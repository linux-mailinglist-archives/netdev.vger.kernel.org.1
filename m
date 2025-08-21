Return-Path: <netdev+bounces-215519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B90B2EEFB
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 09:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE6A71BA0153
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 07:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A2F13B58B;
	Thu, 21 Aug 2025 07:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zJ3OzwZL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E130D36CE1B
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 07:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755759634; cv=none; b=KOXK9mYP9VrfcJLt//dSgg+wLQ261zCE9RCwgcGb9xE0fgYDDmcCywPBLKjfZXBwpyGZ6pIC/9Oe2oyHNPrZThih/lLwUFBslAXZc09qjqpzN7lwafo0kbEFjqYyateLQ8tqqKXyzu4QvMm5ZM/yi6qZGKZGP8XGf5DL+XURB00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755759634; c=relaxed/simple;
	bh=eT8lYjwPuDwqFIiR/6cWKANlHuTQL2UJO7UTGEwDiL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r5xVD54pQDZxIIZSrhLVnYM2RGFaO9/jg01Quh4JMQoYaPTonAHpGROHApTpGlm2PzV7W2zcNbiw2HgAZUihEGvgvZj1cBQ9PBSBDl3M73NREWLXIf4Ad4LcvGe34reT4OiDLCLzIPCeLNzxzm0ZFsxAS+a5fnp00spW3VB6El8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zJ3OzwZL; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b134a96ea9so6108281cf.1
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 00:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755759632; x=1756364432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eT8lYjwPuDwqFIiR/6cWKANlHuTQL2UJO7UTGEwDiL0=;
        b=zJ3OzwZL4XeZjjM8RWlZNBBj7oTOp2Ri0VZ4kgRE+dNxVC7hcXCqdEatyddgUHPDUB
         HfIGKacIk5KnLtwIeK7MZyWeXhe8eSc95kg1/5C0zN5BMDxGnFQQLKkAV+ybJBJWMsd3
         /bJdyWzUdKaiCrpxQCA5/eeNqcATHu6dVVVGO2IX+EvEo1tPRlO/7ca/wdMPeUoFcDHI
         iV3aGCNzo8iJuX3oyiwsz1/mCUv+wY1sanKWaEHNWyxo4BLnAr2ZSn7pQRMq+rUQyj5r
         6C6eMPQDbMXL5P8HwubRlkVbYRikzzItDnwociKuKkaH5vqQZgdhzbdq74VmU104niYs
         /Tbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755759632; x=1756364432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eT8lYjwPuDwqFIiR/6cWKANlHuTQL2UJO7UTGEwDiL0=;
        b=NwzkU/a4vmbwKSWkWNhExJ2qX0xG0Ac1XXXOt2OqND+WAMMfRbzY60s6u+Cb91yCQn
         glBvlJ99K/6+Ys/ON5MdoqWyJvYvFilzQ/rzctI9BOpnPfeczxDtzChhCZjd9FqSxJ1i
         7RBQB1b8GIUMvezFuQPIYH0p30eE2nt9DFpJc764jDpoLSPaSHBT62eDL/56iX+fxKyc
         XCx4nxJlglg8gAp5P8DfIfDwMksumVpi3JYhf/2QdAApyupEpt1/Me+qlX+tL1PRZ/na
         1EOr0437iV3xlxxL5g/xs1BFPDPEATfPm9evuLx4tXE5r0f96HjG26RzYLMyCMgpARis
         D2zg==
X-Forwarded-Encrypted: i=1; AJvYcCW+nrNefYfGEr2hMvGFcxAGfewDRJzixFuJXQzOqw24c+v7ofIDezOdwPq3fb+U3XE4NXCyN1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIyub4M9lBZnXn22ESSiiDoi83Ctwj2MlLfe1KNj4hbXgVfsOL
	LCW8+XoCCm3NOTq7M+1vBNY4ov+4RAY7kYMdqJeL47vb03qCbhoZW0tuhjHCYlBs21hPQpSPLne
	1fnquTMDCLlgzpxHrEgznhte2a0S9vNpJJ1BxukMc
X-Gm-Gg: ASbGnctHnjGtdjAPkK/fhTUqQqR1uk3o6SSIrFmjHevLaWFMC6eH9uTFpoarxdBLisq
	QbcEwrrRfZlZjGq0tT18H9lrC2Ck5EQhVNaM4trjycuYy84x1FpKoHj9tkwUR36flsx9zIEzZ2x
	QhRzYL2RWN4DT1mBkEWvvr964H1JE46zY1fftze6tjCdRDHVObxRuQDJEwQzm5eR0VIrox/ktec
	cG7aF3hTmc4kkIIpYZ8IiE28Q==
X-Google-Smtp-Source: AGHT+IGpLHZ8FPFiWNWZiXL7nkZkRqIOhY79ocUAENhsR48qZlX9MIpbLzCYNDZd3+HeYJgPQ3Fv0rCGlykHFTdF64k=
X-Received: by 2002:ac8:5d4f:0:b0:4b0:eb79:931d with SMTP id
 d75a77b69052e-4b29fa0992dmr13871061cf.2.1755759631227; Thu, 21 Aug 2025
 00:00:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821061540.2876953-1-kuniyu@google.com> <20250821061540.2876953-5-kuniyu@google.com>
In-Reply-To: <20250821061540.2876953-5-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Aug 2025 00:00:20 -0700
X-Gm-Features: Ac12FXwR6Hp86NUpQ6o6-CfriqNR0_HZgzz-s6exJUmjchmrTO4a30Vwgcc5PWw
Message-ID: <CANn89i+Wq+XiAK_HfgjO=gOesaXJvxT_FgAjstSCfAqzjwGrug@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 4/7] tcp: Remove hashinfo test for inet6?_lookup_run_sk_lookup().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 11:16=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:

Please fix, and add

Reviewed-by: Eric Dumazet <edumazet@google.com>

>
> Commit 6c886db2e78c ("net: remove duplicate sk_lookup helpers")
> started to check if hashinfo =3D=3D net->ipv4.tcp_death_row.hashinfo
> in __inet_lookup_listener() and inet6_lookup_listener() and
> stopped invoking BPF sk_lookup prog for DCCP.
>
> DCCP has gone and the condition is always true.
>
> Let's remove the hashinfo test.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---

