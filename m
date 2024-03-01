Return-Path: <netdev+bounces-76662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B2286E75B
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 18:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9861028F698
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 17:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93F3C2CD;
	Fri,  1 Mar 2024 17:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="miMh1B8Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DDE848E
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 17:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709314363; cv=none; b=cZCBEXKAXCXXN42b6wisGcgR4SfJS73B/mLSH3xMf7FA7eqSsjQRKL/cv3JTkfD80CCNuF1IHjo+pn5mJrpy/ZuvWDGpaN6OydHLWePrbkcFkS2OxT9Ya8u7XgAKNA1ZXJq0NT7Yv+Y7jNqM4lwHg3hp2RI3SFvEn1HWiZw6sWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709314363; c=relaxed/simple;
	bh=Ndp44EsPAYsq52DCQ2OpN10cyPRwcPsUX6yhashe06w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vqw2bkNlW0AXAuVCtJIiGhkgeaMXqiJaD3/BJnjt5KGEHdFR/CCV2nIAeuCdLy/gP8D8jtvjNkF2e4vJ6aCJH69iRI6I0WOTpLcFkpSj7CxuCrkqfRGerf0A3XOh/kWbjARk2tig+50alLpPAmKC3RNBhf4LymJH4tTIOlrLl70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=miMh1B8Z; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4129a748420so90015e9.0
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 09:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709314360; x=1709919160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBXMxDCbKn6Jahu8cl3WKPLn/DabJxYYtm6zmy3zae8=;
        b=miMh1B8ZeZcHAXw5IAwHK8ab8X+ATalt91k6O8iDCuKXKDaG02ZFvf4N8ol6tnHZ+J
         3xSt3fUERf2SrS6EYss+x7+u8cx437fE8XbLil7zTsaeuUPWccqauBvtXSVI8jhprbaw
         8SN+K7OSzl7/ohx8lIqJGxFy/CYTe6yW/XWBfXyYufi85lCtFTPYCD7PH24wIJ/QvqnS
         C/Zei59OtVVGpOPodEdYjqZIrv22rSg/xsaBDaww5wGwfhDmnTUkn33Fq3gw2vtBREyE
         KdoZqzpwwoad0k4IDPxlE6ynLfZvb4sbCgujVERf2ae6PuQ/Q5oRrQOI9FumFGnz7xrC
         5quQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709314360; x=1709919160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBXMxDCbKn6Jahu8cl3WKPLn/DabJxYYtm6zmy3zae8=;
        b=mDOsS+VIzynA++enQ4j30/L/cylyuZYapeJiLFhQSwDSS38o4fYRr+Wv1dMvaPEUjO
         FaCpC2l+GSE2WdDWSF23Ojolp8n5IaNSUPO85fQ4BmYEjiSDcDazsAPIG+isBT3w09qk
         89J+JLY4gpDV8wNLJ+RCu7OmxA9LeuwaxLXrJMGio28N3+YOvv1qmErqzZ+K3cShzALA
         TUt8GkL2kgTPjgx1yUpeuj+GLan30lujNen6MY7ZZS5ak2Wi6RXtuKq8PeXFghGKEzm1
         8xtpCQj5LF17pfmOR/gef03DPVyNVn4mwaOYfWvVTUiAV7dLY0OJRfA8LVkBMJfSl5YP
         7gVA==
X-Forwarded-Encrypted: i=1; AJvYcCX9bsWq/F9nmqh7v+wxi7sh9cWMGuKzrOWTYzGscItYdR7ZxBV8wqvrJvbANrnli1ogO28lTcahgb9McHb0mfEgE9iwefJA
X-Gm-Message-State: AOJu0Yzy9LP0FpkatXbb/2siIYVlEir6AksOGaB2GCYezC1giYQwmvcW
	6O1EtAu7B2OwlgDIwo35RxJOfEQ3YFajfaGG9CgsGBN/iZa9GKQDPpCjp0hJtgYIjz1dvtf5g7I
	oPiJLdiqSeIROXyiJyV7yrefOh5cTeeGH7njpSzznOIe9KxtROR57
X-Google-Smtp-Source: AGHT+IHw6ykLUjOoKAZhnw5aOUSGc3PZ63EFlAqSh1Oi3YFnJl1r17yEWybj5FAznNeywhr+8ahRPIvE26PnXVR1a2o=
X-Received: by 2002:a05:600c:2048:b0:412:ca16:b02d with SMTP id
 p8-20020a05600c204800b00412ca16b02dmr75480wmg.7.1709314360225; Fri, 01 Mar
 2024 09:32:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709217658.git.petrm@nvidia.com> <223614cb8fbe91c6050794762becdd9a3c3b689a.1709217658.git.petrm@nvidia.com>
In-Reply-To: <223614cb8fbe91c6050794762becdd9a3c3b689a.1709217658.git.petrm@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 1 Mar 2024 18:32:26 +0100
Message-ID: <CANn89iLDizzEKi7u0NssSXD_rB6c8EeL==ino-O0a2_BxUN5tw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/7] net: nexthop: Expose nexthop group stats
 to user space
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	mlxsw@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 7:20=E2=80=AFPM Petr Machata <petrm@nvidia.com> wro=
te:
>
> From: Ido Schimmel <idosch@nvidia.com>
>
> Add netlink support for reading NH group stats.
>
> This data is only for statistics of the traffic in the SW datapath. HW
> nexthop group statistics will be added in the following patches.
>
> Emission of the stats is keyed to a new op_stats flag to avoid cluttering
> the netlink message with stats if the user doesn't need them:
> NHA_OP_FLAG_DUMP_STATS.
>
> Co-developed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>
> Notes:
>     v2:
>     - Use uint to encode NHA_GROUP_STATS_ENTRY_PACKETS
>     - Rename jump target in nla_put_nh_group_stats() to avoid
>       having to rename further in the patchset.
>
>  include/uapi/linux/nexthop.h | 30 ++++++++++++
>  net/ipv4/nexthop.c           | 92 ++++++++++++++++++++++++++++++++----
>  2 files changed, 114 insertions(+), 8 deletions(-)
>
> diff --git a/include/uapi/linux/nexthop.h b/include/uapi/linux/nexthop.h
> index 086444e2946c..f4db63c17085 100644
> --- a/include/uapi/linux/nexthop.h
> +++ b/include/uapi/linux/nexthop.h
> @@ -30,6 +30,8 @@ enum {
>
>  #define NEXTHOP_GRP_TYPE_MAX (__NEXTHOP_GRP_TYPE_MAX - 1)
>
> +#define NHA_OP_FLAG_DUMP_STATS         BIT(0)
> +
>  enum {
>         NHA_UNSPEC,
>         NHA_ID,         /* u32; id for nexthop. id =3D=3D 0 means auto-as=
sign */
> @@ -63,6 +65,9 @@ enum {
>         /* u32; operation-specific flags */
>         NHA_OP_FLAGS,
>
> +       /* nested; nexthop group stats */
> +       NHA_GROUP_STATS,
> +
>         __NHA_MAX,
>  };
>
> @@ -104,4 +109,29 @@ enum {
>
>  #define NHA_RES_BUCKET_MAX     (__NHA_RES_BUCKET_MAX - 1)
>
> +enum {
> +       NHA_GROUP_STATS_UNSPEC,
> +
> +       /* nested; nexthop group entry stats */
> +       NHA_GROUP_STATS_ENTRY,
> +
> +       __NHA_GROUP_STATS_MAX,
> +};
> +
> +#define NHA_GROUP_STATS_MAX    (__NHA_GROUP_STATS_MAX - 1)
> +
> +enum {
> +       NHA_GROUP_STATS_ENTRY_UNSPEC,
> +
> +       /* u32; nexthop id of the nexthop group entry */
> +       NHA_GROUP_STATS_ENTRY_ID,
> +
> +       /* uint; number of packets forwarded via the nexthop group entry =
*/
> +       NHA_GROUP_STATS_ENTRY_PACKETS,
> +
> +       __NHA_GROUP_STATS_ENTRY_MAX,
> +};
> +
> +#define NHA_GROUP_STATS_ENTRY_MAX      (__NHA_GROUP_STATS_ENTRY_MAX - 1)
> +
>  #endif
> diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
> index 4be66622e24f..0ede8777bd66 100644
> --- a/net/ipv4/nexthop.c
> +++ b/net/ipv4/nexthop.c
> @@ -41,7 +41,8 @@ static const struct nla_policy rtm_nh_policy_new[] =3D =
{
>
>  static const struct nla_policy rtm_nh_policy_get[] =3D {
>         [NHA_ID]                =3D { .type =3D NLA_U32 },
> -       [NHA_OP_FLAGS]          =3D NLA_POLICY_MASK(NLA_U32, 0),
> +       [NHA_OP_FLAGS]          =3D NLA_POLICY_MASK(NLA_U32,
> +                                                 NHA_OP_FLAG_DUMP_STATS)=
,
>  };
>
>  static const struct nla_policy rtm_nh_policy_del[] =3D {
> @@ -53,7 +54,8 @@ static const struct nla_policy rtm_nh_policy_dump[] =3D=
 {
>         [NHA_GROUPS]            =3D { .type =3D NLA_FLAG },
>         [NHA_MASTER]            =3D { .type =3D NLA_U32 },
>         [NHA_FDB]               =3D { .type =3D NLA_FLAG },
> -       [NHA_OP_FLAGS]          =3D NLA_POLICY_MASK(NLA_U32, 0),
> +       [NHA_OP_FLAGS]          =3D NLA_POLICY_MASK(NLA_U32,
> +                                                 NHA_OP_FLAG_DUMP_STATS)=
,
>  };
>
>  static const struct nla_policy rtm_nh_res_policy_new[] =3D {
> @@ -661,8 +663,77 @@ static int nla_put_nh_group_res(struct sk_buff *skb,=
 struct nh_group *nhg)
>         return -EMSGSIZE;
>  }
>
> -static int nla_put_nh_group(struct sk_buff *skb, struct nh_group *nhg)
> +static void nh_grp_entry_stats_read(struct nh_grp_entry *nhge,
> +                                   struct nh_grp_entry_stats *stats)
>  {
> +       int i;
> +
> +       memset(stats, 0, sizeof(*stats));
> +       for_each_possible_cpu(i) {
> +               struct nh_grp_entry_stats *cpu_stats;
> +               unsigned int start;
> +               u64 packets;
> +
> +               cpu_stats =3D per_cpu_ptr(nhge->stats, i);
> +               do {
> +                       start =3D u64_stats_fetch_begin(&cpu_stats->syncp=
);
> +                       packets =3D cpu_stats->packets;

This is not safe, even on 64bit arches.

You should use u64_stats_t, u64_stats_read(), u64_stats_add() ...

> +               } while (u64_stats_fetch_retry(&cpu_stats->syncp, start))=
;
> +
> +               stats->packets +=3D packets;
> +       }
> +}

