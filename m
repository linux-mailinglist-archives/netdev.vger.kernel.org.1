Return-Path: <netdev+bounces-130146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A265A9889F5
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 20:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAE641C21990
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 18:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32E515A853;
	Fri, 27 Sep 2024 18:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AX6/8PeW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B47EEA6
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 18:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727460954; cv=none; b=gVd7aRTi/9zR625rWJoXjlhI7twIXBNqZ+wSNtScvQB+cH8LgdyllCByn01ZEonp/FJkMox0Hwmd7dGKFj4uZarmJsTdVYchnbLpFjRXvX/drMzRNTK2QL0mUx2kOVC0f7Ty/VW/VP0zCfZNK6oky6YCBoa/PVDSoaVzh+56LeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727460954; c=relaxed/simple;
	bh=cPGPrshc4QNk/99mTuoYkMhxWsse5tOYaZQsmXQjy6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fW3FHxvYdLYbtAIH4883SpY08MZsoTkJelums/8+hBjOUQdC+E0apgSpDMoK0zEYTWi1vQ/bQvgTJCXtHVhEe6FWZGNDgXDL7x6C5eQr8iTigrwtn3F2E8WsfTj7VTHCWYO7+O9/C7Rh6oy10vBgMvfhdtYcLH0XKYlxAQeiTz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AX6/8PeW; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f759688444so23385861fa.1
        for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 11:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727460951; x=1728065751; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BAXC1jjS+q2JfymL+BkIvB6rw6pd4yUqUxSez452AvA=;
        b=AX6/8PeWqUWh8v/jtp95n1/7OLMWZpTGXw0b7iw/ttzaSEBejRS76SX5KKvja0Sfyz
         0hiltl8dLOzyi7hg/huBhhTlr4ZfFuTWkvInH68IsltNr5HI+5URRaRbidy6ip51Ejaa
         688ZQ+Sqj2n/BnjdZLRgYfnVnHW+zdvVPnuw3voOX/RXBUbjstr7FJbgA9GXz07+nIxC
         qhb6SjgKawUGX/YewVFQ804rUHo5b3Nrs6OsNnELiEJ2JIdyqw6HiI5Y2OujeltCqOoi
         9TpYGlch22p3qgQ6NzWUL4QWNUyDDLCRDQVUnbwPv0C20I6No9J8Llq9Mc8afghYHeMF
         rizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727460951; x=1728065751;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BAXC1jjS+q2JfymL+BkIvB6rw6pd4yUqUxSez452AvA=;
        b=w8khB8fhOu9j0xf10EC4PgLV9S2XGSmfFqE/n1zk7bPfqLgtONfbV/ZUmL5cVxSvZl
         s9CM31KhINxbqydVuwWlq1pLYj0G5qhwCs58kqXevI660UFugB02Xw6HkmsOCRE1AYa+
         iPe3651uI6np5zu8pP70C3PEMTCPovd+Hmey+9AHasbptVWnhX9bMLO/rIawyPEiyMzy
         S8Oom2M8ruRz0NcqIcZjumvz2lHibigb0DO5gYr0eieb0xw1rdAPrNSbLTCnF+QXlYkI
         Q5B73Zetm5KqxD6zPbtSC9zvtxKaX8TGVZY42YSpsPYKIYNLlQwqczO25B7YmFy7w7cl
         mOEg==
X-Gm-Message-State: AOJu0Ywm25e1GIZkpEFn9JgvdoLv5zyQW2jBTDQaOS6bcVYSjjfbYmbG
	UxCCOymmt4J5LJp07dqTRyNDRy5cYrL+gL3dGa/O6UA+XAupaLIa+CN+mSCWYB/rUgyD0CkhU1o
	btuCecQ6DdJ+prNIi3iVy4C/EAPvOcFBeFbji
X-Google-Smtp-Source: AGHT+IFguB014B6EKl0Q/a5MJW3oPdzwrAqGbr/v6VQraq+wpGBJLmYOKfTJGKUPKSQiOem+2EK4Kwet0VNxh7U+gJ0=
X-Received: by 2002:a05:651c:b0f:b0:2ec:1810:e50a with SMTP id
 38308e7fff4ca-2f9d417a581mr26199411fa.32.1727460951099; Fri, 27 Sep 2024
 11:15:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926030025.226221-1-jdamato@fastly.com> <20240926030025.226221-3-jdamato@fastly.com>
In-Reply-To: <20240926030025.226221-3-jdamato@fastly.com>
From: Praveen Kaligineedi <pkaligineedi@google.com>
Date: Fri, 27 Sep 2024 11:15:39 -0700
Message-ID: <CA+f9V1OsZgH37X-zjWqjkjoQwteXg4=n_HyfA_SOWN9YM=GLRg@mail.gmail.com>
Subject: Re: [RFC net-next 2/2] gve: Map NAPI instances to queues
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, Jeroen de Borst <jeroendb@google.com>, 
	Shailend Chand <shailend@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Ziwei Xiao <ziweixiao@google.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index 661566db68c8..da811e90bdfa 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -1875,6 +1875,9 @@ static void gve_turndown(struct gve_priv *priv)
>
>                 if (!gve_tx_was_added_to_block(priv, idx))
>                         continue;
> +
> +               netif_queue_set_napi(priv->dev, idx, NETDEV_QUEUE_TYPE_TX,
> +                                    NULL);
>                 napi_disable(&block->napi);
>         }
When XDP program is installed, the for loop iterates over both
configured TX queues (idx <  priv->tx_cfg.num_queues) as well as
dedicated XDP TX queues ( idx >= priv->tx_cfg.num_queues).
Should add if (idx <  priv->tx_cfg.num_queues) check here.

> @@ -1909,6 +1915,9 @@ static void gve_turnup(struct gve_priv *priv)
>                         continue;
>
>                 napi_enable(&block->napi);
> +               netif_queue_set_napi(priv->dev, idx, NETDEV_QUEUE_TYPE_TX,
> +                                    &block->napi);
> +
>                 if (gve_is_gqi(priv)) {
>                         iowrite32be(0, gve_irq_doorbell(priv, block));
>                 } else {

Same as above. When XDP program is installed, the for loop iterates
over both configured TX queues (idx <  priv->tx_cfg.num_queues) as
well as dedicated XDP TX queues ( idx >= priv->tx_cfg.num_queues)

