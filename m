Return-Path: <netdev+bounces-111018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7332A92F440
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 05:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328771F23CCB
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 03:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F121749A;
	Fri, 12 Jul 2024 03:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pzVNA91m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35EE635
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 03:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720753344; cv=none; b=qVedPoYT0UZJIokgTbMgR35PDem7jtdYLVBYLlSK6NSKDgpFLd/41bFCm9MbXBa4WjasyjQ2f8C/6ItkMO7/t22fB9Ix4CJoGLxknkeHtiIVKElzczNPuYhVPNeLWogxlW6Ly8z0wbnRxu0ueHNIhhUagGgORXqJNKcaS9aAqoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720753344; c=relaxed/simple;
	bh=aCx0xPZbom50RjqpqNzBRZUay0qhgDN3jLQPgr4Tz/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l7kMy/eEfvOQNMW2nxJNkUx9EljlS+QWOOiUhzsWZkwtrcT/vtu41o+nrkYlcZSedYO4Rk1DHOXC2ndCB2V+XkyurAZnPvHNlsjicyx0J9nSONKKx7lY51orpowNShWVS4egX1WHrVUNN+IrZPpsdSiQ7GRM9f6fI38Z/VEWkYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pzVNA91m; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a77e7420697so211599666b.1
        for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 20:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720753340; x=1721358140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4lFs+zjy6MsryyunPsWDlMFHdv/rOIFc2xs8rscZTM=;
        b=pzVNA91mNSvfPOqgSFqNGJ0elLPbM3db2sBGLC+723C2Uxbn6V1SLnsPdN5HZxtSZ9
         akcecEHB1O0kK7kZF/p6BRJFNCRPOPOF5QugtyhjdI/rjtgu7KftHSS5R0lqRpohbV3E
         ScFN1ZTjtFMoM+oTvRkSFVAkDVYrFpcVmlOvOeTOb7TcY/ZRXQ5Em+oxHDrv6/1mfOC1
         PREeJnWx6H9kvQCqjoQUfaq7JmucU4BRX9EGRtVrbaIl4dPdqjEPyFpRWqiF3r2MFFP6
         IU9TKmhNq6K+5hcQgyaW90UNt2pFgZrRhkzYkTNaQO3dr2vMmgebrv/llvKJZqm4Nq4C
         QGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720753340; x=1721358140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4lFs+zjy6MsryyunPsWDlMFHdv/rOIFc2xs8rscZTM=;
        b=Nv6cKBVCrxWw8bKH69DwJ1irJaeB6W14XYTTZ+M6OSka2lhgCy2HkHxcamnyamlMN2
         3TIcnaFRJUkoHGe9NKkE3aHBRNTeKuIyMlXlwrEEIYSN1+9QAOUVElo1xIDr9MneOVDy
         DXzQOU/n8eD+ZkYmRHZz1eM37J3OyLEL1AL+kgXPvLD7f5FtuODbnjkNneQm0aS5H/Yj
         I74sQB+1kZJGjtgr9Ps3BHKF0a3DTOOfdQ5m7vUIf+xMNLdYzoFmrCbYA/5R6fqr2lcb
         i+RRwG3nvlSM9iMC2RTg7cIejA+gZubrkNTOjTR9/IrytLiuIm31Gi13ww/18bXtGFpI
         gO0w==
X-Forwarded-Encrypted: i=1; AJvYcCX0ZjvgbCAf2OEftvB3+63p6wSF5iQib6ib5qK54EqK8DkGj9noBb67MQJ42aWTvRbF3djW6HXwZHrZ+CiQ7n+8H7OcFYSU
X-Gm-Message-State: AOJu0YzcvcV/44gBCIBdClnKonOWbgbqBnuu6RsDJW5zPPJQLRhXB8m5
	qm8/kQm0c8xXYu++6bpqxVJSTBy2+DTcOgmrF6PMJr4HWX1K9Ov7sDg4YUZ49QvofzI61n7Gwa4
	JgAEg0ioHvcmEiRBHM4tP3jaTTF4zfmnhLsg7
X-Google-Smtp-Source: AGHT+IFf0mgXWvHFnLD310cYRvTOeoTLif8rxMS58idXqvz79P5G9MDHRe7XevDLqrMj6GA8QY33YruHZgaTZ3cXUyE=
X-Received: by 2002:a17:906:30d2:b0:a77:d7f1:42ea with SMTP id
 a640c23a62f3a-a780b70541fmr655068666b.45.1720753340000; Thu, 11 Jul 2024
 20:02:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710111654.4085575-1-yumike@google.com> <20240711095208.GN6668@unreal>
 <Zo+vx4wS49TNX4fa@gauss3.secunet.de>
In-Reply-To: <Zo+vx4wS49TNX4fa@gauss3.secunet.de>
From: Mike Yu <yumike@google.com>
Date: Fri, 12 Jul 2024 11:02:03 +0800
Message-ID: <CAHktDpMtHArc1qa+-_YgkgpTT1NBQ6s8OhQP1=d89ma0h6GpiQ@mail.gmail.com>
Subject: Re: [PATCH ipsec v3 0/4] Support IPsec crypto offload for IPv6 ESP
 and IPv4 UDP-encapsulated ESP data paths
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org, stanleyjhu@google.com, 
	martinwu@google.com, chiachangwang@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sure. The patch series were already based on ipsec-next.
Sent v4 that targets ipsec-next tree.

Mike

Mike


On Thu, Jul 11, 2024 at 6:11=E2=80=AFPM Steffen Klassert
<steffen.klassert@secunet.com> wrote:
>
> On Thu, Jul 11, 2024 at 12:52:08PM +0300, Leon Romanovsky wrote:
> > On Wed, Jul 10, 2024 at 07:16:50PM +0800, Mike Yu wrote:
> > >
> > > Mike Yu (4):
> > >   xfrm: Support crypto offload for inbound IPv6 ESP packets not in GR=
O
> > >     path
> > >   xfrm: Allow UDP encapsulation in crypto offload control path
> > >   xfrm: Support crypto offload for inbound IPv4 UDP-encapsulated ESP
> > >     packet
> > >   xfrm: Support crypto offload for outbound IPv4 UDP-encapsulated ESP
> > >     packet
> > >
> > >  net/ipv4/esp4.c         |  8 +++++++-
> > >  net/ipv4/esp4_offload.c | 17 ++++++++++++++++-
> > >  net/xfrm/xfrm_device.c  |  6 +++---
> > >  net/xfrm/xfrm_input.c   |  3 ++-
> > >  net/xfrm/xfrm_policy.c  |  5 ++++-
> > >  5 files changed, 32 insertions(+), 7 deletions(-)
> >
> > Steffen,
> >
> > If it helps, we tested v2 version and it didn't break anything for us :=
).
> > But we didn't test this specific functionality.
> >
> > Thanks
>
> Thanks for testing it Leon!
>
> This is a new feature, so I don't want to apply it to the ipsec
> tree. Mike, can you rebase on top of ipsec-next instead?
>
> Thanks!

