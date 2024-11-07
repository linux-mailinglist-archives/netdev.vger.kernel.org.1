Return-Path: <netdev+bounces-143066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5323E9C10A1
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 22:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B32E1B21A51
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 21:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7144218319;
	Thu,  7 Nov 2024 21:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ZyY1mETy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EA821892D
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 21:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731013311; cv=none; b=PCjaPdKiZchtXgURtylEf6ObcDUc54U6XhLOLUTRApu/YsxvF92EVn8IKcqrysTrvGRn/0/afrjRvo5jkYIpznzx3vXCWEGHh2EOXnFrDLiFRMT8WN3PrKgQPnRH7wuRvYTuEYsyYNEBsfASku6V4Wj+fsPE4+Q3vFNqvDPAsSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731013311; c=relaxed/simple;
	bh=9wRZoynUPM8fbLnLwOFiidjK1OGLqeKZSr/aHXazfQE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrOJVQnEjsDdNRfF0e2ASDvA1uGqZCwpeYw/Ktqx+PxWBp/HCNsm1oA6LGb35ay21v0EZL5NaE6Mt3hKl5ipk6gPGL56PYl1fhPbmzXHgOCGaWVpmj+GNPqAE+jI/7CVHCbx2tO7siQ0Tn56ScTQDurzyl+Kzjigt/X4PCzoNGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ZyY1mETy; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7205b6f51f3so1130972b3a.1
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 13:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731013310; x=1731618110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jmSPwuvTvOYzYpkGsMG6lCTXPjS3Aw5E8puDPwXdxe4=;
        b=ZyY1mETyjAvxJqiL2suDB65VSZqUEJP43qk9fGDJtFt2ycYR24rsxpK4p0L7+wUPSN
         T3gRHD7J/8tSpVh27v7GtzOi6S0ceu3e5hInwDwxUqeHec4JEhXteAZaJzqpzdgLh1q6
         qdqwu84abTKy9a/QxvaRr7no5RLqiK9zgrJ9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731013310; x=1731618110;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jmSPwuvTvOYzYpkGsMG6lCTXPjS3Aw5E8puDPwXdxe4=;
        b=nrUtGGnBj6//epK4qsC8/LMV0WMLWIWCn2lvq4SbWhowfrR/8OF7hg3wxOVZiNJZ8z
         TQTeZPFCkIkNw0IrzCpJo7GH+uPjp6X1vnO867CRi/GAQ8w+6p+FT0qDvSVi83O8TQaH
         FU7hWzgJqK/FVF8S09e1CSAknAL4vkAeq85h5VWiZGxXkMYRnqu8+wgUq7f1QFJx67PH
         nA7asVWGczepfw4El3gbNdGhEi0cHszHiyvEk1W1Y0GnEz3Pon883GPlVMUsztZFALJ1
         OEpwPYIudyBMvKr5BygRFa625wnpvdzXLlgsha22xmHsyfU3oInz534QWXZ+zmwQiAGF
         rFvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpoFpkb3QKuPS/UNtV03BCB5O2HiQ1KNGaeUTpHC6a/Cl4wwbN9MTC6f4GTJcQKzD1s7r4lBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGywZYZOuEHRrRmAMvWXvOq8+anIwqO8RrEQjrO9XkZaW/nTpi
	2+nWGA11z2GdwXD1R1P2w/qV0huE+SHDjZCDGaqFRRv7b2HXVZs3/EJg29elIFU=
X-Google-Smtp-Source: AGHT+IFMJshTG+iNZPsDMxuBGA6V144RXjcvM6NG6XOh9e0fnJCFlEIWwnL5FovwLiBSEfeP4EJpYg==
X-Received: by 2002:a05:6a00:1744:b0:71d:f64d:ec60 with SMTP id d2e1a72fcca58-72413297242mr794945b3a.7.1731013309637;
        Thu, 07 Nov 2024 13:01:49 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078646d2sm2132410b3a.16.2024.11.07.13.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 13:01:49 -0800 (PST)
Date: Thu, 7 Nov 2024 13:01:45 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	corbet@lwn.net, hdanton@sina.com, bagasdotme@gmail.com,
	pabeni@redhat.com, namangulati@google.com, edumazet@google.com,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	sdf@fomichev.me, peter@typeblog.net, m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com, hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v6 2/7] net: Suspend softirq when
 prefer_busy_poll is set
Message-ID: <Zy0quVx01Q02fRQw@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	corbet@lwn.net, hdanton@sina.com, bagasdotme@gmail.com,
	pabeni@redhat.com, namangulati@google.com, edumazet@google.com,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	sdf@fomichev.me, peter@typeblog.net, m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com, hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20241104215542.215919-1-jdamato@fastly.com>
 <20241104215542.215919-3-jdamato@fastly.com>
 <20241105210338.5364375d@kernel.org>
 <ZyuesOyJLI3U0C5e@LQ3V64L9R2>
 <20241106153100.45fbe646@kernel.org>
 <Zywy8PQDljS5r_rX@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zywy8PQDljS5r_rX@LQ3V64L9R2>

On Wed, Nov 06, 2024 at 07:24:32PM -0800, Joe Damato wrote:
> On Wed, Nov 06, 2024 at 03:31:00PM -0800, Jakub Kicinski wrote:
> > On Wed, 6 Nov 2024 08:52:00 -0800 Joe Damato wrote:
> > > On Tue, Nov 05, 2024 at 09:03:38PM -0800, Jakub Kicinski wrote:
> > > > On Mon,  4 Nov 2024 21:55:26 +0000 Joe Damato wrote:  

[...]

> > 0 epoll
> > 1   # ..does its magic..
> > 2   __napi_busy_loop() 
> > 3     # finds a waking packet
> > 4     busy_poll_stop()
> > 5       # arms the timer for long suspend
> > 6   # epoll sees events
> > 7     ep_suspend_napi_irqs()
> > 8       napi_suspend_irqs()
> > 9         # arms for long timer again
> > 
> > The timer we arm here only has to survive from line 5 to line 9,
> > because we will override the timeout on line 9.
> 
> Yes, you are right. Thanks for highlighting and catching this.
> 
> > > The overall point to make is that: the suspend timer is used to
> > > prevent misbehaving userland applications from taking too long. It's
> > > essentially a backstop and, as long as the app is making forward
> > > progress, allows the app to continue running its busy poll loop
> > > undisturbed (via napi_complete_done preventing the driver from
> > > enabling IRQs).
> > > 
> > > Does that make sense?
> > 
> > My mental model put in yet another way is that only epoll knows if it
> > has events, and therefore whether the timeout should be short or long.
> > So the suspend timer should only be applied by epoll.
> 
> Here's what we are thinking, can you let me know if you agree with
> this?
> 
>   - We can drop patch 2 entirely
>   - Update the documentation about IRQ suspension as needed now
>     that patch 2 has been dropped
>   - Leave the rest of the series as is
>   - Re-run our tests to gather sufficient data for the test cases
>     outlined in the cover letter to ensure that the performance
>     numbers hold over several iterations
> 
> Does that seem reasonable for the v7 to you?
> 
> I am asking because generating the amount of data over the number of
> scenarios we are testing takes a long time and I want to make sure
> we are as aligned as we can be before I kick off another run :)

I just noticed this was marked "changes requested". I re-ran the
tests overnight and have the data to confirm results are the same
even after dropping patch 2, which simplifies the code and removes
the double arming of the timer.

I wasn't sure if you were asking for other changes other than
dropping patch 2, but since I have the data I'm going to proceed as
specified in my previous email above:
  - Drop patch 2
  - Update cover letter with new data
  - Send that as v7

Unless you'd like me to hold off for some reason? Or if there was
some other feedback I need to address that I am missing?

