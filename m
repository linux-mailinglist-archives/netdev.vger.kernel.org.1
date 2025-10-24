Return-Path: <netdev+bounces-232397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89292C05515
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 11:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3F32561050
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 09:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD8F3081D0;
	Fri, 24 Oct 2025 09:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lnwu7mDV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5320A308F0B
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 09:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761297164; cv=none; b=hkwOUSr2xTZ9O9+mN193/XbVQYErDYFbrilcnXCB9rmfnDiBMqoX0TtfIrc8Z4V22O5m2xj4FZ3QZdiJjrPtId3zOPJOmjMLJ7UXs2LzPeBoK1leZWKhZdvK2hbRjlOP0SOe1mNfpwxGc37KowkbZc4Y6yAtNc+tF9dUNqdyb6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761297164; c=relaxed/simple;
	bh=b4fcPDPdHyFgtbJsEfUVIDLQmExHtGaThhTr1RZJbdo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UsHU70jfmOclmdaUzI12fXgFek15qtj8Z3fxFD1D2OF6o1GDtufw81e+iSHG8IRjX2nREnP6w/Wth88f4Kvq4zJvdEwMT1CDh4U9MfvTjSNDcQ63gZqLzuYh0tKrFUZ9dPMXYXKIyH2iTX8nnGYYgXVh6NGzHQ+4EpsoA36LWxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lnwu7mDV; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-85dd8633b1bso881400385a.1
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 02:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761297162; x=1761901962; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4ZOQqWJV8KC55lEsQteEDo8o1WFvi0KLeTnOsQ2765s=;
        b=lnwu7mDVb5LLmjzTM63srgErS1IQ8j4O8wOYdc8jBK76AC9CDmyvdb73gevC2+m+Ry
         tIrvfrhXMiRZGZmJJVg61WhvCq5wviUIAeVK51nqti5yyO5V0JKmqqOv7czUiTTwARlN
         Gad3uiWdjA2Mx98XZMcehP5QVgT/O/tOH7oqvhflkXVn2+zRcdLlxACJaAwvfBvgtVkd
         UcClhah56UqwqDiW9BMntQF7TsN5c5TMdvPDhgLxwPwiWcMfHmPg/g1ER2f0rwQH85xr
         mc6arkF7ds4U90aUvZ8JbhMVYXzZa7fSe09aUJ6oImZEOvScxseYktLpw/agQ+SW3SfK
         pADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761297162; x=1761901962;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ZOQqWJV8KC55lEsQteEDo8o1WFvi0KLeTnOsQ2765s=;
        b=fIaU+is+R27YGuZIbCx7DDXmAWiSzPYir+EXhYttz/8iTDborqFhjntW+iaehBiyjE
         dZPjSuNNvI4fhnvwRdYp3JjSN43PW2iiPLMk/S7FWQElMNAmr6PnYGxRCj1zIgnoerjQ
         Lq7yb8fbKZz7Nr91wurUyz3ZgACfNhPFVwDiqYaZ3nc5laSHW75liuqXWWJuaIbuaWM/
         mBlu8s/LbbJdd8Y1Br9+L5Nadf7hYO7XIIAVypypqzN3M2F+dzCt7WSlg/ETapoDTe2M
         WuEkuRsP+N1fNnrbXeLiPa/K3Nj+gdZ8PVcQ6clkviD9ecl3ZYlCfPUyXTps49C0nF4N
         9GJw==
X-Forwarded-Encrypted: i=1; AJvYcCWA1gzyUOImQT9UWTihyfoFxuLSJc9bH2hGJcjvYQKD0AvzKOC4hdKgYz/6Fg31wLKTk4C848g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDjV8ejsgPdaNWQ/qxJl+HgMW4DlUmzOJwvFf8BNoeuJAWBwEg
	AhLunvuDAoX+ipIC9Wttk7HdB5aqjXt81l9XTxn2/adsS7lxP0J7FHykh146eBshQ1W6gjXfhl6
	4LtszX3it2jNuiw==
X-Google-Smtp-Source: AGHT+IF12OXAhX8Ruei2oMEuMew7i851JdLaQfovBEMxdEDp1tlsFhuPCf6OpgdWpvgo4He3dYnPE3FDoiMGfw==
X-Received: from qkf22.prod.google.com ([2002:a05:620a:a216:b0:891:db86:b5b8])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1b87:b0:883:647b:6dec with SMTP id af79cd13be357-89da0282d3fmr201798485a.3.1761297161857;
 Fri, 24 Oct 2025 02:12:41 -0700 (PDT)
Date: Fri, 24 Oct 2025 09:12:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024091240.3292546-1-edumazet@google.com>
Subject: [PATCH net-next] net: rps: softnet_data reorg to make
 enqueue_to_backlog() fast
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

enqueue_to_backlog() is showing up in kernel profiles on hosts
with many cores, when RFS/RPS is used.

The following softnet_data fields need to be updated:

- input_queue_tail
- input_pkt_queue (next, prev, qlen, lock)
- backlog.state (if input_pkt_queue was empty)

Unfortunately they are currenly using two cache lines:

	/* --- cacheline 3 boundary (192 bytes) --- */
	call_single_data_t         csd __attribute__((__aligned__(64))); /*  0xc0  0x20 */
	struct softnet_data *      rps_ipi_next;         /*  0xe0   0x8 */
	unsigned int               cpu;                  /*  0xe8   0x4 */
	unsigned int               input_queue_tail;     /*  0xec   0x4 */
	struct sk_buff_head        input_pkt_queue;      /*  0xf0  0x18 */

	/* --- cacheline 4 boundary (256 bytes) was 8 bytes ago --- */

	struct napi_struct         backlog __attribute__((__aligned__(8))); /* 0x108 0x1f0 */

Add one ____cacheline_aligned_in_smp to make sure they now are using
a single cache line.

Also, because napi_struct has written fields, make @state its first field.

We want to make sure that cpus adding packets to sd->input_pkt_queue
are not slowing down cpus processing their backlog because of
false sharing.

After this patch new layout is:

	/* --- cacheline 5 boundary (320 bytes) --- */
	long int                   pad[3] __attribute__((__aligned__(64))); /* 0x140  0x18 */
	unsigned int               input_queue_tail;     /* 0x158   0x4 */

	/* XXX 4 bytes hole, try to pack */

	struct sk_buff_head        input_pkt_queue;      /* 0x160  0x18 */
	struct napi_struct         backlog __attribute__((__aligned__(8))); /* 0x178 0x1f0 */

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7f5aad5cc9a1994f95ba9037d3a4af27eef9d5e3..9c1e5042c5e7646c0aa9e8f4e160c78ea27a639a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -377,6 +377,8 @@ struct napi_config {
  * Structure for NAPI scheduling similar to tasklet but with weighting
  */
 struct napi_struct {
+	/* This field should be first or softnet_data.backlog needs tweaks. */
+	unsigned long		state;
 	/* The poll_list must only be managed by the entity which
 	 * changes the state of the NAPI_STATE_SCHED bit.  This means
 	 * whoever atomically sets that bit can add this napi_struct
@@ -385,7 +387,6 @@ struct napi_struct {
 	 */
 	struct list_head	poll_list;
 
-	unsigned long		state;
 	int			weight;
 	u32			defer_hard_irqs_count;
 	int			(*poll)(struct napi_struct *, int);
@@ -3529,9 +3530,17 @@ struct softnet_data {
 	call_single_data_t	csd ____cacheline_aligned_in_smp;
 	struct softnet_data	*rps_ipi_next;
 	unsigned int		cpu;
+
+	/* We force a cacheline alignment from here, to hold together
+	 * input_queue_tail, input_pkt_queue and backlog.state.
+	 * We add holes so that backlog.state is the last field
+	 * of this cache line.
+	 */
+	long			pad[3] ____cacheline_aligned_in_smp;
 	unsigned int		input_queue_tail;
 #endif
 	struct sk_buff_head	input_pkt_queue;
+
 	struct napi_struct	backlog;
 
 	struct numa_drop_counters drop_counters;
-- 
2.51.1.821.gb6fe4d2222-goog


