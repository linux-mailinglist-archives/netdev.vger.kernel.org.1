Return-Path: <netdev+bounces-251809-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIKKGkSPcGkaYgAAu9opvQ
	(envelope-from <netdev+bounces-251809-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:33:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A3ECA539EF
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A9F7642AC4
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 08:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D49033BBCC;
	Wed, 21 Jan 2026 08:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaBsuj2c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839B82FB630
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 08:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768983968; cv=none; b=UTT7pkC3TTv738KKzvP1rjkGguIPei+BAypRkn3S8h+RMGosyA88ZeJNPAIgxLCJwrjw6tw720CFRVPOlAAn8MQHffG9d38Mv7gFSDsxHHPX0rWMgcXvNrZ78JqqUe1zu1Y45bcv8FMJUIpK0VpkMn6kscsLO+SNOyov7ccmgqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768983968; c=relaxed/simple;
	bh=lWBVA9rGgcQanuo/TDefstMpJZ6NtU9ZljG0ClTIkfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ldbkME3EW/L88PEyqT7XHcg8+hUOSPuB3TPwcXS7kO/FGAd4q9FLxLKzGVtmxhF1fjXUiahGf87+FS1GqEHzCRPyYFKwtr9O8KPmfGgvfqaRIxcsvMVyamLCDJZ1lNmVU49fBNkViTvEXQK1GTByjuVx9YprVVdb6N4SDWA2vIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaBsuj2c; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c2dd0c24e5cso2365437a12.3
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 00:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768983966; x=1769588766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pOfh991Nf5x6cbHEyitGr4ECnygIc5lXslxo+H2b9a0=;
        b=eaBsuj2cp9naXuTNUfmOMDhuI6SRyD0xpw/K/fjN1G3bfYqgFKo4U5k9Dx8825fpdM
         Uc7h/smBcidz6impHBTLrnri9Ls1gklS7LP9wLwYgsTiCFyaFQe0VG27rbob3A9k8RPa
         4t1wQNsM9SVmW4Slew/hHPBtGT7RBSB/jEDlDjE3PMemYcu01tstlGRttv+/VHD+bO9u
         pbqnknzibw+wQlzI/NWZ2qb86oiLVcKstXGV0Gn3IucxB4wipA6xXTBuFSWcLRVrPbHJ
         dsFYwmQlnYz6dfHCDwaW+XPb3rAB08N/eMYzytksLWUuECHnLSMrrFm6ly8gkVCy23Ie
         1z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768983966; x=1769588766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOfh991Nf5x6cbHEyitGr4ECnygIc5lXslxo+H2b9a0=;
        b=E6lI99/WuQjzzZ3okgGKFIaHpvKdgfy+JR6LbwsvITN9E76qOMG9RYG0xqH5uffM3u
         tyxptNXRawfA02ZfnTY1F3LOk6Rb+I/TIvV4XyUR04Fmq2Ha2nPLo1rdKc9QLdLiEVe/
         7gl4cpj57zOKrqSM4ObU7zhhiPvbx0O8EGUYvpNLgPzA2Dev9PsJe/DoH8Sr1z8xSc5C
         qs4j6gWR5slme4KQZAcCGg2V/HZsNMce3T1tHXZivWy9V8UIPR7UUgwVGY1nmUHMeaBn
         20hKDZUxH/9SRM8Qdj3AvLM4tid9uAh2Czyp/0zrUlHXBycXxnDOq9EKa9LSMV+CwzKQ
         NYAg==
X-Gm-Message-State: AOJu0Yzl7B8ByAeRaNuJahpeCeU308lTiXjJSvfxGBvbMhdkGSVfInQZ
	aJUEVrxthVhD3w46CTutID3rEPoHIjPAo3wQGI/lwxJTeAvfx6SaycGeMASD7A==
X-Gm-Gg: AZuq6aJPyyPkZZroV0wLJNau6uWny9UToG5cnh0Y72Q1i/ZsNE5PbmOXFat8u9+4Pi3
	pH6GTQq5Nkc+2B6ynOM3Dp3fb8bRe/toAm2YeKlJqOk61HrBEuGGFXNih9Dju07GM3ZVr6OgClk
	4+TWvr2zX41daKK20wIamVYoVfdDR1b9S+M2FBhSIKb1lt8RDge5DXucJsMWz9zclAGdFMniu9c
	SjvUdInIrCJ81XgrK3zytvTbsqzR1viG1yuCYln/MONOivMYjfvoT91kDn6+0dGGg+cNpy+GDk5
	pPIRpK88tkncQS6DPSts62XJ8Bqzgl5ngWvpm/OxV1nTFxAMvLWvIQY3c8YUlx5O7kCzITBmNuR
	avbKx4QPyZq1CfaRRwCB8TxH4wgVmdfX9Cf68WDmdVz42Op01V34BLqUESBkWPKCUU98AME4CT5
	NwycLm6PR9RM9etf9gniZT9QajFjzJqp1NANAN1Li0oKuGSe73pZ9gOA==
X-Received: by 2002:a17:903:1110:b0:271:479d:3dcb with SMTP id d9443c01a7336-2a717518996mr161853105ad.6.1768983966532;
        Wed, 21 Jan 2026 00:26:06 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190d14cfsm147637005ad.38.2026.01.21.00.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 00:26:05 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] xen/netfront: Use u64_stats_t with u64_stats_sync properly
Date: Wed, 21 Jan 2026 16:25:46 +0800
Message-ID: <20260121082550.2389249-1-mmyangfl@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[gmail.com,suse.com,kernel.org,epam.com,lunn.ch,davemloft.net,google.com,redhat.com,lists.xenproject.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251809-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: A3ECA539EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 64bit arches, struct u64_stats_sync is empty and provides no help
against load/store tearing. Convert to u64_stats_t to ensure atomic
operations.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/xen-netfront.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 7c2220366623..0969d5c9f6b7 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -97,8 +97,8 @@ struct netfront_cb {
 static DECLARE_WAIT_QUEUE_HEAD(module_wq);
 
 struct netfront_stats {
-	u64			packets;
-	u64			bytes;
+	u64_stats_t		packets;
+	u64_stats_t		bytes;
 	struct u64_stats_sync	syncp;
 };
 
@@ -634,8 +634,8 @@ static int xennet_xdp_xmit_one(struct net_device *dev,
 		notify_remote_via_irq(queue->tx_irq);
 
 	u64_stats_update_begin(&tx_stats->syncp);
-	tx_stats->bytes += xdpf->len;
-	tx_stats->packets++;
+	u64_stats_add(&tx_stats->bytes, xdpf->len);
+	u64_stats_inc(&tx_stats->packets);
 	u64_stats_update_end(&tx_stats->syncp);
 
 	return 0;
@@ -843,8 +843,8 @@ static netdev_tx_t xennet_start_xmit(struct sk_buff *skb, struct net_device *dev
 		notify_remote_via_irq(queue->tx_irq);
 
 	u64_stats_update_begin(&tx_stats->syncp);
-	tx_stats->bytes += skb->len;
-	tx_stats->packets++;
+	u64_stats_add(&tx_stats->bytes, skb->len);
+	u64_stats_inc(&tx_stats->packets);
 	u64_stats_update_end(&tx_stats->syncp);
 
 	if (!netfront_tx_slot_available(queue))
@@ -1249,8 +1249,8 @@ static int handle_incoming_queue(struct netfront_queue *queue,
 		}
 
 		u64_stats_update_begin(&rx_stats->syncp);
-		rx_stats->packets++;
-		rx_stats->bytes += skb->len;
+		u64_stats_inc(&rx_stats->packets);
+		u64_stats_add(&rx_stats->bytes, skb->len);
 		u64_stats_update_end(&rx_stats->syncp);
 
 		/* Pass it up. */
@@ -1400,14 +1400,14 @@ static void xennet_get_stats64(struct net_device *dev,
 
 		do {
 			start = u64_stats_fetch_begin(&tx_stats->syncp);
-			tx_packets = tx_stats->packets;
-			tx_bytes = tx_stats->bytes;
+			tx_packets = u64_stats_read(&tx_stats->packets);
+			tx_bytes = u64_stats_read(&tx_stats->bytes);
 		} while (u64_stats_fetch_retry(&tx_stats->syncp, start));
 
 		do {
 			start = u64_stats_fetch_begin(&rx_stats->syncp);
-			rx_packets = rx_stats->packets;
-			rx_bytes = rx_stats->bytes;
+			rx_packets = u64_stats_read(&rx_stats->packets);
+			rx_bytes = u64_stats_read(&rx_stats->bytes);
 		} while (u64_stats_fetch_retry(&rx_stats->syncp, start));
 
 		tot->rx_packets += rx_packets;
-- 
2.51.0


