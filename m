Return-Path: <netdev+bounces-71189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E18EE85290F
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75D48B2152E
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 06:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B490914A96;
	Tue, 13 Feb 2024 06:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2+ovmIoj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CE11401E
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 06:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707806075; cv=none; b=XRMZJ4BLXe2WrR8NhKxNCF/yN1P1FThIbmg6HO1XJzNuRMw917jt4345sl7AwWSC9Bd3QAsbnm+Wl+8ko2YHM/ebmjUv3Uf43fwnsLK2In6hv85uZBjZlzk80T8M/iDbzoJDhHz2lpPhbeS4Cp5yDGad4hNQojYjdx2ZWgxWkVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707806075; c=relaxed/simple;
	bh=mKruLP81k11KOUoI6CLV7eaQ8XK+33pFP3PO6J0iJaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1mI04a5raEGaqzoeFAs80zWhwWwTYAATufPTQ2lBt3IHO4JU2UD9x60mYf9XoXz77tfAU7RnYTihAKyHHMIxS+HoR4y8OocJKMf/UY/zTgEUrIIMsO6jMUlj3RGOo+qXa9i0vC/dfpgR859Y6YO2uH1eGO6XatUEEB7rLWCPTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2+ovmIoj; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56101dee221so4601a12.1
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 22:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707806071; x=1708410871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIm9WdyKzo3v62kbxut9xYgCk+tYqEBgc0eUHAV5Zlg=;
        b=2+ovmIoju8lmDNJlrpfYfP087VESODXAiSkGrZteWzarRhwU4BwIFyCIQ7ikikNqrY
         Ndy/coF8B0HoiG6QWXZrAWghrZ699IobY09TzGEO9dVqYbgd7+WWt0fLQgESL5tt04DG
         EP3+ywXjwtoXdJ4J+mAVmG1CpAEvSDF45hofnGrdUlYB9vj2o4wQKsyAX7EcYNrv/zcG
         fGJmsGkl+yBCcaieOzkton3VVKB1sp56irtmNuJDBH1Om+qnNJ9yc517ml7CP8xp2gFK
         5+swdJD97vbtpzSyGtlclxQj07YHkFkjhkjgId3qXJMSDVZtGjazMp2iEgIrucxTo50Q
         +MlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707806071; x=1708410871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIm9WdyKzo3v62kbxut9xYgCk+tYqEBgc0eUHAV5Zlg=;
        b=Xgi6Bvau577CDgCtFWHVdXjBx5R2V1ox6zdulPlN2JcMaeS5KHGGLIoyb1AcvD5Ycb
         GLw+9uhGjzRNdrU9SOcpxYvCrpNn/dcEip2NkfviGvSaodsMaNbJpyRzMuNUJKFIYWho
         RkNnoNu6UUvpO+Nmg0DCa5vymj7O9WYyi0ByKBUc5DsZWfFuGKGScVUKm3V7EtaDcpfU
         XhXbMXklzngDGeEimgGljOO8Sakme9ozgNgs9n2QeKF5xjSlYRCptUL7fSLPWtaldgv8
         5VGO7ILgH42oIC/Tt0OdODi5TNFJTcyaeWxkhk0Vdjo/cbpHCMHWZA7MT+Y1dbRGP3AG
         ROeA==
X-Forwarded-Encrypted: i=1; AJvYcCVxHZdCoxBoByZYmkybxNNTpJ8ECMFYqyUuQ3QAE1komA87l9Do6QNSFCTmQpe4VvVN3AReHd2Z3szdM/e8XDPmKZOsN4V2
X-Gm-Message-State: AOJu0YxbcGy4CM1V2Kt0GRow7xc8yl7cI7k0rji1ip/pw+qh9DTHcy2W
	pQdTZm0KuUGi1QZM33N4V+tBao0yby7a0em/AzckrmCm5LVg8ADmIpcTajp3lWTK8/nS82mEhQA
	JKxR0XatwvESVwHZpP4rQtWM6Srv8CmU4ebV0
X-Google-Smtp-Source: AGHT+IF/wXpV/blHGlNxQbtZJNK0epc6JpPwR38cJIbefYqx2cTJy1wPy/M8ipB1ttLExylgcqf+vmoP6JozNIHit60=
X-Received: by 2002:a50:bae9:0:b0:560:2a1:44fc with SMTP id
 x96-20020a50bae9000000b0056002a144fcmr42153ede.1.1707806071396; Mon, 12 Feb
 2024 22:34:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213061652.6342-1-jdamato@fastly.com> <20240213061652.6342-5-jdamato@fastly.com>
In-Reply-To: <20240213061652.6342-5-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 13 Feb 2024 07:34:18 +0100
Message-ID: <CANn89i+JQdR9-X_mEfifSAGGxqJaWz+hzWcUjScNCz5zOA1yLA@mail.gmail.com>
Subject: Re: [PATCH net-next v8 4/4] eventpoll: Add epoll ioctl for epoll_params
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	chuck.lever@oracle.com, jlayton@kernel.org, linux-api@vger.kernel.org, 
	brauner@kernel.org, davem@davemloft.net, alexander.duyck@gmail.com, 
	sridhar.samudrala@intel.com, kuba@kernel.org, willemdebruijn.kernel@gmail.com, 
	weiwan@google.com, David.Laight@aculab.com, arnd@arndb.de, sdf@google.com, 
	amritha.nambiar@intel.com, Jiri Slaby <jirislaby@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Michael Ellerman <mpe@ellerman.id.au>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Nathan Lynch <nathanl@linux.ibm.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Julien Panis <jpanis@baylibre.com>, Steve French <stfrench@microsoft.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 7:17=E2=80=AFAM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Add an ioctl for getting and setting epoll_params. User programs can use
> this ioctl to get and set the busy poll usec time, packet budget, and
> prefer busy poll params for a specific epoll context.
>
> Parameters are limited:
>   - busy_poll_usecs is limited to <=3D s32_max
>   - busy_poll_budget is limited to <=3D NAPI_POLL_WEIGHT by unprivileged
>     users (!capable(CAP_NET_ADMIN))
>   - prefer_busy_poll must be 0 or 1
>   - __pad must be 0
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Acked-by: Stanislav Fomichev <sdf@google.com>
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

