Return-Path: <netdev+bounces-178379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBA4A76C97
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 19:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1CE3A922D
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 17:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2563215048;
	Mon, 31 Mar 2025 17:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPo57kSw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F81A1DF270;
	Mon, 31 Mar 2025 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743442486; cv=none; b=VUZ4LplTmLUyJl3wJCnX3rN/72VvtOpC0DyxvEdszAVzEsfPCCqZ5B6qdEJl5xdTC75g5e9zELT4F4d2EKyqKzcZrlJLtxgCNP0SdNKSOzQvYGUz02n/vuWfAVY6VWFB7TohacuLV+emvQx77e/gW2xsLNT7p+uyXpECAtd3o0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743442486; c=relaxed/simple;
	bh=jzKePEk4uquYuArRS4/8PLcdpgOZZAdKidp8QCwLwPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWnJT+9H3A8RlT1agkSFauyhEaQpolTkczKuK6xtdHlbbEjfR5nUkKhAE3QbtzqA46E8ic5n5LxlCQgpMVVyk/QEXRaNKoW8KGmvv54Kt7Nj3QQskrrNeV8cIGdB6tARjNweZF7ZufHTzEOfrUHYI3LHAAJzyjNhJrBYksx9/Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPo57kSw; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e8f7019422so42287056d6.1;
        Mon, 31 Mar 2025 10:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743442484; x=1744047284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96Xul1aEIMZ0QJ9ffF2yw8MUNDfqKokATPYLdCnLNjI=;
        b=aPo57kSwfXot5qEZfa8G4U9zXn148t57f+xrKHvBxuIos1ZF7uqrTQXe9udtVn1DZD
         8dyrXkXPfduKxBejdGfS2jZis5SiKXC2UhFLVt7k5KuUHFOz3rkDIuDMi2TjffapcVZT
         LMDHoLtNlbGVdKKe0CCdvLAzuTeAu7YUoRWnXVXZhilHAJfma8an8dWgraqj1wPY0O5Q
         bvzy1ilTbrUdo11Cg9lGzLGoeEsyhFpW9cTA5ttRBiOfHazvrmOFLCceylLBMHE0jlhc
         di0aB63RIjPe4VIx12WV1LUka92JeM4yRG/A5B03N9Ws8TLP1f14GR/rAeM5sHbJlTxu
         deqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743442484; x=1744047284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96Xul1aEIMZ0QJ9ffF2yw8MUNDfqKokATPYLdCnLNjI=;
        b=r/R+NmqaRh0pbbiEFWzUsOpCLjxptk73Duu65rF6xQybP15ZbsX9XWdtSrjTR02VM8
         T7jdvc/OoszqVkiBndTdkivoMQNGW9AltFXbu47eGm7iKAbn10O8rdtkLUcQMQU0GNrs
         u/IptuovLnzHZTYG1W6xR97JRpRYurugYt31AtP5atafkwvcIbfBKfLhzv8SpgZ+JNv7
         JO/7uzKpwSSJARHAGD718+SCgEukdOqRFYDZLEaIuq8L4WRckqH5Phkj+YjJ6qvhgUzE
         ipWG8JO1ehsA1kdCcdWwXm6gei+djtc+Zd8jWAh2w1geFb642urgVoxEYFwJNNHZ8ZOM
         PdMA==
X-Forwarded-Encrypted: i=1; AJvYcCVUriXPQxDEWgvkuKuE1IiD183Onzuq8Gkg6K1DM6rjvCacuaoVd1g8TMPY+IjG4FC3U5zZOfex@vger.kernel.org, AJvYcCVxpUkRtgJpJrTze9KDbo3PsfEEWkZQJ0aXx3wQZHI7QFRYj0l3pX8hPd8Swcg5KjagTG/1r5afYqFdrTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM7U5X0A9ffG/HlyiTkiyWH4Fmbud0u/MSeV1CObJXwWM9SDOl
	5BB7ZRfqi6UEHF/bG94VFJZS5BddJ2FITZ6XMfJVJl4THqJVkArE
X-Gm-Gg: ASbGnctFeaL7dMKFvtnHTwNyjdQ5MEZs0eZL8jmfRJfDQibmmkPmnXzKDvc+XVPcmus
	UI23pi4Od/d6//r6vPpa9cOzO1dszlQ1iMvTk3qnfg7/tMq5fhuvKAhwDB4a4bq7hylOwgIdVsq
	s9/OycXWySfJm8PgWGEfA+2GYZSGDYdL33NEVmkzUb98Z6EAUTrDiqdKqRURbv1sWIn8LYKgzfl
	9VsPJtBeb1IaOLFH+rm5E1RrA++5nuapu2+vRu7KywZyQ/pNrsPPRzK7/oIT2KMLJLCxnqG0/tX
	Uw0VY+x+V1IHqzBS2gxJ9jzLL6J2bbEIiBe4vatw/EepfXwEXvUF95ggAkpzymNoTv5ASfayine
	yzUIvVUMR5ekoYRi3WXDtD9BRXdmjoK6AsXl/njbe9Ts/Bg==
X-Google-Smtp-Source: AGHT+IGHy7vhLSX2by9dT7/WXjhQ02G4RRGZxOIbUYvu1knM/biNNUWfgsMgJgAD4TyEuRVddSXgMw==
X-Received: by 2002:a05:6214:202c:b0:6e8:9535:b00 with SMTP id 6a1803df08f44-6eed6043b32mr143730956d6.12.1743442484018;
        Mon, 31 Mar 2025 10:34:44 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec9659a6esm49021096d6.52.2025.03.31.10.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 10:34:43 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 459121200068;
	Mon, 31 Mar 2025 13:34:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 31 Mar 2025 13:34:43 -0400
X-ME-Sender: <xms:M9LqZ_zX57dtaX6Qb9MCNXtcztmOxrfOYHw_qrYhWA4zB9zgIEsLuQ>
    <xme:M9LqZ3R6CYYOu_Q5DCHqYAShFQu6f6lQnHi9R62DWveRRFM6tW3NBMgDS0yiwvSfk
    6_hHBVM8wFZ96wAnw>
X-ME-Received: <xmr:M9LqZ5WzXQgeGd9COEIMjBDa6I6lJyGvWyWIr6O2JEr3UOR6crSMHiYgGJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedtheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfel
    leeivedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehlvghithgrohesuggvsghirghnrdhorh
    hgpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhlohhnghesrhgvughhrghtrdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhr
    ghdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopeifih
    hllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprggvhhesmhgvthgrrdgtohhmpdhr
    tghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:M9LqZ5jAfMfLPtnxo7caV9kEwlAktvfEbecCF-hk3VS9tf6_pIpdAg>
    <xmx:M9LqZxBVip2inMQfHWCZSnzbGo0-RMUR4NXOrGW5oLSWNEblYNx4Yw>
    <xmx:M9LqZyI0-Sdd-int_OJuWLHGpH46u3P8Rmu0p9n6q2LaPoESWwTIwQ>
    <xmx:M9LqZwBQ5-djVM-Xd_HuHkHQ0dk5V3QqX21XlWcje1vMtowY7kSKpw>
    <xmx:M9LqZ9zcDVhXndbDuIOLWwrgE6Ix452RthglqTLyNmCakdW4FnYqbYDB>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Mar 2025 13:34:42 -0400 (EDT)
Date: Mon, 31 Mar 2025 10:34:26 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Waiman Long <llong@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	aeh@meta.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	jhs@mojatatu.com, kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>
Subject: Re: [PATCH] lockdep: Speed up lockdep_unregister_key() with
 expedited RCU synchronization
Message-ID: <Z-rSIgd18t2_Lz7v@boqun-archlinux>
References: <Z-MHHFTS3kcfWIlL@boqun-archlinux>
 <1e4c0df6-cb4d-462c-9019-100044ea8016@redhat.com>
 <Z-OPya5HoqbKmMGj@Mac.home>
 <df237702-55c3-466b-b51e-f3fe46ae03ba@redhat.com>
 <37bbf28f-911a-4fea-b531-b43cdee72915@redhat.com>
 <Z-QvvzFORBDESCgP@Mac.home>
 <712657fb-36bc-40d8-9acc-d19f54586c0c@redhat.com>
 <1554a0dd-9485-4f09-8800-f06439d143e0@paulmck-laptop>
 <67e44a9f.050a0220.31c403.3ad3@mx.google.com>
 <Z+rHYq0ItKiyshMY@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+rHYq0ItKiyshMY@gmail.com>

On Mon, Mar 31, 2025 at 09:48:34AM -0700, Breno Leitao wrote:
> Hello Boqun, Waimn
> 
> On Wed, Mar 26, 2025 at 11:42:37AM -0700, Boqun Feng wrote:
> > On Wed, Mar 26, 2025 at 10:10:28AM -0700, Paul E. McKenney wrote:
> > > On Wed, Mar 26, 2025 at 01:02:12PM -0400, Waiman Long wrote:
> > [...]
> > > > > > > Thinking about it more, doing it in a lockless way is probably a good
> > > > > > > idea.
> > > > > > > 
> > > > > > If we are using hazard pointer for synchronization, should we also take off
> > > > > > "_rcu" from the list iteration/insertion/deletion macros to avoid the
> > > > > > confusion that RCU is being used?
> > > > > > 
> > > > > We can, but we probably want to introduce a new set of API with suffix
> > > > > "_lockless" or something because they will still need a lockless fashion
> > > > > similar to RCU list iteration/insertion/deletion.
> > > > 
> > > > The lockless part is just the iteration of the list. Insertion and deletion
> > > > is protected by lockdep_lock().
> > > > 
> > > > The current hlist_*_rcu() macros are doing the right things for lockless use
> > > > case too. We can either document that RCU is not being used or have some
> > > > _lockless helpers that just call the _rcu equivalent.
> > > 
> > > We used to have _lockless helper, but we got rid of them.  Not necessarily
> > > meaning that we should not add them back in, but...  ;-)
> > > 
> > 
> > I will probably go with using *_rcu() first with some comments, if this
> > "hazard pointers for hash table" is a good idea in other places, we can
> > add *_hazptr() or pick a better name then.
> 
> I am trying to figure out what are the next steps to get this issue
> solve.
> 

I will send out a serise including introduction of simple hazard
pointers and use it in lockdep for this case, hopefully that can resolve
your issue.

> Would you mind help me to understand what _rcu() fuction you are
> suggesting and what will it replace?
> 

The _rcu() functions we are talking about are:
hlist_for_each_entry_rcu() in is_dynamic_key(), hlist_add_head_rcu() in
lockdep_register_key() and hlist_del_rcu() in lockdep_unregister_key(),
because if we move to hazptr, they are technically not protected by RCU.
But the implementation of these functions is still correct with hazptr,
it's just their names might be confusing, and we may change them later.

Hope this helps.

Regards,
Boqun


> Thank you,
> --breno

