Return-Path: <netdev+bounces-252116-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOjPGrV0cWm3HAAAu9opvQ
	(envelope-from <netdev+bounces-252116-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:52:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 180C560168
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F38A95E4053
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 00:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE6E30FF20;
	Thu, 22 Jan 2026 00:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1AHe8v0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAE730FC31
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 00:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769043092; cv=none; b=JO/QufIDr+CxvnAoQP2YSa3eUbhpl8/JLObI8+2dh0sSPwlYms53VWMTFBXYFsk1yixJLr5lfxYL5rhkteE26x+S3aJiuFD6/uABP46MaPUBESwPmvNAa/UsdVIiM063Zn1z2j/Dgru21wEde8Z5eqaEnIj8LVQLe/f8a0QstGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769043092; c=relaxed/simple;
	bh=eEDHiu3G8QbRA4TDIDw3ynHovjfWsrgribiT3x6Mu7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RN1crmZHLehgjWdWz+v6QVQIQWNm5bCH4DPdkZHs5Bvo3BH36OjPpA3OCIrk5Kcl8zCrPKC2AZn244cIL6IZEmB/EmCWoiQo83C1ATyUHh9O7hcjQZN+MuaTMWOdZ17C9K0PpINv2itf2ZWwzik9UT0x+gu/vf0e3JQNqclmiWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1AHe8v0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0365CC4AF09;
	Thu, 22 Jan 2026 00:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769043091;
	bh=eEDHiu3G8QbRA4TDIDw3ynHovjfWsrgribiT3x6Mu7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p1AHe8v0Npue4AekI6LI1JV8egCEdLZEQfQrRYnk+0Q32Hev3lNp+do//joItOQpP
	 w8QgQnAbXTfRjtxlLennQmnouKePU6grKMd41JAOiP5vDeBfUtOfkb0ASS+kkDiLDO
	 S66XqayOec6mX79ycEeXL2W4ySzXG04oiLkD3xP9AfRxmWXx2u7kba5U9VCJ3BQ8tt
	 /QMe/bk0nmKw65q4jnI6D1heLgpggt4ILnW8BdQcX5HH6/YNFhvqhRVtACotMsJj4f
	 V/iLGjh3X21wLMjpFhRE/wYe1piKSZ/3EXiyM+Qg5zmJ3QUAgvZgYEzQsGV1sP0aL8
	 E7yNax08s4J9Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	sdf@fomichev.me,
	almasrymina@google.com,
	dtatulea@nvidia.com,
	asml.silence@gmail.com,
	dw@davidwei.uk,
	daniel@iogearbox.net,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/6] eth: bnxt: always set the queue mgmt ops
Date: Wed, 21 Jan 2026 16:51:08 -0800
Message-ID: <20260122005113.2476634-2-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122005113.2476634-1-kuba@kernel.org>
References: <20260122005113.2476634-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,fomichev.me,nvidia.com,gmail.com,davidwei.uk,iogearbox.net];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-252116-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 180C560168
X-Rspamd-Action: no action

Core provides a centralized callback for validating per-queue settings
but the callback is part of the queue management ops. Having the ops
conditionally set complicates the parts of the driver which could
otherwise lean on the core to feed it the correct settings.

Always set the queue ops, but provide no restart-related callbacks if
queue ops are not supported by the device. This should maintain current
behavior, the check in netdev_rx_queue_restart() looks both at op struct
and individual ops.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
--
v1:
 - reflow code
 - typo fix
rfc: https://lore.kernel.org/20250421222827.283737-15-kuba@kernel.org
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 0e0c88c122f8..0b95100a7c36 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16314,6 +16314,9 @@ static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops = {
 	.supported_params	= QCFG_RX_PAGE_SIZE,
 };
 
+static const struct netdev_queue_mgmt_ops bnxt_queue_mgmt_ops_unsupp = {
+};
+
 static void bnxt_remove_one(struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
@@ -16966,9 +16969,10 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	if (BNXT_SUPPORTS_NTUPLE_VNIC(bp))
 		bp->rss_cap |= BNXT_RSS_CAP_MULTI_RSS_CTX;
+
+	dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops_unsupp;
 	if (BNXT_SUPPORTS_QUEUE_API(bp))
 		dev->queue_mgmt_ops = &bnxt_queue_mgmt_ops;
-	dev->request_ops_lock = true;
 	dev->netmem_tx = true;
 
 	rc = register_netdev(dev);
-- 
2.52.0


