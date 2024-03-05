Return-Path: <netdev+bounces-77413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C91871A3D
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 11:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12FA4B21388
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 10:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE98A5475D;
	Tue,  5 Mar 2024 10:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVojHPqq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0360C535CF
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 10:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633323; cv=none; b=FLRhZ6+mRwm6ow9lXrgQ2Jo9oVBSHnl4q3lagfn3ZJW9o0QnYDf1vnNiHOd/pEq/mKOosiJRlyHU1pX9ZtH3fZUZp8jVy3cvgfyNdsMz4JpEnLWv7KsLiKpTZWav/XFBsiYYpdM3jWueagMKoL7Dt6q1Mq7KY12Z4OHG3XfK5ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633323; c=relaxed/simple;
	bh=xVjkjJrdue4o88pJcM0fYNarA+Yn9Hy4iBootIYLetg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=euZFWoSnXpb0HYgRsE1StRc5B8XzUI1Kp5FWKLcoiaqNxWYxsIWtFr6g7otB7wuS1coBVuuYNA2iCVp2dBhUpmxuMJNECBD30s/FQfL/5IrhDZpMxYh2sfvTno4F0o65O7Ac2OolB8C2cGdpNbgFP3TgvaEPqwJ3gyx0l2NM9nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AVojHPqq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709633320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QX1DWvxNECoYAFE6VmcgwhOOzXvTsfOse4Qvv+R1j8s=;
	b=AVojHPqqtXDcKSubHntyEWYGjIo/p8ntf8BrKjwqEqXiGUrl9n/8OWxSmCwqYI3Y3HBLSC
	n6mx8kyN2MLBfy8c3cjyFf6rNqrQmE2V5gIR/g36XNu+SUotUzUeMFvXyIJNqDuFO3CNkY
	t6BliOBeu1UvbEh5vUT1eJhNtBWkhLs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-AyTd2MbFPuic8WtPl1jTaw-1; Tue, 05 Mar 2024 05:08:39 -0500
X-MC-Unique: AyTd2MbFPuic8WtPl1jTaw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-412efff3b54so108635e9.1
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 02:08:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709633318; x=1710238118;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QX1DWvxNECoYAFE6VmcgwhOOzXvTsfOse4Qvv+R1j8s=;
        b=QAC1dHdm4dgdhSzAwaOHfGztyPlADyatpbvykdNdkt/XTD7nMoOHAu+5q8B7muUek5
         5PjjDV6Kfd8lrO8WQrn6L9Mv/V+9KoCh+cNldKAtskuAhjWNcQ0esW0oD+F4fp/iVQjX
         sfXE126EZrk0stDVy8/9h9ED2RUaYIULpQhCpHXCP07gVIuvi4WeFNTSCnwf+7FQeFcM
         ONhXoFSArBIioiHWn354zhTP6xhqUgkfvjyYpIrnC9hfwQTS1vlmSnqwUfmt1ksjKYIr
         rnKRkOQcSwBB1ZrXxeU/8vGw/hSTyoYvWIRMqfWrbKg0OtHjcar2bOf67h4wRBNVh+ZB
         2FNw==
X-Forwarded-Encrypted: i=1; AJvYcCWi20++RIcPYbY0wsMRYyidy+ZU27HvtkhflMw+ZbJd+ypkCJ/M6QDKkwrPAbI3nNnbxdbHmNT4B8SDrPuXtVe9j6B/1kn2
X-Gm-Message-State: AOJu0YzoA+niuKN/g5dxlxPBNbCS4sH9MvFaEOsJrDVnNd5kAiNpCx9v
	QY7wDllNvnAOKB7VkPWiXNI04R0195rzoMQ3HLmxq/hCWeXIgxdCG0vKzW26LsHEfRN0z+0Wv0l
	gr/5n65Apx4UR2pb9VyGtD20U+KwVIUwCssd/HL8WfkhfP77J09VWEA==
X-Received: by 2002:a05:600c:3541:b0:412:c6c9:f324 with SMTP id i1-20020a05600c354100b00412c6c9f324mr8842463wmq.3.1709633318133;
        Tue, 05 Mar 2024 02:08:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEv96yAdfAiVSRQBgHs76ys8yuiV6HoCwakJ5tawvAp3vFS69cv/tHZvIl3e5ui2G0pqYS/Xw==
X-Received: by 2002:a05:600c:3541:b0:412:c6c9:f324 with SMTP id i1-20020a05600c354100b00412c6c9f324mr8842446wmq.3.1709633317749;
        Tue, 05 Mar 2024 02:08:37 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-235-19.dyn.eolo.it. [146.241.235.19])
        by smtp.gmail.com with ESMTPSA id u2-20020adfeb42000000b0033b483d1abcsm14470861wrn.53.2024.03.05.02.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 02:08:37 -0800 (PST)
Message-ID: <c37223527d5b6bcf0ffce69c81f16fd0781fa2d6.camel@redhat.com>
Subject: Re: [PATCH v3 net-next 2/4] net: Allow to use SMP threads for
 backlog NAPI.
From: Paolo Abeni <pabeni@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Wander
 Lairson Costa <wander@redhat.com>, Yan Zhai <yan@cloudflare.com>
Date: Tue, 05 Mar 2024 11:08:35 +0100
In-Reply-To: <20240228121000.526645-3-bigeasy@linutronix.de>
References: <20240228121000.526645-1-bigeasy@linutronix.de>
	 <20240228121000.526645-3-bigeasy@linutronix.de>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-28 at 13:05 +0100, Sebastian Andrzej Siewior wrote:
> Backlog NAPI is a per-CPU NAPI struct only (with no device behind it)
> used by drivers which don't do NAPI them self, RPS and parts of the
> stack which need to avoid recursive deadlocks while processing a packet.
>=20
> The non-NAPI driver use the CPU local backlog NAPI. If RPS is enabled
> then a flow for the skb is computed and based on the flow the skb can be
> enqueued on a remote CPU. Scheduling/ raising the softirq (for backlog's
> NAPI) on the remote CPU isn't trivial because the softirq is only
> scheduled on the local CPU and performed after the hardirq is done.
> In order to schedule a softirq on the remote CPU, an IPI is sent to the
> remote CPU which schedules the backlog-NAPI on the then local CPU.
>=20
> On PREEMPT_RT interrupts are force-threaded. The soft interrupts are
> raised within the interrupt thread and processed after the interrupt
> handler completed still within the context of the interrupt thread. The
> softirq is handled in the context where it originated.
>=20
> With force-threaded interrupts enabled, ksoftirqd is woken up if a
> softirq is raised from hardirq context. This is the case if it is raised
> from an IPI. Additionally there is a warning on PREEMPT_RT if the
> softirq is raised from the idle thread.
> This was done for two reasons:
> - With threaded interrupts the processing should happen in thread
>   context (where it originated) and ksoftirqd is the only thread for
>   this context if raised from hardirq. Using the currently running task
>   instead would "punish" a random task.
> - Once ksoftirqd is active it consumes all further softirqs until it
>   stops running. This changed recently and is no longer the case.
>=20
> Instead of keeping the backlog NAPI in ksoftirqd (in force-threaded/
> PREEMPT_RT setups) I am proposing NAPI-threads for backlog.
> The "proper" setup with threaded-NAPI is not doable because the threads
> are not pinned to an individual CPU and can be modified by the user.
> Additionally a dummy network device would have to be assigned. Also
> CPU-hotplug has to be considered if additional CPUs show up.
> All this can be probably done/ solved but the smpboot-threads already
> provide this infrastructure.
>=20
> Sending UDP packets over loopback expects that the packet is processed
> within the call. Delaying it by handing it over to the thread hurts
> performance. It is not beneficial to the outcome if the context switch
> happens immediately after enqueue or after a while to process a few
> packets in a batch.
> There is no need to always use the thread if the backlog NAPI is
> requested on the local CPU. This restores the loopback throuput. The
> performance drops mostly to the same value after enabling RPS on the
> loopback comparing the IPI and the tread result.
>=20
> Create NAPI-threads for backlog if request during boot. The thread runs
> the inner loop from napi_threaded_poll(), the wait part is different. It
> checks for NAPI_STATE_SCHED (the backlog NAPI can not be disabled).
>=20
> The NAPI threads for backlog are optional, it has to be enabled via the b=
oot
> argument "thread_backlog_napi". It is mandatory for PREEMPT_RT to avoid t=
he
> wakeup of ksoftirqd from the IPI.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Does not apply cleanly after commit 1200097fa8f0d, please rebase and
repost. Note that we are pretty close to the net-next PR, this is at
risk for this cycle.

Side note: is not 110% clear to me why the admin should want to enable
the threaded backlog for the non RT case. I read that the main
difference would be some small perf regression, could you clarify?

Thanks!

Paolo


