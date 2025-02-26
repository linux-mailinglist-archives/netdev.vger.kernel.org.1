Return-Path: <netdev+bounces-169801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B61A6A45C05
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 11:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D857D7A3CC4
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 10:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0E41F4177;
	Wed, 26 Feb 2025 10:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nzjmgwPX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709FB238171
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740566398; cv=none; b=tGcS1PCfkjR5DPeBJeriZ1hqcNzYCvdLVbtC9UAMs9itgQtOaJLr8lpgXh1P8d9PmcxKljEt/hi7cfZ0upmly/XuRQUBju/Co60qGh73oQioy9YuevhhCa/k2P3AiGSONqoY372MQO+hxvSqbwsT/RiJD/yJbuQJPWmlxTfqiQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740566398; c=relaxed/simple;
	bh=C/ZP0f2I4/Y22UaJ++eeovNNOVlEIpwa2/TBsiZ88YY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRIsttNHGditnsQ8B2t8cuI3l3Kzt98r947b2YaiwlWndXMOc8R4bwZ1t/2jXq4vbijcfIdni3zqZS388OelXLt7K7CHI5EFZBxADEAFH2JBpRwK65kS61s3v1CpY4pgt19fWSKKadSwj98vCrv8WC86FLahrmCRFWdxrjcWgSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nzjmgwPX; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e04064af07so10585836a12.0
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 02:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740566395; x=1741171195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/ZP0f2I4/Y22UaJ++eeovNNOVlEIpwa2/TBsiZ88YY=;
        b=nzjmgwPXrxdj5q3xVOfCxN8x6D6GQFIqBs2U531d51BoFnP7u8syVnxpu+eX6pid0+
         uJfdce2IRZtGuHpzvl6dp9POw64zMnkzjKUS5L4MuVNc+kV08a3Z4VOqAufbWwLqCSy6
         XbzBXYiC2Tt6ZwG9hNW1kc2BTGOouEjgI+EMXWRwYFcPctMbE/TmHiD/8bOpVKGtZRXz
         sUqGnUjCHWC6/QxAKZP4EduvLmryJYCAXirlXWxboafdWBNJ0SyH5VfouV0dqohVL1L8
         8X2YJlIkxGewpt6HgIim2koi6jIJZuyPHBuW3iydpo/Sp4cQhe9D0pPFxd41BiUSzxet
         lhtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740566395; x=1741171195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/ZP0f2I4/Y22UaJ++eeovNNOVlEIpwa2/TBsiZ88YY=;
        b=hpBpkM/BIUup0b+99J/RZxBPNwq0H1YRP8IRHLmJFQWV2tNLxpq2vXTGwvMNu0CSzY
         uZo0ZECi4515+rDtp0keww2Wala+yX87yD6DSS7p0Grk2HIU3Avbje7yG23QhR25HcYZ
         PHaH6hrEWZH5lHZohrCrGCvo30HP3eIqiHSweAL9tgp+r4kSsQU+nO5vbsEpVE2olWnB
         zGZZPwJ20OhgtiHBR2u9rDP31WcXaiWGApEoKCZaOlUyogiXC+0dzZXt1EaYYtCz+ccr
         E+MLphk53OGae6q+qH8HByVklvK5nkrcBb2Fza77eVyoatSrcUR9yh/I4tR1Wub4TFtv
         Je3w==
X-Forwarded-Encrypted: i=1; AJvYcCU40UYA+VhWqJKrc5HpX+jhJboKV6AQPDNYpSg7G58Q27eAnDXsVFVu8jWjsk6gfpbdVb8Vbvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlHMvg3/nPhV56DRcgweeYepm2AUPLI+YMpbP4PWvQUIcdCaDi
	YQMnf2nGhm0GdcK0UwPA8Azv8h/oq89gPZghkPxtHMZr1lWQBGgbPsUCaz6qgd8MOoFVxirdOlS
	yH45dRQz4UtNLmczFSpJVoFGOtZiP4EFuxVw4
X-Gm-Gg: ASbGncs5Sv3C0bdydkefoiGTtv4l0+yZm8Ov8dYzcxE5q7vqKE1A4POtpq8sLX1U7BK
	w3FWyDV88OZRdV56X3kabN54iQ9Qr/ztnsOIlwUfws61uC3rstZDXH6nqqHySJVfAOruz6ZxBQl
	1xtNqMR1c=
X-Google-Smtp-Source: AGHT+IHG17ZjuBRF5Y0A8pIVakBl5Fld1WcYtNFn9hF2y117sN8t98ax8m1RhWIhT3jbfvipcWbp0a+eWvG+t4ALuDM=
X-Received: by 2002:a05:6402:430d:b0:5dc:c3c2:225e with SMTP id
 4fb4d7f45d1cf-5e4455b6f34mr6137266a12.8.1740566394678; Wed, 26 Feb 2025
 02:39:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225182250.74650-1-kuniyu@amazon.com> <20250225182250.74650-2-kuniyu@amazon.com>
In-Reply-To: <20250225182250.74650-2-kuniyu@amazon.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Feb 2025 11:39:43 +0100
X-Gm-Features: AQ5f1JoUdkESVFsmwR_ykwxvbu7HLarwuFmB2UnUvn-Fu6VJ0dJc4f9r8z1bHe8
Message-ID: <CANn89iLEjuaJnUoe2RGSGY8nHCrf+88Pe9BZAKm=emnB1z8EnA@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 01/12] ipv4: fib: Use cached net in fib_inetaddr_event().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 7:23=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> net is available in fib_inetaddr_event(), let's use it.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

