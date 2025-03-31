Return-Path: <netdev+bounces-178433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF3BA77008
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 23:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCD27188CD8C
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 21:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464ED21C170;
	Mon, 31 Mar 2025 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8nG79Dv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D32F21A45F;
	Mon, 31 Mar 2025 21:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743456109; cv=none; b=pUSeaBCsN3P4K10bLDpcqFp6M/9bWDJ/PATyxLwn7FsfRMfjxR09wvTT+kxMhMIHMCbh5sUPWGZV7XuaibTVLLIsSd1tKc2NK3R+Qx1VHMJdj1/tKn5DXltupJbJxV+l700yPZTDPYO0Cg4b+q7kVAN+5XgBEytgS5OC42JTK8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743456109; c=relaxed/simple;
	bh=pt7lnExktj71TQdLPtKq2v2O2M4D3Ml4XArqoPjoZ/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWGtoSSeZ52t7TwiYB+6PDFC130SX3bqbjwdBwTT9pmsrc9YEm2WuVfH6WOaQXSg4MnMhZ4MKfxeRcpjEGhf2nOKkWa8JuGRiTckYp9iB7CSQKRaZTG+KX8N6fgMYgIbMBJv7oMtdnG4eL0VWArlFR6Q5XaA0wOcv+dOawcDfR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8nG79Dv; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6ecfbf8fa76so55804226d6.0;
        Mon, 31 Mar 2025 14:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743456106; x=1744060906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HuLwdD/d3kWZQrIQyhz8gsUtIDe+p+pTo64F1sYYb40=;
        b=k8nG79DvrjibULWPB3gxrLTp/6yX9QolKzQHOwM+qIWK+/lqKlm02U0S3HaLCoNdWn
         rCFz0KcTsFxJmoRltuBwOzNag9YC1dvWzI/dUgYuTS7xbCTSWomKMDbciPKtCQ99neg6
         oSdQszQrUnX/h2HNoGJMBtl0cFK0dq+ONbkZjhzJf6efIQ2P/9r99zAdiriUvtI4GhO1
         PxukVBNLepwa+97wZaam+TcYNxsETcL3Rq3EzOYPK4mFe4yAFLGOCv2/QnNmkIN3Dwym
         LOmhW8TEwnYrwKbfEqOk30+DStmisc5z2wLldZghm9Q9Aqi0sAhKCr9Tw+44vLTrKAMI
         9AkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743456106; x=1744060906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HuLwdD/d3kWZQrIQyhz8gsUtIDe+p+pTo64F1sYYb40=;
        b=ZuGthAc47d59QnStM9yIW2P87PsyTEYVYbNEMuR8Ygt0Cb/J7+Hrgf/cUfIxM/UIQ5
         0PytGp6mR7LEJb4KgJ+29LqcTNNWvwE/H6bU7Qjv0cB03qTBlz16buzSkDkOLojyvYcR
         8tsYStGkPsZt/H+kJNotarLErE9NDkADjgN2ZzufjH35Xe7oH7wotyVjg2TTRFISCX9V
         YLYicYeLB9ld7Kn/w2uJNI+Uzt7U2KVadlElaHPKXiPh2j+INLfEngwPqVtY5GwSVCAu
         4VeB7wGHtnwONAE9KJ6wbp/bgZYusHy3kkQRzAf4NdrK82LzmNNV+sCPMxcODzqQxIgx
         F+rA==
X-Forwarded-Encrypted: i=1; AJvYcCUntde0a5O2IlwVfVHFdJenaXomXV4HS2vnvNwRYbNqME0/inqTQFl1e5fH8xoHkK2v/glCdEmO@vger.kernel.org, AJvYcCX4/nvyV+Ji/zMA7tez34oJn/DVPtrYRuyJpxItON7dBCNK7mMMCUHVH1lPnPPFdEveBCIjU4g9QqhUzyU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2jsS8rtg90QFDOl647S+7WnY4omuEDSMor0C2goRF9I59rzIN
	WS+AcK0HyCaCK9RrHRkTnkVuDsG10DgUKcsRwG7xXuChlRWioOQn
X-Gm-Gg: ASbGncvoy35D5WlCRjVb+iAY1C7yKTz5i/O9esGMM3wBntoV2p9+D36J1hLk/HF1e/A
	+h53ykYLd88rBEWk/xJXPVvJ3Qg/8nKgwwRYvEOU7Le3NbVZxWooP1EZ9/RxAxnCkICfyM98pXP
	e9YK8twBQE8Dah2sZ8EIMpaIH/26M8M4gLtt0jcWgzLpKg0cV7NJgqKsA5UGBtQ2cbvlLhO16F4
	aaHWp4+QHleWkGhT+RoPoChJrypPJaw2qIEK5yhaQ9N6Cg8KAuaNlsG7PIQTMz/clP1o30/FfnV
	SH26KM6ka2OgJvINSGDtmDqXSiBMrzT34Hi6ZdaD0ThfYP4bFq4h7dZwLzJ9PVFA5kXegyT3rM/
	YdLAdDctV10QIYlah7MfDMnZwNi3g1Km23bk=
X-Google-Smtp-Source: AGHT+IEUuCr4Y8iWcydXMoRJyuChOkNdR02ZlhsDE49aVFL+35x8X+J7ddPYEn9XPDnoN/1yABHz8A==
X-Received: by 2002:a05:6214:4005:b0:6e8:f701:f6d9 with SMTP id 6a1803df08f44-6eed604eac6mr130492316d6.12.1743456106259;
        Mon, 31 Mar 2025 14:21:46 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec965a3c8sm51382826d6.58.2025.03.31.14.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 14:21:45 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1495A120007C;
	Mon, 31 Mar 2025 17:21:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 31 Mar 2025 17:21:45 -0400
X-ME-Sender: <xms:aAfrZ7Gwslxo75JT2QicoikUpn74jnC6xNffKdIJsNVHuHTgECv-nw>
    <xme:aAfrZ4Vd9qsmowB5KTmJdARZcssMk6PCuu-uk1I9PKIcnlL_pS3JWtyTkWSXoyrRB
    ybHZAKDftqfksV6ZQ>
X-ME-Received: <xmr:aAfrZ9Kn5xOLc1vkLyWNQPhByML0db-4-Y0p77zaV3iNmiN1we54zshuERY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedtleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedv
    teehuddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheplhhlohhnghesrhgvughhrghtrdgtohhmpdhrtghpthhtohepphgruhhlmhgtkhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphht
    thhopehlvghithgrohesuggvsghirghnrdhorhhgpdhrtghpthhtohepmhhinhhgohesrh
    gvughhrghtrdgtohhmpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegrvghhsehmvghtrgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:aQfrZ5GM5LBlwrtkQrMD7m0VAEfJIJRwmtpnJCHAJZYnhIorgrKCOA>
    <xmx:aQfrZxXkiTebM2mLN4Zigo04vCzP2uU_FA4_d-kh_bMQhxAAR79v_A>
    <xmx:aQfrZ0OX44IJZ0aUa6nLXAjr2fGJMmSSM-2SEtOSjoDbwN7g7SfADg>
    <xmx:aQfrZw0rLzMOissZ92LNF4CWSuspVSlSG7epdYc5sIisBtF_7qthsA>
    <xmx:aQfrZ2XPbyoPsGitZS4Vxp6ukFUoCNMa_8JaZHYN0vVZTITt_r8yWqjO>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Mar 2025 17:21:44 -0400 (EDT)
Date: Mon, 31 Mar 2025 14:21:28 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Waiman Long <llong@redhat.com>
Cc: paulmck@kernel.org, Eric Dumazet <edumazet@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Breno Leitao <leitao@debian.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, aeh@meta.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	jhs@mojatatu.com, kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>
Subject: Re: [PATCH] lockdep: Speed up lockdep_unregister_key() with
 expedited RCU synchronization
Message-ID: <Z-sHWAQ2TnLMEIls@boqun-archlinux>
References: <Z-L5ttC9qllTAEbO@boqun-archlinux>
 <f1ae824f-f506-49f7-8864-1adc0f7cbee6@redhat.com>
 <Z-MHHFTS3kcfWIlL@boqun-archlinux>
 <1e4c0df6-cb4d-462c-9019-100044ea8016@redhat.com>
 <Z-OPya5HoqbKmMGj@Mac.home>
 <df237702-55c3-466b-b51e-f3fe46ae03ba@redhat.com>
 <Z-rQNzYRMTinrDSl@boqun-archlinux>
 <9f5b500a-1106-4565-9559-bd44143e3ea6@redhat.com>
 <35039448-d8e8-4a7d-b59b-758d81330d4b@paulmck-laptop>
 <69592dc7-5c21-485b-b00e-1c34ffb4cee8@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69592dc7-5c21-485b-b00e-1c34ffb4cee8@redhat.com>

On Mon, Mar 31, 2025 at 02:57:20PM -0400, Waiman Long wrote:
> On 3/31/25 2:33 PM, Paul E. McKenney wrote:
> > On Mon, Mar 31, 2025 at 01:33:22PM -0400, Waiman Long wrote:
> > > On 3/31/25 1:26 PM, Boqun Feng wrote:
> > > > On Wed, Mar 26, 2025 at 11:39:49AM -0400, Waiman Long wrote:
> > > > [...]
> > > > > > > Anyway, that may work. The only problem that I see is the issue of nesting
> > > > > > > of an interrupt context on top of a task context. It is possible that the
> > > > > > > first use of a raw_spinlock may happen in an interrupt context. If the
> > > > > > > interrupt happens when the task has set the hazard pointer and iterating the
> > > > > > > hash list, the value of the hazard pointer may be overwritten. Alternatively
> > > > > > > we could have multiple slots for the hazard pointer, but that will make the
> > > > > > > code more complicated. Or we could disable interrupt before setting the
> > > > > > > hazard pointer.
> > > > > > Or we can use lockdep_recursion:
> > > > > > 
> > > > > > 	preempt_disable();
> > > > > > 	lockdep_recursion_inc();
> > > > > > 	barrier();
> > > > > > 
> > > > > > 	WRITE_ONCE(*hazptr, ...);
> > > > > > 
> > > > > > , it should prevent the re-entrant of lockdep in irq.
> > > > > That will probably work. Or we can disable irq. I am fine with both.
> > > > Disabling irq may not work in this case, because an NMI can also happen
> > > > and call register_lock_class().
> > > Right, disabling irq doesn't work with NMI. So incrementing the recursion
> > > count is likely the way to go and I think it will work even in the NMI case.
> > > 
> > > > I'm experimenting a new idea here, it might be better (for general
> > > > cases), and this has the similar spirit that we could move the
> > > > protection scope of a hazard pointer from a key to a hash_list: we can
> > > > introduce a wildcard address, and whenever we do a synchronize_hazptr(),
> > > > if the hazptr slot equal to wildcard, we treat as it matches to any ptr,
> > > > hence synchronize_hazptr() will still wait until it's zero'd. Not only
> > > > this could help in the nesting case, it can also be used if the users
> > > > want to protect multiple things with this simple hazard pointer
> > > > implementation.
> > > I think it is a good idea to add a wildcard for the general use case.
> > > Setting the hazptr to the list head will be enough for this particular case.
> > Careful!  If we enable use of wildcards outside of the special case
> > of synchronize_hazptr(), we give up the small-memory-footprint advantages
> > of hazard pointers.  You end up having to wait on all hazard-pointer
> > readers, which was exactly why RCU was troublesome here.  ;-)

Technically, only the hazard-pointer readers that have switched to
wildcard mode because multiple hazptr critical sections ;-)

> 
> If the plan is to have one global set of hazard pointers for all the

A global set of hazard pointers for all the possible use cases is the
current plan (at least it should be when we have fully-featured hazptr
[1]). Because the hazard pointer value already points the the data to
protect, so no need to group things into "domain"s.

> possible use cases, supporting wildcard may be a problem. If we allow

I had some off-list discussions with Paul, and I ended up with the idea
of user-specific wildcard (i.e. different users can have different
wildcards) + one global set of hazard pointers. However, it just occured
to me that it won'd quite work in this simple hazard pointer
implementation (one slot per-CPU) :( Because you can have a user A's
hazptr critical interrupted by a user B's interrupt handler, and if both
A & B are using customized wildcard but they don't know each other, it's
not going to work by setting either wildcard value into the slot.

To make it clear for the discussion, we have two hazard pointer
implementations:

1. The fully-featured one [1], which allow users to provide memory for
   hazptr slots, so no issue about nesting/re-entry etc. And wildcard
   doesn't make sense in this implemenation.

2. The simple variant, which is what I've proposed in this thread, and
   since it only has one slot per CPU, either all the users need to
   prevent the re-entries or we need a global wildcard. Also the readers
   of the simple variant need to disable preemption regardlessly because
   it only has one hazptr slot to use. That means its read-side critical
   section should be short usually.

I could try to use the fully-featured one in lockdep, what I need to do
is creating enough hazard_context so we have enough slots for lockdep
and may or may not need lockdep_recursion to prevent reentries. However,
I still believe (or I don't have data to show otherwise) that the simple
variant with one slot per CPU + global wildcard will work fine in
practice.

So what I would like to do is introducing the simple variant as a
general API with a global wildcard (because without it, it cannot be a
general API because one user have to prevent entering another user's
critical section), and lockdep can use it. And we can monitor the
delay of synchronize_shazptr() and if wildcard becomes a problem, move
to a fully-featured hazptr implementation. Sounds like a plan?

[1]: https://lore.kernel.org/lkml/20240917143402.930114-2-boqun.feng@gmail.com/

Regards,
Boqun

> different sets of hazard pointers for different use cases, it will be less
> an issue. Anyway, maybe we should skip wildcard for the current case so that
> we have more time to think through it first.
> 
> Cheers,
> Longman
> 

