Return-Path: <netdev+bounces-90420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1618AE128
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 11:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 402381C218A2
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 09:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A72E58ADD;
	Tue, 23 Apr 2024 09:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qsg67ZD5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1011E863
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713865226; cv=none; b=iODmHMX/HfDLlvevlNvoHqScqzmdnet5l07AcfRWbxIPvQnvIAiirg20Y82fUmPDVLVwBKAcKFg2qLppsQ/3nDqcXLnFhD6ELySLFGlFixZGmP9BfZ4O/i8s1AAC9LqW4T1Ls8r8YBBs9j10511l/wbddc1a/sAM7C3o/Gb8rjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713865226; c=relaxed/simple;
	bh=Kw0NtqcrbAlk17kqAfzgFuxOxsbSsqlNFxBhqzrwRf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MxoEU+yqLpmnSywQxjvPY4tvTAaii9IXubHWdFfy53K0hGMTcoMV4czUJBZwlAjCPxOyKx/2HtLrVhyz5o4VlTVpLte8Aac4Hf7+HWXjp2yuxD3eGayPIrlCLPDjp3xefj9J5LHVoBIp28a8ahAQPsmiemuQPbh83PIg46xdneY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qsg67ZD5; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e5174ffc2so6198a12.1
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 02:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713865223; x=1714470023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kw0NtqcrbAlk17kqAfzgFuxOxsbSsqlNFxBhqzrwRf4=;
        b=qsg67ZD5y4aOZBTeh4d4ES4LBazAhuYCNeBtCjHbx6j+ZfN0LuwamN44b1+33Soumc
         H4f59PtYnfMinueHEMku5LLj/KqAEKFZYizfPxA+aPRtubalTcgOvp5pa5AggxbHkAVC
         2MEKucqnygFshYwQ8vCdXmLF/3BdP0ih6WLALdK77xr3QL6lvMlD765ujCcnQugGwgqh
         8RZgapWT5ezNO5M/PPHUUjZR3dpFA+yheVOKT5OBihUAdH7T10RcFl+gBewp0uaWrpRf
         CUGHvbmMxDDcl6JvYfNzI/jGK8aBhbAYdZyVqjbTAQji4CKd16E+vAdsnaIN9WjlE951
         Kcmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713865223; x=1714470023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kw0NtqcrbAlk17kqAfzgFuxOxsbSsqlNFxBhqzrwRf4=;
        b=TmaZb0xBl7e2X97CICBQk6K/OkTyva+mK7CvYBmIxJhrSjrBZ9cTkCOUmsOq/A+Tad
         DpEFAg+9ceT0GPZljr+aned0roMB2L93vwSesKFZdsZ9mkw20uLuUIauM/0TTImMvG8a
         gXiLVQDswkpuHLKrWP4i1BGj/gIZ0rzieSoj1KwzNYDfK5skemCbK+JZ7WoLQ8EyFQ0p
         MtJD/75AmCpGuc6hZs1SyJVj4FbvoxYQqM1/V+NSEBo0MlcyAK2EDh2UD/4OkAA4/3Ta
         FRnTyntZHax4aJObMru6NwbU5O74rrVAuVlZP4ji7dZEtjPRtFM36empQdj0x0HuKu9t
         jINg==
X-Forwarded-Encrypted: i=1; AJvYcCXONK5+722vKcpy3vWDsf8YsyAyqUfBZiD4Uw5QdcVKTJsQtDj8Oh0f4WUESBvsoqGPQEGS67UCnzspbODq294aU+giuuZe
X-Gm-Message-State: AOJu0YzJWPzS670r8n3FOeGqg8+/lRAWhBVPzdt0AzQQhZZsTwww7wC5
	Pim6tuaQbc6CEQhyeQZH1OLZMYFm/2p5r6Xq5Ql5n5UQb4bLaPFqBytC4nrvl/DQqXXtaE5PhYa
	28DNFMMdeaPynLI0p9AIBDLNW4YtsKQhbYVOd
X-Google-Smtp-Source: AGHT+IGODgn6RLijI4qvb/sVffIu/ww3JNUGMU8tjUcin5spxNo5FBRTHsCIAQWOsHr8Jzzwy/AfgAdZ8d1QCzKK8cM=
X-Received: by 2002:aa7:d947:0:b0:572:20fb:190f with SMTP id
 l7-20020aa7d947000000b0057220fb190fmr85622eds.3.1713865222687; Tue, 23 Apr
 2024 02:40:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7dc06d6158f72053cf877a82e2a7a5bd23692faa.1713448007.git.dcaratti@redhat.com>
 <CAKa-r6tZkLX8rVRWjN6857PLiLQtp92O114FYEkXn6pu9Mb27A@mail.gmail.com> <7ce1a0dba3cc100e6f73a7499b407176a99c0aa9.camel@redhat.com>
In-Reply-To: <7ce1a0dba3cc100e6f73a7499b407176a99c0aa9.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Apr 2024 11:40:08 +0200
Message-ID: <CANn89iKH9FQFjnkmSCX2qcjcvG2GZigT+hFgKEd6P4L5fvGmTA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net/sched: fix false lockdep warning on qdisc
 root lock
To: Paolo Abeni <pabeni@redhat.com>
Cc: Davide Caratti <dcaratti@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, netdev@vger.kernel.org, renmingshuai@huawei.com, 
	jiri@resnulli.us, xiyou.wangcong@gmail.com, xmu@redhat.com, 
	Christoph Paasch <cpaasch@apple.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Maxim Mikityanskiy <maxim@isovalent.com>, Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 11:21=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On Thu, 2024-04-18 at 16:01 +0200, Davide Caratti wrote:
> > hello,
> >
> > On Thu, Apr 18, 2024 at 3:50=E2=80=AFPM Davide Caratti <dcaratti@redhat=
.com> wrote:
> > >
> >
> > [...]
> >
> > > This happens when TC does a mirred egress redirect from the root qdis=
c of
> > > device A to the root qdisc of device B. As long as these two locks ar=
en't
> > > protecting the same qdisc, they can be acquired in chain: add a per-q=
disc
> > > lockdep key to silence false warnings.
> > > This dynamic key should safely replace the static key we have in sch_=
htb:
> > > it was added to allow enqueueing to the device "direct qdisc" while s=
till
> > > holding the qdisc root lock.
> > >
> > > v2: don't use static keys anymore in HTB direct qdiscs (thanks Eric D=
umazet)
> >
> > I didn't have the correct setup to test HTB offload, so any feedback
> > for the HTB part is appreciated. On a debug kernel the extra time
> > taken to register / de-register dynamic lockdep keys is very evident
> > (more when qdisc are created: the time needed for "tc qdisc add ..."
> > becomes an order of magnitude bigger, while the time for "tc qdisc del
> > ..." doubles).
>
> @Eric: why do you think the lockdep slowdown would be critical? We
> don't expect to see lockdep in production, right?

I think you missed one of my update, where I said this was absolutely ok.

https://lore.kernel.org/netdev/CANn89iJQZ5R=3DCct494W0DbNXR3pxOj54zDY7bgtFF=
CiiC1abDg@mail.gmail.com/



>
> Enabling lockdep will defeat most/all cacheline optimization moving
> around all fields after a lock, performances should be significantly
> impacted anyway.
>
> WDYT?
>
> The HTB bits looks safe to me, but it would be great if someone @nvidia
> could actually test it (AFAICS mlx5 is the only user of such
> annotation).
>
> Thanks!
>
> Paolo
>

