Return-Path: <netdev+bounces-185655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BCAA9B392
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 18:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D3841BA46C7
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 16:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECC42857CD;
	Thu, 24 Apr 2025 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMdhBgTb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4819E284B5C;
	Thu, 24 Apr 2025 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745511108; cv=none; b=Q7VGXUxFHBo65Ofd5E5yEeqipShlPT4TLP6w9mPO8qvmkpFgoK8dwPuq7zUJaypRpMWzu0hy3iVXMTf1pa7srltKeEdGtisF2bgs7rPI7Xqymx08ELieB+80d+o5CSQspefg35E1pZoq5sWsHQXLpmK8abSymAfCL+3kz7UHhPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745511108; c=relaxed/simple;
	bh=rBnYkBYfCKwOov8i1SK1rfC4Dy3fPUMul+NfsgVA7Bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RV0Cv17+Tly/P5oI7BwAnZw7AR4AG3aT+pYcL+qmWE75pdQs3cavhuW9COxoWLihtyy9drJNG+N8ClFbsY8Q9a3hHIM3x1n/fpuHrhXKho3EdMiKkc7KbHgUB8Q5tvCvfG1WLGMYWxS2SYnaTKZQ3vv3iGFRtApqJYcEPYbc3xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMdhBgTb; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5edc07c777eso1575234a12.3;
        Thu, 24 Apr 2025 09:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745511104; x=1746115904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBnYkBYfCKwOov8i1SK1rfC4Dy3fPUMul+NfsgVA7Bo=;
        b=HMdhBgTbSf43eOxojg8bnuYR9qSeWP79LcLSaDXpEEwywnOffGmFsFcjyuqbXA6/gz
         8k7tw7YGCWlaVCt2tcW+Gj95SD1rDeCv9Ob5SLwFgYeNqGsrFzC1oYeaatzMK1EJdqkF
         QNHOpLQSrearmjOHN2YxSpzIsAVg91Of9UDE4OJ/YSmYstvTdm6TZX32nhKXolcsn0PC
         85si1zwvFzAcL/mBMfThJfO6zRGdRyhCtuio8Ojm8VsqZ29kmRa7rfdee3g7xE/RNSlN
         Hmg9KTSj+OhTyuGdGVmM3dWElS9tMHtbQOXW57zy5vkAW+1kyomwwipQfXj+sUGRxxgB
         1C0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745511104; x=1746115904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBnYkBYfCKwOov8i1SK1rfC4Dy3fPUMul+NfsgVA7Bo=;
        b=Uptiha63YJ8CmSu3sNqKt1eyTVIoiFrwqnbTi/Su2BZsp7n1NWL3xFaigq47LvNZmG
         L5RLCzgUrKr5r/uKSPoCEkQ9fVMj6xyjfDA5LbojXhAy4qWk4s7qsIC/ZgfhSNymfSpB
         ZJYPbXDWmTUPytWS9aIE+CUM1YjDHDNStx0G3aqtjoUqpeDcfP0iFlC5JWHZ/ikTdb1E
         GLvgA+uwC9v5VTycGFvQ7LFnIzV+woBLd0SxLINCfD6IumMYIBd0InZ+fOSbPlT4lV6P
         tlV2uQWxMm1NoiVSVBLd8ZHCn/UOzYwr/Wplpief80YDCDtitCOhbKPpTrequ8nRSY0A
         ywCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+uk5kOVMA6g3AA5L2+k2HnyFpS6wlGPHN9X1BzOF/iPs/r7FnbhfdYHcGBg07rfnpgBa7BfM1@vger.kernel.org, AJvYcCX65Xc/JlII8/Wt36zFGqw5R1Dr7CMkCsPiP9SVHtzYmjeKAB40z9o3yGJ4TjEwU2JoaDVtLhjwH4sfm3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4r7LfkbkRZWD6eGITfdcS9QAa7F85p12Ajl9ia2UNt02KlOJi
	stAtY18nbQtqrAaPHIiq5AJs1S+WABbQC27MJ95hpEN+OgvAdtEkdtyeet0WZy+gl8/IpyN2dr8
	P/ddATlj8/v6TvaGxLt6H9JAo5kw=
X-Gm-Gg: ASbGncuZqWh4A4t9Hid6z+RpbDHJXugR2isNbrvnTubtD56SbXuGRJKqpDkBeSNtI57
	UUhbYw0pPS/wGRzjAaWo5ZE38xD+vrJA/MQr84ywj6Q/VRfC+4lGZhU+N7WDy2QLrjlGluqEpaW
	qUwd7/JZ4qINFvgoC48Gvq
X-Google-Smtp-Source: AGHT+IGby31M7pE/UqIvfEJsZQ9NUU69Wi1+xEDECqgWhfFYhid9VUDiXC1EruOMr6Bf2ISZOq6Rqz7wkWd+oIsEGDc=
X-Received: by 2002:a05:6402:35c5:b0:5de:c9d0:6742 with SMTP id
 4fb4d7f45d1cf-5f6de2bb65dmr2876390a12.9.1745511104137; Thu, 24 Apr 2025
 09:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424080755.272925-1-harry.yoo@oracle.com> <lr2nridih62djx5ccdijiyacdz2hrubsh52tj6bivr6yfgajsj@mgziscqwlmtp>
 <CAGudoHF8-tpc3nJeJ3gF2_GZZGp_raMBu4GXC_5omWMc7LhN1w@mail.gmail.com>
In-Reply-To: <CAGudoHF8-tpc3nJeJ3gF2_GZZGp_raMBu4GXC_5omWMc7LhN1w@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 24 Apr 2025 18:11:31 +0200
X-Gm-Features: ATxdqUGX-yYDU2lrQULg7WTQlr93U3bgOGgrBEp1CMvLz6ftZCTsRcY_hk0ktIw
Message-ID: <CAGudoHE3CgoeoCjW=qpvv0+AzsSGJQpRCMLObjnOO-uALa2xiQ@mail.gmail.com>
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

On Thu, Apr 24, 2025 at 5:20=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Thu, Apr 24, 2025 at 1:28=E2=80=AFPM Pedro Falcato <pfalcato@suse.de> =
wrote:
> > > How to do this with slab constructors and destructors: the constructo=
r
> > > allocates percpu memory, and the destructor frees it when the slab pa=
ges
> > > are reclaimed; this slightly alters the constructor=E2=80=99s semanti=
cs,
> > > as it can now fail.
> > >
> >
> > I really really really really don't like this. We're opening a pandora'=
s box
> > of locking issues for slab deadlocks and other subtle issues. IMO the b=
est
> > solution there would be, what, failing dtors? which says a lot about th=
e whole
> > situation...
> >
>
> I noted the need to use leaf spin locks in my IRC conversations with
> Harry and later in this very thread, it is a bummer this bit did not
> make into the cover letter -- hopefully it would have avoided this
> exchange.
>
> I'm going to summarize this again here:
>
> By API contract the dtor can only take a leaf spinlock, in this case one =
which:
> 1. disables irqs
> 2. is the last lock in the dependency chain, as in no locks are taken
> while holding it
>
> That way there is no possibility of a deadlock.
>
> This poses a question on how to enforce it and this bit is easy: for
> example one can add leaf-spinlock notion to lockdep. Then a misuse on
> allocation side is going to complain immediately even without
> triggering reclaim. Further, if one would feel so inclined, a test
> module can walk the list of all slab caches and do a populate/reclaim
> cycle on those with the ctor/dtor pair.
>
> Then there is the matter of particular consumers being ready to do
> what they need to on the dtor side only with the spinlock. Does not
> sound like a fundamental problem.
>
> > Case in point:
> > What happens if you allocate a slab and start ->ctor()-ing objects, and=
 then
> > one of the ctors fails? We need to free the ctor, but not without ->dto=
r()-ing
> > everything back (AIUI this is not handled in this series, yet). Besides=
 this
> > complication, if failing dtors were added into the mix, we'd be left wi=
th a
> > half-initialized slab(!!) in the middle of the cache waiting to get fre=
ed,
> > without being able to.
> >
>
> Per my previous paragraph failing dtors would be a self-induced problem.
>
> I can agree one has to roll things back if ctors don't work out, but I
> don't think this poses a significant problem.
>
> > Then there are obviously other problems like: whatever you're calling m=
ust
> > not ever require the slab allocator (directly or indirectly) and must n=
ot
> > do direct reclaim (ever!), at the risk of a deadlock. The pcpu allocato=
r
> > is a no-go (AIUI!) already because of such issues.
> >
>
> I don't see how that's true.
>
> > Then there's the separate (but adjacent, particularly as we're consider=
ing
> > this series due to performance improvements) issue that the ctor() and
> > dtor() interfaces are terrible, in the sense that they do not let you b=
atch
> > in any way shape or form (requiring us to lock/unlock many times, alloc=
ate
> > many times, etc). If this is done for performance improvements, I would=
 prefer
> > a superior ctor/dtor interface that takes something like a slab iterato=
r and
> > lets you do these things.
> >
>
> Batching this is also something I mentioned and indeed is a "nice to
> have" change. Note however that the work you are suggesting to batch
> now also on every alloc/free cycle, so doing it once per creation of a
> given object instead is already a win.
>

Whether the ctor/dtor thing lands or not, I would like to point out
the current state is quite nasty and something(tm) needs to be done.

The mm object is allocated from a per-cpu cache, only to have the
mandatory initialization globally serialize *several* times, including
twice on the same lock. This is so bad that performance would be
better if someone created a globally-locked cache with mms still
holding onto per-cpu memory et al.

Or to put it differently, existence of a per-cpu cache of mm objs is
defeated by the global locking endured for each alloc/free cycle (and
this goes beyond percpu memory allocs for counters).

So another idea would be to instead create a cache with *some*
granularity (say 4 or 8 cpu threads per instance). Note this should
reduce the total number of mms allocated (but unused) in the system.
If mms hanging out there would still be populated like in this
patchset, perhaps the reduction in objs which are "wasted" would be
sufficient to ignore direct reclaim? Instead if need be this would be
reclaimable from a dedicated thread (whatever it is in Linux).

--=20
Mateusz Guzik <mjguzik gmail.com>

