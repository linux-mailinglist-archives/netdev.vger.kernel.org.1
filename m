Return-Path: <netdev+bounces-137833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C84F59AA01A
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 12:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DC261F228A7
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 10:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9E319ADBF;
	Tue, 22 Oct 2024 10:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G8Dr3vNn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9007919AA53
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 10:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729592979; cv=none; b=Mr/48EkuRwc2VH3HIiDUTvjxwvJ97LDgcOba1I579gl7wc6Jsvt26W5MQD0hY0JSFJfCJAERp+WyvS4zpGfztXURXa1XpA7Y+CUdCT0YelCkbcizHv+653gyqCymVSvP9CVIvmpF5RNaluqfOM3Ui7zydDUOz6/7ERn6dwW2IEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729592979; c=relaxed/simple;
	bh=6C7NgU3MUhl3Hi2Nc5pua0VwmoKshs0V30agMvqeRcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1oUuMiTZCQsxDURH3omEyOtXR2C0sjZYe7kJcaHUPQqExvMjeMArkXj7SmFeEWpjKZR5avwD3X9Hu3t0knblgiov5rJ55cJrXJdjEk+uRshswIn5jyXd/SGhCjvRuNGD60wsS/PZchzQy9npw4KahbHKvADtNhhPZc1DSoSi3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G8Dr3vNn; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb3da341c9so53465191fa.2
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 03:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729592975; x=1730197775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfQ5R5W4pAP72bBv+ZRad0B8K8sGOGYh/mrciyj4lTs=;
        b=G8Dr3vNn+oU4NLpM/No4zyI0jB3rTolxsBhHWttfDE/4zP2O2V3BwxdL1OA0SUHL5Q
         rnH6WnNVsyqxMzKcbbjgfqgbGCt2oH7XJ10ZPR8QWk/z08qbbGvd1FT6KJbfpxaxhs1Y
         yGR3DMbKGhaYiyq7D8IeSgLZYUsxCiuv0Xypk0mqx17xz/dwlFARxuGzmxG9TcFj1AeI
         LgGfp/kF35hMKkEGZr+i1FYWA7XTOQvzywxLbYl9VUskWJ3RR+Fr5m9vri+5oCNYypZn
         ARfsk1l5zvIebPV66QJQhOVlIpSbGtGRMM6EiLiNY3a/Ioj1UYiVz1vtFVYS+eiGhwvO
         KwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729592975; x=1730197775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfQ5R5W4pAP72bBv+ZRad0B8K8sGOGYh/mrciyj4lTs=;
        b=NDsXbYxVuA6hqM3hfYP/BkIUi4R4c82PuaQOG3j4HbvYo1q4r1SImYvH/enGBpJs3N
         SiAoTSlQTzZHLpC6UqlpeiSOWTJmgslLlLr4+kInGz/DxwWfho5IO+9HrxJyj96DuYz7
         1tVKuekcSiVRNF3s1aB1CU2ZrjM1un1KTLL56Y5uDgcILz9xcVtyuaz5pJXtfvDeErtf
         N6lo/NGqgwaijEzR5u1/HD9wYrDybeznpUBQX7nrE99P8xXnwuP2H5NnFLuXIgH7IFPp
         bw8I6XLOG8pcmHPCAEuiPMwQ1vmCluALU1GI4RhcFRTAa9v4loYs9uI1PgvT4T8yBrh9
         NSmA==
X-Forwarded-Encrypted: i=1; AJvYcCVqF8E2Udg9krFllu9oVcCtPGnWs+NHU9IBZrK3wl1cp/TWD/IylpxfPuCTID2S6SB0fvto/G8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVlDJR4jjIvTE+KMCbBnYzh9Tdgkcvas9pKv+3jmlaOSOtoxQm
	InFsQrkwVA5dCsWxdoHuUJjGIy+FrhPqDQBTyYoQIif/8FLQuOYa22dk6+/ilsEpoPugAxQjBqG
	2+Ec+LSHN/tMWjTqZwXqEmHBfkK02cYRhCL38
X-Google-Smtp-Source: AGHT+IGKAlOEl7E9oTff9kvgfX+LWcozQrfXlOfU+OSgTq5j864f3oHwCQZ6UD+oFhycuC6vhTNHl9ohjhFSF3njz6w=
X-Received: by 2002:a05:651c:551:b0:2fa:d4ef:f222 with SMTP id
 38308e7fff4ca-2fb8320b662mr59323601fa.38.1729592974448; Tue, 22 Oct 2024
 03:29:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022085759.1328477-1-wangliang74@huawei.com>
In-Reply-To: <20241022085759.1328477-1-wangliang74@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Oct 2024 12:29:21 +0200
Message-ID: <CANn89iLJGbm0Jr9CVFo6K8jetF2jX0EqVBUR3a1L=PPSSLCygA@mail.gmail.com>
Subject: Re: [PATCH net] net: fix crash when config small gso_max_size/gso_ipv4_max_size
To: Wang Liang <wangliang74@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, idosch@nvidia.com, 
	kuniyu@amazon.com, stephen@networkplumber.org, dsahern@kernel.org, 
	lucien.xin@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 10:40=E2=80=AFAM Wang Liang <wangliang74@huawei.com=
> wrote:
>
> Config a small gso_max_size/gso_ipv4_max_size can lead to large skb len,
> which may trigger a BUG_ON crash.
>
> If the gso_max_size/gso_ipv4_max_size is smaller than MAX_TCP_HEADER + 1,
> the sk->sk_gso_max_size is overflowed:
> sk_setup_caps
>     // dst->dev->gso_ipv4_max_size =3D 252, MAX_TCP_HEADER =3D 320
>     // GSO_LEGACY_MAX_SIZE =3D 65536, sk_is_tcp(sk) =3D 1
>     sk->sk_gso_max_size =3D sk_dst_gso_max_size(sk, dst);
>         max_size =3D dst->dev->gso_ipv4_max_size;
>             sk->sk_gso_max_size =3D max_size - (MAX_TCP_HEADER + 1);
>             sk->sk_gso_max_size =3D 252-(320+1) =3D -69
>
> When send tcp msg, the wrong sk_gso_max_size can lead to a very large
> size_goal, which cause large skb length:
> tcp_sendmsg_locked
>     tcp_send_mss(sk, &size_goal, flags);
>         tcp_xmit_size_goal(sk, mss_now, !(flags & MSG_OOB));
>
>             // tp->max_window =3D 65536, TCP_MSS_DEFAULT =3D 536
>             new_size_goal =3D tcp_bound_to_half_wnd(tp, sk->sk_gso_max_si=
ze);
>                 new_size_goal =3D sk->sk_gso_max_size =3D -69
>
>             // tp->gso_segs =3D 0, mss_now =3D 32768
>             size_goal =3D tp->gso_segs * mss_now;
>                 size_goal =3D 0*32768 =3D 0
>
>             // sk->sk_gso_max_segs =3D 65535, new_size_goal =3D -69
>             new_size_goal < size_goal:
>                 tp->gso_segs =3D min_t(u16, new_size_goal / mss_now,
>                      sk->sk_gso_max_segs);
>                 // new_size_goal / mss_now =3D 0x1FFFF -> 65535
>                 // tp->gso_segs =3D 65535
>                 size_goal =3D tp->gso_segs * mss_now;
>                 size_goal =3D 65535*32768 =3D 2147450880
>
>     if new_segment:
>         skb =3D tcp_stream_alloc_skb()
>         copy =3D size_goal; // copy =3D 2147450880
>     if (copy > msg_data_left(msg)) // msg_data_left(msg) =3D 2147479552
>         copy =3D msg_data_left(msg); // copy =3D 2147450880
>     copy =3D min_t(int, copy, pfrag->size - pfrag->offset); // copy =3D 2=
1360
>     skb_copy_to_page_nocache
>         skb_len_add
>             skb->len +=3D copy; // skb->len add to 524288
>

I find this explanation way too long. No one will bother to double
check your claims.

I would simply point out that an underflow in sk_dst_gso_max_size()
leads to a crash,
because sk->sk_gso_max_size would be much bigger than device limits.


> The large skb length may load to a overflowed tso_segs, which can trigger
> a BUG_ON crash:
> tcp_write_xmit
>     tso_segs =3D tcp_init_tso_segs(skb, mss_now);
>         tcp_set_skb_tso_segs
>             tcp_skb_pcount_set
>                 // skb->len =3D 524288, mss_now =3D 8
>                 // u16 tso_segs =3D 524288/8 =3D 65535 -> 0
>                 tso_segs =3D DIV_ROUND_UP(skb->len, mss_now)
>     BUG_ON(!tso_segs)
>
> To solve this issue, the minimum value of gso_max_size/gso_ipv4_max_size
> should be checked.
>
> Fixes: 46e6b992c250 ("rtnetlink: allow GSO maximums to be set on device c=
reation")
> Fixes: 9eefedd58ae1 ("net: add gso_ipv4_max_size and gro_ipv4_max_size pe=
r device")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>  net/core/rtnetlink.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index e30e7ea0207d..a0df1da5a0a6 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -2466,6 +2466,12 @@ static int validate_linkmsg(struct net_device *dev=
, struct nlattr *tb[],
>                 return -EINVAL;
>         }
>
> +       if (tb[IFLA_GSO_MAX_SIZE] &&
> +           (nla_get_u32(tb[IFLA_GSO_MAX_SIZE]) < MAX_TCP_HEADER + 1)) {
> +               NL_SET_ERR_MSG(extack, "too small gso_max_size");
> +               return -EINVAL;
> +       }

Modern way would be to change ifla_policy[] : This is where we put such lim=
its.

Look for NLA_POLICY_MIN() uses in the tree.

> +
>         if (tb[IFLA_GSO_MAX_SEGS] &&
>             (nla_get_u32(tb[IFLA_GSO_MAX_SEGS]) > GSO_MAX_SEGS ||
>              nla_get_u32(tb[IFLA_GSO_MAX_SEGS]) > dev->tso_max_segs)) {
> @@ -2485,6 +2491,12 @@ static int validate_linkmsg(struct net_device *dev=
, struct nlattr *tb[],
>                 return -EINVAL;
>         }
>
> +       if (tb[IFLA_GSO_IPV4_MAX_SIZE] &&
> +           (nla_get_u32(tb[IFLA_GSO_IPV4_MAX_SIZE]) < MAX_TCP_HEADER + 1=
)) {
> +               NL_SET_ERR_MSG(extack, "too small gso_ipv4_max_size");
> +               return -EINVAL;
> +       }

Same here.

> +
>         if (tb[IFLA_GRO_IPV4_MAX_SIZE] &&
>             nla_get_u32(tb[IFLA_GRO_IPV4_MAX_SIZE]) > GRO_MAX_SIZE) {
>                 NL_SET_ERR_MSG(extack, "too big gro_ipv4_max_size");
> --
> 2.34.1
>

