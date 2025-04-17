Return-Path: <netdev+bounces-183645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A42A9165B
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 10:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C59467A8477
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 08:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0418622FACA;
	Thu, 17 Apr 2025 08:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSZUFr//"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B5D22F175;
	Thu, 17 Apr 2025 08:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744878148; cv=none; b=fBrSRRfPwMpss0CVflvvEY4zE3XZYfmWtMgdjCNfyLISEctVNNYdP474ljFddib+7t6Elu6dDo8Q9vfJ3DLi+MIPFtI+FcNhr2F04DNvaoysu+CvJy690UJNzRw9el+zK73GLmFh8BEAJcb8uPyyzfyftJdopmpkv6/P5my3Jz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744878148; c=relaxed/simple;
	bh=XaLWudfU75UnKIdaIpmE5WlbFHKJ3Zsed/6soZVriaY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wz25Rzb9t9edfgjYVeuTf16bI+GWqBnpiyctyCFtJfyZCGmQtZ+SsAMREPGRUi1766kGYf62Jw6t07DkEPVRrQ0Sx7hSl1xnYkFGjCoSFumKCVqrIoD5Ca6533TX3CKyo8xa2DTNrmnPR1Hs2x4i7Hyvasps5TgZgGZ12YCPRBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSZUFr//; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3105ef2a06cso4717991fa.2;
        Thu, 17 Apr 2025 01:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744878145; x=1745482945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aOerJZt7N7TJbcdxM6FzsrLlZ/8eU0Fzpj/ouPW/K/M=;
        b=nSZUFr//xjRjiCFB1m3kgEQGZ5s0W0ZMvZsyrMLqPUeeX6py5UERgfxRrSV1aJ1b2f
         3qN8YJuHWxaRq5ePdDo/1YHERrJ0/rI4l5NoEv3XU/UFewJVnURwho41DvYsLSDpHT3X
         fVn0qYGlIBG2q9k3sORbCGuqWweDQQpY+eUzg26lWIPwFzpEkOpi/ltaIJ+tky5PEib3
         PFa7jGVKivdRo3wkTOMiBRhOMdpiw3MacoIKeoNrFBNc7oomEGJqaobZ52r49qwmwcGV
         Gny+gf0cbTSz8wnZ7j9k7WZWkci5DJWAOLn1UtxwsW82EM+2Q2KtuD8T+JNZVy7Mpgyd
         w23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744878145; x=1745482945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOerJZt7N7TJbcdxM6FzsrLlZ/8eU0Fzpj/ouPW/K/M=;
        b=QZA9piolEs5jRJGoCel9xmSFibDdr5IWyZz9zqypkspf0PIUYEyfP9d81HIDDDHWl8
         rJnF3fqj9xWlVmNzo13L9rlZNL0HWYrTisv8BYPsieFT0Kh/YF98fhyMvMj4WN+sGTvT
         qPYAdkKQOioVMkj0bHKTLjolYcQzpZpxTK4lPWh0VsQ/sqkYhkqBYgqOg0RDBJR21+Eg
         TSBf4W39VhanC2qQ4ioK45k60woYb/AxIwIOFQXyhpm3Y6qUtzkhac274HG+DR20dAeS
         M23xhcsrXqyUZ0jigAOA7RoBBQp0Dk7WYOAxTeDNEuixzErvQYZc0ry9ri4XCTMJWtNe
         nuEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6iphJ8FqWj33A4AFrULwTV2tscySjdcj2Yt8x3XA5BwzBSNMt+FHh+9R8Vptot6gmLgXsL0Fu@vger.kernel.org, AJvYcCUB01aTapu2ozHPXyJZxb8ZRSQPaFxD0K8cA+FsEafijyV3LqgKwwAlADHwU5eqf5A3hoGGG5BDhPQztvo=@vger.kernel.org, AJvYcCVmnCT4jeQ47lJEo1F+DJFDeluLOqg1lIGmhu183W4tkbemBtY3oyVkkA4j31cHM55akbfm@vger.kernel.org
X-Gm-Message-State: AOJu0YwksIyVL2TV5mDX9GhNqwG3/OzbqqH8G+7zJSfhVV0Hlm5Xnh1z
	2Yi2VgHM+EBaV6w9qaSto98A2RaxVsSPfOx6LoLUH/CHmfsDrzdC
X-Gm-Gg: ASbGnctnSnpvNGH+5j3acBopga2+JepbLwuvpdb1b0FH62D9f3Jql1s8kA+bIZP47hj
	LutvCa2V3Yt/tfZ79cOdud3ytlq7QLJ33IQD0FD2VAPiCiJ5YzKeBwLO3Eaevj7cGTEKNW8nEjT
	IUpxDGUs2nZFh7moPSYx0gGykGwzV4wEoX3La09ZVjzpqg/QAcnCui2ypW55O4+AYcGfXcVQ2n5
	QwnBa9W+58kVpM09ek7HLM2Ic/0/QGxex+3ZbI7S9YhkCJlTGtyEgyIRmilK+AoWj4a6Ly831YF
	HWaQ4Ps=
X-Google-Smtp-Source: AGHT+IGMLKxq2LO15KmhGtkOiM7gb90wl6nIY0Y+lquxul1vxlYn5GuuUoaTIqIvxIK7OETTr7XVxg==
X-Received: by 2002:a2e:a58e:0:b0:308:df1e:24c4 with SMTP id 38308e7fff4ca-3107f718becmr16592671fa.29.1744878144740;
        Thu, 17 Apr 2025 01:22:24 -0700 (PDT)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f465d4ed2sm27214161fa.86.2025.04.17.01.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 01:22:24 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 17 Apr 2025 10:22:22 +0200
To: Breno Leitao <leitao@debian.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
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
Message-ID: <aAC6PgzV1kOHT2go@pc636>
References: <20250414060055.341516-1-boqun.feng@gmail.com>
 <Z/+7LMnQqtV+mnJ+@gmail.com>
 <Z__G_8VNrgUpfpuk@pc636>
 <Z//4FUsm1/jbOTP1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z//4FUsm1/jbOTP1@gmail.com>

Hello, Breno!

> Hello Vlad,
> 
> On Wed, Apr 16, 2025 at 05:04:31PM +0200, Uladzislau Rezki wrote:
> > On Wed, Apr 16, 2025 at 07:14:04AM -0700, Breno Leitao wrote:
> > > Hi Boqun,
> > > 
> > > On Sun, Apr 13, 2025 at 11:00:47PM -0700, Boqun Feng wrote:
> > > 
> > > > Overall it looks promising to me, but I would like to see how it
> > > > performs in the environment of Breno. Also as Paul always reminds me:
> > > > buggy code usually run faster, so please take a look in case I'm missing
> > > > something ;-) Thanks!
> > > 
> > > Thanks for the patchset. I've confirmed that the wins are large on my
> > > environment, but, at the same magnitute of synchronize_rcu_expedited().
> > > 
> > > Here are the numbers I got:
> > > 
> > > 	6.15-rc1 (upstream)
> > > 		# time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1234: mq
> > > 		real	0m3.986s
> > > 		user	0m0.001s
> > > 		sys	0m0.093s
> > > 
> > > 	Your patchset on top of 6.15-rc1
> > > 		# time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1234: mq
> > > 		real	0m0.072s
> > > 		user	0m0.001s
> > > 		sys	0m0.070s
> > > 
> > > 
> > > 	My original proposal of using synchronize_rcu_expedited()[1]
> > > 		# time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1234: mq
> > > 		real	0m0.074s
> > > 		user	0m0.001s
> > > 		sys	0m0.061s
> > > 
> > > Link: https://lore.kernel.org/all/20250321-lockdep-v1-1-78b732d195fb@debian.org/ [1]
> > > 
> > Could you please also do the test of fist scenario with a regular
> > synchronize_rcu() but switch to its faster variant:
> > 
> > echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> > 
> > and run the test. If you have a time.
> 
> Of course, I am more than interesting in this topic. This is what I run:
> 
> 
> 	# /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq; time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1234: mq
> 	real	0m4.150s
> 	user	0m0.001s
> 	sys	0m0.076s
> 
> 	[root@host2 ~]# echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> 	[root@host2 ~]# /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq; time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1234: mq
> 	real	0m4.225s
> 	user	0m0.000s
> 	sys	0m0.106s
> 
> 	[root@host2 ~]# cat /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> 	1
> 	[root@host2 ~]# echo 0 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
> 	[root@host2 ~]# /usr/sbin/tc qdisc replace dev eth0 root handle 0x1: mq; time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1234: mq
> 	real	0m4.152s
> 	user	0m0.001s
> 	sys	0m0.099s
> 
> It seems it made very little difference?
> 
Yep, no difference. In your case you just need to speed up a grace
period completion. So an expedited version really improves your case.

So you do not have a lot of callbacks which may delay a normal GP.

Thank you!

--
Uladzislau Rezki

