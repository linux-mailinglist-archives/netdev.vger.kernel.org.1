Return-Path: <netdev+bounces-89883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B675D8AC0EA
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 21:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41D91C20981
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 19:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3633F9FC;
	Sun, 21 Apr 2024 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M0nfp+Ph"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C109F3E478
	for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 19:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713727053; cv=none; b=oYgfFetXbGwXXgpMlr1Mc5l3VIPxgK7ivAVqDswWCukelTPs4DM8DOKwL92/6lCt9wUSg+O1GQUfUBZ1Zmew5Ia3wKf4/d/pERXDe/pRTWD2G9cArrSpSN7cTM04jysLAjSo+6+bVpXmBiH1aPREhr7iXBLszRKalFfYrql5G4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713727053; c=relaxed/simple;
	bh=+/8QEE9YePSg/galLpFrDm4GY3g598oBFhiLGTRLf0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHKZ36bZI/7eiRte79Is/vs9naSmS+iYwoJXZnxg8elMd5YlMeouTujivZTJw6vmM7bNn8WFDPpfy2RCqCp2NjPAN3etOUnfs+d5XB9a8oRPwNb0vvOaj2GJFOq1wxMFfbEbVysyqGrCctXQI5uvrA2nwCP4QU46r0fjoajA+6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M0nfp+Ph; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-571b5fba660so6814a12.1
        for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 12:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713727050; x=1714331850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eze0LsHzPJ7SDHFDA7mSkhV7oL+4KuAEW53gwAGUEn0=;
        b=M0nfp+PhitIw6ITMeD8BSq9JUIrKh5bONiAPHc8OY2JjsRhwQvF6SBkWh9uf4OPSOX
         oNRUs7Ml1Xcv+KEZ/JvvbSGGIV3RIYrUFjWt11ducUfVzFcOLxmJc1ZOKNnbY8gO+JKz
         VWvSy51UKTmL1OYQEc8cFm883lW2zgY8H4zF2vqLhMEZuhlKa/UjMKrifCltaZtOFB3W
         YFiasmCrAdsTpddH9SsLVdD8hy/P9OX+kRLMafwhsSg3LaQ09KSmc+0gE5lHjOCk5mT5
         HnZU193RneLW0C16eX7FEzGJsFZg8fOV4RXSc6Y+qO+D4ANUcL7A6+6J48+gCuCDIzl8
         2iBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713727050; x=1714331850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eze0LsHzPJ7SDHFDA7mSkhV7oL+4KuAEW53gwAGUEn0=;
        b=RCtljOVqs/4Qv9dnq+9ytzmkpaEA95DglvoD/73lfJU7mHVRZL0Crtc/Dcllvs/ZZS
         Jr/N1HJSp9eO/10wnE9R0npYsKtv2Q3ymzml3p7F0acpyGcHhGd0gDfV0kGykjlIJXBu
         mesC+DxdvxUWO2pwksuOQTzomp8AV/ONcOd6JWmBmkEywRbIq/53euGMnN1m0wpnvlcb
         rg01AxKvaoRBMOaVZ5yuEpi3wG2+2srSWT4Tg/L6/eEhzzZbyIUTjXoXUBTViHmyjCxy
         TPBgJXsJvBRvDS4ilM3lDRsFdfAxiINJY1AI8h9N1yeziczDAYlcYk1cgzE0u61Rnpxf
         eicw==
X-Forwarded-Encrypted: i=1; AJvYcCVlB/QhQPeBN5cYK6PC1igDiYa7ETvzYWlqK72xzMDFlDjcV0oVSn9FuJ/tGA/1xP8ARmpvHm5yrjwsHNNsN2+Tm+8gFIW8
X-Gm-Message-State: AOJu0YxLbPOEYfHHBpWAr/ABSyPlm+p8DZ/auiQfwN55IuaYohWSiQyJ
	kxdpgjg7MFSoYyqcVXGqCh5714WutZdG4hf+SPKgAtGw0NlSOMJPFJhe/c9r8+zXsRRh+iqCbPK
	iKr0Qq7oF5hAmKhddUk1368LVQpC2L+xhBo+l
X-Google-Smtp-Source: AGHT+IF39jxMUkxtZgUhyXYhczCnLxgPMBrWmEVVmDip7RrgTHiI0P9fFfVq/hyxb78FF6LRw4+Y57GRQ7DNMkerZjI=
X-Received: by 2002:a05:6402:12c8:b0:571:d30b:18a0 with SMTP id
 k8-20020a05640212c800b00571d30b18a0mr153361edx.0.1713727049828; Sun, 21 Apr
 2024 12:17:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420023543.3300306-1-kuba@kernel.org> <20240420023543.3300306-2-kuba@kernel.org>
In-Reply-To: <20240420023543.3300306-2-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 21 Apr 2024 21:17:15 +0200
Message-ID: <CANn89iK-wnNeH+9-Oe6xi9OjoY5jcZCowJ5wDL7hJz1tRhMfQQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] netdev: support dumping a single netdev in qstats
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	shuah@kernel.org, sdf@google.com, amritha.nambiar@intel.com, 
	linux-kselftest@vger.kernel.org, dsahern@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 4:35=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Having to filter the right ifindex in the tests is a bit tedious.
> Add support for dumping qstats for a single ifindex.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/netlink/specs/netdev.yaml |  1 +
>  net/core/netdev-genl-gen.c              |  1 +
>  net/core/netdev-genl.c                  | 52 ++++++++++++++++++-------
>  3 files changed, 41 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netl=
ink/specs/netdev.yaml
> index 76352dbd2be4..679c4130707c 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -486,6 +486,7 @@ name: netdev
>        dump:
>          request:
>            attributes:
> +            - ifindex
>              - scope
>          reply:
>            attributes:
> diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
> index 8d8ace9ef87f..8350a0afa9ec 100644
> --- a/net/core/netdev-genl-gen.c
> +++ b/net/core/netdev-genl-gen.c
> @@ -70,6 +70,7 @@ static const struct nla_policy netdev_napi_get_dump_nl_=
policy[NETDEV_A_NAPI_IFIN
>
>  /* NETDEV_CMD_QSTATS_GET - dump */
>  static const struct nla_policy netdev_qstats_get_nl_policy[NETDEV_A_QSTA=
TS_SCOPE + 1] =3D {
> +       [NETDEV_A_QSTATS_IFINDEX] =3D NLA_POLICY_MIN(NLA_U32, 1),
>         [NETDEV_A_QSTATS_SCOPE] =3D NLA_POLICY_MASK(NLA_UINT, 0x1),
>  };
>
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 7004b3399c2b..dd6510f2c652 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -639,6 +639,24 @@ netdev_nl_stats_by_netdev(struct net_device *netdev,=
 struct sk_buff *rsp,
>         return -EMSGSIZE;
>  }
>
> +static int
> +netdev_nl_qstats_get_dump_one(struct net_device *netdev, unsigned int sc=
ope,
> +                             struct sk_buff *skb, const struct genl_info=
 *info,
> +                             struct netdev_nl_dump_ctx *ctx)
> +{
> +       if (!netdev->stat_ops)
> +               return 0;
> +
> +       switch (scope) {
> +       case 0:
> +               return netdev_nl_stats_by_netdev(netdev, skb, info);
> +       case NETDEV_QSTATS_SCOPE_QUEUE:
> +               return netdev_nl_stats_by_queue(netdev, skb, info, ctx);
> +       }
> +
> +       return -EINVAL; /* Should not happen, per netlink policy */
> +}
> +
>  int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
>                                 struct netlink_callback *cb)
>  {
> @@ -646,6 +664,7 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
>         const struct genl_info *info =3D genl_info_dump(cb);
>         struct net *net =3D sock_net(skb->sk);
>         struct net_device *netdev;
> +       unsigned int ifindex;
>         unsigned int scope;
>         int err =3D 0;
>
> @@ -653,21 +672,28 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb=
,
>         if (info->attrs[NETDEV_A_QSTATS_SCOPE])
>                 scope =3D nla_get_uint(info->attrs[NETDEV_A_QSTATS_SCOPE]=
);
>
> -       rtnl_lock();
> -       for_each_netdev_dump(net, netdev, ctx->ifindex) {
> -               if (!netdev->stat_ops)
> -                       continue;
> +       ifindex =3D 0;
> +       if (info->attrs[NETDEV_A_QSTATS_IFINDEX])
> +               ifindex =3D nla_get_u32(info->attrs[NETDEV_A_QSTATS_IFIND=
EX]);
>
> -               switch (scope) {
> -               case 0:
> -                       err =3D netdev_nl_stats_by_netdev(netdev, skb, in=
fo);
> -                       break;
> -               case NETDEV_QSTATS_SCOPE_QUEUE:
> -                       err =3D netdev_nl_stats_by_queue(netdev, skb, inf=
o, ctx);
> -                       break;
> +       rtnl_lock();
> +       if (ifindex) {
> +               netdev =3D __dev_get_by_index(net, ifindex);

I wonder if NLM_F_DUMP_FILTERED should not be reported to user space ?

