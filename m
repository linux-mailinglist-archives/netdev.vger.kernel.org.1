Return-Path: <netdev+bounces-132245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A19E9911D7
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA3B1C21D62
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 21:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5021482ED;
	Fri,  4 Oct 2024 21:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIvf4cZ1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D924437F
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 21:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728078740; cv=none; b=PvE6GGUiBF/P9inVDAJd/kwr0oolFWdy4KSKVc/eFHnq0dElEYPqrsuxr2nGgHGDidHIoZjd4GSy6TKLKjHC6sTLbJClwe2PmMkk+6C9zxb2VO4o7GLFLJlBYAWz7UfLTujnbral09VxZyxR1A53jcuXF8Q18KuorKA2UsIfHQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728078740; c=relaxed/simple;
	bh=uzpROxSyXHDis+ZcxSk361Wk81pS4vKtRyGOarVkMbE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MT1DjtuvDuXaOvShETJKVfoeqHhiyx6J5arZLpqfcuw9S4H4NjdzBorYgIWRgy071wiqr6BMIo+lL5JvcG8JrMiD/leZM/SN3begg7IRfRBUgMWAihqMn21AX2Harcw7CoqwJHcnu5yLInGhqoyzFdyMvKeBmmF3Bpmn7JU0KgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIvf4cZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D5BC4CEC6;
	Fri,  4 Oct 2024 21:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728078740;
	bh=uzpROxSyXHDis+ZcxSk361Wk81pS4vKtRyGOarVkMbE=;
	h=From:Date:Subject:To:Cc:From;
	b=hIvf4cZ1Io6xOWef9K8YqkmXQmvIcULpwkj+mH2ZFjnRCGPzU1B8UvOHd2Ua6+x0q
	 cwuoxaEpBt4HA3LZ0nKeNko28MShqjt5xYnwRAJHmMTGLRYgGKUKs1u2J2CKpz49Hj
	 Xx/ExKA3fvFnbzQH/WIHzP190+OjoxzKAuVKEHA7scdKfmBSE39UF8S+kD9XqlSBUf
	 zNVb0Ru8UhziqsQHxBqkJvZgizFCm5d8MoxgUcvWoqIrEQ8xAX/9Nf16VGFimd18sT
	 0wVlegWoPkTCPV3hnKVlSc3ZU55ClqVkSB7I9iD5x1Wn5DEVB6hbnT4sGjZer2pLrk
	 6tikCBrxH9qFA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 04 Oct 2024 23:51:36 +0200
Subject: [PATCH net-next] net: airoha: Fix EGRESS_RATE_METER_EN_MASK
 definition
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-airoha-fixes-v1-1-2b7a01efc727@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGdjAGcC/x3LQQqAIBBA0avIrBPUBKWrRIupppyNhkIE4d0bW
 j4+/4VGlanBpF6odHPjkgV2ULAlzCdp3sXgjPPWGK+Ra0moD36o6YiI0YawutGDLFelP8gxL71
 /y979ql4AAAA=
X-Change-ID: 20241004-airoha-fixes-8aaa8177b234
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Mark Lee <Mark-MC.Lee@mediatek.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Fix typo in EGRESS_RATE_METER_EN_MASK mask definition. This bus was not
introducing any user visible problem.

Introduced by commit 23020f049327 ("net: airoha: Introduce ethernet support
for EN7581 SoC")

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 2e01abc70c170f32f4206b34e116b441c14c628e..a1cfdc146a41610a3a6b060bfdc6e1d9aad97d5d 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -554,7 +554,7 @@
 #define FWD_DSCP_LOW_THR_MASK		GENMASK(17, 0)
 
 #define REG_EGRESS_RATE_METER_CFG		0x100c
-#define EGRESS_RATE_METER_EN_MASK		BIT(29)
+#define EGRESS_RATE_METER_EN_MASK		BIT(31)
 #define EGRESS_RATE_METER_EQ_RATE_EN_MASK	BIT(17)
 #define EGRESS_RATE_METER_WINDOW_SZ_MASK	GENMASK(16, 12)
 #define EGRESS_RATE_METER_TIMESLICE_MASK	GENMASK(10, 0)

---
base-commit: c55ff46aeebed1704a9a6861777b799f15ce594d
change-id: 20241004-airoha-fixes-8aaa8177b234

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


