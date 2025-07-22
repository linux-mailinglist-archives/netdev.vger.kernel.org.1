Return-Path: <netdev+bounces-209088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3130B0E3D5
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 21:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820F31C8324E
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 19:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863BC27F18B;
	Tue, 22 Jul 2025 19:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B9T4zU40"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E203282F5
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 19:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753211042; cv=none; b=MFOebhGKcCFkfDZg6Q/w2L6k0XcSXb0QfVDdYf9SJLoEBY4tEAUNAznpN0bCHEMp/9U0ON/o5SWg0IkB7HgD95B67j4DZGfmYSV5ypCwXVrHO9QWeBZbrhs+e0/ybv3cKDJo1zVNo3MTiv09n+N0K5UldyzIyebguh0x+pKlgJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753211042; c=relaxed/simple;
	bh=DXIhcMM2WS826QQBNmEnnmJpIAj0rucxfdLc90w06iQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0l/ZEchQip4/8cNn2JV1tU02eN45X/iOJOH96NSQOHB3VOCuRullqQ3jcNL1eiGJRioL4IeyGlF9y89fcBCEBKpypUewopVVYlsYHxf5uNXVWE/FbibSwu3YOuHcTUGbziNcxqKgZNB89tWosH6kWY0ja949Imi6hhpIb18Dko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B9T4zU40; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b31c978688dso2853473a12.1
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 12:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753211040; x=1753815840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiA8Ffhznoaz71o6X2Lhv1DU3VKSS1u8j+C6Sx2f3R4=;
        b=B9T4zU40kQiVRCqqFLyS8PZP3PURnEyAERFWij4UCdtauOHnJvokpZaMPSQ8wQzIZl
         lQ2ZM6Jv/lXsxSnAoYkoaBmtvmyY0DV8S6EnozMZIaYq1ZhueW9ituTibiQpk+IX7x+O
         A2knbhGS1wh9F36SmqlPERcET2xiWutjNpTQZA40omXTKmYb7eQ9gkt+bC0MS0DwXCG0
         XbVDx3bqqAvjxOJk9py0H+VsB7EoZaT7RkMlRsEfpldTFyFGB8nQfdWTYD/wYAnGCFyo
         woA/u7EOqO0bSTKtzOx/HAKRrRLpC3b2Vvp5bfSnHUeLN15d5OvrcWTm+DFfRp7aVhMH
         jfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753211040; x=1753815840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iiA8Ffhznoaz71o6X2Lhv1DU3VKSS1u8j+C6Sx2f3R4=;
        b=puuVGomtLaK+JkwvEkAEetFxybzSy08703bhf1sJ4pDlhQQMktD5reYvkJreeiuUKi
         xIvtCfrWCMjYmfIBoaKLyuNnzf0zxAMzaPrcu9U4dsCvRe1qt49myFOAieUO5Vn4NuSi
         CILnkZXAoN6+rQmsAyH+n3bZNDTNa4Z7rxhI/A0LKqhOY0bZZHxM0jUVr1bkofcNmrrq
         w9sID7e8Rl6NXRGzMqP2btoYFRPPXUSiHHFL+c7qe4gW1q17Lx/BZEGFa5XjFvqDlIO8
         FKMFBF+fuOnk8I1S1TEafgFxEPSsSc9DaGnaX5W3JogUmgKnR+VtdDDJzjPylDOaFAWA
         oZ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/lehkToAWPZSB5PMpcOaszwVJFxp/3YgW87wnAjU0YOVZR58CpXvLNA9+90rRCT4sR+Kww0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzSv3E3jfgueZobCgsMr6q00kr/7tkZqR1X6zst9A7FeewUhb8
	fU0GIgJZesAeRxHSWhnXWVpiJ1bpDm1vntU68rpprn0JeRCntxF41EPjd1JcBwy+qR5ikvUvQ2t
	jFSFe0FSskOdj/5LZg1B66grLEX2o+WBPX9o1IYKO
X-Gm-Gg: ASbGnctqFbfuT+SxG1t3zoboLVosShuTcHQjqSH7dVQbo6mfcVHkamTgI82963TJObY
	fHtRlDK39TLWOirFdf787TC2jKqZFJGQnoz4Ipvvf9HJs244klKH9k+bAFoDLe88MeOnBSLiemO
	I9mkbXVKOd4p4YXKeafvIt+BdUPKftLoIoYdyypKw3Qch+gLIxjpJGo3sRO2H7gkqjal1DCykgV
	N3CBk15jTSVUhHalREAx511Ktal/gj/VL8zGA==
X-Google-Smtp-Source: AGHT+IGYBGaRF4+4yiskF7ML1G3zkbt1R2dprHwARsZQ44k60mvIUIP4kGdlv2eHeVBIwzBUJ7cUV3igAXlin7CBAhg=
X-Received: by 2002:a17:90b:35d1:b0:313:176b:7384 with SMTP id
 98e67ed59e1d1-31e5076981fmr533620a91.11.1753211040076; Tue, 22 Jul 2025
 12:04:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com> <20250721203624.3807041-14-kuniyu@google.com>
 <z7kkbenhkndwyghwenwk6c4egq3ky4zl36qh3gfiflfynzzojv@qpcazlpe3l7b>
 <CANn89iLg-VVWqbWvLg__Zz=HqHpQzk++61dbOyuazSah7kWcDg@mail.gmail.com>
 <jc6z5d7d26zunaf6b4qtwegdoljz665jjcigb4glkb6hdy6ap2@2gn6s52s6vfw>
 <CAAVpQUAJCLaOr7DnOH9op8ySFN_9Ky__easoV-6E=scpRaUiJQ@mail.gmail.com> <p4fcser5zrjm4ut6lw4ejdr7gn2gejrlhy2u2btmhajiiheoax@ptacajypnvlw>
In-Reply-To: <p4fcser5zrjm4ut6lw4ejdr7gn2gejrlhy2u2btmhajiiheoax@ptacajypnvlw>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 22 Jul 2025 12:03:48 -0700
X-Gm-Features: Ac12FXzbgoBRyeJ7XxGUPxk-8v86WqDVVO-Vj_Jc8u00Jp12117hni6mqwz8B-U
Message-ID: <CAAVpQUAk4F__D7xdWpt0SEE4WEM_-6V1P7DUw9TGaV=pxZ+tgw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 11:48=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Tue, Jul 22, 2025 at 11:18:40AM -0700, Kuniyuki Iwashima wrote:
> > >
> > > I expect this state of jobs with different network accounting config
> > > running concurrently is temporary while the migrationg from one to ot=
her
> > > is happening. Please correct me if I am wrong.
> >
> > We need to migrate workload gradually and the system-wide config
> > does not work at all.  AFAIU, there are already years of effort spent
> > on the migration but it's not yet completed at Google.  So, I don't thi=
nk
> > the need is temporary.
> >
>
> From what I remembered shared borg had completely moved to memcg
> accounting of network memory (with sys container as an exception) years
> ago. Did something change there?

AFAICS, there are some workloads that opted out from memcg and
consumed too much tcp memory due to tcp_mem=3DUINT_MAX, triggering
OOM and disrupting other workloads.

>
> > >
> > > My main concern with the memcg knob is that it is permanent and it
> > > requires a hierarchical semantics. No need to add a permanent interfa=
ce
> > > for a temporary need and I don't see a clear hierarchical semantic fo=
r
> > > this interface.
> >
> > I don't see merits of having hierarchical semantics for this knob.
> > Regardless of this knob, hierarchical semantics is guaranteed
> > by other knobs.  I think such semantics for this knob just complicates
> > the code with no gain.
> >
>
> Cgroup interfaces are hierarchical and we want to keep it that way.
> Putting non-hierarchical interfaces just makes configuration and setup
> hard to reason about.

Actually, I tried that way in the initial draft version, but even if the
parent's knob is 1 and child one is 0, a harmful scenario didn't come
to my mind.


>
> >
> > >
> > > I am wondering if alternative approches for per-workload settings are
> > > explore starting with BPF.
> > >
>
> Any response on the above? Any alternative approaches explored?

Do you mean flagging each socket by BPF at cgroup hook ?

I think it's overkill and we don't need such finer granularity.

Also it sounds way too hacky to use BPF to correct the weird
behaviour from day0.  We should have more generic way to
control that.  I know this functionality is helpful for some workloads
at Amazon as well.

