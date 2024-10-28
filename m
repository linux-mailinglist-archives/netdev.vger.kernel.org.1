Return-Path: <netdev+bounces-139575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8CC9B34A6
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 16:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5693F1C21F25
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 15:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA5B1DE3B3;
	Mon, 28 Oct 2024 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cq73vevG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B422C1DDC05
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730128839; cv=none; b=Tf405QHDP2gmfE20UxY0Q10G8396Qa3PKk62punqcQxjtpV3e1BsIqUb5oi3dwhaOv0vTg13zsZCGQfZeFEQ2ZQFvu7QVlE9K8w0mDVVBLm/IK/jqRaW4iyCwMiLsuB8n/Dp8bgcVc/AcR/unokmmcs8JLn/6hUgxfzegSKLbQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730128839; c=relaxed/simple;
	bh=9vOfV1nv3dJamdMcGcAvkjeuuuehU7scnrXHevP4JGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g2CLySIgOpMewd2C7Tl3TqOPkyfu/625g+DuAiGiOP4AhQAYa1Udnmm97weM5zheV5LfQ3BpOBeIu9+OEJaLBHc4YGKYQDYf7lnAS3ZegWTvbxbZInYWDESKYAZ9+RydEbC1vLIoRIregxka0zhmqSsGJMj9qYagy7Kj3lxoQj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cq73vevG; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c9454f3bfaso5219500a12.2
        for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 08:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730128835; x=1730733635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8A7Y1smH5iLgDTBZI8wqoHylFq2drR/RaP5ssz22jRY=;
        b=cq73vevGHyRwIo3onMOUSZCq/5fCVwCwI2Zmq0CVeeGcSLFkUdjS5Qazhx88arGFIh
         chMDQfnHa6zZAQP9XT3v0lG1nrh31OHKeQi/nqZz5ha0rycIj54kdb5NC7mL7Fn/qHCU
         TN+aaNfFPjvYE16QHs56zBOwg8zO/qP9YRt1OBkOygIxWt0ZERRLNrq5DIHGg2ZGceHj
         XAHyYElaU7xHbQnm15tzBL0VFiFBjK9E1o2zHlnqyREtVReJobRG3ubgJ1zW4nc4BoZp
         V0WWW1DBVwdh5d5SeYJtMm8w4JOjAXBLUqKvEgq9ntHQYZpKUPnfGMuRIEV/emBqD/Cm
         WCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730128835; x=1730733635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8A7Y1smH5iLgDTBZI8wqoHylFq2drR/RaP5ssz22jRY=;
        b=Z1zi/2T3faMtTNrnSQG10AypY1M1txvK2o5PGMbfsjnc+OHN1JcNdfp5iUOksvJ9/W
         qTUwN5fOrCQgcQNH+lhTCC0y1FgnUC/sFuNy1lQNyysfw8Kl8wAWYTvtbOPxg75ZtjXn
         4awwRPZLQ/ewa7VIhq20kTEl8TgLRZrR9H2Ik89SJN+jJyICtTH35xr+KaJUXul84oWi
         5oIuxbyC8njT0JxmivhTdplesZ9zK75xE6w60MCuvwVDHgNoyDRSBr3KAf6gP4w5d1+e
         taQDXk/cv1CM0ILQzLBHR4qahN0b4wv7gNVQr4e/QIsOqT5tATuJrTZhgz017rsECJeK
         nipQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdJw+6dBH2Y3Cjpoqv7c6UFGnyQEt8cpIE6AkWzpswrN7iX6qY/uQskIx7r0yTVqVuFCl38B0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH46ssZq0OH3aXfbOTzdgZYuyvh2qZNDxpAO+U3OqGB/6yYsd5
	ObaWCDZyJiNlQWGyoncV4B10iKJw6P9MpewmmUHL4W+tokFz6/5YKhVP5Sgd4IS2KN49jHs29Iv
	mQhavj0IC8fL7qtvBI0/W+IIocCqmn75k5EO5
X-Google-Smtp-Source: AGHT+IGQlWvncSWyRjU0MqLvkzq7zgdmh8ci7LTfgESO71eUgRKbiRnKH3tfmeMsJw+1nj1dpvpgLjvAzpaqngtva14=
X-Received: by 2002:a05:6402:40d5:b0:5c9:4022:872d with SMTP id
 4fb4d7f45d1cf-5cbbfa66f3dmr7608343a12.32.1730128834716; Mon, 28 Oct 2024
 08:20:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028080515.3540779-1-ruanjinjie@huawei.com>
In-Reply-To: <20241028080515.3540779-1-ruanjinjie@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 28 Oct 2024 16:20:20 +0100
Message-ID: <CANn89iJCshHRan=w_YMp7bEeBadOjNS7PU392q2K4qNTRtz=Ow@mail.gmail.com>
Subject: Re: [PATCH net] netlink: Fix off-by-one error in netlink_proto_init()
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kuniyu@amazon.com, a.kovaleva@yadro.com, lirongqing@baidu.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 9:05=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:
>
> In the error path of netlink_proto_init(), frees the already allocated
> bucket table for new hash tables in a loop, but the loop condition
> terminates when the index reaches zero, which fails to free the first
> bucket table at index zero.
>
> Check for >=3D 0 so that nl_table[0].hash is freed as well.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  net/netlink/af_netlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 0a9287fadb47..9601b85dda95 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -2936,7 +2936,7 @@ static int __init netlink_proto_init(void)
>         for (i =3D 0; i < MAX_LINKS; i++) {
>                 if (rhashtable_init(&nl_table[i].hash,
>                                     &netlink_rhashtable_params) < 0) {
> -                       while (--i > 0)
> +                       while (--i >=3D 0)
>                                 rhashtable_destroy(&nl_table[i].hash);
>                         kfree(nl_table);
>                         goto panic;
> --

Note that the host is going to panic, many other pieces of memory are
left behind.

A Fixes: tag seems unnecessary.

