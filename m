Return-Path: <netdev+bounces-246642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 212C3CEFC20
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 08:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77B3D300C5D0
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 07:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00A02989B0;
	Sat,  3 Jan 2026 07:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKamALQO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12B4231A30
	for <netdev@vger.kernel.org>; Sat,  3 Jan 2026 07:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767425707; cv=none; b=Pm11O/gYGXurQiUKN+s0veEnmuHmGNt2KjBgIBqEhzXlO/447lnLdv0/ZNqEslcAH9h2uVNdEL5+wW+2Kw8d3fWJSLC08bann/6fLzXCJTbXTOb1sPAVWVnQi0DpY3AukBpWm0/T7Diju3LDAkGwQal3bNtzEzZhAuNGR7so9Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767425707; c=relaxed/simple;
	bh=qassL5vuV23kQD0HsuUk60GKvU0WxH3y1HiGRcRV140=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q8UJ/L0eUWkEun8OYvM4lGMtVfHklB4S/Y1efyiDyqxzju+yGNXW9nYUGQffkvAmR226Bnq0xapulcwW54wBFY/uaZ95fvx5CmODoQxrgVgYyLwsjuc/bZtwsT3SPZOG6SMzEWqRzLy/mo0iUvQ3yBR4tuU6YJrkxaEF2JCRsNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKamALQO; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5959d9a8eceso14275004e87.3
        for <netdev@vger.kernel.org>; Fri, 02 Jan 2026 23:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767425704; x=1768030504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qCqlbDZJeJM78Y83hMUh/636DELqUMKtJwdhltGdUSI=;
        b=aKamALQO/katVgsP4d/2ybbYT/mbzWZJRKsdZj3sDWGqASE2XHibcWfahBF+J9DWox
         OrLWh2bthM9mkDcGjznNKGX2VRwJCrkraJ6W3AO5Pf0SNPEEyi58H2o77pqSd3YliBap
         hqk7ZMuPr+SChC0uZlNMmeSFUZKNss7Gl43XUnwFvr5JieznV1WJ17QPXpo+dkN//WmV
         G9CbwTdt8bn5Gaf4gDlGWH3gBSjRsIs88QDey3UdKJShqe2u8Nzb1JqrJoZVfrYq25G+
         ekbQ/hWu8lHUoix3R60/RdUvImv0E9IW1QeoAfOleJ1AjKHMNMUaPON+snaTct1p4c/l
         z3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767425704; x=1768030504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCqlbDZJeJM78Y83hMUh/636DELqUMKtJwdhltGdUSI=;
        b=Cmq66lIgbh95pImei68yazWZJd4Hz5p6z2/sBNzYpozXmyeaA2uFz+UA5M8Zpgo/FD
         x2ZbCyoyL4w037YyWwW5ktS3FGiqzjMpF7RImDNx5eMGUeheLvbEFXuGe8QK1QG/f526
         5XWX/qhQrZMOb2f1+8ssm8L2Jv4pHkg3GCD5qMeS2S8UTjyJ396+QS8EQDNCnUFruD7y
         G1cVrFPT/XgTpJxr4VeFbwvE1g4dpts5FVr0HwuRqxkRWWVR71LVmhuAf0/ScQV23oJh
         5k6m9yWuH1lvKs74mAc6aniRiu34cLNWYVbJLTIuw+KTVbRb2CyNHayQlaQskmkrUuk5
         tIeg==
X-Gm-Message-State: AOJu0YzJ2wYDA56ZWGD/8z1ZROlnwwhQZeaaqsYPBWgx/VjdyClQmN4O
	Vf0JX6n9XUf6n99iNsUA9rYgMl8egcuGxBJujOlO7Mzhbgw0WWvv3ERBA1qtXNdz
X-Gm-Gg: AY/fxX4E2Gk/3QE1CSwCZQyGRDbnbBQxwLMUoJNyP+di9kWb8qGs8qVEvJpusdhkXnK
	K6ums6H1cSFvRQGPdE7qkq22/A1EBKpLUWUYDwKNm0NyvetEjWitEGFBF9dH+90/6KzLHRDS23F
	WV8wixrG7mgf97mrapEE7FuNh5WgCGSPBsZpXSGgOVyfrDIFIqnD5GkU8Fag84IZlVWSdUF1Dlf
	ijVr87aqOPUFR3wabCmNbLmw8AZXiA56FutGH5HERx8IwKWrUj/2aecyIExwjgVrK7bJTm15p/c
	xIo2/J6FZ3aEGSGRnrwjiYWQWhiN76OI4KUz3AHKVwbOTY+UrfBi3Sv6aD0WPVT2UTqX/ttjRms
	JWaMfCMzVxyWPKG5SLzDBTc33djN58N38lDzO3gJJawh1LfrzqTmLbzWMp4OIFAmDbDAFjYNvOV
	Y=
X-Google-Smtp-Source: AGHT+IErLXUk+2UBmdPOkkr1Hfxhw0RFgmGtIOZsEF1zcXfURgbGxLXBwRgMoDP+m8VSaqO7AeXFJA==
X-Received: by 2002:a05:6512:3e06:b0:595:9dbc:2ed7 with SMTP id 2adb3069b0e04-59a17ded9b9mr14294829e87.43.1767425703611;
        Fri, 02 Jan 2026 23:35:03 -0800 (PST)
Received: from wdesk. ([86.57.26.14])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a1862836esm12946978e87.98.2026.01.02.23.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 23:35:02 -0800 (PST)
From: Mahdi Faramarzpour <mahdifrmx@gmail.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	edumazet@google.com
Cc: Mahdi Faramarzpour <mahdifrmx@gmail.com>
Subject: [PATCH net] udp: add drop count for packets in udp_prod_queue
Date: Sat,  3 Jan 2026 11:04:57 +0330
Message-Id: <20260103073457.189244-1-mahdifrmx@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

in commit b650bf0977d3 the busylock was removed and
per NUMA queues were added for a performance boost.
This commit implements SNMP drop count increment for
the queues.

Signed-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
---
 net/ipv4/udp.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index ffe074cb5..00a8aeda1 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1709,6 +1709,13 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 	int dropcount;
 	int nb = 0;
 
+	struct {
+		int rcvbuf4;
+		int rcvbuf6;
+		int mem4;
+		int mem6;
+	} err_count = {0, 0, 0, 0};
+
 	rmem = atomic_read(&sk->sk_rmem_alloc);
 	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
 	size = skb->truesize;
@@ -1760,6 +1767,17 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 		total_size += size;
 		err = udp_rmem_schedule(sk, size);
 		if (unlikely(err)) {
+			if (err == -ENOMEM) {
+				if (skb->protocol == htons(ETH_P_IP))
+					err_count.rcvbuf4++;
+				else
+					err_count.rcvbuf6++;
+			} else {
+				if (skb->protocol == htons(ETH_P_IP))
+					err_count.mem4++;
+				else
+					err_count.mem6++;
+			}
 			/*  Free the skbs outside of locked section. */
 			skb->next = to_drop;
 			to_drop = skb;
@@ -1797,10 +1815,22 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 			skb = to_drop;
 			to_drop = skb->next;
 			skb_mark_not_on_list(skb);
-			/* TODO: update SNMP values. */
 			sk_skb_reason_drop(sk, skb, SKB_DROP_REASON_PROTO_MEM);
 		}
 		numa_drop_add(&udp_sk(sk)->drop_counters, nb);
+
+		SNMP_ADD_STATS(__UDPX_MIB(sk, true), UDP_MIB_RCVBUFERRORS,
+			err_count.rcvbuf4);
+		SNMP_ADD_STATS(__UDPX_MIB(sk, true), UDP_MIB_MEMERRORS,
+			err_count.mem4);
+		SNMP_ADD_STATS(__UDPX_MIB(sk, true), UDP_MIB_INERRORS,
+			err_count.mem4 + err_count.rcvbuf4);
+		SNMP_ADD_STATS(__UDPX_MIB(sk, false), UDP_MIB_RCVBUFERRORS,
+			err_count.rcvbuf6);
+		SNMP_ADD_STATS(__UDPX_MIB(sk, false), UDP_MIB_MEMERRORS,
+			err_count.mem6);
+		SNMP_ADD_STATS(__UDPX_MIB(sk, false), UDP_MIB_INERRORS,
+			err_count.mem6 + err_count.rcvbuf6);
 	}
 
 	atomic_sub(total_size, &udp_prod_queue->rmem_alloc);
-- 
2.34.1


