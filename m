Return-Path: <netdev+bounces-201150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0653AE847A
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 15:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D78E5A58D0
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316EF262FDB;
	Wed, 25 Jun 2025 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B803vfmd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC48262FD5;
	Wed, 25 Jun 2025 13:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750857690; cv=none; b=R10BihsJ+F08FGRV0/CXD5iZRva7JmMTzUTNZpad3Scr8krP5hfxEIJUt7lMdc8OeQKk2DHWZ8No+YDQAXNPmSo0gN3nUKyBhqJItefdq1m2rxggprrFgp9BS6XAgZjLJeuBlMu5mQ8MWEqc1kRtONJOfalVw7/6Qr9pVpH7Fy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750857690; c=relaxed/simple;
	bh=GAEC5JAbv76V4rnofejgP3gfdLFXFlB4ZYSwW4mIU6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPH/lkcQkT5wFMM/Eo3tU6rzGxDr70n2c3pmCPXCRfG1x9YYJElJwu9D7Z7l2tDBrWwF68Kcyv9jNPwEB4OvAWQI8MEqUorKiEOC0q62CkMAL1ZqCOI85s8NGV0tXjxRhqAvPeWVbNi4fPDSPsXULMN4XQ/GoG7BSFml/vk/yuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B803vfmd; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6face367320so56590246d6.3;
        Wed, 25 Jun 2025 06:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750857687; x=1751462487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fCWPIJ+7Y4/b6HqoL/ZgFJTBhhAZWhRIDbaWoCQ/7s=;
        b=B803vfmdHF82XunEKA2NqZFhCDbsia/7JrFdNCllB9YEpKNf4i4DNxY/8qImtYwDOe
         AjN5MRdRKmDX6wleu62mf3jiOUA65hsPNS+ANm18YoPOXyjZeR9yD1lU6DuUAP0OMeEd
         DKcyWE5Z8wu/0YgNUyDt12FlC+0QJLJj/a2N4SLG2LNz0mq7W1SdHgjy+Irt7/8cLMYN
         YEcNmuRdETyBMinoTl4A9s/E8xFmWZFsU+IHzWeK0YrsPySlovkG9s5oK65Q6DaknGyk
         7kx32CXYp/Tf5b4HtCjCFgpCailHeOkdhU1jexfvxhpjWw1qcMuKjTJ8Ir2KpkjQoJ1H
         kWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750857687; x=1751462487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fCWPIJ+7Y4/b6HqoL/ZgFJTBhhAZWhRIDbaWoCQ/7s=;
        b=CMK9XM8+e/wPqd6pDa8tm51S7ofO05X8DXbZzyapCBvv5Xv2042JdbemaXZQDbF5K2
         zP4TdFxxENLewqLn7kBg8KE5xsKMAAcoQR+hvA/NE5Ke8Ek6rsKe4XTt0T/9xd9hcU35
         MY22YCGWsZZqmLH7+z+jgxex+y+VEo/WpUv9ek9Avcb+vcgVVtLHxAwz4erqnqyMmhRQ
         XZV+SGdtsclXphSQBe+qSpeQJ9qrbkQI26LeznyO/jSCVWw3bxPkARx+Kclg2u4yh0ux
         43nzwjRMpLKjyrFVhgacymwTmL/c0yHjAFmuZQpS6xdO8mQZweSSt01/JsesmUpBXc+A
         9DYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvl32mv7qX13tDB0Oy7a1OOXJGfVFeL7Fz/mQ/YevE3yslopsNJ6tR0+r8478QAJ8Ipl0u8BA=@vger.kernel.org, AJvYcCXBF+sm3I78THlZSK58UlaEADWYyXx1zonPb9bG2z873Naep19AE/+y2/WWb82GYAs6AM2i@vger.kernel.org
X-Gm-Message-State: AOJu0YwhuhQrkyDtZKUsZ9kFty0P7KsqXRpuNquW8BP53a549aINZPLy
	ff/hTDPBKNfo8Q4FhLnFkirv0kJrtpJcg4yXymuINeK/NMQyM+2Pgk12
X-Gm-Gg: ASbGncsPIjjOE2ANd/YEpcHTgSkgBU4rTICn82kbXcm2Dz+pxs/QTqrVmsUxkW3o6te
	N8/3RiumF1S/Bygb4NMI8w3A6ayPsXa2ByF8va7hzJw69CVfhKhuPSxl2jWUT20t5u1MGioPnHb
	+o8aOsLex0xUM3+KGJz++rRY1iZln65e29Ue88u9I3CNI6w7sknyzKHY+NnMcnVLHS5DolxNch1
	+CcPFi3bz+F+2gqukqzqtwRqpp3DV6/6NDcziu8MrKxxtDi51IEU9/RLtfed7p5VEXy23cXMeZf
	YdfMVT+49lM07/jU/hg82fhqo21pyqhYUMfnxROeaM91VzeW8bf9+WtgAZFzs9PKZvKzcrtXJf2
	UCOJPmFQd2IyHZuIPyWiqjInzSGx/mSlUqAgWSWPHa3/kiGQxg07x
X-Google-Smtp-Source: AGHT+IGWa78rZe7hP11kX4tGSZPXXyEeGNZdduIvVkpG6xyitBEuKT+Hmejr8J48TfDfYZ8Uy0jRsw==
X-Received: by 2002:a05:6214:2b8a:b0:6fa:c81a:6231 with SMTP id 6a1803df08f44-6fd5ef59fd6mr50345136d6.8.1750857686686;
        Wed, 25 Jun 2025 06:21:26 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd1af36b87sm49456556d6.66.2025.06.25.06.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 06:21:26 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8EBBBF40066;
	Wed, 25 Jun 2025 09:21:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 25 Jun 2025 09:21:25 -0400
X-ME-Sender: <xms:1fdbaB5JJSJsz-MR0UqTwxfOHGbZE23tusmM0D5MjUvyFrjctf-_ig>
    <xme:1fdbaO4xL70h49HgONRzI7dX153e-82_UMxc-dTh5jkrrrBeoxdr-yopzNbEoLfw0
    XVVvsQcVz07f-30WA>
X-ME-Received: <xmr:1fdbaIduvFZfSSw1ZexJSm2-L-M7sNi0S9VKtREpo7QLWbLHF7Z-FI9Byw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvvdekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepjeegieeuteejveeuuedujeeuvedvffeuteefhfeiheegjeekffehffelkefgheev
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpvghffhhitghiohhsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopedviedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epmhgrthhhihgvuhdruggvshhnohihvghrshesvghffhhitghiohhsrdgtohhmpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprhgtuhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlkhhm
    mheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehpvghtvghriiesihhnfh
    hrrgguvggrugdrohhrghdprhgtphhtthhopehmihhnghhosehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhonhhgmh
    grnhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrvhgvsehsthhgohhlrggsshdr
    nhgvth
X-ME-Proxy: <xmx:1fdbaKLF33RIclEjUCDrWbW5Ob0ps3waTjcMSolhiluoUlZ-yald6A>
    <xmx:1fdbaFJ2cri9a5daaIVhJpOdMz-53HXYqePYRC6mnKwJI0uBCMeJ9w>
    <xmx:1fdbaDypiA_OR5t8vXzVObszVgxCYXi3_t6Pw1ejSvsxRE3hNWBAVg>
    <xmx:1fdbaBKIKePJ-c_tHe1W54d-T7B4mKrmZ295Yva4XLEzF29RnimO1w>
    <xmx:1fdbaIboNx55d3cfPtiNusz-Pa8aTGWMrXUwhuBm_UQ-iddfHdatecWT>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 09:21:25 -0400 (EDT)
Date: Wed, 25 Jun 2025 06:21:24 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, lkmm@lists.linux.dev,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Breno Leitao <leitao@debian.org>,
	aeh@meta.com, netdev@vger.kernel.org, edumazet@google.com,
	jhs@mojatatu.com, kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>
Subject: Re: [PATCH 0/8] Introduce simple hazard pointers for lockdep
Message-ID: <aFv31IIAS0fiYci5@Mac.home>
References: <20250625031101.12555-1-boqun.feng@gmail.com>
 <d9c75e7c-48e2-4398-a830-9d41e7a74cc3@efficios.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9c75e7c-48e2-4398-a830-9d41e7a74cc3@efficios.com>

On Wed, Jun 25, 2025 at 08:25:52AM -0400, Mathieu Desnoyers wrote:
> On 2025-06-24 23:10, Boqun Feng wrote:
> > Hi,
> > 
> > This is the official first version of simple hazard pointers following
> > the RFC:
> > 
> > 	https://lore.kernel.org/lkml/20250414060055.341516-1-boqun.feng@gmail.com/
> > 
> > I rebase it onto v6.16-rc3 and hope to get more feedback this time.
> > 
> > Thanks a lot for Breno Leitao to try the RFC out and share the numbers.
> > 
> > I did an extra comparison this time, between the shazptr solution and
> > the synchronize_rcu_expedited() solution. In my test, during a 100 times
> > "tc qdisc replace" run:
> > 
> > * IPI rate with the shazptr solution: ~14 per second per core.
> > * IPI rate with synchronize_rcu_expedited(): ~140 per second per core.
> > 
> > (IPI results were from the 'CAL' line in /proc/interrupt)
> > 
> > This shows that while both solutions have the similar speedup, shazptr
> > solution avoids the introduce of high IPI rate compared to
> > synchronize_rcu_expedited().
> > 
> > Feedback is welcome and please let know if there is any concern or
> > suggestion. Thanks!
> 
> Hi Boqun,
> 
> What is unclear to me is what is the delta wrt:
> 
> https://lore.kernel.org/lkml/20241008135034.1982519-4-mathieu.desnoyers@efficios.com/
> 

shazptr is more close to the general hazptr I proposed earlier:

	https://lore.kernel.org/lkml/20240917143402.930114-1-boqun.feng@gmail.com/

, it's aimed as a global facility therefore no hazptr_domain is needed,
plus it supports non-busy waiting synchronize_shazptr() at the
beginning.

> and whether this helper against compiler optimizations would still be needed here:
> 
> https://lore.kernel.org/lkml/20241008135034.1982519-2-mathieu.desnoyers@efficios.com/
> 

For the current user, no, but eventually we are going to need it.

Regards,
Boqun

> Thanks,
> 
> Mathieu
> 
> > 
> > Regards,
> > Boqun
> > 
> > --------------------------------------
> > Please find the old performance below:
> > 
> > On my system (a 96-cpu VMs), the results of:
> > 
> > 	time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq
> > 
> > are (with lockdep enabled):
> > 
> > 	(without the patchset)
> > 	real    0m1.039s
> > 	user    0m0.001s
> > 	sys     0m0.069s
> > 
> > 	(with the patchset)
> > 	real    0m0.053s
> > 	user    0m0.000s
> > 	sys     0m0.051s
> > 
> > i.e. almost 20x speed-up.
> > 
> > Other comparisons between RCU and shazptr, the rcuscale results (using
> > default configuration from
> > tools/testing/selftests/rcutorture/bin/kvm.sh):
> > 
> > RCU:
> > 
> > 	Average grace-period duration: 7470.02 microseconds
> > 	Minimum grace-period duration: 3981.6
> > 	50th percentile grace-period duration: 6002.73
> > 	90th percentile grace-period duration: 7008.93
> > 	99th percentile grace-period duration: 10015
> > 	Maximum grace-period duration: 142228
> > 
> > shazptr:
> > 
> > 	Average grace-period duration: 0.845825 microseconds
> > 	Minimum grace-period duration: 0.199
> > 	50th percentile grace-period duration: 0.585
> > 	90th percentile grace-period duration: 1.656
> > 	99th percentile grace-period duration: 3.872
> > 	Maximum grace-period duration: 3049.05
> > 
> > shazptr (skip_synchronize_self_scan=1, i.e. always let scan kthread to
> > wakeup):
> > 
> > 	Average grace-period duration: 467.861 microseconds
> > 	Minimum grace-period duration: 92.913
> > 	50th percentile grace-period duration: 440.691
> > 	90th percentile grace-period duration: 460.623
> > 	99th percentile grace-period duration: 650.068
> > 	Maximum grace-period duration: 5775.46
> > 
> > shazptr_wildcard (i.e. readers always use SHAZPTR_WILDCARD):
> > 
> > 	Average grace-period duration: 599.569 microseconds
> > 	Minimum grace-period duration: 1.432
> > 	50th percentile grace-period duration: 582.631
> > 	90th percentile grace-period duration: 781.704
> > 	99th percentile grace-period duration: 1160.26
> > 	Maximum grace-period duration: 6727.53
> > 
> > shazptr_wildcard (skip_synchronize_self_scan=1):
> > 
> > 	Average grace-period duration: 460.466 microseconds
> > 	Minimum grace-period duration: 303.546
> > 	50th percentile grace-period duration: 424.334
> > 	90th percentile grace-period duration: 482.637
> > 	99th percentile grace-period duration: 600.214
> > 	Maximum grace-period duration: 4126.94
> > 
> > Boqun Feng (8):
> >    Introduce simple hazard pointers
> >    shazptr: Add refscale test
> >    shazptr: Add refscale test for wildcard
> >    shazptr: Avoid synchronize_shaptr() busy waiting
> >    shazptr: Allow skip self scan in synchronize_shaptr()
> >    rcuscale: Allow rcu_scale_ops::get_gp_seq to be NULL
> >    rcuscale: Add tests for simple hazard pointers
> >    locking/lockdep: Use shazptr to protect the key hashlist
> > 
> >   include/linux/shazptr.h  |  73 +++++++++
> >   kernel/locking/Makefile  |   2 +-
> >   kernel/locking/lockdep.c |  11 +-
> >   kernel/locking/shazptr.c | 318 +++++++++++++++++++++++++++++++++++++++
> >   kernel/rcu/rcuscale.c    |  60 +++++++-
> >   kernel/rcu/refscale.c    |  77 ++++++++++
> >   6 files changed, 534 insertions(+), 7 deletions(-)
> >   create mode 100644 include/linux/shazptr.h
> >   create mode 100644 kernel/locking/shazptr.c
> > 
> 
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com

