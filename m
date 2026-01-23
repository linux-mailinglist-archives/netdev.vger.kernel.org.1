Return-Path: <netdev+bounces-252889-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDYuFPmpc2nOxwAAu9opvQ
	(envelope-from <netdev+bounces-252889-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:03:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C2E78C20
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA02930398AC
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3079C28B7DB;
	Fri, 23 Jan 2026 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eubQEOwP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5DD285CBA
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769187806; cv=none; b=iSfA6q5I2zhQf3BWmKHvYEd16jN0a7YaV1BhaXfdaacyWz2k5SUOZqBvORZ3fPp6XGX8djGCpEgR+k7+xmozL0Ad6vYzd2XWA5P2i8XElzl787yY76r7AQG9OKkyXh/ybicPqaedFG/0njon17QNCt5zxIhnRZyS6wjENYgbTII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769187806; c=relaxed/simple;
	bh=NhgzJvxSjijv1UBl5vqceNfEmtassV+8Z+WDXiFYaYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NV2aDxruYvNpT0ISrZ1YgGCSgKFuW17g2ES1BuvoUnG0tCnWLDtNyT0vL0QbvoudxZ02/KjFZ/15/oIr5VWMAUFvC5BOBaLACc7KwaSNBMLXei0arzQWGDSMHAugraz8NOKR1hL3N8a/qJXRt+8aRLmtUaywXp2iHzvHjD0d4EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eubQEOwP; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-823075fed75so1312107b3a.1
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 09:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769187804; x=1769792604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+PPh+f/fZGEIExOliWL4xsOsnlsuK0W3FPm/lFc3wM=;
        b=eubQEOwPsp3xypqxIa/A+lIZxuDIrCA52fXOpw31nhSqNYUAl1EphDf+BNZsKA75s/
         7Yx6eaBdVCF0Da8/vs4b7K0+pldRWlF/T6dCrgSTsv/CUT+34O6LDjJ2msGWoCuPf0h8
         1DFFLlG41NShpt6ejkf0JOlgRTg5EaJk5pBKLFPA7UsH+MbEzsIyW8FHpwexJwKL6gNi
         ijh8IRpjxVnCDJlS9/qzQ10t8uYXuM4QZQtAkouCcxZ/Dv9Br2NeK0cUtea/1PAS64Ql
         DoxTsD9g8ZBfKi8Uj0n37R23W8LbiyJ6YOcicZv/mAROvpeX5OLm7dTn7wErICItozRr
         kklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769187804; x=1769792604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+PPh+f/fZGEIExOliWL4xsOsnlsuK0W3FPm/lFc3wM=;
        b=LB90FjHBY9UAVNTq1hFZj4S7MjqiJw6QWK4LXDui7Rie96AeRWSX/5ntyB69lzWO+H
         VVbzc85apEuNVTwVL8KIpt7MkY31NPNhoq8aQF6+TeM90jcVbsVgVq+5drRfh+gjuYXD
         DTJxeCX0j8uFEvL+FGazeQ0AwEMHCoLiYai+MJvMuDI/MbipeUgFY7tJMdMAp2AsrROt
         E5FRzVMv00wWZpifh14rulaa3T3RAXoxLqBrln9dGFdTcvL3PvVXB3UzlxU/510fJUah
         3Tg+38PvLbE2+IPaKxP4jxoVJP7DB755piJnPJ1eutR3UGrQiqX/p7Vvpibt6vm2kMne
         X8+Q==
X-Gm-Message-State: AOJu0Yw6wfymZLHtL95q7KvsBjXOF3K2OpOICS3wkqdsAHbC6rgpx9qk
	5JGOxuqBHinK49Q9bZQhSn3Xhu32OPXq3u8rA0YcDOzZ1gy22C1nUnlGYuKevQ==
X-Gm-Gg: AZuq6aKPiULnDKlabzbpuZro6jKnmdKAHJus2q1/OmnE2Wr624u2zvsnZtiaQYBApyG
	GYPFimBIIP/KOSN8gm8usXTa2/OTa2ePxn/jgWvqfCbCtu/M5RzBMAcvM1GZtyB0X8tjS+vmhUh
	77pHUn3AVLte4DKM15eRvVXVTH2kPkhUf3uzp0sc6ktSfksDOQC6JH+sBfJoO7FcCNb+AshHa79
	C8b+/RAOnJUvwFLOBMPgH0yFLr4Fi6OFOuA8w5j9UC4/fipxEiXEJ0f5ddXbd0Y6mW38neFuEpn
	cIgh8aMYQ1TNr7eo6wkzFy7KTFUzeX2ksSWvINgKnzUzUB53OJ1gAfaB1LyforVLDrozujmdiV3
	yZys2Bh6raDKImc9nBe7FoiT9HjsoluJTozZKCg+HQUE87sKwcTHXBkoCy2yuiSeTdVrUp7IT+y
	dZW1XbxBlI4PXcNKwk5007WQjb/xuZDhZutU+0IJulIO7UKU2ac/KtSQ==
X-Received: by 2002:a05:6a00:1954:b0:81f:c6d1:5608 with SMTP id d2e1a72fcca58-82317a17c4cmr3170141b3a.1.1769187803903;
        Fri, 23 Jan 2026 09:03:23 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82318644989sm2638201b3a.13.2026.01.23.09.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 09:03:23 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Nishanth Menon <nm@ti.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: ethernet: ti: netcp: Use u64_stats_t with u64_stats_sync properly
Date: Sat, 24 Jan 2026 00:48:36 +0800
Message-ID: <20260123164841.2890054-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.dev,bootlin.com,intel.com,ti.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-252889-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B5C2E78C20
X-Rspamd-Action: no action

On 64bit arches, struct u64_stats_sync is empty and provides no help
against load/store tearing. Convert to u64_stats_t to ensure atomic
operations.

Note that does not mean the code is now tear-free: there're u32 counters
unprotected by u64_stats or anything else.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/ethernet/ti/netcp.h      |  8 ++++----
 drivers/net/ethernet/ti/netcp_core.c | 16 ++++++++--------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/ti/netcp.h b/drivers/net/ethernet/ti/netcp.h
index b9cbd3b4a8a2..9cfddaa807e2 100644
--- a/drivers/net/ethernet/ti/netcp.h
+++ b/drivers/net/ethernet/ti/netcp.h
@@ -65,14 +65,14 @@ struct netcp_addr {
 
 struct netcp_stats {
 	struct u64_stats_sync   syncp_rx ____cacheline_aligned_in_smp;
-	u64                     rx_packets;
-	u64                     rx_bytes;
+	u64_stats_t             rx_packets;
+	u64_stats_t             rx_bytes;
 	u32                     rx_errors;
 	u32                     rx_dropped;
 
 	struct u64_stats_sync   syncp_tx ____cacheline_aligned_in_smp;
-	u64                     tx_packets;
-	u64                     tx_bytes;
+	u64_stats_t             tx_packets;
+	u64_stats_t             tx_bytes;
 	u32                     tx_errors;
 	u32                     tx_dropped;
 };
diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
index 5ed1c46bbcb1..eb8fc2ed05f4 100644
--- a/drivers/net/ethernet/ti/netcp_core.c
+++ b/drivers/net/ethernet/ti/netcp_core.c
@@ -759,8 +759,8 @@ static int netcp_process_one_rx_packet(struct netcp_intf *netcp)
 	knav_pool_desc_put(netcp->rx_pool, desc);
 
 	u64_stats_update_begin(&rx_stats->syncp_rx);
-	rx_stats->rx_packets++;
-	rx_stats->rx_bytes += skb->len;
+	u64_stats_inc(&rx_stats->rx_packets);
+	u64_stats_add(&rx_stats->rx_bytes, skb->len);
 	u64_stats_update_end(&rx_stats->syncp_rx);
 
 	/* push skb up the stack */
@@ -1045,8 +1045,8 @@ static int netcp_process_tx_compl_packets(struct netcp_intf *netcp,
 		}
 
 		u64_stats_update_begin(&tx_stats->syncp_tx);
-		tx_stats->tx_packets++;
-		tx_stats->tx_bytes += skb->len;
+		u64_stats_inc(&tx_stats->tx_packets);
+		u64_stats_add(&tx_stats->tx_bytes, skb->len);
 		u64_stats_update_end(&tx_stats->syncp_tx);
 		dev_kfree_skb(skb);
 		pkts++;
@@ -1973,14 +1973,14 @@ netcp_get_stats(struct net_device *ndev, struct rtnl_link_stats64 *stats)
 
 	do {
 		start = u64_stats_fetch_begin(&p->syncp_rx);
-		rxpackets       = p->rx_packets;
-		rxbytes         = p->rx_bytes;
+		rxpackets       = u64_stats_read(&p->rx_packets);
+		rxbytes         = u64_stats_read(&p->rx_bytes);
 	} while (u64_stats_fetch_retry(&p->syncp_rx, start));
 
 	do {
 		start = u64_stats_fetch_begin(&p->syncp_tx);
-		txpackets       = p->tx_packets;
-		txbytes         = p->tx_bytes;
+		txpackets       = u64_stats_read(&p->tx_packets);
+		txbytes         = u64_stats_read(&p->tx_bytes);
 	} while (u64_stats_fetch_retry(&p->syncp_tx, start));
 
 	stats->rx_packets = rxpackets;
-- 
2.51.0


