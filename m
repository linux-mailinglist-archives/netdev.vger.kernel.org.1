Return-Path: <netdev+bounces-216956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CF2B36807
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 16:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A250A984AE3
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 14:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398EC352FD2;
	Tue, 26 Aug 2025 14:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dYpDFYMj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1679352FC3
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217019; cv=none; b=dyUdjZMKlShNsQKfjyruUwQHZP6Fkvy8b9Amyk7KB/6zPwOOfL5nKH+j4CFBO9d9IRo0VY5Sg5gpkAypku9vAGA5Bl4QgkLfkxRKf01l1siZHWjxNxl2N1sdCBrH8/Ch/nUU9CvoTun/XHm39Ej7ntdA2VuaZdubvk0GUuFPRSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217019; c=relaxed/simple;
	bh=rjO0Dgpa+MvkB9kGuQaPMB5g0ekLMqstP2ZTtpD2Nsk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YjRfQAs9Zq5SE2rDbPULQp+8RW/jbIwTVAITI7IFT3+BTf+KJ/BmdME/cXn601tznAzHP+oLppdIlB0iHvTHNEhlPOdBFNYWRt/kZqlKp1GC6OY7t6CmLurVlaOel12XqVTILIHn2HPCBsHHQW1+6nfAtiJoG7RvLgvUjyljfL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dYpDFYMj; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-244582bc5e4so70118485ad.2
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 07:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756217016; x=1756821816; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aY0FrXGLxgZ/wGxfA4ovaT2GypQmDVl6QRK8fd0deSc=;
        b=dYpDFYMjq5A4M7IdLrWxOslxljdScIseJH/KmQM2oMg8jfL2soS10kjHsbQpy9NdBS
         pvl/BX9yfZBfv3tJrQER2yhJsx4mG0B8/vacsDgMCmZdIgoIriJPIl7sD98+CQYP+U7u
         TzpMXJhnuvNbOotiHzIaZb9yhA6Lq6bvhlou0PwsW8uxT74El1ZKxyi6xvDPnTyNCCyc
         09WBVrr3BkT2C2sQ99hS9UfbFhYmh6hBhrCTS5HlBv0S+efTDZZHOraer2XkYCXnVG/9
         d38KZ+ujwROvZV/0Js9rPueHfzfWmz1Hv9IEA4/TCIv6/TQUlaL3iB29hz37LmbccjYJ
         89PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756217016; x=1756821816;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aY0FrXGLxgZ/wGxfA4ovaT2GypQmDVl6QRK8fd0deSc=;
        b=pz1wZe+9sybIwa6h0o9aiTpbc7iOu+HcW1TsGYPHSZFYzCz+XILTIpQ2njydqBb69A
         97y7t3Sh4w0yfrtY502lMCHUDcyQ285R8rXbj86XuYxrp5YBR97pzkKz9mANKO7ZiSGv
         /1Ro1/pxdeSodNvA19OIFIyWD52IK5/RmpRJBsUziMSIcx3H9vlTIXV0ejxkA1mOHAMe
         FDEb9/FJy/V4L+u2/piH89PoB7fWhuZU1ZvTYICZWbT7UqBQZaNW9bMNXTlm1Nu/I7fw
         6eNuBRK6NMRAXRbTiYeGEZsUjqEEDqHuGpVSc80l+HsSOsEjRoVh0m+c7jzXVJ4/GgI3
         051w==
X-Forwarded-Encrypted: i=1; AJvYcCWqM2CRMfmxygggw0k2unxt8uxSn5vt07S7cDP7IEr6U9xyqQtlh6hlg8++5d9AAE7lg6MJwp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ+4/TM+nht9QbS4nrtQSR5bgIQD2QeZ/lMsMmGK9OnooS4+kR
	NnSvBsbfoq2h/LT/9ql/SsmRjiicsTzTZz+536ly6jpVFFqzMBgnXDe5cQnicHkC4TjX36LNKoj
	6GYFNiQ==
X-Google-Smtp-Source: AGHT+IGVJFRNMksQGpAlkIJ4vRSKOikAD8qcNdNTZurK//e/TKsMdmUxA10VRE8eqTCLKXiBB2hNPFQ1m8o=
X-Received: from pjbso3.prod.google.com ([2002:a17:90b:1f83:b0:320:e3e2:6877])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db0c:b0:240:10dc:b7c9
 with SMTP id d9443c01a7336-2462ee2ba4dmr144692975ad.9.1756217015845; Tue, 26
 Aug 2025 07:03:35 -0700 (PDT)
Date: Tue, 26 Aug 2025 07:03:33 -0700
In-Reply-To: <20250826034937-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250826004012.3835150-1-seanjc@google.com> <20250826004012.3835150-2-seanjc@google.com>
 <20250826034937-mutt-send-email-mst@kernel.org>
Message-ID: <aK2-tQLL-WN7Mqpb@google.com>
Subject: Re: [PATCH 1/3] vhost_task: KVM: Don't wake KVM x86's recovery thread
 if vhost task was killed
From: Sean Christopherson <seanjc@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 26, 2025, Michael S. Tsirkin wrote:
> On Mon, Aug 25, 2025 at 05:40:09PM -0700, Sean Christopherson wrote:
> > Provide an API in vhost task instead of forcing KVM to solve the problem,
> > as KVM would literally just add an equivalent to VHOST_TASK_FLAGS_KILLED,
> > along with a new lock to protect said flag.  In general, forcing simple
> > usage of vhost task to care about signals _and_ take non-trivial action to
> > do the right thing isn't developer friendly, and is likely to lead to
> > similar bugs in the future.
> > 
> > Debugged-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Link: https://lore.kernel.org/all/aKkLEtoDXKxAAWju@google.com
> > Link: https://lore.kernel.org/all/aJ_vEP2EHj6l0xRT@google.com
> > Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Fixes: d96c77bd4eeb ("KVM: x86: switch hugepage recovery thread to vhost_task")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> OK but I dislike the API.

FWIW, I don't love it either.

> Default APIs should be safe. So vhost_task_wake_safe should be
> vhost_task_wake
> 
> This also reduces the changes to kvm.
> 
> 
> It does not look like we need the "unsafe" variant, so pls drop it.

vhost_vq_work_queue() calls

  vhost_worker_queue()
  |
  -> worker->ops->wakeup(worker)
     |
     -> vhost_task_wakeup()
        |
        -> vhost_task_wake()

while holding RCU and so can't sleep.

	rcu_read_lock();
	worker = rcu_dereference(vq->worker);
	if (worker) {
		queued = true;
		vhost_worker_queue(worker, work);
	}
	rcu_read_unlock();

And the call from __vhost_worker_flush() is done while holding a vhost_worker.mutex.
That's probably ok?  But there are many paths that lead to __vhost_worker_flush(),
which makes it difficult to audit all flows.  So even if there is an easy change
for the RCU conflict, I wouldn't be comfortable adding a mutex_lock() to so many
flows in a patch that needs to go to stable@.

> If we do need it, it should be called __vhost_task_wake.

I initially had that, but didn't like that vhost_task_wake() wouldn't call
__vhost_task_wake(), i.e. wouldn't follow the semi-standard pattern of the
no-underscores function being a wrapper for the double-underscores function.

I'm definitely not opposed to that though (or any other naming options).  Sans
comments, this was my other idea for names:


static void ____vhost_task_wake(struct vhost_task *vtsk)
{
	wake_up_process(vtsk->task);
}

void __vhost_task_wake(struct vhost_task *vtsk)
{
	WARN_ON_ONCE(!vtsk->handle_sigkill);

	if (WARN_ON_ONCE(test_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags)))
		return;

	____vhost_task_wake(vtsk);
}
EXPORT_SYMBOL_GPL(__vhost_task_wake);

void vhost_task_wake(struct vhost_task *vtsk)
{
	guard(mutex)(&vtsk->exit_mutex);

	if (WARN_ON_ONCE(test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags)))
		return;

	if (test_bit(VHOST_TASK_FLAGS_KILLED, &vtsk->flags))
		return;

	____vhost_task_wake(vtsk);
}
EXPORT_SYMBOL_GPL(vhost_task_wake);

