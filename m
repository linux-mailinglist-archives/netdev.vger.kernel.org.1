Return-Path: <netdev+bounces-156050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D30A04BF1
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 22:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A4A3A13D9
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 21:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5126B1F7069;
	Tue,  7 Jan 2025 21:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="Odhq5hzu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C779A56446
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 21:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736286741; cv=none; b=AMoQBJYvcYkufJZAqTxOwXiQPtjrqNsed7f24xqsFs4zXgBXAMlg8GwrYCJuySp049CB2jyyC4yWlLAD7+6FN7tz7GN8dNy9nI4GYm+Z6fSUqJaijPY1DvZuxfDgMsaBuIMIlDhwl7yGkMwT9+qeHAB0oE+7Qhs1YgaJrq8+Zdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736286741; c=relaxed/simple;
	bh=2+22Hi00Z3H8JdugqovZ7drUjnUkXVGqFQUK0WARa0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHeBpYORV8oNse3OocwR/HDJxCTShwgQSzZw2IN+zN1SbSVWbUnhZgyor0LSUIKvNECd4mMdvhn9bhp8cNuSuHzYZtVuTX7OcRcYnYtVtuCBO9ureFuZjknBkIiWbMvm35M4LcMGDGAjMMksUrZOieSj0X51wPUVTZlpJ8hn74g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=Odhq5hzu; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GlRXPsyJbM2o47QJmvvPokS/tabVmC9pj0BGhM2WuNo=; t=1736286739; x=1737150739; 
	b=Odhq5hzun43oFSUFlTRWUCVsGn7cvMKQo7cNVlwj3aLTjG2+nI63qjls3h4Kg6PLy2qY6K6HENJ
	bRNgmOytjnkqi47pW7SfHLGqxk4wTfCQ39ngjtIt0/rppJpy69/z07SRP4ypDRgPg8Uej3abuJn2K
	LCW5GRT1dOrM7BrJ5/oeqJxia9H26cSba8a+ekfaHclIMmZZ24AOoQAkRpbEL4jQp3+abjm7XUBw0
	4fkmtvF6v47Xa/QaQlgG1qpS0XVhGcwmzWFME3M6DA8Dw9qbye7Tj9a7KfWmpck98RNw8y6H0XP5T
	2kvAd0cg4H9OwiOKcMsfS/Y2Dzgqq2+HRQsg==;
Received: from mail-oo1-f47.google.com ([209.85.161.47]:49411)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tVHUo-0005u0-JK
	for netdev@vger.kernel.org; Tue, 07 Jan 2025 13:52:19 -0800
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5f32168ddd8so5521861eaf.3
        for <netdev@vger.kernel.org>; Tue, 07 Jan 2025 13:52:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX9Dliypm7JBsR9lVhcNXU/6dgvT/UEiLrAHvpvhdcIhi+cRoYn/rJyu4QHMnrdC5Fe1gV9NSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXPgwjtkvzKNKs9mGx7eUb2JxOFqC0yk8fuR5qUpXrY9TAZ8XW
	fiJEf5iH2m1Uu3M7KpbKowu6/MpMRTCMPsLqArmOnbrEU9vNxU4DKFqhKyeTpCKXvFv5BwZ2v7T
	b7nKs+vz6r/zlqNTNjJs6jGjGs2o=
X-Google-Smtp-Source: AGHT+IFFm4X+OMrri9hchBMDFJ+mSAfvUgP37qI5L/XQPqMH4NJVNU2sdODz9+/pjSwbcMjHvWulGFI+IFIwWJzB4S8=
X-Received: by 2002:a05:6871:6216:b0:296:e4bb:80f5 with SMTP id
 586e51a60fabf-2aa069844ccmr282486fac.36.1736286737994; Tue, 07 Jan 2025
 13:52:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106181219.1075-1-ouster@cs.stanford.edu> <20250106181219.1075-7-ouster@cs.stanford.edu>
 <20250107061510.0adcf6c6@kernel.org> <CAGXJAmz+FVRHXh=CrBcp-T-cLX3+s6BRH7DtBzaoFrpQb1zf9w@mail.gmail.com>
 <CANn89iJKq=ArBwcKTGb0VcxexvA3d96hm39e75LJLvDhBaXiTw@mail.gmail.com>
In-Reply-To: <CANn89iJKq=ArBwcKTGb0VcxexvA3d96hm39e75LJLvDhBaXiTw@mail.gmail.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Tue, 7 Jan 2025 13:51:41 -0800
X-Gmail-Original-Message-ID: <CAGXJAmx4bB15iT1OwNyTmEDYMLvDhCVUXQBhKCftAeBt932uUw@mail.gmail.com>
X-Gm-Features: AbW1kvYyKZm0a7E4PLxw3wWlB_J3MWajKtCxIDL4REb6DhVM_2Jy9O4FioKdzfs
Message-ID: <CAGXJAmx4bB15iT1OwNyTmEDYMLvDhCVUXQBhKCftAeBt932uUw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 06/12] net: homa: create homa_peer.h and homa_peer.c
To: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, pabeni@redhat.com, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 078eb853d78558c6c655f7b6c94b391a

On Tue, Jan 7, 2025 at 1:02=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Tue, Jan 7, 2025 at 9:54=E2=80=AFPM John Ousterhout <ouster@cs.stanfor=
d.edu> wrote:
> >
> > I have removed the cast now.
> >
> > -John-
> >
> >
> > On Tue, Jan 7, 2025 at 6:15=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > >
> > > On Mon,  6 Jan 2025 10:12:12 -0800 John Ousterhout wrote:
> > > > +void homa_dst_refresh(struct homa_peertab *peertab, struct homa_pe=
er *peer,
> > > > +                   struct homa_sock *hsk)
> > > > +{
> > > > +     struct dst_entry *dst;
> > > > +
> > > > +     spin_lock_bh(&peertab->write_lock);
> > > > +     dst =3D homa_peer_get_dst(peer, &hsk->inet);
> > > > +     if (!IS_ERR(dst)) {
> > > > +             struct homa_dead_dst *dead =3D (struct homa_dead_dst =
*)
> > > > +                             kmalloc(sizeof(*dead), GFP_KERNEL);
> > >
>
> While you are at it, I suggest you test your patch with LOCKDEP enabled,
> and CONFIG_DEBUG_ATOMIC_SLEEP=3Dy
>
> Using GFP_KERNEL while BH are blocked is not good.

I will follow up on all of this. Thanks for the pointers, and sorry
that there is so much I don't know.

-John-

