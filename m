Return-Path: <netdev+bounces-110904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B5C92EDF1
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 19:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D49A81C21622
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 17:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906AF16DC1C;
	Thu, 11 Jul 2024 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oe9j52uy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D03816D326
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720719496; cv=none; b=TR8Y7w821IE7BXtq84j7WMvOnA+ySNisDtSN70MaaSugumo1K8AIhc+nEX5bytdYLS0gEI9FlDQNCq7sX0reiNySHEFJAvBXdNd1QWEH0mPAJTntEh///hyIxdwix3DvakJ9ltRlVuRZ5pn0RciCsfVJTkISrqGUCw6WE2T5nvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720719496; c=relaxed/simple;
	bh=5Xgl+EcOjT7f93shPiHRMJ4pO5M75AEYdIGVDYwpN8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kHIhdy5UoT3o0eX0hgQ7gK11snnyGaLuyPnYBBIir/rQHGMOBv/u/3981Ev/B6A4QgzrVkdLG1WqsZUXgoIYR6laKybkElTaK0xF6ljjQOjGiutxtyu80+0GQFNBoUSkF0EqWY5k15wSZm8+gW5l86x6Rt7RWe3rJ+VsguxiHkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oe9j52uy; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso554a12.0
        for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 10:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720719492; x=1721324292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmi5HLcqE6fK5ySS3lyqzl4ypWFtv4L42PctvT1OoP0=;
        b=oe9j52uyDrHceb9y99ZhuiWajBBOOb0Vu5p4YsdN8JRq9bMms36Ydg9DebfagfNYFp
         2bb8egBjYqI+xW7EYeBcnd68Br5gRMChOOnv1uqkpO/NzNAN1bdURs9I1Ys8TSpUaFUB
         GK9K/LdgpHQT24rwAzYds0+QH0TmzpcXFL/v7MaLkVVEOTer+y6D3tDqGPyJCuvrEBY8
         XXCOUzLIJGfg8/lRf2OZr7daWAW25E/BcHRFh8ZBjgx0FxsEAfmQUDDc658XqYyVrbzV
         Xk3n+MfAS1xGB9VXYXXzajf/EM9AjqCa/EMP7xGfTCwggDaU48a3latx5Cg8Bu017uWV
         qMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720719493; x=1721324293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmi5HLcqE6fK5ySS3lyqzl4ypWFtv4L42PctvT1OoP0=;
        b=ZkG5/zUn0vVng5PZ+f5Sa3rGyqarkKyeHIJdjivjOrhEvc8+7N+So5s5K0f8Sd2gJE
         Vb34OLbB8XG9gXNwdPDzlKJudCU9m7OV1+/mcwu0l1FGf+fL46HuSnhLgwc/Y4G6z38c
         CUl7bc19McmwyGoD5HgSnDvDf1rkFhvbN+ap4rn5mMrhJsb6AlJYjC6DLWB/F3rAofuj
         n+4MJlbFHmVNcUZj0Jzvq28F7JNx0rodVeHlckIifuwbuKzEOeSPk+e8RWOdnzt31zWc
         2OSzps2eLPXQiLvsUKbXZt1dQm7/HPLTHlPR1uaqcFrOuP05L87yaU4snC34Fmpo0vPy
         rv2g==
X-Forwarded-Encrypted: i=1; AJvYcCXNBZacotGUuCu+shZRICCu7w02DLvqcysnIl0eKR11s6UwKmmhH8wNDdyVbnsNtyDhx4UCz9SrYlg1SgGq16Jdk0y2bjdn
X-Gm-Message-State: AOJu0Yy3kxzv6G+WRoDtKaMbUdAUZweoKIWsShRmci1/3AoBBlYr42UB
	Esd2UyVgZ0g2jKA9fZIbuTYJrARKtnbuDmP2J4pduEPAkzoOyby4TXn6cGvsmzma47T0cYuDiy+
	NSfEsMOhG2HH4pdpRvSvI2tfJL3++FiNfl/t7
X-Google-Smtp-Source: AGHT+IH7ZVeKGtFW1ffbCmLAUEv4AqAX1Zjzfy/SAWoRHxzSGzNdtgnfN009pJNeMEQH46pIXGbzCkhrPdNrgHUru00=
X-Received: by 2002:a05:6402:51cc:b0:58b:b1a0:4a2d with SMTP id
 4fb4d7f45d1cf-5997b09fef9mr1782a12.1.1720719492339; Thu, 11 Jul 2024 10:38:12
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711171652.work.887-kees@kernel.org>
In-Reply-To: <20240711171652.work.887-kees@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jul 2024 10:38:01 -0700
Message-ID: <CANn89iKqZD68w1QtM3ztL_X290tj_EGyWRvFrhyAz-=T+GkogQ@mail.gmail.com>
Subject: Re: [PATCH] net/ipv4: Replace tcp_ca_get_name_by_key()'s strncpy()
 with strscpy()
To: Kees Cook <kees@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 10:16=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> Replace the deprecated[1] use of strncpy() in tcp_ca_get_name_by_key().
> The only caller passes the results to nla_put_string(), so trailing
> padding is not needed.
>
> Since passing "buffer" decays it to a pointer, the size can't be
> trivially determined by the compiler. ca->name is the same length,
> so strscpy() won't fail (when ca->name is NUL-terminated). Include the
> length explicitly instead of using the 2-argument strscpy().
>
> Link: https://github.com/KSPP/linux/issues/90 [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> ---
>  net/ipv4/tcp_cong.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
> index 28ffcfbeef14..2a303a7cba59 100644
> --- a/net/ipv4/tcp_cong.c
> +++ b/net/ipv4/tcp_cong.c
> @@ -203,9 +203,10 @@ char *tcp_ca_get_name_by_key(u32 key, char *buffer)
>
>         rcu_read_lock();
>         ca =3D tcp_ca_find_key(key);
> -       if (ca)
> -               ret =3D strncpy(buffer, ca->name,
> -                             TCP_CA_NAME_MAX);
> +       if (ca) {
> +               strscpy(buffer, ca->name, TCP_CA_NAME_MAX);
> +               ret =3D buffer;
> +       }
>         rcu_read_unlock();
>

Ok, but what about tcp_get_default_congestion_control() ?

Thanks.

