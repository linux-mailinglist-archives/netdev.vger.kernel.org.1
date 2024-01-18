Return-Path: <netdev+bounces-64205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC31831BDC
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 15:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1F401F219D7
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 14:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE391DDD9;
	Thu, 18 Jan 2024 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FrRvIeNc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0760D1DA2A
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705589719; cv=none; b=QTb6wnEnPBOIkmt1Ju3XhN3wstFh55mwrQWVj/hy8GMvbOiF323AV84ldwDlcaliLCZ7XF9MN5H8Bw8BldxaoA9J5Y7Pxr3Y0/0y/1yieB4HCpsnEdL98P/ypfvAIrWJE/OMjZ1pkslPY9mo9YuoKwbvSEZJv1cxAL5zJZqjPtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705589719; c=relaxed/simple;
	bh=GwND1Fx68Gn7CtEhqbQAYLoMZo7VK+Pc7yN10s+2sus=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:Message-ID:Subject:From:
	 To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version; b=a8WaZQWH2gLZ/mVVgamswAlCwTz/poGm9PV4VoguvnEzDoNZ5D6OVPLo/T9f/LmiXvNkLZ5xXE9FDB5VzBWKbrRdVzt3VnbVv/kH7uqth0alCJc9T0GwMHJKnK1TEcRbZM2lbstwd0gZ037KYIhFmQ3bywQuAeI762vtdXzcwuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FrRvIeNc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705589716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BD91j7jyTaSbSnKpymSiXILldsZ1B3FQmmDH6kUTI/k=;
	b=FrRvIeNcyQCfNr4Gu/wlG0F41S2LVPfqL97AkyCQpeB1RWx4uyyQl0G9SXLglNkRLicjC8
	FEv2pB4i8bJ/Xjq0D0BV+7WO31gaODLhYgi+bpHFyYoKZlgHx90yWp36YOevQjeGnRYYoM
	L/O2ZkRKTnQiwcOecESfZec0gRZzofY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-22SVhUKPO5SHA_4ZqMw5FA-1; Thu, 18 Jan 2024 09:55:15 -0500
X-MC-Unique: 22SVhUKPO5SHA_4ZqMw5FA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-78313358d3bso279549385a.0
        for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 06:55:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705589714; x=1706194514;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BD91j7jyTaSbSnKpymSiXILldsZ1B3FQmmDH6kUTI/k=;
        b=V6QDjQWRE3ygB4/ciSubsqB60YXYw5Xrwx07kSGKG78Hv6tHX8C3+piMqihKsgOG20
         hG5Mn60f37z5vY6TgZnGaS6ZjHa/f0oHGeOOntu9rV8AOBCdBR8lm3Sc/UzOKflCvPQa
         YfVkeobxkyi8GmlyBZKR4c3AsnI7IayHUTPLwsoxb+ooQioN3w5+S6Ted1zY9s4V4Q+/
         vE8GjCtazhfE5uy5TCJIZx5U9BbLUV7bQs2zNORvwnGpJT6dCBJxqOladw7lSKhxyY5D
         amo6jRonnutASlZRo5V6P/nJzCdgBgLCQW2mEsM9zm4AaxLmoIiT/9B5B6EOmmsmX1JA
         b5Ig==
X-Gm-Message-State: AOJu0YyJUosdCxvCDoRgBaM1uiwbcRA9Qpu5H6NkzgbJYntIn8RpaBVf
	3cfg1T4XslNF5KLUM9lCeLrXuDV+MFtYxuAmx/5hmBjjRNaT5VyW34IPoeXNSbG921smo8Q6hve
	oR8PQ+kzgxyAtlH55ZxiXBAW2TPQQ0/Oe7n+JuCNwLFTwQVznUDJ/oksliUJwTw==
X-Received: by 2002:a05:620a:26a3:b0:783:80a1:60bf with SMTP id c35-20020a05620a26a300b0078380a160bfmr1210967qkp.1.1705589714431;
        Thu, 18 Jan 2024 06:55:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExEO3+QPg/k015PhYEdlUHISE8bqmfnBObcr2CGBUZzjX1WVU9qxLehS7bFW3IAIy8OQu6xw==
X-Received: by 2002:a05:620a:26a3:b0:783:80a1:60bf with SMTP id c35-20020a05620a26a300b0078380a160bfmr1210950qkp.1.1705589714119;
        Thu, 18 Jan 2024 06:55:14 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-180.dyn.eolo.it. [146.241.241.180])
        by smtp.gmail.com with ESMTPSA id g14-20020ae9e10e000000b007836e78512asm1773187qkm.61.2024.01.18.06.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 06:55:13 -0800 (PST)
Message-ID: <b8be2149159977ca30d395b3d981a2bbaa192c4d.camel@redhat.com>
Subject: Re: [PATCH net] udp: fix busy polling
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>,
  netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Thu, 18 Jan 2024 15:55:11 +0100
In-Reply-To: <20240118143504.3466830-1-edumazet@google.com>
References: <20240118143504.3466830-1-edumazet@google.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-18 at 14:35 +0000, Eric Dumazet wrote:
> Generic sk_busy_loop_end() only looks at sk->sk_receive_queue
> for presence of packets.
>=20
> Problem is that for UDP sockets after blamed commit, some packets
> could be present in another queue: udp_sk(sk)->reader_queue
>=20
> In some cases, a busy poller could spin until timeout expiration,
> even if some packets are available in udp_sk(sk)->reader_queue.
>=20
> Fixes: 2276f58ac589 ("udp: use a separate rx queue for packet reception")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/skmsg.h |  6 ------
>  include/net/sock.h    |  5 +++++
>  net/core/sock.c       | 10 +++++++++-
>  3 files changed, 14 insertions(+), 7 deletions(-)
>=20
> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index 888a4b217829fd4d6baf52f784ce35e9ad6bd0ed..e65ec3fd27998a5b82fc2c459=
7c575125e653056 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
> @@ -505,12 +505,6 @@ static inline bool sk_psock_strp_enabled(struct sk_p=
sock *psock)
>  	return !!psock->saved_data_ready;
>  }
> =20
> -static inline bool sk_is_udp(const struct sock *sk)
> -{
> -	return sk->sk_type =3D=3D SOCK_DGRAM &&
> -	       sk->sk_protocol =3D=3D IPPROTO_UDP;
> -}
> -
>  #if IS_ENABLED(CONFIG_NET_SOCK_MSG)
> =20
>  #define BPF_F_STRPARSER	(1UL << 1)
> diff --git a/include/net/sock.h b/include/net/sock.h
> index a7f815c7cfdfdf1296be2967fd100efdb10cdd63..b1ceba8e179aa5cc4c90e98d3=
53551b3a3e1ab86 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2770,6 +2770,11 @@ static inline bool sk_is_tcp(const struct sock *sk=
)
>  	return sk->sk_type =3D=3D SOCK_STREAM && sk->sk_protocol =3D=3D IPPROTO=
_TCP;
>  }
> =20
> +static inline bool sk_is_udp(const struct sock *sk)
> +{
> +	return sk->sk_type =3D=3D SOCK_DGRAM && sk->sk_protocol =3D=3D IPPROTO_=
UDP;
> +}
> +
>  static inline bool sk_is_stream_unix(const struct sock *sk)
>  {
>  	return sk->sk_family =3D=3D AF_UNIX && sk->sk_type =3D=3D SOCK_STREAM;
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 158dbdebce6a3693deb63e557e856d9cdd7500ae..e7e2435ed28681772bf3637b9=
6ddd9334e6a639e 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -107,6 +107,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/poll.h>
>  #include <linux/tcp.h>
> +#include <linux/udp.h>
>  #include <linux/init.h>
>  #include <linux/highmem.h>
>  #include <linux/user_namespace.h>
> @@ -4143,8 +4144,15 @@ subsys_initcall(proto_init);
>  bool sk_busy_loop_end(void *p, unsigned long start_time)
>  {
>  	struct sock *sk =3D p;
> +	bool packet_ready;
> =20
> -	return !skb_queue_empty_lockless(&sk->sk_receive_queue) ||
> +	packet_ready =3D !skb_queue_empty_lockless(&sk->sk_receive_queue);
> +	if (!packet_ready && sk_is_udp(sk)) {
> +		struct sk_buff_head *reader_queue =3D &udp_sk(sk)->reader_queue;
> +
> +		packet_ready =3D !skb_queue_empty_lockless(reader_queue);
> +	}
> +	return packet_ready ||
>  	       sk_busy_loop_timeout(sk, start_time);
>  }
>  EXPORT_SYMBOL(sk_busy_loop_end);

LGTM, thanks Eric!

Acked-by: Paolo Abeni <pabeni@redhat.com


