Return-Path: <netdev+bounces-158895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEF0A13AF7
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 14:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C83F16347A
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 13:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D026DCE1;
	Thu, 16 Jan 2025 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="n5BYQuBq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558EA143736
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737034454; cv=none; b=bcY/vLmru0TevrPpHu66mnjr7Eqpba4QUSt7oJXW2+eQ/9RVdmx37j60B5PNqSMTXv2Nz4fMcWuRoTgCs+cWQc5UoBPMJbZdAr6mTlEXaBEt9cbALG8eBYEXk6V1lHqsE81jjyxb8XcpD/P3ONcpwVFE8w+FfA1qP1HPBC0IWOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737034454; c=relaxed/simple;
	bh=8MjTj4fxV4tX0+m2fPX4OGlbYFCEQVQrfIO5mWXbyvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GuT2FA4Qd6sFNJBDrRWFKPvlfq9mTlpJVBhMf1ks2c75CsVmsPO2GgYLL6b3VikLr5IG/59UySkSnHLyvG1W5ODBZmd4qoVOlsL93TU9/OLtj+8C8Mg8mzAIKTh38NOfFHExtbMPNq0IpTkeNhbkCv3MJTm6pr2xbHavW9J7kg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=n5BYQuBq; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ee8aa26415so1638822a91.1
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 05:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1737034451; x=1737639251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJaD5Q2Yc+IS9WWAXzMO26oAA9f7zsOxSZjIsmFyt0c=;
        b=n5BYQuBqsU+alMmT4C+AmtpLmGguiNGWNTHWe+R2KrcSm68TM9a0DoXWgSHIsDJch5
         iUUW7GcfjIT9SnIAPe5cyO55Hn+EfSQMj5CJGeYF4KK//AzDqNd6jEilkFnkLpJSUM9m
         wd3GAHwpeZB2UGzag7X0fEykQ1seelBbTsIBVFp+lnT645wFhbIOIdgmLNuGHgjmnTXE
         rssxqBmjl4gCGoZ+FPjh0+bBEI+Y5vFVKAR++zv6myIzhS74UoNK5uTH1Z2HetQGR8FT
         tCMFoQmvzVmbDyYFxnrauZAXH5KqKJr/moldpDof8nFZj/N5XrRRGAw30+806Vdm9xh8
         voGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737034451; x=1737639251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJaD5Q2Yc+IS9WWAXzMO26oAA9f7zsOxSZjIsmFyt0c=;
        b=hsUYvgXzWmYL90y4NseAZktzRnY46uXRiT43ADyo8BZ6MMT+KyXdcVvXWp70fYOFtw
         tFH4IDLvyaf7Ef2mYpKgqI0+MSJ4MGiPOX/fs2FnLbYwXahiqxCHGZMJhnbCpo/XVZfp
         EPif15sWWLb/GQXmOVtpRo0atMMHeTmDxz9kor3Ev+3/0hm9I+tBf468/cs+CoojY81B
         LxG22qX+agZAsgSQAKuABVQ6tzxJ0KJHaTCFkUhpiMg0Z6fVxiwJYD0KGiNltCqR4hNl
         wpjdKdBvgDIvEGhTB6soI65Dg7POvtvY6HxM80mJnUvlPbies95rfw5nn/9Cbqf4o1iE
         Ddug==
X-Gm-Message-State: AOJu0YyN9prJfsFP3Y/R7gfLSnJwFIoKnJ2qQWlP5Ik+CVBZSiZDfpSu
	RrETGIaPoPS6pcX24eRnP5tnL3E4TKRqfDt1hXoC4i00O16lpPwQ/uLRyQuAdLaJ17l2ZVVCdok
	gH/YoIfSg2rVPII8UXWeZKfywHq6vi+DYFBcvBfy10PFh9Cs=
X-Gm-Gg: ASbGncvBUM2p3MOZARplp8lv3I+vBJnMvAAECAS+d2SALgjtqmarUe6LOkEL3KxZs/R
	N3y4Q9EbEPy/tou2kuqdMXRH+na0nCqHYVZCr
X-Google-Smtp-Source: AGHT+IHmWnD5kwN+ZxEB2f+A3sDv3Y27fhJNucp+It3MA8i/PLvSjBOiinKt1/y8Xt6nUCQL7fU3y0XhE2//suLMoyg=
X-Received: by 2002:a17:90b:5487:b0:2ee:cd83:8fe6 with SMTP id
 98e67ed59e1d1-2f548f813fbmr46893143a91.35.1737034451300; Thu, 16 Jan 2025
 05:34:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111151455.75480-1-jhs@mojatatu.com> <20250114172620.7e7e97b4@kernel.org>
 <CAM0EoMnYi3JBPS7KyPoW5-St-xAaJ8Xa1tEp8JH9483Z5k8cLg@mail.gmail.com>
 <20250115063655.21be5c74@kernel.org> <CAM0EoMk0rKe=AqoD_vNZNj2dz9eKSQpgS0Cc7Bi+FQwqpyHXaw@mail.gmail.com>
 <20250115075154.528eee8a@kernel.org> <CAM0EoM=zzidXbUNYUfnV-P5vVU7KOYZJPw7bdfKt4+nSdyWCvw@mail.gmail.com>
 <20250115173335.0f142a28@kernel.org>
In-Reply-To: <20250115173335.0f142a28@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 16 Jan 2025 08:34:00 -0500
X-Gm-Features: AbW1kvaTbjws7AzH7X6DqHk0RrwxV8Jg4UhIdb6k4GzjxX_EMVLA7DJfxSPb_Ws
Message-ID: <CAM0EoMn-YWEwAM0hys0v8_E4VLzasEu9JSdmjEda7f3tptCP-w@mail.gmail.com>
Subject: Re: [PATCH net 1/1 v3] net: sched: Disallow replacing of child qdisc
 from one parent to another
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, security@kernel.org, 
	nnamrec@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 8:33=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 15 Jan 2025 15:39:43 -0500 Jamal Hadi Salim wrote:
> > > diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> > > index 300430b8c4d2..fac9c946a4c7 100644
> > > --- a/net/sched/sch_api.c
> > > +++ b/net/sched/sch_api.c
> > > @@ -1664,6 +1664,10 @@ static int tc_modify_qdisc(struct sk_buff *skb=
, struct nlmsghdr *n,
> > >                                 q =3D qdisc_lookup(dev, tcm->tcm_hand=
le);
> > >                                 if (!q)
> > >                                         goto create_n_graft;
> > > +                               if (q->parent !=3D tcm->tcm_parent) {
> > > +                                       NL_SET_ERR_MSG(extack, "Canno=
t move an existing qdisc to a different parent");
> > > +                                       return -EINVAL;
> > > +                               }
> >
> > Yes, this should work as well - doesnt have to save the leaf_q, so more=
 optimal.
> > Please send the patch.
>
> I'm gonna keep your commit and just post a v4, hope that's okay.

Thanks!

cheers,
jamal

