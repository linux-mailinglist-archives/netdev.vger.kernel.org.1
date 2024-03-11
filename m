Return-Path: <netdev+bounces-79239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AEA8785F9
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 18:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F4C1F21677
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 17:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2D54AEC3;
	Mon, 11 Mar 2024 17:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UltoYNgI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4FF487BF
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 17:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710176732; cv=none; b=Sv5DPQi+a2Lzz2PMIksYTzjYWX3M+MdEomL3ficJtBg+F15nZCCZvhQjioCo69zR0NjX78Mobi5AljrLTgFKFZ7EJxzr/8tJcpkG1s0wUCljnO4tZ0XhmFiA6OJ14YbCzPjLfuDjAg2N/hO9rA8ujwGfwtmGqxmOI5mNRtIE1/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710176732; c=relaxed/simple;
	bh=XNwbXKaCLGvCbpxIvSjj9i4O3/8QvDmG0N51zcg49XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lpIH556bu4d/2LnXycmdO+KvHR9/i78AyTfYofqr/v2MbGhIii4pE5P92vAYPhNsWw10akiYrAog2aSW3ahLk1VVBuPusr5ocLMDC4G78T8hpZqmHZLn88N6MfcHyVw/7XQ8e47UTsDDRW9kpCG+UsoOc+MVXarHWLHqO3lMpZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UltoYNgI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710176730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ofx1nXrTDjwWTrrBkspXHarb2XIic0gZXzZbExCDCt4=;
	b=UltoYNgIrkqupEomPKTgHkXVcatmK86S40SZZMdQu3TsLXwxDJ9BLKQWljOS6CGGwegBn0
	Qnw2ZjqpxBzDutQZXXlA8jTNndR0GGGTT5ldbgJxZbJJpTeH70PHXchCLBBXXqmEhS0nAE
	UsCXxSP+32F4WnepNmzbpIuUH0duZnk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-ekpEsRb5O82fucKXHQCQug-1; Mon, 11 Mar 2024 13:05:28 -0400
X-MC-Unique: ekpEsRb5O82fucKXHQCQug-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33e97ba772bso583490f8f.1
        for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 10:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710176727; x=1710781527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofx1nXrTDjwWTrrBkspXHarb2XIic0gZXzZbExCDCt4=;
        b=G9IMEwaMGw0RqraHbC1S6dx2q6tIrWtXaoB9YCSSGlLfFIFhCYng5uUuWqXR5x7qru
         oTf2OgTkeiDsW6UJ/VqxOLfD675lrGbTxsSM7ZBoLQUN89rsWpH/GlIXBTtyNRq6EK8z
         hHLei6SUnsPwU68qQRqKcOYi7AKh2Eta9J9qFlpgq6pzIrtuwbfRcbcjFQPCC6i3hRUQ
         rVIspgImzoNdrHmq+AIV3BcsvdJK4hod2TxaOcYmRTxNGJkaSmbhjqVx6OYg7dorWZZg
         1xuiMPWDc3w3XtRpIPGghYJTzi1LX8f/3LhbQxLQL/97dxr7uksKyHnN6ZY4qF3iBZup
         0ISA==
X-Forwarded-Encrypted: i=1; AJvYcCXgWsuy1MBM0ivA8BhCK2bUGwuc48cJnXxcJSUOkQzeqtcui19tWcJJMrIgJ277l9gr7Hheie3gYczjdkG0QTZCRT1306Ef
X-Gm-Message-State: AOJu0YzlRjo0j3e2pXNWkld5aXowEnSBnocodlXYo79dkgh/NzEEMNHk
	FopJe4NP7Xlx9LQoF/OGaZVJD+m1ylb7YrMrWBOPjEyPz4NVhYLF4Nkh4XerkpF1DfS2Gov+okm
	WBJ4FjJAU+Fma+6h+bKpbHj3vJ8QPZT7T1Lk1vpKnQdgORtMjqBDZiQ==
X-Received: by 2002:a05:6000:230:b0:33e:96b7:af6d with SMTP id l16-20020a056000023000b0033e96b7af6dmr1971475wrz.6.1710176727052;
        Mon, 11 Mar 2024 10:05:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkykAXhh3ZDBHaIBqo4LqQhaHhS1QTgvnZKN/euSPkgltlwWOCucmDgB5XoQsM841Kz8WUQQ==
X-Received: by 2002:a05:6000:230:b0:33e:96b7:af6d with SMTP id l16-20020a056000023000b0033e96b7af6dmr1971451wrz.6.1710176726496;
        Mon, 11 Mar 2024 10:05:26 -0700 (PDT)
Received: from redhat.com ([2.52.134.16])
        by smtp.gmail.com with ESMTPSA id b3-20020a05600003c300b0033e239040d8sm7123545wrg.84.2024.03.11.10.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 10:05:25 -0700 (PDT)
Date: Mon, 11 Mar 2024 13:05:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tobias Huschle <huschle@linux.ibm.com>
Cc: Jason Wang <jasowang@redhat.com>, Abel Wu <wuyun.abel@bytedance.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: Re: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6
 sched/fair: Add lag based placement)
Message-ID: <20240311130446-mutt-send-email-mst@kernel.org>
References: <42870.123121305373200110@us-mta-641.us.mimecast.lan>
 <20231213061719-mutt-send-email-mst@kernel.org>
 <25485.123121307454100283@us-mta-18.us.mimecast.lan>
 <20231213094854-mutt-send-email-mst@kernel.org>
 <20231214021328-mutt-send-email-mst@kernel.org>
 <92916.124010808133201076@us-mta-622.us.mimecast.lan>
 <20240121134311-mutt-send-email-mst@kernel.org>
 <07974.124020102385100135@us-mta-501.us.mimecast.lan>
 <20240201030341-mutt-send-email-mst@kernel.org>
 <89460.124020106474400877@us-mta-475.us.mimecast.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89460.124020106474400877@us-mta-475.us.mimecast.lan>

On Thu, Feb 01, 2024 at 12:47:39PM +0100, Tobias Huschle wrote:
> On Thu, Feb 01, 2024 at 03:08:07AM -0500, Michael S. Tsirkin wrote:
> > On Thu, Feb 01, 2024 at 08:38:43AM +0100, Tobias Huschle wrote:
> > > On Sun, Jan 21, 2024 at 01:44:32PM -0500, Michael S. Tsirkin wrote:
> > > > On Mon, Jan 08, 2024 at 02:13:25PM +0100, Tobias Huschle wrote:
> > > > > On Thu, Dec 14, 2023 at 02:14:59AM -0500, Michael S. Tsirkin wrote:
> > > 
> > > -------- Summary --------
> > > 
> > > In my (non-vhost experience) opinion the way to go would be either
> > > replacing the cond_resched with a hard schedule or setting the
> > > need_resched flag within vhost if the a data transfer was successfully
> > > initiated. It will be necessary to check if this causes problems with
> > > other workloads/benchmarks.
> > 
> > Yes but conceptually I am still in the dark on whether the fact that
> > periodically invoking cond_resched is no longer sufficient to be nice to
> > others is a bug, or intentional.  So you feel it is intentional?
> 
> I would assume that cond_resched is still a valid concept.
> But, in this particular scenario we have the following problem:
> 
> So far (with CFS) we had:
> 1. vhost initiates data transfer
> 2. kworker is woken up
> 3. CFS gives priority to woken up task and schedules it
> 4. kworker runs
> 
> Now (with EEVDF) we have:
> 0. In some cases, kworker has accumulated negative lag 
> 1. vhost initiates data transfer
> 2. kworker is woken up
> -3a. EEVDF does not schedule kworker if it has negative lag
> -4a. vhost continues running, kworker on same CPU starves
> --
> -3b. EEVDF schedules kworker if it has positive or no lag
> -4b. kworker runs
> 
> In the 3a/4a case, the kworker is given no chance to set the
> necessary flag. The flag can only be set by another CPU now.
> The schedule of the kworker was not caused by cond_resched, but
> rather by the wakeup path of the scheduler.
> 
> cond_resched works successfully once the load balancer (I suppose) 
> decides to migrate the vhost off to another CPU. In that case, the
> load balancer on another CPU sets that flag and we are good.
> That then eventually allows the scheduler to pick kworker, but very
> late.

Are we going anywhere with this btw?


> > I propose a two patch series then:
> > 
> > patch 1: in this text in Documentation/kernel-hacking/hacking.rst
> > 
> > If you're doing longer computations: first think userspace. If you
> > **really** want to do it in kernel you should regularly check if you need
> > to give up the CPU (remember there is cooperative multitasking per CPU).
> > Idiom::
> > 
> >     cond_resched(); /* Will sleep */
> > 
> > 
> > replace cond_resched -> schedule
> > 
> > 
> > Since apparently cond_resched is no longer sufficient to
> > make the scheduler check whether you need to give up the CPU.
> > 
> > patch 2: make this change for vhost.
> > 
> > WDYT?
> 
> For patch 1, I would like to see some feedback from Peter (or someone else
> from the scheduler maintainers).
> For patch 2, I would prefer to do some more testing first if this might have
> an negative effect on other benchmarks.
> 
> I also stumbled upon something in the scheduler code that I want to verify.
> Maybe a cgroup thing, will check that out again.
> 
> I'll do some more testing with the cond_resched->schedule fix, check the
> cgroup thing and wait for Peter then.
> Will get back if any of the above yields some results.
> 
> > 
> > -- 
> > MST
> > 
> > 


