Return-Path: <netdev+bounces-289775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKvVJd5VDWr9wAUAu9opvQ
	(envelope-from <netdev+bounces-289775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:34:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 406D65882F6
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 41C673035318
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 06:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C787C2D9EDB;
	Wed, 20 May 2026 06:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hR2vvoAJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D269313E1D
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 06:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779258839; cv=none; b=s84ccnsCQJXyYZQyYkQm2N+C/P/YSoQfj4vRtOIlzlbbjczvJDj9jc1yqbCgpBF9VF+JbEp+k4FuliRDD8KCF+FwgUPwqoTX8hY41HyFym3WJVVV3yZEoBVH4NWvTigR8E7XOxmx2P8mwtJiZjF7yIzFVfl056y/yOZZ6jEZixU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779258839; c=relaxed/simple;
	bh=BXKTXqRWY+jw4lZIuldyU990q9WRyFqBBlaJKhn7oHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uZPJRA/POxlaBDmOLv0pNZCbDB482rC438OVgKqr0nMLSVqqhuyJe70uOrytsD/4fyzANZqi2F8AEkePXptCFHLzEO2HuBdnWnb4Y2SluUqBs59mBExHSo9po0FvkelHG3hJqBxZciEeGPEUjQKIY8VyhuHfRR0dqVGvWv8QEe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hR2vvoAJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so52618955e9.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 23:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779258837; x=1779863637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcDk9aKx0mhH0+EawoiaNTh4jeIEq1KFEhd8k4aMQ9s=;
        b=hR2vvoAJrHRwi04MdBXK5thsPs+pqPlQmZD24YZ5lw1tb6TSgGA0G0D6ZicuECau0H
         E6yf8bwXB1/R2QYwwSnkV87RBl+KQ9V24wPJHF0NcCAYhqyGmJUGfpiROHpURARddh45
         MuzOGuj6CTgX9wN1qgRie1FV42mB1vHhff2pC734nWwRykHqTGjHhrxw6AoMT6lvQcYi
         Qdt+IajMTTgDHj+il6sOu3TVBPM0Qbd/nE9QI7P0oJUKISq6c6+L0alTjGX7/ygjXkAB
         COlcjUEC2PXm/MDcJdZzU/KrcFu2IHlDNW2xCWFf6fac0cbxhimunNjPZb8pRtWStpgo
         5fqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779258837; x=1779863637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KcDk9aKx0mhH0+EawoiaNTh4jeIEq1KFEhd8k4aMQ9s=;
        b=gtgTd84YwptP5UH8Q3bbSm2GAQJMFF1URVKKEN+DCackzOp1iC21uOntCRONiHoYYh
         mkl05qlbLnBW0tmi/w+5OUZCVZp8eNR1pXqGkMjTfy1ePCj8uMc5ERQaAEatQWkvrzI5
         lxWFjauPETX3YbgSaXlbeeZGNV51J80ibna5r4mlEk0ak+Ry6JGAkxvPVZY7tcC68Exj
         g8D5fIigHCSWCSN6QCc5N5CXA1RABrscOFCLdrYgQ/8QAiiu0hVkPbWc4qARAAiU98eY
         6+p04THN2Sfl0am9V3lqfnMCsadFmASlHG27mVyUsb6CnyS+o6M9LQztZv4dpZaCoRDY
         i1OA==
X-Gm-Message-State: AOJu0YzdhPOH/ZCzxjyU2Avt8oS4egMkceRe9MHQ8tVfUtbyz0tN6LRi
	J+1KDYdvnG0boJsSv5AGVxSq9Hg92VS++rdUrTF4xLqS6xyl4G7le1EkpsRb3YGq
X-Gm-Gg: Acq92OFsXZxkNLciNS1P6s0m7pe3PM1J1FxQjDpN4R4sbzpIYQdCREFHQEReInf4Olj
	yRAfFJ6U74mHGcYSenuOII44J+zhlzMm1+orls8PpnBGKf15GvBloPhdOtcRPQf3B9p59l5B0cq
	Cj1RDLu9at+v0Yen09yF2jXga/z7twKuDjjFT/DHO47cZQjD6SpKNaMl3G0NR5q9SLeAaSIXYea
	iEbaE8tD3HjV0DAnD+ye8/sNQIMjCbydhZDtCkAtYhkLnaGZQU3KDf+pldJa1f8QTBeVwGudxCZ
	4LT1jayX/yFsJD5OxAxBMM/SxWBWuBimLQlykbYTIIVEh5G/oOwgiNb6uO9AFIfZQFHofJ8y1+y
	e8TL02EnLNUIiDuhVkupyGT8wZOdohYiuFRUYrvF6njN8N25k/ZqFn4H8FWiEEphlGZhkrHsvVW
	X2/rx5RyF8qJ/evKW0ZwYd
X-Received: by 2002:a05:600c:3492:b0:48a:52ee:5776 with SMTP id 5b1f17b1804b1-48fe60e79eemr356478835e9.11.1779258836797;
        Tue, 19 May 2026 23:33:56 -0700 (PDT)
Received: from oscar-xps.. ([79.127.164.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c833fcsm374290485e9.2.2026.05.19.23.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 23:33:56 -0700 (PDT)
From: Oscar Maes <oscmaes92@gmail.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Oscar Maes <oscmaes92@gmail.com>
Subject: [PATCH net-next 2/2] pcnet32: switch to napi_alloc_skb() and napi_gro_receive()
Date: Wed, 20 May 2026 08:33:29 +0200
Message-Id: <20260520063329.6387-3-oscmaes92@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260520063329.6387-1-oscmaes92@gmail.com>
References: <20260520063329.6387-1-oscmaes92@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-289775-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oscmaes92@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 406D65882F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the newer and more efficient napi_alloc_skb() and napi_gro_receive()
APIs to improve RX throughput.

Also removes the manual calls to skb_reserve(NET_IP_ALIGN), since
napi_alloc_skb() already does this internally.

Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
---
 drivers/net/ethernet/amd/pcnet32.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/amd/pcnet32.c b/drivers/net/ethernet/amd/pcnet32.c
index 4f3076d4ea34..06d5432bb464 100644
--- a/drivers/net/ethernet/amd/pcnet32.c
+++ b/drivers/net/ethernet/amd/pcnet32.c
@@ -1220,13 +1220,12 @@ static void pcnet32_rx_entry(struct net_device *dev,
 		struct sk_buff *newskb;
 		dma_addr_t new_dma_addr;
 
-		newskb = netdev_alloc_skb(dev, PKT_BUF_SKB);
+		newskb = napi_alloc_skb(&lp->napi, PKT_BUF_SIZE);
 		/*
 		 * map the new buffer, if mapping fails, drop the packet and
 		 * reuse the old buffer
 		 */
 		if (newskb) {
-			skb_reserve(newskb, NET_IP_ALIGN);
 			new_dma_addr = dma_map_single(&lp->pci_dev->dev,
 						      newskb->data,
 						      PKT_BUF_SIZE,
@@ -1251,14 +1250,13 @@ static void pcnet32_rx_entry(struct net_device *dev,
 		} else
 			skb = NULL;
 	} else
-		skb = netdev_alloc_skb(dev, pkt_len + NET_IP_ALIGN);
+		skb = napi_alloc_skb(&lp->napi, pkt_len);
 
 	if (!skb) {
 		dev->stats.rx_dropped++;
 		return;
 	}
 	if (!rx_in_place) {
-		skb_reserve(skb, NET_IP_ALIGN);
 		skb_put(skb, pkt_len);	/* Make room */
 		dma_sync_single_for_cpu(&lp->pci_dev->dev,
 					lp->rx_dma_addr[entry], pkt_len,
@@ -1272,7 +1270,7 @@ static void pcnet32_rx_entry(struct net_device *dev,
 	}
 	dev->stats.rx_bytes += skb->len;
 	skb->protocol = eth_type_trans(skb, dev);
-	netif_receive_skb(skb);
+	napi_gro_receive(&lp->napi, skb);
 	dev->stats.rx_packets++;
 }
 
-- 
2.39.5


