Return-Path: <netdev+bounces-170805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2178A49FB7
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 18:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E05F11895894
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 17:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8759C1F09B8;
	Fri, 28 Feb 2025 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f4/Fj+lA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE16C1F09A6
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762221; cv=none; b=TmBR8G+Jl4oX0poBsUEfbmfjCGrVaqe6Rq4789rLInCZWvyFAIuoZf1+QnKrRjl4TaN449Op1yi1G17VXHzI0+RpQus1cUEWmYZPvCLeFeJVI7T1FRI7O4TQtIn+t+xY+Q9J2u7mUWu4xT99Lbtkzh5qk4wfRdX+4yoF4OrdJdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762221; c=relaxed/simple;
	bh=rP2OpEz+UAqHglzOnri3Z0W/UW2I3t2l0gHiBGr0QYI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gwNiJWUS75bHCouRAYyP8teDju8Ym9XFr8Ot0MJJ/6s5WuFjoUJTo+ajSpOlMP1OkG4LQii3r7JvzJvtuQN5hH4DK13ELv4N2tECRXs0jj3k/DFpeuGRcGfaUXIh6OyAVJvuRSeyFEyadpjK+m+uNkUGyM4Z8+RX7t47Lb3mvDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f4/Fj+lA; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fe8c697ec3so5435391a91.1
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 09:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740762219; x=1741367019; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yBae22rC1ZZWAm9wgaOrOy67AIEryr2XvHSDCCw/B3A=;
        b=f4/Fj+lA1M99NVEKHpYIdOYqMDCZzDK4PSG1rKBwbYh6rmM1dUMWyY3HruoSV0XEgw
         BkvVXq36oipTHRHZB5otj1B9eL19R0+Zs9Q0uFTSx4Oy2hFVijlyGu4rU+cFb6mMWEwM
         tgrwoF1ozunEuzC5SASrWUQI4/OwxFdNP1xWxTlcfSRqdh72iKWS8fEdwPT8/KLcr9Rv
         Dpxnx0cLOXCBPc5XUyAFQyns7xoK3MvgpgtmtpRXSY7ZP9LRWr8Qlh3MVEf0Lzt2/YVq
         2WS9A0XttFatI6bSz9gNhb2aXAs27s5s+7Xrizc9Bw9fr3Z+DWgqy3T+2Jo7FUWm4C3K
         NC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740762219; x=1741367019;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yBae22rC1ZZWAm9wgaOrOy67AIEryr2XvHSDCCw/B3A=;
        b=ZQuo5lwpdtoFVUeMPs+yxpY0ze1U+6xj28zYWyDViLAuiQ2/j+NpkVtcH+xvZIMEmH
         pgBjMZhXWS8Rx8xy6JNmHQBNSbKPaJkSMQCwfhLN8BGwZ2UNdrkgA7VPngayvCJd816M
         OQDJiBTDsT8zBdLP56zUGcTTAmZCct2AND/TCg8ESLW00+7kKFv+2isISeeqTYTyN+/u
         te57iHbsoOxcinQxHtJgeudABk1FKdvcwqheprdR/D5TKHoDsE/u1HuE7O6PlpeelTH4
         xetn3uqxdomzQptpgC5VYZg9DrivnvPo3NMeRo8RzDkYa19gQ/D0be/DszaiyEeEy+FL
         JmNA==
X-Forwarded-Encrypted: i=1; AJvYcCUtJFGIqEqSvKxFzWMi8dHoByx0f623nwLlV9n+1iwv0zE3diyhmw/mDjE+FTq3CnzSH4PeFrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2clN6oW7xPy07zDc/lRMX62h3TvsvNogI1+6jT4moYen0V4gN
	xNpRxh8LMqAxVsqWKNy0XPlYuavNW02TaxBcg0JbsU6m827H1KhITa/vvWaeWJ2XvDnZBRrW56q
	5YA==
X-Google-Smtp-Source: AGHT+IHfvWvtYClW4D8XZivqOIxKPdkMKph7B/KmPkdLz5hq7e1uqYxbJLhAYv1E7edLxL02jG9Sop91PHI=
X-Received: from pjbsr16.prod.google.com ([2002:a17:90b:4e90:b0:2fa:2891:e310])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ac6:b0:2f6:e47c:1750
 with SMTP id 98e67ed59e1d1-2feba9325ffmr7047907a91.13.1740762219054; Fri, 28
 Feb 2025 09:03:39 -0800 (PST)
Date: Fri, 28 Feb 2025 09:03:37 -0800
In-Reply-To: <3b1046fb-962c-4c15-9c4e-9356171532a0@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227230631.303431-1-kbusch@meta.com> <CAPpAL=zmMXRLDSqe6cPSHoe51=R5GdY0vLJHHuXLarcFqsUHMQ@mail.gmail.com>
 <Z8HE-Ou-_9dTlGqf@google.com> <Z8HJD3m6YyCPrFMR@google.com>
 <Z8HPENTMF5xZikVd@kbusch-mbp> <Z8HWab5J5O29xsJj@google.com>
 <Z8HYAtCxKD8-tfAP@kbusch-mbp> <3b1046fb-962c-4c15-9c4e-9356171532a0@redhat.com>
Message-ID: <Z8HsaS9r_OkpCGYk@google.com>
Subject: Re: [PATCHv3 0/2]
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, Lei Yang <leiyang@redhat.com>, Keith Busch <kbusch@meta.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 28, 2025, Paolo Bonzini wrote:
> On 2/28/25 16:36, Keith Busch wrote:
> > On Fri, Feb 28, 2025 at 07:29:45AM -0800, Sean Christopherson wrote:
> > > On Fri, Feb 28, 2025, Keith Busch wrote:
> > > > On Fri, Feb 28, 2025 at 06:32:47AM -0800, Sean Christopherson wrote:
> > > > > > @@ -35,10 +35,12 @@ static inline int call_once(struct once *once, int (*cb)(struct once *))
> > > > > >                  return 0;
> > > > > >           guard(mutex)(&once->lock);
> > > > > > -        WARN_ON(atomic_read(&once->state) == ONCE_RUNNING);
> > > > > > -        if (atomic_read(&once->state) != ONCE_NOT_STARTED)
> > > > > > +        if (WARN_ON(atomic_read(&once->state) == ONCE_RUNNING))
> > > > > >                   return -EINVAL;
> > > > > > +        if (atomic_read(&once->state) == ONCE_COMPLETED)
> > > > > > +                return 0;
> > > > > > +
> > > > > >           atomic_set(&once->state, ONCE_RUNNING);
> > > > > >          r = cb(once);
> > > > > >          if (r)
> > > > 
> > > > Possible suggestion since it seems odd to do an atomic_read twice on the
> > > > same value.
> > > 
> > > Yeah, good call.  At the risk of getting too cute, how about this?
> > 
> > Sure, that also looks good to me.
> 
> Just to overthink it a bit more, I'm changing "if (r)" to "if (r < 0)". Not
> because it's particularly useful to return a meaningful nonzero value on the
> first initialization, but more because 0+ for success and -errno for failure
> is a more common.
> 
> Queued with this change, thanks.

If it's not too late, the first patch can/should use ERR_CAST() instead of a
PTR_ERR() => ERR_PTR():

	tsk = copy_process(NULL, 0, NUMA_NO_NODE, &args);
	if (IS_ERR(tsk)) {
		kfree(vtsk);
		return ERR_CAST(tsk);
	}

And I was going to get greedy and replace spaces with tabs in call_once.

The changelog for this patch is also misleading.  KVM_RUN doesn't currently return
-ERESTARTNOINTR, it only ever returns -ENOMEN.  copy_process() is what returns
-ERESTARTNOINTR.

I also think it's worth calling out that it's a non-fatal signal.

--
From: Sean Christopherson <seanjc@google.com>
Date: Thu, 27 Feb 2025 15:06:31 -0800
Subject: [PATCH] KVM: x86/mmu: Allow retry of nx_huge_page_recovery_thread
 creation

A VMM may send a non-fatal signal to its threads, including vCPU tasks,
at any time, and thus may signal vCPU tasks during KVM_RUN.  If a vCPU
task receives the signal while its trying to spawn the huge page recovery
vhost task, then KVM_RUN will fail due to copy_process() returning
-ERESTARTNOINTR.

Rework call_once() to mark the call complete if and only if the called
function succeeds, and plumb the function's true error code back to the
call_once() invoker.  This provides userspace with the correct, non-fatal
error code so that the VMM doesn't terminate the VM on -ENOMEM, and allows
subsequent KVM_RUN a succeed by virtue of retrying creation of the NX huge
page task.

Opportunistically replace spaces with tabs in call_once.h.

Fixes: 931656b9e2ff ("kvm: defer huge page recovery vhost task to later")
Co-developed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c    | 10 ++++------
 include/linux/call_once.h | 36 +++++++++++++++++++++---------------
 2 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 70af12b693a3..63bb77ee1bb1 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7633,7 +7633,7 @@ static bool kvm_nx_huge_page_recovery_worker(void *data)
 	return true;
 }
 
-static void kvm_mmu_start_lpage_recovery(struct once *once)
+static int kvm_mmu_start_lpage_recovery(struct once *once)
 {
 	struct kvm_arch *ka = container_of(once, struct kvm_arch, nx_once);
 	struct kvm *kvm = container_of(ka, struct kvm, arch);
@@ -7645,12 +7645,13 @@ static void kvm_mmu_start_lpage_recovery(struct once *once)
 				      kvm, "kvm-nx-lpage-recovery");
 
 	if (IS_ERR(nx_thread))
-		return;
+		return PTR_ERR(nx_thread);
 
 	vhost_task_start(nx_thread);
 
 	/* Make the task visible only once it is fully started. */
 	WRITE_ONCE(kvm->arch.nx_huge_page_recovery_thread, nx_thread);
+	return 0;
 }
 
 int kvm_mmu_post_init_vm(struct kvm *kvm)
@@ -7658,10 +7659,7 @@ int kvm_mmu_post_init_vm(struct kvm *kvm)
 	if (nx_hugepage_mitigation_hard_disabled)
 		return 0;
 
-	call_once(&kvm->arch.nx_once, kvm_mmu_start_lpage_recovery);
-	if (!kvm->arch.nx_huge_page_recovery_thread)
-		return -ENOMEM;
-	return 0;
+	return call_once(&kvm->arch.nx_once, kvm_mmu_start_lpage_recovery);
 }
 
 void kvm_mmu_pre_destroy_vm(struct kvm *kvm)
diff --git a/include/linux/call_once.h b/include/linux/call_once.h
index 6261aa0b3fb0..56cb9625b48b 100644
--- a/include/linux/call_once.h
+++ b/include/linux/call_once.h
@@ -9,15 +9,15 @@
 #define ONCE_COMPLETED   2
 
 struct once {
-        atomic_t state;
-        struct mutex lock;
+	atomic_t state;
+	struct mutex lock;
 };
 
 static inline void __once_init(struct once *once, const char *name,
 			       struct lock_class_key *key)
 {
-        atomic_set(&once->state, ONCE_NOT_STARTED);
-        __mutex_init(&once->lock, name, key);
+	atomic_set(&once->state, ONCE_NOT_STARTED);
+	__mutex_init(&once->lock, name, key);
 }
 
 #define once_init(once)							\
@@ -26,20 +26,26 @@ do {									\
 	__once_init((once), #once, &__key);				\
 } while (0)
 
-static inline void call_once(struct once *once, void (*cb)(struct once *))
+static inline int call_once(struct once *once, int (*cb)(struct once *))
 {
-        /* Pairs with atomic_set_release() below.  */
-        if (atomic_read_acquire(&once->state) == ONCE_COMPLETED)
-                return;
+	int r, state;
 
-        guard(mutex)(&once->lock);
-        WARN_ON(atomic_read(&once->state) == ONCE_RUNNING);
-        if (atomic_read(&once->state) != ONCE_NOT_STARTED)
-                return;
+	/* Pairs with atomic_set_release() below.  */
+	if (atomic_read_acquire(&once->state) == ONCE_COMPLETED)
+		return 0;
 
-        atomic_set(&once->state, ONCE_RUNNING);
-        cb(once);
-        atomic_set_release(&once->state, ONCE_COMPLETED);
+	guard(mutex)(&once->lock);
+	state = atomic_read(&once->state);
+	if (unlikely(state != ONCE_NOT_STARTED))
+		return WARN_ON_ONCE(state != ONCE_COMPLETED) ? -EINVAL : 0;
+
+	atomic_set(&once->state, ONCE_RUNNING);
+	r = cb(once);
+	if (r)
+		atomic_set(&once->state, ONCE_NOT_STARTED);
+	else
+		atomic_set_release(&once->state, ONCE_COMPLETED);
+	return r;
 }
 
 #endif /* _LINUX_CALL_ONCE_H */

base-commit: 7d2322b0472eb402e8a206ba9b332b6c75f6f130
-- 

