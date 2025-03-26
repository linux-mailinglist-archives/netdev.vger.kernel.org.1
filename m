Return-Path: <netdev+bounces-177794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A387A71C28
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 17:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EADD47A5C82
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 16:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975F21F4177;
	Wed, 26 Mar 2025 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V405WfrB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E998527456;
	Wed, 26 Mar 2025 16:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743007684; cv=none; b=ga6T/ZMRizVmOoMd5cZyjnFgJFyoUnXpnzcU+elbI9CkxXsl3AzR2xgCuKhYTNLASPtVpsSx4hrWBWEIkQJnr8pkineBR6OMtUaWgalJ8+7mheT1r4Bk0ZKpnDY8mkOabJbU66md7XJjIuBkYVuQaFWe6gWunFfx79ehMkDSuDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743007684; c=relaxed/simple;
	bh=cfRyOPOXqc7PYO0DilFU5NQHs5+SBJtNvB5Xo7qxAek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5mjlx1lK+5RT8HrndpcGOpHUfz/HO3QIbOo4/7Sck5qxjO6L5vMLnkC5F70vfZRKcLyivdTxTRPk6iP+7qvP3VWZ60v10S4/i/c0VUSIjZWuzpne5rr7lT+4uykZWdvM5zt5mHwRdIQZ4YO1ZL4yfNSOh8t4ivJcmm2VBjkhKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V405WfrB; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6ecfbf8fa76so44366d6.0;
        Wed, 26 Mar 2025 09:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743007682; x=1743612482; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+2YkF4SmIRgXjwjmynNl6QZEvBl38mMpqeEenEb2RQ=;
        b=V405WfrBVGQ82wOuJMO5iNGcZQBFgohb16hU5EdTvlJrpHqiqBUEw7ESyDJxDn/LEY
         UtLGCB7VMSmOcathXQBnVpEzXn5bbgcfMe27LActgIt0lO1dou7086wm3Qy18vSyjQSM
         ooo+O9fVCkVIZCpnc31q2OoYfmfSNDPn/zle6JRzOCH21PT1jF5oU+R2IWgiIDn0YeCu
         TWSqMWiYvO3Lzk7F51sMO+qqeR737TnAiAFAK0W1gogmwHm4Busw8JqbTkII2VX95mCC
         T4N2db07LIeStJaI6ltHd8HZEH4GcvjseLikUUWWVkZWxx69AH7hWW1NOAZJ0ZI0B/lJ
         sPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743007682; x=1743612482;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+2YkF4SmIRgXjwjmynNl6QZEvBl38mMpqeEenEb2RQ=;
        b=DaaVmiv8sI9eeqXrqlS9x/pNjKtPZQQOnindtKZVOZn4Nq8+UklWG2c3AV5cV5h3JQ
         LEjh4i6V2/CHsb9KD/ag6x/2qlK4OgQIdnWTvb1fFgkAp6RGkXlho1tib+naXkzMDXM7
         r/rVwknnQY3+ZEofymKTMDegvV5HbZP/Nv8C4Zma1aRfTsXu9qC0rHZB6xTVDhf6OwL4
         NjAGX9Y6ESco6uiShZn/PT9e0XJL7QUtPEdL0aQKc12XaG8Jq7B9Hyuj6BAm4KNSWDvN
         JE2Fd3FibUY9CvY9vC8gqRf9h7coxWuPgdMz5vdFhh0QH3OmKZO4xSyCgO2EbFolbr04
         IsXA==
X-Forwarded-Encrypted: i=1; AJvYcCW6lMqYHxNiOExM6bF7EUWhTQ8o1Y/NDuUGEq2XRMQQO+pbj2PFzUNdQrD6ANwmTwC8ApnzVUAd@vger.kernel.org, AJvYcCXvtpBDNvtNge5+X8qX76bQ8GmU/NF4QLQN0y4TecIVIr7CyDsd0CsFc+rXd94yfhChQKN2wHyQbgnJXf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/YKiWCCyd5ocHZQexw5nyXDIaYkvVk+rKAHWF37Z6Bl4iB77S
	1NkftthC9tj3oBDPUCJh9gEstAaaCkHDHErb3/HijnIQhTdINuo5
X-Gm-Gg: ASbGnctshUcrLlho01sI3jvtcXm+dOAtO6NxQPfwHMVYYIfKtpo6VC2g6M56ZK5ScKg
	tMfvZA+eriy412e5Oz9wHjFLP2Ng3BBDlWx7rDwOgmuXLbbhZWlAtvIlBHUDDDdoAb0VcSnwwnQ
	ADjkEMCNZAIGMU6LpXkdH5UUKqpMsTuiG85zFidRkndR6LsDW49vIpe9kwi1PX40LVFv6/uYXzH
	0QVuvNZbVcZ1d0dN/ciz6uqmrl4skoj9ETtXLEXuNfckRLEMljVNISPe/kKVLz1w837sCfaXopf
	eTF+eMO4uvT1Y+m1LshEVxie6/nxxv1HeX9isfTSpzPLtWFIcRUl4PPxAOyGu9+BVigMxgJY/Pz
	oCR28DXDmGokIIMByQqVSq09TQmygFxjIcuvccBsLzKZDvg==
X-Google-Smtp-Source: AGHT+IF9JMMWF4dyntkOBljPWsW+RS38rBexSiSPg9zq1HnSHy6ApSi/nmVeIkXzSpLeOVjTyoOXIA==
X-Received: by 2002:ad4:5686:0:b0:6eb:28e4:8519 with SMTP id 6a1803df08f44-6ed23897c41mr1668126d6.21.1743007681506;
        Wed, 26 Mar 2025 09:48:01 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efc5a1dsm69271066d6.79.2025.03.26.09.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 09:48:01 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id B63001200043;
	Wed, 26 Mar 2025 12:48:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 26 Mar 2025 12:48:00 -0400
X-ME-Sender: <xms:wC_kZ2k6MZlZrSFWkORFod8DS-1rAtSfX9OZtvnOsIe1Kcu7J8e_SQ>
    <xme:wC_kZ91QMqPAnpdkrbWU0U5dXcND-lZqRbMbCDcETd274_55cEVhJ0syBQeOFwdZy
    DUI0FqQTDNS6WC7nw>
X-ME-Received: <xmr:wC_kZ0pUL9p7swKYYoUtD8F1LSbN8m_-Uf77NbDVyUBxWMkXBoduOggd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeitdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepvefghfeuveekudetgfevudeuudejfeel
    tdfhgfehgeekkeeigfdukefhgfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpe
    epghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedugedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhlohhnghesrhgvughhrghtrdgtoh
    hmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlvghithgroh
    esuggvsghirghnrdhorhhgpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhm
    pdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrvghhse
    hmvghtrgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:wC_kZ6nL_JDWzG5kEZSJvyUStm8nJbBmabdOTL2OdYwA6IOvpt_K0g>
    <xmx:wC_kZ01RrGSthl4RhOylXVQOxENL_Ie24XIoiubiKFn-ZEDoSCIP6g>
    <xmx:wC_kZxtoTOgpPJVlK5ndzVUolvp6b75a8bnKOiWfoGPIirze4RwaCg>
    <xmx:wC_kZwUnkmNfRIBgl6j75mHPIm8qcdL7hVpilreZO8gBtLaDlmsOdA>
    <xmx:wC_kZ_3nlQvp08yG6mHkg4Rgx4tA0T48z4wMJ8jTC_f6PgWfAnNxpMsk>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Mar 2025 12:48:00 -0400 (EDT)
Date: Wed, 26 Mar 2025 09:47:59 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Waiman Long <llong@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Breno Leitao <leitao@debian.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, aeh@meta.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	jhs@mojatatu.com, kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] lockdep: Speed up lockdep_unregister_key() with
 expedited RCU synchronization
Message-ID: <Z-QvvzFORBDESCgP@Mac.home>
References: <c0a9a0d5-400b-4238-9242-bf21f875d419@redhat.com>
 <Z-Il69LWz6sIand0@Mac.home>
 <934d794b-7ebc-422c-b4fe-3e658a2e5e7a@redhat.com>
 <Z-L5ttC9qllTAEbO@boqun-archlinux>
 <f1ae824f-f506-49f7-8864-1adc0f7cbee6@redhat.com>
 <Z-MHHFTS3kcfWIlL@boqun-archlinux>
 <1e4c0df6-cb4d-462c-9019-100044ea8016@redhat.com>
 <Z-OPya5HoqbKmMGj@Mac.home>
 <df237702-55c3-466b-b51e-f3fe46ae03ba@redhat.com>
 <37bbf28f-911a-4fea-b531-b43cdee72915@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37bbf28f-911a-4fea-b531-b43cdee72915@redhat.com>

On Wed, Mar 26, 2025 at 12:40:59PM -0400, Waiman Long wrote:
> On 3/26/25 11:39 AM, Waiman Long wrote:
> > On 3/26/25 1:25 AM, Boqun Feng wrote:
> > > > It looks like you are trying hard to find a use case for hazard pointer in
> > > > the kernel 🙂
> > > > 
> > > Well, if it does the job, why not use it 😉 Also this shows how
> > > flexible hazard pointers can be.
> > > 
> > > At least when using hazard pointers, the reader side of the hash list
> > > iteration is still lockless. Plus, since the synchronization part
> > > doesn't need to wait for the RCU readers in the whole system, it will be
> > > faster (I tried with the protecting-the-whole-hash-list approach as
> > > well, it's the same result on the tc command). This is why I choose to
> > > look into hazard pointers. Another mechanism can achieve the similar
> > > behavior is SRCU, but SRCU is slightly heavier compared to hazard
> > > pointers in this case (of course SRCU has more functionalities).
> > > 
> > > We can provide a lockdep_unregister_key_nosync() without the
> > > synchronize_rcu() in it and let users do the synchronization, but it's
> > > going to be hard to enforce and review, especially when someone
> > > refactors the code and move the free code to somewhere else.
> > Providing a second API and ask callers to do the right thing is probably
> > not a good idea and mistake is going to be made sooner or later.
> > > > Anyway, that may work. The only problem that I see is the issue of nesting
> > > > of an interrupt context on top of a task context. It is possible that the
> > > > first use of a raw_spinlock may happen in an interrupt context. If the
> > > > interrupt happens when the task has set the hazard pointer and iterating the
> > > > hash list, the value of the hazard pointer may be overwritten. Alternatively
> > > > we could have multiple slots for the hazard pointer, but that will make the
> > > > code more complicated. Or we could disable interrupt before setting the
> > > > hazard pointer.
> > > Or we can use lockdep_recursion:
> > > 
> > > 	preempt_disable();
> > > 	lockdep_recursion_inc();
> > > 	barrier();
> > > 
> > > 	WRITE_ONCE(*hazptr, ...);
> > > 
> > > , it should prevent the re-entrant of lockdep in irq.
> > That will probably work. Or we can disable irq. I am fine with both.
> > > > The solution that I am thinking about is to have a simple unfair rwlock to
> > > > protect just the hash list iteration. lockdep_unregister_key() and
> > > > lockdep_register_key() take the write lock with interrupt disabled. While
> > > > is_dynamic_key() takes the read lock. Nesting in this case isn't a problem
> > > > and we don't need RCU to protect the iteration process and so the last
> > > > synchronize_rcu() call isn't needed. The level of contention should be low
> > > > enough that live lock isn't an issue.
> > > > 
> > > This could work, one thing though is that locks don't compose. Using a
> > > hash write_lock in lockdep_unregister_key() will create a lockdep_lock()
> > > -> "hash write_lock" dependency, and that means you cannot
> > > lockdep_lock() while you're holding a hash read_lock, although it's
> > > not the case today, but it certainly complicates the locking design
> > > inside lockdep where there's no lockdep to help 😉
> > 
> > Thinking about it more, doing it in a lockless way is probably a good
> > idea.
> > 
> If we are using hazard pointer for synchronization, should we also take off
> "_rcu" from the list iteration/insertion/deletion macros to avoid the
> confusion that RCU is being used?
> 

We can, but we probably want to introduce a new set of API with suffix
"_lockless" or something because they will still need a lockless fashion
similar to RCU list iteration/insertion/deletion.

Regards,
Boqun

> Cheers,
> Longman
> 

