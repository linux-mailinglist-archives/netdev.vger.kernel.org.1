Return-Path: <netdev+bounces-72025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 681D4856398
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 13:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F21288455
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 12:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E1412DDA7;
	Thu, 15 Feb 2024 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qWrmsUlH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF62E12D74F
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 12:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001286; cv=none; b=DSyjySWaiMANUEnfJ2fD2Z6St7ljcaLHlDzCxh8SjltDF/twI4b4lxmgxy0VJ+kbPMgelQ8GJrFtsnCTdF8k8nsBxAMsNwdnFNo23fA59RsNehOJcx6VxRyVISu7D+1NLVzQb9DuZ+ql0mN9jyjhkWrUhRs628J859Yv9+45nEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001286; c=relaxed/simple;
	bh=n4W/oeMLxsVSxz8N1PwKYYs3lezOwj6qNxhocfddBm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NWnhQyTE/sStrSVphl0GIu0n4OR4jmGcmi4sIMITmOwS60ULj+Tn1vn3JzNIqCN5Q3mgGz0tE2QOVsSKGPttroBZSMQRBFnR1V9/U6r1leL5vrxPb/m3J8NnLtGoEir8gEhGVGadGoig5vOAmr1hZqEcdbIcNbk2+TWE/MRs0z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qWrmsUlH; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4120933b710so53735e9.0
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 04:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708001283; x=1708606083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQNRXRuN05KfACl3oUXdkaMEEPe2ghUUIfrJquBt6Vc=;
        b=qWrmsUlHOq8zPAU6R1gUW+Y/AdJutTFrPr1wcmY6/yA0Lu6ygq0PJIAI2mM39hBJJm
         HwxYt1VAcAiQnVYiYUwm4M16fGXxBw5wjYmEBS/748CKzSyqrb8xK7iJkLtuhZTfUbmz
         oksrcsZpX5fNG1YN7l99TNb/mfHw5x0H8CVU4HLsWBZeuNFY8JDEI5gfmLtSkhGzbE09
         UbbNXlHo7FBCtk98bS0obvHng9qtXco0OyUwt12hoHMSVAHUGBg0eCtLaCenSNDPUbkw
         z/zoUhfsxM8ebq5pwbrOgE6WB2SrA8hharJnypQPIG7z1glZt2ODjKRyvU088lQsB5+M
         ncnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708001283; x=1708606083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQNRXRuN05KfACl3oUXdkaMEEPe2ghUUIfrJquBt6Vc=;
        b=SsFs+8bl9MfZ1RUSPWrzAv/tYeVcU2VMrt1EvEYOQIiwV0lJzU4uzgyxl86zqw0cQU
         w7ZfDQrrJxJQ5QYFSiVJCfiST4D4XmaTJvb4BfcGTE+ak2PLNSMNMQfWCs5BDNFWEKNL
         leh6qYZm3C2wQnF3AWdFoKlmq/K4N9s3UUF5/dg0Jb7uJx9WhonCdG90RdzQYpVR6Vte
         EgfNSC49eLXVmItQpm10fae0/T5IX0aObPUwyr9x38Nfu7sg9l6XRWrBpmv/DKMqiTwj
         mDSx6oeBWPoFRd370V1IBtM9ONzrUdjJRguTLd3F1EOaVYHPhpmg9i52CffY7vb8r2SZ
         hbhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnIgllIqeug8RE3WSKn62i7EcuqIPU/RheYk1b9ie7ngEp9GsMYhKjvtj5hAkGpQrDGK+0/s+wwBGw+iybLXooVM12MvBQ
X-Gm-Message-State: AOJu0YwAf35YAJelVKQrMHGAstjSsuFL7YYk8jV9HIwcrcFYKzco3i8R
	SvVut15txZdnwrOfwQwSTp1+bXzaoXXyVvwNZsFWRPnAUw2jjSLfLdMl4YXGlnqdGGaGnNUZEAM
	t19z9N3oac/dchdF7D2QVT86fDMe6dy4zbzai
X-Google-Smtp-Source: AGHT+IHnukjZ7g0Xb1PaRQUEaNaVLq/ZgTFtdFxACH88xW7m7wVYWSBYkDx4lidk+KMhdlOpUr0gwq858N0e1kfbH2k=
X-Received: by 2002:a05:600c:5027:b0:412:20d2:6006 with SMTP id
 n39-20020a05600c502700b0041220d26006mr56569wmr.2.1708001282612; Thu, 15 Feb
 2024 04:48:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215112729.1778958-1-leitao@debian.org>
In-Reply-To: <20240215112729.1778958-1-leitao@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 15 Feb 2024 13:47:47 +0100
Message-ID: <CANn89iJsdvjsbcYv_Re5HHvmY=P7Sq6ewV_sdQuWTAFtOPoKbw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: sysfs: Do not create sysfs for non BQL device
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org, 
	Johannes Berg <johannes.berg@intel.com>, Amritha Nambiar <amritha.nambiar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 12:28=E2=80=AFPM Breno Leitao <leitao@debian.org> w=
rote:
>
> Creation of sysfs entries is expensive, mainly for workloads that
> constantly creates netdev and netns often.
>
> Do not create BQL sysfs entries for devices that don't need,
> basically those that do not have a real queue, i.e, devices that has
> NETIF_F_LLTX and IFF_NO_QUEUE, such as `lo` interface.
>
> This will remove the /sys/class/net/eth0/queues/tx-X/byte_queue_limits/
> directory for these devices.
>
> In the example below, eth0 has the `byte_queue_limits` directory but not
> `lo`.
>
>         # ls /sys/class/net/lo/queues/tx-0/
>         traffic_class  tx_maxrate  tx_timeout  xps_cpus  xps_rxqs
>
>         # ls /sys/class/net/eth0/queues/tx-0/byte_queue_limits/
>         hold_time  inflight  limit  limit_max  limit_min
>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/core/net-sysfs.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index a09d507c5b03..c79bc11a0347 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -1417,6 +1417,15 @@ static ssize_t bql_show_inflight(struct netdev_que=
ue *queue,
>         return sysfs_emit(buf, "%u\n", dql->num_queued - dql->num_complet=
ed);
>  }
>
> +static bool netdev_uses_bql(struct net_device *dev)

  const struct net_device *dev

> +{
> +       if (dev->features & NETIF_F_LLTX ||
> +           dev->priv_flags & IFF_NO_QUEUE)
> +               return false;
> +
> +       return true;
> +}
> +
>

Thanks.

