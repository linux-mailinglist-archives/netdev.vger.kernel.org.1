Return-Path: <netdev+bounces-155986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C80A04869
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 18:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9C7C166E1C
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B08C18DF6E;
	Tue,  7 Jan 2025 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ocSN6NVd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f74.google.com (mail-ua1-f74.google.com [209.85.222.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8651018C924
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736271525; cv=none; b=G7IRFO4vmcbMrpD054VigjpJjjwYHW7PcBVhyUxqD4OHpRXhpNYCQ75MKwi8j4CuJ5H8L0CTxjhbAvDplq4tCTaa8prtnyMrCGEQBTQTFWBBA3XoogTqSPgI2bxpOAoWnIpS/NLw04wwDEVxtYI6hjusROY+U5TVZNWHhpQW11Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736271525; c=relaxed/simple;
	bh=kJN2SbSkvYGInmp4MBJGgCNomp540c6bMOIcV9wYj38=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r9noRe0aCcdVTRaGsA35mCFEt34W7cJfg2rBv6fmCQjXlN7LiPPFiCmqcGIqczOfu6E/2y2QPFqYrmN1m96zZ+KhvWDeNdf7z3HVwxnnwr7cS6KghbAblkYVwxlUPc7x8m4NtCYnMxPlO+itEI7wIRqmogtZS2d8DFD9+WIzxxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ocSN6NVd; arc=none smtp.client-ip=209.85.222.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-ua1-f74.google.com with SMTP id a1e0cc1a2514c-85ca702c67cso14530241.0
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 09:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736271522; x=1736876322; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KD5QT7C2cc1SRoGoZkCYCHl9+3wPP/aOnYKm+wH6DBQ=;
        b=ocSN6NVda/1tX+hShduHUlIJG0nhu1znHnCyEbc1LvCxvOn1ck3DtHjmvG592mgGOh
         UML2twjIEehCGAOkPUghjq8jtj3gbqbLjUY3Coy+/C1KuSzRL1kXUUkendBjrxftzSdw
         SancjfFhses8E0ofI7GU5EZyZgMuaAoiylxTVgNP2IbApJXRL9CP2rA1HEp8kOAzYV4E
         r4wTCwjmAU8VhY8hTC/2KNMvVRg6SbeFdCDLYZ8zZdzIq/7dr9gWvIMfh3aZgg5tlGFB
         9N+HAAerJnvN1Gmz+c3R0mgoQRoLB1eX5h4hROb62/D6mL5r8o+UY6863+PtuqPLjBFY
         OyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736271522; x=1736876322;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KD5QT7C2cc1SRoGoZkCYCHl9+3wPP/aOnYKm+wH6DBQ=;
        b=maBIjUTqMlurjDnmWiLGe/elXFEo+DES+n5OhPHzdraZR+j/Fk96gKycoYmDAzKJb8
         WP+nahu28zI7ooqLLJDQsbTD4OgXAA7IFjDE4JNuPF0dbf825n2ychJXaqzvZcKBeRDY
         lFsYnCXscFD3Ctz28inp1qXa2JM61VYMgYoPXN6HoSjJL3Zf6sVlD/u1k4wqAo97whXK
         QOoMYN7Xm0dGjomA5c/qBsE5DAseH51WzqaHD7SdEw2L5teVMEBOhmwuto0GWp7Ag+LZ
         XK01EHFNvG83eYMacdUh0ajhvH6BrWo+IFmmaYzj0f83P92hVi4Leuqn8DH43dVMuvQP
         JHVQ==
X-Gm-Message-State: AOJu0Yyvz7N3Mk/ZTJJXcgul8ZRrrPsvaKjkLbfso5l/464XgwibolGI
	yjgyng0SsLMJ8LBHs+EkubrX/K3aCVyqpL9XLjwHdwYq3FhKj6MzB2grATX4L3nwB0oIM28ZXvf
	yyba/vx7WUw==
X-Google-Smtp-Source: AGHT+IGfgGUnsWPoMrv3jWYhpqv5ffoBnU+hTXTZ882dS/IFA4XGqCST3arKFaCVkqLBwstnWdFkumZ7dsj9Gw==
X-Received: from vsbbq9.prod.google.com ([2002:a05:6102:5349:b0:4b2:ad82:19b6])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:5088:b0:4b2:9e5d:baf with SMTP id ada2fe7eead31-4b3c1eed846mr3248008137.11.1736271522408;
 Tue, 07 Jan 2025 09:38:42 -0800 (PST)
Date: Tue,  7 Jan 2025 17:38:35 +0000
In-Reply-To: <20250107173838.1130187-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250107173838.1130187-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250107173838.1130187-2-edumazet@google.com>
Subject: [PATCH net-next 1/4] net: no longer assume RTNL is held in flush_all_backlogs()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

flush_all_backlogs() uses per-cpu data to hold its
temporary daya, on the assumption it is called under RTNL
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
index 073f682a9653a212198b12bae17fafe7b46f96e9..9e1eb272e4feaf40dc87defd54d691634e0902e5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5961,8 +5961,6 @@ void netif_receive_skb_list(struct list_head *head)
 }
 EXPORT_SYMBOL(netif_receive_skb_list);
 
-static DEFINE_PER_CPU(struct work_struct, flush_works);
-
 /* Network device is going away, flush any packets still pending */
 static void flush_backlog(struct work_struct *work)
 {
@@ -6019,36 +6017,54 @@ static bool flush_required(int cpu)
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
@@ -12237,12 +12253,13 @@ static int __init net_dev_init(void)
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


