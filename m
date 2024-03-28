Return-Path: <netdev+bounces-82878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F008900A2
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 14:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6C41C28625
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 13:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91087D40D;
	Thu, 28 Mar 2024 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4sqZSGAx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA73411CA9
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711633352; cv=none; b=YOMB6r86mPAEWzcNpyp4ujbOiTFAhEqiQ5mzCzvvMNqG8DT5G67PYcMsfBnljBo2nf2+fi2Zl/qSlvu9j5ym+T9PJcAtFDmiwMrRZtZorAGHnuCapH1DyOf3/zyBZJ98TEM69LbtCEntuei6akW/vNN6s1HXZPe5tha3bM3sVAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711633352; c=relaxed/simple;
	bh=90IKMXi+Mx4ljaiWhrb/qRGG8kDwtBjfQtPqlnhUbwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YE5TqLlq0v5Zce5zzkCc+lwsV9f48l+ku3noBQIlyA+zGbAxVN0CV64mV5ncYXXLJM/FUtmOjgS2yN7vKXugUkjPp/0r8qXmzhbCxiL0LzZZbakGCBpKKSgu6cGHrcV5NeIt6BuV0Fmb/UIAz449+5pQKkpTjZamEQBfoBfpJts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4sqZSGAx; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56bde8ea904so14040a12.0
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 06:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711633349; x=1712238149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixIzkD6CcL2ofyOtDwawU0BPi+A2LWUEPg5s7hIMhuE=;
        b=4sqZSGAxl87WEDW2NP6hVX64J0obNUK+7UVcHE4kOu+figPDMqX6VZfXmb/zruV8RA
         3H2zeqrkvMxhyBCsovXRqQbQYrnmlA7d0o+m2MITW5nkOLCEuMcfnRyJm2hcq7SZ2dPt
         qbGMarQyGqVx/e712oKOM0vDBiHP+68pM8f+iy3jso7P9OSm0Ks0LqLjpmxPY+VwTkbu
         JhsLDOgzCTHDrMbffrKBSwMMx5VhZStwFsXDCf/mOuJYs4AODLop0alGrGTs3pi0kx8H
         VPFsD1yK1KzrEfXrKRGWb2tZVCwViPbayanM+PYkwvUnM2bBVyU4wgzrXOmCEwYcjhoK
         7teg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711633349; x=1712238149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ixIzkD6CcL2ofyOtDwawU0BPi+A2LWUEPg5s7hIMhuE=;
        b=VKF35y4wIA4GZBhZnONn8n5SU5NKHsdhrl9oCOKUWtzOh8zYfDCGsW8w4wOAIBR5ye
         3zM6eZxi1nz+0kFz38bGBirQ+7+HBeV2/1dURdhVX9thBsH35a/6/pGOmgx/n/gyEAYU
         +fG537g20u4X0oocKqPUXFEL9taE9Hc4ALZOS30d7L7bRPki41DHqxnoXN0Cw2GDkzNf
         uhCbKtzyBxuy3k4whrAUsUSH76JlxJKmyGIEcCT2uxbDsSbRJzxB3jcPcaTLhWwYcu+H
         BhqUBvVAGjTjW/Y8aoDSwXbFpf+6k/tl5c5sx2gTMN03ufixzVM3WYh+AJK18xM25gvA
         CbAQ==
X-Gm-Message-State: AOJu0Yxq2TvnRlsAaIHdd4qC8k9kNSlpimJqMZ9MBs9QwtXXshBehxIk
	uginKnMng1DmUjExiYJpw884w0MMfNN28LSHsVJ7wxjgxQI2XhoX2pFFH2q83ba0lgFN+JqJrMH
	xrqI/BI7og/Ai+BfiTwS998mDjvrWZkzakvG7
X-Google-Smtp-Source: AGHT+IGkbnId96GzcSj2h7wcsoDCrGkh5Xrm4lhXFdvmYwRTqt/8iuekzebF0/diRq4+/jhyNqfMiUTBmC1rGd2YcFw=
X-Received: by 2002:a05:6402:2550:b0:56c:53ac:b34 with SMTP id
 l16-20020a056402255000b0056c53ac0b34mr76531edb.1.1711633348920; Thu, 28 Mar
 2024 06:42:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328133542.28572-1-dkirjanov@suse.de>
In-Reply-To: <20240328133542.28572-1-dkirjanov@suse.de>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 28 Mar 2024 14:42:14 +0100
Message-ID: <CANn89iLGZj5MVG-sYpn_eyBTNT7JyunpYgv2aOsxGa9EkNV3Gw@mail.gmail.com>
Subject: Re: [PATCH v3 net] Subject: [PATCH] RDMA/core: fix UAF with ib_device_get_netdev()
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: netdev@vger.kernel.org, jgg@ziepe.ca, leon@kernel.org, 
	Denis Kirjanov <dkirjanov@suse.de>, syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 2:36=E2=80=AFPM Denis Kirjanov <kirjanov@gmail.com>=
 wrote:
>
> A call to ib_device_get_netdev may lead to a race condition
> while accessing a netdevice instance since we don't hold
> the rtnl lock while checking
> the registration state:
>         if (res && res->reg_state !=3D NETREG_REGISTERED) {
>
> v2: unlock rtnl on error path
> v3: update remaining callers of ib_device_get_netdev
>
> Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
> Fixes: d41861942fc55 ("IB/core: Add generic function to extract IB speed =
from netdev")
> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
> ---
>  drivers/infiniband/core/cache.c  |  2 ++
>  drivers/infiniband/core/device.c | 15 ++++++++++++---
>  drivers/infiniband/core/nldev.c  |  2 ++
>  drivers/infiniband/core/verbs.c  |  6 ++++--
>  4 files changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/ca=
che.c
> index c02a96d3572a..cf9c826cd520 100644
> --- a/drivers/infiniband/core/cache.c
> +++ b/drivers/infiniband/core/cache.c
> @@ -1461,7 +1461,9 @@ static int config_non_roce_gid_cache(struct ib_devi=
ce *device,
>                 if (rdma_protocol_iwarp(device, port)) {
>                         struct net_device *ndev;
>
> +                       rtnl_lock();
>                         ndev =3D ib_device_get_netdev(device, port);
> +                       rtnl_unlock();
>                         if (!ndev)
>                                 continue;
>                         RCU_INIT_POINTER(gid_attr.ndev, ndev);
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/d=
evice.c
> index 07cb6c5ffda0..53074a4b04c9 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -2026,9 +2026,12 @@ static int iw_query_port(struct ib_device *device,
>
>         memset(port_attr, 0, sizeof(*port_attr));
>
> +       rtnl_lock();
>         netdev =3D ib_device_get_netdev(device, port_num);
> -       if (!netdev)
> +       if (!netdev) {
> +               rtnl_unlock();
>                 return -ENODEV;
> +       }
>
>         port_attr->max_mtu =3D IB_MTU_4096;
>         port_attr->active_mtu =3D ib_mtu_int_to_enum(netdev->mtu);
> @@ -2052,6 +2055,7 @@ static int iw_query_port(struct ib_device *device,
>                 rcu_read_unlock();
>         }
>
> +       rtnl_unlock();
>         dev_put(netdev);
>         return device->ops.query_port(device, port_num, port_attr);
>  }
> @@ -2220,6 +2224,8 @@ struct net_device *ib_device_get_netdev(struct ib_d=
evice *ib_dev,
>         struct ib_port_data *pdata;
>         struct net_device *res;
>
> +       ASSERT_RTNL();
> +
>         if (!rdma_is_port_valid(ib_dev, port))
>                 return NULL;
>
> @@ -2306,12 +2312,15 @@ void ib_enum_roce_netdev(struct ib_device *ib_dev=
,
>
>         rdma_for_each_port (ib_dev, port)
>                 if (rdma_protocol_roce(ib_dev, port)) {
> -                       struct net_device *idev =3D
> -                               ib_device_get_netdev(ib_dev, port);
> +                       struct net_device *idev;
> +
> +                       rtnl_lock();
> +                       idev =3D ib_device_get_netdev(ib_dev, port);
>
>                         if (filter(ib_dev, port, idev, filter_cookie))
>                                 cb(ib_dev, port, idev, cookie);
>
> +                       rtnl_unlock();
>                         if (idev)
>                                 dev_put(idev);
>                 }
> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nl=
dev.c
> index 4900a0848124..cfa204a224f2 100644
> --- a/drivers/infiniband/core/nldev.c
> +++ b/drivers/infiniband/core/nldev.c
> @@ -360,6 +360,7 @@ static int fill_port_info(struct sk_buff *msg,
>         if (nla_put_u8(msg, RDMA_NLDEV_ATTR_PORT_PHYS_STATE, attr.phys_st=
ate))
>                 return -EMSGSIZE;
>
> +       rtnl_lock();

I am guessing rtnl is already held here.

Please double check all paths you are adding rtnl if this is not going
to deadlock.

>         netdev =3D ib_device_get_netdev(device, port);
>         if (netdev && net_eq(dev_net(netdev), net)) {
>                 ret =3D nla_put_u32(msg,
> @@ -371,6 +372,7 @@ static int fill_port_info(struct sk_buff *msg,
>         }
>
>

Please wait one day before sending a new version, thanks.

