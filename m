Return-Path: <netdev+bounces-37371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0645C7B5093
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 12:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 17BBC1C20A40
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 10:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C0810956;
	Mon,  2 Oct 2023 10:46:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176A410942
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 10:46:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A441C433C7;
	Mon,  2 Oct 2023 10:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696243578;
	bh=T8ANryCHqVCEwOlplPMK0i5kTP++466aJTekKfZXhVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tT9Thu992GEis1hpo1IKQCVBT9awpZ9z2NhE0oOPxRkuFfVAPdgMPcZLRSYYyyn0l
	 7+xAElt/M2I5+J8Vpm2ZEyCZnMuUN0As1ljlEwfJzodFbWE6uUYDME88/nEetjTKPM
	 QiMeJl1y1gRR5DHQpU4n/UZn/HwHI1vfv90JXGENAuan1ppkrAjRWh+fQcQdbSHz3T
	 cy+srflzTaNCuw1KJHdxVGcRknsHXJragmH1d1YBOcNMcnarc16WfNnmPRVDX6HPdk
	 YdRDRbpi6uS+owvETxnRTXsEaHi8teQP6tXXNiA2Kp1b57O3H63J7wetLFH8bdh41M
	 oWSnxbjgI+9zg==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net 1/2] net: dsa: qca8k: fix regmap bulk read/write methods on big endian systems
Date: Mon,  2 Oct 2023 12:46:11 +0200
Message-ID: <20231002104612.21898-2-kabel@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002104612.21898-1-kabel@kernel.org>
References: <20231002104612.21898-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit c766e077d927 ("net: dsa: qca8k: convert to regmap read/write
API") introduced bulk read/write methods to qca8k's regmap.

The regmap bulk read/write methods get the register address in a buffer
passed as a void pointer parameter (the same buffer contains also the
read/written values). The register address occupies only as many bytes
as it requires at the beginning of this buffer. For example if the
.reg_bits member in regmap_config is 16 (as is the case for this
driver), the register address occupies only the first 2 bytes in this
buffer, so it can be cast to u16.

But the original commit implementing these bulk read/write methods cast
the buffer to u32:
  u32 reg = *(u32 *)reg_buf & U16_MAX;
taking the first 4 bytes. This works on little endian systems where the
first 2 bytes of the buffer correnspond to the low 16-bits, but it
obviously cannot work on big endian systems.

Fix this by casting the beginning of the buffer to u16 as
   u32 reg = *(u16 *)reg_buf;

Fixes: c766e077d927 ("net: dsa: qca8k: convert to regmap read/write API")
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index de1dc22cf683..d2df30640269 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -505,8 +505,8 @@ qca8k_bulk_read(void *ctx, const void *reg_buf, size_t reg_len,
 		void *val_buf, size_t val_len)
 {
 	int i, count = val_len / sizeof(u32), ret;
-	u32 reg = *(u32 *)reg_buf & U16_MAX;
 	struct qca8k_priv *priv = ctx;
+	u32 reg = *(u16 *)reg_buf;
 
 	if (priv->mgmt_master &&
 	    !qca8k_read_eth(priv, reg, val_buf, val_len))
@@ -527,8 +527,8 @@ qca8k_bulk_gather_write(void *ctx, const void *reg_buf, size_t reg_len,
 			const void *val_buf, size_t val_len)
 {
 	int i, count = val_len / sizeof(u32), ret;
-	u32 reg = *(u32 *)reg_buf & U16_MAX;
 	struct qca8k_priv *priv = ctx;
+	u32 reg = *(u16 *)reg_buf;
 	u32 *val = (u32 *)val_buf;
 
 	if (priv->mgmt_master &&
-- 
2.41.0


