Return-Path: <netdev+bounces-170921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E8DA4AAD1
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 12:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE8C1897B9D
	for <lists+netdev@lfdr.de>; Sat,  1 Mar 2025 11:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454421D5CD7;
	Sat,  1 Mar 2025 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NF3Y8dRq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E44523F37D
	for <netdev@vger.kernel.org>; Sat,  1 Mar 2025 11:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740829551; cv=none; b=QHW0Uuhj1T23ZjD08qu3bckYkikWhey6o7xjqk1a5U58T2+9ThALKTIDapjPKcqJjreO48qkrJ/qhoi0Hc9uTfE9QqqMaKErAKc2idxPhmtH0VRETowOYj+pqykq4bhNaivitVs1tQdxCBXlHxrUR3+yEVwi9vScjfK8b14MsnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740829551; c=relaxed/simple;
	bh=dU09FClwR0GDDMTVXUYblwOmALPNXdDnBNMK/tvDSpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELigqpHXlWKyAkXL+g+060epYiLwG1zO1jGTwm7u2FalGWqgUCU+MExdNegSg5xQTQlOXmhFenA/y5Y4ukAFc8O8AzBz6Y/KytaeUM5NkSFNXoEoJUDz43z7wSCNKd/4b1QNKeb8EJPoaq17Sdlv57/TGT6esUox2+Vaf9lXRUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NF3Y8dRq; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6fd47dfe76cso19929257b3.3
        for <netdev@vger.kernel.org>; Sat, 01 Mar 2025 03:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740829548; x=1741434348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmS1PPHq8lABZggEtaxPRHB7AJcK8W+QpIPwvdWaXGc=;
        b=NF3Y8dRqYBtcAInY6YZUgRbZoFWGP3EoupLR/u0/zpk9aWdbYC8WVWA2x2EgPitdkB
         svYgF7P9RMs58Zkew24eqFE2rnuYYTy1j1Xy5LhlsgQJVkp+isyLCMnpsC/ZNjZZEH08
         czcgXddL1H4hgMpC4iEQZFjhdVckSIGyg8Q94K0/EJ+xy4vA43Z0StpCAElVs3+bf3rN
         5qWz0Cfs254eIJlTnBJdVMvrfUN4ukgkS9w8d/DulXO1VZpQ4+YvynhCoXxTEKSwz1OE
         Cthoj+mKhqzFpSW1KkekB23qjj4T4aohGqSLbyaMOSojSRWOcQCgzBnPsA4Ux5z3v5rr
         En1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740829548; x=1741434348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NmS1PPHq8lABZggEtaxPRHB7AJcK8W+QpIPwvdWaXGc=;
        b=s6v31NuCi6ktvH7XvNxV+9aVKeUUFL1Fexdy1LFtkrAoNcPFqdi6LxohcIR3nsVliU
         LnQa34yKNek6gPTbk5FHnsV67mE38VP99d1C06vQvMRjBuKbrhYBxOuqUsFjd1nZz7h0
         J5gNn2GAWZbIaO6vFlA77W82lYExqEkKsL60uzhivfK31f98gBq11uP6IAp//2+GgXtv
         Ezj1/D19teRoT1r0vqrpWlC0cuwYECQxB8BDUf7f/8vjmjuoPBxhKFNO2mWwdYWbuzId
         mLf47TW5wsYxXaavFMOPMv6/0xgo4hwFh4b+f+kdz6XEI6tkxqmP5TIOfn5vizhwZGDx
         yH1w==
X-Forwarded-Encrypted: i=1; AJvYcCWa13RXkZDyJBnQf44hpHYcprsiDMlfCrIAKodrW4/5oN7sflgNLrtwe6hwr/Q1bK1oRym1Ang=@vger.kernel.org
X-Gm-Message-State: AOJu0YydyMzm2DcQzFZxDA8Fl6ZBTFkNOGaNjSRwuQ3vcVfaLQcGFyo/
	rreuOysWkYXdcp6iorQ7n+VmVrdO6g+UFSUzY4ZVHHMoXvLx7814YeUeQ4XAQ+W5jTNJM5Vyt54
	S8Csb6uZ0sYeB4+bkVTaMTRjmrw==
X-Gm-Gg: ASbGncsZudkpIbXyBQZ+PKt4Voj8WXIzP/D1zHoBqMQcNy0nrQyCfANtsK0gFjcukjJ
	yL87qgEakvYMJ4GVuz9HZqzCqF7EncuUfvn9nwfEjAUgSKeG8JvrflLnxklWxuhj1XKoG1VicDX
	+SBd1FsOdAIQe51cAbEpgCaRInjRXAIXyrr2uDpQ==
X-Google-Smtp-Source: AGHT+IECpiICxbXH9jPk+F9Q1HJ7oZnCGcThwvO9wNe1bDIbzkMtBVFOa8fAgziRLEizgNcyKtnpyvXEFLH1zjXDXRs=
X-Received: by 2002:a05:690c:4b12:b0:6e3:323f:d8fb with SMTP id
 00721157ae682-6fd4a068c4dmr90655127b3.14.1740829548485; Sat, 01 Mar 2025
 03:45:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228173505.3636-1-rsalvaterra@gmail.com> <ebe829ef-342a-4986-975a-62194a793697@gmail.com>
In-Reply-To: <ebe829ef-342a-4986-975a-62194a793697@gmail.com>
From: Rui Salvaterra <rsalvaterra@gmail.com>
Date: Sat, 1 Mar 2025 11:45:37 +0000
X-Gm-Features: AQ5f1JozkqiAi_VC1Mt3fGSs8zJAEVTzmkevwiy1v2JdWPxc5Z1hz6tzslAX5ms
Message-ID: <CALjTZva9+ufCR5+QhJXL+7CHDRJVLQqb4uPwumEO5BqssGKPMw@mail.gmail.com>
Subject: Re: [PATCH] r8169: add support for 16K jumbo frames on RTL8125B
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Heiner,

On Fri, 28 Feb 2025 at 20:22, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> This has been proposed and discussed before. Decision was to not increase
> the max jumbo packet size, as vendor drivers r8125/r8126 also support max=
 9k.

I did a cursory search around the mailing list, but didn't find
anything specific. Maybe I didn't look hard enough. However=E2=80=A6

> And in general it's not clear whether you would gain anything from jumbo =
packets,
> because hw TSO and c'summing aren't supported for jumbo packets.

=E2=80=A6 I actually have numbers to justify it. For my use case, jumbo fra=
mes
make a *huge* difference. I have an Atom 330-based file server, this
CPU is too slow to saturate the link with a MTU of 1500 bytes. The
situation, however, changes dramatically when I use jumbo frames. Case
in point=E2=80=A6


MTU =3D 1500 bytes:

Accepted connection from 192.168.17.20, port 55514
[  5] local 192.168.17.16 port 5201 connected to 192.168.17.20 port 55524
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec   241 MBytes  2.02 Gbits/sec
[  5]   1.00-2.00   sec   242 MBytes  2.03 Gbits/sec
[  5]   2.00-3.00   sec   242 MBytes  2.03 Gbits/sec
[  5]   3.00-4.00   sec   242 MBytes  2.03 Gbits/sec
[  5]   4.00-5.00   sec   242 MBytes  2.03 Gbits/sec
[  5]   5.00-6.00   sec   242 MBytes  2.03 Gbits/sec
[  5]   6.00-7.00   sec   242 MBytes  2.03 Gbits/sec
[  5]   7.00-8.00   sec   242 MBytes  2.03 Gbits/sec
[  5]   8.00-9.00   sec   242 MBytes  2.03 Gbits/sec
[  5]   9.00-10.00  sec   242 MBytes  2.03 Gbits/sec
[  5]  10.00-10.00  sec   128 KBytes  1.27 Gbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-10.00  sec  2.36 GBytes  2.03 Gbits/sec                  recei=
ver


MTU =3D 9000 bytes:

Accepted connection from 192.168.17.20, port 53474
[  5] local 192.168.17.16 port 5201 connected to 192.168.17.20 port 53490
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec   295 MBytes  2.47 Gbits/sec
[  5]   1.00-2.00   sec   295 MBytes  2.47 Gbits/sec
[  5]   2.00-3.00   sec   294 MBytes  2.47 Gbits/sec
[  5]   3.00-4.00   sec   295 MBytes  2.47 Gbits/sec
[  5]   4.00-5.00   sec   294 MBytes  2.47 Gbits/sec
[  5]   5.00-6.00   sec   295 MBytes  2.47 Gbits/sec
[  5]   6.00-7.00   sec   295 MBytes  2.47 Gbits/sec
[  5]   7.00-8.00   sec   295 MBytes  2.47 Gbits/sec
[  5]   8.00-9.00   sec   295 MBytes  2.47 Gbits/sec
[  5]   9.00-10.00  sec   295 MBytes  2.47 Gbits/sec
[  5]  10.00-10.00  sec   384 KBytes  2.38 Gbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-10.00  sec  2.88 GBytes  2.47 Gbits/sec                  recei=
ver


MTU =3D 12000 bytes (with my patch):

Accepted connection from 192.168.17.20, port 59378
[  5] local 192.168.17.16 port 5201 connected to 192.168.17.20 port 59388
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-1.00   sec   296 MBytes  2.48 Gbits/sec
[  5]   1.00-2.00   sec   296 MBytes  2.48 Gbits/sec
[  5]   2.00-3.00   sec   295 MBytes  2.48 Gbits/sec
[  5]   3.00-4.00   sec   296 MBytes  2.48 Gbits/sec
[  5]   4.00-5.00   sec   295 MBytes  2.48 Gbits/sec
[  5]   5.00-6.00   sec   296 MBytes  2.48 Gbits/sec
[  5]   6.00-7.00   sec   295 MBytes  2.48 Gbits/sec
[  5]   7.00-8.00   sec   296 MBytes  2.48 Gbits/sec
[  5]   8.00-9.00   sec   296 MBytes  2.48 Gbits/sec
[  5]   9.00-10.00  sec   294 MBytes  2.47 Gbits/sec
[  5]  10.00-10.00  sec   512 KBytes  2.49 Gbits/sec
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate
[  5]   0.00-10.00  sec  2.89 GBytes  2.48 Gbits/sec                  recei=
ver


This demonstrates that the bottleneck is in the frame processing. With
a larger frame size, the number of checksum calculations is also
lower, for the same amount of payload data, and the CPU is able to
handle them.


Kind regards,

Rui Salvaterra

