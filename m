Return-Path: <netdev+bounces-119450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B132955B06
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 07:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1F43B20B66
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 05:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DCA8F66;
	Sun, 18 Aug 2024 05:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiuQ3S3b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CFDB666
	for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 05:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723958232; cv=none; b=GGc9c4u6K/wskVsyKn/9wXsXarV2MHbWkI1gYD7ihGvkyVsKwzt6WW/46H/AG9kQAKidJpvLgAVuNSyngX87oOvQCIS5A4xrTDg6CT9cYBFjz32W65M3s4JEBY6vHt2xx2jOtJ8yCm3jMyx6vI3jMa5wZbzFGl9GfiwXR62kiYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723958232; c=relaxed/simple;
	bh=q6V3/y8li1MfL3eUZjIiebm3r9FUGaYVnlacoBQQUKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rp+59sbMTSIefGDDv9jmAtoWmZiVIVeBvrTjvXQlOMYEKJFX6lbGUT1hekiPhpqxVb39rqrSlVl1HfVAmYwqHhmhNJKkCsUdcTM+0ZvAQ9zU+W/MyZdkdoS9vLoTXqkjdZ6lgqcWLtJUNKHQ1vZpXAc44nhmIE0E+lWsP/eiUhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiuQ3S3b; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-39d3b89ded1so2210105ab.0
        for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 22:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723958230; x=1724563030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swV2BslQ9iooG2wKiYGU34HhEVu53tLH3wEjBU6cug0=;
        b=CiuQ3S3bs6SQako0q9RWsNUvPNL9C5iAwRk83wQleFBodCvpzCbUtcHhRObCseEaFj
         j+hDGNKW3Duibv6/NMmd1jzYhZo61TA0Qnaq3KCmkPWhx+aDfgI6pMyy4SZXNuYAkddQ
         LsFMejDQh39k1v+f+TAa7q7YOqP5EtOFR8mZtHrtFWABNS6xFMxW2aHae4AYKEYAhxax
         keod+syBDaTk8axJJcKV08WWQqOMjEei/Vyo9TYED0sQFwfKkXykVBWuzgRPTXZbqns9
         9eZyvQbNYDmwG2/cgJAoDls4GYNvGn00kRrxWopp5BKe64VucGmDPFWx0OfgRH6DBlUI
         Drrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723958230; x=1724563030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=swV2BslQ9iooG2wKiYGU34HhEVu53tLH3wEjBU6cug0=;
        b=wAKM4AFzIb4iAI7aT6FcJuUKV8AsVYh2fdnni5oTbp/tS7A47/rMesocp1WwxW+hqh
         TFg0Wu1eFY5g6gpqw+U13vSVsGJzelojbLnHZcjOjeQ5cSMRHEKVIdu4RxjBty6gvjWF
         uIUfYcXg+vV5xFKG9qRRQrVBAqOva3iqQyk/ce4BW9RiEpZzNoERly6As0rgWfT/UBmA
         i47z2qvfomyjtww90a/UZ2l1cBpkWDBsgWoXZG2wA8WzzQDEdYJXIMWIZdsUHE3fpKhm
         80/2G6Sxi5us/hQZ2IR9bk4jtJJYToMa6lLoj5S+rzj/Yx/4clLJKJeheah1WigQYIIX
         ocrQ==
X-Gm-Message-State: AOJu0Yyh2Vk+aJx81MNEI7zOGZRZih+94y68PI1F9HDSRml0I/hXu2+b
	QpkYAVbPCRp0rY/hI6jt6xd7G+m1oEkXU489O8jBKm5m2WGrvqo2wAHKCUFfszWPgC9npCoBDHJ
	vDUISw14fYHE2KGpIpw2Hso/nZ+M=
X-Google-Smtp-Source: AGHT+IEbn0x2xpnoL1WCD5oMQHr3xs9rRRyH1BnLsAbQJCazvIlYnzAvh/E72ue50U+x4aovuRXbBq13C85oJUm3llw=
X-Received: by 2002:a05:6e02:16cf:b0:39a:eb26:45f8 with SMTP id
 e9e14a558f8ab-39d26d5fbe5mr95053365ab.20.1723958229594; Sat, 17 Aug 2024
 22:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240818042538.40195-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240818042538.40195-1-kerneljasonxing@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 18 Aug 2024 13:16:33 +0800
Message-ID: <CAL+tcoBPxMGBDN1yijgdpYpb8PJA-fWDi8gaEda=msVk2fo_iQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: do not allow to connect with the four-tuple
 symmetry socket
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, ncardwell@google.com
Cc: netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2024 at 12:25=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Four-tuple symmetry here means the socket has the same remote/local
> port and ipaddr, like this, 127.0.0.1:8000 -> 127.0.0.1:8000.
> $ ss -nat | grep 8000
> ESTAB      0      0          127.0.0.1:8000       127.0.0.1:8000
>
> Before this patch, one client could start a connection successfully
> as above even without a listener, which means, the socket connects
> to its self. Then every time other threads trying to bind/listen on
> this port will encounter a failure surely, unless the thread owning
> the socket exits.
>
> It can rarely happen on the loopback device when the connect() finds
> the same port as its remote port while listener is not running. It
> has the side-effect on other threads. Besides, this solo flow has no
> merit, no significance at all.
>
> After this patch, the moment we try to connect with a 4-tuple symmetry
> socket, we will get an error "connect: Cannot assign requested address".
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/ipv4/inet_hashtables.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index 9bfcfd016e18..2f8f34ee62fb 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -978,6 +978,21 @@ void inet_bhash2_reset_saddr(struct sock *sk)
>  }
>  EXPORT_SYMBOL_GPL(inet_bhash2_reset_saddr);
>
> +/* SYMMETRY means the socket has the same local and remote port/ipaddr *=
/
> +#define INET_ADDR_SYMMETRY(sk) (inet_sk(sk)->inet_rcv_saddr =3D=3D \
> +                               inet_sk(sk)->inet_daddr)
> +#define INET_PORT_SYMMETRY(sk) (inet_sk(sk)->inet_num =3D=3D \
> +                               ntohs(inet_sk(sk)->inet_dport))
> +#define INET_PORT_SYMMETRY_MATCH(sk, port) (port =3D=3D \
> +                                           ntohs(inet_sk(sk)->inet_dport=
))
> +static inline int inet_tuple_symmetry(struct sock *sk)

Patchwork shows to me that I should not use inline in the .c file. I
will change it in due course in v2 patch.

