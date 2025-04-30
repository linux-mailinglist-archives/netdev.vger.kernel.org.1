Return-Path: <netdev+bounces-187156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F2DAA5506
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 21:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6310E9C025B
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 19:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2607264FA0;
	Wed, 30 Apr 2025 19:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+ZMxy0U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C501C1E9B19;
	Wed, 30 Apr 2025 19:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746042559; cv=none; b=AvwKQ+qHcB/10zYCygM9EUEOU4h6DpRH7idb14dLDw7WVPwQj97R49MNmnJyqxtWKI7gEu5ymQiK40UbaIBSR251ylxtwEOiQ7gIndYvse3B20OBZgQi5Z9HnD2Q4TvXroPhRAc0Qpp/mWhUzW7IRSJTEibB3AG2jvTrp/YcKC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746042559; c=relaxed/simple;
	bh=SMIqjX1PijUCBNJS6A0ie8/EUNwKLw21NX7N5LeVjr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fxru1q7wnzXlodnwCNYKzk0C+NW2MzThNp5N80m0ITXSKo42XJFtf4DAA73V+sd4+ILA+4qXoMROu1ABBDqjgOFAASnzPbYWFiUd9eHm5PhblY9+v7PnMNH+IQ1Cl9YqBAL5pY/2jS83bJ6wuYD+YfHSSrutYpWhO+Y33FmyRxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+ZMxy0U; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-acec5b99052so31434366b.1;
        Wed, 30 Apr 2025 12:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746042556; x=1746647356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5vFC8AhrZtOhJIds93Y4EHwr/YoR1RMhFCgXyxy4qo=;
        b=N+ZMxy0U8TPXfCgt+OFOt9E6KzZ73JQGpoldhJxz62wa+/ZsyskIc8KHHU7lQVpX49
         IyHxWgIu+JcNFxBgABgGn7wTeuBTJOJQomCF3+1JoWAe/s7HFcLPpHBYhmm2LqdlCRC7
         pElfJsr4/KRz3iVRNmK9p3C+0m1IKi5Kk+bjxFs5yGhE9/4FZpmqnor6z+jZIzhtssND
         D/+VmPEgo0sAAZ7Bey2hbao3pWZ9VnwNDrkvSbEEMkebvRvQ5bj6kNwOFmU6C2Lx/ruV
         UG1Qz62nhhNKVbZiGArRrkxFrj6M/qc43kJbJ1HK3DnWq5AztmXkLx36eqwJ2ZN3QMGR
         45tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746042556; x=1746647356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5vFC8AhrZtOhJIds93Y4EHwr/YoR1RMhFCgXyxy4qo=;
        b=oUJsWj8qKQSYXnTi0ZPMNLk5XAUbXzZROp7CdFSAil9OnJHPSkecWC0YDIPDra0l94
         Zgi3nWRhkMGFemYKEHzVri3BCns4h+DA/Jn40U9a9V/P9IwANmDhv8VOKlXRpadxJYdH
         pe5ERkDHzx7p2wYmbmQugI+q2yZk4xV4QlQ7yhCkVohtHY4RlKOcxG64RQ9VBA0Hytc9
         6k3jgX3AMzwSaqgVykSqwZ94q/eQXAdPA9RRxyt+wjDLGt0O1ytY5pdSwnBd5rN6B9s7
         uEg//W2rFKPc8TluB2x9LxdtcqexG5XxRn+yNSGIlY4kEs9eLmRMD6BcSayjIedeVfFd
         Z4EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSw+5xhYaGbPhaCoXYcCkfglukUCUVIu629FmOWDyHENZalPZSQtGn4mKUeAIcH+cOYk/dfqVn@vger.kernel.org, AJvYcCXKuiU94QKmGwot5qhVcntmiuEPUE6FmWVA/gDS1CgJplaPbYFvJlGl+X5gJlisJ2PPG3UvHMO1crmbpJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV7+naX5xGPWeJI8unWWl4nBJQFoKr1+SDhtq0CIUiNYvRPxCk
	f28mr0xP91sRosUinZEWzm6QFOFO9ma7jEEITFHetISZYQFTa6R2KvW70O5Y1afi+8C6MdD1B2D
	jMSniipfPX9VH1+hNBPnzKB17bfU=
X-Gm-Gg: ASbGncuLYQJc5z07V9iXpHOQ67SG76CY2TbjqyvBix/uf5aD7aAdTIxJEim8DEf5Wtq
	LswcfgyZBpdHiLX47/3wciGk1/tMv/3tPAEV5QBpywQzgYncK5PLCDKIWxbUDrGm4wIH1xC0hh8
	UwBCsyTtAkc7dk6Bm3D2v2kysZ8tTsPFI=
X-Google-Smtp-Source: AGHT+IHpT+iTWDFMpDYFHHF3i70rxCnGl9rhceHR3hYQzhGNL2ueWGAsYtHXahAnbbzOSF84ATohrmtx/W4nupgJxCo=
X-Received: by 2002:a17:907:7b9d:b0:ac6:cea2:6c7 with SMTP id
 a640c23a62f3a-acedc701d69mr453954466b.42.1746042555700; Wed, 30 Apr 2025
 12:49:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424080755.272925-1-harry.yoo@oracle.com> <lr2nridih62djx5ccdijiyacdz2hrubsh52tj6bivr6yfgajsj@mgziscqwlmtp>
 <aAtf8t4lNG2DhWMy@harry> <vd3k2bljkzow6ozzan2hkeiyytcqe2g6gavroej23457erucza@fknlr6cmzvo7>
In-Reply-To: <vd3k2bljkzow6ozzan2hkeiyytcqe2g6gavroej23457erucza@fknlr6cmzvo7>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 30 Apr 2025 21:49:02 +0200
X-Gm-Features: ATxdqUFl3ZIseT5-rXLXwt2orZP-o0_kcICmKwmBNRne1lS2Hq2Mm11zQAmstzI
Message-ID: <CAGudoHF4Tj+LcMSEZK3H3TF0Xc2xzf_NWro3ghXddOwVHNRTuw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Reviving the slab destructor to tackle the percpu
 allocator scalability problem
To: Pedro Falcato <pfalcato@suse.de>
Cc: Harry Yoo <harry.yoo@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Vlad Buslov <vladbu@nvidia.com>, 
	Yevgeny Kliteynik <kliteyn@nvidia.com>, Jan Kara <jack@suse.cz>, Byungchul Park <byungchul@sk.com>, 
	linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 12:42=E2=80=AFPM Pedro Falcato <pfalcato@suse.de> w=
rote:
> With regards to "leaf locks", I still don't really understand what you/Ma=
teusz
> mean or how that's even enforceable from the get-go.
>
> So basically:
> - ->ctor takes more args, can fail, can do fancier things (multiple alloc=
ations,
>   lock holding, etc, can be hidden with a normal kmem_cache_alloc; certai=
n
>   caches become GFP_ATOMIC-incompatible)
>
> - ->dtor *will* do fancy things like recursing back onto the slab allocat=
or and
>   grabbing locks
>
> - a normal kmem_cache_free can suddenly attempt to grab !SLUB locks as it=
 tries
>   to dispose of slabs. It can also uncontrollably do $whatever.
>
> - a normal kmem_cache_alloc can call vast swaths of code, uncontrollably,=
 due to
>   ->ctor. It can also set off direct reclaim, and thus run into all sorts=
 of kmem_
>   cache_free/slab disposal issues
>
> - a normal, possibly-unrelated GFP_KERNEL allocation can also run into al=
l of these
>   issues by purely starting up shrinkers on direct reclaim as well.
>
> - the whole original "Slab object caching allocator" idea from 1992 is ex=
tremely
>   confusing and works super poorly with various debugging features (like,=
 e.g,
>   KASAN). IMO it should really be reserved (in a limited capacity!) for s=
tuff like
>   TYPESAFE_BY_RCU, that we *really* need.
>
> These are basically my issues with the whole idea. I highly disagree that=
 we should
> open this pandora's box for problems in *other places*.

Apologies for the late reply.

Looks like your primary apprehension concerns dtor, I'm going to
address it below.

But first a quick remark that the headline here is expensive
single-threaded work which keeps happening on every mm alloc/free and
which does not have to, extending beyond the percpu allocator
problems. Having a memory allocator which can handle it would be most
welcome.

Now to business:
I'm going to start with pointing out that dtors callable from any
place are not an *inherent* requirement of the idea. Given that
apparently sheaves don't do direct reclaim and that Christoph's idea
does not do it either, I think there is some support for objs with
unsafe dtors *not* being direct reclaimable (instead there can be a
dedicated workqueue or some other mechanism sorting them out). I did
not realize something like this would be considered fine. It is the
easiest way out and is perfectly fine with me.

However, suppose objs with dtors do need to be reclaimable the usual way.

I claim that writing dtors which are safe to use in that context is
not a significant challenge. Moreover, it is also possible to extend
lockdep to validate correct behavior. Finally, test code can trigger
ctor and dtor calls for all slabs to execute all this code at least
once with lockdep enabled. So while *honest* mistakes with locking are
very much possible, they will be trivially caught and I don't believe
the box which is being opened here belongs to Pandora.

So here is another attempt at explaning leaf spinlocks.

Suppose you have a global lock named "crapper". Further suppose the
lock is only taken with _irqsave *and* no locks are taken while
holding it.

Say this is the only consumer:
void crapperbump(void) {
    int flags;
    spin_lock_irqsave(&crapper, flags);
    mehvar++;
    spin_unlock_irqsave(&crapper);
}

Perhaps you can agree *anyone* can call here at any point and not risk
deadlocking.

That's an example of a leaf lock.

Aight, so how does one combat cases where the code turns into:
spin_lock_irqsave(&crapper, flags);
spin_lock_irqsave(&meh, flags2);

In this case "crapper" is no longer a leaf lock and in principle there
may be lock ordering involving "meh" which does deadlock.

Here is an example way out: when initializing the "crapper" lock, it
gets marked as a leaf lock so that lockdep can check for it. Then on a
lockdep-enabled kernel you get a splat when executing the routine when
you get to locking "meh". This sorts out the ctor side of things.

How does one validate dtor? lockdep can have a "only leaf-locks
allowed in this area" tunable around calls to dtors. Then should a
dtor have ideas of acquiring a lock which is not a leaf lock you are
once more going to get a splat.

And of course you can just force call all ctors and dtors on a debug
kernel (no need to trigger any memory pressure, just walk the list of
slabs with ctor + dtor pairs and call the stuff).

This of course would require some effort to implement, but there is no
rocket science degree required.

However, given that direct reclaim for mm is apparently not a strict
requirement, my preferred way out is to simply not provide it.
--=20
Mateusz Guzik <mjguzik gmail.com>

