Return-Path: <netdev+bounces-299228-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 86ZJH3W2Lmpp2AQAu9opvQ
	(envelope-from <netdev+bounces-299228-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 16:11:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4421681420
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 16:11:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=dqxlW3eo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299228-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299228-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19F693007C9F
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 14:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2A73921D0;
	Sun, 14 Jun 2026 14:10:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48616387364
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 14:10:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781446258; cv=none; b=VxhyCaOrT0QxSdmKokimLck13CDgchTRH3DOGA1tTG39OqL2rMfPGr4CHhF4wwBZjGzyZGe+0yf0f+mNJXUcWr5QJfCv50hRYINv7jzVO+yzMe3w2lsaJD0yn61nEyACrynZHpSyKzjoMUjvfBRni/nyT2QdO36hD6EbiL2LIpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781446258; c=relaxed/simple;
	bh=DEQ1ozKAOlubTdqHXSC2p+fAsGAwjH75bNOq1F4U8do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SucDDCGOsAkZ/AzK/zBgl6WdfLNlcPDjDefiws5MywGxHh8mZO9/67neWZHUFOqgLLj/8l+Asgq8ovGrjxgS/9WGCok/PnB7JthwjiC+XoM01Qr1aS9EgaqoP/VkgvASK9kvdmY7QS776wjtAt8EEkaHMheWn9AqjJ3eW01DV4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dqxlW3eo; arc=none smtp.client-ip=209.85.214.180
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c0b1a48855so98955ad.0
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 07:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781446257; x=1782051057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yHF10+gcCY+52/p+MI0EpREqdUQuaXVQZcqVUlKnjNk=;
        b=dqxlW3eoVzBm2yQ2PN41SutQoF7Nk/JoJ2hBzJL6WU911XAZLVcC7W07Va5O2MO676
         kyYvPzp/ZQqg4rNxbCLsKM/6G5rvi4DJVv4wvqF2iayZHw99yf9eAbGxnQQik9zffLni
         gXp92qxUCCsCwHRxs6gCCFmPUJc9n8o5tELl13sjZ3F5t8ympWciyuUZ1MtB6h3Ttedt
         ZUuNLZUGyI+MmMzMR8hnOs8HTRCfi5ZTIqblWmQQ337/9h5uirjXT/qzZCmc4HTuOuZe
         ZFFIyfoeeSEaUSuMuJW4x7YYivrNbNRwHMQpEscNlj1QmuCObKVHWnZ7yVQU3BO+6DKo
         UY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781446257; x=1782051057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHF10+gcCY+52/p+MI0EpREqdUQuaXVQZcqVUlKnjNk=;
        b=VXEmhISwhe4FRr1mfLY/YbQ7x9wtFtCPxbI3L/tOy8ka7Rn499qAqDe4z0fnPF2SyR
         6DZhLs+XeI46slK6HIziBKjxetPq+rU/O2PG6ETU5BkB6+jQ7IJivrYeD35wPnL/jGj9
         ypQSAkePWdkhWpcUpV1PDMfPTGntsNof8eXYqfI6xNF76TGUGcX5mmIiK8uEr3E4K6ZH
         k9hT1pAM8tUF6ZAA7zlM4t1tJ7Mwa3lX+Z4crOw52GWOP6l1luyzs/WGBbshKIBWFwbE
         jluz/2pm6Ugc4KNwOeoIHJcb7TLVewQfp1HXFhq1j+tctLwug/f5kJOWX5RT+S0+dAUu
         FvZw==
X-Forwarded-Encrypted: i=1; AFNElJ/9BC17KtRegrkpK6XK1tT5EEUuFnTlUjhBJ/iorZq7ZUuPsGJLQjUgzAd5mBAY5HsW2YKmsCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDAIUZ+HpMCJgBsmtgg1IxGKjNeHbhaWNIjlPA5sSPOqe9Nxtj
	Ubs3NVwQNH+OvDwWIZ8Sd/pxphT7jLagy5wd9VjZylQHmHKrM8DasEfYCs+NvxUZykgqcUz28fi
	zvpcajw==
X-Gm-Gg: Acq92OGaiuYyJfNipEDAq/LvEWd48sDxeykkBEmXejYUoqfqhdrhAwLTlaQl4kl00wT
	fk81J8sDWXWdfJZCdSR2VJaq+FJq63MHsKg3oundZsEbEIHMKyBI2F60SLfijGo4ggudpjRKLBO
	FL9qhQsXgR4rsep88QYzkRQTQZ8AmpoulyNeyCqCI1hRIFooEfRZKlc3Z7y6jUxkQQL/vg7ys8y
	gHxowN9HNKEJA+rW6QEH+k8LzqrJ4aOE0TCrnm8jn/6dyjNgfohe7GljdE9fWw3k8aDzjHlwHpQ
	0+2SLvfDP2s5S1TLtzDSIK/kgOcC0HhKfdsPGTd2x5K2KU6KmmjKcgquu9LZHzcRQch8nIGwinZ
	b2x2Ajk1WkQGlcExTtr4UX0uHEA28w3nwriwTeaimRc4+7RtBwnUAmzoXT7pKBP81JmOYj5AyqJ
	P74H/Uvc9bmMCOFccGu/1doaeVCHlzlaJDQAAlar2zfutzTneIZwz9t7ch2+yfGfmi79Bydx/ZE
	n67nL6GDeJ34kUG9Ltc0G7BZjivmJWX3nKpC6YNuEI5qg==
X-Received: by 2002:a17:903:2d0:b0:2c1:ee6e:be1d with SMTP id d9443c01a7336-2c665ec6cc3mr1663605ad.27.1781446256310;
        Sun, 14 Jun 2026 07:10:56 -0700 (PDT)
Received: from google.com (112.174.16.34.bc.googleusercontent.com. [34.16.174.112])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37a233f4531sm7699437a91.2.2026.06.14.07.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 07:10:55 -0700 (PDT)
Date: Sun, 14 Jun 2026 14:10:50 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Suren Baghdasaryan <surenb@google.com>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Christian Brauner <christian@brauner.io>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
	Lorenzo Stoakes <ljs@kernel.org>, netdev@vger.kernel.org,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Todd Kjos <tkjos@android.com>
Subject: Re: [PATCH v2 2/5] binder: Make shrinker rely solely on per-VMA lock
Message-ID: <ai62ap9SS3KTpqeR@google.com>
References: <20260610230413.D68967BC@davehans-spike.ostc.intel.com>
 <aipphZ5iCnbXVNSR@google.com>
 <CAJuCfpHmem_g7mEoic7O56LVSLkbftgWYgzexPWy7VSwp7_SiA@mail.gmail.com>
 <131c6a49-9177-418b-a653-8f13942fb8d3@kernel.org>
 <876077cc-db6a-4517-9d81-cdfbb43e599e@intel.com>
 <CAJuCfpFh60wULMkFc7hzxWNg+qmZ2R_HMw_QZe5CNcDRFuoN6A@mail.gmail.com>
 <e9e196ff-7428-43bd-8e06-dc2cf0628c9e@intel.com>
 <CAJuCfpFo_avdhpOviX7EsPqLgDJ3DfeGpth+yu1-ahfawqaSzw@mail.gmail.com>
 <2da031dd-4442-45b7-9515-72ffc60e8d8c@intel.com>
 <aixi-DxMuc0MiGeO@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aixi-DxMuc0MiGeO@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299228-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:dave.hansen@intel.com,m:surenb@google.com,m:vbabka@kernel.org,m:dave.hansen@linux.intel.com,m:linux-kernel@vger.kernel.org,m:akpm@linux-foundation.org,m:arve@android.com,m:christian@brauner.io,m:dsahern@kernel.org,m:davem@davemloft.net,m:gregkh@linuxfoundation.org,m:Liam.Howlett@oracle.com,m:linux-mm@kvack.org,m:ljs@kernel.org,m:netdev@vger.kernel.org,m:shakeel.butt@linux.dev,m:tkjos@android.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[cmllamas@google.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[google.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmllamas@google.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4421681420

On Fri, Jun 12, 2026 at 07:50:16PM +0000, Alice Ryhl wrote:
> On Fri, Jun 12, 2026 at 11:47:59AM -0700, Dave Hansen wrote:
> > On 6/12/26 10:44, Suren Baghdasaryan wrote:
> > >> It's not impossible, but I do think it is irrelevant. Or at least that
> > >> the *VMA* is irrelevant in this case. binder_alloc_is_mapped()==false
> > >> means that the binder VMA is gone. It's not in the maple tree, and it's
> > >> not coming back. If a VMA is found, it's an impostor.
> > > Right, but before your change we were bailing out early. With your
> > > change we would be generating the traces and freeing the page. I think
> > > that's a functional change. Was that your intention?
> > 
> > Yeah, it was intentional.
> > 
> > I think the existing behavior is buggy. It also complicates the goal of
> > removing the mmap lock fallback. I've broken that behavior change out
> > into a separate patch. (attached here)
> 
> I think you can just:
> 
> 1. do a lock_vma_under_rcu().
> 2. if it fails, check binder_alloc_is_mapped().
> 3. if still mapped, return LRU_SKIP, otherwise behave like a failed
>    vma_lookup() does today under the mmap read lock.

Right! This is the same suggestion I sent.

...
Also, I would _prefer_ if the commit message was more accurate. The
mmap_lock fallback was there because of "compatibility", as per-vma
locking is technically behind CONFIG_PER_VMA_LOCK. This would be the
only part that IMO describes the actual reason for the change:

> Now that per-VMA locks are universally available, lock_vma_under_rcu()
> will not persistently fail. Rely on it alone and simplify the code.

Cheers,
--
Carlos Llamas

