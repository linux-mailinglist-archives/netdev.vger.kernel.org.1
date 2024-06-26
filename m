Return-Path: <netdev+bounces-106937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E440E91834D
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 15:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67D6D1F21A62
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 13:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415C21836FB;
	Wed, 26 Jun 2024 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ScyVxO9V"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736EC181D1F
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 13:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409727; cv=none; b=U9a2/Vti6Crhta3NdY/5+WIt0JMuvEVCjyurDAycWztJcE4KVkB8HZ0DSV12ZB5YItDvEk62WNzWqrW0/mhttfL3IezROjtqNsZSsgoNClgoBq8AKslfMVtipKEEsCG1voyRvfbwi8Wkb583JUYKPVDjNf9vsvgH0P7loUK6Md0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409727; c=relaxed/simple;
	bh=cEjtRolDCfKQ9IvTMKrFmtTXKUoTDyiceEDQ9jpuSi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7/67z4wQlIk2wwmt6FdrOumPzYtkeuebYlvPou38LDZQPOavhWtvi90wdZfF/FTiyGok6yyVPTlJYVaP+hOrOaf4X6DSUwN6eiHU1/9/9OeZHp8RjUNaut6/8x4baW3IwRvxfekXJdCRTeDFcL9qXW8V7yV9sJ2kApz+H1zDhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ScyVxO9V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719409724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hvXKpAHhZexkNIvChdHi+nkqCcOCNF/XIjN6+0tv388=;
	b=ScyVxO9V7izyte1/VSXl9WuSFittqVwfaKnOTcu7LLdYHWRPMCTwZIEdMcDTZH91G2ADGR
	S59/YGiivt3iSkag+DQkDvNrFzFvAOBBsBLIiBeVVFNXORpb2PIm+Ex4dFjdzCLNMSP3Zg
	BgIrrt1/cqI8BhKF0ZOwppvaPlHuFmA=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-QJnfwi3dPkmXd5bynIz7Kw-1; Wed, 26 Jun 2024 09:48:43 -0400
X-MC-Unique: QJnfwi3dPkmXd5bynIz7Kw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ec72d14876so10727311fa.2
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 06:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719409721; x=1720014521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvXKpAHhZexkNIvChdHi+nkqCcOCNF/XIjN6+0tv388=;
        b=O0FWjKld5oNG+Gw6nylPKUnnOr/5heP/J/kzP8A7km7GgpWybPs+5gQyNwYkwn2iMT
         maDgIERMzkJKy31/c1YGpEEJLJ0fZS/6+zzhJALH27T75ef0uRpDiKraXpGeFOn1lrMj
         3EKltr6HGZ6MAbJ6FC8Ugx57GbH+dpKKHRicRMSFZovqZKInJDyZUX/rnZAaHVZl9ojl
         t2aZAVUDj1/ruvwABmUyW2hQQ0CxWOAdr/PdDssEQkfzsTw0glWnHGT4rP4Dg3AkRfab
         4pw0Y5RO65+eBLUy2c/VEGojf3+F/gIagdx7TzZwNwVrKfjNb1vfPtz/T6+Tna9BHRCG
         DB/w==
X-Forwarded-Encrypted: i=1; AJvYcCXfuVlP1EzY85ZQUFPJ1+vTjFk0GwPAx/NZ9L9ee4peQcV+mQopOnmZ7jjFm8dSgWZhkI3c+DrPZObZHd26dI1x+Re4LDoE
X-Gm-Message-State: AOJu0Yw9VskBnjTpSUJ7WJP+r70H9H78WsNldjxsTQFAca/OTnsxKMnc
	/qRORWFD4CEwCG8p6Im2R31ySj6DqQBVC40gRobbP3duk/3pdQdA/8KZo5iiRkYdNeOSxvofvnJ
	ASIz/q5B21wQyi2B501E71qe59W4c3VwhChdHij0qi0vrKksNf34lYcJuBIRyIEqkgsV43iK1Ru
	wXc9QkhjlrmDBGievYtqsRFTChsv0X
X-Received: by 2002:a2e:6808:0:b0:2ec:588d:7ecc with SMTP id 38308e7fff4ca-2ec5b27a875mr66146341fa.12.1719409721681;
        Wed, 26 Jun 2024 06:48:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWr9A8HlXr3cWn0bW10jR/P2yGKk2CEGLW8OPrjvtvXaetA9H/5QUUzENARZAZqSPVij/rzCu3ObGzbE48Ntw=
X-Received: by 2002:a2e:6808:0:b0:2ec:588d:7ecc with SMTP id
 38308e7fff4ca-2ec5b27a875mr66146081fa.12.1719409721300; Wed, 26 Jun 2024
 06:48:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624141602.206398-3-Mathis.Marion@silabs.com>
 <20240625213859.65542-1-kuniyu@amazon.com> <CAK-6q+gsx15xnA5bEsj3i9hUbN_cqjFDHD0-MtZiaET6tESWmw@mail.gmail.com>
 <0fc38c1b-1a28-4818-b2cc-a661f037999d@silabs.com>
In-Reply-To: <0fc38c1b-1a28-4818-b2cc-a661f037999d@silabs.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 26 Jun 2024 09:48:30 -0400
Message-ID: <CAK-6q+hRz-M0hy611rDZhiF7CVUSD1FmPGMLGNBhVJ-CjSFqtg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] ipv6: always accept routing headers with 0
 segments left
To: Mathis Marion <mathis.marion@silabs.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, alex.aring@gmail.com, davem@davemloft.net, 
	dsahern@kernel.org, edumazet@google.com, jerome.pouiller@silabs.com, 
	kuba@kernel.org, kylian.balan@silabs.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, 
	Michael Richardson <mcr@sandelman.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 26, 2024 at 6:10=E2=80=AFAM Mathis Marion <mathis.marion@silabs=
.com> wrote:
>
> On 26/06/2024 3:45 AM, Alexander Aring wrote:
> > Hi,
> >
> > On Tue, Jun 25, 2024 at 5:39=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazo=
n.com> wrote:
> >>
> >> From: Mathis Marion <Mathis.Marion@silabs.com>
> >> Date: Mon, 24 Jun 2024 16:15:33 +0200
> >>> From: Mathis Marion <mathis.marion@silabs.com>
> >>>
> >>> Routing headers of type 3 and 4 would be rejected even if segments le=
ft
> >>> was 0, in the case that they were disabled through system configurati=
on.
> >>>
> >>> RFC 8200 section 4.4 specifies:
> >>>
> >>>        If Segments Left is zero, the node must ignore the Routing hea=
der
> >>>        and proceed to process the next header in the packet, whose ty=
pe
> >>>        is identified by the Next Header field in the Routing header.
> >>
> >> I think this part is only applied to an unrecognized Routing Type,
> >> so only applied when the network stack does not know the type.
> >>
> >>     https://www.rfc-editor.org/rfc/rfc8200.html#section-4.4
> >>
> >>     If, while processing a received packet, a node encounters a Routin=
g
> >>     header with an unrecognized Routing Type value, the required behav=
ior
> >>     of the node depends on the value of the Segments Left field, as
> >>     follows:
> >>
> >>        If Segments Left is zero, the node must ignore the Routing head=
er
> >>        and proceed to process the next header in the packet, whose typ=
e
> >>        is identified by the Next Header field in the Routing header.
> >>
> >> That's why RPL with segment length 0 was accepted before 8610c7c6e3bd.
> >>
> >> But now the kernel recognizes RPL and it's intentionally disabled
> >> by default with net.ipv6.conf.$DEV.rpl_seg_enabled since introduced.
> >>
> >> And SRv6 has been rejected since 1ababeba4a21f for the same reason.
> >
> > so there might be a need to have an opt-in knob to actually tell the
> > kernel ipv6 stack to recognize or not recognize a next header field
> > for users wanting to bypass certain next header fields to the user
> > space?
> >
> > - Alex
> >
>
> My point is that if a particular routing header support is disabled
> through system configuration, it should be treated as any unrecognized
> header. From my perspective, doing otherwise causes a regression every
> time a new routing header is supported.
>

makes sense to me. I am asking myself what the exact reason is to have
the difference between "recognized" and "unrecognized" to judge more
about such change and what we may miss here to consider?

- Alex


