Return-Path: <netdev+bounces-290624-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BKLNkaAD2pdMwYAu9opvQ
	(envelope-from <netdev+bounces-290624-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 23:59:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E67615AC409
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 23:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B329300B282
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 21:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C7B363C62;
	Thu, 21 May 2026 21:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Av03Mgtg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE7C3630AD
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 21:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779400770; cv=none; b=SWPtYMap9yLyjwFfGTRUdmhvi/7H2EFR89AJ+Z04OKIE7sHwYEBoRc9gnHq0eU7mhNZAfT6Gy1htkmntY02KHyNRGBF4Vocn1YBj8L24FZvIdFP0Yqf59qzyc5zSbip7WeC2k4/nWrINfL7OE/KH9ixIMmwDlaJlhi5Q2ikocOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779400770; c=relaxed/simple;
	bh=Uix4sdOeQOfZ2qnoZJWLanW0I9iYfNJFKlhaOAGtNFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hSplaErDu5OyPoX+Ypk51mUsjbA69o6UvZUHfGHoLYwtfWChbfgw4Pq7qSrZZ2juHgfuZxVIj6tlKvbHXXJcbzbxB/dY6/sQfR7U0IlpuR+KikWjVx8VZDdg0o6A8OaRHfoTKnXBiz+DkJ4oC3T1F4+FSnRt0HCGs7TVL1BADR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Av03Mgtg; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-90d042fa745so1132917485a.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 14:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779400767; x=1780005567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mI24G/o+4PEXDBjCjZw3VQTBs+XxswtjSNBe5GbNQpo=;
        b=Av03MgtgFvYEr2EW6PCZm4Gk3tX7uEpKea0p89wtxDONttYIeIERq4LG6iUoyr7U++
         wScxdJBxquy9QoOVOLWEn/Ev1uMk6A6to36gyVh56hv2QFoAAivGCoeEF5/VWGse8gt8
         0MBYgKfCuk96YePfs5aSeA/QI6IhMHH/XfQwaRtwgixv8FN3fjo5REDb5ksRRNtWdUlO
         I+uQrefg7hQAO6sxnncflB7bPqUENXLs0hf1hbvFqS0bZnmc4yqA7fffXE57UaI6NM2o
         zlk8PrUUBghfUM0n0bZPrmUj5wK1LvTBfoMHE/0qtue4PvKGQ2F6NBleimFfsb+EYw0K
         swUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779400767; x=1780005567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mI24G/o+4PEXDBjCjZw3VQTBs+XxswtjSNBe5GbNQpo=;
        b=V9j5bfnV+VIiMIUsg+ArPoDd0rPA20QynrhQKDs1ZltoLNP8VBXWmyQlVaGEk7VG5E
         yqypNbh6+RY0iGm0pQR6eQ1oApF723xhPb/nP7XZy2OK7b0+II136wCqW4CGsdI4T0p5
         R39ZHWqVbt43Ux8GqFbxh7LNbr3SeeBQt54KjXsdvjqUkVABJFK/vDtyI+59EfPFVMrj
         +wu4MyVuKWIm+EzfZfw0+/mOOnXw/1oal4d5GiyM26cjgBxKA/AbMfrsjoJkLGJbQhOv
         5iz0ou3nyM/oSs5XDzc6nOaN6NrYVt/c9MtWMo3XSnIutGGplUIiK//ToGr84Ik2GYKX
         5uqg==
X-Gm-Message-State: AOJu0YzhOclkZ02zAAJfFhhW1IN0Kcv4iwlTICcaqb5aVzMuiDclEv2U
	eBnOy61wQAPfoCrSOVfRSGnt8kaMu4mHdGhdTTr4UUykG5OiAiI1eFlkCotDpw==
X-Gm-Gg: Acq92OFKZWo59IFrN4eVUb9VRQjg7ILsqrFoyO+uTBXuaOjlzJfqYDKAZbJ8FPCYnP1
	2eEdSD3Oy6P6NQVYpugXJBOty09kQ2kds/8ODfRV1uwYC8GDbkDVaAZggPMOYrsIeG1OLhx1Q+m
	BEsthGuC5e1odfMhxq9gyX5QLTY7C5O/zBgPTJkvju31BXRZ/ThVUHCuy0xkVXSL+ebWTlzPzUo
	67js6nSycGXb3sm3nq5iaNBnEkosrUwUq1HowmI54ZF5D1WSa0M2xF6plU+Y4y8nTnIffDhVrVS
	t3VbZG5C5191lq70tbOCxbBMTkmb5UQSval4wcBMsJXzD+E0gRDHRaZxiWTB51IJ7/DLlFkY2h7
	/EL640A4ZdhwdR2mAzpH4ZB3I90xpwfz1jWQATLgzad60tt+LRuSoNZRCckbliaWkoLNDiIDQQX
	OEgjpKLUZix0dgxevRp2acmKv0C/+D6vRGC0Cijk08IxOyWy2Wi60TRma83joN3R++nShYegSDF
	zQ6lcnoQh73KC9X4RH7XiAtMoxYc1KxpUlxJE6CpKqE/5PSvU2bhJWW
X-Received: by 2002:a05:620a:468a:b0:8cf:c513:349c with SMTP id af79cd13be357-914b46b9db7mr180633785a.9.1779400767517;
        Thu, 21 May 2026 14:59:27 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914b5d95413sm17311485a.19.2026.05.21.14.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 14:59:26 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] net: ibm: emac: Use napi_gro_receive() for Rx packets
Date: Thu, 21 May 2026 14:59:08 -0700
Message-ID: <20260521215908.257118-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290624-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E67615AC409
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

emac_poll_rx() already runs in NAPI context and TAH-equipped EMACs set
CHECKSUM_UNNECESSARY on verified frames, which lets GRO coalesce TCP
segments without a software checksum on the merge path. Replace the
per-poll rx_list batched with netif_receive_skb_list() with direct
napi_gro_receive() calls so the stack can merge segments into super-skbs
and skip a full traversal per packet -- a meaningful win on the slow
4xx-class CPUs this driver targets.

Small routing speed improvement tested on a Cisco Meraki MX60W:

Tested with iperf3

Before:

[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec   494 MBytes   414 Mbits/sec  839             sender
[  5]   0.00-10.04  sec   492 MBytes   411 Mbits/sec                  receiver

After:

[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec   510 MBytes   428 Mbits/sec  580             sender
[  5]   0.00-10.04  sec   508 MBytes   424 Mbits/sec                  receiver

Traffic to and from the router seems to be slow no matter what:

Tested with iperf3 --bidir

Before:

[ ID][Role] Interval           Transfer     Bitrate         Retr
[  8][TX-C]   0.00-10.00  sec   297 MBytes   249 Mbits/sec   35            sender
[  8][TX-C]   0.00-10.00  sec   293 MBytes   245 Mbits/sec                  receiver
[ 10][RX-C]   0.00-10.00  sec   184 MBytes   154 Mbits/sec    0            sender
[ 10][RX-C]   0.00-10.00  sec   184 MBytes   154 Mbits/sec                  receiver

After:

[ ID][Role] Interval           Transfer     Bitrate         Retr
[  8][TX-C]   0.00-10.00  sec   295 MBytes   248 Mbits/sec   31            sender
[  8][TX-C]   0.00-10.00  sec   294 MBytes   246 Mbits/sec                  receiver
[ 10][RX-C]   0.00-10.00  sec   181 MBytes   152 Mbits/sec    0            sender
[ 10][RX-C]   0.00-10.00  sec   181 MBytes   152 Mbits/sec                  receiver

Assisted-by: Claude:Opus-4.7
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index adac0b55936c..11d673a9f119 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -1738,7 +1738,6 @@ static inline int emac_rx_sg_append(struct emac_instance *dev, int slot)
 /* NAPI poll context */
 static int emac_poll_rx(void *param, int budget)
 {
-	LIST_HEAD(rx_list);
 	struct emac_instance *dev = param;
 	int slot = dev->rx_slot, received = 0;
 
@@ -1795,7 +1794,7 @@ static int emac_poll_rx(void *param, int budget)
 		skb->protocol = eth_type_trans(skb, dev->ndev);
 		emac_rx_csum(dev, skb, ctrl);
 
-		list_add_tail(&skb->list, &rx_list);
+		napi_gro_receive(&dev->mal->napi, skb);
 	next:
 		++dev->stats.rx_packets;
 	skip:
@@ -1839,8 +1838,6 @@ static int emac_poll_rx(void *param, int budget)
 		goto next;
 	}
 
-	netif_receive_skb_list(&rx_list);
-
 	if (received) {
 		DBG2(dev, "rx %d BDs" NL, received);
 		dev->rx_slot = slot;
-- 
2.54.0


