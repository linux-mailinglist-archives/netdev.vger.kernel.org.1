Return-Path: <netdev+bounces-110882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF85292EBC3
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 17:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D80D1F24900
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 15:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3800576034;
	Thu, 11 Jul 2024 15:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iw7x7IE0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C341642B
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720712069; cv=none; b=lyhl03bd0tHof79u/INMTavPXAHLjbslA3vkN7oyvliqNHWdvyz77M/eqn7hedKAR5mMY7GS85ETkomTwAxjOtWEwGlp9GOIUBAHWj4sVhuyFaqd8N3n4V2NYKeMyPUYH8TMbovrnhaUIzjQMotGfk/AL50fKYAZMCTtQHqZ10E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720712069; c=relaxed/simple;
	bh=yvzsqQbQfoS5qaafGTJ3Z6ul6WI4SYH4DkvZks0FEnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gDle8TcTbLQfs2IHD3Pwz9EE8WMIT4gEsYNVEwA7BbIikEfLuh3CR29XUFbrGIzjZaRanL0ry6W+766V3lupU2pX0A0gQAO442yXvkONYEk8IFfC7e1aVGM3xQh8JJgwI1L7aKDuLz0gfX23eioXUv7EKbmo3G7W2WomH6Zfwfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iw7x7IE0; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso17651a12.0
        for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 08:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720712066; x=1721316866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyHdC/G6S5r7eCq2k2+XCASvYqoniOpGXpN3b3NuqQA=;
        b=Iw7x7IE0QwgBxM7nHcmiuppuJOw0Xb/RCc9QZJ9FdzOqy8LIOp01iXuJhcUBaDdhtA
         UPiDrk5gPzn/hlukVXYKX00ocdDwe7ERQLKveoP4mTD3xDCYCYYeqQYKLngRS30wVnrA
         qKZt5zbMS33jY9oK6DKyUszyXoeb+HgCADOR8Mo9Zp6/RTbMdG2rp1PBbmRkTg3qK5y6
         walrK1sSxbX6GLCfPUf0tpiBMgWNl/YPcNnCm6MdV6GjSgZXQQcJalddwkgmV6YNvUgd
         hMjBPcWPuE69oUwCi/tbiQPF5gmPahzBtRwQCoSlQTtaV2F1gnsGGLI3C08rK9FX7v7i
         Io+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720712066; x=1721316866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EyHdC/G6S5r7eCq2k2+XCASvYqoniOpGXpN3b3NuqQA=;
        b=DkOpojaTMa7Tov4EqNq0H2/gGJ/fHihvIqQSYmYENiU729DcXkTNmRpDT6VudA/Nfi
         aghTvVTw34qYNzVPGbd7S8YOQ5hYmTeMqbDGCgq2eUYMdnIcgWOIsiST/0qwyTFYH8tf
         HmuN/ZPEzdhPqrYC5qPAv2Xokh6yuaYjkRv+nr+m6tvgYnWHsd6hiKpYvyAOjNhd/got
         nFS3MpiLaoNa2H5CeQKWM70LmbFiRL8vaGeTGknd6JeFmduu1aLbu9ToOTEpooI7U6nB
         j8ZJzR+kCdcAgCPWPvom4divcXD4R1A+K1mNR06/pU9P3/BWlJrcT9cPfYr7QlcxZSm1
         BI8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgUfh+Wf8W3YpgG8fSw1HfHs/EDT0GcbaBdzeGdVmIdfo8tN5oDLWN8f2SQw1lMC19nhEnEZVQzaLZlUITBdIh9frwD6zU
X-Gm-Message-State: AOJu0YwGv1d5+jkq3sKBtBlfKZh0EWG51hrX61dkpZjN7qyQJL66+Ef6
	J6F8Sf524L7x5TXqhD+SXVHaiC+qI94e1xv/cNPXsHYhsPsDXs1MK12NWkJWT7mWGyNDvS54u4B
	3C+Xq/xDq1fc4VoWS9I5nxOqmxmnUbphoATYIkur5V6PUC7CNij8K
X-Google-Smtp-Source: AGHT+IFt5as97v8mc6p1fhlzw6PoT6Puof1m3RBj12dD//FyoAjzEdOWnfjqsw3Cl6JlWRbUZFST+bV8+9dAVuOZmZQ=
X-Received: by 2002:a50:9510:0:b0:57c:b712:47b5 with SMTP id
 4fb4d7f45d1cf-5982931a177mr267869a12.4.1720712063882; Thu, 11 Jul 2024
 08:34:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710171246.87533-1-kuniyu@amazon.com> <20240710171246.87533-2-kuniyu@amazon.com>
In-Reply-To: <20240710171246.87533-2-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jul 2024 08:34:10 -0700
Message-ID: <CANn89i+TgEnBhw5Lhzy_TQSP--BSO1WGm+PVZnMAyfc7m7wrZA@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/2] tcp: Don't drop SYN+ACK for simultaneous connect().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 10:13=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> RFC 9293 states that in the case of simultaneous connect(), the connectio=
n
> gets established when SYN+ACK is received. [0]
>
>       TCP Peer A                                       TCP Peer B
>
>   1.  CLOSED                                           CLOSED
>   2.  SYN-SENT     --> <SEQ=3D100><CTL=3DSYN>              ...
>   3.  SYN-RECEIVED <-- <SEQ=3D300><CTL=3DSYN>              <-- SYN-SENT
>   4.               ... <SEQ=3D100><CTL=3DSYN>              --> SYN-RECEIV=
ED
>   5.  SYN-RECEIVED --> <SEQ=3D100><ACK=3D301><CTL=3DSYN,ACK> ...
>   6.  ESTABLISHED  <-- <SEQ=3D300><ACK=3D101><CTL=3DSYN,ACK> <-- SYN-RECE=
IVED
>   7.               ... <SEQ=3D100><ACK=3D301><CTL=3DSYN,ACK> --> ESTABLIS=
HED
>
> However, since commit 0c24604b68fc ("tcp: implement RFC 5961 4.2"), such =
a
> SYN+ACK is dropped in tcp_validate_incoming() and responded with Challeng=
e
> ACK.
>
> For example, the write() syscall in the following packetdrill script fail=
s
> with -EAGAIN, and wrong SNMP stats get incremented.
>
>    0 socket(..., SOCK_STREAM|SOCK_NONBLOCK, IPPROTO_TCP) =3D 3
>   +0 connect(3, ..., ...) =3D -1 EINPROGRESS (Operation now in progress)
>
>   +0 > S  0:0(0) <mss 1460,sackOK,TS val 1000 ecr 0,nop,wscale 8>
>   +0 < S  0:0(0) win 1000 <mss 1000>
>   +0 > S. 0:0(0) ack 1 <mss 1460,sackOK,TS val 3308134035 ecr 0,nop,wscal=
e 8>
>   +0 < S. 0:0(0) ack 1 win 1000
>
>   +0 write(3, ..., 100) =3D 100
>   +0 > P. 1:101(100) ack 1
>
>   --
>
>   # packetdrill cross-synack.pkt
>   cross-synack.pkt:13: runtime error in write call: Expected result 100 b=
ut got -1 with errno 11 (Resource temporarily unavailable)
>   # nstat
>   ...
>   TcpExtTCPChallengeACK           1                  0.0
>   TcpExtTCPSYNChallenge           1                  0.0
>
> The problem is that bpf_skops_established() is triggered by the Challenge
> ACK instead of SYN+ACK.  This causes the bpf prog to miss the chance to
> check if the peer supports a TCP option that is expected to be exchanged
> in SYN and SYN+ACK.
>
> Let's accept a bare SYN+ACK for active-open TCP_SYN_RECV sockets to avoid
> such a situation.
>
> Note that tcp_ack_snd_check() in tcp_rcv_state_process() is skipped not t=
o
> send an unnecessary ACK, but this could be a bit risky for net.git, so th=
is
> targets for net-next.
>
> Link: https://www.rfc-editor.org/rfc/rfc9293.html#section-3.5-7 [0]
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

