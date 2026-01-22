Return-Path: <netdev+bounces-252118-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEVpLut0cWm3HAAAu9opvQ
	(envelope-from <netdev+bounces-252118-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:52:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DF16018A
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 01:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B693B5E642E
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 00:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FEE3115BD;
	Thu, 22 Jan 2026 00:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCn5LJFv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CE2311592
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 00:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769043093; cv=none; b=nmA+nH3bFhVibHZQ/Pq7QbH9MmqixyJ4Yir8n+IjRhcp2A1H7bqKpLORWkYgMzxlpVbDRiZq4KWkfx3n3iRGHMvCQ3tXVrtr3eP2d7tkisuWaB28sRDAT90a2c4plgNYj+i4GwadI4HrDVJ2OcvSaSqTae1nBt2u9ImlRUO9nOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769043093; c=relaxed/simple;
	bh=ReDhAJCdPwGrXsyM0mq8tQmhNwxFBOhBnblfuSRuvBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWbimJgJ2FEW/6N0qqG37VUalTBw5jDvY0g3UGMGHzXukTgV8OEAwLsIoI9LldIT2KVPQHSCDduNQitKO7i6UR5PkysX993UuAfhaqM2CpblJdTSQy2249HI9kGES7p6j53C65yJVb3VBWwOisql/pef7RUVTAprYjBiK1iTfZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCn5LJFv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920DEC2BC86;
	Thu, 22 Jan 2026 00:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769043093;
	bh=ReDhAJCdPwGrXsyM0mq8tQmhNwxFBOhBnblfuSRuvBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vCn5LJFvB3mnbXV77MlnFZn4r/KzSiDLZQRh3jVU2m6d1jLEhevhCNLxrj4hxTHmO
	 O0w2RCv8VvwNNyW+7StyKBJnHNEcLJgCunmk39vOOoLqKjagkLncWeV+YG0fpCgzVH
	 fo8JOiqOpg3NCMY9Yhz1esnCf0q05ILCB7SI2yP/0TZvkGfMJmzuAVrQhFFY0s765b
	 vcNcIzM2TiqaM29DfBzrKkMXIBeRspQcIIRUmAqu9g2lefT1VQsjKFTWcg1YLjbecH
	 Jm84fy7xvSKmMfTCgNaaujJ87xEBSRD++z0t2oCHpWr39KnxpBXt2x4c2FQduvimGE
	 ww3kq4N/JbFxA==
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
Subject: [PATCH net-next 3/6] net: move mp->rx_page_size validation to __net_mp_open_rxq()
Date: Wed, 21 Jan 2026 16:51:10 -0800
Message-ID: <20260122005113.2476634-4-kuba@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-252118-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 27DF16018A
X-Rspamd-Action: no action

Move mp->rx_page_size validation where the rest of MP input
validation lives. No other caller is modifying mp params so
validation logic in queue restarts is out of place.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/netdev_rx_queue.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index b81cad90ba2f..03d7531abb3a 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -39,11 +39,8 @@ int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq_idx)
 	if (qops->ndo_default_qcfg)
 		qops->ndo_default_qcfg(dev, &qcfg);
 
-	if (rxq->mp_params.rx_page_size) {
-		if (!(qops->supported_params & QCFG_RX_PAGE_SIZE))
-			return -EOPNOTSUPP;
+	if (rxq->mp_params.rx_page_size)
 		qcfg.rx_page_size = rxq->mp_params.rx_page_size;
-	}
 
 	new_mem = kvzalloc(qops->ndo_queue_mem_size, GFP_KERNEL);
 	if (!new_mem)
@@ -115,6 +112,7 @@ int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 		      const struct pp_memory_provider_params *p,
 		      struct netlink_ext_ack *extack)
 {
+	const struct netdev_queue_mgmt_ops *qops = dev->queue_mgmt_ops;
 	struct netdev_rx_queue *rxq;
 	int ret;
 
@@ -139,6 +137,10 @@ int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 		NL_SET_ERR_MSG(extack, "unable to custom memory provider to device with XDP program attached");
 		return -EEXIST;
 	}
+	if (p->rx_page_size && !(qops->supported_params & QCFG_RX_PAGE_SIZE)) {
+		NL_SET_ERR_MSG(extack, "device does not support: rx_page_size");
+		return -EOPNOTSUPP;
+	}
 
 	rxq = __netif_get_rx_queue(dev, rxq_idx);
 	if (rxq->mp_params.mp_ops) {
-- 
2.52.0


