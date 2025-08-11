Return-Path: <netdev+bounces-212418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EC1B20263
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 10:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6017B16BA62
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 08:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D062DCBF4;
	Mon, 11 Aug 2025 08:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t/rtueEP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AB523B613
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 08:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902461; cv=none; b=g2wpQmGtf1Prwz3caYQ+WfUZFx+nlCHX0pcqdhoCk5QNAAQ4e6pibtFnV8N2h+YKbx9DGB2rvnaeFZH2VubC67VT6RVlOEPTDjFg5ra+4udmwMEDwPa2yjlveLPUBVpM7KhQcs6NB2YgaYMtXDy+7kpBDSGQfHZEyiDGOYYumak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902461; c=relaxed/simple;
	bh=+P8bhVOwv74YoOnMiIN2tr6EOCNywG2x3gGP2baVj9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6fay8I3B4BRn1R+h+sranFTjet9f4q4Gr3ei6lJiTl4Dv2Fj4f0NUeMnF+0FT34soQArXAfK3tX/6bR60eG9oR1FBlhihLnvnN9zz/y7zkGP69I99P3WntQUM2QnSTHSrf8aGQQA1f2zSomP5A48TnnegqrKKiRfkDTXMuqfpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t/rtueEP; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4af12ba9800so49979091cf.0
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 01:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754902458; x=1755507258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggBs91xhT5OGerz7WB6lsIzNIUixHqSJQNYCiUzD130=;
        b=t/rtueEPdSpOr6xdOCDOVwFFeuMs7KTFDvqcr+ymi/wfDWiDRPoo0dyH5f8ltC8iQr
         Z/zKrN62QUqjfJ1uQO9lLNLnDnTSFeEcpe8EWSEzmftsWC6DFFyfMXHAo4gjwnRQJM7g
         XDAvvgrzUHnKtIT8gWu5Rn+LFnr2Du5HN7jdTKvGx8wIGUQ3cGl2IO/MRK7Ok+F0La+v
         Z4+6JSmISTW9FA0IyFxHd2U5YaNY6aENWLOkgXEclwLnJhv099tYOzwTpEn5rTtDkyQv
         XRt23bLmN2flm7/88QtRa2groxNX7DOicRFAZkqvtLpnLwYmF4iqjuXmW3yPlLDJCnZ6
         xdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754902458; x=1755507258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ggBs91xhT5OGerz7WB6lsIzNIUixHqSJQNYCiUzD130=;
        b=KJjVCDKNpqvm7I8vpKJ03MyfYdFBiR3vRlLLjn4DZdJc8E2rqs6WT9YTrkK7JLC/b0
         z6RPVvmsO0c//ScDNACeeF86v3rnPxfY2gj+Dot5HkOBoZAIa0R4NnO/KdQQWwG0uSCq
         +vZcbTt0xxNkSG7lL9wF9vt+hq02/X/XzjlmKR6D6VVN9iOk2/SmLGnNwcjqSiT+bvxl
         6gDJivgJU71qiFAys8Q/jS207OomJg5UR27rl8VAxNQiREJlVm2OeY9QNWgvBM6Svcp5
         vfOizX+NBolayt0oEkh0sQi4jIFI+tnIg+fNm8qF1uF/bKb8i9R2eLVwSVmxblnXIIqr
         KcyA==
X-Forwarded-Encrypted: i=1; AJvYcCV8eOiimEtkes77qiyRZMu5HCOVJrFXNfPj43PXvObPQYxYFMNBQOsKk6dRShmuICLQG0fazgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYXfZEIuJK1yYwihtkcJ1e2bO5kSZI7c5Z+wJlVsmnJIxGSCCn
	4Ovy2fFhyDuq6GiE+3jWN/CaDdhmylYq18s6xeJDNKeKOSRjrG8fehiIQpHnMnEP2HMrJdnSoE9
	rZ/dcZGjIvC4/dUhv3qQfmOOMVQwT+1/XzC0wnekR
X-Gm-Gg: ASbGncsj7BtZVQFa6QduQ6D/i7ehTU6LFoCL4Fxjek+7acQCpvNEIGZOg2YPhWhQYGG
	inazgXNBJrOTDDdj1UiQgzYWSLHsoPe0vHH+xs1WDh1JZRtYa6bayKBqo/BAC1NDF5WVL8FAvxK
	jW5eKMyhyZN0mdB2LTO23WtIYPWELpzuWZH4sXpTvQ3jqMlngFdl3zaqn8KVqS9vAIyq1ax1duV
	csQS+CL+AFMs5uDHA==
X-Google-Smtp-Source: AGHT+IG89vGodbMDduFmWXYAKYKFluMW/TUv1KNzoncPyzwA4Ywx0KGrdM0+oGpLbFz8OgPt0cdJzwZZzvcsfyGaDmo=
X-Received: by 2002:a05:622a:5587:b0:4a9:b1ca:9fe1 with SMTP id
 d75a77b69052e-4b0aec59430mr156307251cf.12.1754902457392; Mon, 11 Aug 2025
 01:54:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250810072944.438574-1-rongqianfeng@vivo.com> <20250810072944.438574-2-rongqianfeng@vivo.com>
In-Reply-To: <20250810072944.438574-2-rongqianfeng@vivo.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 11 Aug 2025 01:54:06 -0700
X-Gm-Features: Ac12FXwqVWBo7ThXFkCkWpYauhWAWMYvv5F__fjkB3vLi2kEx3RFoeqxwYzI7ic
Message-ID: <CANn89iKFbfNvKWa=yrPnfkTdfEo-xS-9TfE6ThgZF8MATU0Cmg@mail.gmail.com>
Subject: Re: [PATCH 1/3] tcp: cdg: remove redundant __GFP_NOWARN
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"open list:NETWORKING [TCP]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 10, 2025 at 12:30=E2=80=AFAM Qianfeng Rong <rongqianfeng@vivo.c=
om> wrote:
>
> GFP_NOWAIT already includes __GFP_NOWARN, so let's remove the redundant
> __GFP_NOWARN.
>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  net/ipv4/tcp_cdg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_cdg.c b/net/ipv4/tcp_cdg.c
> index ba4d98e510e0..fbad6c35dee9 100644
> --- a/net/ipv4/tcp_cdg.c
> +++ b/net/ipv4/tcp_cdg.c
> @@ -379,7 +379,7 @@ static void tcp_cdg_init(struct sock *sk)
>         /* We silently fall back to window =3D 1 if allocation fails. */
>         if (window > 1)
>                 ca->gradients =3D kcalloc(window, sizeof(ca->gradients[0]=
),
> -                                       GFP_NOWAIT | __GFP_NOWARN);
> +                                       GFP_NOWAIT);

Reviewed-by: Eric Dumazet <edumazet@google.com>

It is unclear why GFP_NOWAIT was used here, while all other TCP
allocations use GFP_ATOMIC or GFP_KERNEL.

