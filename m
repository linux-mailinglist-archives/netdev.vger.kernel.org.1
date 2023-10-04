Return-Path: <netdev+bounces-37910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9627B7BC0
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 11:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id AE41CB2099A
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 09:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C52510976;
	Wed,  4 Oct 2023 09:19:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2C710A09
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 09:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6A3C433C9;
	Wed,  4 Oct 2023 09:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696411150;
	bh=ARqqx35Yo1WsqWxuoBmHHsUb0Zf+p1XF8jxNeXqyJgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uy0BRJiI3qDuayZh8Jmas81lwvfVU5pbmjOHE5UUQg3gsHgdmrf0WArNXna5UEDpu
	 DHyYIyF/2cP5QdkbU8BWMb+IS5NH6zZtVIK0PdfmOQpW7jrXhvVEEWUqBCPMA2+jKu
	 23yEVsHN8Nsk/oNxAtJpCOi4QJdLycC+/PhM2iR+zR5hc7EGr43LuGR/ECrAU5NtwO
	 At2IweyUbxMjd1Ge3BSI4PZm+Jew04YEsynpFmdjd0k3n8GsAk9L2dyAq2Be4n5KHy
	 r45eX67uKE3Gl0q/k1mJr/ebm3ZgzS9U+q7kB/m7A0qEP8KE2OPOfMqTWHAPNcgVkM
	 NScOFOjvCRhRQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH net v2 1/2] net: dsa: qca8k: fix regmap bulk read/write methods on big endian systems
Date: Wed,  4 Oct 2023 11:19:03 +0200
Message-ID: <20231004091904.16586-2-kabel@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004091904.16586-1-kabel@kernel.org>
References: <20231004091904.16586-1-kabel@kernel.org>
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
first 2 bytes of the buffer correspond to the low 16-bits, but it
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


