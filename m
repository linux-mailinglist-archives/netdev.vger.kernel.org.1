Return-Path: <netdev+bounces-43173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3D17D1A44
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 03:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57B34B214E7
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 01:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1AF658;
	Sat, 21 Oct 2023 01:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86797EA
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 01:23:43 +0000 (UTC)
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2841AD69
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 18:23:41 -0700 (PDT)
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.70.203])
	by sina.com (172.16.235.25) with ESMTP
	id 65332815000002C6; Sat, 21 Oct 2023 09:23:37 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 53730834210857
X-SMAIL-UIID: 96D766E791A64224BF0FE1776099F234-20231021-092337
From: Hillf Danton <hdanton@sina.com>
To: Ivan Babrou <ivan@cloudflare.com>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>,
	kernel-team <kernel-team@cloudflare.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: wait_for_unix_gc can cause CPU overload for well behaved programs
Date: Sat, 21 Oct 2023 09:23:22 +0800
Message-Id: <20231021012322.1799-1-hdanton@sina.com>
In-Reply-To: <CABWYdi0N7uvDex5CdKD60hNQ6UFuqoB=Ss52yQu6UoMJm0MFPw@mail.gmail.com>
References: <CABWYdi1kiu1g1mAq6DpQWczg78tMzaVFnytNMemZATFHqYSqYw@mail.gmail.com> <20231020104728.2060-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 20 Oct 2023 10:25:25 -0700 Ivan Babrou <ivan@cloudflare.com>
> 
> This could solve wait_for_unix_gc spinning, but it wouldn't affect
> unix_gc itself, from what I understand. There would always be one
> socket writer or destroyer punished by running the gc still.

See what you want. The innocents are rescued by kicking a worker off.
Only for thoughts.

--- x/net/unix/garbage.c
+++ y/net/unix/garbage.c
@@ -86,7 +86,6 @@
 /* Internal data structures and random procedures: */
 
 static LIST_HEAD(gc_candidates);
-static DECLARE_WAIT_QUEUE_HEAD(unix_gc_wait);
 
 static void scan_inflight(struct sock *x, void (*func)(struct unix_sock *),
 			  struct sk_buff_head *hitlist)
@@ -185,24 +184,25 @@ static void inc_inflight_move_tail(struc
 		list_move_tail(&u->link, &gc_candidates);
 }
 
-static bool gc_in_progress;
+static void __unix_gc(struct work_struct *w);
+static DECLARE_WORK(unix_gc_work, __unix_gc);
+
 #define UNIX_INFLIGHT_TRIGGER_GC 16000
 
 void wait_for_unix_gc(void)
 {
 	/* If number of inflight sockets is insane,
-	 * force a garbage collect right now.
-	 * Paired with the WRITE_ONCE() in unix_inflight(),
-	 * unix_notinflight() and gc_in_progress().
-	 */
-	if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC &&
-	    !READ_ONCE(gc_in_progress))
-		unix_gc();
-	wait_event(unix_gc_wait, gc_in_progress == false);
+	 * kick a garbage collect right now.
+	 *
+	 * todo s/wait_for_unix_gc/kick_unix_gc/
+	 */
+	if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC /2)
+		queue_work(system_unbound_wq, &unix_gc_work);
 }
 
-/* The external entry point: unix_gc() */
-void unix_gc(void)
+static DEFINE_MUTEX(unix_gc_mutex);
+
+static void __unix_gc(struct work_struct *w)
 {
 	struct sk_buff *next_skb, *skb;
 	struct unix_sock *u;
@@ -211,15 +211,10 @@ void unix_gc(void)
 	struct list_head cursor;
 	LIST_HEAD(not_cycle_list);
 
+	if (!mutex_trylock(&unix_gc_mutex))
+		return;
 	spin_lock(&unix_gc_lock);
 
-	/* Avoid a recursive GC. */
-	if (gc_in_progress)
-		goto out;
-
-	/* Paired with READ_ONCE() in wait_for_unix_gc(). */
-	WRITE_ONCE(gc_in_progress, true);
-
 	/* First, select candidates for garbage collection.  Only
 	 * in-flight sockets are considered, and from those only ones
 	 * which don't have any external reference.
@@ -325,11 +320,12 @@ void unix_gc(void)
 	/* All candidates should have been detached by now. */
 	BUG_ON(!list_empty(&gc_candidates));
 
-	/* Paired with READ_ONCE() in wait_for_unix_gc(). */
-	WRITE_ONCE(gc_in_progress, false);
-
-	wake_up(&unix_gc_wait);
-
- out:
 	spin_unlock(&unix_gc_lock);
+	mutex_unlock(&unix_gc_mutex);
+}
+
+/* The external entry point: unix_gc() */
+void unix_gc(void)
+{
+	__unix_gc(NULL);
 }
--

