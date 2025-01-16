Return-Path: <netdev+bounces-158746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7EBA131FE
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 05:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30FDB18876FE
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 04:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3995078F49;
	Thu, 16 Jan 2025 04:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lS+50wXz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83686EC4
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 04:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737002211; cv=none; b=AC48dnl231KPiGSCWNafj9FCwO/ay2C8O9JTbmWnKmHsNyhfAdeqb3Rxzxgt7xaiioxWp9v9mfO0kwgvLw5al1Zrd9MVifCjGwV7012YajdIsSKzqAVB9b3hDoO6NR6Zw0Lwb7kou9SZODzr8ZpJH3TetberVlTJZFGmBR/8uQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737002211; c=relaxed/simple;
	bh=Ye1wprbBiEm+woytOj1mmFn8mGpsMKLHFvAj7bCd8qA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSnRHI5msF1/PtVk+MR9KSU2gR0kq+wry3QLvdSDhrJEhVqBrzbphEsaL2jLPY7uLbkTWvXDnkwje8ueIwylD+W0PKmrtYWGyC8DMWQDD+gvB0PlhbCt66EPM6cJwbmR84P/MVpUrl9TnT3OToRJt3cLpyWRVKOBC3wZOatJyyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lS+50wXz; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21636268e43so9507975ad.2
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 20:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737002209; x=1737607009; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SJvHxa6DBMoYQnnAkZBUXqZ6YXyCZJdZLXFmLnOkHfo=;
        b=lS+50wXz/LtySFSuDb2NsQtyDgU9kZX+c+35grF5hHPmRDjW3em8pSHCS1YXbygnAE
         jD1VlFoc2LTywwO2Ae5IfAP8jxcIO2QkVDdD2oK8WFDWbXzez4FccdUjBqgofSQTqiTg
         8X22m/riWzyB5pnUV5AJMwbMLP15hLKRfYPRsWVe2NEhMI2khahBVleN6iz7VZ5bx/v5
         HuhKaqlaM9kh3uWKCQXU//ieR9le8H5GZwC6jvJ7vqrGrHTneY0zHbynfwlsu2hnxZAa
         F6XbTdMgbICLXWmbnRIwHOAfL9/xQlQqhCzxLFJHOQPfHdXXIFX7Ioq+08sU8b+rDIlb
         089A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737002209; x=1737607009;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJvHxa6DBMoYQnnAkZBUXqZ6YXyCZJdZLXFmLnOkHfo=;
        b=u2dVEf35gVmzXhfUK7P911svbQp0pTVBYT4PXCeupe1OQr/3rthPHvLc3tTkPZFqUk
         Tt71h/XPMCA/jGXiFvldNR9usX3z7WA3u5c8ln734kNrSR3Pv0S8q7jOBEmLGgcIhm3q
         TYaBGWBnkVKNFwy349WY7fSAtqzGemanTf90buXmBLTGPI8oPwFKfNR6xbxsVG4vVN8o
         wStonHTKqVbK9Ll4ir5ET3W3dRr+1YnDMhUFzqFtUke4ByEDuqSpede8hDGH3qqLUJFF
         mIW152CvFeQPUAbtVNEbUQcoLexuHYEyc1jZShQ/6eTFBBxqaaUGRNtheugjAkHI8ahi
         yqfg==
X-Forwarded-Encrypted: i=1; AJvYcCVhmiqiQwIBcgqNZswBJ5cdLetC3VtQfummdlDsykcqyYbaHIr13QN4MwhiFtXTzt2ZFaOjuRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1b3QYffHQGbxvZjR0sRfmzLXi0QH4DAtC2j8QTWxlf550jakw
	fQtcfe5ApYIkozR8J3G0G/4N28EAyLgoJ8WtfWZxgwGtRioMDAjiPa3UFw==
X-Gm-Gg: ASbGnct3JffcqeDa81YT0TGjLQxr39JOINXmtkYTrDvxEk2v5uuXdPys1aOKzXB1a+0
	D7NHGi5nczW2PMZ9biqg1KqOg7zl4663D8eMUG9aFv8+AinVcpZykp2gr6Xt4pe02IqSe3G5RUC
	EG2e0Ffczvi2ioXa+vi7YKxs8gyYc8Q3iAA1GCKY1/DTa9933S3dsYQO26UAZYTOeus41rvC9gx
	LPYLUdR93XwCIP/dUvxpea/rT4K6rndl0lvaebDMHHOeRQQN9uKLZ2cqcnn8oo=
X-Google-Smtp-Source: AGHT+IFRJpLSt/ocPQs5teVUsiRTbEwvyg3/SfoFqRg5acIDdJ3O3huiGK99D0O4nDqQSJFU382qjA==
X-Received: by 2002:a17:902:da89:b0:216:56c7:98a7 with SMTP id d9443c01a7336-21a84012b27mr555287545ad.53.1737002208356;
        Wed, 15 Jan 2025 20:36:48 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:6f6d:ec82:64c6:3692])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10f86bsm89109595ad.36.2025.01.15.20.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 20:36:47 -0800 (PST)
Date: Wed, 15 Jan 2025 20:36:46 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Petr Machata <petrm@nvidia.com>, netdev@vger.kernel.org,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, petrm@mellanox.com, security@kernel.org,
	g1042620637@gmail.com
Subject: Re: [PATCH net v4 1/1] net: sched: fix ets qdisc OOB Indexing
Message-ID: <Z4iM3qHZ6R9Ae1uk@pop-os.localdomain>
References: <20250111145740.74755-1-jhs@mojatatu.com>
 <Z4RWFNIvS31kVhvA@pop-os.localdomain>
 <87zfjvqa6w.fsf@nvidia.com>
 <CAM0EoMkvOOgT-SU1A7=29Tz1JrqpO7eDsoQAXQsYjCGds=1C-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMkvOOgT-SU1A7=29Tz1JrqpO7eDsoQAXQsYjCGds=1C-w@mail.gmail.com>

On Mon, Jan 13, 2025 at 06:47:02AM -0500, Jamal Hadi Salim wrote:
> On Mon, Jan 13, 2025 at 5:29 AM Petr Machata <petrm@nvidia.com> wrote:
> >
> >
> > Cong Wang <xiyou.wangcong@gmail.com> writes:
> >
> > > On Sat, Jan 11, 2025 at 09:57:39AM -0500, Jamal Hadi Salim wrote:
> > >> diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
> > >> index f80bc05d4c5a..516038a44163 100644
> > >> --- a/net/sched/sch_ets.c
> > >> +++ b/net/sched/sch_ets.c
> > >> @@ -91,6 +91,8 @@ ets_class_from_arg(struct Qdisc *sch, unsigned long arg)
> > >>  {
> > >>      struct ets_sched *q = qdisc_priv(sch);
> > >>
> > >> +    if (arg == 0 || arg > q->nbands)
> > >> +            return NULL;
> > >>      return &q->classes[arg - 1];
> > >>  }
> > >
> > > I must miss something here. Some callers of this function don't handle
> > > NULL at all, so are you sure it is safe to return NULL for all the
> > > callers here??
> > >
> > > For one quick example:
> > >
> > > 322 static int ets_class_dump_stats(struct Qdisc *sch, unsigned long arg,
> > > 323                                 struct gnet_dump *d)
> > > 324 {
> > > 325         struct ets_class *cl = ets_class_from_arg(sch, arg);
> > > 326         struct Qdisc *cl_q = cl->qdisc;
> > >
> > > 'cl' is not checked against NULL before dereferencing it.
> > >
> > > There are other cases too, please ensure _all_ of them handle NULL
> > > correctly.
> >
> > Yeah, I looked through ets_class_from_arg() callers last week and I
> > think that besides the one call that needs patching, which already
> > handles NULL, in all other cases the arg passed to ets_class_from_arg()
> > comes from class_find, and therefore shouldn't cause the NULL return.
> 
> Exactly.
> Regardless - once the nodes are created we are guaranteed non-null.
> See other qdiscs, not just ets.

The anti-pattern part is that we usually pass the pointer instead of
classid with these 'arg', hence it is unsigned long. In fact, for
->change(), classid is passed as the 2nd parameter, not the 5th.
The pointer should come from the return value of ->find().

Something like the untested patch below.

Thanks.

---->

diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index f80bc05d4c5a..3b7253e8756f 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -86,12 +86,9 @@ static int ets_quantum_parse(struct Qdisc *sch, const struct nlattr *attr,
 	return 0;
 }
 
-static struct ets_class *
-ets_class_from_arg(struct Qdisc *sch, unsigned long arg)
+static struct ets_class *ets_class_from_arg(unsigned long arg)
 {
-	struct ets_sched *q = qdisc_priv(sch);
-
-	return &q->classes[arg - 1];
+	return (struct ets_class *) arg;
 }
 
 static u32 ets_class_id(struct Qdisc *sch, const struct ets_class *cl)
@@ -198,7 +195,7 @@ static int ets_class_change(struct Qdisc *sch, u32 classid, u32 parentid,
 			    struct nlattr **tca, unsigned long *arg,
 			    struct netlink_ext_ack *extack)
 {
-	struct ets_class *cl = ets_class_from_arg(sch, *arg);
+	struct ets_class *cl = ets_class_from_arg(*arg);
 	struct ets_sched *q = qdisc_priv(sch);
 	struct nlattr *opt = tca[TCA_OPTIONS];
 	struct nlattr *tb[TCA_ETS_MAX + 1];
@@ -248,7 +245,7 @@ static int ets_class_graft(struct Qdisc *sch, unsigned long arg,
 			   struct Qdisc *new, struct Qdisc **old,
 			   struct netlink_ext_ack *extack)
 {
-	struct ets_class *cl = ets_class_from_arg(sch, arg);
+	struct ets_class *cl = ets_class_from_arg(arg);
 
 	if (!new) {
 		new = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops,
@@ -266,7 +263,7 @@ static int ets_class_graft(struct Qdisc *sch, unsigned long arg,
 
 static struct Qdisc *ets_class_leaf(struct Qdisc *sch, unsigned long arg)
 {
-	struct ets_class *cl = ets_class_from_arg(sch, arg);
+	struct ets_class *cl = ets_class_from_arg(arg);
 
 	return cl->qdisc;
 }
@@ -278,12 +275,12 @@ static unsigned long ets_class_find(struct Qdisc *sch, u32 classid)
 
 	if (band - 1 >= q->nbands)
 		return 0;
-	return band;
+	return (unsigned long)&q->classes[band - 1];
 }
 
 static void ets_class_qlen_notify(struct Qdisc *sch, unsigned long arg)
 {
-	struct ets_class *cl = ets_class_from_arg(sch, arg);
+	struct ets_class *cl = ets_class_from_arg(arg);
 	struct ets_sched *q = qdisc_priv(sch);
 
 	/* We get notified about zero-length child Qdiscs as well if they are
@@ -297,7 +294,7 @@ static void ets_class_qlen_notify(struct Qdisc *sch, unsigned long arg)
 static int ets_class_dump(struct Qdisc *sch, unsigned long arg,
 			  struct sk_buff *skb, struct tcmsg *tcm)
 {
-	struct ets_class *cl = ets_class_from_arg(sch, arg);
+	struct ets_class *cl = ets_class_from_arg(arg);
 	struct ets_sched *q = qdisc_priv(sch);
 	struct nlattr *nest;
 
@@ -322,7 +319,7 @@ static int ets_class_dump(struct Qdisc *sch, unsigned long arg,
 static int ets_class_dump_stats(struct Qdisc *sch, unsigned long arg,
 				struct gnet_dump *d)
 {
-	struct ets_class *cl = ets_class_from_arg(sch, arg);
+	struct ets_class *cl = ets_class_from_arg(arg);
 	struct Qdisc *cl_q = cl->qdisc;
 
 	if (gnet_stats_copy_basic(d, NULL, &cl_q->bstats, true) < 0 ||

