Return-Path: <netdev+bounces-128837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF62897BE0D
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 16:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DB0E1C20AFC
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 14:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B143B1BA88C;
	Wed, 18 Sep 2024 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A47BSIp8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1D21BA867
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726670281; cv=none; b=s+wcJOOuisbQiIEupqRK3o/nS/d4tBzsHOSM3agd1OLUKPEByKqnevtc4b/RTGUAw2ho7MSxNeeH5ZxSqzr8EPmpL8yV0JpQGAFWvwcZrVMTh28InMTpantlKjTjkwA1x+lOHhfVGtipkrwVKMjErlMCb/otuq/MxU/lOeyYIN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726670281; c=relaxed/simple;
	bh=xXLfPYls2cCeIdrdeFZxy8Q4TAacIKqRg0i33Imm1gY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JVf3wJGuCNO1UjgMIXEO9K79SgHumPieZeSq7v1syKPdwRCaMtHUtBim91hrqwDvdDFazQIo9Au4Qvg9LZ+RfedOY+84/CMnLwI2qlZyn6pYpiHIeON7kAWupULf4QN+z+tyDQjpcNBA1PtT+QRh/Hh3AmGdznZ1m+gklX7Ae5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A47BSIp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BDBC4CEC2;
	Wed, 18 Sep 2024 14:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726670281;
	bh=xXLfPYls2cCeIdrdeFZxy8Q4TAacIKqRg0i33Imm1gY=;
	h=From:Date:Subject:To:Cc:From;
	b=A47BSIp8YO5Ahf70mXgJElnNxFupJ8zkLIxXLjeSv6KWkimEDgBNORFHe+P/dTiQS
	 /KWOVTezUPZyeG/15lF/CGlLkwk09hIKEyhlFtbgdmydfGaD/sXpdboYCTETMtTEdg
	 l13OwaUSFCJznk/PUY4pSLC7K6pR3DWc4ab9X5Uudq64OROlFBcWLmnNNXghgSnabg
	 ptH7EMhYrOxZVSMVPhfsw7Wb/G5dDewwkgc3fNsRIvrOqkYTDnhVIDv/9MUJZ2tQ1C
	 Zu7q9XS1IABEoCwemUC8+Q1Z3CjlsV1BYfNdfS95GjbK5zqfQwE78j8LVThgts3cDA
	 cHrPgdkEd7KDQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 18 Sep 2024 16:37:30 +0200
Subject: [PATCH net] net: airoha: fix PSE memory configuration in
 airoha_fe_pse_ports_init()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240918-airoha-eth-pse-fix-v1-1-7b61f26cd2fd@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKnl6mYC/x2MQQqAIBAAvxJ7bkFDpPpKdBDdci8lbkQQ/r2l4
 wzMvCBUmQTm7oVKNwufh4LtO4g5HDshJ2UYzODMZEcMXM8ckK6MRQg3ftA7m0zc/OijAQ1LJdX
 /dFlb+wArfm5TZAAAAA==
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Mark Lee <Mark-MC.Lee@mediatek.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 upstream@airoha.com, Sayantan Nandy <sayantan.nandy@airoha.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.1

Align PSE memory configuration to vendor SDK. In particular, increase
initial value of PSE reserved memory in airoha_fe_pse_ports_init()
routine by the value used for the second Packet Processor Engine (PPE2)
and do not overwrite the default value.
Moreover, store the initial value for PSE reserved memory in orig_val
before running airoha_fe_set_pse_queue_rsv_pages() in
airoha_fe_set_pse_oq_rsv routine.

Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Tested-by: Sayantan Nandy <sayantan.nandy@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index 930f180688e5..2e01abc70c17 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -1116,17 +1116,23 @@ static void airoha_fe_set_pse_queue_rsv_pages(struct airoha_eth *eth,
 		      PSE_CFG_WR_EN_MASK | PSE_CFG_OQRSV_SEL_MASK);
 }
 
+static u32 airoha_fe_get_pse_all_rsv(struct airoha_eth *eth)
+{
+	u32 val = airoha_fe_rr(eth, REG_FE_PSE_BUF_SET);
+
+	return FIELD_GET(PSE_ALLRSV_MASK, val);
+}
+
 static int airoha_fe_set_pse_oq_rsv(struct airoha_eth *eth,
 				    u32 port, u32 queue, u32 val)
 {
-	u32 orig_val, tmp, all_rsv, fq_limit;
+	u32 orig_val = airoha_fe_get_pse_queue_rsv_pages(eth, port, queue);
+	u32 tmp, all_rsv, fq_limit;
 
 	airoha_fe_set_pse_queue_rsv_pages(eth, port, queue, val);
 
 	/* modify all rsv */
-	orig_val = airoha_fe_get_pse_queue_rsv_pages(eth, port, queue);
-	tmp = airoha_fe_rr(eth, REG_FE_PSE_BUF_SET);
-	all_rsv = FIELD_GET(PSE_ALLRSV_MASK, tmp);
+	all_rsv = airoha_fe_get_pse_all_rsv(eth);
 	all_rsv += (val - orig_val);
 	airoha_fe_rmw(eth, REG_FE_PSE_BUF_SET, PSE_ALLRSV_MASK,
 		      FIELD_PREP(PSE_ALLRSV_MASK, all_rsv));
@@ -1166,11 +1172,13 @@ static void airoha_fe_pse_ports_init(struct airoha_eth *eth)
 		[FE_PSE_PORT_GDM4] = 2,
 		[FE_PSE_PORT_CDM5] = 2,
 	};
+	u32 all_rsv;
 	int q;
 
+	all_rsv = airoha_fe_get_pse_all_rsv(eth);
 	/* hw misses PPE2 oq rsv */
-	airoha_fe_set(eth, REG_FE_PSE_BUF_SET,
-		      PSE_RSV_PAGES * pse_port_num_queues[FE_PSE_PORT_PPE2]);
+	all_rsv += PSE_RSV_PAGES * pse_port_num_queues[FE_PSE_PORT_PPE2];
+	airoha_fe_set(eth, REG_FE_PSE_BUF_SET, all_rsv);
 
 	/* CMD1 */
 	for (q = 0; q < pse_port_num_queues[FE_PSE_PORT_CDM1]; q++)

---
base-commit: 9410645520e9b820069761f3450ef6661418e279
change-id: 20240918-airoha-eth-pse-fix-641d0cf686c0

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


