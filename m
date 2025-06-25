Return-Path: <netdev+bounces-201266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D640AE8B35
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 19:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 512607BA55F
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 17:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EE02DAFB5;
	Wed, 25 Jun 2025 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YhsQJ2l0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629842D6613
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750870487; cv=none; b=LCFRGUhxtX7UiEVdoys8hiBrTaItXMpiD6wiKMsmSCoCMseUV0l4qr51FaDiZdyp+mtTbuYZZzIwiMVU/QFp6o4KzVQnCSfr8g4aLrQyTrrwwH6B2Fo4ALmQFrmlqNE4G8JNuWrGfeaI+SaijF7Mj8d85v1YGc2/Kh5gOKo8vbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750870487; c=relaxed/simple;
	bh=lBDbDMqM6EzL06NdbJFJ7I/PhA09JDo2Zq/svCi5Xr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MieGs7680djtlxpz697gbZjGprOVQ779kqekkOTMkBURMlIRP/4o9wrN3M5ZUZIo4KSue8AqaIBS6qjR/3VJ24mgQ+K6mmx0GkXfV+izqnJtE+PzZ0tX5roTspIo8RI8Ppu4BGdIl5WtLyHRY9aLxuInT1Ah2iPVdcvaqHaFUXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YhsQJ2l0; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23508d30142so2157485ad.0
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 09:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750870486; x=1751475286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lbj/LroNXpAiNEpwMzoE137rEOQVWGByOHdjSXhauBc=;
        b=YhsQJ2l0jRZo3jh0qVxdxCB1W4AUkoRKrMaWKarhpXuLuMtVWH9PmrUWc2LBxXjY9L
         c7qDxvjcKTMfw3zYZM35GBp0+E0p06hQtGsmnWwwDEl03y0Nzs5L6dLCUemzsZQOe36/
         AogGgjY7X5Aj7Xs+RkRL/J+vlcINhGTU+JsuPtseNvW+ojHNLnbfSoLjy8AlTaXYzOXs
         FKA6g40yXzNZl05wnouJFPcjuiIpRcAGTRefGe8i5RQDa7iZhh1PsKjD1p2wikGKSLSx
         MqLg76pyvnKg26uiOWpfK1yFIZBt3EFc3vZF2/aLIDZceWzu99QbSvnS7PzouUZU7vry
         WnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750870486; x=1751475286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lbj/LroNXpAiNEpwMzoE137rEOQVWGByOHdjSXhauBc=;
        b=E48PjIZT9hZtT2Yf+HGlTIOca974eK/WQ/iq+TzcfnCiSNTIE50qcVsbE2e/3JFBuL
         oSqwcaN8FibvOr1/FS/sG+oJTe0KZj7dEPj47X9WctdJeWzWttOAHywRMjhdkb6jnlTN
         S25BDMGatKXFht7xDmHwvpGTXfvnxIkAoWK8xkBvrEoHoLlQIfT/2aMMG8TMmVAuL8X7
         gncFSdcO48kaHPdt0aqa0dl5hZTvWf2/kgsAEYt4kWmtF41J4UpgBwG8IJzKGVCWUWJ5
         X2MqBuDQ7gReT5FNAfnlUw7F11v4kDLNqGwLM8UvdXZpjEb+acHHY522IqF5hKoSsJ4Z
         OV6A==
X-Forwarded-Encrypted: i=1; AJvYcCXYe02qjFLFRye4pxg9hqYb/F390+Nl6AOsol6OxF1gXLfsEmewq4ZD5a2vvRYDjThi7nSauLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQmih2wAFR0fMHm4J1w8DPzbU/tsDK7jNQAs6qj7afhmVxmWrx
	36DAJqpvyu+r/QQjLvpJ17RynlQDHK/At8I+fb/ZmSFOLCcH2EyWA8N5PBW0rq1AkP8cIvxVPNZ
	LXIp2YhSYpZe1LkNfnyINjgllBx9wGstweiW4CBHv
X-Gm-Gg: ASbGncsO/Io+RuQYarNcfSfsQXLs8LUol8Fqtyj8St0l/EQknBnPYB9+E+iB8UeWDfe
	Xw4PRLnmqjzHKpzmuXEpeGKME6Fq8dQ9Fjr+nPFIxHKAfJNtO/XUVvOdr5RmixXLk+7O79BkQJZ
	XMCLtlGybvfbVPWFyo1lFEtOTm4xOSqk+xbcc0xgMXfRYq+kMjrcXC8kjLEYAYlTd58dfX4RZY1
	w==
X-Google-Smtp-Source: AGHT+IFeKVnJc6QCJRGr4OXWCNA2tz6fiMAs4n7uMIeZzjA/074WnKl5a3SxBaJVxigg2QbFJcxfRws/j/7Be7l3uOQ=
X-Received: by 2002:a17:902:ced2:b0:234:d7b2:2ac3 with SMTP id
 d9443c01a7336-23823fdd767mr67312345ad.20.1750870485515; Wed, 25 Jun 2025
 09:54:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625022059.3958215-1-yuehaibing@huawei.com>
In-Reply-To: <20250625022059.3958215-1-yuehaibing@huawei.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 25 Jun 2025 09:54:34 -0700
X-Gm-Features: AX0GCFv9Cs91WMz-ure16jB1p8mN-vn8sTtVBHtyugFOPzB0BkM1M4E2a9WhqYM
Message-ID: <CAAVpQUBRj7dcq2yPQ+0L7b4piPXAxzmgD9zKvm_n_+mZ97egOw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] ipv4: fib: Remove unnecessary encap_type check
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 7:04=E2=80=AFPM Yue Haibing <yuehaibing@huawei.com>=
 wrote:
>
> lwtunnel_build_state() has check validity of encap_type,
> so no need to do this before call it.
>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Next time please wait 24h before reposting.
https://docs.kernel.org/process/maintainer-netdev.html

Thanks!


> ---
> v2: Restore encap_type check in fib_encap_match()
> ---
>  net/ipv4/fib_semantics.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
> index f7c9c6a9f53e..a2f04992f579 100644
> --- a/net/ipv4/fib_semantics.c
> +++ b/net/ipv4/fib_semantics.c
> @@ -625,11 +625,6 @@ int fib_nh_common_init(struct net *net, struct fib_n=
h_common *nhc,
>         if (encap) {
>                 struct lwtunnel_state *lwtstate;
>
> -               if (encap_type =3D=3D LWTUNNEL_ENCAP_NONE) {
> -                       NL_SET_ERR_MSG(extack, "LWT encap type not specif=
ied");
> -                       err =3D -EINVAL;
> -                       goto lwt_failure;
> -               }
>                 err =3D lwtunnel_build_state(net, encap_type, encap,
>                                            nhc->nhc_family, cfg, &lwtstat=
e,
>                                            extack);
> --
> 2.34.1
>

