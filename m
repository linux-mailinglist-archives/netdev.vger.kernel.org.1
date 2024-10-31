Return-Path: <netdev+bounces-140726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE93D9B7BA7
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 14:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62E11C20895
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 13:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615BF19DF4F;
	Thu, 31 Oct 2024 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XGjViwhx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3031019CC0B
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 13:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730381289; cv=none; b=ASX8GVAfF6c31qXNoyHVXvWHgDTJWn1hYlZA7qU3EMtF6JI2OBVS+lv6wfhgmNYZIoscIjg3Zd6szvJpbPLH4vY2gaqvEq1iHaIE3zIlJgwog0Lr7Y9dvyOUjkOo8FoUNIqLuU2r0TFGXwItU3MBAlhjViomvcA28OlI+eHKCFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730381289; c=relaxed/simple;
	bh=Jjcka7E6MaSQ7nC/CFEot10Oi7cbuvv9l+tAnI2O9Ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XTg2MHk0V5WgkHfq158VpZcQTffsN5pFj26yjhgGWMEb7TsVnoRugC26JD5TNQ63b/ENu3jVOjvDFNyAr3n9NJIFKyOJSAWQLdL9TjxvvyRgu0oynZSt5XaVltw0biBis6Jo1Jv9hLGc+9pCXcBkRoW+BOvDoNG9i5cbkRhXTUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XGjViwhx; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-460b295b9eeso129871cf.1
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 06:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730381286; x=1730986086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+8pPFT1eOD/z3ha9J7u1uxzhaY7+UYdheZyJLi46ZI=;
        b=XGjViwhxWUaEKhDMyq/6RvrnMokx/rK+gX3rlfnO4oVAX1qk87i58iSeav2yTrtend
         jgN6s9D6putKTKrj7x6v0weJEOkguMIe706LeJ7deYB9IKnprZfYIYYKt9V0xagXRxG7
         onDAWLb0dUNrzGnapGrWV6CB2G3QQWaHjv+WjyWvsiZI5TpXiaNXlLwZKM6VdmUkqgE+
         9QjeWGAWELb4mbOVcDy4QEPLJRwknZJi4J0Z2Qgi0wcSieDxp5ShhGsOLTuIwHYOa/8e
         mSeMn3Oe8mVnqCAUwJxob5ha87J2/2KJGZSNTfeTI3uL/FHbAMV5v3nFD+qVgUvL/ieI
         d3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730381286; x=1730986086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+8pPFT1eOD/z3ha9J7u1uxzhaY7+UYdheZyJLi46ZI=;
        b=uUPzgm3O+1OmbOSTq20CN0UTIk3TlEj5PXyGgiMofesyaLFOZCtUVrQD+n1NxKgfBD
         ebqCRzs7Ourem9YvXAk+VUCvEjPfJF7vfa1Z75tQn6Jh40zCakGTSiuDRlUsp3OPzu9F
         FYOylQrx/GKcdfHVp0xUFc3nYYorSpoFQiBEK/WdV523A1m9OjrF2R1br0Filgcy2Oqq
         J/U8D+6XoietOvZTZGBLt69it+fFpm0XH1bldfGY0Hh9m9flkjeDM5fvbU85iyb9ICcg
         zd+Z4P/z6ooWmrFCP10og91KXTxyVMf8ovKYMYxCTK7bhq/Z48aL1ZVCLNRKQ0EnSQlo
         2iQw==
X-Forwarded-Encrypted: i=1; AJvYcCUpJ8rGFpf+mzscavDPPTj7mGcE7H/NTj4Ve//amhBRUHgxrObnTSkdmEQWpb/mBYAfcS2GuMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKxhExDw0khg3CkYP3g9ESQAHmt3J7/Ye0CqSkLS2IiMKsRtKx
	c5ZrNmAZ/fHj6l7oxcPQlU5zcFsfuhehIdKJA2D67v9eyB4iaD3crtH5321S14hTB4aV1qH2Vxj
	XQRKuarxILEy6lhyyiOj3jbkR9QC4UgOrCQU6
X-Gm-Gg: ASbGnctMLwm1Wfo0uwPSEMT2sk0WTAeX19ZvWeqWhzAD4aaMvMb+NwNHNPo5WYlEm00
	c8Js2dmswnVMmMwpSsy2ugDMFakJ0EEBHL7V1O9P9cnLTSo1TekMkQ7Fn0HA+gMHe
X-Google-Smtp-Source: AGHT+IHYNqzSZym//dzOXkU1elr06MP9CUrZZFR8bYzLtv3uxrKgDmP5/hQUYFV0jUEicQkMxk2E0Cr7lCnhMQBhMsI=
X-Received: by 2002:a05:622a:614:b0:461:4be1:c612 with SMTP id
 d75a77b69052e-462ad2da722mr2934321cf.21.1730381285738; Thu, 31 Oct 2024
 06:28:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021221248.60378-1-chia-yu.chang@nokia-bell-labs.com>
 <20241021221248.60378-2-chia-yu.chang@nokia-bell-labs.com>
 <ea2ccad9-6a4a-48e1-8e99-0289e13d501c@redhat.com> <CANn89iKU5G-vEPkLFY9vGyNBEA-G6msGiPJqiBNAcw4nNXoSbg@mail.gmail.com>
In-Reply-To: <CANn89iKU5G-vEPkLFY9vGyNBEA-G6msGiPJqiBNAcw4nNXoSbg@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 31 Oct 2024 09:27:49 -0400
Message-ID: <CADVnQy=Gt+PHPJ+EdaXY=xcrgeDwusSBmmWV9+6-=93ZhD4SXw@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 1/1] sched: Add dualpi2 qdisc
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, chia-yu.chang@nokia-bell-labs.com, 
	netdev@vger.kernel.org, davem@davemloft.net, stephen@networkplumber.org, 
	jhs@mojatatu.com, kuba@kernel.org, dsahern@kernel.org, ij@kernel.org, 
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com, Olga Albisser <olga@albisser.org>, 
	Olivier Tilmans <olivier.tilmans@nokia.com>, Henrik Steen <henrist@henrist.net>, 
	Bob Briscoe <research@bobbriscoe.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 12:53=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Tue, Oct 29, 2024 at 1:56=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > On 10/22/24 00:12, chia-yu.chang@nokia-bell-labs.com wrote:
> > > +/* Default alpha/beta values give a 10dB stability margin with max_r=
tt=3D100ms. */
> > > +static void dualpi2_reset_default(struct dualpi2_sched_data *q)
> > > +{
> > > +     q->sch->limit =3D 10000;                          /* Max 125ms =
at 1Gbps */
> > > +
> > > +     q->pi2.target =3D 15 * NSEC_PER_MSEC;
> > > +     q->pi2.tupdate =3D 16 * NSEC_PER_MSEC;
> > > +     q->pi2.alpha =3D dualpi2_scale_alpha_beta(41);    /* ~0.16 Hz *=
 256 */
> > > +     q->pi2.beta =3D dualpi2_scale_alpha_beta(819);    /* ~3.20 Hz *=
 256 */
> > > +
> > > +     q->step.thresh =3D 1 * NSEC_PER_MSEC;
> > > +     q->step.in_packets =3D false;
> > > +
> > > +     dualpi2_calculate_c_protection(q->sch, q, 10);  /* wc=3D10%, wl=
=3D90% */
> > > +
> > > +     q->ecn_mask =3D INET_ECN_ECT_1;
> > > +     q->coupling_factor =3D 2;         /* window fairness for equal =
RTTs */
> > > +     q->drop_overload =3D true;        /* Preserve latency by droppi=
ng */
> > > +     q->drop_early =3D false;          /* PI2 drops on dequeue */
> > > +     q->split_gso =3D true;
> >
> > This is a very unexpected default. Splitting GSO packets earlier WRT th=
e
> > H/W constaints definitely impact performances in a bad way.
> >
> > Under which condition this is expected to give better results?
> > It should be at least documented clearly.
>
> I agree, it is very strange to see this orthogonal feature being
> spread in some qdisc.

IMHO it makes sense to offer this split_gso feature in the dualpi2
qdisc because the dualpi2 qdisc is targeted at reducing latency and
targeted mostly at hops in the last mile of the public Internet, where
there can be orders of magnitude disparities in bandwidth between
upstream and downstream links (e.g., packets arriving over 10G
ethernet and leaving destined for a 10M DSL link). In such cases, GRO
may aggregate many packets into a single skb receiving data on a fast
ingress link, and then may want to reduce latency issues on the slow
link by allowing smaller skbs to be enqueued on the slower egress
link.

> Also, it seems this qdisc could be a mere sch_prio queue, with two
> sch_pie children, or two sch_fq or sch_fq_codel ?

Having two independent children would not allow meeting the dualpi2
goal to "preserve fairness between ECN-capable and non-ECN-capable
traffic." (quoting text from https://datatracker.ietf.org/doc/rfc9332/
). The main issue is that there may be differing numbers of flows in
the ECN-capable and non-ECN-capable queues, and yet dualpi2 wants to
maintain approximate per-flow fairness on both sides. To do this, it
uses a single qdisc with coupling of the ECN mark rate in the
ECN-capable queue and drop rate in the non-ECN-capable queue.

This could probably be made more clear in the commit message.

> Many of us are using fq_codel or fq, there is no way we can switch to
> dualpi2 just to experiment things.

Yes, sites that are using fq_codel or fq do not need to switch to dualpi2.

AFAIK the idea with dualpi2 is to offer a new qdisc for folks
developing hardware for the last mile of the Internet where you want
low latency via L4S, and want approximate per-flow fairness between
L4S and non-L4S traffic, even in the presence of VPN-encrypted traffic
(where flow identifiers are not available for fq_codel or fq fair
queuing).

Sites that don't have VPN traffic or don't care about the VPN issue
can use fq or fq_codel with the ce_threshold parameter to allow low
latency via L4S while achieving approximate per-flow fairness.

best regards,
neal

