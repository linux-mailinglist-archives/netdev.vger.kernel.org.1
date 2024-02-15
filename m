Return-Path: <netdev+bounces-71917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9E6855919
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 04:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03475B24E3D
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 03:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A041864;
	Thu, 15 Feb 2024 03:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="ZhasJfnO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3204A05
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 03:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707966323; cv=none; b=vB7Q+S0n5HIJJGxin8Wz1Kai+8AQKDEjcP4botCwcI2xUVpji4k/5ndEcETUmav/hYZrwSz2TsSKuYYDnbEJq3C73gtJcHvO+S8DxvpBYlNMCNUccEDF20mbIhbiNukWzVIZD6Hd+qQvul38Pe86FFn6J4KoIg+3muBAgqYrElM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707966323; c=relaxed/simple;
	bh=XQQUXJwbqJLCCf4zLjFHNZ5/X0OzLVljNQX9uXnnymU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NAQpvQVnpUkqmoqKvp7RkhZUVUL3QOwT4Gx6hMxUE9D5kDRLx+2qNGTwA/er++UN4SS4BBOU+Q5ol6vg13k0UYxmKivM6+8FjVIYKlToOru4cXMEwrR+Y3YPgme5j5oIGjQycyrqxX/jmCvRPbO3nrCmgSbcbJIP5UaoJB2ib2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=ZhasJfnO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1db562438e0so3326215ad.3
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 19:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707966320; x=1708571120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBVC5RzP0fTrPT+l1F9kKP29YyFrCG1YG6/Oc+yKVZM=;
        b=ZhasJfnO7R4tet583VDs6igZsNa5EJLFF4k13uWxyw07NwbnxOEm6WvfxmNNX+RCU0
         QCaRadQi+4GeiDH1P0FtlXEok+rwXl96N3Z+eU6vn/gYn2VSL2cgmhPvnGeBRSAnhJMm
         fxUy4p7So8+F80yV2hMQY5sjUEvqHn5cKP/mPaHQ+y22O4jHACx8C3c9fH6kiKeIkraE
         PdaluD4Tf/addkPgJwFtinPiCqgTxs+YK+iIY0CxptLskRTAeb47Jo/ZGYIMe7LbTlcF
         WEgGnZnKPEVvFqNAaEasUT52N6AnIRXQP18gmbP85PUUFO0PIykJjMiDQc3ZagWZio/B
         3GwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707966320; x=1708571120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBVC5RzP0fTrPT+l1F9kKP29YyFrCG1YG6/Oc+yKVZM=;
        b=xTqe//PuL77hOZvhF/rx+cTuraHUT8Qw5eSk+qNGsByI+fo5S64WWBIFTs+IAZJdBb
         3Ulusksnijq7C+tORG1Ox5Ei9tMkonc4jOOIbt/0kOg3RvbwB2JhTb/6HkxZWcKgGUzX
         QZdmMh0LPKWPrnyA71FuBMpud6liZ92+Uq9WBPzbsdqaB2OeKlXqXdD1UVexLtiUuAP/
         3QncYiEXKs1Q1Nog67c5tl6rud/pL6NrrfTIjH9aztHF0irJqjOb7J3hc2LPjOzYd1D8
         s0nvoLTylAjIXYndrLcH/5S12huPZCyem/WiowVizu2trDXXcBfYI2M1VB8UbPzC2NQP
         bZyg==
X-Forwarded-Encrypted: i=1; AJvYcCVfqFODDIjmZEaNH8ILOKn0yIFmBHVYV8WN6nRYS2HofBj0apz+PjPhcMOIy1PDHDCrScoZQvVWnGP9v3gchD+TnE7rTGgd
X-Gm-Message-State: AOJu0Yxcf6OL2hfg9Otmf9jBiGtD1ao3i5bNO3fkSTjsLlacuk7ZS1RX
	MM5WIesU/4u120ACS09AHy7ZpQqvVeiCqP+BTd/6wcPCjGnG1g6YoiD2oqSmEJg=
X-Google-Smtp-Source: AGHT+IFO9lRbYOHiISCvnM4d3MKt1zmKhVLVTKzazxwpWqu6Addn6ZN7I3g/EuFV9A9uQv+hN4msOw==
X-Received: by 2002:a17:902:c40c:b0:1db:5093:5e23 with SMTP id k12-20020a170902c40c00b001db50935e23mr653121plk.28.1707966320633;
        Wed, 14 Feb 2024 19:05:20 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id a8-20020a170902ecc800b001d9641003cfsm156387plh.142.2024.02.14.19.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 19:05:20 -0800 (PST)
Date: Wed, 14 Feb 2024 19:05:19 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Ahern <dsahern@gmail.com>
Cc: Andrea Claudi <aclaudi@redhat.com>, netdev@vger.kernel.org,
 sgallagh@redhat.com
Subject: Re: [PATCH] iproute2: fix build failure on ppc64le
Message-ID: <20240214190519.1233eef6@hermes.local>
In-Reply-To: <d2707550-36c2-45d3-ae76-f83b4c19f88c@gmail.com>
References: <d13ef7c00b60a50a5e8ddbb7ff138399689d3483.1707474099.git.aclaudi@redhat.com>
	<20240209083533.1246ddcc@hermes.local>
	<3730d7e4-058f-421f-8ecf-a9475440ef58@gmail.com>
	<20240209164542.716b4d7a@hermes.local>
	<ZczcqOHwlGC1Pmzx@renaissance-vector>
	<d2707550-36c2-45d3-ae76-f83b4c19f88c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Feb 2024 08:49:02 -0700
David Ahern <dsahern@gmail.com> wrote:

> On 2/14/24 8:30 AM, Andrea Claudi wrote:
> > On Fri, Feb 09, 2024 at 04:45:42PM -0800, Stephen Hemminger wrote: =20
> >> On Fri, 9 Feb 2024 15:14:28 -0700
> >> David Ahern <dsahern@gmail.com> wrote:
> >> =20
> >>> On 2/9/24 9:35 AM, Stephen Hemminger wrote: =20
> >>>> On Fri,  9 Feb 2024 11:24:47 +0100
> >>>> Andrea Claudi <aclaudi@redhat.com> wrote:
> >>>>    =20
> >>>>> ss.c:3244:34: warning: format =E2=80=98%llu=E2=80=99 expects argume=
nt of type =E2=80=98long long unsigned int=E2=80=99, but argument 2 has typ=
e =E2=80=98__u64=E2=80=99 {aka =E2=80=98long unsigned int=E2=80=99} [-Wform=
at=3D]
> >>>>>  3244 |                 out(" rcv_nxt:%llu", s->mptcpi_rcv_nxt);
> >>>>>       |                               ~~~^   ~~~~~~~~~~~~~~~~~
> >>>>>       |                                  |    |
> >>>>>       |                                  |    __u64 {aka long unsig=
ned int}
> >>>>>       |                                  long long unsigned int
> >>>>>       |                               %lu
> >>>>>
> >>>>> This happens because __u64 is defined as long unsigned on ppc64le. =
 As
> >>>>> pointed out by Florian Weimar, we should use -D__SANE_USERSPACE_TYP=
ES__
> >>>>> if we really want to use long long unsigned in iproute2.   =20
> >>>>
> >>>> Ok, this looks good.
> >>>> Another way to fix would be to use the macros defined in inttypes.h
> >>>>
> >>>> 		out(" rcv_nxt:"PRIu64, s->mptcpi_rcv_nxt);
> >>>>    =20
> >>>
> >>> since the uapi is __u64, I think this is the better approach. =20
> >>
> >> NVM
> >> Tried it, but __u64 is not the same as uint64_t even on x86.
> >> __u64 is long long unsigned int
> >> uint64_t is long unsigned int
> >> =20
> >=20
> > Is there anything more I can do about this?
> >  =20
>=20
> where does the uint64_t come in? include/uapi/linux/mptcp.h has
> mptcpi_rcv_nxt as __u64 and PRIu64 macros should be working without a
> problem - this is what perf tool uses consistently.

I just did this:

diff --git a/misc/ss.c b/misc/ss.c
index 5296cabe9982..679d50b8fef6 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -8,6 +8,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <inttypes.h>
 #include <fcntl.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
@@ -3241,7 +3242,7 @@ static void mptcp_stats_print(struct mptcp_info *s)
        if (s->mptcpi_snd_una)
                out(" snd_una:%llu", s->mptcpi_snd_una);
        if (s->mptcpi_rcv_nxt)
-               out(" rcv_nxt:%llu", s->mptcpi_rcv_nxt);
+               out(" rcv_nxt:%" PRIu64, s->mptcpi_rcv_nxt);
        if (s->mptcpi_local_addr_used)
                out(" local_addr_used:%u", s->mptcpi_local_addr_used);
        if (s->mptcpi_local_addr_max)


And got this:
    CC       ss.o
ss.c: In function =E2=80=98mptcp_stats_print=E2=80=99:
ss.c:3245:21: warning: format =E2=80=98%lu=E2=80=99 expects argument of typ=
e =E2=80=98long unsigned int=E2=80=99, but argument 2 has type =E2=80=98__u=
64=E2=80=99 {aka =E2=80=98long long unsigned int=E2=80=99} [-Wformat=3D]
 3245 |                 out(" rcv_nxt:%" PRIu64, s->mptcpi_rcv_nxt);
      |                     ^~~~~~~~~~~~         ~~~~~~~~~~~~~~~~~
      |                                           |
      |                                           __u64 {aka long long unsi=
gned int}
In file included from ss.c:11:
/usr/include/inttypes.h:105:41: note: format string is defined here
  105 | # define PRIu64         __PRI64_PREFIX "u"


