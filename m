Return-Path: <netdev+bounces-284791-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uM9QCfUi+2lvWwMAu9opvQ
	(envelope-from <netdev+bounces-284791-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 13:16:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F5C4D9A75
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 13:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC4C83014572
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 11:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F0A31716F;
	Wed,  6 May 2026 11:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="DYhWXfGE";
	dkim=pass (2048-bit key) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b="ck1vH9MK"
X-Original-To: netdev@vger.kernel.org
Received: from out-ip0052.fra.mailhop.org (out-ip0052.fra.mailhop.org [18.158.144.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6029F246778
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 11:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.158.144.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778066150; cv=none; b=mD0x5lqr6/KOPuRFomCYksVTVHa/ajlL1748BI7yhJwZ/AX1ugkJFGHgs2u7hHkg1dLm1eTWktGcv2hrQlpLho/mpo+6nhYWeVUUSCeFgY1+nWsAubYSTaXov0s1KH1va1lbutX/V44rK5SMzZhmTMv4GB2BxevE7LEILYVuIys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778066150; c=relaxed/simple;
	bh=8Lmvqbu4qQ4lUb+7e2rO7fhHnvQ/F6uZ+YoU+WtzL4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s1wyB1eVNe424DHwAhHmaU+2LsDxcnAj2P1om71oEl/NroJj+eUSq42asxkSolJlhPe+1NQ+FQ/KcOEyiuI7yCDKMhkwPm5kQ/mWX8xEEFrE7DW+pY1SzSjXqtSnvbAPOBBU35lTdyRgycBk+7pX5s42YWMCh4HYS/dDe7Gv5SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com; spf=pass smtp.mailfrom=hitachienergy.com; dkim=pass (1024-bit key) header.d=hitachienergy.com header.i=@hitachienergy.com header.b=DYhWXfGE; dkim=pass (2048-bit key) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b=ck1vH9MK; arc=none smtp.client-ip=18.158.144.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hitachienergy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=hitachienergy.com; s=duo-1630306886989-947ac67a;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 cfbl-address:cfbl-feedback-id:from;
	bh=mzUCgE4R9ZBXTM/Zus2HFTCm9+5cChUmtqF1FgPd4FU=;
	b=DYhWXfGEoctLK+Qi9qqFGgDuAz7DMuhfwSA4j4SXWTgoZ309AexLFoEGF3fB1+JEQoAwjVVTgOJjL
	 ujTZm6er/0UWhIk/zpuSiOIvl/bR8bEez4EuGez5HRAw26AG4Q9WffczdFx4q3j5pwvnCfFAI/9YpH
	 aWdfPrazCt0xlhqM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=outbound.mailhop.org; s=dkim-high;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 cfbl-address:cfbl-feedback-id:from;
	bh=mzUCgE4R9ZBXTM/Zus2HFTCm9+5cChUmtqF1FgPd4FU=;
	b=ck1vH9MKZbrduQMh8rGhDVni8Z8iq3K0Q+TD1wdsaJeDEE/bN7lDDJtPkw+JPr1XUF5ZkL+96Xu1u
	 lAEhUS0OGtWwN4wpvOJVMKJ2KToCiFU0t9m20ma+H4yKzVrrj21zvY7mBULD+pSBMl4KSUgUsT81qd
	 NXmJ9fHPprhIZ8r3Yzf86S3fBqxWkdAcjf2kVcmdRyZrX3lMKC3FA5uxFcauoaH9Z+aUZ8dbRSnvVO
	 ImifNNufxWiW9ozF032+m9jbwd+wfOg4sexPNBUICEzIJSo+E2ZfNtYYDwThNMiEjaeNmeEK+X4m/h
	 /gmooY3Lv8FDjP5btuBPwpBY3MjZf6g==
X-MHO-RoutePath: aGVkY3NtdHA=
X-MHO-User: e4f9875c-493c-11f1-8f51-f54febe22707
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: e4f9875c-493c-11f1-8f51-f54febe22707:15
CFBL-Address: prvs=058643e936=abuse@outbound.mailhop.org; report=arf
Received: from HPG0000000426.corp.hitachi-powergrids.com (unknown [20.82.50.241])
	by outbound3.eu.mailhop.org (Halon) with ESMTPSA
	id e4f9875c-493c-11f1-8f51-f54febe22707;
	Wed, 06 May 2026 11:15:32 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
	by HPG0000000426.corp.hitachi-powergrids.com (Postfix) with ESMTP id 47A9F80525F;
	Wed,  6 May 2026 11:15:31 +0000 (UTC)
Received: from chbrn3-p-dev015.keymile.net (chbrn3-p-dev015.keymile.net [172.31.41.201])
	by gitsiv.hitachienergy.com (Postfix) with ESMTP id 19A6B60B7D47;
	Wed,  6 May 2026 13:15:31 +0200 (CEST)
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	andrew+netdev@lunn.ch,
	chleroy@kernel.org,
	qiang.zhao@nxp.com,
	horms@kernel.org,
	kuba@kernel.org,
	Holger Brunck <holger.brunck@hitachienergy.com>
Subject: [PATCH v2 net] net: wan: fsl_ucc_hdlc: free tx_skbuff in uhdlc_memclean
Date: Wed,  6 May 2026 13:15:29 +0200
Message-ID: <20260506111529.2919079-1-holger.brunck@hitachienergy.com>
X-Mailer: git-send-email 2.52.0.120.gb31ab939fe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 77F5C4D9A75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hitachienergy.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[hitachienergy.com:s=duo-1630306886989-947ac67a,outbound.mailhop.org:s=dkim-high];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[holger.brunck@hitachienergy.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284791-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[hitachienergy.com:+,outbound.mailhop.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]

When the device is removed all allocated resources should be freed.
In uhdlc_memclean the netdev transmit queue was already stopped. But at
this point we may have pending skb in the transmit queue which must be
freed. Therefore iterate over the tx_skbuff pointers and free all
pending skb. The issue was discovered by sashiko.

https://sashiko.dev/#/patchset/20260429114208.941011-1-holger.brunck%40hitachienergy.com
Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
---
v2: - use dev_kfree_skb instead of kfree
    - improve commit message
    - add missing paramter in for statement
v1: https://lore.kernel.org/linuxppc-dev/20260504161145.2217950-1-holger.brunck@hitachienergy.com/

 drivers/net/wan/fsl_ucc_hdlc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index bc7c2e9e6554..417e8e4c111f 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -739,6 +739,8 @@ static int uhdlc_open(struct net_device *dev)
 
 static void uhdlc_memclean(struct ucc_hdlc_private *priv)
 {
+	int i;
+
 	qe_muram_free(ioread16be(&priv->ucc_pram->riptr));
 	qe_muram_free(ioread16be(&priv->ucc_pram->tiptr));
 
@@ -769,6 +771,11 @@ static void uhdlc_memclean(struct ucc_hdlc_private *priv)
 	kfree(priv->rx_skbuff);
 	priv->rx_skbuff = NULL;
 
+	for (i = 0; i < TX_BD_RING_LEN; i++) {
+		dev_kfree_skb(priv->tx_skbuff[i]);
+		priv->tx_skbuff[i] = NULL;
+	}
+
 	kfree(priv->tx_skbuff);
 	priv->tx_skbuff = NULL;
 
-- 
2.52.0.120.gb31ab939fe


