Return-Path: <netdev+bounces-214266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CF1B28B36
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 08:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A1E73BB698
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 06:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161DB2010EE;
	Sat, 16 Aug 2025 06:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nQ4i5lbX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697AB3176F0
	for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 06:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755327306; cv=none; b=Bg8fASCAZ1VSNtCCuqUDiwArTj1R4STBZHL+eWsMVBTf7gQ68Bp0uJrezSi3znw3TzvNcadgNumHNYkA2Y0znNoR815+RE+YgTmuRfOiabhMnVUvxkiMLZ5j1PnFM++2LHG9pZSu2XWOJosq8SxAinJiezwJO8cYlfuAxZwymP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755327306; c=relaxed/simple;
	bh=/F+VLR4k/VQa/W7G7e4mK7Tt/KybN6dnMhzKfl7uavc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HUb1IdGXCxkW1o1lcdEfGKpPAyWuiNPADBbnF9XhFOpKHSa0W+esFe63pkE8Po6MkS46GpX0eE60xV9hqWiZDrGcASkdzBcb98fjGNN2eo8wnhiKqBx5tSlV+5GMzUPZhhA4H3uKtjUC096V2hWl9UfbFfTRoCoBJOuhBv0cWuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nQ4i5lbX; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b472f0106feso868756a12.2
        for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 23:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755327303; x=1755932103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+roC/3kZ2N7w+PMio3Mw9lCc2kYfnFQheZWp08VP6Fo=;
        b=nQ4i5lbXMmRhAE/G2LrZfqn0rWfNWFQbVj30LZGZYq+XfEL4HzK7vv1OIsg/3a+5AX
         XfGCoZZoEdQlM4tc60K7RcZuH/Fmun2ZM+CCJ2ivk74Dz3qj9ObtborntzZFT95EWFPj
         XGTv5VPc9jO1uY7pVu87TsNX+kclGPCPM2IIPslZzr6YaCr4yuDCsU4iL0hf0o1GOk83
         pNoSlD4ozfdxVPf+JJ50bwiW9UY7ZNlLsKdGFoMDuylVDq621BRiP1GVePnGmESwVNFU
         ruqVwQV18XhJ/RelzoMzEiZj67Y+wCnLB1gz5g4CAQ8xyFSDglAxEhYIMLzNhF72ZH/k
         f5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755327303; x=1755932103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+roC/3kZ2N7w+PMio3Mw9lCc2kYfnFQheZWp08VP6Fo=;
        b=UKdhUce3E2eC4JjXAbZRJuhl2Qw6tPjMWxj2PZ9pQmtmsVj1GG6Ja4g0mvp5x+aNsK
         KwaO1zPdGVXpIYsctYbLMA0UnR10Zbf2DoUpzIjnvFtsEkpgsHR3J5PTFm5Csdnmchrl
         pYVf2GR/+MiUn+NtURzRbQ/XjUyAenXdE7LkmVrrujHKMCTxKFdrcYi8J0rO6q0VS3gZ
         gkAP3uKd0WbzsFAsh3A/o8Z8gjlrGuvkPEl+eX56r5LYwAKuPbz2+rzDcrJEd6/OOHjL
         lf5SY5JaZVLIeiUiTRnqHO2eeLNe7vBEseTKuxMXjmpVcpYD4FCiRJdbWQuzqqALmV92
         fEPg==
X-Forwarded-Encrypted: i=1; AJvYcCWavRtqRYCtvi4M7idZr/5WlDdfrhg7tL+3Fe7XgcepJH36ChA0yoWa9G+GcVoql95JWDEfmTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAIm/Yq7lEsrjDzJ7Z4yud9gaNiikGUP+b2YYjSLuNd2wa1kdM
	97uyc4FBhxbksm3EunwYh7AoNW7SdsLldj1BkaicvRuAB14DENEvfrR69X+qrhjZgkr9dvKVlX6
	S4wEONWSo3b0mcm+ZsPuKAapOBBvn2pQ1n84CP/12
X-Gm-Gg: ASbGnct/dyUQ/zjU7gdZVokczvU6X365ySGeF+r6b0F0pw8zagKgKA3MM11pc0drpRU
	LY84PBprzz0VLcVhoPRESdJAB3iZewPOFX+v0W9ZPStJSV6BagTOpxbZb60cq3oQr10hiTAJnfi
	CjkxBYwv6AIbat5XCrPvC2HFVZoKIJ3jTj0SOWSjYEselIbUdeZreRppX8GTJAng9ZNU/kyxOwP
	w7r1VgEy1BorkQSf+ItRIHQIyRNG/PvcmtA4cCpotavqkammaEWXR6RyQ==
X-Google-Smtp-Source: AGHT+IEMSA24bd0diS0sQYr20cbIkI0J4iGYKyH2mU0FJoJ7HQA4OvKP0Qg3cveqUerOQhUmDDsmSsfyd608LPwwrjg=
X-Received: by 2002:a17:902:f54f:b0:23f:cd6e:8d0f with SMTP id
 d9443c01a7336-2446d71ab4bmr70555295ad.13.1755327302534; Fri, 15 Aug 2025
 23:55:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aJ4FUauS-3Ymarop@shredder> <20250815063845.85426-1-heminhong@kylinos.cn>
In-Reply-To: <20250815063845.85426-1-heminhong@kylinos.cn>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 15 Aug 2025 23:54:50 -0700
X-Gm-Features: Ac12FXwZyGYXEIwMUpsUzF4a8Iww5pU6O2PEKL5Oev7G9TdqLt1QMJCq7MTRFsg
Message-ID: <CAAVpQUACaRY3gW1W1rBEFkYJxeJfVpL=BfuSv_99D7cqr-G6nQ@mail.gmail.com>
Subject: Re: [PATCH net v4] ipv6: sr: validate HMAC algorithm ID in seg6_hmac_info_add
To: Minhong He <heminhong@kylinos.cn>
Cc: idosch@idosch.org, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 11:39=E2=80=AFPM Minhong He <heminhong@kylinos.cn> =
wrote:
>
> The seg6_genl_sethmac() directly uses the algorithm ID provided by the
> userspace without verifying whether it is an HMAC algorithm supported
> by the system.
> If an unsupported HMAC algorithm ID is configured, packets using SRv6 HMA=
C
> will be dropped during encapsulation or decapsulation.
>
> Fixes: 4f4853dc1c9c ("ipv6: sr: implement API to control SR HMAC structur=
e")
> Signed-off-by: Minhong He <heminhong@kylinos.cn>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>


> ---
>  net/ipv6/seg6_hmac.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
> index f78ecb6ad838..d77b52523b6a 100644
> --- a/net/ipv6/seg6_hmac.c
> +++ b/net/ipv6/seg6_hmac.c
> @@ -304,6 +304,9 @@ int seg6_hmac_info_add(struct net *net, u32 key, stru=
ct seg6_hmac_info *hinfo)
>         struct seg6_pernet_data *sdata =3D seg6_pernet(net);
>         int err;
>
> +       if (!__hmac_get_algo(hinfo->alg_id))
> +               return -EINVAL;
> +
>         err =3D rhashtable_lookup_insert_fast(&sdata->hmac_infos, &hinfo-=
>node,
>                                             rht_params);
>
> --
> 2.25.1
>

