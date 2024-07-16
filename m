Return-Path: <netdev+bounces-111824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D3D93338C
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 23:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F01F1C222DF
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 21:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E8378C6C;
	Tue, 16 Jul 2024 21:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J8UkSDkB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2BF6BFCA
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 21:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721165238; cv=none; b=jOTqvLjudySI+CLRGbLF6TJ/nKYV1iTvck9UGPpi9B7JnkOg0J/M6z/WMLjqsyg++d5WpVrDREqyrcicJRw9Po19fsIhIR3pBd++l1troRrLaNBThkckRKQB42cAwqeM+/SzuDVk64m5Qn9j2HxvavVNMgDYU4mFHhl7hAM2YyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721165238; c=relaxed/simple;
	bh=SGzieUQEpX16lgmk9mW82QaAzlznyacCBQJzom4R2r4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BixKjWjH7XPaFVU+pvhKrSqMRKIhmMdBNC3acAaiX5MEAGO/X8O+RLTJKjHzk2TlNDB4i/dp82pacDja4eQjlH+EqounkMis2TDZQgCwN7K+wvrTt9BkPTYxWY+M3KPnPdIs4ghRsqngqPPTzSprhw50y5nDxMRog1tF1qETONM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J8UkSDkB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721165236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kxB9jk333dC6G4q0E0+/79K2V4qLrZ+brHs5Bi9B0aY=;
	b=J8UkSDkBWZpMqELaux4lyFzkGd2K5sZh6oWsLOSBdk4PrUlMw/Of5zTbHJ1b1iPDLUpkBL
	GrvJRftJuwOFThz+3FJp3/tO2QOk0g+F6CXGm1If7Z07pEqroKfWlo3V9/3EvUgT7LpzML
	JStrS2nSmqx6mZgYqTNT8bt0hfPSQa0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-AGauw55DMwG0C8XeUXwaZg-1; Tue, 16 Jul 2024 17:27:14 -0400
X-MC-Unique: AGauw55DMwG0C8XeUXwaZg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ee91e5be95so68401511fa.2
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 14:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721165233; x=1721770033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kxB9jk333dC6G4q0E0+/79K2V4qLrZ+brHs5Bi9B0aY=;
        b=Wpf7AwvSDG+5CSZbgYzxeUgoAxvbMnWvJ1vqLN7Wk/HT74pAmssNyJ0kkHI1tkar7D
         mlo1YDy8QTGgln0V+se8LDCKO4R1vOZ572NfYZZFLxZ6+s0+iS2W8UFrYiQcKKE8QMvy
         XKhnSp601dE8lCvmm7dbzLNU5MZXwkyHuuts6zHgqwyDm3eYcB/ihZzPACldSNhRuvsP
         1VgMGq8yUBEsuxPeM4HlBq/nK/BQk1cJv1JLjkU/pP9o/XXuxsMrTPTRyzrQ0iCjLavs
         bBgPE+LIJ+lRf3v6yRjHv3qpVWWe/yJc49MAgHGQbgF808DvHPn4kkLdtvOnXynBgMtx
         sWhA==
X-Forwarded-Encrypted: i=1; AJvYcCVTpCHX6ddOrvhtDTcv3LNybIWtwiYFNKCbyNxOilvmHWZW8RqxY4BVdaeruixbACyTTLXZdP6uP/lDwscd2+QrYdhpgL6C
X-Gm-Message-State: AOJu0Yzl/PYqZOBbVCIrOFuI/zYVF6lK/kB0yIRycMRyzSf0z5dSbDnF
	9A4pUbMZWZk8P0qPdVSozCzBbXotjQhRbZAF5HzRyGZuL6y0/+nXDlExh6c4SyUlfDHvQa6h5Rn
	ZKyo8VKbM69ln8TPVATYnzbArFKeAbxIEXgQKmhFuD2HmCKQ/EHVMXYclK685KKztiO+4P2wQaP
	GiN2wgPd2Tv0eQkdclk22fUjwXV18T
X-Received: by 2002:a05:651c:a09:b0:2ee:9521:1443 with SMTP id 38308e7fff4ca-2eef41d8e15mr35802721fa.35.1721165233080;
        Tue, 16 Jul 2024 14:27:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHD3D037h/+QhZR8p/keq6zeLkUSWI2I6aUtc7yuVtgVxyAyui7505efWXvWtNyBzMyLxdQnF3i3LLzkG/aIsg=
X-Received: by 2002:a05:651c:a09:b0:2ee:9521:1443 with SMTP id
 38308e7fff4ca-2eef41d8e15mr35802491fa.35.1721165232698; Tue, 16 Jul 2024
 14:27:12 -0700 (PDT)
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
Date: Tue, 16 Jul 2024 17:27:00 -0400
Message-ID: <CAK-6q+jm51Co0k6cR0fMDXxJiM2G8z_nF8LjrcdCcSnGrap8EA@mail.gmail.com>
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

coming back to this. I think you need to add another switch to do that
and turn it by default in whatever the current default situation is,
otherwise this patch will break the next person's behaviour.

- Alex


