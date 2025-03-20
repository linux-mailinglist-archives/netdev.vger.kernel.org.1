Return-Path: <netdev+bounces-176570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE15AA6AD87
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 19:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2688F8A0A8A
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 18:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD882288F9;
	Thu, 20 Mar 2025 18:53:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EB422839A;
	Thu, 20 Mar 2025 18:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496782; cv=none; b=fyx19tLZWh/YMXDrGjEgT34Q05GMSNBOcaw+wSYtH0wVUKX4RQ0/9WDoeW73gfTtnLQoo5xiVXoR0aBCyZplX+Uf3c3p3aXPa3q+Qv+2vg9QCjqzz+dmDGbnvM3AIYFVBR6aBcYQ/TBwDQLhhkQwbsYXFLENp0dlUflyc9aQFEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496782; c=relaxed/simple;
	bh=fhayBrvqU5pLUtHSs0Uxv9FPEhHBbC18H/HpNV0tR5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FL6s6ScQoyV01jM4lb/sJC+jc0T+XzdgZsJ65vCj7Y8HhVI7n7w1IXSAV56TL4NlqYuzlVpkmOiKELG+6ZOEhJM6UAPnm8xSQT9vyC3E5qJeeEgH+yFGAtYs/x6FcjfGg0nJcYvpB9nx3M6oAx+rTfpGH3P9BPETpmOeogCnKMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac2a089fbbdso211003566b.1;
        Thu, 20 Mar 2025 11:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496779; x=1743101579;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k/CXK/lkCmDZhi01vUA4HT1uCVDUJUDuW4LmxwM3DFY=;
        b=KpeOrZFmxj7d5tKjtNtkv6YEYMaCcdOYAToNsWWCz3T/Hwp6YUgVmymMbYBzwGLwFB
         xxovzzmxZEJere9xyPDumE7qr6TBunWJDaGmc0FV6Q1kh0Tkpbk3Fp8wk20rOA+Yr38r
         ATwBAhuBUvl94lP+X46Q+D36iL76qLo8rZKyAfqpGXSguHQEy3WmMd2mJb4xj7ze6fvQ
         Iqh7ncY728ya8mLimCNrRMC/NxUaJWvC5jGymU7k/rkf096TbR1x4iWx77hz7Fhh2PT4
         IhTHOApjJpA58WaIrezJh4J6DQ+pyd5gPiusHIYSNN4VojymZ6t48LR/RLCJAcc70F/O
         DwWw==
X-Forwarded-Encrypted: i=1; AJvYcCUTn85nnxBTZ4iT5AEPBDyLzhoGijJYj/qSmX70r0Kk+xG1uNzrU7Spdoi9OcDoXCKqMhpAAls=@vger.kernel.org, AJvYcCXC0YVWFisNNVpZ1jkt/B1U6rz5VBieFWfa3EhsGa/coElTUnzD3INInLv7Gr/VDwH3yR80@vger.kernel.org
X-Gm-Message-State: AOJu0YxqyETfgJ09Y+qGUMdsopi4/oiV/d5rdgpMKtZaECENZ201OpgX
	R1ar00mUXbdTNHjVeCX1UKpHeP2qNOu0iwI73mUo90LFC+UCazqr
X-Gm-Gg: ASbGncvi4S8wuQFQdwf6/pUe9YxHnbBprfN8g5KOxSrtozAaB1oaaEaHWFqkrGN4N5W
	sLexNhRVzp4OpTsxhlVC5xDROJoWZJ366Ght8x56SXC4pVXJSs5hojYAabZp786Elxo572sB9aa
	tbFKQeBXjzwiwDlfGMpjlmDIWSaBcCXbkVjdokEhWasqSQEmfVOqQYt/PgLmFLBWW6uQ5uldlzh
	x7iPT93sP5AdggxLpad7kpu39VZuVTiZqsZjr405eH6tnH/XaQ5+o4RwC/+lXtzmBGCcNCGu3vr
	/9KL7uwO493YXwwmpL/9cKteDSmbcSPD
X-Google-Smtp-Source: AGHT+IFbFHjUuwCHi8RiKbrvgFcyFPjqJ8tNhOn2kWtMfYhYpv1Omd4h+Ssx4NrmidYBzj4Sj66Jiw==
X-Received: by 2002:a17:906:dc8e:b0:ac1:17fe:c74f with SMTP id a640c23a62f3a-ac3f03c1e7emr51087466b.21.1742496779175;
        Thu, 20 Mar 2025 11:52:59 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efd4d36csm21371066b.170.2025.03.20.11.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:52:58 -0700 (PDT)
Date: Thu, 20 Mar 2025 11:52:56 -0700
From: Breno Leitao <leitao@debian.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, longman@redhat.com,
	bvanassche@acm.org, Eric Dumazet <edumazet@google.com>,
	kuba@kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us,
	kuniyu@amazon.com, rcu@vger.kernel.org, kasan-dev@googlegroups.com,
	netdev@vger.kernel.org
Subject: Re: tc: network egress frozen during qdisc update with debug kernel
Message-ID: <20250320-demonic-marmoset-of-economy-bba7ed@leitao>
References: <20250319-meticulous-succinct-mule-ddabc5@leitao>
 <CANn89iLRePLUiBe7LKYTUsnVAOs832Hk9oM8Fb_wnJubhAZnYA@mail.gmail.com>
 <20250319-sloppy-active-bonobo-f49d8e@leitao>
 <5e0527e8-c92e-4dfb-8dc7-afe909fb2f98@paulmck-laptop>
 <CANn89iKdJfkPrY1rHjzUn5nPbU5Z+VAuW5Le2PraeVuHVQ264g@mail.gmail.com>
 <0e9dbde7-07eb-45f1-a39c-6cf76f9c252f@paulmck-laptop>
 <20250319-truthful-whispering-moth-d308b4@leitao>
 <CAM0EoM=NJEeCcDdJ5kp0e8iyRG1LmvfzvBVpb2Mq5zP+QcvmMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoM=NJEeCcDdJ5kp0e8iyRG1LmvfzvBVpb2Mq5zP+QcvmMg@mail.gmail.com>

Hello Jamal,

On Wed, Mar 19, 2025 at 05:05:08PM -0400, Jamal Hadi Salim wrote:
> On Wed, Mar 19, 2025 at 2:12 PM Breno Leitao <leitao@debian.org> wrote:
> >
> > On Wed, Mar 19, 2025 at 09:05:07AM -0700, Paul E. McKenney wrote:
> >
> > > > I think we should redesign lockdep_unregister_key() to work on a separately
> > > > allocated piece of memory,
> > > > then use kfree_rcu() in it.
> > > >
> > > > Ie not embed a "struct lock_class_key" in the struct Qdisc, but a pointer to
> > > >
> > > > struct ... {
> > > >      struct lock_class_key;
> > > >      struct rcu_head  rcu;
> > > > }
> > >
> > > Works for me!
> >
> > I've tested a different approach, using synchronize_rcu_expedited()
> > instead of synchronize_rcu(), given how critical this function is
> > called, and the command performance improves dramatically.
> >
> > This approach has some IPI penalties, but, it might be quicker to review
> > and get merged, mitigating the network issue.
> >
> > Does it sound a bad approach?
> >
> > Date:   Wed Mar 19 10:23:56 2025 -0700
> >
> >     lockdep: Speed up lockdep_unregister_key() with expedited RCU synchronization
> >
> >     lockdep_unregister_key() is called from critical code paths, including
> >     sections where rtnl_lock() is held. When replacing a qdisc in a network
> >     device, network egress traffic is disabled while __qdisc_destroy() is
> >     called for every queue. This function calls lockdep_unregister_key(),
> >     which was blocked waiting for synchronize_rcu() to complete.
> >
> >     For example, a simple tc command to replace a qdisc could take 13
> >     seconds:
> >
> >       # time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1234: mq
> >         real    0m13.195s
> >         user    0m0.001s
> >         sys     0m2.746s
> >
> 
> Could you please add the "after your change"  output as well?

Sure. I will send the official patch tomorrow, and I will update it with
the information as well.

Thanks
--breno

