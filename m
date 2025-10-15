Return-Path: <netdev+bounces-229795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDD8BE0DF3
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 23:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96DE6426FE3
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 21:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127BF303A2E;
	Wed, 15 Oct 2025 21:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="QE+WS5VA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A162D24AC
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 21:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760565056; cv=none; b=SBrGaTOpAHa8s6l/XwgZVACOtIG5NwUaFhvLcljByTn39A75pz0U+Id5jkFDn7cu8BzouqGRuL1Sf2Ogp+avc4eitzbPZLg9xlQyK2gmlitY1/Y0FOf5PM3ZfIU592XFI3flpMXAXABnV+scWLuMd787mZZvM+w2lmBOht6zTIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760565056; c=relaxed/simple;
	bh=iduM9BCUy9A1PPFJTP7NoUXJkN4FJL3UKtirvC6QjRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIwlYOdHkS9RieBsSk0Uxda91xuOoMpPRGU6JK6ZDuhzlrDlbGK6li+YyMZAFiSo6qCSQwYdWv4IP+Xh7ubqHbSXOa9wg/CYSqFi+5fIdd32XCMLWr7Jc5LtEbz5NPrz2BbyTXs4YHGnj/fOZM1V+NxWVIy2ujMPsAWSCwM5zjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=QE+WS5VA; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-781001e3846so92069b3a.2
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 14:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1760565054; x=1761169854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iduM9BCUy9A1PPFJTP7NoUXJkN4FJL3UKtirvC6QjRM=;
        b=QE+WS5VA0TWfN8btw/Vp76HeZs4mypDhpa/gyTXyDKRq59mTPhWVwpj9gwDtwLMNWc
         36Ik+ISxb11fTe7AIvf92Qo24MO+sgJrXz7N/p3O5njUhOAuiVa2+mJp1Fy77dQl5zEY
         RHtjmkBiAmXWuOrSEcfUGXO7Mw3PW7eoG0tEL4/m8nvwJDfi42IFSRV5zvzy8cWErBkU
         623bk8sFmoF+YsWSfIVVslJf7SiNXRSTU/zcEGx97td4jr1v2ujTOpEw5GH0YgnLLk/I
         bDQHBZFd6btSKeH2SpQ93FS5dyDYeOaCho4DtcHi3afivDgFKTRMvczRctUOFClI6dpe
         xZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760565054; x=1761169854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iduM9BCUy9A1PPFJTP7NoUXJkN4FJL3UKtirvC6QjRM=;
        b=kRP4QzKrz8v7dRGzx7E14V1rnccyAkKvifglzXO+B3+Fo2czNJtKsCWI8ihFtFBy7s
         DZnVIUagZTBgKlYoQOkRlAyXmsD3WS2mViW0OZkMH1Uy/PJzaL78Fe4HLd/OweVSdjlK
         XZZm362GZ2Nw0+LIgOCOi3Ma7i3p1bdynaKrZUe72Q6Pd3KcemXkXVBPojoGfwtryhwK
         4qo6GA/yiBPzbsQDMZ+m2o4n/4AxvTrFv9yCU7vxVexW8/y72FWu6aGp8UR9ASiBooIl
         xuzVBL5dlcy6r6GZesbPlIXzIu19/vejqQ/tBnhnzpqJCu0Sc+FvtrIP1VV4H1sfuUBU
         /xWw==
X-Forwarded-Encrypted: i=1; AJvYcCWz9TPxpks12k2Wuyo54wSIlCCK9hXP4xvtL9fdRGCkH02rDq+gmEsa81obXOzQlm6Jwkp/LDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy40loXFrpGuX5dOd2xWwc9+oJCT6f5brM1d1TLrNzIEQ6NM0sx
	eAJL2JJJbkVybpuFdHE8gElsVNd9t0i2qn1/k2VLcroIVeTqT7dV1fj8bx0o8xrF/vuNXUCKQhu
	UtIXd3bH6i8vnx0uC699AfspehUt/xshiAxGwEqan
X-Gm-Gg: ASbGncsVtSbKq8u0TOlJQ7wd5iu632uwajjjx1n3N2rR66KySi4gEuDfs19TAeaaEqG
	ti/ifga6eGNyfpI2tW/6DWHxyxRbcIPhVDRTK6cgzU2Rpslz8Sv5xKHBEWjuoU2DpUDWF46gYRX
	NWrU47lab0V6fLdzDGTEI+ixWGyTA9sYkXmL9GwnnvrPupdedPKK9Q6VYUGEWzUrUBZNQ4wdaod
	PeeP7vCZ8WA6nVUlLV9wWKVlSN2qrvVjlM93V+mRIBR8xluN0MaJGnrLP7DxnJFXTzpwX/Jt9f8
	DS3Td+PNbJQp8hJMo8iqulc/BeCShTh4HxE/
X-Google-Smtp-Source: AGHT+IFwZrRh7ZKAhbIlR4D12tk51kY/fRatZwY2OQID0vS3YYNT414SduS1rI4gvIe3Me4Ogb4ysXIQ+xiEjdpPLrE=
X-Received: by 2002:a05:6a20:3ca7:b0:2e5:c9ee:96fb with SMTP id
 adf61e73a8af0-32da84ed584mr41211395637.59.1760565053849; Wed, 15 Oct 2025
 14:50:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <681a1770.050a0220.a19a9.000d.GAE@google.com> <68ea0a24.050a0220.91a22.01ca.GAE@google.com>
 <CANn89iLjjtXV3ZMxfQDb1bbsVJ6a_Chexu4FwqeejxGTwsR_kg@mail.gmail.com>
 <CAM0EoMnGLqKU7AnsgS00SEgU0eq71f-kiqNniCNyfiyAfNm8og@mail.gmail.com>
 <CAM0EoMmK7TJ4w_heeMuD+YmUdMyEz7VWKY+a+qMO2UN4GYZ5jQ@mail.gmail.com> <20251014201149.ckkw7okat3cv55qk@skbuf>
In-Reply-To: <20251014201149.ckkw7okat3cv55qk@skbuf>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 15 Oct 2025 17:50:41 -0400
X-Gm-Features: AS18NWBoDDX5v9apL36RaGrCWfEkUt2MPnhglXFLB138k75uT3ov8ARY2TM2AaI
Message-ID: <CAM0EoM=1swUNW5F2Ha4JCf3VW309m1S0JEpSqiyR5wH7e=YyJw@mail.gmail.com>
Subject: Re: [syzbot] [net?] [mm?] INFO: rcu detected stall in
 inet_rtm_newaddr (2)
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Eric Dumazet <edumazet@google.com>, 
	syzbot <syzbot+51cd74c5dfeafd65e488@syzkaller.appspotmail.com>, 
	Vinicius Costa Gomes <vinicius.gomes@intel.com>, davem@davemloft.net, dsahern@kernel.org, 
	hdanton@sina.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 4:11=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nx=
p.com> wrote:
>
> Hi Jamal,
>
> On Sun, Oct 12, 2025 at 11:52:54AM -0400, Jamal Hadi Salim wrote:
> > > > Yet another taprio report.
> > > >
> > > > If taprio can not be fixed, perhaps we should remove it from the
> > > > kernel, or clearly marked as broken.
> > > > (Then ask syzbot to no longer include it)
> > >
> > > Agreed on the challenge with taprio.
> > > We need the stakeholders input: Vinicius - are you still working in
> > > this space? Vladimir you also seem to have interest (or maybe nxp
> > > does) in this?
> >
> > + Vladmir..
> >
> > > At a minimum, we should mark it as broken unless the stakeholders wan=
t
> > > to actively fix these issues.
> > > Would syzbot still look at it if it was marked broken?
>
> I still have interest in taprio, but at the moment I can't look at this
> any sooner than the second half of next week (unless someone else beats
> me to it). I've added a note not to lose track.
>

Thanks!

> What is the situation with syzbot reports? I don't actively monitor them,
> only if somebody happens to email me.

These issues have been lingering forever..
They do get posted on the list. Here are samples:
https://lore.kernel.org/netdev/676d25b2.050a0220.2f3838.0464.GAE@google.com=
/#r
https://lore.kernel.org/netdev/67d2a576.050a0220.14e108.0030.GAE@google.com=
/
https://lore.kernel.org/netdev/67946a0c.050a0220.3ab881.0010.GAE@google.com=
/
https://lore.kernel.org/netdev/66e96979.050a0220.252d9a.000a.GAE@google.com=
/
https://lore.kernel.org/netdev/6777334a.050a0220.3a8527.0058.GAE@google.com=
/#t

They all point to the same bisected commit, but am not sure whether
they are the same issue

To get you on Cc from syzbot - i think we'll have to add you as a
maintainer for taprio if you'd be okk with that..

cheers,
jamal

