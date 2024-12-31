Return-Path: <netdev+bounces-154640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7230E9FF072
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 17:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798981882BFA
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 16:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFAB13FD72;
	Tue, 31 Dec 2024 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QiBCM6ZG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504736F30F
	for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735660863; cv=none; b=nA7d7nFOpvoI5pNIqL1YlUsyuP7wudI1XnfYbuF3EI/Z0HnwYoCIKQpAiIzK2yP7E7rUEhuase71rSvv7vLNt0EqYAw+ukgAqzMZVoCRXnt4bWl5c4OMILQnAxZG1MWr/dxMVrWNIcJB+Mgoup9Pn2NkdaVQArA6qr15Q6d6nkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735660863; c=relaxed/simple;
	bh=BPdDURvxPGIfVJ/wkqA6GC+9iLpcZpSTi3FZo3hWcEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=meqJAREWwXfXFP/Zv1pyO+zbfaKkVus+XwEvKXUccEDutiGNfY/BwW8ZDhc5YONZ+UMVY260M8fVaxWEJVXamCYtk1v/qdfBDKRnfQuAtWHYwIRTHQHoJRV+4mDAIZ8H9TFmlASByymJ4a3luqxiT+ZSAA3W1W43g+hK3hE7xm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QiBCM6ZG; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3e9f60bf4so17307571a12.3
        for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 08:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735660860; x=1736265660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEKkU9DgznGH5SC9U2+I52ImEFm0gpWt/zxcGyuu6xM=;
        b=QiBCM6ZGoUb8CWpHuqfmHns0TkYdkD//ae/glnEUkySvRjBb04v268qT64pUcke+7i
         h1SMjwczFlGUVt8CnAuqkMlfbgjvvrzrxLB3yI0iu6h6xdbNKrlqLDsODDm8z/GXYgaN
         gflWtTZbHXZ+8Uhi7DuoOnNuj+fqbv5k3Y/7Xt8yVScyvBmnt006Vyekd7jSIFaFRUjq
         o0CILsF/GXiHM5Kk4+elGXNA/NF8Jp2uGdzWJHuVFzOC4WE6H7ihB1N4n9RhCwQKJ88j
         vpDEhDtTKnEo5iUYz5JQ/ouVF4U8SXrctYHeYmZ1R6u/rLgUjVJ43NRlc4oxFqqlg9S+
         RdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735660860; x=1736265660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEKkU9DgznGH5SC9U2+I52ImEFm0gpWt/zxcGyuu6xM=;
        b=AFPrLxUnR3dUiWbY/sihNNrKcVJuVRysfBU6/pvm2AGsR/WWkpsoQ1fwApzn+34DRI
         kmZ6170DJB5fHsrCcE6rBNUY7HHvrD3KOcfZ142GO/AzYTtv6W8jHMo/1uSIJ7EsSuy3
         BcPshUzB3JgAB2VJDE+9ymXzzpXEFncALpaSIK2aUY4XGqzaovgLaff/sSlPelL76AgT
         hwuVmISVW5CShuYvAbY0xSdx/S47989KU6BomZsne/4nxdFfqxTVDPlhyGwnhqKPhRkh
         UUBKKDSN0InwDFB+ezto8kF2/o/rkNyTdfHjGYSeMeQ8lMjY0feDVkFdihBgyUxIGKAr
         ATcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnh81ODwTE+XhARIU9qe8uDyWKvLLzUv1J5jlPKxBruU4/CJC6fIXYnWMALOFFGOKkVN2RU9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgk42LqEYLiJ7GlfM1IR1TYMQ6I5QWCnEb/q7vPGH/rBh9XZO4
	+UFPZHTGHDaxT6irI9s9mo8e3zT6RtxDplwMUQMxTHuWMAcO8sLF8I0l0Pmqrn8wmXUyhzReynt
	hLVd1UO/SnUyLT/tdAI6WNTddoFoG73Lplli7
X-Gm-Gg: ASbGnct6yz3fKrLmbQK5yY1fRVkdheONRHWSwtTtEMEGqx7ygkUtDZltc5E5jZaD8V+
	NA72WRRKBFuB7jREK197JaB1VaR18nasFND38u4M=
X-Google-Smtp-Source: AGHT+IHpLhd+kiEiXyoTsoTl5jZ3WBP/PnmBCBnTxdCsIe5Olpz0//rplTDd8nLNTiK8XE6D7+xr+Q2W3ahS9QejMRg=
X-Received: by 2002:a05:6402:2813:b0:5d3:d7ae:a893 with SMTP id
 4fb4d7f45d1cf-5d81de23133mr35772657a12.25.1735660859481; Tue, 31 Dec 2024
 08:00:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5fbeecfc311ea182aa1d1c771725ab8b4cac515e.1729778144.git.benoit.monin@gmx.fr>
 <CANn89iK1hdC3Nt8KPhOtTF8vCPc1AHDCtse_BTNki1pWxAByTQ@mail.gmail.com> <4919277.OV4Wx5bFTl@benoit.monin>
In-Reply-To: <4919277.OV4Wx5bFTl@benoit.monin>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 31 Dec 2024 17:00:48 +0100
Message-ID: <CANn89iLfDgpnT+NLbiwG614EbyJkqoVbEB3ScYD7y=Oz+771YQ@mail.gmail.com>
Subject: Re: [PATCH v2 net] net: skip offload for NETIF_F_IPV6_CSUM if ipv6
 header contains extension
To: =?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@gmx.fr>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 31, 2024 at 4:24=E2=80=AFPM Beno=C3=AEt Monin <benoit.monin@gmx=
.fr> wrote:
>
> Hi,
>
> 23/12/2024 Eric Dumazet wrote:
> [...]
> >
> > FYI, this patch broke BIG TCP over IPv6.
> >
> > [  239.698598] Oops skb_network_header_len()=3D48 skb->len=3D67210
> > [  239.704122] skb len=3D67210 headroom=3D162 headlen=3D94 tailroom=3D0
> >                mac=3D(162,14) mac_len=3D0 net=3D(176,48) trans=3D224
> >                shinfo(txflags=3D0 nr_frags=3D3 gso(size=3D1428 type=3D1=
6 segs=3D47))
> >                csum(0x1000e0 start=3D224 offset=3D16 ip_summed=3D3
> > complete_sw=3D0 valid=3D0 level=3D0)
> >                hash(0xadf29e31 sw=3D0 l4=3D1) proto=3D0x86dd pkttype=3D=
0 iif=3D0
> >                priority=3D0x18020 mark=3D0x0 alloc_cpu=3D46 vlan_all=3D=
0x0
> >                encapsulation=3D0 inner(proto=3D0x0000, mac=3D0, net=3D0=
,
> > trans=3D0)\x00, net=3D0, trans=3D0)
> > [  239.704153] dev name=3Deth2 feat=3D0x0000030000114ab3
> > [  239.704155] sk family=3D10 type=3D1 proto=3D6
> [...]
> What is the driver of eth2?
> Since it was working before the patch, it means that the hardware is able=
 to
> deal with variable-sized IP header. So shouldn't its features contains
> NETIF_F_HW_CSUM instead of NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM?
>

Drivers supporting BIG TCP ipv6 remove the hop by hop header before
the packet hits the NIC

commit 1169a64265c4ea7100091228c98d4267f041b0e7
Author: Eric Dumazet <edumazet@google.com>
Date:   Fri May 13 11:34:07 2022 -0700

    mlx4: support BIG TCP packets

Rationale is explained in https://netdevconf.info/0x15/slides/35/BIG%20TCP.=
pdf

