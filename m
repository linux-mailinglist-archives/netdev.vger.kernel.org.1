Return-Path: <netdev+bounces-85040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAB58991AF
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 00:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C965FB25125
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 22:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2FB130495;
	Thu,  4 Apr 2024 22:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="bjOQuwrG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C7C6F099
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 22:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712271588; cv=none; b=onKR388O83QhKjgBPUuezl98az4ZGhMBesGdovhRS3biBqgv/8fKseP8Yrbx5NiVULrWMzwrdN21k7eq6axBpTrgyzSsTxjjxV+h372T3UP2d0agj3xFEWO5m9mD6cswCfsjoGdKQhyJMUR5raeMhiuq8Aeup9wHvSUECJiJOmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712271588; c=relaxed/simple;
	bh=3KfHzzVqCenEpli7+i2AT5/sHR3mXvJ+MXge6MSdt5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qgSR8eeuTbNJOB1PZFoMFNEyDVu9cZLSWB6UAVZWINNA7z/One9w0aR3ZOPD+abK8heHq5VDOwGA1Ua8sqaT2v1fgg3JbqdR0PjPgOnJI7TSceZ9McB85A0LuVEoTHFRI4hjVSDrQ4OXoMDiBTSvdXDeP3sJUQPdCMWuIYInRG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=bjOQuwrG; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcbd1d4904dso1661209276.3
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 15:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1712271585; x=1712876385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KfHzzVqCenEpli7+i2AT5/sHR3mXvJ+MXge6MSdt5s=;
        b=bjOQuwrGoarfwpwE5TAZWUSWmboHd6g+mMokeaRLELNCMUrRQPjv0Dwu05bZNqDVcO
         Xh/LKJgIBUhrABQBAKdZfcCg+UdP7NusN9KTE8YqwuDswQlwLX489XHmhkudAlfsFw4a
         6uSYOoKa7AMjmZo6UZIEkY+4nFjz/Am7aTgmQGhHWO1wzfEzulAdstAlyK/UGTj19bWQ
         uJmEKx5LdhHwelOiheyanMfUlmHxSWyH0CzCr5vdMa0Ceuz2QdJ2jVR6ZA4bl74rsxtf
         nfFhY3r0vqi0n2wrzx5xKiXCXKsFFXddBZz7mvs1+64nUUgVUWaCujzj3QpIAqnqMRzI
         DMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712271585; x=1712876385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KfHzzVqCenEpli7+i2AT5/sHR3mXvJ+MXge6MSdt5s=;
        b=sK/lgVcfpAkZvrFtQ51jYtbD2D0evNJOqIHNS0KJ+BKd34ZlzH9fmd1m6v0BMFF/Lg
         qdksomK8P8aAoypH2CZRkWuON3JKk0CC1fTAs9xUvT3F4xYFw06zx5YbfLvm6Wex7zkt
         fHJpr/4z9d8nrsvQyjvMy013dHAd8blVuhXWUGfK6tt9KNWuJcu1+sVBoGNWQ6UqmiT1
         bQkHABy+60XSOB43e5gdtfvwkIW02Nr/vS36TatNg2TKc2vnneCKe01jHTlr0CPfAIwV
         gSRzz9tTGbw2/8rio8hI35pfm47SfPTcVV0UyZCkRTEz04XIRZuxOU/rSsqwwN/X9IvY
         +bTg==
X-Gm-Message-State: AOJu0YzUaMvgvSnoFVN+YswzEI6mWmLLXvCDD9f+U9Cn8ZEWbbVgKtoZ
	DRDZVf2HqiwBSucAGXNxWGE4MMaiTkUFF+sIpYofk9gCmF2MVoaAo0TR3fsO4DLvwznUYo6hgmz
	ng5iB/lpwQyf3fXRxkFmb6LkBMZ28u4yxvUi8
X-Google-Smtp-Source: AGHT+IHLYSIJJn5ZiLgss5d1MGDVMo1TD0IPyPLYXbC8xwTw5TvM3TyTgIuW4IFiESXjSKc+lhbxKbeE7yxzTfVhEGE=
X-Received: by 2002:a5b:64d:0:b0:dc6:3610:c344 with SMTP id
 o13-20020a5b064d000000b00dc63610c344mr903126ybq.13.1712271585426; Thu, 04 Apr
 2024 15:59:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404122338.372945-1-jhs@mojatatu.com> <20240404122338.372945-15-jhs@mojatatu.com>
 <CAADnVQLw1FRkvYJX0=6WMDoR7rQaWSVPnparErh4soDtKjc73w@mail.gmail.com>
In-Reply-To: <CAADnVQLw1FRkvYJX0=6WMDoR7rQaWSVPnparErh4soDtKjc73w@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 4 Apr 2024 18:59:33 -0400
Message-ID: <CAM0EoM=SyHR-f7z8YVRknXrUsKALgx96eH-hBudo40NyeaxuoA@mail.gmail.com>
Subject: Re: [PATCH net-next v14 14/15] p4tc: add set of P4TC table kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Network Development <netdev@vger.kernel.org>, deb.chatterjee@intel.com, 
	Anjali Singhai Jain <anjali.singhai@intel.com>, namrata.limaye@intel.com, tom@sipanda.io, 
	Marcelo Ricardo Leitner <mleitner@redhat.com>, Mahesh.Shirshyad@amd.com, Vipin.Jain@amd.com, 
	tomasz.osinski@intel.com, Jiri Pirko <jiri@resnulli.us>, 
	Cong Wang <xiyou.wangcong@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, khalidm@nvidia.com, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, victor@mojatatu.com, 
	Pedro Tammela <pctammela@mojatatu.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 6:07=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Apr 4, 2024 at 5:48=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
> >
> > We add an initial set of kfuncs to allow interactions from eBPF program=
s
> > to the P4TC domain.
>
> ...
>
> > Note:
> > All P4 objects are owned and reside on the P4TC side. IOW, they are
> > controlled via TC netlink interfaces and their resources are managed
> > (created, updated, freed, etc) by the TC side. As an example, the struc=
ture
> > p4tc_table_entry_act is returned to the ebpf side on table lookup. On t=
he
> > TC side that struct is wrapped around p4tc_table_entry_act_bpf_kern.
> > A multitude of these structure p4tc_table_entry_act_bpf_kern are
> > preallocated (to match the P4 architecture, patch #9 describes some of
> > the subtleties involved) by the P4TC control plane and put in a kernel
> > pool. Their purpose is to hold the action parameters for either a table
> > entry, a global per-table "miss" and "hit" action, etc - which are
> > instantiated and updated via netlink per runtime requests. An instance =
of
> > the p4tc_table_entry_act_bpf_kern.p4tc_table_entry_act is returned
> > to ebpf when there is a un/successful table lookup depending on how the
> > P4 program is written. When the table entry is deleted the instance of
> > the struct p4tc_table_entry_act_bpf_kern is recycled to the pool to be
> > reused for a future table entry. The only time the pool memory is relea=
sed
> > is when the pipeline is deleted.
>
> TLDR:
> Nacked-by: Alexei Starovoitov <ast@kernel.org>
>
> Please drop this patch (all p4tc kfuncs) then I can lift
> the nack and the rest will be up to Kuba/Dave to decide.
> I agree with earlier comments from John and Daniel that
> p4tc is duplicating existing logic and doesn't provide
> any additional value to the kernel, but TC has a bunch
> of code already that no one is using, so
> another 13k lines of such stuff doesn't make it much worse.
>
> What I cannot tolerate is this p4tc <-> bpf integration.
> It breaks all the normal layering and programming from bpf pov.
> Martin explained this earlier. You cannot introduce new
> objects that are instantiated by TC, yet read/write-able
> from xdp and act_bpf that act like a bpf map, but not being a map.
> Performance overhead of these kfuncs is too high.
> It's not what the XDP community is used to.
> We cannot give users such a footgun.
>
> Furthermore, act_bpf is something that we added during early
> days and it turned out to be useless. It's still
> there, it's working and supported, but it's out of place
> and in the wrong spot in the pipeline to be useful
> beyond simple examples.
> Yet, p4tc tries to integrate with act_bpf. It's a red flag
> and a sign that that none of this code saw any practical
> application beyond demo code.
> We made our fair share of design mistakes. We learned our lessons
> and not going to repeat the same ones. This one is obvious.
>

It's the same old aggression from you "if you dont do it the way i
would have done it then it is wrong". Maybe it's how Meta or Cilium do
things, but that imposition on other people is just plain rude.
I have heard you shit on tc many times and it's not just tc everything
else sucks if it is not from you. It's your prerogative. Sorry, we are
not going to use tcx because it doesnt suit our goals. We are going to
use tc actions and filters. You do you, we'll do us.

You've been going around telling people they dont have to post any
kfunc to the ebpf mailing but it is still preferred to upstream.
That's what we are doing.
You do realize we can make this kfunc an out of tree kernel module but
we opted to share with the community.
 We initially posted a solution that didnt use ebpf and the push back
was to use ebpf. I know you act like ebpf is your property but it is
not. We will use ebpf/xdp/kfuncs whenever they make sense to us. Sigh.
This community is getting more political by the day. Open source is
about scratching your itch - this is our itch.

cheers,
jamal

> So please drop all bpf integration and focus on pure p4tc.

