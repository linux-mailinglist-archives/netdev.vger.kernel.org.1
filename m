Return-Path: <netdev+bounces-186918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCA3AA3ED6
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 02:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0C35171693
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 00:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB6D20C485;
	Wed, 30 Apr 2025 00:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="sphgWJH9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D69210185
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 00:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745972170; cv=none; b=R5QslyBXJIZfqhm+YPdlVi3SgeWFODGst6s7Yd4nS1nkwzQU2UJcqI3jTKXzmEykxR+ivXSK276RwDHmxWJ6iWPNNE5gZzGyWmJ4S5J6kEGJXNEvlJjbc7CHSOyAYy77JuJ+X0+0bkNVgSlzjgr1ghqqBlEDrHeJU224W1mar1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745972170; c=relaxed/simple;
	bh=LIC3Qcq+l5eRAB0KsRfbPox02LR0xVIB2SGspCaNTK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=suVpAinumXc/tTA7KCp8H7mNu53USJgqp/fjY+QtKAN3dz8GVmAZseUybQJ5YJk0VCohsZ9TOYpQx0iIJVoNdiEdNtXn7zvfz1MiU/1v4Qwgzpilf+DLQEsQgfoKZgLwgM7Q3m1WGxzer7YEtOBV3UR0rqrVYCpz+xHX/LS+HcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=sphgWJH9; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-736ad42dfd6so5620968b3a.3
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 17:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745972166; x=1746576966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WphI4oNGxm2FNHuq1WIu21YQSXlxi3kjgBxukfVBAbg=;
        b=sphgWJH9XlIGCACI2bw2BwZEllMpyh+b8M+1zMRnx5eSNB8rKAFVuYrzRSOxqLBvx9
         PXKYeyYMGaM2WnbxnEilojo0NySFuBil7z9LRKtGVOxJnScBbvn1MuMQS50ULkqUXZ8L
         Lea2hGn0LpRm5LnAUSRsgrW3uvj4gz83JD4PE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745972166; x=1746576966;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WphI4oNGxm2FNHuq1WIu21YQSXlxi3kjgBxukfVBAbg=;
        b=rv6IFtrzPjgVa+whncqYjJHGxWqhlZEG+LhjzmTxnNs+mE0ZIw1QwIhZ2VqHhLJgSD
         p6v6La1p2LAPFHcJPEBIUgBMe2oqkC6PgAvO15srxFSl/7UQhIFXxcuUtYvLPOj1Pcm1
         ca0uQFUKTuiWELy78soIY7LbJyodtBE2P9mX3bcyGfaNSsNdLo9hI9R+yelN9G/jdydA
         oIxkh40ebzS0A0BqVUxGlsd65PmLFO1bap3g5h2lCEC/FG/GLCztYS614HZLmXIfAbJh
         9pCq2+gdYYZhbq5TjLNIHPCN1irbGv0XGcWtZZP9oqp7bFZyI8CRdROh3Hxur3vS5lEz
         ODfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjiWk4QqT02dffwqEOyfQkgt/0gFf2huhSvlUGvwXILv6b/1MJY8BbACRL1Kec6kBBRmonxtc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ndcal05MJv0/rHdSqwAd5O+mZ00Tf9an5KSbRmjKx/JM4yao
	i2xIJytcx24LHyOz43gl73R2SyIE4gmcNj5sK1k2sXBU9zfZzXSlASCi5sSwiZY=
X-Gm-Gg: ASbGncvJFbfuTFDuyoP7/npndLOyfiBzEbA8wEG9L3QmDce1J0DBTrIP0QQ0fTwbm3U
	650GuRt1Q6AbqTBHeG5CAHsrtIraNE/XLJligzjHwWsT2VLTyloE/sWIQXkuL4hfMETO0uufINz
	ChBN+F173kmUSgsJlw/rD/LUWpTFPgxIPgHrfWRXylVGiHWALTTkDWvgFJ/Gy363GucDDP9cc68
	GE6LfWny6p21k9F1Kv0URHZHI9EUUj1S1dWOosG2YIdpAoX2ZMZF5M8B2m31Lz8fHXiCiNBPl6x
	8vxpzRsb41mpiPhxSTsTeMONaA2+ENF86vvI9C/u8VNo2NgBaSxbPUqlEBjBHTzWdRt22+OK2l4
	A3KNciUBVW0pR
X-Google-Smtp-Source: AGHT+IEuSjI1NM/5Mx0A12zkRI5z3JrcEUzUQ3M+6XiRxdNrMegzWiwxgLBf9kNcsTsof6iOYraakQ==
X-Received: by 2002:a05:6a20:ce47:b0:1f5:8179:4f43 with SMTP id adf61e73a8af0-20a8832cfbfmr1319743637.23.1745972166363;
        Tue, 29 Apr 2025 17:16:06 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-740399202efsm345639b3a.54.2025.04.29.17.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:16:05 -0700 (PDT)
Date: Tue, 29 Apr 2025 17:16:03 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5] Add support to set napi threaded for
 individual napi
Message-ID: <aBFrwyxWzLle6B03@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	netdev@vger.kernel.org
References: <20250423201413.1564527-1-skhawaja@google.com>
 <20250425174251.59d7a45d@kernel.org>
 <aAxFmKo2cmLUmqAJ@LQ3V64L9R2>
 <680cf086aec78_193a062946c@willemb.c.googlers.com.notmuch>
 <aA_FErzTzz9BfDTc@LQ3V64L9R2>
 <20250428113845.543ca2b8@kernel.org>
 <aA_zH52V-5qYku3M@LQ3V64L9R2>
 <20250428153207.03c01f64@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428153207.03c01f64@kernel.org>

On Mon, Apr 28, 2025 at 03:32:07PM -0700, Jakub Kicinski wrote:
> On Mon, 28 Apr 2025 14:29:03 -0700 Joe Damato wrote:
> > On Mon, Apr 28, 2025 at 11:38:45AM -0700, Jakub Kicinski wrote:
> > > On Mon, 28 Apr 2025 11:12:34 -0700 Joe Damato wrote:  
> > > > On Sat, Apr 26, 2025 at 10:41:10AM -0400, Willem de Bruijn wrote:  
> > > > > This also reminds me of /proc/sys/net/ipv4/conf/{all, default, .. }
> > > > > API. Which confuses me to this day.  
> > > 
> > > Indeed. That scheme has the additional burden of not being consistently 
> > > enforced :/ So I'm trying to lay down some rules (in the doc linked
> > > upthread).
> > > 
> > > The concern I have with the write all semantics is what happens when
> > > we delegate the control over a queue / NAPI to some application or
> > > container. Is the expectation that some user space component prevents
> > > the global settings from being re-applied when applications using
> > > dedicated queues / NAPIs are running?  
> > 
> > I think this is a good question and one I spent a lot of time
> > thinking through while hacking on the per-NAPI config stuff.
> > 
> > One argument that came to my mind a few times was that to write to
> > the global path requires admin and one might assume:
> >   - an admin knows what they are doing and why they are doing a
> >     global write
> >   - there could be a case where the admin does really want to reset
> >     every NAPIs setting on the system in one swoop
> > 
> > I suppose you could have the above (an admin override, so to speak)
> > but still delegate queues/NAPIs to apps to configure as they like?
> >  
> > I think the admin override is kinda nice if an app starts doing
> > something weird, but maybe that's too much complexity.
> 
> The way I see it - the traditional permission model doesn't extend 
> in any meaningful way to network settings. All the settings are done 
> by some sort of helper or intermediary which implements its own
> privilege model.

I agree that is how it is today, but maybe we are misunderstanding
each other? In my mind, today, the intermediary is something like a
script that runs a bunch of ethtool commands.

In my mind with the movement of more stuff to core and the existence
of YNL, it seems like the future is an app uses YNL and is able to
configure (for example) an RSS context and ntuple rules to steer
flows to queues it cares about... which in my mind is moving toward
eliminating the intermediary ?
 
> My thinking is more that the "global" settings are basically "system"
> settings. There is a high-perf app running which applied its own
> settings to its own queues. The remaining queues belong to the "system".
> Now if you for some reason want to modify the settings of the "system
> queues" you really don't want to override the app specific settings.

Yea, I see what you are saying, I think.

Can I rephrase it to make sure I'm following?

An app uses YNL to set defer-hard-irqs to 100 for napis 2-4. napis 0
and 1 belong to the "system."

You are saying that writing to the NIC-wide sysfs path for
defer-hard-irqs wouldn't affect napis 0 and 1 because they don't
belong to the system anymore.

Is that right?

If so... I think that's fairly interesting and maybe it implies a
tighter coupling of apps to queues than is possible with the API
that exists today? For example say an app does a bunch of config to
a few NAPIs and then suddenly crashes. I suppose core would need to
"know" about this so it can "release" those queues ?

If I'm following you, I think overall your idea is sensible but
requires more work to get there.

Do you think that the current model of defer-hard-irqs prevents the
model you describe from becoming a thing in the future? I don't
think it does, personally, but then again ... what do I know?

> The weakness in my argument is that you probably really shouldn't mess
> with system level settings on a live system, according to devops.
> But life happens, and visibility is not perfect so somethings you have
> to poke to test a theory..

Agreed on all points in the above.

