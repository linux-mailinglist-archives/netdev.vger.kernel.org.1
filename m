Return-Path: <netdev+bounces-198794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C83BADDD94
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 23:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A1EA17B48E
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 21:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961FF25C82E;
	Tue, 17 Jun 2025 21:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d8kRfGIp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5371288CBE
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 21:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750194274; cv=none; b=c+xWX66i+O4/xO2BNDnYQRFkpdXUX/7jxfnh8RRvryrUhmd8rR4xcBJY9zwvNvVzcoGOIcsueGTx5A9tSo6A+y+9VEpSngK9V/n/PW1IkjlNJz10ReGhq8wP18IIsgyLY5x8cSgl7znaLvPQe9j20uprq0eQg/qeS5hv9cZUvXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750194274; c=relaxed/simple;
	bh=G7EyBO9aaixvVybf61PXE6lTfXuLk1htvEcQFvTJAzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t0oDa4/lL1XR4ErTJhx4DX0RddUA8FjM9iH1deqeqWlThG4zMrmr3BAvmFKTrUY/7uMAb5TmiivQLe1pzUMy9IYnRqCxFT45HA1x2RRLK25pPsiMV1V/zpoJiD/EUefi9ZzkJmNLNFcr3JiRn20Gfmwxeig+6vIIIV81OK5dn+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d8kRfGIp; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71101668dedso53966207b3.1
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1750194270; x=1750799070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLSaH5FJ0osFIVIC7b0ua1GAmBIi8+s8Y1MlWceWV4Y=;
        b=d8kRfGIp3RdQR+cjCI8hG3Oau0KjjVm2IcPrRSLhktOd4p0gxHWAu/iYgTGn/lY8Mo
         pT7ieg3bOESqn25Fh/zzwEZ9QmOakDGGm0qEZGpgpU1V/IYtWBFU73Ac0KkK+5bzqcMT
         CPJR+b4xJ45cwPnsuvr+cL+PHCKal30Y0O8DmhFeF4nTjm7lPtZHwl5DC+e8nmdHcN4X
         H6EhKQm728EDGDFgwr1vMMDqD9w+O9VrMhjUbPbXAInmC6fNLi9FbUgJzQtNIetWKiJA
         52amJ3mIrdqyz7Sq9VjwVWmRk4Z/knaZbtwIqKWIodpZVD0IIzoTGwbSSr9R6hZJFVnL
         YFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750194270; x=1750799070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLSaH5FJ0osFIVIC7b0ua1GAmBIi8+s8Y1MlWceWV4Y=;
        b=Xo9Im97pOnF/GkmNZ50NobJGQt+4GeeB6iEBygNZThB8BaZatXLGkaTACdq1snTjk2
         DnLSTAyQRzAMENdbCqNs8ZT4Q+SBZ1ZfGnS/bjxpDMNhUJC30z2tjneYfejSQGSXBFeL
         GvVNmx/tLtT/iazFs+hUVEfYUesqQBQrMBZwtxZhLthz7ftzK09gsZRbsuJklKGlqq9E
         9O28nmh9yF9d4w4la2yYkdWfGmzaHi1ZXH+PTaLXZp7CWIK2NNklcgZBkHbbCqWtTuhP
         VSS6Jh5ucfs9/LKqLS+0t0mpMrzu9q8cDtyd0EIlr7KeZPYjVNof1VBpLlYhjgNv+W6n
         P+Lw==
X-Forwarded-Encrypted: i=1; AJvYcCW/N79lp3FDklqrHSTx189YWscl7udI533H7OoEw1OZ3MaykPIHpefIWRW4MW4wzot0LLUFOeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqMRCJx4vefnPrnIP66Dd16iO6lx3Q5bcNmitrYV/99lRq0HQg
	scX8i84g30jELe9EulRtLXBb494AhDueZXScgQ6trN2LW2V6PbV0e1di0Xxw6AYX8YqHgah4fmK
	sL7Ad30xFnAARvBUN109oz64mHvewRcocPzo3qJDR
X-Gm-Gg: ASbGncvly3BwTh1K0Via9TTYefc2bWt/Kw/AeARNcmRDGbGJoJuQYNNCFel3NBwPH/5
	qxcFGO/AldmuXvjfRY3BH/ksIPgT57fjTssa4eq6nraPZOcsuGFpHWBM8DwsuLKAKMdA9ptY6a5
	+K4TdNq/0jp228XJs8Hcg3ji1vVbRmtZTrXgO/8bBRaIY=
X-Google-Smtp-Source: AGHT+IF1EZ1a0hQWE4asfB5JT5FSJBolOr0rcgGVLC/42lBKbzDGscabkq8Ij553a+7rnbN0R+EVacrmZkz63U4IiPM=
X-Received: by 2002:a05:690c:6:b0:70b:6651:b3e2 with SMTP id
 00721157ae682-71175384ed3mr212955347b3.6.1750194269666; Tue, 17 Jun 2025
 14:04:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616172612.920438-1-kuni1840@gmail.com>
In-Reply-To: <20250616172612.920438-1-kuni1840@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 17 Jun 2025 17:04:18 -0400
X-Gm-Features: Ac12FXxP97gXP9l2v6eRR4pipJgnyOXpsbqjly8R6nBKnPWsPTOXFXGZ5UfFv1c
Message-ID: <CAHC9VhTPymjNwkz9FHFHQbbRMgjMQT80zj1aT+3CFDVY=Eo5wg@mail.gmail.com>
Subject: Re: [PATCH v1 net] calipso: Fix null-ptr-deref in calipso_req_{set,del}attr().
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Huw Davies <huw@codeweavers.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, syzkaller <syzkaller@googlegroups.com>, 
	John Cheung <john.cs.hey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 1:26=E2=80=AFPM Kuniyuki Iwashima <kuni1840@gmail.c=
om> wrote:
>
> From: Kuniyuki Iwashima <kuniyu@google.com>
>
> syzkaller reported a null-ptr-deref in sock_omalloc() while allocating
> a CALIPSO option.  [0]
>
> The NULL is of struct sock, which was fetched by sk_to_full_sk() in
> calipso_req_setattr().
>
> Since commit a1a5344ddbe8 ("tcp: avoid two atomic ops for syncookies"),
> reqsk->rsk_listener could be NULL when SYN Cookie is returned to its
> client, as hinted by the leading SYN Cookie log.
>
> Here are 3 options to fix the bug:
>
>   1) Return 0 in calipso_req_setattr()
>   2) Return an error in calipso_req_setattr()
>   3) Alaways set rsk_listener
>
> 1) is no go as it bypasses LSM, but 2) effectively disables SYN Cookie
> for CALIPSO.  3) is also no go as there have been many efforts to reduce
> atomic ops and make TCP robust against DDoS.  See also commit 3b24d854cb3=
5
> ("tcp/dccp: do not touch listener sk_refcnt under synflood").
>
> As of the blamed commit, SYN Cookie already did not need refcounting,
> and no one has stumbled on the bug for 9 years, so no CALIPSO user will
> care about SYN Cookie.
>
> Let's return an error in calipso_req_setattr() and calipso_req_delattr()
> in the SYN Cookie case.

I think that's reasonable, but I think it would be nice to have a
quick comment right before the '!sk' checks to help people who may hit
the CALIPSO/SYN-cookie issue in the future.  Maybe "/*
tcp_syncookies=3D2 can result in sk =3D=3D NULL */" ?

> diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
> index 62618a058b8f..e25ed02a54bf 100644
> --- a/net/ipv6/calipso.c
> +++ b/net/ipv6/calipso.c
> @@ -1207,6 +1207,9 @@ static int calipso_req_setattr(struct request_sock =
*req,
>         struct ipv6_opt_hdr *old, *new;
>         struct sock *sk =3D sk_to_full_sk(req_to_sk(req));
>
> +       if (!sk)
> +               return -ENOMEM;
> +
>         if (req_inet->ipv6_opt && req_inet->ipv6_opt->hopopt)
>                 old =3D req_inet->ipv6_opt->hopopt;
>         else
> @@ -1247,6 +1250,9 @@ static void calipso_req_delattr(struct request_sock=
 *req)
>         struct ipv6_txoptions *txopts;
>         struct sock *sk =3D sk_to_full_sk(req_to_sk(req));
>
> +       if (!sk)
> +               return;
> +
>         if (!req_inet->ipv6_opt || !req_inet->ipv6_opt->hopopt)
>                 return;
>
> --
> 2.49.0

--=20
paul-moore.com

