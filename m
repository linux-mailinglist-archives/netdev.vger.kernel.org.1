Return-Path: <netdev+bounces-140790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7F39B8126
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 18:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 514FE282D47
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 17:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFF21BD517;
	Thu, 31 Oct 2024 17:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsNQMckr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CC21386C9
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 17:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730395664; cv=none; b=lSIP7i3vfsUrLp7OVojRXQlbHQQj9B5bibjliQu6Zc0P3LxmSMjzzOPv05wYpR1E0RuzcLRSJYSiur2oWfzx/Sx96kQIxKRpALJFq2WqhO609Ei8hvRCrJGDNUK9BwpcP+luuBu7WyTwiNu2yiWVxHQrCpu221BtPqtlwEddvXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730395664; c=relaxed/simple;
	bh=wajFU0VqH/eWf8Gcuw1Tf0q2QHCAYb3SgHwDwszQgrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gWWkfxMTUoH0lsnxKsRDZyC5IxAgH19F2StT2zXqTK/Y2wNUVvI8C5djFy5GFwWuchn5O/HQz6I66NzQ0XtQSCwQPgFSLft5F0nCejgolcwD8IoeWOj9I4U3qTPOnn2ORvK45dBsu88u2vQMuXYKeebRgCCAhGdmZ/x0te4DO+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsNQMckr; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-28c654c9e79so1233622fac.0
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 10:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730395662; x=1731000462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15tVf+gqbtVobKotVC5kh7A1yTAAJ4bmaozLqkT5Qiw=;
        b=jsNQMckrztsfFBaVQixEULfvYqyC8pW0i20Ix3Xti4l1m6xYQdbaWKA+E8JWILntc2
         HwvT9A4PcpXNlABL9nH04cDAkNRbuEvcyuMN+okSl3uPzhP4RvBpHghIqekvImHW9r6W
         m2gq1kWaSHpf4neVa348Nf8w7+q/FSfzryWdw6U9VTemkb/jxxHw5MP0lhfHA/Kux8/7
         5SIsAcBoFTqDWaaDo7IQjESaD8Da+F9JytYoe48xSGPbhiuHGxmZR6HNyRXNea1cyuDo
         tAGhhmN5zmJeNsrWzsWyFwc7UXDCPbpmy5MdQ1DGEfvIpURh8EMiMxwPHyFuWbYCMjw5
         F5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730395662; x=1731000462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15tVf+gqbtVobKotVC5kh7A1yTAAJ4bmaozLqkT5Qiw=;
        b=rtFZYU7bAaHTRB1IRHFZyb9TDcw/83G47hQykJRj1cGUaAbeOm3mfCXQYi0v6RcEcz
         /EHJRky4LU/eKW6Xtt0gQ2S0oC5thl9lUwRmyWBnllfMlOHUbUdIMkPKLax94lAqeQMV
         mntaoQzsfKjEDZIA/E2O/AWw9FPqq2gfp9Ni1eoIiB7Rd6OvdsUITI88196ZO/aCfsen
         MkSXCTkYryCDLEZK9y8mBelfjm0f1qlQjd6k75ig5ZF3BCtWiIDMweAIU8eihQy/XfJW
         ts7bJDdk6qCI43zptNL9Gk4Smi9kAmNKnX5htrxsq6Xown4FShFqxlX20+yep6X+lyXI
         H3rg==
X-Forwarded-Encrypted: i=1; AJvYcCVCOV78//W665izGmDnTjH0r4hFws9kxbjDfyBToDsQoACZc+pFvCrfN1MQHVm3ACRbt52O+I0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDBfZkMiFLL56VONjB636Q5tkss7U0Uvk3VxrW9x+DrFJjlXCy
	IPj9WbpQTiXmsntRcW3aPPVfOwnIQhP60bUA++9sdDs5vJswgwynCBaral635Ab0LujPCtVyHTy
	rfaEnbTMWG2RHAbU+PEdJ5amwdqo=
X-Google-Smtp-Source: AGHT+IHjD9/sSv6GHUJ2jRr35+8QlvFfu0em8OE9qRrMMT7W6ORIHzYu95bZXvzS0Bs57EWYV41onV/z7mchANxpVSI=
X-Received: by 2002:a05:6870:9d96:b0:277:73ce:da7c with SMTP id
 586e51a60fabf-29488987aeemr1781653fac.23.1730395661780; Thu, 31 Oct 2024
 10:27:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021221248.60378-1-chia-yu.chang@nokia-bell-labs.com>
 <20241021221248.60378-2-chia-yu.chang@nokia-bell-labs.com>
 <ea2ccad9-6a4a-48e1-8e99-0289e13d501c@redhat.com> <CANn89iKU5G-vEPkLFY9vGyNBEA-G6msGiPJqiBNAcw4nNXoSbg@mail.gmail.com>
 <CADVnQy=Gt+PHPJ+EdaXY=xcrgeDwusSBmmWV9+6-=93ZhD4SXw@mail.gmail.com>
 <CANn89iJNi1=+gAx6P4keDb9wuHoTjZnN0DNRgBEZ5cJuUcaZHg@mail.gmail.com> <AM6PR07MB4456EAF742A691AD513AE8C1B9552@AM6PR07MB4456.eurprd07.prod.outlook.com>
In-Reply-To: <AM6PR07MB4456EAF742A691AD513AE8C1B9552@AM6PR07MB4456.eurprd07.prod.outlook.com>
From: Dave Taht <dave.taht@gmail.com>
Date: Thu, 31 Oct 2024 10:27:27 -0700
Message-ID: <CAA93jw7b5D3DXw3=x5hWxvEctLiVhc4ozQSgwogqArOE6pMYcQ@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 1/1] sched: Add dualpi2 qdisc
To: "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, 
	"Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net" <davem@davemloft.net>, 
	"stephen@networkplumber.org" <stephen@networkplumber.org>, "jhs@mojatatu.com" <jhs@mojatatu.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "dsahern@kernel.org" <dsahern@kernel.org>, "ij@kernel.org" <ij@kernel.org>, 
	"g.white@cablelabs.com" <g.white@cablelabs.com>, 
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>, 
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>, 
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, 
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>, 
	Olga Albisser <olga@albisser.org>, "Olivier Tilmans (Nokia)" <olivier.tilmans@nokia.com>, 
	Henrik Steen <henrist@henrist.net>, Bob Briscoe <research@bobbriscoe.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 9:46=E2=80=AFAM Koen De Schepper (Nokia)
<koen.de_schepper@nokia-bell-labs.com> wrote:
>
>
> From: Eric Dumazet <edumazet@google.com>
> Sent: Thursday, October 31, 2024 3:31 PM
> > On Thu, Oct 31, 2024 at 2:28=E2=80=AFPM Neal Cardwell <ncardwell@google=
.com> wrote:
> > > On Tue, Oct 29, 2024 at 12:53=E2=80=AFPM Eric Dumazet <edumazet@googl=
e.com> wrote:
> > > > Also, it seems this qdisc could be a mere sch_prio queue, with two
> > > > sch_pie children, or two sch_fq or sch_fq_codel ?
> > >
> > > Having two independent children would not allow meeting the dualpi2
> > > goal to "preserve fairness between ECN-capable and non-ECN-capable
> > > traffic." (quoting text from https://datatracker.ietf.org/doc/rfc9332=
/
> > > ). The main issue is that there may be differing numbers of flows in
> > > the ECN-capable and non-ECN-capable queues, and yet dualpi2 wants to
> > > maintain approximate per-flow fairness on both sides. To do this, it
> > > uses a single qdisc with coupling of the ECN mark rate in the
> > > ECN-capable queue and drop rate in the non-ECN-capable queue.
> >
> > Not sure I understand this argument.
> >
> > The dequeue  seems to use WRR, so this means that instead of prio, this=
 could use net/sched/sch_drr.c, then two PIE (with different settings) as c=
hildren, and a proper classify at enqueue to choose one queue or the other.
> >
> > Reviewing ~1000 lines of code, knowing that in one year another net/sch=
ed/sch_fq_dualpi2.c will follow (as net/sched/sch_fq_pie.c followed net/sch=
ed/sch_pie.c ) is not exactly appealing to me.
>
> This composition doesn't work. We need more than 2 independent AQMs and a=
 scheduler. The coupling between the queues and other extra interworking co=
nditions is very important here, which are unfortunately not possible with =
a composition of existing qdiscs.

I tried to mention that the dualpi concept is not very dual when
hardware mq is in use - one "dualpi" instance per core.

So essential limitations on usage for dualpi are:

Single instance only
gso-splitting only

So it is not suitable as a general purpose data center qdisc because
it simply cannot scale to larger bandwidths.

I think in part the confusion here is the other stuff that was
originally submitted (accecn, tcp prague), needs to be tested somehow,
and a path forward seems to be to put a ce_threshold into sch_fq
matching the l4s ecn bit, with a suitable default (which in dualpi is
1ms). (self congestion is a thing), then incorporate accecn, then test
prague driving that, then, somewhere on the path or test setup put in
a rate limited dualpi instance?

> Also, we don't expect any FQ and DualQ merger. Using only 2 queues (one f=
or each class L4S and Classic) is one of the differentiating features of Du=
alQ compared to FQ, with a lower L4S tail latency compared to a blocking an=
d scheduled FQ qdiscs.

>Adding FQ_ on top or under DualQ would break the goal of DualQ.

Comparing fq_codel or fq_pie to dualQ would probably be enlightening.
Both of these scale to hardware mq.

In dualpi's defence it seems to be an attempt to mimic a hardware
implementation.

> If an FQ_ supporting L4S is needed, then existing FQ_ implementations can=
 be used (like fq_codel) or extended (identifying L4S and using the correct=
 thresholds by default).

Merely having a preferred value for that threshold would be nice. The
threshold first deployed for fq_codel was far too low for production
environments. If 1ms works, cool!

>
> Regards,
> Koen.



--=20
Dave T=C3=A4ht CSO, LibreQos

