Return-Path: <netdev+bounces-131735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 522A698F616
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 20:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85C5DB216E1
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 18:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B274E1AAE2B;
	Thu,  3 Oct 2024 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bMAyinFJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCE81A7062
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 18:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727980185; cv=none; b=dyP4VRRoCrZYHZIOYYlbWNHgARRDcXG/jRUkYb2rAejSEfsWzNRanITr9lIc7ztmWCyUq7EDUwTxEPK7XcUw6H8F1GqK5jqtO2VVci6Z7+YzCCg2xOQ4HXaZAj07mLhc8oDd0D9UHjDzflyKUbA0Cmb/SavhmT+OAKrGLe3H/kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727980185; c=relaxed/simple;
	bh=2qzxjKFrcEgUqWUnrIEiNSe6Cm82aybNgOP5SBjCt5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+X1UR3fxXlG4sXz+uIqAom3hcweZCELHcdgg8W36PVCFVYuGNbAKdOm/MwgWMAjx4IA+6BQMoU3yQ/iR2W4zpdESKSiOsuHnp5/gY8ilMfQv14UbQDh1aCBJC43txiuX8ipK+tSKFEbwPu7QsZd8t7HeSKLCbGvgDtE+eVecr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bMAyinFJ; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-45b4e638a9aso40531cf.1
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 11:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727980183; x=1728584983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S1k4ChpIfL1zYPEqDQYtaSA7c5Ed/Wun853K5E1/PAs=;
        b=bMAyinFJSZyMrvmgJSzQaWpWBpvmWG5ctTC/6xPvcVREVS+5mrvvGw0az7nq+cuoDl
         ETZ8FiPdVB1Maq1rkl7/gUtJivwQqpiVZY5ZoZ8awIILduh8FQuf6CbpvkJs7sd2aL/r
         j3x5n191lJXrx0oy3GvQSmXIsiS4u3Wzc7igOcErBsgauwY/GQFZDZHKmED3zn9TEowC
         wyhSAhrfWVaF4R13Tw3r10tNV5HVWnGQDeMyx1BJdYa//BxmIOS3VMNMMNuExC8fJNZg
         GSEbnqTBpIaGvEiHHyXHVEG4v96nnZHC61Ag7aKnwCGS/GeeUX+VzZIyOZQdTGm8q3Km
         Y5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727980183; x=1728584983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1k4ChpIfL1zYPEqDQYtaSA7c5Ed/Wun853K5E1/PAs=;
        b=L25Jqp2DFljrcz+AyaLjmtkfpissbdSrp1HI0OtqkRgKYxWRTPM4bqqY965fJzcRp0
         d7GW4mSKkYQHChvbvo23rJxFCXb6KjMrFtXK6n+nsXEg5T+4Ea6hCHoFzBh6qcQQSOYG
         NeyVYnahcJrvJ8wKK75sgPY5dd22hTt4e4kklXw+j28k+FYZaLi1jeodoD3PrKLj/wlj
         QuszsaSPs60wBDjPz3GwFtSUCrsDqccmxUGVLHLKe6NLo/YE6H72qxZDZZTZFanMy3yl
         K3om/xg4vXvei2/HYDp4fgo7eQ5DJD1eaXt02JkhM1zypBONuuphcJPUj1KJ8bbPTGyJ
         u0eg==
X-Forwarded-Encrypted: i=1; AJvYcCXe3CZtOC5iniqvrMVIOmoWDx0kXchgjsMXu2hVrJb/XCANyvFKtY3R1wt3zY7cLCAaAp4BOcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQIGA6FzldpFig5pSWAAZKoqRIqNwxbIGtFeqUOZGAhYQOccUL
	D++9OLRSi2Bq/a2kWFc8kccBwj+WIK0LbH6ft+lLJlLMfsdwzv6hAagN4Eda6zDz8xZKab29cZ2
	K4KPfErO4AFmayOpha0t912WPqASZEgmwpz2b
X-Google-Smtp-Source: AGHT+IElUOfsfGZ3a15mzNpIMkSq4GH7lKflIH4h5T4vTiw9MweG5FIZIJTWK73RDKR2BnrZNo/Er4WCmRHGtJQDGhA=
X-Received: by 2002:a05:622a:8491:b0:456:7f71:ca78 with SMTP id
 d75a77b69052e-45d9bb8b832mr115711cf.4.1727980182769; Thu, 03 Oct 2024
 11:29:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003160620.1521626-1-ap420073@gmail.com> <20241003160620.1521626-6-ap420073@gmail.com>
In-Reply-To: <20241003160620.1521626-6-ap420073@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 3 Oct 2024 11:29:29 -0700
Message-ID: <CAHS8izNwnBnZf6P0WtAcg+MjmaxXDZ++kYit8_Ac8r6y=cDMAQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/7] net: devmem: add ring parameter filtering
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	donald.hunter@gmail.com, corbet@lwn.net, michael.chan@broadcom.com, 
	kory.maincent@bootlin.com, andrew@lunn.ch, maxime.chevallier@bootlin.com, 
	danieller@nvidia.com, hengqi@linux.alibaba.com, ecree.xilinx@gmail.com, 
	przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com, 
	paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	asml.silence@gmail.com, kaiyuanz@google.com, willemb@google.com, 
	aleksander.lobakin@intel.com, dw@davidwei.uk, sridhar.samudrala@intel.com, 
	bcreeley@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 9:07=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wrot=
e:
>
> If driver doesn't support ring parameter or tcp-data-split configuration
> is not sufficient, the devmem should not be set up.
> Before setup the devmem, tcp-data-split should be ON and
> tcp-data-split-thresh value should be 0.
>
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
>
> v3:
>  - Patch added.
>
>  net/core/devmem.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 11b91c12ee11..a9e9b15028e0 100644
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
> @@ -146,6 +150,20 @@ int net_devmem_bind_dmabuf_to_queue(struct net_devic=
e *dev, u32 rxq_idx,
>                 return -EEXIST;
>         }
>
> +       if (!dev->ethtool_ops->get_ringparam) {
> +               NL_SET_ERR_MSG(extack, "can't get ringparam");
> +               return -EINVAL;
> +       }
> +
> +       dev->ethtool_ops->get_ringparam(dev, &ringparam,
> +                                       &kernel_ringparam, extack);
> +       if (kernel_ringparam.tcp_data_split !=3D ETHTOOL_TCP_DATA_SPLIT_E=
NABLED ||

The way I had set this up is that the driver checks whether header
split is enabled, and only sets PP_FLAG_ALLOW_UNREADABLE_NETMEM if it
is. Then core detects that the driver did not allow unreadable netmem
and it fails that way.

This check is redundant with that. I'm not 100% opposed to redundant
checks. Maybe they will add some reliability, but also maybe they will
be confusing to check the same thing essentially in 2 places.

Is the PP_FLAG_ALLOW_UNREADABLE_NETMEM trick not sufficient for you?

> +           kernel_ringparam.tcp_data_split_thresh) {
> +               NL_SET_ERR_MSG(extack,
> +                              "tcp-header-data-split is disabled or thre=
shold is not zero");
> +               return -EINVAL;
> +       }
> +
>  #ifdef CONFIG_XDP_SOCKETS
>         if (rxq->pool) {
>                 NL_SET_ERR_MSG(extack, "designated queue already in use b=
y AF_XDP");
> --
> 2.34.1
>


--=20
Thanks,
Mina

