Return-Path: <netdev+bounces-195491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4B8AD0770
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 19:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91312165BAA
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 17:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FA428A1F3;
	Fri,  6 Jun 2025 17:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Av4sINpB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E0B28A1CB
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 17:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749230665; cv=none; b=HoZW7L/S0jeaxs7aJ2AeFqFNdqNXemJbuQC/628WCgMCEHfNqcbn8RXbNUqIhGzP7BKkPhEgRbuIqUUZqARJY1IUr3aXzrnClP2flasLh7Aa9rfWELp6dJzNnerEYxfmFd6/lhiVbttTAiO+GG28bk2+SuUQNjAyt8SYCGrNJQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749230665; c=relaxed/simple;
	bh=bQ38KmJJGmrTHb+zulrc8zCiYNFdsJC1EbUj/im5B5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dxhnj1nx/KuEcoA0LuU+M3xN9Ka5utd6jS8wqz+INU2iD+0i6bfyhCTF8NF2HzUf/UENlbxlPZmRQndH0KFTuClIYaVL9T9e6CpsJzTGhAPVSWtnXaCLnLIf+r7ydVMnaSu1zT5falFtaGoGtOR5NxlWVtEIqcQUC072sathHYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Av4sINpB; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a44b3526e6so28540411cf.0
        for <netdev@vger.kernel.org>; Fri, 06 Jun 2025 10:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749230663; x=1749835463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffCo5dXVRroZvzAAAAZg8qxWZENQN0EkOAHPkbaNFvQ=;
        b=Av4sINpBVqXQisVFvHxtHHqmyEnAz41xocVe4df71I8GPd2jENOouVZ3SgZNdDvMls
         0XvsuMj7D160h7Vj8XQGzn4Bgy3XyQBC7Fm1Hw/uTtUrAg0OqaWi9v/o3amPn0oouXoI
         6L1CpYN/dCd0jAeY3zG6dYu1Slszb0BaGUchD4s3G1luhvZYE5dUogYC7ovhfpaZMBsR
         sfEpJAgCWb41bfuXQ+PW5oWJ7JivIZIZiqKf+TcxpvyqvBAuAFurREnZQzuIaMahLEqG
         31FP+ZoGxx6exroJcR/Wv0U9oqv2p96KBJIM3Q8reVWK7ln+wO6WnbCW80jenLY5kRok
         8NSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749230663; x=1749835463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffCo5dXVRroZvzAAAAZg8qxWZENQN0EkOAHPkbaNFvQ=;
        b=wXtxkT2+NLcDxZ3VyOgXQkwNF/T/QRCewEPs6ZATMwD/0XL99zPF9wb+TeF49orQs/
         YPGXQ5+rxeqykv8wCTGOnNbFGXRgPgt+/UYQg8CLQJPk37tNtAgiT2i+z3ogKN4IrAw3
         OST1dbYGatLCyKprTjBjqolXjy3sqOIMi2LglI0DNfWaGja0n8qoS0Kg1BkuwJfmOqPH
         m6yxlE7JLrpajIFX6XSByBrNxQbXXDdyWtu5H4dMP9kNFatnweLhHJwsgssragH7uKik
         xbYKPd9RPgw5ZI500DQEW/ddg0v/FW7rDt+k/CdeuybBQi7k5ALsEq6uSkLuPPuQQjb3
         CBtw==
X-Forwarded-Encrypted: i=1; AJvYcCXc4x74GbrLk1BUxr2uB0apSHZ1d+krrurV8vnMVgrviW+76t5fYDqiTu44ZzhNwclPvHtCYYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXJ6xJc8lkuBXxaqK/eFTQ2UQdNCIeSC2Qew4/bPdWxyvpNgem
	mvotson+/xkvAXRk4bGecEcQmH+VCCS2jXBNXX2LVCFbjSNVFML9SHOozr1ksuuvM+Vp4fz+Dg2
	UR0cLFJtPUexQ2EQVjvWdtZPlReeChfVPqZVC3oac
X-Gm-Gg: ASbGnctrVKpTv118ixac2xYOXZBWuvH0tI5WiuEQ7mM8gCvGnH1A94UIlGFhBWyFOSm
	OBzPz5AWVwowVU75m4izI1KFfm1/kbnFeY/ucHQAlmCYmo/igGqqgGOVNebpHxCbddxwSMtK/1G
	G66XeS10M5JSbl4b6H8FRFDxbdB6ZpqDwx3Xnn0lnshm4=
X-Google-Smtp-Source: AGHT+IF0Nd7Gtw8FrLO2kv+YjD8srzAHi/Fp1In3ZGRb8OMlcA2h06J9rnpLtTHA8mC0F7fRGMYcXVXRQ5uFtMybiDg=
X-Received: by 2002:a05:622a:428c:b0:48e:1f6c:227b with SMTP id
 d75a77b69052e-4a5b9a47e1amr68167491cf.26.1749230662900; Fri, 06 Jun 2025
 10:24:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606162650.2063172-1-peteryin.openbmc@gmail.com>
In-Reply-To: <20250606162650.2063172-1-peteryin.openbmc@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 6 Jun 2025 10:24:11 -0700
X-Gm-Features: AX0GCFtdzy0SFiQsGmt7R159fBYswVNv7hbUBGBEp-VWTo7DjSeHnc3f_lZkY7c
Message-ID: <CANn89iLD8woPzgBcjetiUvFNp6DZQZRK9WTjr-Quz3BctyeKiw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mctp: fix mctp_dump_addrinfo due to unincremented ifindex
To: Peter Yin <peteryin.openbmc@gmail.com>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 9:28=E2=80=AFAM Peter Yin <peteryin.openbmc@gmail.co=
m> wrote:
>
> From: Peter Yin <peter.yin@quantatw.com>
>
> The mctp_dump_addrinfo() function uses mcb->ifindex to track resume
> progress when dumping MCTP device address information via netlink.
> However, if mcb->ifindex is not updated after each iteration,
> the dump restarts from the same net_device repeatedly, resulting
> in an infinite loop.
>
> This patch updates mcb->ifindex to dev->ifindex + 1 after
> a successful call to mctp_dump_dev_addrinfo(), ensuring that
> subsequent dump callbacks resume from the correct device.
>
> This fixes the netlink dump hang observed during sequential
> `ip mctp addr show` or similar operations.
>
> Fixes: 2d20773 ("mctp: no longer rely on net->dev_index_head[]")
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---
>  net/mctp/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/mctp/device.c b/net/mctp/device.c
> index 4d404edd7446..ddde938c7123 100644
> --- a/net/mctp/device.c
> +++ b/net/mctp/device.c
> @@ -142,9 +142,9 @@ static int mctp_dump_addrinfo(struct sk_buff *skb, st=
ruct netlink_callback *cb)
>                 if (rc < 0)
>                         break;
>                 mcb->a_idx =3D 0;
> +               mcb->ifindex =3D dev->ifindex+1;

I do not understand this patch.

for_each_netdev_dump() already has such an operation.

