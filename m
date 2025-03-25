Return-Path: <netdev+bounces-177288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C91CAA6E951
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 06:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF23E16CA51
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 05:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349121A23BA;
	Tue, 25 Mar 2025 05:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uFhvc6k7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A996A1ADFFB
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 05:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742880900; cv=none; b=aJD1pC9aALMBp0cbPYSP5/lWHRWpkxBIoVsqjAvACDKltdUsiZq6CsPWvbpRVNIUpCfZVGD1iGugUy6v6tTqYIDwqLwoEHFohkRS3zym7Kg97BxpTKyCgKIEkK73hvZ2DPyIAy6yxQn334Wbqa+ijTrrgkfqP8FnCBlkKJLsjOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742880900; c=relaxed/simple;
	bh=VZyZ+U03n/kYLr7nyU+6j/u+eDsCM/4aigx8fhbJ59k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3mcGVSThQDl9NFYFoRAGm98q0RFT/nGXQVm81kvK1pLbiZgecbHxBYM2zTW7X5euIagGGliFx29rBCTRzigH0pCWNvsi4f6My4omNIUosiKt2wygawnxIxeDdx42pnl4zgKKgd6it7KrBHyLS5dGyTTEMRt9RzS6mbUx+5lgUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uFhvc6k7; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2264c9d0295so144225ad.0
        for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 22:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742880898; x=1743485698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwLeh8RhcdM/WIYZF7AMbpvd0gW+3hk38NS3nQGJDuw=;
        b=uFhvc6k79fQt4plwlrVwX+rZGbF2vVc02vWMJJua+Sq/1t92QhbXDIagj+N47ddTS6
         SL2swETNuz/urJBbicuva63Xkmvw0c/hZqAQ2D2NXNUgqLftcPKpjx5fbeFwDnAzIx+o
         3fk5N92ByLX2vDD5rocA6lwbwHW3cMIbBENvz/qk1Q7F/qxXYlmokbliJCKfbZRRLU4T
         hEa1MBzOT95vWyRTn/OaWRW8lfzTdQ5TsZsG3TkHlE9+wYCG0mVr/ZkR5bXAqL3ZpBhQ
         eLOzkV+YdzJ7aaWz/UtlRt2xi5Vk09vVcn5nmnLNmsv/sMZWoh0BIlcEJABYgsBGP5BF
         mtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742880898; x=1743485698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwLeh8RhcdM/WIYZF7AMbpvd0gW+3hk38NS3nQGJDuw=;
        b=fS6ycmIZt/RXvAw97+EEpjSm2FLB0VO600H5wA2rAtxOrqZ92O+wQB5kaNeetpepbF
         ZyweSIqdSZaEYs7qpwCsynsVlSd4C/wTndE+WekF2EIw1PH+JsCDn+hh21I7cVdFpfV9
         YfiRgmwXjVCKogwNd4Sgc1IGUTtalizy8drJQj14RCiwsBtC8g51AwPmaoOQDZv6xA12
         rq4NXszf5fUkDu5j7MGWdnkt8+YHqfIK/tNSuH+SJwPOAW9MTxu4sUdqw95cgOkQ8Gyo
         IYcuVgzqBMOk6Z+rdIc0rRMB/y6liT9sL5NFiYfXCMm2csjITeKpewjvHZcIrfSq9U8E
         L5KA==
X-Forwarded-Encrypted: i=1; AJvYcCU6Ri/2xy2lbbyGcxg2mTGdXO1mNWAgdJbBSOHdTCyEYxwuAW+1w6k9eCOwWP5njb+sAX8KujY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLX588jnT8XtK35gslfUf5qHp7GBytCsPK3i3AzYnA56OWrpLd
	GMfvhBDqqRLvQhM8QMiaQcUqdixRYHUtrFPJ5qckW0U4Lce+Uxe2Sr96EfTv6kbbIq+xUaasAWy
	UctuhTYRXllJRPXAKlDMiRvgYiUS5XhxehWPk
X-Gm-Gg: ASbGncsmlIEYOmeRna281Zm1MuKvP2qCVivoiaY3GAGyQzS/iH2Y/8cQOo1+SrhGFR8
	qAiz8D6qFQeKx9JEVODBknKaMksSyHF1O/R0QPRDR5ZBRjE7sGQq+qqqdCPNkk4CoslaO+WgL60
	UmbdShZWWtTuzLoyj/vjgJuqp6oRQ=
X-Google-Smtp-Source: AGHT+IEsb8DJ3jomOSB/M2jxmaFjVsSIc7TW2TcD18AjQCiUOXCPreUTFMUSnF7r4j4M+W86oVXxuN+zPJm+dXN8PJA=
X-Received: by 2002:a17:902:f707:b0:21f:3e29:9cd4 with SMTP id
 d9443c01a7336-2279832099dmr7540485ad.20.1742880897456; Mon, 24 Mar 2025
 22:34:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324224537.248800-1-kuba@kernel.org> <20250324224537.248800-8-kuba@kernel.org>
In-Reply-To: <20250324224537.248800-8-kuba@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 24 Mar 2025 22:34:43 -0700
X-Gm-Features: AQ5f1JpOzgQVDShicbEPF6lsAJY84A8DI1WZ40AT0_W7tI0Pli8T7aQFCSmMvzk
Message-ID: <CAHS8izMyS_y0o9EzJ8NaLnS99KYH+Ze6BaSw=+=hPPnuS9zP8A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 07/11] net: protect rxq->mp_params with the
 instance lock
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 3:47=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Ensure that all accesses to mp_params are under the netdev
> instance lock. The only change we need is to move
> dev_memory_provider_uninstall() under the lock.
>
> Appropriately swap the asserts.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
>  net/core/dev.c       | 4 ++--
>  net/core/page_pool.c | 7 ++-----
>  2 files changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 690d46497b2f..652f2c6f5674 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10353,7 +10353,7 @@ u32 dev_get_min_mp_channel_count(const struct net=
_device *dev)
>  {
>         int i;
>
> -       ASSERT_RTNL();
> +       netdev_ops_assert_locked(dev);
>
>         for (i =3D dev->real_num_rx_queues - 1; i >=3D 0; i--)
>                 if (dev->_rx[i].mp_params.mp_priv)
> @@ -11957,9 +11957,9 @@ void unregister_netdevice_many_notify(struct list=
_head *head,
>                 dev_tcx_uninstall(dev);
>                 netdev_lock_ops(dev);
>                 dev_xdp_uninstall(dev);
> +               dev_memory_provider_uninstall(dev);
>                 netdev_unlock_ops(dev);
>                 bpf_dev_bound_netdev_unregister(dev);
> -               dev_memory_provider_uninstall(dev);

So initially I thought this may be wrong because netdev_lock_ops()
only locks if there are queue_mgmt_ops, but access to mp_params should
be locked anyway. But I guess you're relying on the fact that if the
device doesn't support queue_mgmt_ops memory providers don't work
anyway.

--=20
Thanks,
Mina

