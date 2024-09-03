Return-Path: <netdev+bounces-124537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E689B969E6B
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1FBA2840BC
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 12:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615A613C9B8;
	Tue,  3 Sep 2024 12:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xF/qSqYD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6E01CA6B5
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 12:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725368055; cv=none; b=jnNxi3biWe9tdOBHahGjNUvz81zi/K+3+tnpaiTwO2ArfeDmoML/HSo4SLDFNHArsV8QISSjQUJdj7C4NY6ixFWaaXsDcP6p2ECMyaB8FRcYJ/23oaak3iegpUYXTDDTV4k3Wc31/w5t2u5pQPBbGVfyDwvqK2vIiiqxlCU6+Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725368055; c=relaxed/simple;
	bh=1sQBXbrxFIepozBp6rnoQlrnGCfeK/Fpe+8jGrr1poA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IbE6V0un77TMwSi1tZK85u+jmWUlxWuMZ1hTL38OE5M9TZgK7wDPEdEMia5nCsw3Pc7z/oN0vG4boyruzinV+p5he7QZZDxan8NHryh/CPdO2NNkBZ6d72yjW3A7JWvufpMbAdy8X9X0hXj9qfCKg7Oky+4LHw8Xl01g30K41W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xF/qSqYD; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c255e3c327so2539486a12.1
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 05:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725368052; x=1725972852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EDBDFztnJ7QXRoMHA2gILDtQaFW+5NDgEd/OR5D7qQ=;
        b=xF/qSqYD5OArC0KIDCAZXJnbE/Zpk65OIwi7S7bYHHRUQkJrxJ8cwcgzsKTRylhZoP
         LQeJ8qxYpCZl9gha3ygopcLBYApnrEvb9JEP8v6Nn1RirvQT389Ghs5Yrfmklxeg/sgc
         VAeXbgqEtHMk9JABwMzQ3s1htl00LhvSaHlKIMiOnyFIb9oLubvTR4cn9GBLzThne9xH
         TC534VEg+gNe0k/jdDIU6kgp9K+Gsx4SacrE7i/bnuNwV/LeT7erdUqiANCPMVIPMKtu
         7cuGNkaONUG4yTFD6LA1geRh6VRhG698PHP5NF2CdcznKiapEND09UvD6KiTC75SsAZH
         Zrhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725368052; x=1725972852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4EDBDFztnJ7QXRoMHA2gILDtQaFW+5NDgEd/OR5D7qQ=;
        b=ibglZfvmNhFHNWVigy9EwUJAFW9tLA68Fu/KfAAFzsHmR8ZizkcYeObbOW5SbO17ZA
         q7a5ItBHtYX6ka1a0Xi1VDLlaxUqVEIcTmlvomyys0nutOeT7AQ4NC4i0/R4VntQSPG9
         /vZPqzTXYLNjYfCYx+liKoigz5fDSbW0sk8NIDhtpyUNboamsmmNCHAJWlwFdk4rq30B
         VMEg1hD2Nlh3I2VPO5S4Je1IElujIqu+AZMYTudia5FtOKdaJ01AJR/+KNx8Tfk3honx
         L0DmQTjVwgHH1ynA/Uuaf53QgBohq0sACGw8nQy2p67jAltvyov4pBATuSuxB+kZZf52
         S+Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVVP0ykXOSvkgZ3yvh2Ss0mPh2w+vJ1ru9YLyR/e5IUu22GOP4+dyBUpK4QayvLvqPVsAGW/1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIQkzSKDqXSWuSP+FbY9fBVrkVeEOjU2gkxuqiMl0DXW5wYsFv
	wM5ZgKQimwYWJRmx66g3r9zib+0xWy9hTyCgJml7leSXXCMxNlJ464bXENx/2HYIIQVlpOv7Rwi
	uTSd9UbfUinkTAgZz3G9Ik1hUiFqoiejlIg7x
X-Google-Smtp-Source: AGHT+IGMhRSDzER85v0Usuyk6HaZqJzCZmoVnPlKt+9m2DPGiVR7zgy1X34wbIdjxq2rxCpi5bJ1oQh3i/P43zRUBXw=
X-Received: by 2002:a17:907:3e9c:b0:a86:a0ec:331d with SMTP id
 a640c23a62f3a-a89fadc0cfdmr506031266b.18.1725368051226; Tue, 03 Sep 2024
 05:54:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024072924-CVE-2024-41041-ae0c@gregkh> <0ab22253fec2b0e65a95a22ceff799f39a2eaa0a.camel@oracle.com>
 <2024090305-starfish-hardship-dadc@gregkh>
In-Reply-To: <2024090305-starfish-hardship-dadc@gregkh>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 3 Sep 2024 14:53:57 +0200
Message-ID: <CANn89iK5UMzkVaw2ed_WrOFZ4c=kSpGkKens2B-_cLhqk41yCg@mail.gmail.com>
Subject: Re: CVE-2024-41041: udp: Set SOCK_RCU_FREE earlier in udp_lib_get_port().
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: Siddh Raman Pant <siddh.raman.pant@oracle.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 2:07=E2=80=AFPM gregkh@linuxfoundation.org
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Sep 03, 2024 at 11:56:17AM +0000, Siddh Raman Pant wrote:
> > On Mon, 29 Jul 2024 16:32:36 +0200, Greg Kroah-Hartman wrote:
> > > In the Linux kernel, the following vulnerability has been resolved:
> > >
> > > udp: Set SOCK_RCU_FREE earlier in udp_lib_get_port().
> > >
> > > [...]
> > >
> > > We had the same bug in TCP and fixed it in commit 871019b22d1b ("net:
> > > set SOCK_RCU_FREE before inserting socket into hashtable").
> > >
> > > Let's apply the same fix for UDP.
> > >
> > > [...]
> > >
> > > The Linux kernel CVE team has assigned CVE-2024-41041 to this issue.
> > >
> > >
> > > Affected and fixed versions
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > >
> > >     Issue introduced in 4.20 with commit 6acc9b432e67 and fixed in 5.=
4.280 with commit 7a67c4e47626
> > >     Issue introduced in 4.20 with commit 6acc9b432e67 and fixed in 5.=
10.222 with commit 9f965684c57c
> >
> > These versions don't have the TCP fix backported. Please do so.
>
> What fix backported exactly to where?  Please be more specific.  Better
> yet, please provide working, and tested, backports.


commit 871019b22d1bcc9fab2d1feba1b9a564acbb6e99
Author: Stanislav Fomichev <sdf@fomichev.me>
Date:   Wed Nov 8 13:13:25 2023 -0800

    net: set SOCK_RCU_FREE before inserting socket into hashtable
...
    Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")

It seems 871019b22d1bcc9fab2d1feba1b9a564acbb6e99 has not been pushed
to 5.10 or 5.4 lts

Stanislav mentioned a WARN_ONCE() being hit, I presume we could push
the patch to 5.10 and 5.4.

I guess this was skipped because of a merge conflict.

