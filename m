Return-Path: <netdev+bounces-71443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD618534A0
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 16:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262CC1F24E4B
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 15:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C599F5DF37;
	Tue, 13 Feb 2024 15:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NKkEcQDW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079E15EE79
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 15:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707838125; cv=none; b=pz4Za+vpiZjG1GBcuku8pR7CZQ91+v3yDYk8vwsmQFnysJorccEOdJjvHU+16KtO4EfM6kHalJuJ1QrRYoSzWSoaDE0BlNzvD8zeI5Jzv3AogGIneGJnaD1dvB9gcWy4EbNf4WaTbaSzVoZlFRDG1XCKEYNk3FHY0/6C0OYGv34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707838125; c=relaxed/simple;
	bh=qk4Xya/4t862lV+EV2UB+RHGBt6fdwyCRsJrczkmy4c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=khEvaP+2tCCx9Vl7XOn5BY2M9r20/Duix8+zcnolFX+kTNwMeV2KqO4upgb8p65NrVRU4hbQwRF2PacO1TwfnxqVECFuD2ZlcsOpA6kU0E39sBg6pzb9zBwxdgOfrhyQL4R/57fDOwrSghqQquZQvCJraTt/0v+NxX8T/61v2PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NKkEcQDW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707838122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BECdebsetLJD8oehNBFBOebgbzStfrCRQ78NrPHXYM4=;
	b=NKkEcQDWSvBomjaqhn8Ce/ciwLOauixbZ0WEJVjk/vSW4hX1qzmJOVxhShZvty5xWoPYQG
	7cr4lWkDwWLxjhk6qAQFuibiffMzmeeRwCoNQKg79pBxvoCCUAvOfM/AM3QfgoUmyNyA17
	Gd+n7pf/901HFTW+LnWgqOIQ0O3ln74=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-3MFLF326OaS_o5-tZOhY_Q-1; Tue, 13 Feb 2024 10:28:41 -0500
X-MC-Unique: 3MFLF326OaS_o5-tZOhY_Q-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d0af6e4540so17614661fa.0
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 07:28:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707838119; x=1708442919;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BECdebsetLJD8oehNBFBOebgbzStfrCRQ78NrPHXYM4=;
        b=fHMPhS21KXywnRgFkfwwE4b3inR3T01UthKXWDxFXrTw4Y59ZXd6bp1qKasZZ/b/dd
         g4ne91bUWEmBtoXIEHSVwUAotOigSkKqx7iPcC7lIcTd+2DEFcnCfxvekQpC4KH+FJbh
         rpaLyTR1nchsMq+gBseS4hHIORJ7zqm6fBQTWdOMfAn7ZAUTtBC2yipPaZHIBmIj/M3R
         ecDkOVDv/xcwNQ0A5cGaqnNjbddEy8xk2SvqWyDtp/ndCD2LJWClGUestlOV9rKIan6l
         Q8oSh/PqZSegZWamxrp8eP9zVOBS/YNjw2bruDwQdhxfHCoJxzkHAK0SeracuDEWkqDJ
         HMRA==
X-Forwarded-Encrypted: i=1; AJvYcCWITHt4EGgS2iuK1NMPdT9y0IQeNSzf5gwJFsLoz5J1yGcWfq3EGNSmkZ3HtSSu7sGIlnt/52dIlntmvfdEpiHDfnlWQhzv
X-Gm-Message-State: AOJu0YzgOXP8yUe8Bu7Clvw4ZkAvsbJ8fdeZ2l/iYYsUnemZ0m0vqUBN
	syBq8FfMXQCyQ/pEvbyB9Am6qTGFHhPjjGwkopxDsTMTZhbkqcDGnHUfKPC+mEvOkcTg9lvCTn/
	ERGUySxn/blTJrMvGtbit85nA8+I/c7SXAo4FmZEgNYwjqHXf1OLr0Nxm2JyEsw==
X-Received: by 2002:a2e:3c03:0:b0:2d0:a258:3003 with SMTP id j3-20020a2e3c03000000b002d0a2583003mr5950293lja.2.1707838119404;
        Tue, 13 Feb 2024 07:28:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBRFQYXPYRfBqsvlLZ864EaPJnS9kgHdpllD35YvhK26M56+OLprAFPo1g2GNaYPLBy77BHA==
X-Received: by 2002:a2e:3c03:0:b0:2d0:a258:3003 with SMTP id j3-20020a2e3c03000000b002d0a2583003mr5950280lja.2.1707838119042;
        Tue, 13 Feb 2024 07:28:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUTf3zufGqHmogGLxVtaUFMol2sWlKhjtd2DwmoR0yQOnCUuuwxAwBMW3VFNbmxz/dblRi9Nl65I4UEje8rYAP1wiAR6IY/81sIZ0VTiCXx2+HzPzGyZkDIqD+/oqQCBkJ2sq9at797/P5c/B8gP62U9DAwyzpGva4ALWO453HDoGGUmKXbCJLCrVOtzRcDzy3a2FWHYRAmKr4C536MKLF3SGmCDVxjPtMn1qQkZnNeNGgqoO4DRxxnvGZnArUGgg==
Received: from gerbillo.redhat.com (146-241-230-54.dyn.eolo.it. [146.241.230.54])
        by smtp.gmail.com with ESMTPSA id e12-20020a05600c4e4c00b00411c9c0ede4sm1464622wmq.7.2024.02.13.07.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 07:28:38 -0800 (PST)
Message-ID: <20072ba530b34729589a3d527c420a766b49e205.camel@redhat.com>
Subject: Re: [PATCH v3] tcp: add support for SO_PEEK_OFF
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: kuba@kernel.org, passt-dev@passt.top, sbrivio@redhat.com,
 lvivier@redhat.com,  dgibson@redhat.com, jmaloy@redhat.com,
 netdev@vger.kernel.org, davem@davemloft.net
Date: Tue, 13 Feb 2024 16:28:36 +0100
In-Reply-To: <CANn89iL=npDL0S+w-F-iE2kmQ2rnNSA7K9ic9s-4ByLkvHPHYg@mail.gmail.com>
References: <20240209221233.3150253-1-jmaloy@redhat.com>
	 <8d77d8a4e6a37e80aa46cd8df98de84714c384a5.camel@redhat.com>
	 <CANn89iJW=nEzVjqxzPht20dUnfqxWGXMO2_EpKUV4JHawBRxfw@mail.gmail.com>
	 <eaee3c892545e072095e7b296ddde598f1e966d9.camel@redhat.com>
	 <CANn89iL=npDL0S+w-F-iE2kmQ2rnNSA7K9ic9s-4ByLkvHPHYg@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-13 at 14:34 +0100, Eric Dumazet wrote:
> On Tue, Feb 13, 2024 at 2:02=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >=20
> > On Tue, 2024-02-13 at 13:24 +0100, Eric Dumazet wrote:
> > > On Tue, Feb 13, 2024 at 11:49=E2=80=AFAM Paolo Abeni <pabeni@redhat.c=
om> wrote:
> > >=20
> > > > > @@ -2508,7 +2508,10 @@ static int tcp_recvmsg_locked(struct sock =
*sk, struct msghdr *msg, size_t len,
> > > > >               WRITE_ONCE(*seq, *seq + used);
> > > > >               copied +=3D used;
> > > > >               len -=3D used;
> > > > > -
> > > > > +             if (flags & MSG_PEEK)
> > > > > +                     sk_peek_offset_fwd(sk, used);
> > > > > +             else
> > > > > +                     sk_peek_offset_bwd(sk, used);
> > >=20
> > > Yet another cache miss in TCP fast path...
> > >=20
> > > We need to move sk_peek_off in a better location before we accept thi=
s patch.
> > >=20
> > > I always thought MSK_PEEK was very inefficient, I am surprised we
> > > allow arbitrary loops in recvmsg().
> >=20
> > Let me double check I read the above correctly: are you concerned by
> > the 'skb_queue_walk(&sk->sk_receive_queue, skb) {' loop that could
> > touch a lot of skbs/cachelines before reaching the relevant skb?
> >=20
> > The end goal here is allowing an user-space application to read
> > incrementally/sequentially the received data while leaving them in
> > receive buffer.
> >=20
> > I don't see a better option than MSG_PEEK, am I missing something?
>=20
>=20
> This sk_peek_offset protocol, needing  sk_peek_offset_bwd() in the non
> MSG_PEEK case is very strange IMO.
>=20
> Ideally, we should read/write over sk_peek_offset only when MSG_PEEK
> is used by the caller.
>=20
> That would only touch non fast paths.
>=20
> Since the API is mono-threaded anyway, the caller should not rely on
> the fact that normal recvmsg() call
> would 'consume' sk_peek_offset.

Storing in sk_peek_seq the tcp next sequence number to be peeked should
avoid changes in the non MSG_PEEK cases.=C2=A0

AFAICS that would need a new get_peek_off() sock_op and a bit somewhere
(in sk_flags?) to discriminate when sk_peek_seq is actually set. Would
that be acceptable?

Thanks!

Paolo


