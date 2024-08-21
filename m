Return-Path: <netdev+bounces-120661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF67E95A206
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 17:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F341F259C4
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F8814E2C5;
	Wed, 21 Aug 2024 15:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3j4aKiQu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA3F14D70A
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 15:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255263; cv=none; b=dVni3a0Uv4XfPuOUnm3zlwtDhUwnqWDYDJQXcSTUvjFG2uoV2UX6L86IsQ3eJLgOrPG0S/30ZFeYWlMu7vk9MV4MnaiZBD5XzrZaLnkZL3Wnc3czu1XHJUeZ4KTrBlGI4E/B1TANfjLr5wp2NICTibSTba6/hNxXYyoWbL+J2zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255263; c=relaxed/simple;
	bh=sgHJ6YptOkcKpLQK2JxauQSVKBQRRzsbtyikXIwWbDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uPVIJijHWPc4hh4SZ6fTPQytX/aYZfvj8ot7/FHQTZuFXu3FwJlFOt/5OYlXpNT0q1Mrayz/r5/P62hNfi1O1w+2sG73ePe/JSjZ9o82RYXPA1LgBKL8Bos9trODizTBKBV3wZFZwBi5ZYLSVgOmD0slktgnp1KKL92eNHAiiac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3j4aKiQu; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5bed83487aeso5581392a12.2
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 08:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724255260; x=1724860060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUnXYk1aJPUKmKqgAFtikPHUrK72trazpkSKJV6ucMM=;
        b=3j4aKiQuBArsAeDP8RFJiCAvyKMjyAtDK+2+p/4pb92gYH3wT6ES1EYzRA4q59RPHl
         6unWACbHO1eJyQO11NoJOp0NMayJ7BWa2ptQp4Qyhbx2F8CgFR6ZRgqNqUe2Aby34TgT
         lPvWrQknM6iHpasXzdpGFFLpH4ChCS2SVYOZ8/yGnL6BuCHaC7lUrdbTgraEW27h25pn
         2p2EIJKr3otJZBkiv9A86bPMQ2SWqfMjxUf1jSfgOvmpcH9WxiBvFY7mMksoFLpc8ny8
         EI5vT18LGLWWgRp/yFHttjJ4Wo6HvH1vBeZaN3ELlHMNkgY0u5PxXD6RUrgQfkCT/Mst
         T4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724255260; x=1724860060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rUnXYk1aJPUKmKqgAFtikPHUrK72trazpkSKJV6ucMM=;
        b=ZHbZ8WdsF2FZ3ALJEcmAZL7skN6QPNesITH2wu0z7Z1WpWJiwMelYsrexzYcGJPdJa
         RSIP8J6uUxe01DbfQsngAHTxj84LKaTJv2qUy0/UG+ZOXAL/o4XJUm69Ce4Nv81iQuc4
         L+EoqNsMlocuIYKryQqQ2RAwsKMJCxxw07kP7QcbHEJk+KzIEye4QGx+GW03EV7p2wcg
         Tv5fH4WQ4ARvKRtqUML9NjYREhgbKrn1bIkhtsBfPfiKvsSO8LtBXZhjyOwpN+E8PEt1
         WcbI01TQ7j6KntB+2eUCqRlpN0mBQayonCGnNIAWjyEXpjFVm0p44kPuybQQz3K+yPSp
         ZHCg==
X-Forwarded-Encrypted: i=1; AJvYcCXxvfyetlQgHOVewlJkUDTTw8uDoBpRdtov4qj44NttPZbaH/D3200erIY6jqJ8lQFKr+PBW/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7eC56Q1/+utZYHy8H39XFe1o52R/vOMEFq8DPy8OONjqD59Jq
	Eizl6phYn1lBL8b04feXDCmBcyyuO+2fNVRA611eizWU5uGfIX95iFusU++od+O0+5ILRSRi4kH
	bpRniOHqMKlKpcNF3WL2dBTeZ48YxU1l8WoMa
X-Google-Smtp-Source: AGHT+IEq9na6xHANtfysrHCYRcGY8V6pfa3wOBMKVcS+Wg0vJ9UMeil1Rzc2KdFHxjkwKEzVRmt/WTJUhujdvhZGUxE=
X-Received: by 2002:a17:907:2cc6:b0:a80:7c30:a836 with SMTP id
 a640c23a62f3a-a866f894098mr241822966b.56.1724255259550; Wed, 21 Aug 2024
 08:47:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821153325.3204-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240821153325.3204-1-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Aug 2024 17:47:28 +0200
Message-ID: <CANn89iKovApWCsnFWAVTywCmWH9bFfBRCvc75+b_tjASj22SJQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next] tcp: avoid reusing FIN_WAIT2 when trying to
 find port in connect() process
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Jade Dong <jadedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 5:33=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> We found that one close-wait socket was reset by the other side
> due to a new connection reusing the same port which is beyond our
> expectation, so we have to investigate the underlying reason.
>
> The following experiment is conducted in the test environment. We
> limit the port range from 40000 to 40010 and delay the time to close()
> after receiving a fin from the active close side, which can help us
> easily reproduce like what happened in production.
>
> Here are three connections captured by tcpdump:
> 127.0.0.1.40002 > 127.0.0.1.9999: Flags [S], seq 2965525191
> 127.0.0.1.9999 > 127.0.0.1.40002: Flags [S.], seq 2769915070
> 127.0.0.1.40002 > 127.0.0.1.9999: Flags [.], ack 1
> 127.0.0.1.40002 > 127.0.0.1.9999: Flags [F.], seq 1, ack 1
> // a few seconds later, within 60 seconds
> 127.0.0.1.40002 > 127.0.0.1.9999: Flags [S], seq 2965590730
> 127.0.0.1.9999 > 127.0.0.1.40002: Flags [.], ack 2
> 127.0.0.1.40002 > 127.0.0.1.9999: Flags [R], seq 2965525193
> // later, very quickly
> 127.0.0.1.40002 > 127.0.0.1.9999: Flags [S], seq 2965590730
> 127.0.0.1.9999 > 127.0.0.1.40002: Flags [S.], seq 3120990805
> 127.0.0.1.40002 > 127.0.0.1.9999: Flags [.], ack 1
>
> As we can see, the first flow is reset because:
> 1) client starts a new connection, I mean, the second one
> 2) client tries to find a suitable port which is a timewait socket
>    (its state is timewait, substate is fin_wait2)
> 3) client occupies that timewait port to send a SYN
> 4) server finds a corresponding close-wait socket in ehash table,
>    then replies with a challenge ack
> 5) client sends an RST to terminate this old close-wait socket.
>
> I don't think the port selection algo can choose a FIN_WAIT2 socket
> when we turn on tcp_tw_reuse because on the server side there
> remain unread data. In some cases, if one side haven't call close() yet,
> we should not consider it as expendable and treat it at will.
>
> Even though, sometimes, the server isn't able to call close() as soon
> as possible like what we expect, it can not be terminated easily,
> especially due to a second unrelated connection happening.
>
> After this patch, we can see the expected failure if we start a
> connection when all the ports are occupied in fin_wait2 state:
> "Ncat: Cannot assign requested address."
>
> Reported-by: Jade Dong <jadedong@tencent.com>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> v3
> Link: https://lore.kernel.org/all/20240815113745.6668-1-kerneljasonxing@g=
mail.com/
> 1. take the ipv6 case into consideration. (Eric)
>
> v2
> Link: https://lore.kernel.org/all/20240814035136.60796-1-kerneljasonxing@=
gmail.com/
> 1. change from fin_wait2 to timewait test statement, no functional
> change (Kuniyuki)
> ---
>  net/ipv4/tcp_ipv4.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index fd17f25ff288..b37c70d292bc 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -144,6 +144,9 @@ int tcp_twsk_unique(struct sock *sk, struct sock *skt=
w, void *twp)
>                         reuse =3D 0;
>         }
>
> +       if (tw->tw_substate =3D=3D TCP_FIN_WAIT2)
> +               reuse =3D 0;
> +

sysctl_tcp_tw_reuse default value being 2, I would suggest doing this
test earlier,
to avoid unneeded work.

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index c2860480099f216d69fc570efdb991d2304be785..9af18d0293cd6655faf4eeb60ff=
3d41ce94ae843
100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -118,6 +118,9 @@ int tcp_twsk_unique(struct sock *sk, struct sock
*sktw, void *twp)
        struct tcp_sock *tp =3D tcp_sk(sk);
        int ts_recent_stamp;

+       if (tw->tw_substate =3D=3D TCP_FIN_WAIT2)
+               reuse =3D 0;
+
        if (reuse =3D=3D 2) {
                /* Still does not detect *everything* that goes through
                 * lo, since we require a loopback src or dst address

