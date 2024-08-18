Return-Path: <netdev+bounces-119449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A32B2955AF4
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 06:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2271B21001
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 04:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAB538B;
	Sun, 18 Aug 2024 04:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c99R8tm9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38C89443
	for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 04:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723956518; cv=none; b=ZLNPXmP2nAjVUPwWBIxPz2i6Xog/4ZujD+uFCOzDBRqIcVvYuE4w7FB+LyXW6duJLAS9dVB796TAC6wCwj28y93ByCjxfDr9ejS8vpQqz2NTaxRdgHgB9LRh20GnWAdOQ71226HD9a0xO9EuKYjHKJI0bH5rWMKnyshbiUEIUEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723956518; c=relaxed/simple;
	bh=RIreuAg7JUUsGzfuPMeCGMzmQmYsx9ZoMRJO+fDFZ/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A5g5OovH+K9hRCQhEq1Y1BcN12a9fzXbgDLvyhO23KYNQ1e54o+FxHhxvWmfCAb2RG+7CdGRh3+2kFJJO7yFVDOYnyNw8j0Ow4GXnLONStrALP6C70WgwBrGB0+sKQ4IH9nxsOIDUfea8Fim3jp2tw2VJrvQUHvSk6ZwmUH5tBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c99R8tm9; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-710dc3015bfso2233826b3a.0
        for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 21:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723956516; x=1724561316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7v59zCTPyCNRuP6+2YoE9uB+/GJObdRG9pk14zmAhzM=;
        b=c99R8tm94tPL1HSnEtrwSDYv0r4j2I1GsCj0PAGUTcH9mRFentg7ldl0LHjfJbR2pE
         YGyGUU7wBSAoss9jHUbQG6Lbi9rIZdsjWkfC2YDub81LRUPiVLkHZc0a8p2AHYpzV8YK
         YbBsdKnfqIoa6mLLzYbaThBN6xLMn0n9MJo9tLzxWYUGBwMVOLXMqXB+/ZwHg4KYE747
         GVNFzEEUvMOHrmrCSEEdb22TpN8po1ufFwrZO2x45p3PbqOGnZ+OxUjarbfF7sVbspyP
         b590tJoIekkreJ2eNogyj++ylMdsZDkuCwFPePsfU0vxl/CZmDWtI3d3owmbkt1gGl4y
         Tnkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723956516; x=1724561316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7v59zCTPyCNRuP6+2YoE9uB+/GJObdRG9pk14zmAhzM=;
        b=UKN7ntfCOMH2h/7scJtn5LL0MamAtasjULL9zmfrrvG301R2QREOJj6bbAO/NpEL+O
         d8zYDYl4QvaghcXBSmByasNNtOTC+whRUrSuc3xhQ2Od32I1WP0JwpdsiYjVLWOc/s+7
         C3G315j9udSXkBmpLhlhuYP+J+VyxjlkJCIBhacM/IDNBUnJqc9r3oHUqpOxNNNWa9EJ
         21vat7AFEGxtfKEC3nqq4ttlK+oOs5E96TIeALHaoQXlyeyBa+FTdbRYWCK7NITrJjAH
         eSFHUMalV61vfxltrQoMe6KoW6LPVwf807kvA2Biwa0XKtx2rrOURbyBWDou+h3C7Aqv
         WF6g==
X-Forwarded-Encrypted: i=1; AJvYcCVWuCJNYixIpI4rml8llXJMxJyQnweJHJAh8wVrI0tymO4IqS5BoSYF7YUNb1bqqWv1aYklW703TnHzE/V/DPt0xnXkbBzA
X-Gm-Message-State: AOJu0Yyb/nER/J5RnI9ML+Oi8kUCm5nAgO8prJD0rHBUXoI/JqlzR1Bn
	vCTclQdUQz2F1VbHHJw2JuaDHs0clja+ujdGQwWC1dNRhNd0sl0WiOcYdvY6+e+i8himv3mC5Ra
	2LhEidq2yiqxA/7aYQ3Z7AHkoB/Q=
X-Google-Smtp-Source: AGHT+IEJchgeV/z/58hEZyxvRXZdco8pzhTk25fpLy5Pkq9XAxH0v+3UFG02jqNehzF3QIKjxANAw9VgNeHWu+1pW9Y=
X-Received: by 2002:a05:6a00:9182:b0:70e:cf2a:4503 with SMTP id
 d2e1a72fcca58-712770382efmr17674000b3a.11.1723956515899; Sat, 17 Aug 2024
 21:48:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175b3433a4c.aea7c06513321.4158329434310691736@shytyi.net>
 <202011110944.7zNVZmvB-lkp@intel.com> <175bd218cf4.103c639bc117278.4209371191555514829@shytyi.net>
 <175bf515624.c67e02e8130655.7824060160954233592@shytyi.net>
 <175c31c6260.10eef97f6180313.755036504412557273@shytyi.net>
 <20201117124348.132862b1@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <175e0b9826b.c3bb0aae425910.5834444036489233360@shytyi.net>
 <20201119104413.75ca9888@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <175e1fdb250.1207dca53446410.2492811916841931466@shytyi.net>
 <175e4f98e19.bcccf9b7450965.5991300381666674110@shytyi.net>
 <176458a838e.100a4c464143350.2864106687411861504@shytyi.net>
 <1766d928cc0.11201bffa212800.5586289102777886128@shytyi.net>
 <20201218180323.625dc293@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CANP3RGfG=7nLFdL0wMUCS3W2qnD5e-m3CbV5kNyg_X2go1=MzQ@mail.gmail.com>
 <17a9af1ae30.d78790a8882744.2052315169455447705@shytyi.net>
 <17a9b993042.b90afa5f896079.1270339649529299106@shytyi.net>
 <CAAedzxr75CQTPCxf4uq0CcpiOpxQ_rS3-GQRxX=5ApPojSf2wQ@mail.gmail.com>
 <191421fdb45.105ccb455117398.7522619910466771280@shytyi.net>
 <1914270a012.d45a8060119038.8074454106507215168@shytyi.net>
 <CANP3RGdeFFjL0OY1H-v6wg-iejDjsvHwBGF-DS_mwG21-sNw4g@mail.gmail.com> <19147ac34b9.11eb4e51f218946.9156409800195270177@shytyi.net>
In-Reply-To: <19147ac34b9.11eb4e51f218946.9156409800195270177@shytyi.net>
From: Erik Kline <ek.ietf@gmail.com>
Date: Sat, 17 Aug 2024 21:48:24 -0700
Message-ID: <CAMGpriVD6H4t9RSTBeVsLqPC5TGHoMkjOE1SE=MCMDgnxOK7ug@mail.gmail.com>
Subject: Re: [PATCH net-next V9] net: Variable SLAAC: SLAAC with prefixes of
 arbitrary length in PIO
To: Dmytro Shytyi <dmytro@shytyi.net>
Cc: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, ek <ek@loon.com>, 
	Jakub Kicinski <kuba@kernel.org>, yoshfuji <yoshfuji@linux-ipv6.org>, 
	liuhangbin <liuhangbin@gmail.com>, davem <davem@davemloft.net>, 
	netdev <netdev@vger.kernel.org>, David Ahern <dsahern@gmail.com>, 
	Joel Scherpelz <jscherpelz@google.com>, Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dmytro,

Well, there are roughly 1,000,001 threads where this has been hashed
out.  It's not possible to point to a single document, nor should it
be necessary IMHO.

Furthermore, changing this doesn't solve the non-deployability of it
in the general case.  A general purpose network has no idea whether
attached nodes support the non-default SLAAC configuration, and RAs so
configured will just leave legacy hosts without IPv6 connectivity.

There is still more that can be said, but a troll through the 6MAN
working group archives will find numerous discussions.


On Mon, Aug 12, 2024 at 10:55=E2=80=AFAM Dmytro Shytyi <dmytro@shytyi.net> =
wrote:
>
> Dear Maciej, Erik,
>
> Thank you for your response and for highlighting that this topic
> has been discussed multiple times within IETF and other forums.
>
> I understand that "race to the bottom" is a term that has been
> used in various discussions, but I=E2=80=99ve noticed that a concrete
> definition of "fundamental problem" (in ML, mail of EK, 2021-10-14 18:26:=
30)
> "race to the bottom", particularly in the
> context [2], has been somewhat elusive.
>
> The fundamental problem "race to the bottom" was
> brought up as a issue in the current topic,
> therefore, could Erik or you provide a more detailed explanation
> or point me to specific documents or discussions where this
> fundamental problem "race to the bottom" has been _clearly
> defined_ and _well contextualized_ regarding these two questions?
>  [1]. Would you be kind to send us the explanation of
>     "race to the bottom problem" in IP context with examples.
>  [2]. Would you be kind to explain how the possibility of configuration o=
f
>      prefix lengths longer that 64, enables
>      fundamental problem "race to the bottom"?
>
> Understanding this more concretely would
> be very helpful as we continue to address the issues.
>
> Thank you for your guidance and support.
>
> Best regards,
> Dmytro Shytyi et al.
>
> ---- On Mon, 12 Aug 2024 18:34:56 +0200 Maciej =C5=BBenczykowski  wrote -=
--
>
>  > On Sun, Aug 11, 2024 at 10:16=E2=80=AFAM Dmytro Shytyi dmytro@shytyi.n=
et> wrote:
>  > >
>  > > Hello Erik Kline,
>  > >
>  > >   You stated that, VSLAAC should not be accepted in large part becau=
se
>  > >   it enables a race to the bottom problem for which there is no solu=
tion
>  > >   in sight.
>  > >
>  > >   We would like to hear more on this subject:
>  > >   1. Would you be kind to send us the explanation of
>  > >   "race to the bottom problem" in IP context with examples.
>  > >
>  > >   2. Would you be kind to explain howt he possibility of configurati=
on of
>  > >   prefix lengths longer that 64, enables "race to the bottom problem=
"?
>  >
>  > This has been discussed multiple times in IETF (and not only), I don't
>  > think this is the right spot for this sort of discussion.
>  >
>  > >
>  > >   We look forward for your reply.
>  >
>  > NAK: Maciej =C5=BBenczykowski maze@google.com>
>  > >
>  > > Best regards,
>  > > Dmytro SHYTYI, et Al.
>  > >
>  > >  >
>  > >  >
>  > >  >
>  > >  > ---- On Mon, 12 Jul 2021 19:51:19 +0200 Erik Kline ek@google.com>=
 wrote ---
>  > >  >
>  > >  > VSLAAC is indeed quite contentious in the IETF, in large part bec=
ause
>  > >  > it enables a race to the bottom problem for which there is no sol=
ution
>  > >  > in sight.
>  > >  >
>  > >  > I don't think this should be accepted.  It's not in the same cate=
gory
>  > >  > of some other Y/N/M things where there are issues of kernel size,
>  > >  > absence of some underlying physical support or not, etc.
>  > >  >
>  > >  >
>  > >  > On Mon, Jul 12, 2021 at 9:42 AM Dmytro Shytyi dmytro@shytyi.net> =
wrote:
>  > >  > >
>  > >  > > Hello Jakub, Maciej, Yoshfuji and others,
>  > >  > >
>  > >  > > After discussion with co-authors about this particular point "I=
nternet Draft/RFC" we think the following:
>  > >  > > Indeed RFC status shows large agreement among IETF members. And=
 that is the best indicator of a maturity level.
>  > >  > > And that is the best to implement the feature in a stable mainl=
ine kernel.
>  > >  > >
>  > >  > > At this time VSLAAC is an individual proposal Internet Draft re=
flecting the opinion of all authors.
>  > >  > > It is not adopted by any IETF working group. At the same time w=
e consider submission to 3GPP.
>  > >  > >
>  > >  > > The features in the kernel have optionally "Y/N/M" and status "=
EXPERIMENTAL/STABLE".
>  > >  > > One possibility could be VSLAAC as "N", "EXPERIMENTAL" on the l=
inux-next branch.
>  > >  > >
>  > >  > > Could you consider this possibility more?
>  > >  > >
>  > >  > > If you doubt VSLAAC introducing non-64 bits IID lengths, then o=
ne might wonder whether linux supports IIDs of _arbitrary length_,
>  > >  > > as specified in the RFC 7217 with maturity level "Standards Tra=
ck"?
>  > >  > >
>  > >  > > Best regards,
>  > >  > > Dmytro Shytyi et al.
>  > >  > >
>  > >  > > ---- On Mon, 12 Jul 2021 15:39:27 +0200 Dmytro Shytyi dmytro@sh=
ytyi.net> wrote ----
>  > >  > >
>  > >  > >  > Hello Maciej,
>  > >  > >  >
>  > >  > >  >
>  > >  > >  > ---- On Sat, 19 Dec 2020 03:40:50 +0100 Maciej =C5=BBenczyko=
wski maze@google.com> wrote ----
>  > >  > >  >
>  > >  > >  >  > On Fri, Dec 18, 2020 at 6:03 PM Jakub Kicinski kuba@kerne=
l.org> wrote:
>  > >  > >  >  > >
>  > >  > >  >  > > It'd be great if someone more familiar with our IPv6 co=
de could take a
>  > >  > >  >  > > look. Adding some folks to the CC.
>  > >  > >  >  > >
>  > >  > >  >  > > On Wed, 16 Dec 2020 23:01:29 +0100 Dmytro Shytyi wrote:
>  > >  > >  >  > > > Variable SLAAC [Can be activated via sysctl]:
>  > >  > >  >  > > > SLAAC with prefixes of arbitrary length in PIO (rando=
mly
>  > >  > >  >  > > > generated hostID or stable privacy + privacy extensio=
ns).
>  > >  > >  >  > > > The main problem is that SLAAC RA or PD allocates a /=
64 by the Wireless
>  > >  > >  >  > > > carrier 4G, 5G to a mobile hotspot, however segmentat=
ion of the /64 via
>  > >  > >  >  > > > SLAAC is required so that downstream interfaces can b=
e further subnetted.
>  > >  > >  >  > > > Example: uCPE device (4G + WI-FI enabled) receives /6=
4 via Wireless, and
>  > >  > >  >  > > > assigns /72 to VNF-Firewall, /72 to WIFI, /72 to Load=
-Balancer
>  > >  > >  >  > > > and /72 to wired connected devices.
>  > >  > >  >  > > > IETF document that defines problem statement:
>  > >  > >  >  > > > draft-mishra-v6ops-variable-slaac-problem-stmt
>  > >  > >  >  > > > IETF document that specifies variable slaac:
>  > >  > >  >  > > > draft-mishra-6man-variable-slaac
>  > >  > >  >  > > >
>  > >  > >  >  > > > Signed-off-by: Dmytro Shytyi dmytro@shytyi.net>
>  > >  > >  >  > >
>  > >  > >  >
>  > >  > >  >  > IMHO acceptance of this should *definitely* wait for the =
RFC to be
>  > >  > >  >  > accepted/published/standardized (whatever is the right te=
rm).
>  > >  > >  >
>  > >  > >  > [Dmytro]:
>  > >  > >  > There is an implementation of Variable SLAAC in the OpenBSD =
Operating System.
>  > >  > >  >
>  > >  > >  >  > I'm not at all convinced that will happen - this still se=
ems like a
>  > >  > >  >  > very fresh *draft* of an rfc,
>  > >  > >  >  > and I'm *sure* it will be argued about.
>  > >  > >  >
>  > >  > >  >  [Dmytro]
>  > >  > >  > By default, VSLAAC is disabled, so there are _*no*_ impact o=
n network behavior by default.
>  > >  > >  >
>  > >  > >  >  > This sort of functionality will not be particularly usefu=
l without
>  > >  > >  >  > widespread industry
>  > >  > >  >
>  > >  > >  > [Dmytro]:
>  > >  > >  > There are use-cases that can profit from radvd-like software=
 and VSLAAC directly.
>  > >  > >  >
>  > >  > >  >  > adoption across *all* major operating systems (Windows, M=
ac/iOS,
>  > >  > >  >  > Linux/Android, FreeBSD, etc.)
>  > >  > >  >
>  > >  > >  > [Dmytro]:
>  > >  > >  > It should be considered to provide users an _*opportunity*_ =
to get the required feature.
>  > >  > >  > Solution (as an option) present in linux is better, than _no=
 solution_ in linux.
>  > >  > >  >
>  > >  > >  >  > An implementation that is incompatible with the published=
 RFC will
>  > >  > >  >  > hurt us more then help us.
>  > >  > >  >
>  > >  > >  >  [Dmytro]:
>  > >  > >  > Compatible implementation follows the recent version of docu=
ment: https://datatracker.ietf.org/doc/draft-mishra-6man-variable-slaac/ Th=
e sysctl usage described in the document is used in the implementation to a=
ctivate/deactivate VSLAAC. By default it is disabled, so there is _*no*_ im=
pact on network behavior by default.
>  > >  > >  >
>  > >  > >  >  > Maciej =C5=BBenczykowski, Kernel Networking Developer @ G=
oogle
>  > >  > >  >  >
>  > >  > >  >
>  > >  > >  > Take care,
>  > >  > >  > Dmytro.
>  > >  > >  >
>  > >  > >
>  > >  >
>  > >  >
>  > >  >
>  > >
>  >
>  > --
>  > Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google
>  >

