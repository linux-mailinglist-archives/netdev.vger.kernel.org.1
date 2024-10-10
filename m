Return-Path: <netdev+bounces-134055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF78997BC3
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 06:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01C21C21FA0
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 04:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B965C19D890;
	Thu, 10 Oct 2024 04:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KFFIWhB7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD92615B0F2
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 04:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728534310; cv=none; b=mua8EQW/edi5LSci18rN0QSrjiIsRUmcnv8misGF4+fsONjCVK7T4tGC1nb8V9P/tFVEt1RzsFXwUXwA+6DGqfw/6WFZctsyNcc8d+tIlhmTZLAJGXIwikZe8KAfZkoCgZwCM5hY/yZqmE+2q31Q4HMjTzfdRCUVdD0tycwXSsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728534310; c=relaxed/simple;
	bh=IzrgkmuURIu8MAwSdYUsLYVkJkijsn1AfNL7OptyW/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PgduUVHsOLkEEXjIY7tinf3/uG1+5hGSfLZ9C4hDhWCnTQkcTNh1tj/PwQb/j7f6oyRmiOSDBrBzANKhjc7IPfAaVr96Cr2lxrsf0Hzlu/qG0KlGgwRtUoCcWeToQ8ZcXn51cTo7xslaZNvAgPWYmdYslknKozSPWC1Sbe0mKYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KFFIWhB7; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c896b9b3e1so571477a12.2
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 21:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728534306; x=1729139106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vS+5mt2Jic6TNgTcrAq7H8a5Jt96tTYPxl+St69+/88=;
        b=KFFIWhB7XxViHuO8bU3/hnPTZAE1hTVs26PPaTEugtRhdH9SSSnGZJqLTFECEDplfc
         r2wRwSY8eyGqEMDaZFWC7wlpwVqTuihcfV1rNXX7dkYnTlKTsgrrjndDCWokIdVDltJy
         n+8AR0oYMgxhNBc1vyXomFCXud5MwPO7Wy1/hEGexb6FEil0PsufxwFxsL6yBZSZSGoN
         y26ikF3e8+0NiLtHVifN1oG9D+BtJjlTPmJTSfMe8aRqUuYaUF+Cvbz4ByIGHiWs6FHE
         cSxJ+zTTm9jQ3F+PMW5XY1fTUNGyIIzdQaG++R6v+z2+DxxI3u1+j77tSkgwikqibu9z
         e6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728534306; x=1729139106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vS+5mt2Jic6TNgTcrAq7H8a5Jt96tTYPxl+St69+/88=;
        b=mCOVoTWtZZhsKGKD7HhIO9H6NCfy/dasvw/Mqcurf+a/llsl25m5+TdUe0XLX2uBp6
         SNe6SbjjHSnKRH5y/1UfpUv+XJI+VKg/ZOsfPr3b5KF7GWeIV9BP/Y/AiVGKRJM08zKd
         njvzg+KxazUkSKtUB5NPQl9lR+6upjsmnhhVL94b+MdDjth+36V82QLPMMHOHNygxtsA
         A+d/wjgc6AydUwSJ63LD2DpXd5NvbXZlyMolSZIcJm+96KjesFbEEIQPPXyyuMWrSKBx
         mWFc/5bTMfCgpHwhRvZdaPV2/KKQKDkJnSzlfLVym7K5CcBqWxPRJSu1RJj/z1+kwKRL
         rrPg==
X-Gm-Message-State: AOJu0YxFnTZ0ixhq3I4j/zONuDBELBsNvqw/R3x3jmubEhd9JgsiNUHI
	NyIX0PEMIFdt1e9rnZtXKSFFbYy/YuKwkrOUA4aGsTsVyfRpLTSGPDgD/n6rrVDsFXn6YPRnuE2
	2M05zb1hY5W4ek3Ocr4wbxWY/hKrObx4BOa0n
X-Google-Smtp-Source: AGHT+IEgVe8WI6zZ9IXhPwM6gk7DQh07FJlH2KuBbAQRppOjApcfrMvKt96YYXcJnGDeQF5QVjBzy/Z/rbbCOB2UUbM=
X-Received: by 2002:a05:6402:518f:b0:5c7:1ed7:8825 with SMTP id
 4fb4d7f45d1cf-5c91d5817c6mr3750836a12.12.1728534305884; Wed, 09 Oct 2024
 21:25:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009005525.13651-1-jdamato@fastly.com> <20241009005525.13651-7-jdamato@fastly.com>
In-Reply-To: <20241009005525.13651-7-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 06:24:54 +0200
Message-ID: <CANn89iJ1=xA9WGhXAMcCAeacE3pYgqiWjcBdxiWjGPACP-5n_g@mail.gmail.com>
Subject: Re: [net-next v5 6/9] netdev-genl: Support setting per-NAPI config values
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com, 
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com, 
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Mina Almasry <almasrymina@google.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 2:56=E2=80=AFAM Joe Damato <jdamato@fastly.com> wrot=
e:
>
> Add support to set per-NAPI defer_hard_irqs and gro_flush_timeout.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  Documentation/netlink/specs/netdev.yaml | 11 ++++++
>  include/uapi/linux/netdev.h             |  1 +
>  net/core/netdev-genl-gen.c              | 18 ++++++++++
>  net/core/netdev-genl-gen.h              |  1 +
>  net/core/netdev-genl.c                  | 45 +++++++++++++++++++++++++
>  tools/include/uapi/linux/netdev.h       |  1 +
>  6 files changed, 77 insertions(+)
>
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netl=
ink/specs/netdev.yaml
> index bf13613eaa0d..7b4ea5a6e73d 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -690,6 +690,17 @@ operations:
>          reply:
>            attributes:
>              - id
> +    -
> +      name: napi-set
> +      doc: Set configurable NAPI instance settings.
> +      attribute-set: napi
> +      flags: [ admin-perm ]
> +      do:
> +        request:
> +          attributes:
> +            - id
> +            - defer-hard-irqs
> +            - gro-flush-timeout
>
>  kernel-family:
>    headers: [ "linux/list.h"]
> diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> index cacd33359c76..e3ebb49f60d2 100644
> --- a/include/uapi/linux/netdev.h
> +++ b/include/uapi/linux/netdev.h
> @@ -201,6 +201,7 @@ enum {
>         NETDEV_CMD_NAPI_GET,
>         NETDEV_CMD_QSTATS_GET,
>         NETDEV_CMD_BIND_RX,
> +       NETDEV_CMD_NAPI_SET,
>
>         __NETDEV_CMD_MAX,
>         NETDEV_CMD_MAX =3D (__NETDEV_CMD_MAX - 1)
> diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
> index b28424ae06d5..e197bd84997c 100644
> --- a/net/core/netdev-genl-gen.c
> +++ b/net/core/netdev-genl-gen.c
> @@ -22,6 +22,10 @@ static const struct netlink_range_validation netdev_a_=
page_pool_ifindex_range =3D
>         .max    =3D 2147483647ULL,
>  };
>
> +static const struct netlink_range_validation netdev_a_napi_defer_hard_ir=
qs_range =3D {
> +       .max    =3D 2147483647ULL,

Would (u64)INT_MAX  work ?

> +};
> +
>  /* Common nested types */
>  const struct nla_policy netdev_page_pool_info_nl_policy[NETDEV_A_PAGE_PO=
OL_IFINDEX + 1] =3D {
>         [NETDEV_A_PAGE_POOL_ID] =3D NLA_POLICY_FULL_RANGE(NLA_UINT, &netd=
ev_a_page_pool_id_range),
> @@ -87,6 +91,13 @@ static const struct nla_policy netdev_bind_rx_nl_polic=
y[NETDEV_A_DMABUF_FD + 1]
>         [NETDEV_A_DMABUF_QUEUES] =3D NLA_POLICY_NESTED(netdev_queue_id_nl=
_policy),
>  };
>
> +/* NETDEV_CMD_NAPI_SET - do */
> +static const struct nla_policy netdev_napi_set_nl_policy[NETDEV_A_NAPI_G=
RO_FLUSH_TIMEOUT + 1] =3D {
> +       [NETDEV_A_NAPI_ID] =3D { .type =3D NLA_U32, },
> +       [NETDEV_A_NAPI_DEFER_HARD_IRQS] =3D NLA_POLICY_FULL_RANGE(NLA_U32=
, &netdev_a_napi_defer_hard_irqs_range),
> +       [NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT] =3D { .type =3D NLA_UINT, },
> +};
> +
>  /* Ops table for netdev */
>  static const struct genl_split_ops netdev_nl_ops[] =3D {
>         {
> @@ -171,6 +182,13 @@ static const struct genl_split_ops netdev_nl_ops[] =
=3D {
>                 .maxattr        =3D NETDEV_A_DMABUF_FD,
>                 .flags          =3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>         },
> +       {
> +               .cmd            =3D NETDEV_CMD_NAPI_SET,
> +               .doit           =3D netdev_nl_napi_set_doit,
> +               .policy         =3D netdev_napi_set_nl_policy,
> +               .maxattr        =3D NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT,
> +               .flags          =3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> +       },
>  };
>
>  static const struct genl_multicast_group netdev_nl_mcgrps[] =3D {
> diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
> index 8cda334fd042..e09dd7539ff2 100644
> --- a/net/core/netdev-genl-gen.h
> +++ b/net/core/netdev-genl-gen.h
> @@ -33,6 +33,7 @@ int netdev_nl_napi_get_dumpit(struct sk_buff *skb, stru=
ct netlink_callback *cb);
>  int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
>                                 struct netlink_callback *cb);
>  int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info);
> +int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info)=
;
>
>  enum {
>         NETDEV_NLGRP_MGMT,
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 64e5e4cee60d..59523318d620 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -303,6 +303,51 @@ int netdev_nl_napi_get_dumpit(struct sk_buff *skb, s=
truct netlink_callback *cb)
>         return err;
>  }
>
> +static int
> +netdev_nl_napi_set_config(struct napi_struct *napi, struct genl_info *in=
fo)
> +{
> +       u64 gro_flush_timeout =3D 0;
> +       u32 defer =3D 0;
> +
> +       if (info->attrs[NETDEV_A_NAPI_DEFER_HARD_IRQS]) {
> +               defer =3D nla_get_u32(info->attrs[NETDEV_A_NAPI_DEFER_HAR=
D_IRQS]);
> +               napi_set_defer_hard_irqs(napi, defer);
> +       }
> +
> +       if (info->attrs[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT]) {
> +               gro_flush_timeout =3D nla_get_uint(info->attrs[NETDEV_A_N=
API_GRO_FLUSH_TIMEOUT]);
> +               napi_set_gro_flush_timeout(napi, gro_flush_timeout);
> +       }
> +
> +       return 0;
> +}
> +
> +int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +       struct napi_struct *napi;
> +       unsigned int napi_id;
> +       int err;
> +
> +       if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_NAPI_ID))
> +               return -EINVAL;
> +
> +       napi_id =3D nla_get_u32(info->attrs[NETDEV_A_NAPI_ID]);
> +
> +       rtnl_lock();

Hmm.... please see my patch there :

 https://patchwork.kernel.org/project/netdevbpf/patch/20241009232728.107604=
-2-edumazet@google.com/

Lets not add another rtnl_lock() :/

> +
> +       napi =3D napi_by_id(napi_id);
> +       if (napi) {
> +               err =3D netdev_nl_napi_set_config(napi, info);
> +       } else {
> +               NL_SET_BAD_ATTR(info->extack, info->attrs[NETDEV_A_NAPI_I=
D]);
> +               err =3D -ENOENT;
> +       }
> +
> +       rtnl_unlock();
> +
> +       return err;
> +}
> +
>  static int
>  netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
>                          u32 q_idx, u32 q_type, const struct genl_info *i=
nfo)
> diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux=
/netdev.h
> index cacd33359c76..e3ebb49f60d2 100644
> --- a/tools/include/uapi/linux/netdev.h
> +++ b/tools/include/uapi/linux/netdev.h
> @@ -201,6 +201,7 @@ enum {
>         NETDEV_CMD_NAPI_GET,
>         NETDEV_CMD_QSTATS_GET,
>         NETDEV_CMD_BIND_RX,
> +       NETDEV_CMD_NAPI_SET,
>
>         __NETDEV_CMD_MAX,
>         NETDEV_CMD_MAX =3D (__NETDEV_CMD_MAX - 1)
> --
> 2.34.1
>

