Return-Path: <netdev+bounces-306037-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SL/7IdInT2pfbQIAu9opvQ
	(envelope-from <netdev+bounces-306037-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 06:47:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D836172C962
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 06:47:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=n4RIc+R2;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306037-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306037-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A2BF301E586
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 04:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1545B2EEE9F;
	Thu,  9 Jul 2026 04:47:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8DC43935E
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 04:47:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783572432; cv=none; b=CcmzPWkFinj3gatZNiVRa0aQ60z/opl76+TiO/m+WOulWh5NXGaig3zqfrik7q8LzZA58SUIyVeEQLW5ZfUGNdv3MrbHtecJ6w8iejrd6GcbYpi/DeCFUj6etYn4osHMb2QsrUoy9M93CAVcFT9N49dUlQ1HlSDzMfrB+Z7gWdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783572432; c=relaxed/simple;
	bh=PRroqpoyMJg/+rYrFJe4O8BKnUwWTSzH2NWue6bkJJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oNPhyGqSIaXXfWRte739JBYHPo0Rcfstx9q6MhSqfQa0loCLXSDydj8By0z3Jp2aKbKQ2VqfDau91szfS8MtbHujYK+8z99gcLxH6lCKTpcAy6lBf9waBKvfWtc3eqd5iWrcL3EJ6YlaFCGGkHcIG7w99nRAiDaUMXE9EkyLtDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n4RIc+R2; arc=none smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc80b585bfso4011355ad.0
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 21:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783572430; x=1784177230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZGemzx+pMunN1tP8jAT+YOako4z0+tHzoNO2IOm+UVk=;
        b=n4RIc+R2Jp4fvqXccV0SRDYpftkct4bxvjoLSvrXWnpE5gFZuRdumdh3moejftvrto
         pB2UYCktHz/+oqhfptL3ZtCU0SYDPdkV8PT7Kh5mv8jbBG/2YGXgZo+QVm96xug+/sbR
         cZF6b1ch0aSyMPblNHgZVX+GHbMC8e3jbBlM40qWaUpagKRivqQjRwlw1bI51QujQulc
         1denembbw0phiJHLz2Z4xskUCGtUmoAZ/aO9xdTThoTRspINzpyCqktTBbWIMj5oZV6z
         VXp+g6xiZqWvVBYKYrYOD1Tv3I6rRRNj54ElIEQfIxR1rm/1Ls4K9dEUAUyUgrg11Vcb
         yiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783572430; x=1784177230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZGemzx+pMunN1tP8jAT+YOako4z0+tHzoNO2IOm+UVk=;
        b=cksoVJWJVUgVC4Mwg6nwcAaB33cbJ2cF10zrYJ+0TG3LVOq935lRVGTFngUgHesB6w
         IQJSX3ukwAlQMvMbWpc23m1T6B3KH/K6ALxRtYl85XSWOmNOcPO0Uykiw0hayDTsmRk8
         MrHKddkraXVPL3DXtzmgqUsDqV0BFbNpxveLfuxV+lzfSIkzV53HMJ8425bHAcCM9SV0
         0fqMshbXvwprAEKgKONFFvj/JAY3YZJ73De14tQbgvsMyDFs1usc8Wo6RkNcoroojkUb
         srl2mk+ir0KkN1v3A8QlbZgJ5VjweWgmHPWchbu4d3vH/SD3RmWRPYTBfp250wSe1lDq
         oQvQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrtbof+MdqSgLGUWt6+3HoW8rGy3Wl5StjoiK2YLZBrFbo47c8Jn3vsZQPI9MKntVmXTFzXb4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfVZH9qbLq5WMrUZmF3SUYf8gt5TfFZ14uOKUg6MVM0ToMPqQp
	RTld8bSVFmr+jJAjpl90Xrvdr67flfCyb57g75FN5yTBj+xGKIxLjqvR
X-Gm-Gg: AfdE7cnmM/oTzhKy+vr0D+8jOq3POfOT1RA/yflS4kckJg2Tv/RASNu8dguseskmyY9
	XAeKTQfgn3a+G5EcYk7fOiNYeNGMveIncUlS/SSBObkyE18/famG6+PDN3cX2iTEr6ZgflYENdX
	GurCuTaQ42TxdEAQBnsYyZQ+8/Xv/8cSMMUy9yWX7MY8IxoWseudKNOk+VUdkOgvhtgmDlazYIU
	Y6ZgMxstKX87OftV1vivemW+pbn+SbfNRPG9jwVCV3nsz4n55u4YHfgHRzVoImMP//5/6cTyti8
	wPZ4RAC53jgeZtI85xotfnLXwrDN425qFYh6C+SCg2hN2OfRFJvENRXubyghG5a1cWhcTsftFvM
	S0vsTvwRtSEmJqLXB6Q71pwUgD20ccP1stU5gPLunTtscXUj7om0k6ARrJPB8pXpRLp+LG5S4nU
	82VxG9DtH0TN5Xs+P0qg==
X-Received: by 2002:a17:903:3c67:b0:2ca:9d5a:8b6c with SMTP id d9443c01a7336-2ccea37d246mr55009625ad.5.1783572429827;
        Wed, 08 Jul 2026 21:47:09 -0700 (PDT)
Received: from localhost ([2402:e280:3e0d:544:91b3:77c4:f31d:d706])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb76asm38436785ad.12.2026.07.08.21.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 21:47:09 -0700 (PDT)
From: Vaibhav Nagare <nagarevaibhav@gmail.com>
X-Google-Original-From: Vaibhav Nagare <vnagare@redhat.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch
Cc: matvey.kovalev@ispras.ru,
	Pavel.Zhigulin@kaspersky.com,
	aelior@marvell.com,
	manishc@marvell.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vaibhav Nagare <vnagare@redhat.com>
Subject: [PATCH net] qede: Fix NULL pointer dereference in TPA fragment processing
Date: Thu,  9 Jul 2026 10:17:04 +0530
Message-ID: <20260709044704.141507-1-vnagare@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306037-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:matvey.kovalev@ispras.ru,m:Pavel.Zhigulin@kaspersky.com,m:aelior@marvell.com,m:manishc@marvell.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:vnagare@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nagarevaibhav@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nagarevaibhav@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D836172C962

  Under memory pressure, the qede driver encounters NULL pointer
  dereferences when processing TPA continuation fragments because:
  1. qede_fill_frag_skb() does not validate the page pointer before use
  2. qede_tpa_end() checks error state AFTER calling qede_fill_frag_skb()

  The crash occurs when:
  1. System experiences memory pressure (GFP_ATOMIC allocations fail)
  2. qede_alloc_rx_buffer() returns -ENOMEM, leaving sw_rx_data->data NULL
  3. qede_tpa_start() sets QEDE_AGG_STATE_ERROR on SKB allocation failure
  4. Hardware delivers TPA_CONT and TPA_END events for this aggregation
  5. qede_tpa_end() calls qede_fill_frag_skb() before checking error state
  6. qede_fill_frag_skb() accesses NULL pointer in skb_fill_page_desc()
  7. Kernel panics with NULL pointer dereference

Example crash from production system:
  BUG: unable to handle kernel NULL pointer dereference at 0x8
  RIP: qede_fill_frag_skb+0x96/0x430 [qede]
  Call Trace:
    qede_rx_int+0xb06/0x1de0
    qede_poll+0x2f4/0x6c0
    __napi_poll+0x2d/0x130

Observed on HPE Synergy 480 Gen11 running RHEL 8.10
(4.18.0-553.134.1.el8_10.x86_64), but the vulnerable code path
exists in mainline.

Fix by:
1. Adding NULL page validation in qede_fill_frag_skb() before dereferencing
2. Checking error state EARLY in qede_tpa_end() before processing fragments
3. Checking error state in qede_tpa_cont() to skip fragment processing

This allows the system to survive memory pressure by dropping packets
instead of crashing.

Fixes: 55482edc25f0 ("qede: Add slowpath/fastpath support and enable hardware GRO")
Cc: stable@vger.kernel.org

Signed-off-by: Vaibhav Nagare <vnagare@redhat.com>
---
 drivers/net/ethernet/qlogic/qede/qede_fp.c | 25 ++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_fp.c b/drivers/net/ethernet/qlogic/qede/qede_fp.c
index 33e18bb69774..95b5cfcc43c2 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_fp.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_fp.c
@@ -670,13 +670,22 @@ static int qede_fill_frag_skb(struct qede_dev *edev,
 							 NUM_RX_BDS_MAX];
 	struct qede_agg_info *tpa_info = &rxq->tpa_info[tpa_agg_index];
 	struct sk_buff *skb = tpa_info->skb;
+	struct page *page = current_bd->data;
 
 	if (unlikely(tpa_info->state != QEDE_AGG_STATE_START))
 		goto out;
 
+	/* Avoid NULL pointer dereference when under severe memory pressure */
+	if (unlikely(!page)) {
+		DP_NOTICE(edev,
+			  "Failed to allocate RX buffer for TPA agg %u\n",
+			  tpa_agg_index);
+		goto out;
+	}
+
 	/* Add one frag and update the appropriate fields in the skb */
 	skb_fill_page_desc(skb, tpa_info->frag_id++,
-			   current_bd->data,
+			   page,
 			   current_bd->page_offset + rxq->rx_headroom,
 			   len_on_bd);
 
@@ -684,7 +693,7 @@ static int qede_fill_frag_skb(struct qede_dev *edev,
 		/* Incr page ref count to reuse on allocation failure
 		 * so that it doesn't get freed while freeing SKB.
 		 */
-		page_ref_inc(current_bd->data);
+		page_ref_inc(page);
 		goto out;
 	}
 
@@ -959,8 +968,16 @@ static inline void qede_tpa_cont(struct qede_dev *edev,
 				 struct qede_rx_queue *rxq,
 				 struct eth_fast_path_rx_tpa_cont_cqe *cqe)
 {
+	struct qede_agg_info *tpa_info = &rxq->tpa_info[cqe->tpa_agg_index];
 	int i;
 
+	/* Don't process fragments if TPA start failed */
+	if (unlikely(tpa_info->state != QEDE_AGG_STATE_START)) {
+		for (i = 0; i < ARRAY_SIZE(cqe->len_list) && cqe->len_list[i]; i++)
+			qede_recycle_rx_bd_ring(rxq, 1);
+		return;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(cqe->len_list) && cqe->len_list[i]; i++)
 		qede_fill_frag_skb(edev, rxq, cqe->tpa_agg_index,
 				   le16_to_cpu(cqe->len_list[i]));
@@ -982,6 +999,10 @@ static int qede_tpa_end(struct qede_dev *edev,
 	tpa_info = &rxq->tpa_info[cqe->tpa_agg_index];
 	skb = tpa_info->skb;
 
+	/* Drop the packet if TPA start failed */
+	if (unlikely(tpa_info->state != QEDE_AGG_STATE_START || !skb))
+		goto err;
+
 	if (tpa_info->buffer.page_offset == PAGE_SIZE)
 		dma_unmap_page(rxq->dev, tpa_info->buffer.mapping,
 			       PAGE_SIZE, rxq->data_direction);
-- 
2.54.0


