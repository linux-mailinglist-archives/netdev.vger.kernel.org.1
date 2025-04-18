Return-Path: <netdev+bounces-184133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 499EAA936B8
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 13:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 892023BDFC0
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 11:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020E02686AE;
	Fri, 18 Apr 2025 11:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cRWuKhpP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A6B212D8A
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 11:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744977101; cv=none; b=axw4D80bsQxyfmE1XlzK/NHKMRuWKnqoJl1KSmlWcuLXiS3Uqv4n6HrFJTE63V7zyI8TdJkkedfW1GR0oVeoHRkLQtlVw6f4L6QR78W0cCVyFPIRtsGh7UYSKScGOdmQUcC8ztydvt2nbuFiEubjzcB9JEgcZn3Sd7YN2EFKp5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744977101; c=relaxed/simple;
	bh=1MGM+5do9bVt7P2M0NDM7vdgPsnXCAZ1eIoW6va120Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGMorabvbz3clGzbhPGSRtT8rMbg+XwwlxQG9uY/D7/SlMD3gG9U8akFy+9rBhYO0faJF9jUvcX4Vq0rKlq6XuxVnQlW923Kp3TS5BrkGnx1wUTb3xmsD+OElq2LUsE4ETgfT7uHA6yn+e16v29bmi4ys35OswISBNQXaK+E92Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cRWuKhpP; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2242ac37caeso160015ad.1
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 04:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744977099; x=1745581899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEJpM/kUx2DUWhjnYE/RXkA6aIoxPKfZ9c0nl3UqU+Y=;
        b=cRWuKhpPQ7wT1NY0E9TqtLNUGuBScV/sk1QPgpXoXapsy4qLt4qL0dUx50TSPfPK/f
         iDPbH1oX8CDBj44zllQBUti8uGCxU2pZpTVc1OJ8ibEL7GqggAWXWAX6xkIStbUMRIrf
         WHmUuk4cXTYfhBID5PW0NVujZwrTxM8Q+rMTXXXzCmBHD2c0gn7c+KQvx4NSiLruLsSO
         nhJEjFVWiiU0lmr0ilrpyhIiF6YU+rm3zNPJJN4Mpl36vPnbKjE1L82bgPe2fgPdeV+T
         nWfHrYANbr+spxh0HnSDZGJCHp08PgT9pvYp82hPCD8xFvb2wpbZGcFbpWLcHPcnfavN
         otmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744977099; x=1745581899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEJpM/kUx2DUWhjnYE/RXkA6aIoxPKfZ9c0nl3UqU+Y=;
        b=osj4nJ1/j4aTCVrD2KjJWp5DNgEHz4oFu6ZFwopuRF891/nnbOrOO2aHTbC+jLk89K
         kHEtbKkmGHcRiPsPoaG+kQZvsPfWOzXp1S2YbTKX3KuUWJZr1qj5Oozs0KLts2LccEWs
         hLVtV/4ZDN/e97/r7klJ4VGSLTENqRA0TA1g67Uu6eG59g7TAaBhn4PIqbKcLaX6dKCh
         lKJBuWGdUuoBssTvxjWFQyH34fXFhv0yGGsY5g9mv1EzZyYv5bZPOCQYt8ZwccVHwEgz
         027JBQY1STBMkooe8eTHJkyXyC00ou19Zz7NpMbqynGzTq15bIQb2ZkR7g0Peri/Z8P0
         KHQA==
X-Forwarded-Encrypted: i=1; AJvYcCWJU/B7Qou87is0KZ6PCJ5+7hcP52aUismD11cnJZojSRxekAEdqctFG6+KZzXm8olx82ohnuI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Zeu7tf81+Z+iRaY/6n7LnnhWs5uq0My9KoC2fmS1fIlZfAs+
	pQz31ExqkMPoEqfkjpBjslGuNCgwSeywQqK63Eayh9+ADNaWbd7bwoXRhgCZqSg8X2Wmm3GElu8
	1eplSTqjE7L34zRUImUZfZF1M1brJFpahPtpi
X-Gm-Gg: ASbGncseYJUoDaWgZ9VJ2TmFx/4Sabo2XTlKurOqj6nQTYY7G+SFYrXd6XyvGQcIwbw
	TsR0NBAlm5GsbX3mGddnS75oS3WH8JVE6/yAIeN89+iDa+gI4pIY23dcNvjjcbcjLWej2H+byVk
	klTPwKrN0vt9dVhSwELJHTmKg=
X-Google-Smtp-Source: AGHT+IHjlV2WeH/ObFs9Ruv8j3xlk+cr0VRNF+Smb2TznUpIT/mOlQ/wOjI5DA+7skjekkdZbXxOZpIP0oUS2OkW8yc=
X-Received: by 2002:a17:903:3d0d:b0:224:6c8:8d84 with SMTP id
 d9443c01a7336-22c529e6033mr2318245ad.4.1744977099171; Fri, 18 Apr 2025
 04:51:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418015317.1954107-1-kuba@kernel.org>
In-Reply-To: <20250418015317.1954107-1-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 18 Apr 2025 04:51:26 -0700
X-Gm-Features: ATxdqUEyY7L33ZYPR5Fi4IFM4cs0adMOyGhV1IdpqjzG6h69WCnGD03AxLKT1SU
Message-ID: <CAHS8izMnK0C0sQpK+5NoL-ETNjJ+6BUhx_Bgq9drViUaic+W1A@mail.gmail.com>
Subject: Re: [PATCH net] net: fix the missing unlock for detached devices
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	jdamato@fastly.com, sdf@fomichev.me, ap420073@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 6:53=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> The combined condition was left as is when we converted
> from __dev_get_by_index() to netdev_get_by_index_lock().
> There was no need to undo anything with the former, for
> the latter we need an unlock.
>
> Fixes: 1d22d3060b9b ("net: drop rtnl_lock for queue_mgmt operations")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
> CC: jdamato@fastly.com
> CC: almasrymina@google.com
> CC: sdf@fomichev.me
> CC: ap420073@gmail.com
> ---
>  net/core/netdev-genl.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 5d7af50fe702..230743bdbb14 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -861,14 +861,17 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, str=
uct genl_info *info)
>
>         mutex_lock(&priv->lock);
>
> +       err =3D 0;

nit: AFAICT, this setting to 0 is redundant. err is 0 initialized and
I don't see a code path that sets err but doesn't goto.

>         netdev =3D netdev_get_by_index_lock(genl_info_net(info), ifindex)=
;
> -       if (!netdev || !netif_device_present(netdev)) {
> +       if (!netdev) {
>                 err =3D -ENODEV;
>                 goto err_unlock_sock;
>         }
> -
> -       if (!netdev_need_ops_lock(netdev)) {
> +       if (!netif_device_present(netdev))
> +               err =3D -ENODEV;
> +       else if (!netdev_need_ops_lock(netdev))
>                 err =3D -EOPNOTSUPP;
> +       if (err) {
>                 NL_SET_BAD_ATTR(info->extack,
>                                 info->attrs[NETDEV_A_DEV_IFINDEX]);
>                 goto err_unlock;
> --
> 2.49.0
>


--=20
Thanks,
Mina

