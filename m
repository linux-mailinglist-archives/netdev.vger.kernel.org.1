Return-Path: <netdev+bounces-156328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 945E1A061B7
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78BC0166018
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F581F9AB6;
	Wed,  8 Jan 2025 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lhyt5iYv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4448D1F9439
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736353382; cv=none; b=q9ejW+velFIa3y5AfBOROv5UR6jz4nDLUi+EglK92K3aZ6YucVmEV3YtmTUmYKVgJE4vexptfA2b8AQi7X0m1Hi66qRw4tN2U7EtvDktui9q8xMbrkkOhbkrQ6FbYTbZuxUnxbuekXzQafG7COQhxMdlxDMjECeGVB30BXBiCIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736353382; c=relaxed/simple;
	bh=FbDbWtrkeO1zLkrOE6W8TLnoL+pS/UMS4N66Svjvmv4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YB37GhzaeNeIz9x3cXWu6IaXybCj4n+xum7oZPriF2XDhANvWk+p9tBmad6HlZ7oNRQpX6XlxkMeNQA7ml5hfrQfqEaXb5/22RYbtACMH+x+0ZrjzJWiF0/SjvUOUEEnqNT83YniQh0VZ8tKfPrp0xYtmtK74w0JP4wgZxRjcFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lhyt5iYv; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4678b42cbfeso335686031cf.3
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 08:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736353380; x=1736958180; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=24m9Jbnx67pDSoU0/Ox88pWvSYxaM1gsBFAZIN3yQRY=;
        b=Lhyt5iYvo2/hFg/RGjaymGmXJntuYx6UN7+3fIhM9MC6xqTp9Bv5oXCIdJCXnmEx/Z
         lKSj8NyJsFjvX6bgH2uP084ZuoVTvXWlaiw7etMo4XF51cu2I5NaAB9qDLnfTPJd7D99
         kKQ8d0MXmvPvGbBN6/eR5uQtFgCCt7W9JfxbMrQcp7RWqegnH6rLOqcvM/Mhr75kxiTp
         6jjpU2d+PRhJPpAGuHxCg34Kw9OU+ZvMTnegz8kyKdyhmSk2wFlnhO0cAGawJCjhE+eb
         TGD0xzn5dDAZ/QeZllJzXPECc2v5YJEn22MSghw+r23zLQSTDFG+WvBsgYPLRLlJDy7/
         o4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736353380; x=1736958180;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=24m9Jbnx67pDSoU0/Ox88pWvSYxaM1gsBFAZIN3yQRY=;
        b=xCr3FJuSnD6Q4wIJVBDdfAZT2v4kdcyOkc12ifyMyNcBe7C+ajziRTo1Mbb21v+QjA
         YsmLWO3xvhGyoLcnz+tRogN5sCosIrrfZ3qL4YO8ysQmet7MPt/OFb2xchIZfu2FnBH4
         XKHoq6CUVtH+LnzTn3WZFMDyFbWkcE4/8RZ8sg6V8Q+gvo8T09Fzk1EqeMwRO3jIU9WE
         oEyLW1p1LpLijwxs32tGL4t5zxA6U2Ft365a9Cdp2Ze5fYHygm/tJgphm9a1AvEjsn78
         IxRJSHBRV8gZ+rcsaMcoNLobYc179iUrx/RLxXpxgNFBpC5SL8ZRKQ1BdzicHu0bqATA
         jYNg==
X-Gm-Message-State: AOJu0YwyvMLgQvDYkE0bVk/KS8T0vQYqGG9+kvgsVdGXKFNhGR/ZmaUn
	MwP9gio4xp8xAGxpv2VkKeAGmlXjKBmo2J5xnb6UeBDKL1/1hLPNz4WH5JlmzM3GonDka+jK9kZ
	t7a0V5KXKVg==
X-Google-Smtp-Source: AGHT+IGgtcS3+OOOtwHbf1dIGYX5GuC7oeABEuwMJpxaA+3OnOKbtjxnNpAE4nqMZryLJehIRE357/m7MFVNpQ==
X-Received: from qtnd3.prod.google.com ([2002:ac8:51c3:0:b0:467:64d0:3f08])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5793:0:b0:467:70ce:75ea with SMTP id d75a77b69052e-46c7102bfdbmr49580191cf.23.1736353380222;
 Wed, 08 Jan 2025 08:23:00 -0800 (PST)
Date: Wed,  8 Jan 2025 16:22:53 +0000
In-Reply-To: <20250108162255.1306392-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250108162255.1306392-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250108162255.1306392-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/4] net: no longer assume RTNL is held in flush_all_backlogs()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

flush_all_backlogs() uses per-cpu and static data to hold its
temporary data, on the assumption it is called under RTNL
protection.

Following patch in the series will break this assumption.

Use instead a dynamically allocated piece of memory.

In the unlikely case the allocation fails,
use a boot-time allocated memory.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 53 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 76ad68b129eed0407686e8696102aeed9a8b30ec..8ff288cf25dceb5856496388f83f409fcb6f8e5d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5978,8 +5978,6 @@ void netif_receive_skb_list(struct list_head *head)
 }
 EXPORT_SYMBOL(netif_receive_skb_list);
 
-static DEFINE_PER_CPU(struct work_struct, flush_works);
-
 /* Network device is going away, flush any packets still pending */
 static void flush_backlog(struct work_struct *work)
 {
@@ -6036,36 +6034,54 @@ static bool flush_required(int cpu)
 	return true;
 }
 
+struct flush_backlogs {
+	cpumask_t		flush_cpus;
+	struct work_struct	w[];
+};
+
+static struct flush_backlogs *flush_backlogs_alloc(void)
+{
+	return kmalloc(struct_size_t(struct flush_backlogs, w, nr_cpu_ids),
+		       GFP_KERNEL);
+}
+
+static struct flush_backlogs *flush_backlogs_fallback;
+static DEFINE_MUTEX(flush_backlogs_mutex);
+
 static void flush_all_backlogs(void)
 {
-	static cpumask_t flush_cpus;
+	struct flush_backlogs *ptr = flush_backlogs_alloc();
 	unsigned int cpu;
 
-	/* since we are under rtnl lock protection we can use static data
-	 * for the cpumask and avoid allocating on stack the possibly
-	 * large mask
-	 */
-	ASSERT_RTNL();
+	if (!ptr) {
+		mutex_lock(&flush_backlogs_mutex);
+		ptr = flush_backlogs_fallback;
+	}
+	cpumask_clear(&ptr->flush_cpus);
 
 	cpus_read_lock();
 
-	cpumask_clear(&flush_cpus);
 	for_each_online_cpu(cpu) {
 		if (flush_required(cpu)) {
-			queue_work_on(cpu, system_highpri_wq,
-				      per_cpu_ptr(&flush_works, cpu));
-			cpumask_set_cpu(cpu, &flush_cpus);
+			INIT_WORK(&ptr->w[cpu], flush_backlog);
+			queue_work_on(cpu, system_highpri_wq, &ptr->w[cpu]);
+			__cpumask_set_cpu(cpu, &ptr->flush_cpus);
 		}
 	}
 
 	/* we can have in flight packet[s] on the cpus we are not flushing,
 	 * synchronize_net() in unregister_netdevice_many() will take care of
-	 * them
+	 * them.
 	 */
-	for_each_cpu(cpu, &flush_cpus)
-		flush_work(per_cpu_ptr(&flush_works, cpu));
+	for_each_cpu(cpu, &ptr->flush_cpus)
+		flush_work(&ptr->w[cpu]);
 
 	cpus_read_unlock();
+
+	if (ptr != flush_backlogs_fallback)
+		kfree(ptr);
+	else
+		mutex_unlock(&flush_backlogs_mutex);
 }
 
 static void net_rps_send_ipi(struct softnet_data *remsd)
@@ -12259,12 +12275,13 @@ static int __init net_dev_init(void)
 	 *	Initialise the packet receive queues.
 	 */
 
+	flush_backlogs_fallback = flush_backlogs_alloc();
+	if (!flush_backlogs_fallback)
+		goto out;
+
 	for_each_possible_cpu(i) {
-		struct work_struct *flush = per_cpu_ptr(&flush_works, i);
 		struct softnet_data *sd = &per_cpu(softnet_data, i);
 
-		INIT_WORK(flush, flush_backlog);
-
 		skb_queue_head_init(&sd->input_pkt_queue);
 		skb_queue_head_init(&sd->process_queue);
 #ifdef CONFIG_XFRM_OFFLOAD
-- 
2.47.1.613.gc27f4b7a9f-goog


