Return-Path: <netdev+bounces-115270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E880D945B0F
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 11:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B9FF1F231DC
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 09:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAC01C3794;
	Fri,  2 Aug 2024 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sksh22t1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24C41DAC4A
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 09:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722591182; cv=none; b=IQ1IwHs+0q8rEteYe3aNY2IpN2lw/Mysco8mVLrMsSp0KZG558nXGCG7wQn4iRuFy6CgjqTs2l7eugkgmKGTIYJTYkuHIcCqV90iuY3m/wXLISGTqJZRHrbqTnwzsYWGinHfmkJeaJh+/Y5EEqnsZxbIKluRFrHXEiMlZQxgrgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722591182; c=relaxed/simple;
	bh=AlUPv2MkLJg0dg+B90BqXCcrYz6UkUtfpeJsVH4Xl4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dXQxbAm0BsbWy1b2pR7Xo82zg+FDkQS433MKMayy85xc/Y2Fp9Dx54NGGGtmrwBsQywqdXpo4dHeACIQJTa0lSD7OPWr/c7o+JOi+uRZ0O6HGAtwAIJkm1+UbDuh/Dvphxo8KzWR3g3tWh5By0voJQmXKD8VO9r43lLAUdKCbGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sksh22t1; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so48420a12.1
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 02:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722591179; x=1723195979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJLw42eX0x5diEp44ayZtOuH0SE7rg9/HVNWOPkzlp8=;
        b=sksh22t1hT9fWZMLIJT4ywddkCv37bmmK49uVP6aCg4+4Cmq1i/ZjM86kVtwyNOzbl
         MyBrXQEEozMdj8iZqne/zF2UzDSFfHhqDAfes9TS/0vtAltZzldb8HoXnFrPagqqTkbF
         BpoIWSQnSPQ5AVToKKpsWizax61TnvypMMnXFEQdPP0ziRgi+ckPLiiGlCc7y/g1UFQj
         wvnuYTEV7YV7pHyUWc1MVq6arKL6JwdQ4e1ETf69HL3g1B7EmhPeehL8FLGi5E+HZ64o
         WAqecE9j+nzDPK0P/hMtL2Ngo6i0XJCf3twkbbG17wpzlTtfhOvkQBhrwkg00l/D7T15
         w+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722591179; x=1723195979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJLw42eX0x5diEp44ayZtOuH0SE7rg9/HVNWOPkzlp8=;
        b=QyRQmVu2ZybXC1udMUmRXIZO5tOoLxkGZsutuyUSjchH9iuyuFmkLaUFKprJ8ZtiIX
         yRJ6gdYrk2ENf30FNwmbLM+V/gfodMEOApBozUPpksJjaAVI7HkJVsAg4Kblbj2GjPKK
         D0pzUMwqhzn8UpQPwSc59UftSLhJXTZypZqS5TfODGBGKfGGrNnwuiTeq6/uy9OeL+4F
         NbWVYaDWFCLte7c4rHTsi+idNdp4nwQKXsn2s3cYhTtdXBRn60Rlaj01NmCafhEdP2Xt
         r1ydRZCi7o+m39DGDDqb2sLYd9YD/y7cTsiGKUMflUu6cWitMqi5+0LeBwAhGuqOERKv
         X+6w==
X-Forwarded-Encrypted: i=1; AJvYcCUWWI2GYJ1Wh8X/o9MstJjBfsPdKJ2lx9c89nW8hmDmWK/uCf907TaDthc1Q1fgqKCy41OwvhWCaIW7ZDLwbjUay+Zt+ykE
X-Gm-Message-State: AOJu0Yx30IG0R/Em6xjdP9zqNCFgYjogWzDI4smKRZm2SDo1kTqZt7TH
	raATla0v5xfx1Ny4vgo4P7iNIi/JWCFxvPHisUJKqkuJR+JhMSvscOgWWUGGXr2cAxGmkuNCJBD
	2UIYbUoJm6Sg0H4oZfgnevbl863yhYPhAVNQx
X-Google-Smtp-Source: AGHT+IFgny2NzFbumeqzbvER3SREZ3wNxMj5Cw5GXaOsA2EbzcD+Ji9J2UYIcXkkbwcw2Umx8SvmjU8fAPkL/XeNAMI=
X-Received: by 2002:a05:6402:358e:b0:58b:93:b624 with SMTP id
 4fb4d7f45d1cf-5b870c69d67mr84363a12.1.1722591178614; Fri, 02 Aug 2024
 02:32:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801145444.22988-1-kerneljasonxing@gmail.com> <20240801145444.22988-8-kerneljasonxing@gmail.com>
In-Reply-To: <20240801145444.22988-8-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 2 Aug 2024 11:32:47 +0200
Message-ID: <CANn89iLdtAKvat8bUwrpgQLqLeOTP6VKfU3WEJKcovRDysAE0Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 7/7] tcp: rstreason: let it work finally in tcp_send_active_reset()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 4:55=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Now it's time to let it work by using the 'reason' parameter in
> the trace world :)
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/ipv4/tcp_output.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 16c48df8df4c..cdd0def14427 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -3649,7 +3649,7 @@ void tcp_send_active_reset(struct sock *sk, gfp_t p=
riority,
>         /* skb of trace_tcp_send_reset() keeps the skb that caused RST,
>          * skb here is different to the troublesome skb, so use NULL
>          */
> -       trace_tcp_send_reset(sk, NULL, SK_RST_REASON_NOT_SPECIFIED);
> +       trace_tcp_send_reset(sk, NULL, reason);

Reviewed-by: Eric Dumazet <edumazet@google.com>

