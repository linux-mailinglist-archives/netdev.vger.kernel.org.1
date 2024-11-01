Return-Path: <netdev+bounces-141039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4479B932F
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 15:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003371F236F5
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 14:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DA91A76CD;
	Fri,  1 Nov 2024 14:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KU9Hw65+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E611A4F12
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 14:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730471360; cv=none; b=WEzcF9gGamYZHJ2RIH20qajK+Gms9oc+P3RE6zwY11aqlNcwKLpTfEPKIDI6pmKaCTc5EsqVI/h+95lLuRsQ/25syz3fjBiOgvdtAL5oyPj9eqewPw28yLgMIO4h1IF/OjJsosM4Pe3WU02Z6Vau1MGXmmIKicbYVdgD2xjcteU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730471360; c=relaxed/simple;
	bh=eJVNvJnZLTG4PpxBtX9b0krF09fZgAY5tkl/hJZTlyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rcQXxPZ2kj0XiyZKBr+X3x1wvNJb0X9gqUTx0HS15Sk8Y/3CbygtF7Poh+dJEq//SLYY8P9mSvBzDiGcDAxwzZ2j3h2xWTiuyD2odJ/B18JDxsG7ssPHud5t6Wiaz7Oua4mK1lDqq6wqmePuYrnUnLMxxIOfjHy2ZrqbtBoIuwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KU9Hw65+; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-460b295b9eeso138761cf.1
        for <netdev@vger.kernel.org>; Fri, 01 Nov 2024 07:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730471356; x=1731076156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71rDrn/xSyrSel5+3YD+U/lkEjJUJKYWwLFn/ivmxck=;
        b=KU9Hw65+obka9tr/pM5cR/jNGsgQzIcHig0dyxxDBX0kh1mHE5/auhSDDlvO4KWOZ4
         i25/rSX7cwnOjYoE912O+SnQhhBdrNsXIdnhwuGrWrrjJnqy+0XP/kJliUymcNUCmIc7
         Yv/lC/lztn8oZtGzzhQ/i4SP1eabCNQMyVPfdtEInRhsUQ0Lp9al8J/oONCi1pxFaxXZ
         ArdQ0DZRylzVCkOubQ3Hia4GOf+jy2NEJgGHuJW+xWp0cxTb9rJXm2nZBwU+FPbmbqnm
         XbIzmbjRbz3T8y4ycgNpbVmzqBSExGHH8K9LzqIGSfrJsvxtRlBLD+8cLjo/qnjk33m0
         R6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730471356; x=1731076156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=71rDrn/xSyrSel5+3YD+U/lkEjJUJKYWwLFn/ivmxck=;
        b=WMopg4TB5S+332hXX7mwM8KRsQYhMnsIDHxaF4LMyPQfO/iLnLqzfvnJomIYAzucy7
         xfcOT2NFE9jcrtEBypcep7lTjuJ9yDqYEd6gvfIm/lnMqH+FMhq1IEnBDvwLybvTlvJN
         2x6EdvNbGsznSdW6SszVc1eBUiNcKQ3fMbl2F6bF4FS6ARi1A253CfkhJ5YrRO84ouus
         bj+4vnCVpDxiFGQF9xvyVU0tlaHpinFPID3Homn6zvulSymFBusy5z9je1AdEwo0ZEw4
         txW6X8zrAr5DrVVfYwWozpoCKJCzd5tlWtglwNAEdAWgbl/GXpGWmVsF0gpP5BhSrg0D
         Rnlw==
X-Forwarded-Encrypted: i=1; AJvYcCXhA8x5gvRpW7Po0Ahvdt08SIrMlkYt7tOTaRx9tLNYMr71g1MIg176el/1A3XA02QBIV5WUE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlcI4QDRZu5+Ev8q1tpd/ACraMkoilLXZqQ/LBYHMVP72DDW84
	apW/tqaDuvoyBCSlLKcowvx/SfCA9V/oXyC5SKAS95/An6nMgWWzGg88absRpSWaHRrxVN+jk8H
	pE6SjkzTdJwEhCvpwlNCt4OTVCGQW8bE8+rTx
X-Gm-Gg: ASbGncs/Uv7t6TgshF6O6yf44/HZNYZAf7odjfs6dp/w8k1O+0qsstfcR+VKCLrCOKz
	+0imqMZNt48BmmPDnKlrXOEwiTBEp4FQ=
X-Google-Smtp-Source: AGHT+IHfPf4efEtalOK8WUuB9JdEhR5RMnc0VUPGI/FfzKul0egqfNyIe0EJS2sbq6VHEkHbfxIaYbjkGSJgcXA7P3I=
X-Received: by 2002:a05:622a:614:b0:461:4be1:c612 with SMTP id
 d75a77b69052e-462ad2da722mr6592141cf.21.1730471356319; Fri, 01 Nov 2024
 07:29:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022162359.2713094-1-ap420073@gmail.com> <20241022162359.2713094-6-ap420073@gmail.com>
In-Reply-To: <20241022162359.2713094-6-ap420073@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 1 Nov 2024 07:29:04 -0700
Message-ID: <CAHS8izNbS4i+ke0bK07-rNLuq6RGXD-H73DhVb1-tsUOzSCBog@mail.gmail.com>
Subject: Re: [PATCH net-next v4 5/8] net: devmem: add ring parameter filtering
To: Taehee Yoo <ap420073@gmail.com>, Praveen Kaligineedi <pkaligineedi@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, donald.hunter@gmail.com, corbet@lwn.net, 
	michael.chan@broadcom.com, andrew+netdev@lunn.ch, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me, 
	asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, kory.maincent@bootlin.com, 
	maxime.chevallier@bootlin.com, danieller@nvidia.com, hengqi@linux.alibaba.com, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, 
	ahmed.zaki@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	jiri@resnulli.us, bigeasy@linutronix.de, lorenzo@kernel.org, 
	jdamato@fastly.com, aleksander.lobakin@intel.com, kaiyuanz@google.com, 
	willemb@google.com, daniel.zahka@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Taehee, sorry for the late reply. I was out on vacation and needed
to catch up on some stuff when I got back.

On Tue, Oct 22, 2024 at 9:25=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wro=
te:
>
> If driver doesn't support ring parameter or tcp-data-split configuration
> is not sufficient, the devmem should not be set up.
> Before setup the devmem, tcp-data-split should be ON and
> header-data-split-thresh value should be 0.
>
> Tested-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
>
> v4:
>  - Check condition before __netif_get_rx_queue().
>  - Separate condition check.
>  - Add Test tag from Stanislav.
>
> v3:
>  - Patch added.
>
>  net/core/devmem.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 11b91c12ee11..3425e872e87a 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -8,6 +8,8 @@
>   */
>
>  #include <linux/dma-buf.h>
> +#include <linux/ethtool.h>
> +#include <linux/ethtool_netlink.h>
>  #include <linux/genalloc.h>
>  #include <linux/mm.h>
>  #include <linux/netdevice.h>
> @@ -131,6 +133,8 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device=
 *dev, u32 rxq_idx,
>                                     struct net_devmem_dmabuf_binding *bin=
ding,
>                                     struct netlink_ext_ack *extack)
>  {
> +       struct kernel_ethtool_ringparam kernel_ringparam =3D {};
> +       struct ethtool_ringparam ringparam =3D {};
>         struct netdev_rx_queue *rxq;
>         u32 xa_idx;
>         int err;
> @@ -140,6 +144,20 @@ int net_devmem_bind_dmabuf_to_queue(struct net_devic=
e *dev, u32 rxq_idx,
>                 return -ERANGE;
>         }
>
> +       if (!dev->ethtool_ops->get_ringparam)
> +               return -EOPNOTSUPP;
> +

Maybe an error code not EOPNOTSUPP. I think that gets returned when
NET_DEVMEM is not compiled in and other situations like that. Lets
pick another error code? Maybe ENODEV.

Also consider extack error message. But it's very unlikely to hit this
error, so maybe not necessary.

> +       dev->ethtool_ops->get_ringparam(dev, &ringparam, &kernel_ringpara=
m,
> +                                       extack);
> +       if (kernel_ringparam.tcp_data_split !=3D ETHTOOL_TCP_DATA_SPLIT_E=
NABLED) {
> +               NL_SET_ERR_MSG(extack, "tcp-data-split is disabled");
> +               return -EINVAL;
> +       }
> +       if (kernel_ringparam.hds_thresh) {
> +               NL_SET_ERR_MSG(extack, "header-data-split-thresh is not z=
ero");
> +               return -EINVAL;
> +       }
> +

Thinking about drivers that support tcp-data-split, but don't support
any kind of hds_thresh. For us (GVE), the hds_thresh is implicitly
always 0.

Does the driver need to explicitly set hds_thresh to 0? If so, that
adds a bit of churn to driver code. Is it possible to detect in this
function that the driver doesn't support hds_thresh and allow the
binding if so?

I see in the previous patch you do something like:

supported_ring_params & ETHTOOL_RING_USE_HDS_THRS

To detect there is hds_thresh support. I was wondering if something
like this is possible so we don't have to update GVE and all future
drivers to explicitly set thresh to 0.

Other than that, looks fine to me.


--=20
Thanks,
Mina

