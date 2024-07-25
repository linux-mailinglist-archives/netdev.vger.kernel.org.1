Return-Path: <netdev+bounces-112938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6364793BF41
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 11:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E9B1C20C27
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 09:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A0A198A2B;
	Thu, 25 Jul 2024 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I3JWQSla"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2AA198A20
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 09:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721900712; cv=none; b=RX/rr8yOT4XJVLXMdaer6rPP4C2bA3T8Pbqan5sOmsQKlEqCU+wbFLdYvJySBr/pGqwIxZCr2YORoa/J6GpI2h9fhjNKL2jWmgtncLvbbFT7wkWiJ2yArQEwmtXp7Ndba4/vvu1sskqV/8a4D6efEFISJtSkXfBLktYoIrVIZwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721900712; c=relaxed/simple;
	bh=cTGmVzxz48I8nx9ljE2V1sbWqEgzP1TM7ZccMjBT4R4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VJQhGWV8TEXRX/06OSaAobSoTKKY+gE4q6PmhIZCfbJLxAMcRNm0XaedxBHJRqlJ/xdK4q9jMWs/N6yG+Ie6pzXkh6Ztiqr6Tm2C86hRnjTNLtyaUlsOhAvTuL8fcKQo0pKXF9mBo8ZTjHO0R5jHu1BCT84WRA/QIREaAnTWmxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I3JWQSla; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso13825a12.0
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 02:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721900709; x=1722505509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oeGMhTbFu7+/JGAR3lcMYypAKm4OWpVaWyGrv2COnm0=;
        b=I3JWQSla3NA0zyS8Oky+F8CDbFcW+QDX5usRfG58P0Acpgq9+FGorH8nBlr4H5jUNe
         L36o4AVd4tkuJFkheIhBDo5qyr2Sksq8xrJ9Ylgf3WuqSWYwJ9sVdwRSi9lydw+JyrfB
         CHOSF+208Ug1Hxk2bDD6uGnLpF5caUQR6l8jMqNusrcGlZBAMpVKXkJ0/sqcn5lTTn5S
         y2MKoNFTQeuakFj8Ujf3l2DSof7qm/yN3gp4GOPj296VdyQQ9xZ5mPN+oKMPBpKyxm2J
         TtvicLAzTIzeZy9kAme64HNRbIXakibz2iTUhm2QoLuIL8A+XR6PdA7O24E0cxl/jw2F
         YFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721900709; x=1722505509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oeGMhTbFu7+/JGAR3lcMYypAKm4OWpVaWyGrv2COnm0=;
        b=FR+zESO97Qkfp+47KRl76WIYKyJPwWo2IGmjmGWSTYktGz7jdn3xeOnEn0ERuYXM7r
         7I81l3Tpv2fdxlc7n4XlLdkWJGFk689RAymwRIPZqAVRtyHf4GmNKaE3aI+iJLs10SXU
         62BwkO4Lpj+P1mg/n+nSnqdbSRwzC5LTvSd3L2PV7pvTueVkG6xeHc9JngM4ICc8/oUS
         yrSpBKwE+zEDNA3gR8k/sfG5ga4cYRrdbpjyuyrRjDmgXtxnRkx4yToJIH0Z5OxRgS2M
         cyJzAI4sxdD8wC9GjDy7T/peMP/F4X5glecTwlEv7BlRQkdJUZBftUNqNlZmmzqqWkmy
         HJqA==
X-Forwarded-Encrypted: i=1; AJvYcCXoRhfUhpjchbdloK881Y4aHycxzGHIQJHLamlCGNojCZih2fj0/3FZjcOI51kR2bwIpj/W0+58WsBThC7WhNmBt96NYXkc
X-Gm-Message-State: AOJu0YxctgRpkZm2RBnRAc85IiKVkI/O3+tBIC4kplI0xTYaR1jleP3r
	W337WKtnxMZVOus3H81Fp8ugaUWw4Q/2GzIhOPk1oD5YkzqEU9PDiCZIKUAg/40Z5xFwRr6QLIG
	W4zJF8awgwvNMupZh8Uhjkrq13l+gmQ74mVOeVE1LkA1TzpJQtw==
X-Google-Smtp-Source: AGHT+IF5a8GLUBdMM8rC+HXTpMcIfTCzxxUZDPzAmu60Ru/iLxOnwc1GzaQyitPVfaWGH4at6uRiw5oO9e5xVJGXvsg=
X-Received: by 2002:a05:6402:40c3:b0:58b:93:b624 with SMTP id
 4fb4d7f45d1cf-5ac2a3d8998mr198983a12.1.1721900709071; Thu, 25 Jul 2024
 02:45:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724135622.1797145-1-syoshida@redhat.com>
In-Reply-To: <20240724135622.1797145-1-syoshida@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Jul 2024 11:44:56 +0200
Message-ID: <CANn89iKOWNa28NkQhhey=U_9NgOaymRvzuewb_1=vJ65HX1VgQ@mail.gmail.com>
Subject: Re: [PATCH net] macvlan: Return error on register_netdevice_notifier()
 failure
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 3:56=E2=80=AFPM Shigeru Yoshida <syoshida@redhat.co=
m> wrote:
>
> register_netdevice_notifier() may fail, but macvlan_init_module() does
> not handle the failure.  Handle the failure by returning an error.

How could this fail exactly ? Please provide details, because I do not
think it can.

>
> Fixes: b863ceb7ddce ("[NET]: Add macvlan driver")
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>  drivers/net/macvlan.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
> index 24298a33e0e9..ae2f1a8325a5 100644
> --- a/drivers/net/macvlan.c
> +++ b/drivers/net/macvlan.c
> @@ -1849,7 +1849,9 @@ static int __init macvlan_init_module(void)
>  {
>         int err;
>
> -       register_netdevice_notifier(&macvlan_notifier_block);
> +       err =3D register_netdevice_notifier(&macvlan_notifier_block);
> +       if (err < 0)
> +               return err;
>
>         err =3D macvlan_link_register(&macvlan_link_ops);
>         if (err < 0)
> --
> 2.45.2
>

