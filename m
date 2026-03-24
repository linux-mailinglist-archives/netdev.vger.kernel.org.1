Return-Path: <netdev+bounces-271162-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIw1OyS5wmlilAQAu9opvQ
	(envelope-from <netdev+bounces-271162-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:17:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BEB318D96
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B188311514A
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B9037CD30;
	Tue, 24 Mar 2026 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BkI7d0eD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2819D35A388
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774368613; cv=none; b=dbVRHwWbDanpZ+ICg0+wRjMZth+SSyukKq+RB1EJTs4lqxmax/6H9sI9+kSV8G/SRv20hzInKSl+v33hKt20OjAU2Hbs9osPxK3q2FCqKAJ+qpBzBdWJqz3wIRbSH5WvfTyI31rl59wRiwOu0yuJJYIzMD9PgYlBqEiFpEGwMWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774368613; c=relaxed/simple;
	bh=zeikdYu9v/BVJrzka5ekNp8NioT8dTG5SLu0HnqVJ8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NrpOSx48AG/WAHQBjkLtP5kY2V5yBGwPt0y7oNWMkgpwvtDmfgsdB1sJg+J2zjktoSEdgrESmSgi8C5HyINhuKAFUCeKqgICIEfQSsrsKRre2HSe4ZCihktQFrurkyzITUO+4vCHdKsJ1i+0wBwWEo/Bs0cqySqMY/IXqu0QiDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BkI7d0eD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774368611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RYilQPGgWc0WcL89jBjytDGNZY4H742DKtfN/Tn13+4=;
	b=BkI7d0eD7qtW7ZTpwUeOogKNx/dkvmOoS2pjCq4Tme1H25irNzujxatQ8nl/7DtFzJLvmy
	tfmNcBdEFdS6TQCIdkMDoutlyDKc+Z3YurMC/uTT/hiPc+SFeFMzwyC5xr+y7w337ELu36
	1cPHLAQkbRiS4IS7QFujL6n3fea89Uw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-Bp6EAz3COOiXDF5awm-yow-1; Tue,
 24 Mar 2026 12:10:07 -0400
X-MC-Unique: Bp6EAz3COOiXDF5awm-yow-1
X-Mimecast-MFC-AGG-ID: Bp6EAz3COOiXDF5awm-yow_1774368606
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E507A1955D84;
	Tue, 24 Mar 2026 16:10:05 +0000 (UTC)
Received: from ibakolla-thinkpadt14gen4.tpbc.com (unknown [10.45.224.70])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1D8A730002C3;
	Tue, 24 Mar 2026 16:10:02 +0000 (UTC)
From: Izabela Bakollari <ibakolla@redhat.com>
To: Edward Cree <ecree.xilinx@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] sfc: add transmit timestamping support
Date: Tue, 24 Mar 2026 17:08:21 +0100
Message-ID: <20260324160823.151472-1-ibakolla@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-271162-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ibakolla@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 72BEB318D96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Enable software TX Timestamping. The out of tree driver 
also implements this.

Signed-off-by: Izabela Bakollari <ibakolla@redhat.com>
---
 drivers/net/ethernet/sfc/ethtool.c | 2 ++
 drivers/net/ethernet/sfc/tx.c      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/sfc/ethtool.c b/drivers/net/ethernet/sfc/ethtool.c
index 362388754a29..c0038b942913 100644
--- a/drivers/net/ethernet/sfc/ethtool.c
+++ b/drivers/net/ethernet/sfc/ethtool.c
@@ -231,6 +231,8 @@ static int efx_ethtool_get_ts_info(struct net_device *net_dev,
 {
 	struct efx_nic *efx = efx_netdev_priv(net_dev);
 
+	ts_info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE;
+
 	efx_ptp_get_ts_info(efx, ts_info);
 	return 0;
 }
diff --git a/drivers/net/ethernet/sfc/tx.c b/drivers/net/ethernet/sfc/tx.c
index 4dff19b6ef17..ea0fc1000476 100644
--- a/drivers/net/ethernet/sfc/tx.c
+++ b/drivers/net/ethernet/sfc/tx.c
@@ -371,6 +371,8 @@ netdev_tx_t __efx_enqueue_skb(struct efx_tx_queue *tx_queue, struct sk_buff *skb
 	if (!data_mapped && (efx_tx_map_data(tx_queue, skb, segments)))
 		goto err;
 
+	skb_tx_timestamp(skb);
+
 	efx_tx_maybe_stop_queue(tx_queue);
 
 	tx_queue->xmit_pending = true;
-- 
2.51.0


