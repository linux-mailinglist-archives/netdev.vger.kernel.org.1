Return-Path: <netdev+bounces-246896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EA604CF2303
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 08:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2CE3C3002D27
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 07:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462152D94B4;
	Mon,  5 Jan 2026 07:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKqA3DBg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7EB2DC78C
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 07:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767597190; cv=none; b=jE4nX9WBvyV0hP+BznxNgTpMecWsOCl8zXx116b/g6PvqXLKYML0KfopDR4zV5kYifqtaKeToQzvgfrqIf7n8OKQVA17ubftxtXNgUExK1QLwVfZQ2Iw+n2x22wBXHE8HKdRNvJa9OYy3U8DWZAEu4sxdfd7BXWyNSclCQvGBlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767597190; c=relaxed/simple;
	bh=gwAMnVCPsbObpSr8NZJYTS5zJXwJE+KPIgRAIXR5+P0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lMSJD1IxVwdsMXmIkN+6W/Dyymiy6ni+LzrDVSgNw+9X9884DAAhxKcTKDBIkMdm5uI/or9UbSLbnKuba+ffFdoU2im14IBLgX8dKPROp8Z4RfUwe2SyBSOzaLkw3ZUg9GcAVwF/Hp55+2QiRYIcZtOCaQIjW18y66Qkd7rqb2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKqA3DBg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47796a837c7so88243455e9.0
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 23:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767597186; x=1768201986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WxfXdQAg2BrE/Z8fW2pjKrcx6pyjbpt2KxhN4MnDyB0=;
        b=UKqA3DBgiCkxWQlzc3wP9iZctZOgfG0CInmErCsdXYK+G2ZrlrB7ELceQkmujZR1s1
         Zo6JKQZkHnKCI2/HseKSfdDHY1z+ycGjk3waXNwYiZfEoA+jBaINExujqC36iZ+l6YeY
         W5kUpPzP6iSxxHv8Pfu+IiIE5MghqFN7tKP0SjcJD+jc0uo02Qesk3YYZiMXXuxz4YZT
         pCSnM9pAjDBeXPVadxQmAjNeOmY5AiPr0A57bjHgS7+szWDtGITQ77NNV7Lnt2uIMqyI
         rFZMwYPpBPrYfyY0StJfd6PI0BDgtd921973azlEd9y3xSJEQ/X8ppNg0fBxvQMKWBnc
         fupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767597186; x=1768201986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxfXdQAg2BrE/Z8fW2pjKrcx6pyjbpt2KxhN4MnDyB0=;
        b=ZM96DYh8C8MX+g8vbgGD/1pfOHi11p8eXNAZCWS4b2/rHnF1ZlPeUFNazG2a5A6Oco
         qgsE2ywBYv/Ezc6vvN8J/hty7wCY4VM2ZLw/I97hRAblPVDFRZdDY+Xi8WfLJHhuU6WN
         kOGxV3K54mhDgGGYp5H7oshXryZXdDBlbWsXSn6ETL1dwZphogk0TSqcgLQRxtCniNcl
         7xGvaOFeFgjmD/VI7csihoKgYSomo0UoYTQU/zIHgJv/X3dTLH5rac4HHoks4fc+CBpM
         /6ktr9H7JUgq7dHmsTL+90gTeOvc2Bd9jACIFx3j5C+aWWXeBGj2jRAebQ23cKgAMuzv
         PWjw==
X-Gm-Message-State: AOJu0Yw6hWVc9I/1RI6+BwUWzHVkDYwE4Xa0tLKuUqKu1Lcl6R7LXvVM
	mXgKFRvC39vVWXv8O0/SgDidgmDZfTSOjYZGInr8z74HXVbuB19uQ4qw/NuklVTC
X-Gm-Gg: AY/fxX5e/o7qhZihHJnlTMVqgugYVjdjETm8JRPWkolXLnCl4YbyHbaPbCH9ah1BOci
	2GiA7gYS6D3CwQ+7ws5lN04X6c5nI1gEZ3/iiGdqKDbbOCH78/sUMPWduBJIoRKDTEHDUi6ZqMn
	+LthIKc24WsmUocGXHPFURXVciLBb9QGXFpUvKzY9hFlDGyuKr/WOR/mYMljntYdNttF0RVlCLA
	/I6dj/nkEQSWO3+kLCX8kiBLanGD1cLbllph28HIVZ8lgNodHl7sk4ZOng/6b2xlBeCRlwE85xL
	7HDiYmGjj0IxA9rlLR3Jiuww3BTQG7dfJ0JoDjJVxjyMz6BJQv4nnMk/Js4quJNoNNG+g2zg2zE
	xrR49IX69lMyac272WeZMO8vY/3p6bNH9bzImrWXM808mrcSF5s2Qrco9PZBFPiV+iQT8Rt6IKA
	eAxMyKrfFTtYs=
X-Google-Smtp-Source: AGHT+IELaTadGLOwRJqFAHK5LSWVDMZuNYFlsZ68Vy+MDD2lTWsXUWSNIeBNSkVYxMppnNjcBz1L5g==
X-Received: by 2002:a05:600c:45c5:b0:47d:4fbe:e6d2 with SMTP id 5b1f17b1804b1-47d4fbee7b1mr357360315e9.12.1767597185879;
        Sun, 04 Jan 2026 23:13:05 -0800 (PST)
Received: from wdesk. ([5.213.159.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d13ed3fsm133820765e9.1.2026.01.04.23.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 23:13:05 -0800 (PST)
From: Mahdi Faramarzpour <mahdifrmx@gmail.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Mahdi Faramarzpour <mahdifrmx@gmail.com>
Subject: [PATCH net-next] udp: add drop count for packets in udp_prod_queue
Date: Mon,  5 Jan 2026 10:42:18 +0330
Message-Id: <20260105071218.10785-1-mahdifrmx@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds SNMP drop count increment for the packets in
per NUMA queues which were introduced in commit b650bf0977d3
("udp: remove busylock and add per NUMA queues").

Signed-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
---
 net/ipv4/udp.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index ffe074cb5..9dbbe4da9 100644
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
+			if (err == -ENOBUFS) {
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
+			       err_count.rcvbuf4);
+		SNMP_ADD_STATS(__UDPX_MIB(sk, true), UDP_MIB_MEMERRORS,
+			       err_count.mem4);
+		SNMP_ADD_STATS(__UDPX_MIB(sk, true), UDP_MIB_INERRORS,
+			       err_count.mem4 + err_count.rcvbuf4);
+		SNMP_ADD_STATS(__UDPX_MIB(sk, false), UDP_MIB_RCVBUFERRORS,
+			       err_count.rcvbuf6);
+		SNMP_ADD_STATS(__UDPX_MIB(sk, false), UDP_MIB_MEMERRORS,
+			       err_count.mem6);
+		SNMP_ADD_STATS(__UDPX_MIB(sk, false), UDP_MIB_INERRORS,
+			       err_count.mem6 + err_count.rcvbuf6);
 	}
 
 	atomic_sub(total_size, &udp_prod_queue->rmem_alloc);
-- 
2.34.1


