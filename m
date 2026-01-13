Return-Path: <netdev+bounces-249569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BA5D1B0F7
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 20:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C0C73015ED7
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 19:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E018636A015;
	Tue, 13 Jan 2026 19:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V73C823r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D3127057D
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 19:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768332746; cv=none; b=jDjVZVP0+m6UAZxEDt55P0yjXUBfPdI96Shog3l9Gq44hTVQ0BOStpBbWpOv6hHn1sHxLyuvYupd/rbCd0b5U99IFs2wYuc86GErb6LmRH0DZOIM7hAaJcxDFya9vw6DuLfUmG3uLRIUEGsC2f/QCEv5uU749QDtva77hIP4Z6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768332746; c=relaxed/simple;
	bh=d1VCtjj7cVya6MZTtBwlMZaMcgKCOHjzsyH210DJl/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c6ASR/AH8LChLQQauEszlVp+M63lWVhWGhJWmQlMnDQ8EuiUqPRu/1ZI8DiBdqQ8uUYfbah7BAz7f4qCtBDEWgbt8Ya4eI7O4rnGd+cqOyS9UmZD4g3vWPJZlGDy/pHX+Wwd+6tHW68qxBoJBqhu0z4LI68lpD49LoNqyNivdC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V73C823r; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-93f5905e60eso4964953241.0
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 11:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768332744; x=1768937544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzAcQXW0+VMrSsxc+AImvg2uuT8BF5o11u9lZ3+Xqcg=;
        b=V73C823rrijplqq+pgi8vUwfUHnvs/J7KkhLcwLOaXRBPnanDOr59XdOSrn+RHsn5C
         UTUVSVeL/gZFVaKg8PquRWtGWsn+NLU1asE/se6pl9jsqLcY2xtRKV1zz/hlBhjKuvDe
         DMZSo2dm7WgS32b0kY4xW8pYgAC6UUcDaWjXB4pZTsTJqA4VdNT5cA1X8/e7LGxdEBjk
         Aez9Y6WOHpUQq5o0VEOin53/xMvBbtqRION4RefFeVu9oi/uf2DdGCPJXdjRMGAj/iRH
         RFQ0gyQDYNYKzK/TGrK1P4b0e5Hu/QQQ/hFwjgb/qIeF5BK6pypqXRnKGOgJP5Y+196O
         0u+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768332744; x=1768937544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CzAcQXW0+VMrSsxc+AImvg2uuT8BF5o11u9lZ3+Xqcg=;
        b=wQneHu02GNOqCdhiiDmoXkDkjRVBh6RFAHggCqDWODmff3DvihSviW4WzI4COAvXt2
         9Naw4nwxW4N1Auo2R+46jfYj8qfgOk8IW3g4RoQt4k1r+uumBp/InUefuNJC6tum1cfi
         ZZ/00QwSZ0jXzZn9wDBhGP1kgoOkI5AoduIy8MQXJ3vEdkN/We2Mz64HsH6apELHDy8e
         9lC+Vfj9gB2vVOIaRXVP7CiSinLVUl6IrZYjkPhrXENX4TWaIH7Wr+JhZmcoDxw/8n/f
         5VOsW4tc23RFSfuPVRZy88wUXborQuZyUwJaGpq03GmlClaNyxgMbRthGbfjWvfoMwci
         BbPg==
X-Forwarded-Encrypted: i=1; AJvYcCX9KPtQLLzdvZAKSGN2xpG2w/yXBLA7xrAsUjW+rfP/AWxd/6Qigt0jsx5MrI73p2rX/B9blOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz42q2t/g7NYEISSm/yltCjpyQWPyBDXq27wIrcSwont3y9wQ3C
	LHCNOqILmnmear1hvbHCcclPIJ717lrlHYDY4GNOOlpXzn887q3kSHUBbGMzR0WELGbksF/kf4U
	1fozxThSMrte30pGqWWlIkNVdJ3x+qqc=
X-Gm-Gg: AY/fxX4/aObTjJHhLmoKUlH4nNtkfmei9hJG+M1Utpz8Pbn8aLp4Y51R70brPQechCZ
	UWudmugpHESF5nNH3od/xP4PnafVR089CYe+rn7Cx7xHJSQA31rsB4TeLVrq4RuwAGhmwgqW4xB
	9r1Z0FBfZRCmpPueDlZw5aAmitIiu8ZbOU3tLy5yfUHgoMYkswMPoOdwwU+UQ86ntbWUGg8OIqR
	GDj4HSvTi+MTHRPw8qxVWl6KiKtrogRwlsyauW+sS9kUXauiNVQMjw8GQlLmQazndyUGW9xn+R8
	fUX3Tg5WEtd+UEROxiinEBx+mOgS
X-Received: by 2002:a05:6102:f86:b0:5ef:a9fb:f1f5 with SMTP id
 ada2fe7eead31-5f17f444459mr165987137.14.1768332744506; Tue, 13 Jan 2026
 11:32:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111163947.811248-1-jhs@mojatatu.com> <20260111163947.811248-6-jhs@mojatatu.com>
 <CAM_iQpVVJ=8dSj7pGo+68wG5zfMop_weUh_N9EX0kO5P11NQJw@mail.gmail.com> <CAM0EoMn7Mza5LqV5f6MMgacuELncbr1Ka6BOi7SA_2Fe3a7LCA@mail.gmail.com>
In-Reply-To: <CAM0EoMn7Mza5LqV5f6MMgacuELncbr1Ka6BOi7SA_2Fe3a7LCA@mail.gmail.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Tue, 13 Jan 2026 11:32:12 -0800
X-Gm-Features: AZwV_QgjnKKsEZ1YPPhn6INdNnx6MAEfEoP-7GL1P85eDTVCjK29S422tFLaiBU
Message-ID: <CAM_iQpUEgzQwrO5DJ05Rzx8CJJ660xZPcGqoD_SPJ2buo7K_Cg@mail.gmail.com>
Subject: Re: [PATCH net 5/6] net/sched: fix packet loop on netem when
 duplicate is on
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, jiri@resnulli.us, victor@mojatatu.com, 
	dcaratti@redhat.com, lariel@nvidia.com, daniel@iogearbox.net, 
	pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, phil@nwl.cc, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	zyc199902@zohomail.cn, lrGerlinde@mailfence.com, jschung2@proton.me, 
	William Liu <will@willsroot.io>, Savino Dicanosa <savy@syst3mfailure.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2026 at 1:57=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Sun, Jan 11, 2026 at 3:39=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.c=
om> wrote:
> >
> > On Sun, Jan 11, 2026 at 8:40=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > > -               q->duplicate =3D 0;
> > > +               skb2->ttl++; /* prevent duplicating a dup... */
> > >                 rootq->enqueue(skb2, rootq, to_free);
> > > -               q->duplicate =3D dupsave;
> >
> > As I already explained many times, the ROOT cause is enqueuing
> > to the root qdisc, not anything else.
> >
> > We need to completely forget all the kernel knowledge and ask
> > a very simple question here: is enqueuing to root qdisc a reasonable
> > use? More importantly, could we really define it?
> >
> > I already provided my answer in my patch description, sorry for not
> > keeping repeating it for at least the 3rd time.
> >
> > Therefore, I still don't think you fix the root cause here. The
> > problematic behavior of enqueuing to root qdisc should be corrected,
> > regardless of any kernel detail.
> >
>
> The root cause is a loop in the existing code, present since the

That's the symptom, not the cause.

