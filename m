Return-Path: <netdev+bounces-118955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCF3953A5C
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 20:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F6771F2535E
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 18:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC91944384;
	Thu, 15 Aug 2024 18:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="dDs1pZNX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F76544C6F
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723747945; cv=none; b=PkWQiCM+0cXDKGnLZvx2yTdMOzqm+NyJHiUDghA94bDQDi2dAx933wPDIGOQA5fSIt1Q+TYst9niA7j0q2bGITC/6RhhzUcynDM5m8IDUR1MV1sX9SdqfBuZkruFSerYNkOd3lvyKcrTO17mrt0Rkz9QB9NO4I4pzRq9i+hWHQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723747945; c=relaxed/simple;
	bh=WTsdf8FMp/NeDIDWUv7Q42ytwUbkAq6VZ3t90yXAKZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UBHGR6yUKyXcPfdSPEsNqIAT//kofDLo3b0xfSIMYiD0pvN5YjWzKrLXuXpqKIK0/MDOCBB6OqLjYcl8gZEpM6gv7vnIqw/DrxhQTHDasSClqKjvUA31Sk6n13rd3nMBq6fYvdZk929S3ufhDuMHo4Y/+dSWeFYLTdTaC4czESw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=dDs1pZNX; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5bd13ea7604so1586087a12.1
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 11:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1723747942; x=1724352742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWfHcVKEyUFyDBoxEtA6+YhAytduUvyjIGD1f0lrJvU=;
        b=dDs1pZNXsMauTO13zSXW9PmnamkCIwFZc9lpuYv7TJaiG930Xvppmag2qLbzArdzUK
         h8ON3lSo4UJ/Nvp0IX0OuEKgzPmmduq6YKj3kzDveSdqmZ4kVECay6cjyyz1DKuv2scb
         nuYi8lVFcKh7o9VaA5zETGtJDpyBXEW+PERwTTvYqU376ukQIwv66kLIag4v76BGoX7U
         5jJAH5u+HeNEQmd9YffGeocS0uAVKHpT8SxmbEYLJQadGh6L5unm/P5yMDc6GVgv+EAb
         47I4edNEIH6znyciJHsFMi3NDZoT+RHKltwGXsLR+g9AQMxXqei4PRqFX3bSe5FDgbzy
         1Ktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723747942; x=1724352742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWfHcVKEyUFyDBoxEtA6+YhAytduUvyjIGD1f0lrJvU=;
        b=ak1yAjXxjVggz3bID9cGZfILRzcfqPMBomodUr4P9uNw8JYsVD+hFo7YwLrZ5gPlAB
         ApvOKk1nF620hbz/NFTo+7Fgvi4KG52CNiNHf/KwGyn8OqQoJ3Xq6gOTRqf88cs54NvC
         ROPcWCmhImEVKHcqxZoMO/chb2KzWix3FtS94ZRA9tTg3DKkrv2chJ3gqMQirANk5Y0A
         D+KzGoIcsDxww8GBfSzAI2a93m37ieNLy9QCATag8U9GzCmYNc2aVm0rEaG9mAuRqlQD
         fO6aVDxyccz1p9PMdddq7I41pNo7IZf6A4+g7htrB3AkMtkxJSWxx2AeyCJf2k96HqiL
         t3wg==
X-Forwarded-Encrypted: i=1; AJvYcCWoOe9MRtHD5hEJjZY929lrUyQOnNsXsri6S6QSZ7kBhm2Mh9nbuluWZ4PFDTqbWlpi19XB2NGdXcH87XpwR7m++tW51cqF
X-Gm-Message-State: AOJu0YyZ4RW8emjYBcAayV5v+KTI897tjOGLfZ1WUoWRVjJQCUoWF65C
	h1I3hViafR4y4Nt6TVSO67WyZQDgB8cwfQ4kfL6K+/XMgkhPPLWvOgpIm2XtV8GRiKJqTT2HT2W
	BlwA45S4lLVE1mlSFgzoFANWBjNbwJ+lHfHfa
X-Google-Smtp-Source: AGHT+IG6JHXgxIPJUlpRwytmmXmjaTTyDc7y+/bFvNB1XqNTVDlHeUWXDgEwFATl/G11/bByAzhoXpcEQym0ZwlyDGM=
X-Received: by 2002:a05:6402:40d3:b0:57c:9d54:67db with SMTP id
 4fb4d7f45d1cf-5beca527b9emr283973a12.9.1723747942184; Thu, 15 Aug 2024
 11:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731172332.683815-1-tom@herbertland.com> <20240731172332.683815-5-tom@herbertland.com>
 <66ab8c1d6e343_2441da294b7@willemb.c.googlers.com.notmuch>
In-Reply-To: <66ab8c1d6e343_2441da294b7@willemb.c.googlers.com.notmuch>
From: Tom Herbert <tom@herbertland.com>
Date: Thu, 15 Aug 2024 11:52:11 -0700
Message-ID: <CALx6S34ei7r47XvhCHVaMZuw4-iCALZ9MDytpNN=syd9kuv05Q@mail.gmail.com>
Subject: Re: [PATCH 04/12] udp_encaps: Add new UDP_ENCAP constants
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com, 
	netdev@vger.kernel.org, felipe@sipanda.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 6:22=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Tom Herbert wrote:
> > Add constants for various UDP encapsulations that are supported
> >
> > Signed-off-by: Tom Herbert <tom@herbertland.com>
> > ---
> >  include/uapi/linux/udp.h | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/include/uapi/linux/udp.h b/include/uapi/linux/udp.h
> > index 1a0fe8b151fb..0432a9a6536d 100644
> > --- a/include/uapi/linux/udp.h
> > +++ b/include/uapi/linux/udp.h
> > @@ -36,6 +36,7 @@ struct udphdr {
> >  #define UDP_GRO              104     /* This socket can receive UDP GR=
O packets */
> >
> >  /* UDP encapsulation types */
> > +#define UDP_ENCAP_NONE               0
> >  #define UDP_ENCAP_ESPINUDP_NON_IKE   1 /* unused  draft-ietf-ipsec-nat=
-t-ike-00/01 */
> >  #define UDP_ENCAP_ESPINUDP   2 /* draft-ietf-ipsec-udp-encaps-06 */
> >  #define UDP_ENCAP_L2TPINUDP  3 /* rfc2661 */
> > @@ -43,5 +44,17 @@ struct udphdr {
> >  #define UDP_ENCAP_GTP1U              5 /* 3GPP TS 29.060 */
> >  #define UDP_ENCAP_RXRPC              6
> >  #define TCP_ENCAP_ESPINTCP   7 /* Yikes, this is really xfrm encap typ=
es. */
> > +#define UDP_ENCAP_TIPC               8
> > +#define UDP_ENCAP_FOU                9
> > +#define UDP_ENCAP_GUE                10
> > +#define UDP_ENCAP_SCTP               11
> > +#define UDP_ENCAP_RXE                12
> > +#define UDP_ENCAP_PFCP               13
> > +#define UDP_ENCAP_WIREGUARD  14
> > +#define UDP_ENCAP_BAREUDP    15
> > +#define UDP_ENCAP_VXLAN              16
> > +#define UDP_ENCAP_VXLAN_GPE  17
> > +#define UDP_ENCAP_GENEVE     18
> > +#define UDP_ENCAP_AMT                19
>
> Should these existing constants never have been UAPI to begin with?

Hi Willem,

I'm inclined to think they probably should be, especially if we need
these in eBPF.

Tom

>

