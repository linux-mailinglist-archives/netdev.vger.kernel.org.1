Return-Path: <netdev+bounces-216968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0736FB36CA4
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 16:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A9CBA071A9
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 14:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD31F353379;
	Tue, 26 Aug 2025 14:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7BsG3yu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EB03375BD
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219260; cv=none; b=PPPq0NTFSUWDHRysb2ojAsUo64vYb49Bsea7jc1JKk0FxS36rNTOQ9/5P79g1vnwQkJE0tiWkncV4MLV61vZaqSBTjErQeDqVEnEeQwUev/+uCLZok0vOl455VcdTI+T7y/yyoQWKHEVdtTK1VZkFYdC//+Wfay+l1bIsj5KGcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219260; c=relaxed/simple;
	bh=UV6QsGJaNRCIjLl6uGJScd++GUZtMzgSHcsM6bVx3c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrcT1z70jTDScypIMij1qOyp/yyArUR444Xg1/FPy9s9dv+qhD7SMxUnrRSLqy9v6UeYsKGsoOUrwqGAEOnIegHg51IrpULV/PtGpSI8FjaY3uEVSE1oKu+3KybX1BglSnsxsKgVlhZBeykRzlYPZ1Z/4dHN1NVaP511T6Ch0D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q7BsG3yu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756219257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1ihfy3FuhJ2wqfa7u6CNmaEum1YBa2rsl3CeJYStFWI=;
	b=Q7BsG3yuOeERvLdZA55b4Rd0RHFvclPJS10RWHCjHFH4L91aqFtlEByHMUiDwnm1lWlC3H
	yJ6se1RbAjLj8cCpGqqGR3+DK9K+SdsACWkByOgiIEh0IL0Vz8pK6HlPEnmWy6V6AZuFmA
	luBAdin6wIO/YapQ9xfOHOpJGlq/N60=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-k52ShtS8PUqc0CS3_hqq2A-1; Tue, 26 Aug 2025 10:40:56 -0400
X-MC-Unique: k52ShtS8PUqc0CS3_hqq2A-1
X-Mimecast-MFC-AGG-ID: k52ShtS8PUqc0CS3_hqq2A_1756219255
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0511b3so33846285e9.1
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 07:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756219254; x=1756824054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ihfy3FuhJ2wqfa7u6CNmaEum1YBa2rsl3CeJYStFWI=;
        b=lugeP0RYZ2b07OdaebPFGX0igTIE51VPyzW7LnTOmdHe5B6YpS5uFfT3bAJk/9WTcB
         p4LWXqhpxCcHhEKTtks/aWJahCmJ9NtrLmvqQ6J3tvVG+1Kzfi4tuory6EQVcaAcjJjJ
         8lgvEWezvvKSe9hzQwKHQrfm8iNJ3ja9z2WOvEJoJp2rQ3JN3OrXvctNJGCDt1j03Nm3
         1OCzJzgMurFPT64pTi/gW0SU36k1RHGXkijhGlwmPu3e3ipN3jyPyAMI/l8gWvVvVc57
         Q22qKuNfhJuaIa0aM1S2uTzkxnQMy2Ppzcuo9btXmaNkNKhQgvvL7LZpWB6f8CJweEKd
         O7nQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2r03onZNCh6I3Nq5q/5Fav6hV9IrLd9jNOYr6ksfzEf2lNL13otBV6kPOTit2sbMDr2rhUnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzazfWHYHkkXCoHuISTAnmD0n8maoIQP0bpvbGlmOdkbOsEtRVA
	O0xeACUa6YRdPCKWzrJC2nzVkELU0XCjnbYLsee+VseU8jPKQmlp6WLKCoBa7JXNPAXF1bNvu5F
	sPMXxMnYMG35L7auHAzrB2dY0/r1kapFcIzCrvOsxztHiwazWcfjMP8pWYodnHTm1mBqLl2s=
X-Gm-Gg: ASbGncs8i45F11lA19wzBAlHxUnuYaic0WBy39/+a5hcAPfB+QcaAOXVK1ynrUztcPJ
	MwTsNAwFcEUicx3lwnqKTi0dyszTHXURAasM2OIau2lHHYGoPaHo4wjfwApecJTYR1zdtOCczw5
	Tle/3ip1/5/3W9RrG4g0FjQYZVQiWnMRiAjcdiiO5LHPtxkg5PB0vb3GyglwNbqKadYNVMOlD9C
	FRdh5YEufpmwfodv+BlNGccdtYWpSeHnOfeme0p5511z8m4KFqInIT9asAn2v6I4nj3+UCJ8c/m
	f+pCg6+Ts6odJrN9Al4CHIcaSKDqtoM=
X-Received: by 2002:a05:600c:5251:b0:455:f380:32e2 with SMTP id 5b1f17b1804b1-45b517ca54cmr149244065e9.18.1756219254604;
        Tue, 26 Aug 2025 07:40:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQn6JvvJeT7MlM5vxv7NDmMYfGEo1DRscOYnhsp0L3inuZrfVRfxK+fMUnsbs9Tx6WF6MBXA==
X-Received: by 2002:a05:600c:5251:b0:455:f380:32e2 with SMTP id 5b1f17b1804b1-45b517ca54cmr149243805e9.18.1756219254143;
        Tue, 26 Aug 2025 07:40:54 -0700 (PDT)
Received: from redhat.com ([185.137.39.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b5df6b356sm112346715e9.0.2025.08.26.07.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 07:40:53 -0700 (PDT)
Date: Tue, 26 Aug 2025 10:40:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/3] vhost_task: KVM: Don't wake KVM x86's recovery
 thread if vhost task was killed
Message-ID: <20250826103625-mutt-send-email-mst@kernel.org>
References: <20250826004012.3835150-1-seanjc@google.com>
 <20250826004012.3835150-2-seanjc@google.com>
 <20250826034937-mutt-send-email-mst@kernel.org>
 <aK2-tQLL-WN7Mqpb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK2-tQLL-WN7Mqpb@google.com>

On Tue, Aug 26, 2025 at 07:03:33AM -0700, Sean Christopherson wrote:
> On Tue, Aug 26, 2025, Michael S. Tsirkin wrote:
> > On Mon, Aug 25, 2025 at 05:40:09PM -0700, Sean Christopherson wrote:
> > > Provide an API in vhost task instead of forcing KVM to solve the problem,
> > > as KVM would literally just add an equivalent to VHOST_TASK_FLAGS_KILLED,
> > > along with a new lock to protect said flag.  In general, forcing simple
> > > usage of vhost task to care about signals _and_ take non-trivial action to
> > > do the right thing isn't developer friendly, and is likely to lead to
> > > similar bugs in the future.
> > > 
> > > Debugged-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > Link: https://lore.kernel.org/all/aKkLEtoDXKxAAWju@google.com
> > > Link: https://lore.kernel.org/all/aJ_vEP2EHj6l0xRT@google.com
> > > Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > Fixes: d96c77bd4eeb ("KVM: x86: switch hugepage recovery thread to vhost_task")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > 
> > OK but I dislike the API.
> 
> FWIW, I don't love it either.
> 
> > Default APIs should be safe. So vhost_task_wake_safe should be
> > vhost_task_wake
> > 
> > This also reduces the changes to kvm.
> > 
> > 
> > It does not look like we need the "unsafe" variant, so pls drop it.
> 
> vhost_vq_work_queue() calls
> 
>   vhost_worker_queue()
>   |
>   -> worker->ops->wakeup(worker)
>      |
>      -> vhost_task_wakeup()
>         |
>         -> vhost_task_wake()
> 
> while holding RCU and so can't sleep.
> 
> 	rcu_read_lock();
> 	worker = rcu_dereference(vq->worker);
> 	if (worker) {
> 		queued = true;
> 		vhost_worker_queue(worker, work);
> 	}
> 	rcu_read_unlock();
> 
> And the call from __vhost_worker_flush() is done while holding a vhost_worker.mutex.
> That's probably ok?  But there are many paths that lead to __vhost_worker_flush(),
> which makes it difficult to audit all flows.  So even if there is an easy change
> for the RCU conflict, I wouldn't be comfortable adding a mutex_lock() to so many
> flows in a patch that needs to go to stable@.
> 
> > If we do need it, it should be called __vhost_task_wake.
> 
> I initially had that, but didn't like that vhost_task_wake() wouldn't call
> __vhost_task_wake(), i.e. wouldn't follow the semi-standard pattern of the
> no-underscores function being a wrapper for the double-underscores function.

Eh. that's not really a standard. the standard is that __ is an unsafe
variant.

> I'm definitely not opposed to that though (or any other naming options).  Sans
> comments, this was my other idea for names:
> 
> 
> static void ____vhost_task_wake(struct vhost_task *vtsk)

That's way too many __. Just vhost_task_wake_up_process will do.

> {
> 	wake_up_process(vtsk->task);
> }



Pls add docs explaining the usage of __vhost_task_wake
and vhost_task_wake respectively.

> void __vhost_task_wake(struct vhost_task *vtsk)
> {
> 	WARN_ON_ONCE(!vtsk->handle_sigkill);
> 
> 	if (WARN_ON_ONCE(test_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags)))
> 		return;

Add comments here please explaining why we warn.

> 	____vhost_task_wake(vtsk);
> }
> EXPORT_SYMBOL_GPL(__vhost_task_wake);



> void vhost_task_wake(struct vhost_task *vtsk)


> {
> 	guard(mutex)(&vtsk->exit_mutex);
> 
> 	if (WARN_ON_ONCE(test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)))

Add comments here please explaining why we warn.

> 		return;
> 
> 	if (test_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags))
> 		return;
> 
> 	____vhost_task_wake(vtsk);
> }
> EXPORT_SYMBOL_GPL(vhost_task_wake);


