Return-Path: <netdev+bounces-216972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F13AB36CB2
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 16:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC818584B49
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 14:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBF23568EF;
	Tue, 26 Aug 2025 14:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bt01Szcx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17A5353360
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219424; cv=none; b=RzScL4DXPThUfhWnmz7CxEZXx53tp/x/Ipj/ECRyjUcI1t3P8P1+1SzpppVWyq+Ibta9cfg7WmQtAfqLZFkOb2ZbZn/0d5j6kcvB+A64lCbIMmTSRpn8g7/Q7OX3WZvb93CtzzPe+WcukzC16XJoRxtVxwGF3on2Y7wjQ135lns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219424; c=relaxed/simple;
	bh=iejrjokTTlPMxHP5sNoP2lTL0M8oxqRZx3MzRd6awPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thnCv6tmpK6dNQo0i+K9xcMv+28aYOb+SVpa0JA88erAS9gMfkpKb1C0o4/ipK83KFCgmFA78arURezYD5RjBGu9nCo7mVBVok3OqewCT3+Z45qH3FVe1NLZu25YSs/eXHpqxw97aJXUX9+OMRBu6E8Rk+xCYTrJ4GBqYPGQUYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bt01Szcx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756219421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xJ+/ApOk9l/Z8tKJCltFO5cRPUS5o4APxC6i4rrECEw=;
	b=bt01SzcxdtvmW4fDa1EWPTBkVUV1zp27TUq4PlkJyPkK5C1XugoRlCr17H8Up58jDTvFkZ
	I9povdrUqCtZZgqI7zN6tkgkqnvjTMmP4mX/TMJvoY8tMrvy8iLWjO6JHIi9f9DsVn6BsP
	jEBu6BYz6VomX5Mswd4P25nZV16iuHA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-TQajvlEWMz2ZeffCwIjijg-1; Tue, 26 Aug 2025 10:43:40 -0400
X-MC-Unique: TQajvlEWMz2ZeffCwIjijg-1
X-Mimecast-MFC-AGG-ID: TQajvlEWMz2ZeffCwIjijg_1756219419
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b51411839so28197545e9.0
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 07:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756219419; x=1756824219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJ+/ApOk9l/Z8tKJCltFO5cRPUS5o4APxC6i4rrECEw=;
        b=tENRevF4/kMnDFnIxWh3C0qQMax/fYLGHTiotwfKS7OQrjQEhFRq0UEwR+pEp5JFbz
         fNEkzoLEmgkW5ul6kWI5/NnpLzw6LSnZUzBrgcEbjErvJa9FglPkKLXDGYIraEdZuK6S
         jSQZZ+kE4rJh70rogojvcdVoWCldEme4rSWspKnwPv/ooR0SHBAiDek7V0z3NGLz5SQw
         Gr3lpm55oKz6g6NOJzKrKx3z0NedkMWDpJteO8bsrstDbVB7qGHXm2j0tl/4ICIshMBW
         0lIsQHOCYwJU30PLI4CsfPvibZP+Qov+ag9B4gZhaI1zSF6Bq+f8s13YV6CC5BWGPbsY
         T1vw==
X-Forwarded-Encrypted: i=1; AJvYcCUnb/pkvQS20Bfb0+fF3ojkmSU1j4cgiAamDqe2d+p0WoaaGQQImgpyRSAd4dT8Nb/NjocXEFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeRjyzLUFLyLDcav3SzkoDYlUV7T613Z0bTzJenLs/HAR/hGaC
	PWmX2sPRsr+MRsJWdZzXK8FyeINwkxIyd1VeJZdfGa1iy5wc4GMi5aF3z90D/d1wd7vmbnq5blX
	UfNSOu9g6PWn4xNnySqIfD6z7WVtJhLbKFbq5iZbdRNuicxQXh8GSy8tXvQ==
X-Gm-Gg: ASbGncs0b6c8xRXRGlH7GCoRArMHPpoa2uTg+g3pp0l3QfEV/n3lo1Ckm9gUuAjCyhs
	+lSvFf9DFmWZiy16VAeZS7eEAo43noPPcwKP6XDgEOjtz9IKw9gKNbcR13QGmjgPLJfm2/MPBAK
	qJYR+uaAYLszbFAp3bz/M45KKxHAoA56eth1mFdret1Uj2nEOr4Uhs+61aGDqaNAuD643CitavO
	MOvu7Yfrb+tmcodQ2ZM7kAR4C/rHR04rpHsq3BcfYFtdSaD9xA72nskf6SqhfMeqD5pnWnVhGjl
	YCnc5HzT7lo8yMN1Mne5CbqdwPy8dRg=
X-Received: by 2002:a05:600c:3541:b0:45b:6705:4fca with SMTP id 5b1f17b1804b1-45b6705509bmr28293585e9.31.1756219419001;
        Tue, 26 Aug 2025 07:43:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWY9QpJGoM3OjbiPyE9H0X8nRAONCQz7DYkRfT2HbxNPUkLPO0HVzLZi7KRCcQCzJR/dzxSA==
X-Received: by 2002:a05:600c:3541:b0:45b:6705:4fca with SMTP id 5b1f17b1804b1-45b6705509bmr28293345e9.31.1756219418542;
        Tue, 26 Aug 2025 07:43:38 -0700 (PDT)
Received: from redhat.com ([185.137.39.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7112129b9sm16542806f8f.34.2025.08.26.07.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 07:43:38 -0700 (PDT)
Date: Tue, 26 Aug 2025 10:43:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/3] vhost_task: KVM: Don't wake KVM x86's recovery
 thread if vhost task was killed
Message-ID: <20250826104310-mutt-send-email-mst@kernel.org>
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

OK so this needs to change to call the __ variant then.


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
> 
> I'm definitely not opposed to that though (or any other naming options).  Sans
> comments, this was my other idea for names:
> 
> 
> static void ____vhost_task_wake(struct vhost_task *vtsk)
> {
> 	wake_up_process(vtsk->task);
> }
> 
> void __vhost_task_wake(struct vhost_task *vtsk)
> {
> 	WARN_ON_ONCE(!vtsk->handle_sigkill);
> 
> 	if (WARN_ON_ONCE(test_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags)))
> 		return;
> 
> 	____vhost_task_wake(vtsk);
> }
> EXPORT_SYMBOL_GPL(__vhost_task_wake);
> 
> void vhost_task_wake(struct vhost_task *vtsk)
> {
> 	guard(mutex)(&vtsk->exit_mutex);
> 
> 	if (WARN_ON_ONCE(test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)))
> 		return;
> 
> 	if (test_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags))
> 		return;
> 
> 	____vhost_task_wake(vtsk);
> }
> EXPORT_SYMBOL_GPL(vhost_task_wake);


