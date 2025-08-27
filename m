Return-Path: <netdev+bounces-217335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DDAB3859C
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 17:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD97D3B9F76
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 15:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E861C5D72;
	Wed, 27 Aug 2025 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lKXgaeb6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6542A1C862F
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756306893; cv=none; b=DNR5pKpwXDWQhEOkxVpMi3kadLTtHVGZKQO6VijJbLi6O9T5RTLwDN40mfNf6QscP8ldVP+8MCFrWs1yfKhldJ4Uc0sAekXVtouJUYmrthUOGhjROL8Da/bCntj6pI7jYj1f+xta0ZrynDR+bITY9mYSlVrehZ7bE7fWu+Yy22A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756306893; c=relaxed/simple;
	bh=nOkQtnU/CdYzFXICwBqZrPJb/6UcOqneuZYW52PGCys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dpYiDVxYlvvq76pO/+Lt6sTOZ2qjLPCMJhGOHELooFvuXDmUjTLD2dkewqMUUafKPfLOfVKFbtd1jSlGAPGaGTqMM2MqkS+filNiz3tg4MhAudaQdsC72T03qI52N3zwJVTQ2RhGjodDEqY61rQfD7YBszkAoWm3tI6VuSooG6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lKXgaeb6; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b109914034so89869581cf.0
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 08:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756306890; x=1756911690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxI2QHBfgv/KhmaGxQrz/rHQ5JUOrzYUncHB4G6a9Fo=;
        b=lKXgaeb6ECbI+CUM2dG78g8rrzOqRQDJPwU7ar1Q623RnEtTHV7BpnVnShnEaQHbUu
         dk+8fB3BAG0uPv32VKA+90EkaZmdmdLb/r1QnvFtvoY1iPISy2/xrHKGTI4ShxNbMEIO
         3OBdFnYLs02iU6GliIOKWnJTIM86PNKyXoF/JpsFeGd8Ai4nu72rOGLEyMoGdDcGHVuw
         7bb7+juuhnsMy9b15j3czQrh/w+0GolTk6D398S5pME+GL1n3fn9jqzKnZs4H95GSJHd
         S0X9Rml+WDJQKc+BEYCgSaOTOZj34eknkfqd495NnoywPHl9F75YFdzwn/3G+4gbpBE4
         XmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756306890; x=1756911690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxI2QHBfgv/KhmaGxQrz/rHQ5JUOrzYUncHB4G6a9Fo=;
        b=EEQSKQy/8JFYhpFhtfrUP2IseUu8eYEe38D+ra7pWahYNI9+G/mz0BZOYSRtxS1zRw
         7tzIjfXY8/buz8DaVSC1RhUAhuEs0kVtJ40Ly0Oe3moRGW1+gp/q8iwAhn9v/fn7v/ix
         CMvFNr8gNZHOIa211BrKO9aZmNytzhOyVm9vYUd9M7hqDBOZlcly4WETVcli6ANlM2G4
         2v5ubi5kQ7eCexo7Y0zf1cw85cheqUoO0KxXqDeJ24+4X2oY7CAxiLpWPrj18cp5XdsA
         30GY20exR+Sf9vXIUgClf3eIOxfWStGKHvaW00PRyCUws70yg9S5+xzXoAUkTSaL2g04
         OYFA==
X-Forwarded-Encrypted: i=1; AJvYcCVVw0ft/9JWnSH9TF52rbeeIGSNa6BIzvTv3/8fQJx8ZjHPeb72UuS56wNzaub8s5GenuIEWok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyja66AbMSjE920i3xYV/U5pLee3j4LUze6aIpVcQQy8Xasqy2p
	QyPzsm3LFBhqdaHUF21bmkdiqIAm1hnJwhuo9F6rFiE/Cqf1hI785T+ceN1Wns02d2sBTuj8tZJ
	zv1QXPVHDfNfBFgZmf+RPVm95KXvM8gzIWpRvimIZ
X-Gm-Gg: ASbGncuKgLBqVru3izPZAQRZzKN26TyrdxqsSYe0LGblskgwEx9ZvKuTaKQJTfup78Z
	t4GQiYuajlBaFMXm1bPNr0CmpVN2dNSfdditfd3Bcm9Xix94IMrC/42O1K6cF+7Tq4CApqyij6A
	njAE+Hg+UkP/+AZYC7y9ancjofYEsbbUQRhcXBOoQbLaSin3XvAIRAapc0v0bU/zfFYe/HDBmkW
	0X2c+7qVxE9MYwk3PziCUhmL05o80DBNXEz
X-Google-Smtp-Source: AGHT+IFMlqD35tYOnj60/AqhlA8Cctp4Q5D28EbX4u76TJwnsVObctHW7RbcSpBrpRvLS41aCnumev2bvgcn4+IjeFs=
X-Received: by 2002:a05:622a:d5:b0:4b2:d607:16c4 with SMTP id
 d75a77b69052e-4b2d60719bamr127929821cf.73.1756306852614; Wed, 27 Aug 2025
 08:00:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827120503.3299990-1-edumazet@google.com> <20250827120503.3299990-4-edumazet@google.com>
 <8f2d8a47-4531-4d3b-9a64-cf9477b7b41f@kernel.org>
In-Reply-To: <8f2d8a47-4531-4d3b-9a64-cf9477b7b41f@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 27 Aug 2025 08:00:40 -0700
X-Gm-Features: Ac12FXyvcJ75mMd108XGVJWSzW6nZZiJrm9Zrr2158JJ61uUv1CcjTIPNkpDLX8
Message-ID: <CANn89iKdv2OfNm2=iRW6vGqOUsxZbDf9vZ5DdagkFTZzXoPQQQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] inet: ping: make ping_port_rover per netns
To: David Ahern <dsahern@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 7:57=E2=80=AFAM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 8/27/25 6:05 AM, Eric Dumazet wrote:
> > @@ -84,12 +82,12 @@ int ping_get_port(struct sock *sk, unsigned short i=
dent)
> >       isk =3D inet_sk(sk);
> >       spin_lock(&ping_table.lock);
> >       if (ident =3D=3D 0) {
> > +             u16 result =3D net->ipv4.ping_port_rover + 1;
> >               u32 i;
> > -             u16 result =3D ping_port_rover + 1;
> >
> >               for (i =3D 0; i < (1L << 16); i++, result++) {
> >                       if (!result)
> > -                             result++; /* avoid zero */
> > +                             continue; /* avoid zero */
> >                       hlist =3D ping_hashslot(&ping_table, net, result)=
;
> >                       sk_for_each(sk2, hlist) {
> >                               if (!net_eq(sock_net(sk2), net))
> > @@ -101,7 +99,7 @@ int ping_get_port(struct sock *sk, unsigned short id=
ent)
> >                       }
> >
> >                       /* found */
> > -                     ping_port_rover =3D ident =3D result;
> > +                     net->ipv4.ping_port_rover =3D ident =3D result;
>
> READ_ONCE above and WRITE_ONCE here?

Note we hold ping_table.lock for both the read and write,
so there is no need for READ_ONCE() or WRITE_ONCE() here.

Thank you !

