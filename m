Return-Path: <netdev+bounces-183451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4C0A90B5F
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 20:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB14F17D91C
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F2022370A;
	Wed, 16 Apr 2025 18:34:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68A8223704;
	Wed, 16 Apr 2025 18:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744828444; cv=none; b=COWwWzJVqGZkcGjWpAh8euZp1L+Wn3SgE++djmgrlrGO8dsP+7eKC8lQBNMy7R0wlZGWeF+Uj6oX95HB34B0WoXmtSoYq7osqbFqSj4Pfbtl0nMUbFVkqaMGCdZOaFrVcY3OhwwavzBZJeh7lAWQKaYEbDzOTlG77T/vbW+oCNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744828444; c=relaxed/simple;
	bh=nI4eMCXpXlIIBaVnc9BH396gww79YEtpd2CqFazhQOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cm5AyU1dev2FHuGN+as3vANg/SzD8f+nKFJ3C81t39rLfJ/+fC3cyvg7GUrKpK3+HSBnjRxJW2KPSSuetDhZwQQBHzthgfJSmS6M523JaC/7EPpVIQXj1mgYQhoY5hRjyIZGdhC9GYpV6vEw8cPQ8JahOJtai0IIjdxnElS5FY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e686d39ba2so12876377a12.2;
        Wed, 16 Apr 2025 11:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744828441; x=1745433241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=II34oFPyGmpovKrvCA1FDiNQbtnPbuqRHfz3wqrX0Nc=;
        b=Wzhk9c9Co6t7VC6DCkj3fbdmrG5ARKJByNcn3/bW8zYgG27k/sV0TMFsrQZSHzT6CP
         UQw0bpcpAfP072uBA9T58Ss5rWLg40zZD/PaAsR0ffvo0mEvytjHaAmQE1hbm9jNP3By
         S6J3ZnAdsu7WYvLF/wg8XMOhv89kZPBkHr6kdML2laYIXjtE0uqEjgYREFMduPrPLm8f
         geuj1I4T9wuAPw1qDGRMHP7XMNzPqREO705WiLIg2JDxOnmRLMSWJEjtmeyBJ0Lqi8HP
         gq8sulT1b2xVKF+QFBCJl8AP6yNfpsGkDXZMUoEkoiV/vF0PwlkdPTEl3KrrQulsxXit
         qSJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXhlAgsGZlhiL4YaTCawNdYmZM6vEQE2HzGUTUJuGKIBqr18HXlpaliPv4ZNS8gnUab7+dXL0l@vger.kernel.org, AJvYcCXXofit5MHenpBGZobrSURBakbD5Sly6xa9iMSXeb9Xqr8uzfZeGccCocW6QVtNlr0RvUJH@vger.kernel.org, AJvYcCXlf6RgxeITMbXjl2+XIYfNfHsRwwzaSrm1s4qH21OdWxAkyoUnRNomYbk5EnI3noaN5FqlfjWraNRDKVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXPs7wEX4UKjBO+V5mi/M64FciGJSMWQU7zCXtt0AtD1C8iohc
	zUIFNUbDOzoM67+8j4VmP4PSZhWobpsLTQ1JqQhiwGXdyjhOy6cQ
X-Gm-Gg: ASbGnctYpeUuQe8nEQppTGF4rn1dH3+MM69rKbb1UfoDa3qN43HYXS4yZiFKPL6PJ60
	T+RBVfJcki+dHuXb77VOl3twlEBjIanaWpxGo+eS5gbCqFQP77N+GVNFxs8g5ID+RHGiq6Nm53F
	kq0aUvvINcewLvyH3FuUZeMen/1harWAVk/NBJ06Z+Jc2TEpTJnZHnu0MeXaln8N0blHH6J3xjw
	EovRgDyHRbEerMl4wIZ5UYpwsx/BbISq9v8rcbnKHpt3Y+O20KM2BFc9MNj5L9PIqOa/OFaaLlP
	Y0C/vNcawVOjxKgnNPjcjCs7SvCW90Bw
X-Google-Smtp-Source: AGHT+IGfcWO1OWqg4XBLUSJ9Zwiz91FknHiSYKJiNdaWcjNSyHc4W1J3O1QOnmtZgxqyH2rgmq//xw==
X-Received: by 2002:a05:6402:239c:b0:5f0:9eb3:8e76 with SMTP id 4fb4d7f45d1cf-5f4b76f4db4mr1959270a12.34.1744828440735;
        Wed, 16 Apr 2025 11:34:00 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:70::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36f06c4fcsm9052083a12.47.2025.04.16.11.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 11:34:00 -0700 (PDT)
Date: Wed, 16 Apr 2025 11:33:57 -0700
From: Breno Leitao <leitao@debian.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, aeh@meta.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	edumazet@google.com, jhs@mojatatu.com, kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] Introduce simple hazard pointers for lockdep
Message-ID: <Z//4FUsm1/jbOTP1@gmail.com>
References: <20250414060055.341516-1-boqun.feng@gmail.com>
 <Z/+7LMnQqtV+mnJ+@gmail.com>
 <Z__G_8VNrgUpfpuk@pc636>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z__G_8VNrgUpfpuk@pc636>

Hello Vlad,

On Wed, Apr 16, 2025 at 05:04:31PM +0200, Uladzislau Rezki wrote:
> On Wed, Apr 16, 2025 at 07:14:04AM -0700, Breno Leitao wrote:
> > Hi Boqun,
> > 
> > On Sun, Apr 13, 2025 at 11:00:47PM -0700, Boqun Feng wrote:
> > 
> > > Overall it looks promising to me, but I would like to see how it
> > > performs in the environment of Breno. Also as Paul always reminds me:
> > > buggy code usually run faster, so please take a look in case I'm missing
> > > something ;-) Thanks!
> > 
> > Thanks for the patchset. I've confirmed that the wins are large on my
> > environment, but, at the same magnitute of synchronize_rcu_expedited().
> > 
> > Here are the numbers I got:
> > 
> > 	6.15-rc1 (upstream)
> > 		# time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1234: mq
> > 		real	0m3.986s
> > 		user	0m0.001s
> > 		sys	0m0.093s
> > 
> > 	Your patchset on top of 6.15-rc1
> > 		# time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1234: mq
> > 		real	0m0.072s
> > 		user	0m0.001s
> > 		sys	0m0.070s
> > 
> > 
> > 	My original proposal of using synchronize_rcu_expedited()[1]
> > 		# time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1234: mq
> > 		real	0m0.074s
> > 		user	0m0.001s
> > 		sys	0m0.061s
> > 
> > Link: https://lore.kernel.org/all/20250321-lockdep-v1-1-78b732d195fb@debian.org/ [1]
> > 
> Could you please also do the test of fist scenario with a regular
> synchronize_rcu() but switch to its faster variant:
> 
> echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> 
> and run the test. If you have a time.

Of course, I am more than interesting in this topic. This is what I run:


	# /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq; time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1234: mq
	real	0m4.150s
	user	0m0.001s
	sys	0m0.076s

	[root@host2 ~]# echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
	[root@host2 ~]# /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq; time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1234: mq
	real	0m4.225s
	user	0m0.000s
	sys	0m0.106s

	[root@host2 ~]# cat /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
	1
	[root@host2 ~]# echo 0 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
	[root@host2 ~]# /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq; time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1234: mq
	real	0m4.152s
	user	0m0.001s
	sys	0m0.099s

It seems it made very little difference?

Thanks
--breno

