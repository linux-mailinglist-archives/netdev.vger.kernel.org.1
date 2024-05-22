Return-Path: <netdev+bounces-97498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EDC8CBB97
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 08:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F872B20FD9
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 06:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770ED74E3D;
	Wed, 22 May 2024 06:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y5rS7jPE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10FE18C3D
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 06:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716360758; cv=none; b=DO9VUhlWPJX7v0uEN1QQnBYt5WRXAAEYroMQObAsOBl/mizz5x+b6XBxux8mT7tXin1p2c7jDdGrVisRnCGj2X2R2TBfuOIqr3UnPB4hIHhrPCOcQJ2QVxJ4/Qq8CTj6iJYTRpY6JijdnVVHcKBU3S0pG7NqajfyOQN6Id625pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716360758; c=relaxed/simple;
	bh=rOkhvpe8iKpXVCqhpp7HVWwpSlLgAQnmHjLJXsTzGrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0cGQRbgEb193xprQuv/WhYU/WQ7nEzbVf374BIBd6VKVnw9dKclYJv6b+ylrLNpxR+Y7Y7whL5ruTf4uoDcPuY6w/HsglaNhEgiIe1QVIzneVeZDOkaCLGl7whpLgoOMKQ89FOD87zw4S7QlXqh/gxNVUEpQb8h88z3RwKZQmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y5rS7jPE; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52399b68b0bso2214e87.0
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 23:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716360755; x=1716965555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYUSrZ3XazOgHSg9Apr4aZjHDZafCO0ZxRdr8Tp5xDI=;
        b=y5rS7jPE9yam+ejowRWOI0m9dbqXLxw1d1E2XyqPKzC4ZU0XDo+/NNywKvY2b9nJR0
         MInCG8sXtrcyFKs1QbZ5kOmPVXaqa/sTfHRQawNryuUl2AGbchUJSPSOAW34pAQljtAW
         oWo1i57+Qu23PwLBHpOQYivUGP7GqZCsfX4QKtkKVbADeJ+sCbn+/4/zSyJmh6EcZo2X
         1WN1g0mmNxmD8Rh6lRl4MmchuQgjNJuaAwY/7hE26mgKr2iBaMrbAm0T8P34YNR1YtB9
         DvZfzYSpJnAU5R7wSqeLsAdQFudTusAlgt2ImUXlfvBPkhLrPcq2lacZKYcpwGvKlq5P
         RKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716360755; x=1716965555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYUSrZ3XazOgHSg9Apr4aZjHDZafCO0ZxRdr8Tp5xDI=;
        b=HLib0QHEStF0o80UF/OgygG+KJAqBbH3IcfqUjqekjh2jip8iMBG+XxlfKhKvM5IaL
         SSqwxlbSKY2Ou/9cpKrxC4f5/tqJMWF3duIM15OTGwDBVItxxHfHRlOXsn7HIXJJJazW
         4GLZGl3DC/syjrKz6+o5c2cmJ3ueg9NzNyHotUS2EVXRJMjUFKVUl55ejvzw1pW4Nzz9
         5w7cYd5MKDotIm8RYve91nv3seh33BTSaWwz1WG8vc0BUfhlDRuc09m15DM4LVVorJOE
         IBrx8IxJpLb+7O86rEMlVVwNDQEtO1ipqjPp+wJPSfnYUFF2UPckD20iw6mBxiBZoVLx
         FjMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZAobNRrMuNuxex84026YeUILy1gtF6xz50q/+hsmtvDFX9NmrySYbo0ANOti2JcU7A6LOVVIBu50Lomeu71zBpN0KtUWI
X-Gm-Message-State: AOJu0YwRRHMOv9vDZJvYcofJknbnaSd5xKRFMhGgq99XmozHGsSo8R68
	scS+H+2J7UXNusnFmtvePxR8OeH9qIC1sSPaq9wEy4gtgfWrxlT7J/To40Fyv4ib3TGVQ6/0iIf
	X+leyP0ay+7sVOUN9pzxa/D/t3ySAldfTvo0J6v2/L7Uy2N/JJA==
X-Google-Smtp-Source: AGHT+IH+C/AJMuiIi/8GrrbQgHRHu/VgZsVhw8gN/aSsNg19Ag6fhQWiYGLIwXHyX9J6xx5wiBXfu/5HaLIIXVycwZo=
X-Received: by 2002:a19:701a:0:b0:521:6e82:8884 with SMTP id
 2adb3069b0e04-526aeb4a522mr73919e87.7.1716360754572; Tue, 21 May 2024
 23:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521134220.12510-1-kerneljasonxing@gmail.com>
In-Reply-To: <20240521134220.12510-1-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 May 2024 08:52:23 +0200
Message-ID: <CANn89i+ByJ5S2y_M86fG5v2cSYsfaXH4=JL+Y0FMRNpHDSijdQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: remove 64 KByte limit for initial tp->rcv_wnd value
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, ncardwell@google.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 3:42=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Recently, we had some servers upgraded to the latest kernel and noticed
> the indicator from the user side showed worse results than before. It is
> caused by the limitation of tp->rcv_wnd.
>
> In 2018 commit a337531b942b ("tcp: up initial rmem to 128KB and SYN rwin
> to around 64KB") limited the initial value of tp->rcv_wnd to 65535, most
> CDN teams would not benefit from this change because they cannot have a
> large window to receive a big packet, which will be slowed down especiall=
y
> in long RTT. Small rcv_wnd means slow transfer speed, to some extent. It'=
s
> the side effect for the latency/time-sensitive users.
>
> To avoid future confusion, current change doesn't affect the initial
> receive window on the wire in a SYN or SYN+ACK packet which are set withi=
n
> 65535 bytes according to RFC 7323 also due to the limit in
> __tcp_transmit_skb():
>
>     th->window      =3D htons(min(tp->rcv_wnd, 65535U));
>
> In one word, __tcp_transmit_skb() already ensures that constraint is
> respected, no matter how large tp->rcv_wnd is. The change doesn't violate
> RFC.
>
> Let me provide one example if with or without the patch:
> Before:
> client   --- SYN: rwindow=3D65535 ---> server
> client   <--- SYN+ACK: rwindow=3D65535 ----  server
> client   --- ACK: rwindow=3D65536 ---> server
> Note: for the last ACK, the calculation is 512 << 7.
>
> After:
> client   --- SYN: rwindow=3D65535 ---> server
> client   <--- SYN+ACK: rwindow=3D65535 ----  server
> client   --- ACK: rwindow=3D175232 ---> server
> Note: I use the following command to make it work:
> ip route change default via [ip] dev eth0 metric 100 initrwnd 120
> For the last ACK, the calculation is 1369 << 7.
>
> When we apply such a patch, having a large rcv_wnd if the user tweak this
> knob can help transfer data more rapidly and save some rtts.
>
> Fixes: a337531b942b ("tcp: up initial rmem to 128KB and SYN rwin to aroun=
d 64KB")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

