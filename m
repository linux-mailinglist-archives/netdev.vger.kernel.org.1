Return-Path: <netdev+bounces-228237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C02DBC56E1
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 16:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597413A69C6
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 14:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7B7287268;
	Wed,  8 Oct 2025 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GR1UvI8Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952861E489
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 14:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759933625; cv=none; b=HwHpx2Be7TTTlhfDsRrOkZ/JoD/A6gSO2C3/5kvMxYjKzDAsVYlgWYiIgpS8xvfkxhrjExRZGnBK2Akjdd5skoLso4JlKiT1LIwY2IsyYk5hTdxiiDAho92wgw4mTFGYC2Y6sNQ9fR7fJFItCJDwDasyyIx/vK6ESOEw+8E2fJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759933625; c=relaxed/simple;
	bh=fJN1bBcYCvfkVWJ+ape/+AaILyURo7rI+Re3epMhWIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nPoAXYN1tL2XhrNPOpxIYEj3CUWLNwykbDEkrPGD2huX8dcsNEHiD7lCPGxZlISsohf5552XDsLFtdjPyarM7HDSh+c7pAkom+iIC63Byyhy5Y3Ifd8JBezbGEQIuEk2ePhUJ060VWcr4RcE03i0ZwJ4eL6T28uA+mw2Zgeo6dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GR1UvI8Q; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4df3fabe9c2so380891cf.1
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 07:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759933622; x=1760538422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HtBKIShAmoXOkmskp+CQr6Z30m7aYa08KHDthGcujY=;
        b=GR1UvI8QQEz4fCCaWR+tdi3BRu7qKBO8UQsLWRHMb2Ba65R2JlEMRHsmocJOdREq8s
         1ZNpIm733UvC0YlECQDcbsXbR9uzQqLGPqws+5XCZKiizg6Dql/cK3tudp0DYVOFOcIt
         Ee0SQaAyv4bicmwkF2zY+CatUupkDDtXs95TmZnFpv2klYuQlGNSpGZPVgyo6qb7rCwF
         dTsB1/McW9rINwabmbTSk27jT/Uo8OkTkk2+5GOzvixdrgD2aloXkpl0lKnotOqzgBsq
         PC8EljGO90j+SEKftkaLY4p+PIVTcQ7O08ODrLycvCc3X+BLYklXsWAFIHyDHrKwMgup
         4W+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759933622; x=1760538422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3HtBKIShAmoXOkmskp+CQr6Z30m7aYa08KHDthGcujY=;
        b=KhCvD7evbQ96A+anQdEOhnyIpAlRJ3kArOEDGtVTyAfzZ8Bg2I1K2AaZynaC/obxa1
         1Y/3UltAPtfrNhMPW/yJQ9rKNLErvsKDqW0ahWAgAfvzbyvfM0fQAdxQcKd3egC2mIC9
         KFGYuyrxdaEdxaW9M32jv6UgWEfz2D9Ic1m0XYEAfYZsRJx8dypevA6Pt9FSsAH3B4/a
         RfifZeBkgzxWkBYStonEhvGbUv0C7Sjv7yg6NIijyZKc3dHY6QziFLDnKP1vpn7BFn4M
         FfkjM/CWvuix8nn7FiruroZMQT1dDW2FcKxVoKrFIOK3eKJBmDrObFAmnbpFmRa7fK8S
         w6mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgBr1yDqqvXPWf61fx/iPIkqAjKKZ3f9XMGGD23jXNCq4ItVlloipgifs0YUSZGDWX8GaV9/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGyGYJi5DU6aOlBIgoMJsVMZKv5Z/391+EnJzmXmR84E8/k9lB
	KcpPmBCfzhnUBD0EM2TlczJUTUGNfudJcXdL6tRuE8dZrft8eSjaojUC816qdm9O8m61PICbFml
	DV9lY4xY/WaelapRI23x6XQg0s2wztFKcuaH9WIWm
X-Gm-Gg: ASbGnctgDWMm/tuzn18+f7UJCJQohzvENa7J/BuZI4FkgkHpn4DeXRer2pHYvoLepTQ
	hc1D5Bc2c2AcxX+BjTS+qkSqlx9Oq6ZvzUjD4ebDx9kfkScpp4spPRuamVhqaM65rGKXvCucyKE
	h79SxT82ai9vsAYPXSscFOALB0QdXGLG3f4yrkD7iKEiW+ag4vkJwa1ltpvnOHzXwshrxl0irWY
	bTytqRMKNu3fUfAxL3afk3X9EVGAVtnCli48q8EaqEfqmErLkwiOQM5+Qn17LC4lyWuv8Sy7fSE
	l1U=
X-Google-Smtp-Source: AGHT+IFjuC52chesM6604EtzzdWEyYkgOJM5R44oiptFOVek1vIWXki4imho9oHNszU3I/buEh9hxEqk6bdzdi4VsAA=
X-Received: by 2002:a05:622a:1111:b0:4b3:1617:e617 with SMTP id
 d75a77b69052e-4e6eabcef17mr7581171cf.11.1759933622007; Wed, 08 Oct 2025
 07:27:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008104612.1824200-1-edumazet@google.com> <20251008104612.1824200-3-edumazet@google.com>
In-Reply-To: <20251008104612.1824200-3-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 8 Oct 2025 10:26:45 -0400
X-Gm-Features: AS18NWCurPPd4PwXxy18x_ELEL1RR47a3eJsWW2eOayaImvCd_6geLIv-1IlS64
Message-ID: <CADVnQymCD-zpw_kN3TUaWZ3afsJUZd5JazGA28s1+siQzpBkpw@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 2/4] net: control skb->ooo_okay from skb_set_owner_w()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 6:46=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> 15 years after Tom Herbert added skb->ooo_okay, only TCP transport
> benefits from it.
>
> We can support other transports directly from skb_set_owner_w().
>
> If no other TX packet for this socket is in a host queue (qdisc, NIC queu=
e)
> there is no risk of self-inflicted reordering, we can set skb->ooo_okay.
>
> This allows netdev_pick_tx() to choose a TX queue based on XPS settings,
> instead of reusing the queue chosen at the time the first packet was sent
> for connected sockets.
>
> Tested:
>   500 concurrent UDP_RR connected UDP flows, host with 32 TX queues, XPS =
setup.
>
>   super_netperf 500 -t UDP_RR -H <host> -l 1000 -- -r 100,100 -Nn &
>
> This patch saves between 10% and 20% of cycles, depending on how
> process scheduler migrates threads among cpus.
>
> Using following bpftrace script, we can see the effect on Qdisc/NIC tx qu=
eues
> being better used (less cache line misses).
>
> bpftrace -e '
> k:__dev_queue_xmit { @start[cpu] =3D nsecs; }
> kr:__dev_queue_xmit {
>  if (@start[cpu]) {
>     $delay =3D nsecs - @start[cpu];
>     delete(@start[cpu]);
>     @__dev_queue_xmit_ns =3D hist($delay);
>  }
> }
> END { clear(@start); }'
>
> Before:
> @__dev_queue_xmit_ns:
> [128, 256)             6 |                                               =
     |
> [256, 512)        116283 |                                               =
     |
> [512, 1K)        1888205 |@@@@@@@@@@@                                    =
     |
> [1K, 2K)         8106167 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@    |
> [2K, 4K)         8699293 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@|
> [4K, 8K)         2600676 |@@@@@@@@@@@@@@@                                =
     |
> [8K, 16K)         721688 |@@@@                                           =
     |
> [16K, 32K)        122995 |                                               =
     |
> [32K, 64K)         10639 |                                               =
     |
> [64K, 128K)          119 |                                               =
     |
> [128K, 256K)           1 |                                               =
     |
>
> After:
> @__dev_queue_xmit_ns:
> [128, 256)             3 |                                               =
     |
> [256, 512)        651112 |@@                                             =
     |
> [512, 1K)        8109938 |@@@@@@@@@@@@@@@@@@@@@@@@@@                     =
     |
> [1K, 2K)        16081031 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@|
> [2K, 4K)         2411692 |@@@@@@@                                        =
     |
> [4K, 8K)           98994 |                                               =
     |
> [8K, 16K)           1536 |                                               =
     |
> [16K, 32K)           587 |                                               =
     |
> [32K, 64K)             2 |                                               =
     |
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Nice! Thanks!

neal

