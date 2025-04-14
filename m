Return-Path: <netdev+bounces-182102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07827A87D2C
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 12:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94BC43BAFB2
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 10:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726D9263C8E;
	Mon, 14 Apr 2025 10:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7d8rnx0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D288525D8FF
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 10:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744625409; cv=none; b=q1j5jjVPK1Nj5ge9n21uS0IYtMctRyfsiZtmtDL6xkCguW4wJHkN9NEP1Khgz4B73ByUoN3cGmybhL9VjpKABDTlmLPBfRSCbYhQUMsV2iFVBux21nnuRMyr8ja0NHEYXR3P+00wBvjNHRHkUTYbdaG1HWz1ItCUI8voZGnd8Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744625409; c=relaxed/simple;
	bh=fGWwn0NFNGz3cyx9yOIs6RFqZALVqMR0ypHAWFSsy+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PwgP3/LbG4+PJaGfPzbijUC/O1s8ieFrujLTUdD6pLuYz/dlhukwz+8GvxjrbPuJMBOFVoJVSvPd82SQ07NEkCNhFYamwvmmE0vxPv1haIZG/NQ247FlLgT/Zd0ULUDlOIi/1es/ZEw9SSFhlKr7w4QQ51y3asghIv8FNYOhdzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7d8rnx0; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-301d6cbbd5bso4225385a91.3
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 03:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744625407; x=1745230207; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G4dyRQS+tNwC/wK8lTSjYczGh73JBS96X94A+tyYXEk=;
        b=k7d8rnx0xhDULSlJjkL++BNbZhJHc3S0TlCnoI8NCL7LqUkWMHiGATnr8iNemDAb+c
         tE9RwoTZ+Qw8rlN8ZT5RSlapQ1ZCDQ7NScyW4q5SsJ8WA8i/mvWO7UTr2GEphYiDSHVr
         OVLor8j4dsvT1eZWyXWPKS5zrxYie2nsVwZSrjTyhZgjxLglAR8sBZ4kvDOpa37lIqPj
         mJpuTcSG40ni2QN9S5PhEWZs1XFLhFU8q7OTwgPCePuME1Anw1NHCXs/hyh3lIDORyxA
         LHyXjOiUMaaqlxVKTaojh5Rc8M93OiOzWfqO/JfjgVpASAmJ0vWyyEmu+LKOlyN/Sg8g
         0kJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744625407; x=1745230207;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G4dyRQS+tNwC/wK8lTSjYczGh73JBS96X94A+tyYXEk=;
        b=m1nCkKEum6nIleljmpZP/yAbNoCHj4E5wu/qoXYdfV5/BbuPicBNVoFYfVMtGABDav
         KCy8sAR0Koud2vl4zA0RnAVWflJuv6YM4CHR/vDLCJfO4r6bI0DjlNssrr38WyMhavZj
         wNTXvnGOKQOt4znfGxoiFrVsobbm2jpr8FWf1p77krUb+RNb/YPwZFYZKyFGMYjoGIPW
         2q7k1HmY/Li4230Suo3ARzKyVXnrEabJRsruxUC/odtjAT9essDQA+ZslLiuPWTLg9MN
         z5KpLibq5k67pd8n7jeRhGX73JRhFQXkPR6XJRbFqCZSunBAZEg2Nyh+uyBMmk9yuQSY
         pP/g==
X-Gm-Message-State: AOJu0YwMauPDQrTULxuVh5qEWBm+t8unIjkDel1A68bNY8Z2KXftam/Q
	816U+AHQNJcRNUJ7pcSEyNlQnzwaOPvTNJRb/TjTLW/MhdEwRALtzx5Jc/Z0sYjTxYNJm4KXGm2
	IF7J4IYGm+pVrUVjVGJwgHU7f5SY=
X-Gm-Gg: ASbGncs6MHMKjG8q/NODV6Tiv1Gqwhj86U5HTYFpmu5jT+2wOn92ZeTWI3JYtJq+OyX
	q37gtFqy/U6krc2c99G02HxTgAga7KolKCqpP1+JHuGc5rkg0mzxQn/Sei+QpnSUAMqOu7yBUBn
	DSJkQcue6LE6QQmp1ba0IapdVDdex4HLzhAzDMvwmIbxkessPf
X-Google-Smtp-Source: AGHT+IEscJF5ijK5WAvqnTfCUswPqtHdQaGRM9PFu/pInN5ezfj3p9C1I8zQZjdXOQcLrmaeFWxu1RH1WL4+jOhkWPs=
X-Received: by 2002:a17:90b:2e44:b0:2ee:b8ac:73b0 with SMTP id
 98e67ed59e1d1-308236343famr16501427a91.2.1744625406774; Mon, 14 Apr 2025
 03:10:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414010912.816413-1-xiyou.wangcong@gmail.com>
 <20250414010912.816413-2-xiyou.wangcong@gmail.com> <CALYGNiOV2sJY5gQwMX+U6ot9fFURHLWW+F87pBtH3T-RLDL+5Q@mail.gmail.com>
In-Reply-To: <CALYGNiOV2sJY5gQwMX+U6ot9fFURHLWW+F87pBtH3T-RLDL+5Q@mail.gmail.com>
From: Konstantin Khlebnikov <koct9i@gmail.com>
Date: Mon, 14 Apr 2025 12:09:54 +0200
X-Gm-Features: ATxdqUHEDhkgN4tMe9E5qywx6IGrAJQLuvQg9T8OGmDu_jZdpcw8SCUos-D0mtA
Message-ID: <CALYGNiMtTKpn-BBPpnY+r9WxTPzgMB3rUS5ePO4HQNH1QgZEFQ@mail.gmail.com>
Subject: Re: [Patch net 1/2] net_sched: hfsc: Fix a UAF vulnerability in class handling
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us, 
	gerrard.tai@starlabs.sg
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Apr 2025 at 11:39, Konstantin Khlebnikov <koct9i@gmail.com> wrote:
>
> On Mon, 14 Apr 2025 at 03:09, Cong Wang <xiyou.wangcong@gmail.com> wrote:
> >
> > This patch fixes a Use-After-Free vulnerability in the HFSC qdisc class
> > handling. The issue occurs due to a time-of-check/time-of-use condition
> > in hfsc_change_class() when working with certain child qdiscs like netem
> > or codel.
> >
> > The vulnerability works as follows:
> > 1. hfsc_change_class() checks if a class has packets (q.qlen != 0)
> > 2. It then calls qdisc_peek_len(), which for certain qdiscs (e.g.,
> >    codel, netem) might drop packets and empty the queue
> > 3. The code continues assuming the queue is still non-empty, adding
> >    the class to vttree
> > 4. This breaks HFSC scheduler assumptions that only non-empty classes
> >    are in vttree
> > 5. Later, when the class is destroyed, this can lead to a Use-After-Free
> >
> > The fix adds a second queue length check after qdisc_peek_len() to verify
> > the queue wasn't emptied.
> >
> > Fixes: 21f4d5cc25ec ("net_sched/hfsc: fix curve activation in hfsc_change_class()")
> > Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
> > Cc: Konstantin Khlebnikov <koct9i@gmail.com>
> > Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> > ---
> >  net/sched/sch_hfsc.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
> > index ce5045eea065..b368ac0595d5 100644
> > --- a/net/sched/sch_hfsc.c
> > +++ b/net/sched/sch_hfsc.c
> > @@ -961,6 +961,7 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
> >
> >         if (cl != NULL) {
> >                 int old_flags;
> > +               int len = 0;
> >
> >                 if (parentid) {
> >                         if (cl->cl_parent &&
> > @@ -991,9 +992,13 @@ hfsc_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
> >                 if (usc != NULL)
> >                         hfsc_change_usc(cl, usc, cur_time);
> >
> > +               if (cl->qdisc->q.qlen != 0)
> > +                       len = qdisc_peek_len(cl->qdisc);
> > +               /* Check queue length again since some qdisc implementations
> > +                * (e.g., netem/codel) might empty the queue during the peek
> > +                * operation.
> > +                */
> >                 if (cl->qdisc->q.qlen != 0) {
> > -                       int len = qdisc_peek_len(cl->qdisc);
> > -
>
> I don't see any functional changes in the code.

Oh, I see. "peek" indeed can drop some packets.
But it is supposed to return skb, which should still be still part of the queue.
I guess you are also seeing the warning "%s: %s qdisc %X: is
non-work-conserving?".

Actually, following code cares about size of next packet so it could
be clearer to rewrite it as:

if (cl->qdisc->q.qlen != 0) {
    int len = qdisc_peek_len(cl->qdisc);
    if (len != 0) {
        <insert class>
    }
}

>
> >                         if (cl->cl_flags & HFSC_RSC) {
> >                                 if (old_flags & HFSC_RSC)
> >                                         update_ed(cl, len);
> > --
> > 2.34.1
> >

