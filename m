Return-Path: <netdev+bounces-178374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD12CA76C84
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 19:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59AB1889525
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 17:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDAC2139C8;
	Mon, 31 Mar 2025 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SX9sjnkc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAA219F117;
	Mon, 31 Mar 2025 17:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743441995; cv=none; b=Ele1tPVZHNqtOboCDLYDGdogTxCntR4rMpBc1/+tv4hYbB5LOHT3jOXel4u/CB3mn1Sg0M7X/5VeSoe7aZrUE/l3CAdgFFnUGNtkaiW+ar9QP4GVquAw1SKvM1oLaEuxCFPqqwElcNSX4vzaQ5KGxELwJD998rFjiHDSZJjng8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743441995; c=relaxed/simple;
	bh=orZh2BCxMRMseQbfZV4anPxjY+gnxSpq8moL1zQKvHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SInBbMTouO5usWHsW8l3IEoe5Z7k/9QD0Ea0JsWUppQYluMugbxwmOs5JJpk3a57eHKRTdaJjdUnTPrSck8/GdiFe1LUOb7cOtID3ngKujuuInpQvQJjCFMqeIqNiBWhIeWE5G8qE/CN6aZLpKLdgfbH1NMycKtR0wuGurFqxjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SX9sjnkc; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c560c55bc1so508832385a.1;
        Mon, 31 Mar 2025 10:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743441993; x=1744046793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oCNzu/Fxf/6j8nlJXQ46TjW0dh7FpFajDQzpO4wAg0=;
        b=SX9sjnkcmBN/TjLCdnqy7qfq9JhCn1ly6ZP+UyYHfVohGxn/vFymgtZYuZf4KzlmI8
         GZVquphbIfVdAR/CihMOqB9pOz+n9DGydky98C0GFDFrCcUZv8fLZtj0vZuF8T6jR+Br
         KUJVv3838NlxU/VUUQM1Npiy2tUGNR1yB1RSrao2nxMs9XUc6a/GSQC43WGosRTewYV9
         8dDGXv0WRBYC9gu4YbXIjy0dkCjJ9zDhoPA+rLnlVSZA6jY+zQgTSLls7/zhqq9qxRNU
         3QYA1YwaIJ2cpiHjKWL6DlKhB9zRcgNHPBm+CKuh84BssTOsyr81LHyL/jny5VPsqzAs
         fLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743441993; x=1744046793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/oCNzu/Fxf/6j8nlJXQ46TjW0dh7FpFajDQzpO4wAg0=;
        b=p13JigIAzvT04wUIHVvFP6pbUzOVkOxZKit31UJFROax1obi4+Hi9PaG13z8R4bIA+
         yJl63qq4o4ledlCu2vRyJwCUQgemEblp4W8YevuEPQsfKuyZBmAaaSYGfH/avTyI+fSk
         xZ6EqIzA3Kzol45Tp9A6+BYWUUvBo6mHu8kZZ6V62lwCEjNU/J+pkhieQ8eG5zwvYfG/
         3+ae88hwUVDQcMTKA91C5Gs2gtdH/+NxSZwDqBQdMaZ79Q3cHznsEYJmpSJJWJGY6UII
         vw5nCVhWhFvcFpUiWWstukC6a///SfYqOrxbVOszuNZbXFayM6JOZNHyh7dGLVOjeBBP
         wOBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmbw8B194UsoxGBJYCmwjTJo892EaqEBgUY5n6VYQm+qquntk0fCvyxxYJ+vI5LTv7HG6MdnapdaOO0uE=@vger.kernel.org, AJvYcCXpnT4pbJepEK51KSX1L97RK8I9AV00AuovsEUCTGqBOthBSX8fjm6hp1mdEd8+0z4qfG7q/sZ1@vger.kernel.org
X-Gm-Message-State: AOJu0YzyW9d5RnGjc4K0DENIVJPEF6PXdiSrLg1T+dLXPbEJixGjk93V
	Kh4r6Qu6MxsBPYJCg1zseEAUyLTXo+gUqcIJ/X+yuwmS8+/bLiTb
X-Gm-Gg: ASbGncviGkQFvkQNXkw21jq3o8NwM+M/iq86204h+QihoXLSDz7Wm5/dnBTJL6nXmWV
	pRp38mbqGI95F23icTJCOao7c4Ai8G9PjxOK3xpWo0xcoMU1cu6cb+uDaUvfk9BcYfgzIwhXTbT
	tplvTxKfeqm4bs0XFDhyZjjL93deHyh24cxPvmy+CyMzrw6qINfj02C++DYLeijMIqCjYP3ocms
	No1z8ggkacH1xPreu89BW+PZ+sssWThXLMw+F77+uryeP0MvTQWttIDaXU5SWU8a/CfSvzd8yZq
	RzMEagdNRf9emP461fcAR+RkSzWE0R3JXW8vUK9e3cjfmzu+5TXIIf0HA4i5MHm7smGUgm0QnND
	pQlZSTI5a3VixvOnPh2G5LBOB67tFufZiUI8=
X-Google-Smtp-Source: AGHT+IGe4AzegAumIot0ANUF7bK2pgla/r1T4cqrZnTn9paFxFxziydhrg5Hs0wOIEoVqEfQFtwjiw==
X-Received: by 2002:a05:620a:2551:b0:7c5:538f:ae4a with SMTP id af79cd13be357-7c69072d5aemr1254310585a.26.1743441992631;
        Mon, 31 Mar 2025 10:26:32 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f76abe07sm522409585a.59.2025.03.31.10.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 10:26:32 -0700 (PDT)
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9EF83120006A;
	Mon, 31 Mar 2025 13:26:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-13.internal (MEProxy); Mon, 31 Mar 2025 13:26:31 -0400
X-ME-Sender: <xms:R9DqZxAxN1b6d7f168SI6wJ2tq1hxkeK5Ma74FWFQ1qohDEw6iAc1Q>
    <xme:R9DqZ_hfSq6Ths1Fu_R_EcJOOFcXo56r6I3ovl7Sf_ucSGUBerxSlUpM0otUuDBHt
    hVox68c3rqWuwwlIA>
X-ME-Received: <xmr:R9DqZ8kE5IcKOO44CPrOVKRcD6bdhfr7PpHF7ul3grl1WEnS73qE89sy2JI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedthedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfel
    leeivedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehllhhonhhgsehrvgguhhgrthdrtghomh
    dprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    phgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhgvihhtrghose
    guvggsihgrnhdrohhrghdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdp
    rhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprggvhhesmh
    gvthgrrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:R9DqZ7wLkrRuLFVEazsPHlvs3YkpI6X_9xWCi90SASaIOjFCr3nGEA>
    <xmx:R9DqZ2SrTS51Fr3JATW39zdRr7xDPOy20XMvKQEYUX7q53KckB8OLw>
    <xmx:R9DqZ-ZtJLgjoN2jTPhQfhk5wzWqqij_Rz_l02XYmZq6K_Yu_Ro3WQ>
    <xmx:R9DqZ3QA5VjLWOqldGuhwmZDUwBP-hnpm8-IyS-tPMPtiAA_xwq_Vg>
    <xmx:R9DqZ0A2iqP4kBIsTOWpoqLrLG01-1Sf0tRKCDt4nz8JcTbal4pomF1s>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Mar 2025 13:26:31 -0400 (EDT)
Date: Mon, 31 Mar 2025 10:26:15 -0700
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
Message-ID: <Z-rQNzYRMTinrDSl@boqun-archlinux>
References: <67e1fd15.050a0220.bc49a.766e@mx.google.com>
 <c0a9a0d5-400b-4238-9242-bf21f875d419@redhat.com>
 <Z-Il69LWz6sIand0@Mac.home>
 <934d794b-7ebc-422c-b4fe-3e658a2e5e7a@redhat.com>
 <Z-L5ttC9qllTAEbO@boqun-archlinux>
 <f1ae824f-f506-49f7-8864-1adc0f7cbee6@redhat.com>
 <Z-MHHFTS3kcfWIlL@boqun-archlinux>
 <1e4c0df6-cb4d-462c-9019-100044ea8016@redhat.com>
 <Z-OPya5HoqbKmMGj@Mac.home>
 <df237702-55c3-466b-b51e-f3fe46ae03ba@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df237702-55c3-466b-b51e-f3fe46ae03ba@redhat.com>

On Wed, Mar 26, 2025 at 11:39:49AM -0400, Waiman Long wrote:
[...]
> > > Anyway, that may work. The only problem that I see is the issue of nesting
> > > of an interrupt context on top of a task context. It is possible that the
> > > first use of a raw_spinlock may happen in an interrupt context. If the
> > > interrupt happens when the task has set the hazard pointer and iterating the
> > > hash list, the value of the hazard pointer may be overwritten. Alternatively
> > > we could have multiple slots for the hazard pointer, but that will make the
> > > code more complicated. Or we could disable interrupt before setting the
> > > hazard pointer.
> > Or we can use lockdep_recursion:
> > 
> > 	preempt_disable();
> > 	lockdep_recursion_inc();
> > 	barrier();
> > 
> > 	WRITE_ONCE(*hazptr, ...);
> > 
> > , it should prevent the re-entrant of lockdep in irq.
> That will probably work. Or we can disable irq. I am fine with both.

Disabling irq may not work in this case, because an NMI can also happen
and call register_lock_class().

I'm experimenting a new idea here, it might be better (for general
cases), and this has the similar spirit that we could move the
protection scope of a hazard pointer from a key to a hash_list: we can
introduce a wildcard address, and whenever we do a synchronize_hazptr(),
if the hazptr slot equal to wildcard, we treat as it matches to any ptr,
hence synchronize_hazptr() will still wait until it's zero'd. Not only
this could help in the nesting case, it can also be used if the users
want to protect multiple things with this simple hazard pointer
implementation.

Regards,
Boqun

[..]

