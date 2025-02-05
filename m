Return-Path: <netdev+bounces-163176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C22B7A297F5
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 18:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28125162575
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 17:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3891FDA93;
	Wed,  5 Feb 2025 17:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uqpTAfY7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881CF1FC7FC
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 17:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738777746; cv=none; b=O5vNCIY6IsRjEN64kVbA27U67Ic0otzNEEHoGT+2r/569LrL4YYgPtA5jLgx88hlQatReRtMy4B62/mEVfHRjEuYVUSE2GK08wdUR5L/2dfDdQhj5KePe5+nv2H6UNCv4AsrAhIi+7LN4xOMAkCZ8muWk04/4PBfTbFtE8TgQD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738777746; c=relaxed/simple;
	bh=/u62dmBR/ElLvSnF0c2PDOI2w0kdMLqx8LmycyWZfzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iQHAUQ1z9vp9hs9tCUiaBLMwb4ImpVc3CzSppgnnyizbNltL2bEfwbk5204uPQ96stWrX8lRH98YxlQ7qo1eUSwFIP2PZY+Pd7c62n9Oo//BAOH2udd1hcrw+PmgOoeUuHAItX1MWWtKuYifXac0/557jjAsVrog7tgMB0fqF+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uqpTAfY7; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab7157cf352so236898166b.0
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 09:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738777742; x=1739382542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQSBOXqhcCachV8zft/ScV1fAUdaea+WUZiYV/mWDWA=;
        b=uqpTAfY72ChwJxTgZzIEtB5RyCziQaK4TMUTFBYYzG8ALRiJI7YiWT3leZb/0EKebT
         7baWKcC7je1Jy9aqd3Y4dMCgHlaH44ZmVJXlQtw82wDOA7b2YxbDjjr2T6rc4HuJBscp
         rm2sXXR7VuJUj0kiSiN0OHhJF9G1X1uHmRHi5OWS9QokobsfrJF/KSGF8F9gH3pG720f
         3m9+hu6UOlVgwNLvLhGXtoHwffmpT7T711s23ZZll9A778BCLgsVdBR6ANVN6iFK5ATv
         2B6uB/jWkqBRZW07kyst+atf0lbcgAYcrgW2OSHcgiaLkz2u5F6WbvxxThGAkhAZZSxH
         NiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738777742; x=1739382542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQSBOXqhcCachV8zft/ScV1fAUdaea+WUZiYV/mWDWA=;
        b=Z7pT1l8VBydaPMX2LGEJ+tujDUUEj56vOcM8hMGT32iEIMSpoT562/r84OlsQQ39DR
         VGu6jtNU2+cMwuP11EHeO9UuZHSQp9JDk2S/Aq8TeiIiXWE05rNkrkPNnQn58MPfsOI+
         +5zegUj9oqY24Ui4WxEXFZvPsFPY9An40uvAokC6HT8ArtIrdHyC7jbmKDJ/0L/0mbv8
         IcVsehnKJvqAaMZ3a4lyLw+bjjP9wCwqyILZSvAcrZV7BODfXwLw0HbNh1cq6D73O1MG
         eM5R2wTEo6EvlIV0Sg4dghf/1mTM3GopL/0DWPy40R9a+FgYzu+dliB5pYbDnaw79cIf
         k9iA==
X-Forwarded-Encrypted: i=1; AJvYcCWH0LZG3TzDH0brjcizlrVpkKDA7zIIu+bmGtZabHSD4o6gOnBt0grxhTwHIFmH/kCCGpTzebk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbgPFtq30gHRHUVJSX70maYhhSny7iO8v/EJkzeRlpOqrtQKg6
	85zc9EhrJj+kUoN0WvdD9e8UlsBJQaknxsdpHDBSWsIqdDtkze1tZ8v6bUZ1X979tQoEW/KjEaG
	dOTspMztplB1dcsZdJmJd4SLWN+XtL8uvGK+c
X-Gm-Gg: ASbGncu1lyGgInJMvtFxR0NdTFRdJp9sULMhO03TQbWY4qVWZntf3RYfkzHAU5f9p6s
	KlNLhc40RcAqLbCITy5WMRXsZ41wJlpOwUbG/CRzTV9mjH+g8xNXNz9gxxPvhjHf/uFQO1z+F
X-Google-Smtp-Source: AGHT+IHJ8jmvk2vlvaC+lS/sj7o4RSpBTPngYU6t0we792og/hqSw+9hG/n7P/6UGVrDc5IFt2nzYS57fa68T5dlKVI=
X-Received: by 2002:a17:907:7fa3:b0:ab6:e04e:b29 with SMTP id
 a640c23a62f3a-ab76e84c376mr17529966b.3.1738777741553; Wed, 05 Feb 2025
 09:49:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205163609.3208829-1-aleksander.lobakin@intel.com> <20250205163609.3208829-2-aleksander.lobakin@intel.com>
In-Reply-To: <20250205163609.3208829-2-aleksander.lobakin@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 5 Feb 2025 18:48:50 +0100
X-Gm-Features: AWEUYZkuOxhIaitZ5J2JCfpt9TDbTEs11u0nOVrp_WhyR-akpJsCIQE0mTy2wI0
Message-ID: <CANn89iJjCOThDqwsK4v2O8LfcwAB55YohNZ8T2sR40uM2ZoX5w@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/8] net: gro: decouple GRO from the NAPI layer
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 5:46=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> In fact, these two are not tied closely to each other. The only
> requirements to GRO are to use it in the BH context and have some
> sane limits on the packet batches, e.g. NAPI has a limit of its
> budget (64/8/etc.).
> Move purely GRO fields into a new tagged group, &gro_node. Embed it
> into &napi_struct and adjust all the references. napi_id doesn't
> really belong to GRO, but:
>
> 1. struct gro_node has a 4-byte padding at the end anyway. If you
>    leave napi_id outside, struct napi_struct takes additional 8 bytes
>    (u32 napi_id + another 4-byte padding).
> 2. gro_receive_skb() uses it to mark skbs. We don't want to split it
>    into two functions or add an `if`, as this would be less efficient,
>    but we need it to be NAPI-independent. The current approach doesn't
>    change anything for NAPI-backed GROs; for standalone ones (which
>    are less important currently), the embedded napi_id will be just
>    zero =3D> no-op.
>
> Three Ethernet drivers use napi_gro_flush() not really meant to be
> exported, so move it to <net/gro.h> and add that include there.
> napi_gro_receive() is used in more than 100 drivers, keep it
> in <linux/netdevice.h>.
> This does not make GRO ready to use outside of the NAPI context
> yet.
>
> Tested-by: Daniel Xu <dxu@dxuuu.xyz>
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  include/linux/netdevice.h                  | 26 +++++---
>  include/net/busy_poll.h                    | 11 +++-
>  include/net/gro.h                          | 35 +++++++----
>  drivers/net/ethernet/brocade/bna/bnad.c    |  1 +
>  drivers/net/ethernet/cortina/gemini.c      |  1 +
>  drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c |  1 +
>  net/core/dev.c                             | 60 ++++++++-----------
>  net/core/gro.c                             | 69 +++++++++++-----------
>  8 files changed, 112 insertions(+), 92 deletions(-)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 2a59034a5fa2..d29b6ebde73f 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -340,8 +340,8 @@ struct gro_list {
>  };
>
>  /*
> - * size of gro hash buckets, must less than bit number of
> - * napi_struct::gro_bitmask
> + * size of gro hash buckets, must be <=3D the number of bits in
> + * gro_node::bitmask
>   */
>  #define GRO_HASH_BUCKETS       8
>
> @@ -370,7 +370,6 @@ struct napi_struct {
>         unsigned long           state;
>         int                     weight;
>         u32                     defer_hard_irqs_count;
> -       unsigned long           gro_bitmask;
>         int                     (*poll)(struct napi_struct *, int);
>  #ifdef CONFIG_NETPOLL
>         /* CPU actively polling if netpoll is configured */
> @@ -379,11 +378,14 @@ struct napi_struct {
>         /* CPU on which NAPI has been scheduled for processing */
>         int                     list_owner;
>         struct net_device       *dev;
> -       struct gro_list         gro_hash[GRO_HASH_BUCKETS];
>         struct sk_buff          *skb;
> -       struct list_head        rx_list; /* Pending GRO_NORMAL skbs */
> -       int                     rx_count; /* length of rx_list */
> -       unsigned int            napi_id; /* protected by netdev_lock */
> +       struct_group_tagged(gro_node, gro,
> +               unsigned long           bitmask;
> +               struct gro_list         hash[GRO_HASH_BUCKETS];
> +               struct list_head        rx_list; /* Pending GRO_NORMAL sk=
bs */
> +               int                     rx_count; /* length of rx_list */
> +               u32                     napi_id; /* protected by netdev_l=
ock */
> +

I am old school, I would prefer a proper/standalone old C construct.

struct gro_node  {
                unsigned long           bitmask;
               struct gro_list         hash[GRO_HASH_BUCKETS];
               struct list_head        rx_list; /* Pending GRO_NORMAL skbs =
*/
               int                     rx_count; /* length of rx_list */
               u32                     napi_id; /* protected by netdev_lock=
 */
};

Really, what struct_group_tagged() can possibly bring here, other than
obfuscation ?

Less than 30 uses in the whole kernel tree...

