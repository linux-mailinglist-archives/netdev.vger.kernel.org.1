Return-Path: <netdev+bounces-151112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2D39ECDB3
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 14:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75ED8285860
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 13:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF032336BF;
	Wed, 11 Dec 2024 13:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="omDj3KJs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50647229149
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733925221; cv=none; b=fzyievx8H/Pp3HV6RI5VSCAtILjhlzNcqat4RiGTrvEvJvqu1FJub6EqXK5mtixDMZ6YAs8p6ZSmt29U2F/ecmDfd7RXYVM4a3+8/IiUodsG7w7b96/Ei9whh9vEVyjciIFSDH1TmPEjahAW8EbSTYTnueAMPqYA8/LyXm8AEKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733925221; c=relaxed/simple;
	bh=1ler+6t5wwhzmcNaLGwLWs8a2MX4ASG3Zvx3gT94VPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lYF1pgdJATJAj3VRB7YxP4ZkYFh/MsVSfyJROdsklIbjINOFDYZwGKqT7ueoSXzg7kmg3lQdvO6viADhFxzRYYiVsSPCdMGz6yKjlnGUYX6mWX1LFbZiY7mCUmNO6+oLdx94s7BCsdelREg76SWBuJVaAj9ytC7m5xgYhtBTVkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=omDj3KJs; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-300392cc4caso45046881fa.3
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 05:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733925218; x=1734530018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyglwL7lcLajD1vfvAC6TyqBHbq3YqYRZog/vZd+lPo=;
        b=omDj3KJsPkdP7UDkEBkr8I8BmUFjLlncQnR8U1KHRmWs4eX2Od9WNA0Ge1slgLs74D
         hYp6a4U1CyacZbInWvPD/TL56ag2IN1BQUOKGZ24bAQo1knFloHJGpw6RLyKLgMI/Ich
         FQ/eIr5U5m601YqwpLL3O61FD+9kURKiEawOMu3v9ORmtUW1sFkB3D9mopTziG+ajVix
         8e0RXBaq3HeM/bK2ndvdwgZ4lgGxZ7oVSqCK3Y6ZlazYDPlzbcUJuk9BnvualA6K12vy
         36remNoOn6ih/pluAhyQBzIt1XF6dN0GBvAskyEvdi7SBuoKVEa+r0ga5WUGsgSibr6l
         nCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733925218; x=1734530018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyglwL7lcLajD1vfvAC6TyqBHbq3YqYRZog/vZd+lPo=;
        b=xJkWcOZ/nj3gj6kZ0hEDSQ+LUwDCPAveLNIzHDlZB/1G1t4EvcHZq6ZZlIppfTrQaC
         qMA3m7ld96Vh/EIXVwjS1PCVj2l2tPFaCdLWQgGwKLCIcSDxJYUdU38eii5CLKd022cI
         7juQ2EcK6iUKzZER5e0cb8OgufuIJF9xK0iupp4Etp2A3r/UKq7iE6S0xE5rzwYDUjQK
         82T9yLQJp8NT0idItca3V+4khdDSoUEmjvWeyvKktWM/2KnUUq31uvifAN5/MHIN/PaQ
         shdB9vgXc/qtM1fSLHP5px3PtOyK2x69E//SRJAUwb47vm1CW/c4Egaa8ET3OkU03oJW
         FHBg==
X-Forwarded-Encrypted: i=1; AJvYcCWDtKCYk/X/VZq5QWrSRVpP9uBcEeg87FNVZxlYGpTPekkqpmsQjgNvtnzWHwaTd99nDjsRisI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLTdvII6wxgPutbq7aNu2x0eO3lJZ0FMIdEjF5M1paAEJlP3dU
	6ZJdMFQ8fGS2VrKIZb2A0He3Ly+EiITJ+ZDGBg8bGEaaciIesOgp3KQvygBt4fYHYNorn3JNXn6
	o49zCs1W6Vor0g7u4j0p4qGFwM+8b4rgWotXAFQ==
X-Gm-Gg: ASbGncuLXpNnkVaEVvlRYlzOS4AyRj2cjZ8VGmO7tYclyIDN//428m/H41W5DqkknpZ
	G78oDn67rbL4u9g1E0W0t64sDhi+kZuFoJm02+Zt+QvCgqWpgCE2ty+OqImUrcaYqDj8=
X-Google-Smtp-Source: AGHT+IGPGpFba0wsi4op1Gj+i5/QGCDpVBGPrx3rA3uLS79Kse28wu78qqyJ+hwtxlmidsvWthwfkHUhBW/gtPRZ2IA=
X-Received: by 2002:a05:651c:1542:b0:300:33b1:f0d7 with SMTP id
 38308e7fff4ca-30240c9fc57mr9357831fa.5.1733925218339; Wed, 11 Dec 2024
 05:53:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1e0cf09d-406f-4b66-8ff5-25ddc2345e54@stanley.mountain>
In-Reply-To: <1e0cf09d-406f-4b66-8ff5-25ddc2345e54@stanley.mountain>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 11 Dec 2024 14:53:27 +0100
Message-ID: <CAMRc=McCc3G4D4rHVMfGBTdvi6z5Nbxqzg+k8iN11+vazffSnw@mail.gmail.com>
Subject: Re: [PATCH net] ipvs: Fix clamp() order in ip_vs_conn_init()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Julian Anastasov <ja@ssi.bg>, Simon Horman <horms@verge.net.au>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, linux-kernel@vger.kernel.org, 
	David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 2:16=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> We recently added some build time asserts to detect incorrect calls to
> clamp and it detected this bug which breaks the build.  The variable
> in this clamp is "max_avail" and it should be the first argument.  The
> code currently is the equivalent to max =3D max(max_avail, max).
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/all/CA+G9fYsT34UkGFKxus63H6UVpYi5GRZkezT9=
MRLfAbM3f6ke0g@mail.gmail.com/
> Fixes: 4f325e26277b ("ipvs: dynamically limit the connection hash table")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> I've been trying to add stable CC's to my commits but I'm not sure the
> netdev policy on this.  Do you prefer to add them yourself?
>
>  net/netfilter/ipvs/ip_vs_conn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_c=
onn.c
> index 98d7dbe3d787..9f75ac801301 100644
> --- a/net/netfilter/ipvs/ip_vs_conn.c
> +++ b/net/netfilter/ipvs/ip_vs_conn.c
> @@ -1495,7 +1495,7 @@ int __init ip_vs_conn_init(void)
>         max_avail -=3D 2;         /* ~4 in hash row */
>         max_avail -=3D 1;         /* IPVS up to 1/2 of mem */
>         max_avail -=3D order_base_2(sizeof(struct ip_vs_conn));
> -       max =3D clamp(max, min, max_avail);
> +       max =3D clamp(max_avail, min, max);
>         ip_vs_conn_tab_bits =3D clamp_val(ip_vs_conn_tab_bits, min, max);
>         ip_vs_conn_tab_size =3D 1 << ip_vs_conn_tab_bits;
>         ip_vs_conn_tab_mask =3D ip_vs_conn_tab_size - 1;
> --
> 2.45.2
>

Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

