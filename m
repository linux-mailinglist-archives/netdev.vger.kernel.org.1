Return-Path: <netdev+bounces-112644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049F893A4EC
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 19:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA2452836D9
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 17:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328FF1581FF;
	Tue, 23 Jul 2024 17:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AdnuBxZ8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87024158207
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 17:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721755615; cv=none; b=ajZZNLJZePABFR5tz9ZYOc+61rT9rK265BtDGuh1fuoGUpc7WoTr54wjqhF4EbutArJCcYZSfnMK9CxCu3U3CBxcHRGI8V+UCRdFdo0LoYRbghaFnPRFwuHvzTwcZEOpGmWGb8UaSwtQ9kb3XpXWBLtMsn7/4NxQ/nvag6SrCwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721755615; c=relaxed/simple;
	bh=Y7piUmchrBxF7BjjALNLAV6x5CV8s099z8LNa5F0clc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CkQeXD87c3QeU6wEQSRQaAfsg93aE++27EAPre1b3fu1gPVeeLDwjpUnFK1TujDUF5FF/PGP2vFZyvvxeS/H4IL2eAvB0UJTrPJ+Hk4wtYiQa3NRHZuz/eD7rKkhXM9leF1/CFV9LYk3pwcZIF1Tb5j5IzFV7fG1/i12655Rsnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AdnuBxZ8; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a869e3e9dfso1263a12.0
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 10:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721755612; x=1722360412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AO9JE1mj1Yo0mDWeNJpYtjgiDQqq1GwG91dRnHzCAsE=;
        b=AdnuBxZ8yKb8IVy+h2NY1jXs4wllqsXy3VWiv2ANJZ2qRlxOmT36iMDWRjiVrpuA32
         E3szNT/OtrItmogFHNvXeH/cSelrxiBGCu7Xmyxj8t5aUMHedtWEzNGoT8fplyQkpuwo
         CAioWw96OkdPSSxfh2Hhd2vlVSPCyISWM9NoxVmTLYgOMVAzPDs21KrOnabio4ZEZ6e5
         zXIhoPRrGxppBQ/BSMKUByWiHwjIGF1Q1HIJgGamz3IJX57zhupIuecVgTHBTf7LpF8A
         lFmHDCUxOuLIvGrqVEC7vpoJRov/aI2xGusB5u2IpABJAu5PmZg2+oYQWy1D0O3RIJpi
         xIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721755612; x=1722360412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AO9JE1mj1Yo0mDWeNJpYtjgiDQqq1GwG91dRnHzCAsE=;
        b=kyELroSMWawMQCxP0AAxMtT9D3AOa6ExHKwyJb7P19Y3Yb+c4SW3q1++ETfnd1hVoD
         /5pQX1O3K/kpcmnLfLuIpk54kh0BsuNlsjanj+H1k8Ayy/QK4Qrkzp55IkEvFtVMoIJw
         HFQALpyFeOr+EX4HeS4V/E0tTBQoH9N5iySLB8uaSN7tsvslU0vPGvN5CvFxPkWUZh9a
         WI2LgcbFxqqRwU7CgD73Swt1z4F7iSrq2Zjx0m1scve2Ltj2Wo9e/soquZ5MI44e3G80
         5I1R2zC7ZgYYLYQZ17Gj5uF5fZHvprOcP6tn1tFMOvjF4WwzlO0F2QdPd2MMCbVLVyun
         9AnA==
X-Forwarded-Encrypted: i=1; AJvYcCXYozHeHYVwjzWJpHiRU2OAT/mD/AvV3WXPm+07U3xfIMzCTM/smIeKLxUjocrkbWmHQn4T34DvNMsTKdpsdZUaeyF55rIc
X-Gm-Message-State: AOJu0YwjL3Fh72Psqni0FQnUJ9OObmnKcWmd0Qma9Nl0IjfFNtVuxdzT
	O881CifRQwNBz06Yuw8jxgwvRXC2n2Nq7jHoTY/GHDojigCm/YNRtD2/yEQJXnv3TvLRJ+T9THV
	eR4Orni+XHk2Vp55XxtTpIiHEWbN5EXu65g4a
X-Google-Smtp-Source: AGHT+IGCSzQhk0PHRa1eNhpR8/ewWiODcgMGXGszhBhuSuFKDFl94+1xC/41r8h1gNLKQN93ZxT8krx0PZKQjShAWLk=
X-Received: by 2002:a05:6402:2681:b0:5a1:4658:cb98 with SMTP id
 4fb4d7f45d1cf-5aac71248ddmr38703a12.0.1721755611484; Tue, 23 Jul 2024
 10:26:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8b06dd4ec057d912ca3947bacf15529272dea796.1721749627.git.petrm@nvidia.com>
 <CANn89iJQB4Po=J32rg10CNE+hrGqGZWfdWqKPdY6FK0UgQpxXg@mail.gmail.com>
In-Reply-To: <CANn89iJQB4Po=J32rg10CNE+hrGqGZWfdWqKPdY6FK0UgQpxXg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Jul 2024 19:26:40 +0200
Message-ID: <CANn89iLvqJXmCktm=8WoSuSWOAVHe35fy+WHet-U+psMW2gAoQ@mail.gmail.com>
Subject: Re: [PATCH net] net: nexthop: Initialize all fields in dumped nexthops
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	David Ahern <dsahern@kernel.org>, mlxsw@nvidia.com, Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 6:50=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Jul 23, 2024 at 6:05=E2=80=AFPM Petr Machata <petrm@nvidia.com> w=
rote:
> >
> > struct nexthop_grp contains two reserved fields that are not initialize=
d by
> > nla_put_nh_group(), and carry garbage. This can be observed e.g. with
> > strace (edited for clarity):
> >
> >     # ip nexthop add id 1 dev lo
> >     # ip nexthop add id 101 group 1
> >     # strace -e recvmsg ip nexthop get id 101
> >     ...
> >     recvmsg(... [{nla_len=3D12, nla_type=3DNHA_GROUP},
> >                  [{id=3D1, weight=3D0, resvd1=3D0x69, resvd2=3D0x67}]] =
...) =3D 52
> >
> > The fields are reserved and therefore not currently used. But as they a=
re, they
> > leak kernel memory, and the fact they are not just zero complicates rep=
urposing
> > of the fields for new ends. Initialize the full structure.
> >
> > Fixes: 430a049190de ("nexthop: Add support for nexthop groups")
> > Signed-off-by: Petr Machata <petrm@nvidia.com>
> > Reviewed-by: Ido Schimmel <idosch@nvidia.com>
>
> Interesting... not sure why syzbot did not catch this one.
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Hmmm... Do we have the guarantee that the compiler initializes padding ?

AFAIK, padding at the end of the structure is not initialized.

