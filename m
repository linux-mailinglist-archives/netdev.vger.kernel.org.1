Return-Path: <netdev+bounces-251807-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEU9Gh6PcGkaYgAAu9opvQ
	(envelope-from <netdev+bounces-251807-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:32:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D196E539B4
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EF297E100C
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 08:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68E647A0BD;
	Wed, 21 Jan 2026 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaThl1eo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C6047A0AA
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 08:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768983871; cv=none; b=H+r7Yp7q8L6rmM6B/XN8Rhwq9mfgmi8b+4Lnll/amLPNMf26RV5a4cEPjVQWUxpAc4sJQRI3aS1C/Igt0u2LgT9zdypU6Ee2AdekEQZS99+QCVZOS6cN+woHuBqRuijBPYZdxV2FOxQ+LiGM6y5An6cHxsHetZ23Fi+pt4jmOfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768983871; c=relaxed/simple;
	bh=sSFv0IdAf9sQinLXNohXO+H7ajTSZl9Iu+sA6q9NtgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FPQ1kYhw44lrhjpXa5gLBVBmzuhs5u2SD5gQhz25V3YiDL5LUT3O0jwmww7Vdn9/P+gsA2K0c66kHWBlXnRmzNioqcfhMf7332c6IlsEHgwttW/I07pHwT5b+8AunvnmoYIDO55QnCOrnU8BUt2x3Aqm0kIGSLiyv+Puab1D2lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jaThl1eo; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-352f60d6c2fso469722a91.1
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 00:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768983867; x=1769588667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kpk5WVvh/foJx73m2kZTvwGkZZ/a/ld0lKy/L+I+Z1w=;
        b=jaThl1eoY7BtYXQ7/97xutwdB9+A6bwF4q/dhJehBUOA22Yc96zAsrX3oSZQPNWw43
         qN/6goMTuWKHJP78kGugMwLh4Mo1Pn2fQ2WZMAiTkmRCsnoZwz4WS4+cRnLZ1ex50gO5
         VqxjPhQgzuz1l0LvsNuaGnS+DV42bs195adWzT2h+wKN3xpy7yiIrrYbZUNJLxtkl5RT
         sZKBkT5xaCUqNm/N7OTxJmzk4ujpsD31fmRkxRkWwrUSFp/kmAyHYiSo+pfdhCwYE4Hp
         Zef9J9GyQ8+ciAGVuBCuk3ppHHNqBd4zxpwxvNapNV3fJjCAe14kI+0pUjUNnyFd+qTt
         y9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768983867; x=1769588667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpk5WVvh/foJx73m2kZTvwGkZZ/a/ld0lKy/L+I+Z1w=;
        b=Tgsl/Wc/XU/cJjJjPrgmNeBOubNP3oF9Zu8t+IMn18R82/6wqORsT9P96CDowcBvPy
         2V65gQXdUd0a+wZ3N1td7vp+cSWlefJ24tkyA9mB1oJdGSxEtAXJTS4osbJPrrNWBh0V
         pn33Zp9twW8NAiEdIs3MiHfrSN3QhylfS4gORv8+/n3OPe8Ion7/YpGOIevByfNZPYoW
         0xoB1CkgfMW6E9NZrN4j73fk5/r/pJi/JTvjOzV7KZKCOsNAABJjv/CDYyzw2tc3CIoo
         1kJKeoQ0w6Ykm6Tc1F/l8NGO/lCQXFkmri6RQx0IGMhfYtmm9mRxyY8Pd9p7N35HGPrI
         8NIw==
X-Gm-Message-State: AOJu0YzYRTDGSSgyV3mIjKRPzhQEQmLmdptJoUzIH8tRcVbH1yctPr8X
	7PdeH62/05s/fz50VneW9KNyfaig7UYhJsiLAFWIEhOVcaknz+E7f2R3uFBlEg==
X-Gm-Gg: AZuq6aKXK2a4L/OFrxtuqWOwaeAIkbstWb3VmFBt3D6Ij6agz8Aca7MpP5Qq1EpCByv
	AeRFviVDwU5CNOsQoCk1aFWVILjPNnIincX3syZDVcpW4qhO5RJWF18xiU4Fqxg2xRlpkLAEHZ4
	jJegZBlr3D7etB6mvYdQrW+4KWansDza7Lv59+jaX8Sb8BjpXR8FIvbaox6OTbPvnnmUm6NWLLR
	PmUF5jlSJk8svm69GVFte/f0z/U36YzerhMVf2s8AEx4ri6C7ptJLLww5CMa4AxXVGWbe3tKk2H
	3jqoE2wMtYPrB/X8ALFw7lQm8hxFJha+pRECd/fNVjdP21iRUi8Pp0cUuATO+hJoPhfKr/DO6gz
	/2hk7oa7rK8aiN6fj+0IrSMUepolQKouRLYy80Z64Ma3ujeWP9yeF56MszC511YnTZD8FQYJaNA
	UhlmJqW02JHLJnuLI4hI2J/TRINOkngIbif8woWCB1T3zAKMYOmRmE3g==
X-Received: by 2002:a17:90b:37d0:b0:33b:8ac4:1ac4 with SMTP id 98e67ed59e1d1-3527329c896mr15564081a91.35.1768983866637;
        Wed, 21 Jan 2026 00:24:26 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352c150faa1sm4265728a91.7.2026.01.21.00.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 00:24:26 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: ifb: use u64_stats_t with u64_stats_sync properly
Date: Wed, 21 Jan 2026 16:23:44 +0800
Message-ID: <20260121082348.2388314-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251807-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: D196E539B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 64bit arches, struct u64_stats_sync is empty and provides no help
against load/store tearing. Convert to u64_stats_t to ensure atomic
operations.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/ifb.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ifb.c b/drivers/net/ifb.c
index d3dc0914450a..6da801748189 100644
--- a/drivers/net/ifb.c
+++ b/drivers/net/ifb.c
@@ -39,8 +39,8 @@
 #define TX_Q_LIMIT    32
 
 struct ifb_q_stats {
-	u64 packets;
-	u64 bytes;
+	u64_stats_t packets;
+	u64_stats_t bytes;
 	struct u64_stats_sync	sync;
 };
 
@@ -81,8 +81,8 @@ static int ifb_close(struct net_device *dev);
 static void ifb_update_q_stats(struct ifb_q_stats *stats, int len)
 {
 	u64_stats_update_begin(&stats->sync);
-	stats->packets++;
-	stats->bytes += len;
+	u64_stats_inc(&stats->packets);
+	u64_stats_add(&stats->bytes, len);
 	u64_stats_update_end(&stats->sync);
 }
 
@@ -163,16 +163,16 @@ static void ifb_stats64(struct net_device *dev,
 	for (i = 0; i < dev->num_tx_queues; i++,txp++) {
 		do {
 			start = u64_stats_fetch_begin(&txp->rx_stats.sync);
-			packets = txp->rx_stats.packets;
-			bytes = txp->rx_stats.bytes;
+			packets = u64_stats_read(&txp->rx_stats.packets);
+			bytes = u64_stats_read(&txp->rx_stats.bytes);
 		} while (u64_stats_fetch_retry(&txp->rx_stats.sync, start));
 		stats->rx_packets += packets;
 		stats->rx_bytes += bytes;
 
 		do {
 			start = u64_stats_fetch_begin(&txp->tx_stats.sync);
-			packets = txp->tx_stats.packets;
-			bytes = txp->tx_stats.bytes;
+			packets = u64_stats_read(&txp->tx_stats.packets);
+			bytes = u64_stats_read(&txp->tx_stats.bytes);
 		} while (u64_stats_fetch_retry(&txp->tx_stats.sync, start));
 		stats->tx_packets += packets;
 		stats->tx_bytes += bytes;
@@ -248,7 +248,7 @@ static void ifb_fill_stats_data(u64 **data,
 		start = u64_stats_fetch_begin(&q_stats->sync);
 		for (j = 0; j < IFB_Q_STATS_LEN; j++) {
 			offset = ifb_q_stats_desc[j].offset;
-			(*data)[j] = *(u64 *)(stats_base + offset);
+			(*data)[j] = u64_stats_read((u64_stats_t *)(stats_base + offset));
 		}
 	} while (u64_stats_fetch_retry(&q_stats->sync, start));
 
-- 
2.51.0


