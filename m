Return-Path: <netdev+bounces-116648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BAD94B4F6
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 04:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E70D2847DA
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 02:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0DD1A269;
	Thu,  8 Aug 2024 02:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrJebO5Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C950168C4;
	Thu,  8 Aug 2024 02:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723083457; cv=none; b=XrHmj1hOLjoFc16yeIzKGfOBZicGEIBfOx1ZgmJCPz/ytOJA5oG9dLfOS+f8zOEUrL5xMOUWEPK8Lpqb7YeSIA8HrHdrrU6MBpfryN5F8iYHAdBjkFw3+eDEFdjZzVkgKS/u/5v6sK6xYVfUH/Qb9cl7WrVsEkaKnKqJB/wQkRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723083457; c=relaxed/simple;
	bh=srKXVOPh2Vxq4LMVF43MjhGvklqQuFomd6hpcMjsAe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bo6AeqzaAEVIVWRMoLiL5FKGmM98lmeDJE4AnXDCYMWaiLGFoLlkgUdB55izTppE4QNk3UYLOGwbiuqCD6JXd3WgI9ievj06JxFa/scuA8zGlM4yIpafdKzRebS+KvmsM78v2yi6SxVwxjtWn4YNyp7Zb0KYrqceWrmgFB2magg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrJebO5Z; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e05e4c3228bso446503276.0;
        Wed, 07 Aug 2024 19:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723083455; x=1723688255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFpaQfuOSmzb8ZFN+/kSQhHCjV0SxCqKUb8nm9XU9r4=;
        b=ZrJebO5ZQjctt1lhRXBQxXmt2VUggyzZF3NNvKp8Tm6vm5bbaXaOEPDKAcPemvxJkh
         xp9lIOWGGrjgTIJPRjpbIzyYTkXTpI3dxSrFHzF8rhyhfjYTFoAVrCtbsXQdvSQIeve/
         N9MHV26J8/bZH3Ctz4izTdNlCtp1co13sLAkcdmZDQCE6qXRYWipao+VK8GaptSc0kAD
         9xuKambmryzDbPi8k5dWylsBPcRn6ZJ6BhVYs5sSQO+l+u+Mcu1HLb3V00CoRseWIP2n
         cWoeIcfuzMoRztgXS9bC9+LB54UJc6g0J3/xNry1R8WdSvg8Gg3d+gZstaNrN4F6oGDB
         OqyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723083455; x=1723688255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFpaQfuOSmzb8ZFN+/kSQhHCjV0SxCqKUb8nm9XU9r4=;
        b=Fpt1BjI81hVwF1ZQWis6DD2O8qf6xuq2m6OqCdcxr30OAOhwjlpOAajqBy8C6DTV7h
         k2fCjJmjzJvwBGRySw3wXIEUW7py2M+fzd8F0TJdPYurhMXWvycfTbNHIsObxX7soo4H
         CvUyYZaKQLdlVwn1CYwkD20TmHn4xmPpjBbo/z3n0FlHlZLiODi7/Mi/u23pcLwc+zdd
         fMzjYvHsh512WhJXuzAanjkh4F70+yCiwfzRqeWaeNQloZrFqupga04UEk1Mz5lnhIyi
         sdG0W3pAvkrpnTm+WQYNfjkuKen7KMRobMdm5YRu1+bbKlSBpm9bal0yXwYyPq59qqeg
         73pw==
X-Forwarded-Encrypted: i=1; AJvYcCWJCa+G4FUVbn14YSociNsy1XApNeZUnWMx0tyVeh8vZ9ta5+CrRWmZViEqBk64rzH6FYzmIOTlH+eNG7Z4Ew/lUIJ6SDH7EaCzeEAz
X-Gm-Message-State: AOJu0YzO9+ZDuAy0b2YNXvy6c5XdwjhBshkGtPmp4DqBRK/q18ejptiN
	DhI20C8Bynl+3oPTqd8muM3ChVrPYZmxTUJmmlYLvUP9q9RNnqMSanyvq0CEiZJ8bvv4WS1KpG/
	XzMq/w9sEW1dw3W9FZmvVWRKVOAlEXw==
X-Google-Smtp-Source: AGHT+IFwYOqHFyP8avOhE7g6vYgY2cwgYyH52hbrIK8wJJ2A+rUBMzMFtY+469w5oFloU/SltB9RIuKi2OB9zdrj9Gk=
X-Received: by 2002:a05:6902:2292:b0:e0b:c1bf:3ad0 with SMTP id
 3f1490d57ef6-e0e9dad0348mr496331276.16.1723083454989; Wed, 07 Aug 2024
 19:17:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807190236.136388-1-ayaka@soulik.info>
In-Reply-To: <20240807190236.136388-1-ayaka@soulik.info>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 7 Aug 2024 22:16:58 -0400
Message-ID: <CAF=yD-K=4_ry_iYeKWX17fMdBbDtO3i3O9_tbK02c10SgJPT4w@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: tuntap: add ioctl() TUNGETQUEUEINDEX to
 fetch queue index
To: Randy Li <ayaka@soulik.info>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 3:02=E2=80=AFPM Randy Li <ayaka@soulik.info> wrote:
>
> We need the queue index in qdisc mapping rule and the result
> value for the steering eBPF.
> There was no way to know that.

This commit message is very short.

There's an ongoing conversation in v2 on whether this feature is
needed, given that tc and tun already have a variety of ways to both
drop and steer traffic.

So a bit too soon for a v3.

The big question that the commit message should answer is why this
feature is needed given the alternatives. Essentially, in v4 please
include the short conclusion of the discussion.

Also add a Link: to the full discussion on lore.

> Changelog:
> v3:
> fixes two style issues in the previous commit
> v2:
> Fixes the flow when the queue is disabled in the tap type device.
> Put this ioctl() under the lock protection for the tun device.
>
>
> Signed-off-by: Randy Li <ayaka@soulik.info>
> ---
>  drivers/net/tap.c           | 10 ++++++++++
>  drivers/net/tun.c           | 13 +++++++++++++
>  include/uapi/linux/if_tun.h |  1 +
>  3 files changed, 24 insertions(+)
>
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index 77574f7a3bd4..bbd717cf78a5 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -1120,6 +1120,16 @@ static long tap_ioctl(struct file *file, unsigned =
int cmd,
>                 rtnl_unlock();
>                 return ret;
>
> +       case TUNGETQUEUEINDEX:
> +               rtnl_lock();
> +               if (!q->enabled)
> +                       ret =3D -EINVAL;
> +               else
> +                       ret =3D put_user(q->queue_index, up);
> +
> +               rtnl_unlock();
> +               return ret;
> +
>         case SIOCGIFHWADDR:
>                 rtnl_lock();
>                 tap =3D tap_get_tap_dev(q);
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 1d06c560c5e6..0c527ccdeab3 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -3151,6 +3151,19 @@ static long __tun_chr_ioctl(struct file *file, uns=
igned int cmd,
>                 tfile->ifindex =3D ifindex;
>                 goto unlock;
>         }
> +       if (cmd =3D=3D TUNGETQUEUEINDEX) {
> +               ret =3D -EINVAL;
> +               if (tfile->detached)
> +                       goto unlock;
> +
> +               ret =3D -EFAULT;
> +               if (put_user(tfile->queue_index, (unsigned int __user *)a=
rgp))
> +                       goto unlock;
> +
> +               ret =3D 0;
> +               goto unlock;
> +       }
> +
>
>         ret =3D -EBADFD;
>         if (!tun)
> diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
> index 287cdc81c939..2668ca3b06a5 100644
> --- a/include/uapi/linux/if_tun.h
> +++ b/include/uapi/linux/if_tun.h
> @@ -61,6 +61,7 @@
>  #define TUNSETFILTEREBPF _IOR('T', 225, int)
>  #define TUNSETCARRIER _IOW('T', 226, int)
>  #define TUNGETDEVNETNS _IO('T', 227)
> +#define TUNGETQUEUEINDEX _IOR('T', 228, unsigned int)
>
>  /* TUNSETIFF ifr flags */
>  #define IFF_TUN                0x0001
> --
> 2.45.2
>

