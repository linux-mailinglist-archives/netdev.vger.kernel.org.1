Return-Path: <netdev+bounces-236762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D45C8C3FB44
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 12:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA6604E1970
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 11:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3BA31D750;
	Fri,  7 Nov 2025 11:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jUkZvzKt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39F02F691D
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762514417; cv=none; b=rTjcfy+MA4C9ElSWCPTLFei9mz/RA407eJtzZ4Mg2LYVu10QVPWBKwIb2ZNv/jPPUT24/xDqvwf3/hsiYN6nj5r4jFkWXGGAg8UD6Gry6G12316vaQq6+luwrbtZvnHrUKJCrge+IqLHfVkBD2CA3TH6Tc45QmHr5pPSILTQ6F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762514417; c=relaxed/simple;
	bh=BRaK+VjCK1hNZi3/Bm25vdWhbCF3f4DmIMNp6ZePR/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pl6Gty86vVTYKjoZ36cxmSbtwxC/A8ausc5dNAV2QEz2Da3UFBsigzR9wKU7vJlWBj6of+opp8n1Sp8JN2YlGpmuoYGaBFnTuZ+FZAqwfisvN4Z+l8Jmun8K3Cq7kz6W0lswQqlpo8DfHAGiNkBrtAeImorKFLHiWEhhg/Chlqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jUkZvzKt; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ed96544434so6139221cf.1
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 03:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762514415; x=1763119215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCuntcHPB7jt7B/bSZdm9gqlzC6yu+GRicnaUIhJiE0=;
        b=jUkZvzKtLY+JSbhFO4QDQAGxkk4ytJCkr8KMyQ/klCNASqBvBpGxSiLm2fdHMiJCKO
         Ut+ahhOqbegytRzh+KR5nabbJRq2vR+cB3X73kbMFv+Q10e7un0CORbff6BDJdwk684P
         gWKx+ZSUDBI6680d7NmVMabEKpPAvNxb96FRI/I3EutuLavhEQGAMNeMGzydzluohZTG
         vxgnvW9dPj+MV0o+w14sN24hebsdyN2KRBmxOkxQAzZ/g+0EDS5GYnh9S4xbdunYctQe
         BC9KASBUx8/3VYjCTQ5AYZuc2ZDiaLAYBY5QIqvSBE4liwEqaOcQ/8lQvJMDx2EPOgST
         XAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762514415; x=1763119215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fCuntcHPB7jt7B/bSZdm9gqlzC6yu+GRicnaUIhJiE0=;
        b=A+3/9KmSM5LWl9w31mcHcKJVpsh1SGz27Mx0whPERNZfTBUbodB0RxECtWRIqo0Ivu
         fkp/zEVI6nkYQFtuw+GCgaKKvEMgweFb1KkFFvG92Zmo0e9FhSeZ/AskZsBFhWdev9Rt
         2F2swz9zhh+iZj/RF2bVikuAj6L9Y980329/6r/TA10uidKg8IX3po5MN+RqQbws6eeY
         iZDpO3idg9mc84ywyU61RmIPq6tYsYktbe2be7bE4SJG00KRvh/aCPQrOd68YAYeBpxq
         BZyqjqy103TkqvVZGmZiRYRyUZvy5iXtEBjD6otqwIKwZtGv0NCbzd5wocVndcQTduC6
         7MVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHXoMTnyLDGeCOsfdW1ka7zhJDNmepDXfJ0fnQepq9pCWsLIz7kpg87XOZNdlYrZDC7JpNmRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLILk2Jnopd3CnF+mIiTYoXjpBgcWwYqd/B96Yz36a4nzKWkPf
	ZFPyO9bsGNp+XTRbnRE2GhdzUDyrJObkaXp7eLWNzbBgi8OJkTwuk0Fdm32G++colw7t2xa2jxD
	d6hm8wsyPcO+8KLKxdxoLyPJau9lmAneYse91wEZk
X-Gm-Gg: ASbGnctw/uKBMJETHcL+8gRcrX11aWijAtsOpYw8XAFS3Xh8BbBRoYcAdFbXVpCmAiE
	GAzAsLLl6LyNktojwbsVQYAaoXT+UurbTM5eSJQdHxz8WBe24SdjHcIFx/ci+XvgQwnvAQjLFbW
	M3YMfFMpkv8kuxqubiUwcHyLIn7l9nf7fYP5bZAl14OXqgmAU8BbL1NbwZYaau3kJnAuxnPVeok
	4j07tZHmKZVGMi7OdLW9kN5Vb0VEyBQVeuXhvnXFIRzZzoqdz+opY6g4YFbMaBTbtJJ/Wad
X-Google-Smtp-Source: AGHT+IGC3fYMjryS9zADloir/gP2Yamma9UjG5JSmMf62xT/E/o9kWnU3HSHFswBMiaxi1WGy0axf3d/DY0sMx5XNcM=
X-Received: by 2002:ac8:5702:0:b0:4ec:f969:cabc with SMTP id
 d75a77b69052e-4ed9494e284mr28907961cf.10.1762514414438; Fri, 07 Nov 2025
 03:20:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107080117.15099-1-make24@iscas.ac.cn>
In-Reply-To: <20251107080117.15099-1-make24@iscas.ac.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Nov 2025 03:20:03 -0800
X-Gm-Features: AWmQ_bnEuaGnleUmw5tdQ2p6tHQd4r5RAkYYgVZBqY4gtBL8VHSKOH_-igWdJDQ
Message-ID: <CANn89iKswhYk4ASH0oG1YbvNsP9Yxuk4vSX5P45Tj_UY+s16VQ@mail.gmail.com>
Subject: Re: [PATCH] net: Fix error handling in netdev_register_kobject
To: Ma Ke <make24@iscas.ac.cn>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	sdf@fomichev.me, atenart@kernel.org, kuniyu@google.com, yajun.deng@linux.dev, 
	gregkh@suse.de, ebiederm@xmission.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 12:01=E2=80=AFAM Ma Ke <make24@iscas.ac.cn> wrote:
>
> After calling device_initialize(), the reference count of the device
> is set to 1. If device_add() fails or register_queue_kobjects() fails,
> the function returns without calling put_device() to release the
> initial reference, causing a memory leak of the device structure.
> Similarly, in netdev_unregister_kobject(), after calling device_del(),
> there is no call to put_device() to release the initial reference,
> leading to a memory leak. Add put_device() in the error paths of
> netdev_register_kobject() and after device_del() in
> netdev_unregister_kobject() to properly release the device references.
>
> Found by code review.
>
> Cc: stable@vger.kernel.org
> Fixes: a1b3f594dc5f ("net: Expose all network devices in a namespaces in =
sysfs")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  net/core/net-sysfs.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index ca878525ad7c..d3895f26a0c8 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -2327,6 +2327,7 @@ void netdev_unregister_kobject(struct net_device *n=
dev)
>         pm_runtime_set_memalloc_noio(dev, false);
>
>         device_del(dev);
> +       put_device(dev);

Please take a look at free_netdev()

>  }
>
>  /* Create sysfs entries for network device. */
> @@ -2357,7 +2358,7 @@ int netdev_register_kobject(struct net_device *ndev=
)
>
>         error =3D device_add(dev);
>         if (error)
> -               return error;
> +               goto out_put_device;
>
>         error =3D register_queue_kobjects(ndev);
>         if (error) {
> @@ -2367,6 +2368,10 @@ int netdev_register_kobject(struct net_device *nde=
v)
>
>         pm_runtime_set_memalloc_noio(dev, true);
>
> +       return 0;
> +
> +out_put_device:
> +       put_device(dev);
>         return error;

This seems bogus.

Was your report based on AI or some tooling ?

You would think that syzbot would have found an issue a long time ago...

