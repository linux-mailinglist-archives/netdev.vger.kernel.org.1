Return-Path: <netdev+bounces-158173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B940EA10C90
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 17:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD13E160EE8
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 16:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9175192580;
	Tue, 14 Jan 2025 16:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fum10YRe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E093232459;
	Tue, 14 Jan 2025 16:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736873049; cv=none; b=TNrE8SMpAVg0G8xI7Bjy13TV0ppOdq1iIxVnNrckb/VpB4kS1/inP7WgjlJts0MTumTWAJaq6peodBMcMI6OPX7teyTmolZoSGnYk7WfiGFpWhIq01pyIc5tdbPQ6Z26PQztJOEOYReYwFlajPiiGIW1XgjxjTS7yUwdAoS42Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736873049; c=relaxed/simple;
	bh=tOranElCofvfv6xx8u6Adcd1rUF/PcHEoQUuujhspAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NxOFobD3rH13UeF9VD591hCFEut1y2RewVyugNIhAdWM5ZlezG5qMInLSdAWBei0+tBQD8K+jBxH3rjU7k5gd2JFAzreefFC9L7LZBHFV/R5DBacZAVeGA1AqFwiGH52HVwRxNKTs2d4m5PuaBOMUJdFbjAIJxjxRzc6osYLzpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fum10YRe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D73C4CEDD;
	Tue, 14 Jan 2025 16:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736873049;
	bh=tOranElCofvfv6xx8u6Adcd1rUF/PcHEoQUuujhspAk=;
	h=From:Date:Subject:To:Cc:From;
	b=fum10YRej2tS7JsHzIcJVnD5G6yNoe79r7ougbogWX6kHVKMiENvaL2gs7kUfkJ7R
	 GyQZWL5OiKw3q3nxTYvFMgp/fVkVU8i67507vV+UnHVsMKt8uYkThiH+mC54A/60kM
	 O0jnyJYzcoPjGzMbZ/Sq6tX+UxHDQDENoHBl0X03oOXvNsKq/rpv6hJ2DsaH9PI7sh
	 MoAF71RMo+v4uuExIVwR7+NcB/TpWdu4MxQRcJu5xgU97JXPlMK6HK2pmqPVH3cXFI
	 dhpdinBWZxrx3J133ZKuJwLfTeWbswKs1nJNNAqw+/UYn61471WypUFzt5WIo2dYzi
	 g0IxzWkME194g==
From: Roger Quadros <rogerq@kernel.org>
Date: Tue, 14 Jan 2025 18:44:02 +0200
Subject: [PATCH net] net: ethernet: ti: am65-cpsw: fix freeing IRQ in
 am65_cpsw_nuss_remove_tx_chns()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-am65-cpsw-fix-tx-irq-free-v1-1-b2069e6ed185@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFGUhmcC/x2MwQqDMBAFf0X23IVETJD+SukhxKfuwWg3UgXJv
 xs8DszMRRkqyPRuLlL8JcuaKthXQ3EOaQLLUJla0zpjbcdh8Y7jlg8e5eT9ZNEfjwpw3/kQnQM
 8LNV+U1TleX8oYadvKTc8eo24cAAAAA==
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Grygorii Strashko <grygorii.strashko@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: srk@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1233; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=tOranElCofvfv6xx8u6Adcd1rUF/PcHEoQUuujhspAk=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBnhpRWg59EJPQ0/u3tcmyYnl/8xBSHSSNcNtuRe
 ZK6x2eGznGJAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZ4aUVgAKCRDSWmvTvnYw
 k7aED/485pkk+jO2zKaHsha3S9w7HYjPS3n5KF80HThn2BwVOabP1110k/FWPC58hPcs1TJSmrd
 XhXXrqM7NZ5QA911NTgJ5MjU8OHXlOEW2RWlWt2gq5urGUZxEGzyo+bTAJLxw9Q/BSj9K5QiYKr
 5k4f+JSb228wO5OtuGlH3mtjuN31q37g7dc8olNIhngG32Ef24P7UtNfpTlhvCS/JGABGEPwaaQ
 BuZHgOiM3fSahq62HJhHUFROOLGYmhDw3SU08/4WhRL1vIs9a6H13dr7gAepEppeSo/jPeKqtIB
 q47cSgJXfnlcNaXBkO6DBcktLvlsR+QI6AZ+Tr0TTAy75q2iZ1lrjbpxupsi91hVn36EJjxQsFg
 R05EwN0go5WhZ5wLaZhOeaKgsjTooiIYedlYXCdthIz0ylGdOVG7NixI1ADs5B+/ggZCJG3Mq9c
 IK5mN/XS2n1fVJ7vRUZBn4caqvC2HSNcelNX3lxeWrisbtkwEWfqORvMzAdZgY6gJcfb//RjEib
 X1KgQLiumIvH6+TXPsJESRIUHWfAzPXgOSJlJjmZpaPXRLJufMt3GmMTPf4yBpGSMaNKTTewLmk
 49Aec6ntR47vtnyKbKUnf8MA/qvXNEb2N0owRdtWFh5+EwCoubtb4BHDKKX+n4gMq8dOmzIvp+d
 oX9VUe2bc8mkaqA==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

When getting the IRQ we use k3_udma_glue_rx_get_irq() which returns
negative error value on error. So not NULL check is not sufficient
to deteremine if IRQ is valid. Check that IRQ is greater then zero
to ensure it is valid.

Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth subsystem driver")
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 5465bf872734..e1de45fb18ae 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2248,7 +2248,7 @@ static void am65_cpsw_nuss_remove_tx_chns(struct am65_cpsw_common *common)
 	for (i = 0; i < common->tx_ch_num; i++) {
 		struct am65_cpsw_tx_chn *tx_chn = &common->tx_chns[i];
 
-		if (tx_chn->irq)
+		if (tx_chn->irq > 0)
 			devm_free_irq(dev, tx_chn->irq, tx_chn);
 
 		netif_napi_del(&tx_chn->napi_tx);

---
base-commit: 5bc55a333a2f7316b58edc7573e8e893f7acb532
change-id: 20250114-am65-cpsw-fix-tx-irq-free-846ac55ee6e1

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>


