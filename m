Return-Path: <netdev+bounces-139933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 987379B4B38
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 14:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF142847D0
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 13:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2419B206051;
	Tue, 29 Oct 2024 13:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="QS0eT6jd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F6C20110B
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 13:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730209729; cv=none; b=U8eRF2U0yJHit/+y6vfI7Ehl4qmjealaPzSptdXkzxG0sjxrXJtsQBt/XQHQMxxhJVxIIDRS+y2aEDYafiEFmVkwu1zI0S2fVeva+d+J1r9v4sDn2esBlCdd8z/4VAtV6VYgObhcClSD/FTSGKwLfHAZ0BQx+DY5jvmIBlDIdio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730209729; c=relaxed/simple;
	bh=61dsj1PasILu65UaLrfL0HzWdDbD1vyqbhmC3CX3aJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZcEms2zibT5StLVxNjdHVnFIOfdon8psR1IEYPZuZXmvcY/6sIrcdpXVqTqmaS7P45NdGyVBL98Xm6Izw9xktVQz1YRH4L7K0oLk2+RKm1e4bFzcbgA8rgvBcLih1zUMDAY/z6ygYiGCktYHsMe9xrFDJx3lJdUxc9qN5WxQf18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=QS0eT6jd; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7180dc76075so2806869a34.3
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 06:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1730209726; x=1730814526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwPgAMavAEXO6C26tryLIudfVuj8YRS3X4MpACE1QyQ=;
        b=QS0eT6jdat2wIq/L5NKQH+YMbs8zVtl7e0UYapWT0QF2Dd2fqZVVwB8HA3pbKE401/
         ia9wZx6w1DvLR0zVHMKiLCCbw1hJ0r3P8EQdFmlsT0uwyHw0Sx/NvkswbIkOBvGKjod+
         ckIiZa9Ligm41k1Hp28nRn3zP5fLWow28EK7HXFnwmArom1Xq6LTsky2oh4SYjMmsbpE
         KiPcykQA1/P/R7S3ceL3lmcfIy2XSuYxES8KDod28nYMut3SKamJAlimdHf1mYt/iChI
         kfh58RVL94JhU8lb1JKU7U4BBUlCxe8iza0430WbBuyb2lmgtvkZGTSlG3wlFkYPk9Q8
         3E9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730209726; x=1730814526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YwPgAMavAEXO6C26tryLIudfVuj8YRS3X4MpACE1QyQ=;
        b=W2I2Yeq6+yYD/k3KjKOISkl1jGzsAx4UR8XkVPCzF4LFO4vkkr6tXvGWB77oi00PoV
         8AyI9qIUBivdnH01x7ZNXK3TJbZ/khbO9t6aUF6FdVfF9ZD1QNp0oOLDkNPw6b1wxXbN
         xPuQK3rqiKkJ8n9lCTDAQTcww71Z7oNWrJMYLmsiqocQQMX2zn42xPJSSWaFXTrB1ury
         nwAAe6ju5PjT4ZPYnn98PLk8cxbGLJZUBNnVLsmQ92p3BYFLKTi8vvBZAP9g8wnymaF0
         7MtGBhtZc2yO4BEF7Zf75QmLec51MWXG386jxqDoSVJZVtoX0S595tVNxpiJk+Ds0e12
         P3Yw==
X-Gm-Message-State: AOJu0YyRZyjdujHTT/JjxOogJSYxmm7kljaLyq9PiOFz5Q4Bd5tmaOYl
	xOTCcNo4eFs1CLwSTCy4E14zXyd2UjyWaiiP7VUSDjm/FzzXAQNmDwv+Geqk2z1WsOsSOBBGhkM
	REh7Bj+iDwP3UAtPktyiBTb4O0R5l435lfiBVHnk2TLEiDlM=
X-Google-Smtp-Source: AGHT+IERVKkHC5wJalI3mqRzZ/A5PH2xSU4Bs1ARGGwATY+YubjlmvmeSh/2Up4XIkOrOQ05tH86OxjHKUp+rjKh6jA=
X-Received: by 2002:a05:6870:1687:b0:287:29a0:cfe4 with SMTP id
 586e51a60fabf-29051d3e1acmr10332986fac.32.1730209725886; Tue, 29 Oct 2024
 06:48:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023100541.974362-1-vladimir.oltean@nxp.com>
 <CAM0EoMnV3-o_4L3Vv=TuEqC=iNKhNnW0c4HQiRqrJD5NtjKeOQ@mail.gmail.com> <20241025124023.qp5y67slaac7iqll@skbuf>
In-Reply-To: <20241025124023.qp5y67slaac7iqll@skbuf>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 29 Oct 2024 09:48:34 -0400
Message-ID: <CAM0EoMkBZx0qk5MR4jyeFn5T7eRco2n_Y58hryDtLTBjaOzEfg@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: sch_api: fix xa_insert() error path in tcf_block_get_ext()
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Pedro Tammela <pctammela@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 8:40=E2=80=AFAM Vladimir Oltean <vladimir.oltean@nx=
p.com> wrote:
>
> On Thu, Oct 24, 2024 at 11:39:51AM -0400, Jamal Hadi Salim wrote:
> > On Wed, Oct 23, 2024 at 6:05=C3=A2=E2=82=AC=C2=AFAM Vladimir Oltean <vl=
adimir.oltean@nxp.com> wrote:
> > >
> > > This command:
> > >
> > > $ tc qdisc replace dev eth0 ingress_block 1 egress_block 1 clsact
> > > Error: block dev insert failed: -EBUSY.
> > >
> > > fails because user space requests the same block index to be set for
> > > both ingress and egress.
> > >
> > > [ side note, I don't think it even failed prior to commit 913b47d3424=
e
> > >   ("net/sched: Introduce tc block netdev tracking infra"), because th=
is
> > >   is a command from an old set of notes of mine which used to work, b=
ut
> > >   alas, I did not scientifically bisect this ]
> > >
> >
> > What would be the use case for having both share the same index?
> > Mirror action for example could be used to target a group of ports
> > grouped by blockid in which case a unique blockid simplifies.
> >
> > > The problem is not that it fails
>
> As mentioned, I don't have a use case for sharing block indices between
> ingress and egress. I did have old commands which used to not fail
> (incorrectly, one might say), but they stopped working without notice,
> and the kernel was not being very obvious about it. Had the kernel
> behavior in this case been more clear/consistent, and not failed any
> subsequent command I would type in, even if valid, it would have taken
> me less time to find out. Hence this patch, and also another one I have
> prepared for net-next which improves the error message.
>
> > Fix makes  sense.
> > Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> Thanks.
>
> > I am also hoping you did run the tdc tests (despite this not looking
> > like it breaks any existing feature)
>
> To be honest, I had not, because I had doubts that this error path would
> be exercised in any of the tests (and I still don't think it is).
>
> But I did run them now, they seem to pass, except for the last 11 of
> them which seem to be skipped, and I really do not have the patience
> right now to debug and see why.
>

You did fine, more below...

> ~/selftests/tc-testing# ./tdc.py
>  -- scapy/SubPlugin.__init__
>  -- ns/SubPlugin.__init__

[..]
>
> ok 1159 4cbd - Try to add filter with duplicate key # skipped - Tests usi=
ng the DEV2 variable must define the name of a physical NIC with the -d opt=
ion when running tdc.
> Test has been skipped.
>
> ok 1160 7c65 - Add flower filter and then terse dump it # skipped - Tests=
 using the DEV2 variable must define the name of a physical NIC with the -d=
 option when running tdc.
> Test has been skipped.
>
> ok 1161 d45e - Add flower filter and verify that terse dump doesn't outpu=
t filter key # skipped - Tests using the DEV2 variable must define the name=
 of a physical NIC with the -d option when
> running tdc.
> Test has been skipped.

These were skipped because it would require real hardware (typically
also for testing offload).

cheers,
jamal

