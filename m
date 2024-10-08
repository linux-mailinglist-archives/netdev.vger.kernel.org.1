Return-Path: <netdev+bounces-133031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104A39944D6
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 11:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB60281330
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 09:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECBD15B12F;
	Tue,  8 Oct 2024 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eK2HlAzD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E026942AB1
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 09:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381276; cv=none; b=bJH0Y1AKOihIiDEv9GqAp56xPDGfmOGPkdUPfqeNHCmaA033Ix8xH5T/1qV+d6eFBFKMbINowyjfpqvn9/a53n7Eyj6v/li+sW/lmpzB84mtPD/NOu1FnGrbHg1MhEUY48cRgx9gAXWnBwQKHg7+/PgaF1YnGCe7qCy8amk8W3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381276; c=relaxed/simple;
	bh=rP3lq2lC2auj3AgMgQLGsKD6mc5uIrDwpFl+MpKOr9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXh8Ov3RP8uHLJ2w65mDh5Z0yIhABv4FG0uq7XeRFaIhPC6QbYSXmnWsGrvV7XWyhsf5D8EQi4ipakxRYoqNlAiRGrVWhMVjRqFJ3rDrSilJGV8wUNpy5rLgH0gViJEhd9lfziUPiQIsGLAUiVmhu4lucQLq1EzV64A8+3LO2FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eK2HlAzD; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c5b9bf9d8bso3967403a12.1
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 02:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728381273; x=1728986073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6XIMLwhQrKyZBAfEpAT8GFwc8+6i8Pmfz25y2Peo0I=;
        b=eK2HlAzDa2phgXD5Bhzo1ftDJEigUI5Lk+3K4XNlh+Zd+2hYQ4ls3OhhcJQqEqfVw8
         ae1EpnCyUiFgfQhJTGXrNDENOzbvQKp7qnoM0XOjrjgEqsDkJ3a96Q3fqNFVgYMjK+X2
         YwtpxlplbKK9/8kVzdTKC8nkfX/HKUAF1w6DhGQOzpc0TbKDErFba526G04pjSe78h8t
         u3zdDGPzcFszMYnlanig7UREwP6gMp7KpBwZ5KPbMG1pRF5UnsVb6qQ+Qou7O+Mk4Zif
         Op1JQX2aE/T4uM9uHgAM6heGZOxrfSITWcUOWvbv9tIdl8Cjf7LmGbDdHMlPvxRxqXpP
         ombA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728381273; x=1728986073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6XIMLwhQrKyZBAfEpAT8GFwc8+6i8Pmfz25y2Peo0I=;
        b=OCgRcqOMxnQ2MCb/7s0aB3Ov0JTYoxnx08ULBt7FEDt1IsFf4yGXYZyV3q/lM1Qo3Y
         eeyUO+NhGrcnxbV9OS1Hc/pn+v93nNLWUwzqgKBJYjHD6JC8ubpSK45gxopMDcTOwQIe
         ySINNbfRPxcmH9xHNqWeIjwRz9PHj3qpAxP+RzczWu9PvSg2BDU2eXGuklXJAwjDmp4c
         bvBkwRHmrmwne9F/po9Fece8qHqR0yOiPcL4mjHO4KyQ3JCWo7ikmvuX+qAnFAstcq8N
         xjTMzMEAyH332iDawDK9wLQy/0lSQ+nBcunK6a8HqcbElekPwrodOPCn3QliF4dI7V+N
         Jl6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWhtChO9Ayf86VmYxirSSP4fXwftubDCCGY/IxVAFOVCpDcTpjLQp4L2O0x7fq5WY1img7KM4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt/0irWhUE94NnAWLHTv6H3E288gys9LncYvkZf5Cgi+qi48Z5
	VFLD4JvbaB3s0+UgjMYhE48E3i1F7QmX+nCdMC6ur4zvoOnjvNeZozaEunFGkfk9wWaPtLvqdPv
	LFG/aq+Zr0L3W9hLvSqm/JjaM//MA6umc3ATn
X-Google-Smtp-Source: AGHT+IFWVJa2J/41N2MbQNkksw/7bmKQ+X/VWsOsUqzvQh9Ckmb7a4bnS93ITLaYleeFTdp6lZyd5G6GcCgLuhk3qyg=
X-Received: by 2002:a05:6402:2791:b0:5c5:b9bb:c341 with SMTP id
 4fb4d7f45d1cf-5c8d2e9f8bdmr23483582a12.26.1728381272852; Tue, 08 Oct 2024
 02:54:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007162610.7d9482dc@kernel.org> <20241007235251.84189-1-kuniyu@amazon.com>
In-Reply-To: <20241007235251.84189-1-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 8 Oct 2024 11:54:21 +0200
Message-ID: <CANn89iKWPDs8UXTu8NU+18DM4XE4wHz=CKeSY2AMoxB7tvLyKw@mail.gmail.com>
Subject: Re: [PATCH v1 net] tcp/dccp: Don't use timer_pending() in reqsk_queue_unlink().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: kuba@kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	kuni1840@gmail.com, martin.lau@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 1:53=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Mon, 7 Oct 2024 16:26:10 -0700
> > On Mon, 7 Oct 2024 07:15:57 -0700 Kuniyuki Iwashima wrote:
> > > Martin KaFai Lau reported use-after-free [0] in reqsk_timer_handler()=
.
> > >
> > >   """
> > >   We are seeing a use-after-free from a bpf prog attached to
> > >   trace_tcp_retransmit_synack. The program passes the req->sk to the
> > >   bpf_sk_storage_get_tracing kernel helper which does check for null
> > >   before using it.
> > >   """
> >
> > I think this crashes a bunch of selftests, example:
> >
> > https://netdev-3.bots.linux.dev/vmksft-nf-dbg/results/805581/8-nft-queu=
e-sh/stderr
>
> Oops, sorry, I copy-and-pasted __inet_csk_reqsk_queue_drop()
> for different reqsk.  I'll squash the diff below.
>
> ---8<---
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index 36f03d51356e..433c80dc57d5 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -1188,7 +1190,7 @@ static void reqsk_timer_handler(struct timer_list *=
t)
>         }
>
>  drop:
> -       __inet_csk_reqsk_queue_drop(sk_listener, nreq, true);
> +       __inet_csk_reqsk_queue_drop(sk_listener, oreq, true);
>         reqsk_put(req);
>  }
>
> ---8<---
>
> Thanks!

Just to clarify. In the old times rsk_timer was pinned, right ?

83fccfc3940c4 ("inet: fix potential deadlock in reqsk_queue_unlink()")
was fine I think.

So the bug was added recently ?

Can we give a precise Fixes: tag ?

Thank you.

