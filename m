Return-Path: <netdev+bounces-158228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6305BA1128E
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 21:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90A63A183B
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 20:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3615120DD42;
	Tue, 14 Jan 2025 20:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jTWq1smH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8154620C47F
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 20:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736888139; cv=none; b=q4m38cxcwTJm/v0tyVwchijp4k9FSDhw85MupxcTMXOXlFiHYT5+LamT5k16j59bkyqKF628XmXe7/vlZVSZI3Zn/lwHu+bTwWWvzWs8MvldgFNTJtdH987trXlGiozKYlxeQKm5+C1gABdOz2PiUIj6FBJMputr3oUkSoMut+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736888139; c=relaxed/simple;
	bh=kE6Ol122z9shZe0ALiEEiiN0Fxw+ppJCaKhQ7pRqGws=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ert+/GC3UHYr3LYwtpvsPOXDmhyedULK4E7P0qGElPEdfQDu3Ehzgdv+moElCMLQlB4geNtLQ5TaHtFSWhBBp/TOim9YfqQjSSMhEgim/y+B7NbDijo/0SZJoORDDmklnaAmSxAvD2Ndwy6+asE6DiIsPldx2uAyRDBMYPffSeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jTWq1smH; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-46790c5b1a5so148995641cf.2
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 12:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736888136; x=1737492936; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=umZ8c1cXwPdHXyHK5U4mqkUbZzV6gnO5gDr3Vw2yphM=;
        b=jTWq1smH9A8+EY+42EagmYDOpf6LkuwiBoUyNMqFmAC96J0TSfBbmmykcpNjqWHUIT
         tMC7WnzUuSVFLq1pNqS9odADnVCOJLrjEpI20T6WhyQSzF6IiugBoPoZoMSMKtw16Ut6
         BeGY/E8zxs/ezzg0TlJZDbJUeLyZLQYYSVCp24/e2Q7gF1CZxvnHQTt3PEl69mLOeDTO
         tZXHpwjX1IyGUYZKsOeSL15UafivQIEFpwL+GZKDRaXOrultwBtIP2QetkgFpuGM6LlT
         HQLsc7Te/9ouDgaXyRQ80eEYt3lX6Vqi2VLW5Eh5tela8tRdFWnqQPA5eCU9KqaU5qvd
         TWFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736888136; x=1737492936;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=umZ8c1cXwPdHXyHK5U4mqkUbZzV6gnO5gDr3Vw2yphM=;
        b=fEWcIRk/S24N/gRW8XfNVyxvKG/4XOEjqv1KMWnEy/3vj1mVikxf/j6kp+BrOnOpVM
         xuVOrzzrwGZYuq2u5J3LH59ZX/jp8M3TzG0/sHOU86RzsCYdwrJlkIQF9bA8ETL8UCB+
         vetGvVyW/6xvlAkY9lHgF/rWQ9eox+y7RosLXCImEiAJrbvq0dcuv3NrchurrPza4j3K
         K+e+5z04D4YTVleR7xvsm+kgf6B5APz+8nftUQhdxpYjspSmJBOinkaDwK6yfiiF95Cr
         YXAiRMk/1hg/5znlkXmmqCnJjR1PhHuFqD+UMiVU6CTAMoW8mz4uZH9AdpTT1XIjuBTN
         uF4g==
X-Gm-Message-State: AOJu0YwpwL6hCabq+F3XfCehlkk/PdH897D6R2or1jZvJ3TSJ0tiHszc
	qUzJQAAs9iSV1pV2ealWeGlm1+1RASe8rNMEeE2kXyNO1M0TSWu0XSu42mvqUTNYyf2iSpIYFLa
	mPjUHR+WtUQ==
X-Google-Smtp-Source: AGHT+IHZb8FjDrSKYsKTBOOsJGQ/sz3/O9gAwZTKJIFYgaapyiksM3yX466gULZHwF1AewuZiJCajY5B+u0Hew==
X-Received: from qtbbq15.prod.google.com ([2002:a05:622a:1c0f:b0:46c:9f17:12ee])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:58c4:0:b0:467:87f4:a29f with SMTP id d75a77b69052e-46c7108f7acmr412157281cf.45.1736888136441;
 Tue, 14 Jan 2025 12:55:36 -0800 (PST)
Date: Tue, 14 Jan 2025 20:55:28 +0000
In-Reply-To: <20250114205531.967841-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250114205531.967841-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250114205531.967841-3-edumazet@google.com>
Subject: [PATCH v3 net-next 2/5] net: no longer assume RTNL is held in flush_all_backlogs()
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
index 0542346a403c2602f94d8bc61f7be0ea0c64c33a..b0e05e44d771bee2721d054ddbd03166cc676680 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6012,8 +6012,6 @@ void netif_receive_skb_list(struct list_head *head)
 }
 EXPORT_SYMBOL(netif_receive_skb_list);
 
-static DEFINE_PER_CPU(struct work_struct, flush_works);
-
 /* Network device is going away, flush any packets still pending */
 static void flush_backlog(struct work_struct *work)
 {
@@ -6070,36 +6068,54 @@ static bool flush_required(int cpu)
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
@@ -12286,12 +12302,13 @@ static int __init net_dev_init(void)
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
2.48.0.rc2.279.g1de40edade-goog


