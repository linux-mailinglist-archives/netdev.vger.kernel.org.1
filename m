Return-Path: <netdev+bounces-178564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 836EAA77914
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 12:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 342C016A812
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 10:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009B81F03C1;
	Tue,  1 Apr 2025 10:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LbtA2RCv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6FAEACE
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 10:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743504445; cv=none; b=OSaH522XjlZJYXfJP75KYunFxBqIlASEmNGuqjXt+G9jKvhE1EL8/BYOUn5NmqIXQACj43SMQcZ+gyf2cqe09KEj5ZfHMRlyfyrE4YNwVuf9LSE7hZ9KROEN8DRYiDHJb2nAtEAcwTn3UzWfjP3sxEqAGXcoD5pf6B3Bd+M8Vm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743504445; c=relaxed/simple;
	bh=V3Kkr7gn9uwABNIvfQ5UNyrUZ3bW7pGaQpkcjnq4iLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lg/WL4fZ/Iw4Wn/yZYgPjDmf5BW7MTO/Z8ItDUe/YDM+9HV63UJDjjt661SSJyVeaonyOvN2Dv7UVFzmBVfj99/Bd7saoi1w4SrLdCUWr9kgWEl0YMZDL63iSvOlnTnX8k6taswZ6DNnYASs4XuxDpIVBGUP1wTt8L9uaYcwfZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LbtA2RCv; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4772f48f516so63200391cf.1
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 03:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743504443; x=1744109243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1jU9TGtjVSrWjGaGWo2Ncuf9ZIfOq40UC/MdxrOrFY=;
        b=LbtA2RCvV/R5XUb3gnWFx/4k9sYRFV006gJuGPTKRF2eb27M0xGUWhoxW9O8wZVKkV
         +uAoe/xJh0wIDc1CQYtjzFXHJjaVP2cuOk8u679STF1ZuDbtNZrsjpnAJqkz/Lfsxs1b
         AN5/T6LnzN9KiNNhrfwP2Cg2r9e1TjHInGflEkWGwCcvGgl5Qc4Wc96pyoQN2xv1ZFee
         1rbFMv+IR0Y4fjvoxpx0VsgpxW7PBnl8fU5Out7twz47NEGApZ8kSqbReF/telVZZkkq
         1uvxRVdHFoAO6ZCIlfG8sjS6/hrGn9QN9PL/IKlqgXdGjDtHfBjMNFsLUZ/KSK6L91+M
         RRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743504443; x=1744109243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1jU9TGtjVSrWjGaGWo2Ncuf9ZIfOq40UC/MdxrOrFY=;
        b=wHnTADDIYMn6jvRZiXcW3UtFBGrMmajbQWDYAzyLAwu28mfg0AFwsOWR6p3tg9FUHm
         dtrtesu906XlWnultO5wAm7B9IoXyC7vrSJ2S4Q7UNLS6Jqe14zI8t7e2M4e+ZQe7FUx
         TThtoD/bdTNWRuNcBun9SyhXcWLHzHEBGuE82Ka7/VlagBn7k8rIRiA4jVu/VzVwdlym
         3O6rMXU4m4Ke0JPV1XwkITU0Tr5RumgUvY7/rSxMkl6EJgie2XjAfwwSSQdUwS52L1FY
         qQOXngp2y7AGuERqeEztfmY5QdjBYp55xfU14nsqlvzrjgXaq0hEe2GJgZ3jffoNnP9q
         ezdA==
X-Forwarded-Encrypted: i=1; AJvYcCWG10fL2I/0IKpbkVkyqswAr70c0A/GYkIrdHcZYQS2MwKT1SKiNYkMGrdn+4BhgG9xd+ZkdSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWag8FtpWilLSEYm5+z5+CqIcYh9RDx7XAOjE6BJug/cThtVCb
	lq2Qz1PXhPBqFqFjL+yUFjex8EKV/ejYWNPtC28iFAJ/0rsWgmMwM/M7MtK6cNg1gaCMZjI6/Ma
	U19Ja9uNG/76PbL2q01blcBDB+y6X+qCMr7Bx
X-Gm-Gg: ASbGncv/Rg5BH4qoliVwdOlNvEMc72L4CSFGx2QOEkQGrQsrsRSfhXjMOW5t2mBjHIT
	64PCAWSCuh27Aj9ncLgZ8S51Kn/cIut8rYSD2CmK8rGiIl/COHaTw/poUBHRBrLkxAJ4fywOGfH
	gRHMzKeJEVnTu71XFHm4z+1mb+8gM=
X-Google-Smtp-Source: AGHT+IFoi7e2numvC/p3WWDiikN6b7B39OOCxmVmyD2tiyIAA/8bkjVzcSwd1zGHtGDdC3voF09VgzLrHhrthgqVT5o=
X-Received: by 2002:a05:622a:1f0c:b0:474:e033:3efb with SMTP id
 d75a77b69052e-477845e8d44mr278112741cf.24.1743504442895; Tue, 01 Apr 2025
 03:47:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328201634.3876474-1-tavip@google.com> <20250328201634.3876474-2-tavip@google.com>
 <Z+nYlgveEBukySzX@pop-os.localdomain> <5f493420-d7ff-43ab-827f-30e66b7df2c9@redhat.com>
In-Reply-To: <5f493420-d7ff-43ab-827f-30e66b7df2c9@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 1 Apr 2025 12:47:11 +0200
X-Gm-Features: AQ5f1JouzkUIiU2TOrDziK8Z96CiHYeW3FdovGN4FXSm0Y_Dx6YstRKxr6Yjy7M
Message-ID: <CANn89iJW0VGQMvq6Bs8co8Bq6Dq1dUT7TN+EXg=GwYbSywUz0A@mail.gmail.com>
Subject: Re: [PATCH net 1/3] net_sched: sch_sfq: use a temporary work area for
 validating configuration
To: Paolo Abeni <pabeni@redhat.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Octavian Purdila <tavip@google.com>, jhs@mojatatu.com, 
	jiri@resnulli.us, davem@davemloft.net, kuba@kernel.org, horms@kernel.org, 
	shuah@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 11:27=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 3/31/25 1:49 AM, Cong Wang wrote:
> > On Fri, Mar 28, 2025 at 01:16:32PM -0700, Octavian Purdila wrote:
> >> diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
> >> index 65d5b59da583..027a3fde2139 100644
> >> --- a/net/sched/sch_sfq.c
> >> +++ b/net/sched/sch_sfq.c
> >> @@ -631,6 +631,18 @@ static int sfq_change(struct Qdisc *sch, struct n=
lattr *opt,
> >>      struct red_parms *p =3D NULL;
> >>      struct sk_buff *to_free =3D NULL;
> >>      struct sk_buff *tail =3D NULL;
> >> +    /* work area for validating changes before committing them */
> >> +    struct {
> >> +            int limit;
> >> +            unsigned int divisor;
> >> +            unsigned int maxflows;
> >> +            int perturb_period;
> >> +            unsigned int quantum;
> >> +            u8 headdrop;
> >> +            u8 maxdepth;
> >> +            u8 flags;
> >> +    } tmp;
> >
> > Thanks for your patch. It reminds me again about the lacking of complet=
e
> > RCU support in TC. ;-)
> >
> > Instead of using a temporary struct, how about introducing a new one
> > called struct sfq_sched_opt and putting it inside struct sfq_sched_data=
?
> > It looks more elegant to me.
>
> I agree with that. It should also make the code more compact. @Octavian,
> please update the patch as per Cong's suggestion.

The concern with this approach was data locality.

I had in my TODO list a patch to remove (accumulated over time) holes
and put together hot fields.

Something like :

struct sfq_sched_data {
int                        limit;                /*     0   0x4 */
unsigned int               divisor;              /*   0x4   0x4 */
u8                         headdrop;             /*   0x8   0x1 */
u8                         maxdepth;             /*   0x9   0x1 */
u8                         cur_depth;            /*   0xa   0x1 */
u8                         flags;                /*   0xb   0x1 */
unsigned int               quantum;              /*   0xc   0x4 */
siphash_key_t              perturbation;         /*  0x10  0x10 */
struct tcf_proto *         filter_list;          /*  0x20   0x8 */
struct tcf_block *         block;                /*  0x28   0x8 */
sfq_index *                ht;                   /*  0x30   0x8 */
struct sfq_slot *          slots;                /*  0x38   0x8 */
/* --- cacheline 1 boundary (64 bytes) --- */
struct red_parms *         red_parms;            /*  0x40   0x8 */
struct tc_sfqred_stats     stats;                /*  0x48  0x18 */
struct sfq_slot *          tail;                 /*  0x60   0x8 */
struct sfq_head            dep[128];             /*  0x68 0x200 */
/* --- cacheline 9 boundary (576 bytes) was 40 bytes ago --- */
unsigned int               maxflows;             /* 0x268   0x4 */
int                        perturb_period;       /* 0x26c   0x4 */
struct timer_list          perturb_timer;        /* 0x270  0x28 */

/* XXX last struct has 4 bytes of padding */

/* --- cacheline 10 boundary (640 bytes) was 24 bytes ago --- */
struct Qdisc *             sch;                  /* 0x298   0x8 */

/* size: 672, cachelines: 11, members: 20 */
/* paddings: 1, sum paddings: 4 */
/* last cacheline: 32 bytes */
};


With this patch :

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 65d5b59da583..f8fec2bc0d25 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -110,10 +110,11 @@ struct sfq_sched_data {
        unsigned int    divisor;        /* number of slots in hash table */
        u8              headdrop;
        u8              maxdepth;       /* limit of packets per flow */
-
-       siphash_key_t   perturbation;
        u8              cur_depth;      /* depth of longest slot */
        u8              flags;
+       unsigned int    quantum;        /* Allotment per round: MUST
BE >=3D MTU */
+
+       siphash_key_t   perturbation;
        struct tcf_proto __rcu *filter_list;
        struct tcf_block *block;
        sfq_index       *ht;            /* Hash table ('divisor' slots) */
@@ -132,7 +133,6 @@ struct sfq_sched_data {

        unsigned int    maxflows;       /* number of flows in flows array *=
/
        int             perturb_period;
-       unsigned int    quantum;        /* Allotment per round: MUST
BE >=3D MTU */
        struct timer_list perturb_timer;
        struct Qdisc    *sch;
 };

