Return-Path: <netdev+bounces-101980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381E2900F12
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 03:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42E651C214A4
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 01:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6B063C8;
	Sat,  8 Jun 2024 01:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLC1woYg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151EB7F
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 01:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717809626; cv=none; b=WYJgBbjkcTtOVWx+WCzyoB/Sovk46wKYU8paX9fsom4/y1zC0knBkZz9VutjQ8IMuj/nBPyF9wA5IrUAW2k51Usl+ZB0BlFw4fp14RX75fmDkBMXWINfbEtnqj3XB30lUH7c+X14q+siyPPnE7keR+CbYDcVHR5zj1TdRlR5Ap4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717809626; c=relaxed/simple;
	bh=QIg6XGSCr+CGdd0aBjGmkYFLCEsLsRysfCCz2IXW1Qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNx/4nwQzrkdG/JfEtaNBxW43E/KJxBiGLiN55r0Ajd7IdE0aRObkcDAS5qptCgd1zu215Wx7miYpCOF0Cj3Ne5t85VoboMLCNzXkxrwhXp+GGc3vND9Xb+Fyac/GMmHHtSGyLsK7uCmuWJDXE1Irt4IfdMfBhT5DgtRWhCQn0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLC1woYg; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a689ad8d1f6so333107166b.2
        for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 18:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717809623; x=1718414423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIg6XGSCr+CGdd0aBjGmkYFLCEsLsRysfCCz2IXW1Qc=;
        b=LLC1woYgBhwcK1lYlKie6sPL//z/p6PiubSaxaeZ6MI8sxrX9MUk1fHGvMMHC0vyIp
         G8ADyDjN1aie7nJjmNcD4u72x+afErK/8YApw1dGxfydHtFbGW8YH70dOBtkv/A3Y6H6
         O98joiRAwr+B6JT7sE1U3rCHWNXPRuyJiRyfvePChcN8jGOHVulFpspD36MjoMuCeTfr
         6yTishutnOrqr+bhA8aZm1is8EtNx3J8SOMzTPTynDL2rppZDPJUyC+vaHPt7zXINshF
         1i3kK5OryMOQangWrkh+Xs5MWwzzi5JSrvBsfpc059tgQv9ILMAKVaVAvjcXTbTdQO1H
         8Vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717809623; x=1718414423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIg6XGSCr+CGdd0aBjGmkYFLCEsLsRysfCCz2IXW1Qc=;
        b=LnI9i10Y4ci24FRHxGvrN8akgIE7vaWZr+1jCz1Ept4BifPxbiWqvu5FuxuK5mswmK
         HYqXuRQ1Mtsgxk4/06xGclk5rRqcIxvaxg16HcGd1UmYoj0iyg8wpa+1eiaGuf2uOAmu
         S/sbvCB4bdy6vfKHtcNyg9Tk8gXAI43B8fVt46YmouHXsi2TSoY9Tmz28S2dTQvdMy8I
         bR0nBCPjlApWxVMncFVoCQgWKwoaqMN26S7P9pgW5TUIovhg6jqPip2hoYcbOBCzNreJ
         sfSfk3QY369CSVJyDtdbYW6bbgrw1AKh9gk6rm+ndfe5SQcnASZTooLdZmE4l4HX7bBS
         Os0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVz0tf3L1SGPvEwEFJIWyH5V4sEE04HcTG2Pcdk4WP/wVtbENn3fUQfSSoznfDdr3Kz6S8HcKvwnpX7rC8o9OFUIl2+qlQ/
X-Gm-Message-State: AOJu0YwISCjzntmKIZks5wo8V1wKsQdZeq7kGvdVIz7uM/H6KKjxo+IZ
	0e4qlFdA+Etd1+SWmodyms7IrAUvaU89uml65H4buNJfwteE1Hwe8NjVTkFgi0+WXGgTL9drIC5
	2+oyAx4prxgqhK3dqOPGKfh16cLI=
X-Google-Smtp-Source: AGHT+IFV1graCwsRp3llKS0Ij4VEu0wIgLoZAKIPFmwfuNkjcgWHEmBDyqEzJj9Tvr89GrWx4bL648Nu+o4Ntpb3vqI=
X-Received: by 2002:a17:906:ae4a:b0:a6e:46ab:9a9b with SMTP id
 a640c23a62f3a-a6e46ab9b22mr182881366b.31.1717809623326; Fri, 07 Jun 2024
 18:20:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607125652.1472540-1-edumazet@google.com>
In-Reply-To: <20240607125652.1472540-1-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 8 Jun 2024 09:19:45 +0800
Message-ID: <CAL+tcoDmdHQ8MQmH0grozXe7_HJS0vuzYXsYp44bUoLJHcRr1Q@mail.gmail.com>
Subject: Re: [PATCH net] tcp: use signed arithmetic in tcp_rtx_probe0_timed_out()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, eric.dumazet@gmail.com, 
	Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 8:58=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Due to timer wheel implementation, a timer will usually fire
> after its schedule.
>
> For instance, for HZ=3D1000, a timeout between 512ms and 4s
> has a granularity of 64ms.
> For this range of values, the extra delay could be up to 63ms.
>
> For TCP, this means that tp->rcv_tstamp may be after
> inet_csk(sk)->icsk_timeout whenever the timer interrupt
> finally triggers, if one packet came during the extra delay.
>
> We need to make sure tcp_rtx_probe0_timed_out() handles this case.
>
> Fixes: e89688e3e978 ("net: tcp: fix unexcepted socket die when snd_wnd is=
 0")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Menglong Dong <imagedong@tencent.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks!

