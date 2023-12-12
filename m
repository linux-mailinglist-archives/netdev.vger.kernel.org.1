Return-Path: <netdev+bounces-56549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DC880F552
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 19:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED2F2817C8
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 18:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A0D7E77A;
	Tue, 12 Dec 2023 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x/bDxY5x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rqBOX7U3"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA40D0
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 10:16:23 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702404981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vuaoZ4lMBkxsoPUY8HtPx04W3xi8KgehdLES/V07New=;
	b=x/bDxY5xPdBIf7Cg79rGjO45vZY0JbBbzscoURxAKST0KkpwZDVGtxS1QS0YUv6x3LRobM
	9scTt8/beU6Pix+zsWLOED5NTx6+MeCACaE1wDEIoe1RjXg9jMG9WImdrzJOpV/rSjs0pG
	m2+hT/Ys7qRBvZndaLiqVeyRw6EIt1RLg2YzbCNpS9EltekpQ5gPKXYGJMbAMuUfcsMeL2
	XZhuD9mW3tbCI/YcFKcvXtwXKYCeu3RuScWBNI8jS6CniOJATUNEZUZ8P+3OFy4YwLlDoo
	0Mj/fZvqssqOG/6I2oSIFeRS1oQFf61zNfN9QGqM3XSVJjM+TIMS73iBB3DKbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702404981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vuaoZ4lMBkxsoPUY8HtPx04W3xi8KgehdLES/V07New=;
	b=rqBOX7U3LLFAi2SPwi0RjV2pLP/t8yqfloApcVJncMRRZMiWHBsVNfG9DkqrUOY6RySpO/
	oI7eo308rBuH43AQ==
To: Martin Zaharinov <micron10@gmail.com>
Cc: peterz@infradead.org, netdev <netdev@vger.kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, patchwork-bot+netdevbpf@kernel.org, Jakub Kicinski
 <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>,
 kuba+netdrv@kernel.org, dsahern@gmail.com, Eric Dumazet
 <edumazet@google.com>
Subject: Re: Urgent Bug Report Kernel crash 6.5.2
In-Reply-To: <2B5C19AE-C125-45A3-8C6F-CA6BBC01A6D9@gmail.com>
References: <64CCB695-BA43-48F5-912A-AFD5B9C103A7@gmail.com>
 <CANn89iL9Twf+Rzm9v_dwsH_iG4YkW3fAc2Hnx2jypN_Qf9oojw@mail.gmail.com>
 <D773F198-BCE3-4D43-9C27-2C2CA34062AC@gmail.com>
 <8E92BAA8-0FC6-4D29-BB4D-B6B60047A1D2@gmail.com>
 <5E63894D-913B-416C-B901-F628BB6C00E0@gmail.com> <87lea4qqun.ffs@tglx>
 <2B5C19AE-C125-45A3-8C6F-CA6BBC01A6D9@gmail.com>
Date: Tue, 12 Dec 2023 19:16:21 +0100
Message-ID: <87r0jrp9qi.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Martin!

On Sat, Dec 09 2023 at 01:01, Martin Zaharinov wrote:
>> On 9 Dec 2023, at 0:20, Thomas Gleixner <tglx@linutronix.de> wrote:
>> That's definitely not a RCU problem. It's a simple refcount fail.
>> 
> Is this a problem or only simple fail , and is it possible to catch
> what is a problem and fix this fail.

Underaccounting a reference count is potentially Use After Free.

    if (rcuref_put(ref))
       call_rcu(ref....);

So after the grace period is over @ref will be freed. Depending on the
timing the context which does the extra put() might already operate on a
freed object.

How to catch that, that's a good question. There is no instrumentation
so far for this. Below is a straight forward trace_printk() based
tracking of rcurefs, which should help to narrow down the context.

Btw, how easy is this to reproduce?

Thanks,

        tglx
---
--- a/include/linux/rcuref.h
+++ b/include/linux/rcuref.h
@@ -64,8 +64,10 @@ static inline __must_check bool rcuref_g
 	 * Unconditionally increase the reference count. The saturation and
 	 * dead zones provide enough tolerance for this.
 	 */
-	if (likely(!atomic_add_negative_relaxed(1, &ref->refcnt)))
+	if (likely(!atomic_add_negative_relaxed(1, &ref->refcnt))) {
+		trace_printk("get(FASTPATH): %px\n", ref);
 		return true;
+	}
 
 	/* Handle the cases inside the saturation and dead zones */
 	return rcuref_get_slowpath(ref);
@@ -84,8 +86,10 @@ static __always_inline __must_check bool
 	 * Unconditionally decrease the reference count. The saturation and
 	 * dead zones provide enough tolerance for this.
 	 */
-	if (likely(!atomic_add_negative_release(-1, &ref->refcnt)))
+	if (likely(!atomic_add_negative_release(-1, &ref->refcnt))) {
+		trace_printk("put(FASTPATH): %px\n", ref);
 		return false;
+	}
 
 	/*
 	 * Handle the last reference drop and cases inside the saturation
--- a/lib/rcuref.c
+++ b/lib/rcuref.c
@@ -200,6 +200,7 @@ bool rcuref_get_slowpath(rcuref_t *ref)
 	 */
 	if (cnt >= RCUREF_RELEASED) {
 		atomic_set(&ref->refcnt, RCUREF_DEAD);
+		trace_printk("get(DEAD): %px %pS\n", ref, __builtin_return_address(0));
 		return false;
 	}
 
@@ -211,8 +212,15 @@ bool rcuref_get_slowpath(rcuref_t *ref)
 	 * object memory, but prevents the obvious reference count overflow
 	 * damage.
 	 */
-	if (WARN_ONCE(cnt > RCUREF_MAXREF, "rcuref saturated - leaking memory"))
+	if (cnt > RCUREF_MAXREF) {
+		trace_printk("get(SATURATED): %px %pS\n", ref, __builtin_return_address(0));
+		WARN_ONCE(1, "rcuref saturated - leaking memory");
 		atomic_set(&ref->refcnt, RCUREF_SATURATED);
+	} else {
+		trace_printk("get(UNDEFINED): %px %pS\n", ref, __builtin_return_address(0));
+		WARN_ON_ONCE(1);
+	}
+
 	return true;
 }
 EXPORT_SYMBOL_GPL(rcuref_get_slowpath);
@@ -248,9 +256,12 @@ bool rcuref_put_slowpath(rcuref_t *ref)
 		 * require a retry. If this fails the caller is not
 		 * allowed to deconstruct the object.
 		 */
-		if (!atomic_try_cmpxchg_release(&ref->refcnt, &cnt, RCUREF_DEAD))
+		if (!atomic_try_cmpxchg_release(&ref->refcnt, &cnt, RCUREF_DEAD)) {
+			trace_printk("put(NOTDEAD): %px %pS\n", ref, __builtin_return_address(0));
 			return false;
+		}
 
+		trace_printk("put(NOWDEAD): %px %pS\n", ref, __builtin_return_address(0));
 		/*
 		 * The caller can safely schedule the object for
 		 * deconstruction. Provide acquire ordering.
@@ -264,7 +275,9 @@ bool rcuref_put_slowpath(rcuref_t *ref)
 	 * put() operation is imbalanced. Warn, put the reference count back to
 	 * DEAD and tell the caller to not deconstruct the object.
 	 */
-	if (WARN_ONCE(cnt >= RCUREF_RELEASED, "rcuref - imbalanced put()")) {
+	if (cnt >= RCUREF_RELEASED) {
+		trace_printk("put(WASDEAD): %px %pS\n", ref, __builtin_return_address(0));
+		WARN_ONCE(1, "rcuref - imbalanced put()");
 		atomic_set(&ref->refcnt, RCUREF_DEAD);
 		return false;
 	}
@@ -274,8 +287,13 @@ bool rcuref_put_slowpath(rcuref_t *ref)
 	 * mean saturation value and tell the caller to not deconstruct the
 	 * object.
 	 */
-	if (cnt > RCUREF_MAXREF)
+	if (cnt > RCUREF_MAXREF) {
+		trace_printk("put(SATURATED): %px %pS\n", ref, __builtin_return_address(0));
 		atomic_set(&ref->refcnt, RCUREF_SATURATED);
+	} else {
+		trace_printk("put(UNDEFINED): %px %pS\n", ref, __builtin_return_address(0));
+		WARN_ON_ONCE(1);
+	}
 	return false;
 }
 EXPORT_SYMBOL_GPL(rcuref_put_slowpath);


