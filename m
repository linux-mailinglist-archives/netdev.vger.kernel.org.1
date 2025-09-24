Return-Path: <netdev+bounces-225933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCFEB99902
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 13:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 510B92A2D6B
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 11:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1EC2E425E;
	Wed, 24 Sep 2025 11:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdWCQrqh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA9E2DFA46
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 11:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758712913; cv=none; b=mO1ZwCoR7dPXaYm6IBvEQ7Ne6+S4oM9HIgRkZAPiT1hCsA7DjxRWhRqfE10CaGMwPm4GeFLJ0fhW3zS/9I0v6q7MS3iwHcAZoDZWSoKj62lFsHOH/eQ+95ZDAwhGWlg2fWOfd0WJbiUK/+fUVO2NIG588rvRt/S9iA6PTl1H5hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758712913; c=relaxed/simple;
	bh=YXL4lPnbAJH3NIq7JPnUD3UdEKqqq1Cg32Z9C3s9+s4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJUd2tg7Ruc6wz4VaCTykXiNpO1GQEp0IlbHHpIbkTm7zjOJqyRkVLq+ig6OGjKZj3qTVTdXYpwRnBOgsCNYlAoYbpt+TDT4AGdt8CIab7l4EfNB9GjPEq+TPQqyIOGjCh6NrirRv0I7lLS0T2GJBUPL1fAIfPYSfce6gAteTFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YdWCQrqh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758712906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3vAP8FsUJk8PIZpACRyUvOqyIq/F22fin2PfGx/vcc4=;
	b=YdWCQrqhYGMQaDNY3KTM9sJQ8tFdjeuD/Ja61IuTTVQv7d15FZImT3qZ2qde3/Z0rrDWUF
	mVzwazXV09Q1XlW0nynsGegBiM5YkQG5vIhwZ9LWdnVeC1j4q2/3H8MDEujG93t923dRkG
	yWxj91/z3bBeyIGq17HD6xx20yIO3VU=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-Ot73_y9fM7KwNpqn2RiP-Q-1; Wed, 24 Sep 2025 07:21:45 -0400
X-MC-Unique: Ot73_y9fM7KwNpqn2RiP-Q-1
X-Mimecast-MFC-AGG-ID: Ot73_y9fM7KwNpqn2RiP-Q_1758712904
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2711a55da20so31839975ad.1
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 04:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758712904; x=1759317704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3vAP8FsUJk8PIZpACRyUvOqyIq/F22fin2PfGx/vcc4=;
        b=bICCK0gh2GL4sumsxdj8NSIVvBu7sE2R1b/0xb/8CeuV4aLq6nzeAtYAc1oX3G1e+y
         T3JjIXfUrbf+spIpiaTWf54Q3XxLNNvLCCbABOtIQwW4UJKU4bFnT6VErpUtwavImL3a
         dTaJjjR5PL790pEGvyF1TM8fi+h+29gA1ApeRufI0koL74LbbUpAylYSECssNGYPfybg
         htQUKJlm+TQqo/vUW02+X0Ltwm17lVhUwsAdBoWdDl8p9WYyX/FJkxsoPOqNn4uujyoA
         dm3yZJDJPaIL7ICH5VrsoZRbnazFtEoBwNYm+IPWtT0z+KqgreInRtqaXS86Zhq3ashc
         72XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSc7dGyUqh+AKXaQeaAwiKZa5E3Ls7xR+dHaNPtyF4ZJtG9mOrHYCjWH8+SGZKg7qMNGFDmFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YycS8A6FCHmc0n9wMql1s/I6Pvfgkh2+FZV7X99z4diaaPgFOtl
	ymX7u+RTw1sCxlIOxqnVNNZF4dUuUzAl8WmnhwTlGgRng2PWflcc1y/+LEiILzMZIXkh4Wicf9v
	5WEsMiLaDyqLd4vG6AS7PXR2vAFJUKH0nbrflFoFP4nh7nfW5W+kwORL6sRoxNSNN5PNAGjePNn
	fYkstTiRImq8GRZkVdIev3sxpPrLV8dXGb
X-Gm-Gg: ASbGncuuw4L3zJGNDlwi1/M5ewWEl68z/OUijresWZRxxTxfsc8QN0rJUx6vzD5yCWa
	UEkLQSrBUr+SEYyJPl30JWs4gJqSH0B6aStwLtmE0XvdWyaQiXH+9PN/kB76+2gMYtkeMdpKAsW
	MXseaB4z4MCdWQYyS8OLxu
X-Received: by 2002:a17:903:2292:b0:26d:353c:75cd with SMTP id d9443c01a7336-27cc2100f79mr87319875ad.21.1758712904352;
        Wed, 24 Sep 2025 04:21:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK5j25zp+qR3y2Or9C3OlE2KjTlI6YV0TR8vyb+TBnaF9UqEPA0DkV6tRpB8e0GWVbP0wWJa2qxezYCPDmOAw=
X-Received: by 2002:a17:903:2292:b0:26d:353c:75cd with SMTP id
 d9443c01a7336-27cc2100f79mr87319645ad.21.1758712903978; Wed, 24 Sep 2025
 04:21:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922093743.1347351-3-jvaclav@redhat.com> <20250923170604.6c629d90@kernel.org>
In-Reply-To: <20250923170604.6c629d90@kernel.org>
From: =?UTF-8?B?SsOhbiBWw6FjbGF2?= <jvaclav@redhat.com>
Date: Wed, 24 Sep 2025 13:21:32 +0200
X-Gm-Features: AS18NWDsDXr22u2_E2zXqbAuYteKBCpdfAJ8_fD3vo_MssgmJS29OCt-zWJiSWU
Message-ID: <CAEQfnk3Ft4ke3UXS60WMYH8M6WsLgH=D=7zXmkcr3tx0cdiR_g@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] net/hsr: add protocol version to fill_info output
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 2:06=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 22 Sep 2025 11:37:45 +0200 Jan Vaclav wrote:
> >       if (hsr->prot_version =3D=3D PRP_V1)
> >               proto =3D HSR_PROTOCOL_PRP;
> > +     if (nla_put_u8(skb, IFLA_HSR_VERSION, hsr->prot_version))
> > +             goto nla_put_failure;
>
> Looks like configuration path does not allow setting version if proto
> is PRP. Should we add an else before the if? since previous if is
> checking for PRP already
>

The way HSR configuration is currently handled seems very confusing to
me, because it allows setting the protocol version, but for PRP_V1
only as a byproduct of setting the protocol to PRP. If you configure
an interface with (proto =3D PRP, version =3D PRP_V1), it will fail, which
seems wrong to me, considering this is the end result of configuring
only with proto =3D PRP anyways.

I think the best solution would be to introduce another change that
allows explicitly setting the version to PRP_V1 if the protocol is set
to PRP.

What do you think?


