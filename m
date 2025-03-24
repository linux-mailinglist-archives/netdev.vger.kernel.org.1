Return-Path: <netdev+bounces-177184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9BFA6E35B
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 20:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81F2D188699A
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 19:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7813192D8F;
	Mon, 24 Mar 2025 19:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abt1RDvI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DFA171C9;
	Mon, 24 Mar 2025 19:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742844074; cv=none; b=nmOkyoGpXVSOB1Z4NRXcdeaeB9zhTCrieMpX1dzy+MMn8ZeQ+7vjBt063ScW3pOj7S2Lo5RGt8xFmEiP+RWdO0K9iK9Fvrq3/OthLD1fvX1xN2TsFKKrHbWmHue9Pns4YXMubsUlylB+TNDm7P3Kez8TS95qVyGDHQtt70VJK5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742844074; c=relaxed/simple;
	bh=MC15kNVtFlElzpBmIaeBcDCa29DSscXjbTIaVbU/pf0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NW4WptE+MQerwS8eeAS8iIHBh8QaSCayaeXPfp6L56f8WmV601GQQNRak1vXXn4VinhJ/KZDrhNFImpZ+GURpAvi7FC081Zu9Mewm5tRfVgjM5ttQpzvuE/CWTJdMaRh6Of7ZZuAhn3b2LVn9j72M0+kZv/HepualrZeR1bkS3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abt1RDvI; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c08fc20194so988682585a.2;
        Mon, 24 Mar 2025 12:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742844071; x=1743448871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUlMkEDmKO4g9etZfMtOVg0T8/WM79ss9P0JktMQ2zc=;
        b=abt1RDvIfdRyU5ry5maU9+QHD86ex5+PoLfDJnrlYfuCld1WLs3lAOS0kDlAEQxg8a
         SBBiHF/FA93WOr1iSJ8SmqaFLrlEDoKhS8PnM/jbiN6y+U0l7/GcsuC+CSm3uEMF6M30
         mmgdh+UJU6ABuECa4lyYpS2LY5WEfyTHv/0lR4bo4EigVyEJkcUyjnqRv3OyU96N56ZY
         cnJkwrXVgLC/B9ZzSj5HHv2vpRPdYgwc1yPoBIs9+Enni4nyxY/NPhLFApW6K6O9Mfhm
         htDRbiEZfPuTas9q04074vmx0sfWbmE+gBwxKEvBOj/NtrgrwGvU4nIy8P+H+K+zyyBD
         nrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742844071; x=1743448871;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUlMkEDmKO4g9etZfMtOVg0T8/WM79ss9P0JktMQ2zc=;
        b=MbQlxybpt+E7HtSPuImGWogJ//qDoqlOYK9omEHt7blXpOAR3/GindieBAL4dB62CA
         bXjS0BA5qWslB+N3oxBUGZxm2ZicHVJJeiWaQTAOUdsnVNy0doKUZ69U775VX4XHXWNa
         ZLRErOHWHa0hHUvI1fM4VZi3f6doMpKUywmCqImKELcxtr3OlbwxUv0n55jVGbtRp/3n
         yfz0eMLYAZFEZ0z9fQCCC0U4D7MtcWtTKi4UjW1KzdYwl3PAqzMbrxLIs6b7de++MDAv
         ZDjee90ta+nPDFcLBV9Bz8bgniheL2rtkyiE1X9FKlaLXDTqEVx3YFC14ndb19Ckzzac
         JT8g==
X-Forwarded-Encrypted: i=1; AJvYcCVI0MwR7ZMoQy6P6Hbd8mLOG7oxwoeEIBNF2a59MRlUtoHh01joByWTu109x9+6sEz/xYAsbfenJcs6TvY=@vger.kernel.org, AJvYcCX/mqFKT1WlDTP352GBT3k/1rKwiSe1gYw/84XIPaGk9twbhamJFAqZhvTQsGitUaY+4i2FKr1J@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Rif94Fef25heiqiXxA6umo0DF71lrwHWqgWK0JavjIT6bnhS
	T0lt3XuDeE9uAuP5CIECkASKDoo2Q6NOF9Q/Pf5viM6Ujv5iCXg1
X-Gm-Gg: ASbGncvc5q5Ambuv37WhH6vF21qLwU5S6Se6R9B1bd25eqNA+fzlp/mdaw6zgPRLe3k
	q+ZG+RQlT0/PjUCxy3s7nzi/wwRCVYb0oxo520sBkzkxpBe37ADuSdAhR0GmFrSDW1ucyf2KCVT
	QBE2S0DHHSXXrzQ6facgGd7NKcleNDwMAJFz500azVU84OypZeOugP/dTbGx+ATLkTAJLkDm4zI
	hscbdtQ0gZYpPf8NsrQZFMVOyIb+QuZXJ6Nvuy4Mdb/X+9rJK4uTzIv3jpbyOluy46RmOgoRbZl
	a5Gi3dGgX5V/AE1C80lOVANlJngNDIyEzA0sEFY4JaZrqu5K1CfuhkGpzB8ITBDoNwHRq6Dwnzi
	UXi7LJV2yfVMQdHVe6R2AmnYa5CKGbVpnX8c=
X-Google-Smtp-Source: AGHT+IHlZj1w/+mISIfkyNw5FJ09GccvnRcsgJ3Q7IvGB+pzkn3YZg9EBqQE/B1rCpU0LJa6xe/zUg==
X-Received: by 2002:a05:620a:319d:b0:7c5:5e60:1d08 with SMTP id af79cd13be357-7c5ba208d09mr2448272285a.45.1742844070544;
        Mon, 24 Mar 2025 12:21:10 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92b827csm545263385a.14.2025.03.24.12.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 12:21:10 -0700 (PDT)
Message-ID: <67e1b0a6.050a0220.91d85.6caf@mx.google.com>
X-Google-Original-Message-ID: <Z-Gwo_fla-0FQc98@winterfell.>
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9E73D1200043;
	Mon, 24 Mar 2025 15:21:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 24 Mar 2025 15:21:09 -0400
X-ME-Sender: <xms:pbDhZ7twiNoQWVLvyPOGcHYR7uklvXGHAjB4YyIUTzGygCyUhx28cg>
    <xme:pbDhZ8cduv_UdtNAB2SSdmwqufWhR22cX4G4YfAfpQY49vsquzM_jNwcu1iG2RZzA
    E8L0BTHekVlFV2n0A>
X-ME-Received: <xmr:pbDhZ-zP0xXbcDlgq4ERHq1kfmXMvI4NT2fQ0BBuspcQF1gAe3QZyKHamiuU_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedtiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfel
    leeivedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghp
    thhtoheplhgvihhtrghoseguvggsihgrnhdrohhrghdprhgtphhtthhopehmihhnghhose
    hrvgguhhgrthdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhonhhgmhgrnhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprggvhh
    esmhgvthgrrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:pbDhZ6P7cDISGLX9n52PyWdIfw8x6k74XSSehOOFBAzZJ_z8aZNRpw>
    <xmx:pbDhZ79at4wZQ5yX4jqQCgSYAx6v1xsF0Ei_Pohy8ZLchErAr4mk9A>
    <xmx:pbDhZ6XZk3DbQPNqbcGe490v5TysoUH5hQZh9qdmgcf1IvagWG7p2w>
    <xmx:pbDhZ8d6N_HF4Fn-vO-6cqJ77eoeLjFGYmWTlng2-zh3N1nXT8zBqg>
    <xmx:pbDhZ5fdElfyJDilOjl7EaVbs_ZA7y1RfDHfhwq55P2SqsPiAsDG2HP_>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 15:21:08 -0400 (EDT)
Date: Mon, 24 Mar 2025 12:21:07 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Breno Leitao <leitao@debian.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, aeh@meta.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	jhs@mojatatu.com, kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] lockdep: Speed up lockdep_unregister_key() with
 expedited RCU synchronization
References: <20250321-lockdep-v1-1-78b732d195fb@debian.org>
 <20250324121202.GG14944@noisy.programming.kicks-ass.net>
 <CANn89iKykrnUVUsqML7dqMuHx6OuGnKWg-xRUV4ch4vGJtUTeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iKykrnUVUsqML7dqMuHx6OuGnKWg-xRUV4ch4vGJtUTeg@mail.gmail.com>

On Mon, Mar 24, 2025 at 01:23:50PM +0100, Eric Dumazet wrote:
[...]
> > > ---
> > >  kernel/locking/lockdep.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > > index 4470680f02269..a79030ac36dd4 100644
> > > --- a/kernel/locking/lockdep.c
> > > +++ b/kernel/locking/lockdep.c
> > > @@ -6595,8 +6595,10 @@ void lockdep_unregister_key(struct lock_class_key *key)
> > >       if (need_callback)
> > >               call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
> > >
> > > -     /* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
> > > -     synchronize_rcu();

I feel a bit confusing even for the old comment, normally I would expect
the caller of lockdep_unregister_key() should guarantee the key has been
unpublished, in other words, there is no way a lockdep_unregister_key()
could race with a register_lock_class()/lockdep_init_map_type(). The
synchronize_rcu() is not needed then.

Let's say someone breaks my assumption above, then when doing a
register_lock_class() with a key about to be unregister, I cannot see
anything stops the following:

	CPU 0				CPU 1
	=====				=====
	register_lock_class():
	  ...
	  } else if (... && !is_dynamic_key(lock->key)) {
	  	// ->key is not unregistered yet, so this branch is not
		// taken.
	  	return NULL;
	  }
	  				lockdep_unregister_key(..);
					// key unregister, can be free
					// any time.
	  key = lock->key->subkeys + subclass; // BOOM! UAF.

So either we don't need the synchronize_rcu() here or the
synchronize_rcu() doesn't help at all. Am I missing something subtle
here?

Regards,
Boqun

> > > +     /* Wait until is_dynamic_key() has finished accessing k->hash_entry.
> > > +      * This needs to be quick, since it is called in critical sections
> > > +      */
> > > +     synchronize_rcu_expedited();
> > >  }
> > >  EXPORT_SYMBOL_GPL(lockdep_unregister_key);
> >
> > So I fundamentally despise synchronize_rcu_expedited(), also your
> > comment style is broken.
> >
> > Why can't qdisc call this outside of the lock?
> 
> Good luck with that, and anyway the time to call it 256 times would
> still hurt Breno use case.
> 
> My suggestion was to change lockdep_unregister_key() contract, and use
> kfree_rcu() there
> 
> > I think we should redesign lockdep_unregister_key() to work on a separately
> > allocated piece of memory,
> > then use kfree_rcu() in it.
> >
> > Ie not embed a "struct lock_class_key" in the struct Qdisc, but a pointer to
> >
> > struct ... {
> >      struct lock_class_key key;
> >      struct rcu_head  rcu;
> > }
> 
> More work because it requires changing all lockdep_unregister_key() users.

