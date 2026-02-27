Return-Path: <netdev+bounces-261995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6O3jJ8gYomnFzAQAu9opvQ
	(envelope-from <netdev+bounces-261995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 23:20:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4D71BEA1E
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 23:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BA5F30AC4FF
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 22:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DDD3C1998;
	Fri, 27 Feb 2026 22:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MTI4OYG7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37A747AF52
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 22:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772230806; cv=none; b=IVkoQT3sL2NHYiUCwb3J1i+TCZnsMw9EvUq33gutfP9SDgC0qNNm6+jK36Rt9fA5qDoLXI3v3ZNR9WV4p9ghRr4tNzNd9I76Ccl+xWVUbC5r3k4vqpTAw7dO3IxAO1Y5rjK2haqwwbaC4xjMWjV4jU2td5xavxJJU6Hqv/7MLIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772230806; c=relaxed/simple;
	bh=sRPJXi4fJv81KLpqK2UcIw4LGWIaFYv98YJo40zBji0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=huDz89u///xuMDj2ROZnIUYboU1JCyiA9jrGg6q0BYfHE1hKBx2loHNTI67wFw+j2aa/DY8ViMclvP0Kwjobukatl09Hio2xpB83E2T5df1ztboW2PAJywZtIgQ4qkt3LzdHpbHqu7ZcrzWT7YAaDtiuPur22i6RmOwK686M15s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zhuyifei.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MTI4OYG7; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zhuyifei.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdc87facf6so2727748eec.1
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 14:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772230804; x=1772835604; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W0cPFKLs4Nx9cX5dBjgJ3mxtaSWri2YWpITL9brXMD0=;
        b=MTI4OYG7jiJeUS0KXhWOa6yLXGEl5p876CZRGkURk/4JciEMADW026Og4B3tpSBesg
         /0OukROU2H5+WvawRiPOH68eP2QFC3k4z0pMUMofaISZV3JhQdQN045Ko68deoVUvpN+
         Qkd0LIFrl8Ux0FzHUVRZvhX1E98AtE5aM7LJ8dh60HE1Q19Jl2R+eJCN22pngkkRt3Io
         /5OJtn3sTTHZHuLAX8iVKPWLvEShcU//Ez9F9lgi91MUvqeCVSZAd2dBDFQ7AeaXvyLT
         Rfw2QSEq6L1z6ZeZiDlGyY4c4ifb97x3zVIn8BlFoOivgU+HItgsLPpn4MZ9Tf1UMAYI
         +eyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772230804; x=1772835604;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W0cPFKLs4Nx9cX5dBjgJ3mxtaSWri2YWpITL9brXMD0=;
        b=J3wG9OZMBUb2JvfFRwjMf/LfqxMajCe17Xf0IeyRuV8BvGSMwJmQKMhVL9iSXvE7Gq
         7IA1YqIol4IdXGmLm0LguA0qZsp6ATSOcyQpiCDfD4D8tAvv7ir5LhhvOY8sdixnfY7+
         RhsUcX9zf1E8+7v+bwHorae5b3MLpY89lvp+Yyvh0zXaXwU+UNzoj6N/zkd9xAlBE7wZ
         s6L9E6CKyvwqkfB3IEcyr5IgluF8n95NCbuLQUr1poLhFbzWSlHNudY6Jv2XCKU25ELr
         K7leE6vCueJ5DjKeJLiVs+4DA85Blydar9T72CD9ARAjgW5DIFF95ZrJUaA9kmL4bUiV
         uUZA==
X-Forwarded-Encrypted: i=1; AJvYcCXkN0s3R6VP3J2j6eGM0XaAON1YJcYnGEk2ilwGu1bIIyLHjqPSoHynstX6AvOTWHP+0bpLsKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi1YYfC7cFpstv2fH7dE8Mz/T8+U2fUTqx77FMpHfslsNJHe6b
	XJhMnjVGzjtpRqm5fiXIQGOwQxOA3OTeqa8MMc4Sy/YiqB0aceiyfx6Ck2NNVc3AJ3L3ekXjTcG
	BK/w9R5VD05njjQ==
X-Received: from dybse9.prod.google.com ([2002:a05:7301:4909:b0:2ba:9e1c:5e99])
 (user=zhuyifei job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:cd90:b0:2b6:af85:dd2d with SMTP id 5a478bee46e88-2bde1d3b4b6mr1717587eec.32.1772230803596;
 Fri, 27 Feb 2026 14:20:03 -0800 (PST)
Date: Fri, 27 Feb 2026 22:19:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260227221937.1060857-1-zhuyifei@google.com>
Subject: [PATCH net] net: Fix rcu_tasks stall in threaded busypoll
From: YiFei Zhu <zhuyifei@google.com>
To: Jakub Kicinski <kuba@kernel.org>, "David S . Miller " <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Samiullah Khawaja <skhawaja@google.com>, netdev@vger.kernel.org
Cc: almasrymina@google.com, willemb@google.com, Joe Damato <joe@dama.to>, 
	YiFei Zhu <zhuyifei@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261995-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhuyifei@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8A4D71BEA1E
X-Rspamd-Action: no action

I was debugging a NIC driver when I noticed that when I enable
threaded busypoll, bpftrace hangs when starting up. dmesg showed:

  rcu_tasks_wait_gp: rcu_tasks grace period number 85 (since boot) is 10658 jiffies old.
  rcu_tasks_wait_gp: rcu_tasks grace period number 85 (since boot) is 40793 jiffies old.
  rcu_tasks_wait_gp: rcu_tasks grace period number 85 (since boot) is 131273 jiffies old.
  rcu_tasks_wait_gp: rcu_tasks grace period number 85 (since boot) is 402058 jiffies old.
  INFO: rcu_tasks detected stalls on tasks:
  00000000769f52cd: .N nvcsw: 2/2 holdout: 1 idle_cpu: -1/64
  task:napi/eth2-8265  state:R  running task     stack:0     pid:48300 tgid:48300 ppid:2      task_flags:0x208040 flags:0x00004000
  Call Trace:
   <TASK>
   ? napi_threaded_poll_loop+0x27c/0x2c0
   ? __pfx_napi_threaded_poll+0x10/0x10
   ? napi_threaded_poll+0x26/0x80
   ? kthread+0xfa/0x240
   ? __pfx_kthread+0x10/0x10
   ? ret_from_fork+0x31/0x50
   ? __pfx_kthread+0x10/0x10
   ? ret_from_fork_asm+0x1a/0x30
   </TASK>

The cause is that in threaded busypoll, the main loop is in
napi_threaded_poll rather than napi_threaded_poll_loop, where the
latter rarely iterates more than once within its loop. For
rcu_softirq_qs_periodic inside napi_threaded_poll_loop to report its
qs state, the last_qs must be 100ms behind, and this can't happen
because napi_threaded_poll_loop rarely iterates in threaded busypoll,
and each time napi_threaded_poll_loop is called last_qs is reset to
latest jiffies.

This patch changes so that in threaded busypoll, last_qs is saved
in the outer napi_threaded_poll, and whether busy_poll_last_qs
is NULL indicates whether napi_threaded_poll_loop is called for
busypoll. This way last_qs would not reset to latest jiffies on
each invocation of napi_threaded_poll_loop.

Fixes: c18d4b190a46 ("net: Extend NAPI threaded polling to allow kthread based busy polling")
Cc: stable@vger.kernel.org
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 net/core/dev.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index c1a9f7fdcffa9..4af4cf2d63a47 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -7794,11 +7794,12 @@ static int napi_thread_wait(struct napi_struct *napi)
 	return -1;
 }
 
-static void napi_threaded_poll_loop(struct napi_struct *napi, bool busy_poll)
+static void napi_threaded_poll_loop(struct napi_struct *napi,
+				    unsigned long *busy_poll_last_qs)
 {
+	unsigned long last_qs = busy_poll_last_qs ? *busy_poll_last_qs : jiffies;
 	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	struct softnet_data *sd;
-	unsigned long last_qs = jiffies;
 
 	for (;;) {
 		bool repoll = false;
@@ -7827,12 +7828,12 @@ static void napi_threaded_poll_loop(struct napi_struct *napi, bool busy_poll)
 		/* When busy poll is enabled, the old packets are not flushed in
 		 * napi_complete_done. So flush them here.
 		 */
-		if (busy_poll)
+		if (busy_poll_last_qs)
 			gro_flush_normal(&napi->gro, HZ >= 1000);
 		local_bh_enable();
 
 		/* Call cond_resched here to avoid watchdog warnings. */
-		if (repoll || busy_poll) {
+		if (repoll || busy_poll_last_qs) {
 			rcu_softirq_qs_periodic(last_qs);
 			cond_resched();
 		}
@@ -7840,11 +7841,15 @@ static void napi_threaded_poll_loop(struct napi_struct *napi, bool busy_poll)
 		if (!repoll)
 			break;
 	}
+
+	if (busy_poll_last_qs)
+		*busy_poll_last_qs = last_qs;
 }
 
 static int napi_threaded_poll(void *data)
 {
 	struct napi_struct *napi = data;
+	unsigned long last_qs = jiffies;
 	bool want_busy_poll;
 	bool in_busy_poll;
 	unsigned long val;
@@ -7862,7 +7867,7 @@ static int napi_threaded_poll(void *data)
 			assign_bit(NAPI_STATE_IN_BUSY_POLL, &napi->state,
 				   want_busy_poll);
 
-		napi_threaded_poll_loop(napi, want_busy_poll);
+		napi_threaded_poll_loop(napi, want_busy_poll ? &last_qs : NULL);
 	}
 
 	return 0;
@@ -13175,7 +13180,7 @@ static void run_backlog_napi(unsigned int cpu)
 {
 	struct softnet_data *sd = per_cpu_ptr(&softnet_data, cpu);
 
-	napi_threaded_poll_loop(&sd->backlog, false);
+	napi_threaded_poll_loop(&sd->backlog, NULL);
 }
 
 static void backlog_napi_setup(unsigned int cpu)
-- 
2.53.0.473.g4a7958ca14-goog


