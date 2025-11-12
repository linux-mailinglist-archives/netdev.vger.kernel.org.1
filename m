Return-Path: <netdev+bounces-237805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA60C50643
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 04:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD11C18852F8
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 03:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BDE2C21DA;
	Wed, 12 Nov 2025 03:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GlRfI4mo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793D627FD4F
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 03:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762916835; cv=none; b=ZRKhKX3RAuh9pKuZ2R7hKrejRQ2u77VYXD3zQMPWUzG83YkiDLlAFaxNGLKyXxHToZ3tSpO6v4wFVAhpAxrXrIjsDectBeVVdVBx85OiPPuZWY0uOCcamw0vQwWKSVM3Nf7+0XhW0y7mws4DZvZMRZ0oCEjqvuxXvG4K+6k+1m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762916835; c=relaxed/simple;
	bh=3cpY37m6DDyY0SZ9u/QBcuP3DtbAkjbxVetlLaL+fyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9s2bV83om35Qv9UR9y+V4Yv7yIJaGQyKvb85cwunuAudPZbd/d3F7F1o/31xxEzyCCB/cf4dtx+NMlSQ+jAgAYbRPgGHOb+fy4omGpD+iQjvAtEp70TrCnCXgxlP4HZZDDGAianqyORtRBn9+dUnKpK2IE09hTROhiNGl50TQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GlRfI4mo; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-bb7799edea8so269159a12.3
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 19:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762916834; x=1763521634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkQ0KPfBTNMBE3TELpUEf7mKLVk/mh6eoqMKiCsk8UI=;
        b=GlRfI4morzyaBLu7VPniP3wtV41dkm6D0oP4dZiA7YdY7OJK56bs2C6Yv/YZWFg6UK
         Gpa2nTFepx32qs9GpWJTTn2IcYoUqj/kphGqZoBy/P7Xfzy/qo8jD6GVxChwLto6Zcof
         5P4bQBuBm4wMmHdZNhdUX7QwjFrqxd7lad3WIYpkJ8R8gBY/GaulUcdtIuO0K5VW8x10
         FrbCVOK0Uk6vodSms1Vw3PMhu3j4qYdD2RG3CzKC7Poi7HcLB9TrjmvnCdVPjdTqEwWs
         mjXuR3X8ls+rOdH5H209wzDVqezsZGz+czQEL4aLjXCAUpPjs650QS4zkVG034FoZc5Q
         93Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762916834; x=1763521634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pkQ0KPfBTNMBE3TELpUEf7mKLVk/mh6eoqMKiCsk8UI=;
        b=Z53dtelLIk/wC3Qs3y0e9DNANDcS3rpvrV7KscZuQOls99apSuWyEaB+ywB6v9CnUI
         6+JAbixREi7QLAeWBH+ajgyqCRYkr9sPKEMFRtKR3H2uA9V+dqtmu4Lv45JBK3CjuYxU
         9dDdp8J8NBxXsruTDmOW6ul1+4T9l/DRJCiwHEvUW7k5TUp8seFRwODwMCHEAuiDYdeD
         1K2bWhU/nUw8h9odJii76Z5X3l8f0ClRgpD/73qQYsdGfyfc2LkeYVmCUP9yK+hJO+uV
         CDVAOA+Fmmf6fPW8rIbyZBWKXrZZvIe5Er4+I2S54ewYdb3oetH3TpoqNvq4pw4LDjJZ
         3X5A==
X-Forwarded-Encrypted: i=1; AJvYcCVTRYcfOcgm44SJnh2AsAh41Ft0E59NvvMUGYdzYLkVaUME0oz7mw38FijyYVpiZqj2z2pHM8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4kA0E5FThjH93H0Lyj0eCvS/hnH6mM2n+Wwkg9CXoFKod7OoW
	vF7TAGLextaDfEvHedMpl23AlIxikHikCrzF8YiVAJb8tj50eg1nccWJIjyYcabH037v4lm0gSM
	KnliYdpijP55lTMwtWQRHBprbatxLz1RMHPm7N9ji
X-Gm-Gg: ASbGncutdP/igbVLELaZDdGZDA1ldqZTHtuLqbnAjNl/5PLfbkW2wakTCsd7OAKawFX
	WyEyNtqXdSjg1QjH/kTXPO9bgNNJ/LhyVySQ7/nGCCeYjwak4LeO4CZosy/MG3tF8JmKVTvABPr
	p1teN/aNnpV/GvRW4t8IFAPfw8a38i/DlKDXesPv6ElpfzTy/dmd3BcP97ksAGvTV+5Xu5A9FHA
	esdR6xqy/1GeLQDUgSEv6HnSeHTE5eo8GlMFoRbbp9xXvc5RF5wU0KfM0rT3xESRCycEZE4c648
	lcReAoBvBD7Q6KSs4i5qdtsZhAh7tuDxaseD/Og=
X-Google-Smtp-Source: AGHT+IGoG71z0zhgYnwqJXFmkeJHiPD+B6u9R8z2IO5ja+ySnj8LHzNYhGu34r0wRtrKJC8HPSR6B5sXlC5kNV3/FG8=
X-Received: by 2002:a17:903:2b03:b0:297:f7fb:7b66 with SMTP id
 d9443c01a7336-2984edf3d08mr20638945ad.57.1762916833471; Tue, 11 Nov 2025
 19:07:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106071050.494080-1-kuniyu@google.com> <aRJJaCVk181ErQWJ@pop-os.localdomain>
In-Reply-To: <aRJJaCVk181ErQWJ@pop-os.localdomain>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 11 Nov 2025 19:07:02 -0800
X-Gm-Features: AWmQ_blDj3ixqh8dDtYdDtqmTdB3Obm0oITzJ1xFE8nhudN9eY5to_Iq-9K4FF8
Message-ID: <CAAVpQUDi8hLHa6nps9PyNbxqLUEm4znO8xF8M=rER5UAEN7ghw@mail.gmail.com>
Subject: Re: [PATCH v1 net] net: sched: sch_qfq: Fix use-after-free in qfq_reset_qdisc().
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Paolo Valente <paolo.valente@unimore.it>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+ec7176504e5bcc33ca4e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 12:22=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.co=
m> wrote:
>
> On Thu, Nov 06, 2025 at 07:10:49AM +0000, Kuniyuki Iwashima wrote:
> >  static int qfq_change_class(struct Qdisc *sch, u32 classid, u32 parent=
id,
> >                           struct nlattr **tca, unsigned long *arg,
> >                           struct netlink_ext_ack *extack)
> > @@ -511,6 +541,10 @@ static int qfq_change_class(struct Qdisc *sch, u32=
 classid, u32 parentid,
> >               new_agg =3D kzalloc(sizeof(*new_agg), GFP_KERNEL);
> >               if (new_agg =3D=3D NULL) {
> >                       err =3D -ENOBUFS;
> > +
> > +                     if (existing)
> > +                             goto delete_class;
> > +
> >                       gen_kill_estimator(&cl->rate_est);
> >                       goto destroy_class;
> >               }
> > @@ -528,40 +562,14 @@ static int qfq_change_class(struct Qdisc *sch, u3=
2 classid, u32 parentid,
> >       *arg =3D (unsigned long)cl;
> >       return 0;
> >
> > -destroy_class:
> > -     qdisc_put(cl->qdisc);
> > -     kfree(cl);
> > +delete_class:
> > +     qfq_delete_class(sch, (unsigned long)cl, extack);
> >       return err;
>
> Is it better to just call qfq_delete_class() directly? Two reasons:
> 1) It is only used by this code path
> 2) It reads odd to place a 'return' above 'destroy_class' label below.
>
> And, what about the error patch of gen_new_estimator()? 'existing' could
> be true for that case too, which I assume requires the same error
> handling?

Ah right, the path also needs qfq_delete_class().
Then, the label will be needed anyway.

Thanks!

