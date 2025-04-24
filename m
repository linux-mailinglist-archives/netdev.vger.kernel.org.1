Return-Path: <netdev+bounces-185609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A06A9B200
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 17:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B524A16D9
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEA11A315E;
	Thu, 24 Apr 2025 15:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6+W+JBW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6341A3161;
	Thu, 24 Apr 2025 15:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508075; cv=none; b=BRaY9BKA6iclsXLNqY+MJPvW0KTUbnntQeKVvNUpcMHiqKss61lIh9LjeWrdfPvAVVWgcotJoB2tlce4UjJs01np76yIgRGupiMZIowwhuupaF4co2AvQrsxeuTOqjK3PEBHNVGvkPZOJVu14tHmTblQXqK+8dCmLHT713NsjHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508075; c=relaxed/simple;
	bh=GC+PtHDYmmef0IxCV4hv6duPBITreI/6ZNwMatH+Tgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yi6GN8ijGvk8rv0FvV/asxVkiumab1U/cS8k0K6Z0sgLmzVQXx9pniosjNiNtrfHZj7SRnvTGhJK4rZ6taV9V7Fgr2nKQiHr1t0eQx5478tcZ2v1aargjMZArjLeHOr/V7v0NJdeOjQAhDllBJ8qoSjJuq9ENb2sQJ9jr15G3aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6+W+JBW; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5f624291db6so2008819a12.3;
        Thu, 24 Apr 2025 08:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745508072; x=1746112872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GC+PtHDYmmef0IxCV4hv6duPBITreI/6ZNwMatH+Tgg=;
        b=j6+W+JBWwIJ/e0FM7zETCz2a1iVNb2Ti7laK4HeHOe6RtVTzPEhsCmwUyHNoib0CH3
         5y4yQrak0774cLYVv2ahVR4HZ30XZXrN6QkczlK1ikymiwHJ6kotpRi3HmRnjSKWDU/r
         EpajwdkkyW3hqXw6XnX4KCkVC/DresB4/467ZTzthbBWylduQpNltNtCEzgPlZCOtwg7
         3K70kKf5YaJ2OhyJqOjT2twVnYBLjhI094WETg07xCh/STt2vUCn7e1O+dqbRqfJ7UDA
         LrPgY3RWqfhQCeZFJTlSRy3c6gGPuBFqt3lWAKZF5mkrjrVFq8h24ZWyibGAsv89UqRU
         FGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745508072; x=1746112872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GC+PtHDYmmef0IxCV4hv6duPBITreI/6ZNwMatH+Tgg=;
        b=bgcBzxJXjmFCQ+yFvyuxgTFh9ejYPozuV8gFE3zjDM/iTQ8kAPpha85MA8nZ/YpC6r
         86LHn/Zo2WLGO2n0TCNnU/OySJvDstVxRRuQoPqi6zWsO7REdlYuhrhbbV3OZwhVReM9
         iJCQt0JvFhGYnpZyVOVEoJUD9htjh5zmO71cyjDtUBxaW/tAodextXd0E2LaJGiIRV5h
         Bdm2CtSIQtRjYk6+T0jm1N8A0UmWlfLuJQsYEzKPFhisuTr5JbHiMyRJErTnshNyCOnU
         dugJC8X6/akxOmfKnIOX7Rw48LfX5VWzLHxwkoPvV2oKVWgiLe4u4qwyUNuYqhu/yHoa
         1a/g==
X-Forwarded-Encrypted: i=1; AJvYcCXuzrVe9zE+Ee+gDRLTWwvQgG7mKRpgxCSh5lYsJDfQV5NVoU6VUxLgp1ZdHcWKq/ZFYLMl6syD5gA4Yx8=@vger.kernel.org, AJvYcCXzt0i9qvOMvmxaXFKpMQqyupO8XM7dCnvtLYOhj9fGZaQVHkRSo3fOFs6uD+VsXKSHUXICSt4u@vger.kernel.org
X-Gm-Message-State: AOJu0YwJzd8icc/Lybd9s4jS4SxoSBT3pMcNhIpxdJV68tIf0z4xtBre
	ToU4UO1IJRfNeITYkkVgm0X69O2+BxbzCe5soJFNARjSCvqsOQeQNs8CyknF/xipydmTtVIWdPl
	kAaydx3LcKkdd5qQMUbFPK14PYSg=
X-Gm-Gg: ASbGncuaI4sDVl9jzCaMi1OS5ThNZ7kset2CMwLsTnvI91SU8H5mHDZuYaMAamKlky5
	QeI/O2Jt05negp60qcTHF7D/csIHy7DjmDg6AxcEFKekJtXfXdqtQF04a7sL/xHSGtNNvCf2RlD
	CsurkleX/EDF9TkZWcRH9K
X-Google-Smtp-Source: AGHT+IEdImTuRc3xMVstIZacqrqR7ovVhW5g7sBs2ZSRtcs3RwZU5YX4VlNzD8HzVelGQLKyFVRllpCEcLEgDxw0YVs=
X-Received: by 2002:a05:6402:34d1:b0:5ec:96a6:e1cd with SMTP id
 4fb4d7f45d1cf-5f6ddb0ae59mr2804678a12.2.1745508071566; Thu, 24 Apr 2025
 08:21:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424080755.272925-1-harry.yoo@oracle.com> <lr2nridih62djx5ccdijiyacdz2hrubsh52tj6bivr6yfgajsj@mgziscqwlmtp>
In-Reply-To: <lr2nridih62djx5ccdijiyacdz2hrubsh52tj6bivr6yfgajsj@mgziscqwlmtp>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 24 Apr 2025 17:20:59 +0200
X-Gm-Features: ATxdqUGZG_Q9xpHZ3X2jOpTAzlBs2c9IIdsj6KruiU8Xt92FFEuIAKEa75sHT38
Message-ID: <CAGudoHF8-tpc3nJeJ3gF2_GZZGp_raMBu4GXC_5omWMc7LhN1w@mail.gmail.com>
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

On Thu, Apr 24, 2025 at 1:28=E2=80=AFPM Pedro Falcato <pfalcato@suse.de> wr=
ote:
> > How to do this with slab constructors and destructors: the constructor
> > allocates percpu memory, and the destructor frees it when the slab page=
s
> > are reclaimed; this slightly alters the constructor=E2=80=99s semantics=
,
> > as it can now fail.
> >
>
> I really really really really don't like this. We're opening a pandora's =
box
> of locking issues for slab deadlocks and other subtle issues. IMO the bes=
t
> solution there would be, what, failing dtors? which says a lot about the =
whole
> situation...
>

I noted the need to use leaf spin locks in my IRC conversations with
Harry and later in this very thread, it is a bummer this bit did not
make into the cover letter -- hopefully it would have avoided this
exchange.

I'm going to summarize this again here:

By API contract the dtor can only take a leaf spinlock, in this case one wh=
ich:
1. disables irqs
2. is the last lock in the dependency chain, as in no locks are taken
while holding it

That way there is no possibility of a deadlock.

This poses a question on how to enforce it and this bit is easy: for
example one can add leaf-spinlock notion to lockdep. Then a misuse on
allocation side is going to complain immediately even without
triggering reclaim. Further, if one would feel so inclined, a test
module can walk the list of all slab caches and do a populate/reclaim
cycle on those with the ctor/dtor pair.

Then there is the matter of particular consumers being ready to do
what they need to on the dtor side only with the spinlock. Does not
sound like a fundamental problem.

> Case in point:
> What happens if you allocate a slab and start ->ctor()-ing objects, and t=
hen
> one of the ctors fails? We need to free the ctor, but not without ->dtor(=
)-ing
> everything back (AIUI this is not handled in this series, yet). Besides t=
his
> complication, if failing dtors were added into the mix, we'd be left with=
 a
> half-initialized slab(!!) in the middle of the cache waiting to get freed=
,
> without being able to.
>

Per my previous paragraph failing dtors would be a self-induced problem.

I can agree one has to roll things back if ctors don't work out, but I
don't think this poses a significant problem.

> Then there are obviously other problems like: whatever you're calling mus=
t
> not ever require the slab allocator (directly or indirectly) and must not
> do direct reclaim (ever!), at the risk of a deadlock. The pcpu allocator
> is a no-go (AIUI!) already because of such issues.
>

I don't see how that's true.

> Then there's the separate (but adjacent, particularly as we're considerin=
g
> this series due to performance improvements) issue that the ctor() and
> dtor() interfaces are terrible, in the sense that they do not let you bat=
ch
> in any way shape or form (requiring us to lock/unlock many times, allocat=
e
> many times, etc). If this is done for performance improvements, I would p=
refer
> a superior ctor/dtor interface that takes something like a slab iterator =
and
> lets you do these things.
>

Batching this is also something I mentioned and indeed is a "nice to
have" change. Note however that the work you are suggesting to batch
now also on every alloc/free cycle, so doing it once per creation of a
given object instead is already a win.

--=20
Mateusz Guzik <mjguzik gmail.com>

