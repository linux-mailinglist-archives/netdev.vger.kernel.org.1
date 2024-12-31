Return-Path: <netdev+bounces-154642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F021B9FF138
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 19:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 954427A1611
	for <lists+netdev@lfdr.de>; Tue, 31 Dec 2024 18:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8862719AD48;
	Tue, 31 Dec 2024 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/x0cIZs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5D1182D9
	for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735670024; cv=none; b=eiW/dB6s7OauqepLCyABPCefDdHc2r52Tq+t07O6DqzW2iM+510nikGGa96f1WvVJbW5Y5CQvsLqQUxnKCAOMu7Q70v4BZU3dMdJOeoP1sLH1FYjk5i0FngUrWTnx51J/Md0WW4QCnTBjOA9wEpUXlTaS7wwh1c8a797dxEcvEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735670024; c=relaxed/simple;
	bh=YqDuTMsvsgnfwyS47P72D+A3NQO/L+5t/+aVuGk36ng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hUUf92NMSapY3nrTVUu8QfJbc2/hcZ8xAVp0ZBiPj9ns/7Pd/smbK5Y6JxSD4OZNSaikGFs0dL981nJUinq52IVdmU1wTXhkQzY/mzAtC0HZYD0AdRl0PQM+dldtB+R9K0PUMLsWTBePbDwPklBhE5mauUfHHwDIF7m/qCSZeeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/x0cIZs; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3862a921123so6964927f8f.3
        for <netdev@vger.kernel.org>; Tue, 31 Dec 2024 10:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735670021; x=1736274821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2OGPBMKU1WoKNyQ4pzVSQVikkWah/utYrM+vJeWPpI=;
        b=a/x0cIZsvuNJUkL8hJSxiFRjZOF3LE9qdeNn88sHu9D7lU+bmtYoTPnifi6A1+hlDb
         BQATQxg9EK5PJkDRlRBVwK+YC9pxOkdrUER3UUlFOkW19yYQqvc2PeDB1jnHJmCmpeu3
         YtD2XlpMYh2MqU1QwoDs0EjBCrnqzT3/kl8uVR2j/wsqj2+Nv1ENRaGW6wnp5b2+SDtY
         Jr2dDrkDatVE4e4T/MLBSISxz/Yg4HX7QQ2PI9/bM0leDmavo4Ul7JwD30zav8amLHAV
         RpzgW3M9VGDoYhRN7XMT/7hcK3hqow6kXhH4ok64tKx6XN99nmPDkRw6eFHFeKN6yfAs
         0xqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735670021; x=1736274821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2OGPBMKU1WoKNyQ4pzVSQVikkWah/utYrM+vJeWPpI=;
        b=euHVYEjToL/lBT142mlaCKVGTf6ynyve/64hmR+PBRdeRedBVQrwpj8DtOOcvvmfck
         I+RS5S+NFmq1xVmuLxZaRTPhYNuNIQLikZmEa2VYzl9v8GqzGATHgq/ghhCDSbC2iOEe
         pTBHT/w1HJwmHSY5swuyZhUNTapovZQXSt3zM7JB9S6xvXE5DveAQnilEA9vggt7JgOq
         LHabfHD4+Jw2V3xkdy1lQe5P1a4KuZBSycqP7gdK1cGtlsYOMaduG8OSsZA1oq9ynvi3
         JLGC+8NtB3JL1GCtLpIkrtQo9N2TjP2xLhOj4kfK6faa7qzQ/WbtinIQQXfsTpC3pLao
         yLXw==
X-Forwarded-Encrypted: i=1; AJvYcCV7Ky5z6zUcBQgtz4QEPjYscjX3gGjSU+/HV7gCMR/orU0NtQvs4TLXnT8bafB4YSW3hDN9w1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgm3P6H7zU2BTco1XBV0lXb/1BCvpP/uKc2SmWyTWAcUEcEw1/
	po+0zbxNJoDG8YfnJjqoCbALrt7bOZlbEX0nRBkHiXyuMuw2yRhK
X-Gm-Gg: ASbGncv+VPjzkjSwFVtu4+wJCAyb1QouF7neUL/Zvfy10QBvELY6ZiYs8ximE99jufW
	8yMSn+LmyA5e7sne0CAd5jwcgihYzBcePbH/ch3OGUS4s7fk4X2bUYuv+Zf3MUy2cn9TDZ4F49f
	q3N2K4MfFN/NPrUmMzIs6vbEGZtUmiG7WoxafP7T5Nxe2j2XQyO+01XdeeydJS9KNbj6+M9SO9I
	Sw3jUT1UUoMkjlnf4D7yRFUhzo0OIPhvvwIcEK61xvHVPw+n3h0xkNVs8xjJJ5X9oFOrM3x1Do3
	TItEjH2TLoHg+iVaDtBivkQ=
X-Google-Smtp-Source: AGHT+IGDkrS3B0UY+BJqensP8j2URpWxSfHSCUUrYODgTEcp/0xSZ8xIJfY2OkVWcrQ2MV9SDo85hg==
X-Received: by 2002:a05:6000:18a8:b0:385:f7d2:7e29 with SMTP id ffacd0b85a97d-38a221ea539mr32400447f8f.15.1735670020636;
        Tue, 31 Dec 2024 10:33:40 -0800 (PST)
Received: from dsl-u17-10 (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e2d2sm33956181f8f.71.2024.12.31.10.33.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Dec 2024 10:33:39 -0800 (PST)
Date: Tue, 31 Dec 2024 18:33:39 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com,
 syzbot+b3e02953598f447d4d2a@syzkaller.appspotmail.com, Martin KaFai Lau
 <kafai@fb.com>
Subject: Re: [PATCH net] net: restrict SO_REUSEPORT to TCP, UDP and SCTP
 sockets
Message-ID: <20241231183339.6ee59b64@dsl-u17-10>
In-Reply-To: <20241230193430.3148259-1-edumazet@google.com>
References: <20241230193430.3148259-1-edumazet@google.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Dec 2024 19:34:30 +0000
Eric Dumazet <edumazet@google.com> wrote:

> After blamed commit, crypto sockets could accidentally be destroyed
> from RCU callback, as spotted by zyzbot [1].
> 
> Trying to acquire a mutex in RCU callback is not allowed.
> 
> Restrict SO_REUSEPORT socket option to TCP, UDP and SCTP sockets.
> 
...
> 
> Fixes: 8c7138b33e5c ("net: Unpublish sk from sk_reuseport_cb before call_rcu")
> Reported-by: syzbot+b3e02953598f447d4d2a@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6772f2f4.050a0220.2f3838.04cb.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Martin KaFai Lau <kafai@fb.com>
> ---
>  include/net/sock.h | 7 +++++++
>  net/core/sock.c    | 6 +++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 7464e9f9f47c..4010fd759e2a 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2730,6 +2730,13 @@ static inline bool sk_is_tcp(const struct sock *sk)
>  	       sk->sk_protocol == IPPROTO_TCP;
>  }
>  
> +static inline bool sk_is_sctp(const struct sock *sk)
> +{
> +	return sk_is_inet(sk) &&
> +	       sk->sk_type == SOCK_STREAM &&
> +	       sk->sk_protocol == IPPROTO_SCTP;
> +}

Isn't SCTP SOCK_SEQPACKET ?
In any case the sk_type test is redundant (for inet sockets).

If support is needed for raw (ip) sockets is it enough to just
check sk_is_inet() ?

	David

> +
>  static inline bool sk_is_udp(const struct sock *sk)
>  {
>  	return sk_is_inet(sk) &&
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 74729d20cd00..56e8517da8dc 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1295,7 +1295,11 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
>  		sk->sk_reuse = (valbool ? SK_CAN_REUSE : SK_NO_REUSE);
>  		break;
>  	case SO_REUSEPORT:
> -		sk->sk_reuseport = valbool;
> +		if (valbool && !sk_is_tcp(sk) && !sk_is_udp(sk) &&
> +		    !sk_is_sctp(sk))
> +			ret = -EOPNOTSUPP;
> +		else
> +			sk->sk_reuseport = valbool;
>  		break;
>  	case SO_DONTROUTE:
>  		sock_valbool_flag(sk, SOCK_LOCALROUTE, valbool);


