Return-Path: <netdev+bounces-216818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 509C0B354AE
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 08:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C19164917
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 06:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9139E2853E9;
	Tue, 26 Aug 2025 06:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jn91P3mX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9132641E3
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 06:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756190303; cv=none; b=Q+/njwi0GaIZOue6yeeYU88dRAZ0ClgC3hcigXJcUVlaqeVWTqv0OW7d2clefb9iVB79tQA1PmkLzEcXIRFKJsWlmYqO8ecDhvz0OLAAY8ip28hWZ215MKB3DXhnr4PeGkzlNu+qgY+BG3gh7Zj4HJmRI2UkOM1TOxClQ4M0FGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756190303; c=relaxed/simple;
	bh=wpU8pIN/IW7kIhoJKatbUTCAqJ0FjOn1Rg1gTLzUeOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FVV7t/Yci4Rtzk0Wwt4/HQIJTulRtdCnsa3/C3sPk7VKX5+tP6rPOQn9XqebL/roLm7pkipd2yiiLy2wpKvomocdruzjec6WtMU2uCmYHMMTomxuLEJ2AFqaqPmrlY43Es4M6WcAh6Tnw2W64H59lvi2bvDoWCvbGVYQbBApCVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jn91P3mX; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b1098f9e9eso83767561cf.0
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 23:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756190297; x=1756795097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0C3S1bVVtePc/APHT/8WoZJdWGoJ1m+D+V53HqBA7o=;
        b=jn91P3mXyCa0I0UtuKN1e0EBc4oG9WpO6MirHi1mKKwEKbc1CW3oISIs0QgLZ4HJfr
         QJzcLVbfUsXvSWvByaYiU5P194ZqpAhSGLw2w9XmmjRsRZEAMlywHGQqCm11PBg0ySGW
         B+PC1XCFgDBs3APyBn1TjGIRtO4Y1hoavJgVep+5XiTWbl4ZvNCnJvWb2lzRWrRQ+AlK
         AYIyo7lmSWcDPWUnCtlXMtM7zrJw6wfEg2bFbsTiNaBC2tqgMRWPCkgodpTPgPJCHekG
         ut8wLxzc1ue+o8HqvmEbkR+2UnI53TVcdx/iJAfbdGWpXHdm1Z6Pd7WJAkHrAdZe6eKc
         qGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756190297; x=1756795097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0C3S1bVVtePc/APHT/8WoZJdWGoJ1m+D+V53HqBA7o=;
        b=F3h0JfVvdz0aeOVqVNFPlZNcaw/Rss8WGBXhnHI7JktAeY12d2dPdtqgTQsPyazwGR
         VZHD6oynTizhaFy4DwFd1aTyk3dLoORUR+IVA2AYgGdQNJF18NdjllwtpGf3L5MBwNRP
         mZz7HGji1uj2/GqslRW7fYeJbOSm3ggXn5RjE8FsvvfuH2Cv/zydeR+nkjlFtfjhSMbT
         A78+ywIk51A/luMCCWqOE66ocyHN1VZ42HG1zVykEP7OhEAHaYB9xt6eDeXS/4VEkkd6
         EepmQMpDfUrYjdzM4wzQspcGzJKWpMKwqm/bffiAkpEMXDvG9sS0nz6dJ0IqriXePe8f
         aurQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/btAHmd6CBpEKSbshWY8KkRBkpUTw7Xu7ByyVju3Q0hrK2nJzbGTddbEqBbFeCPbkcosCj68=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJEMyKRCOHXKaox05BdMR752xgF6kHcSkH0U572kkZAcDvcvcj
	nsYpn6TIhZDzguUVZqUWsB9uE2p61rXmAYrBQJMxSsa1O+7TNYIr1yaUT/miJRiBxAuifm+T1wB
	yXxO0Ah1tMhF5Dvi5MfHC+JrvLKy0YXfHSDnoGKL0
X-Gm-Gg: ASbGncsrxA/w/jMrVPFyA5oH+1rB/o1kg3/knWq4uF6pVdN97gV1ayy/Yqdc2kVx7Kq
	8PsBBRNEYB0iwwzAGxpoI/v9SG36DunOCjPcEO0BE5p6t7nheL9S8xAbdQ8b26I+P31mKq0UWk/
	WkF746ILWULeve+xG2z3Qn23LYwxVWMMxQy4ZbVTLn3kgG4s2mWgIH16s5+7nDUApesujJ8WWld
	IIQbEIO6S0dmKersdoNjZp3Ow==
X-Google-Smtp-Source: AGHT+IHKLF2ER9I7pXDkRBQiOJY6S9iwrojCpIUCPgd3UbgIlllqycwq0hMz3my1s0m2wrjolIBjDpG3hredR1BoJkk=
X-Received: by 2002:a05:622a:44d:b0:4b0:7c4f:aefa with SMTP id
 d75a77b69052e-4b2aaa6db01mr171561191cf.35.1756190296574; Mon, 25 Aug 2025
 23:38:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v3-0-5527e9eb6efc@openai.com>
 <20250825-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v3-2-5527e9eb6efc@openai.com>
In-Reply-To: <20250825-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v3-2-5527e9eb6efc@openai.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 25 Aug 2025 23:38:05 -0700
X-Gm-Features: Ac12FXwMOXaPuD5H2XjFt2mAQbfXmgTtztUtNIlns1GSIvefg4_ldwJMpGaHcxM
Message-ID: <CANn89iJ5brG-tSdyEPYH67BL1rkU5CKfvUO4Jc03twfVFKFPqQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] net/mlx5: Avoid copying payload to the
 skb's linear part
To: cpaasch@openai.com
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Gal Pressman <gal@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 8:47=E2=80=AFPM Christoph Paasch via B4 Relay
<devnull+cpaasch.openai.com@kernel.org> wrote:
>
> From: Christoph Paasch <cpaasch@openai.com>
>
> mlx5e_skb_from_cqe_mpwrq_nonlinear() copies MLX5E_RX_MAX_HEAD (256)
> bytes from the page-pool to the skb's linear part. Those 256 bytes
> include part of the payload.
>
> When attempting to do GRO in skb_gro_receive, if headlen > data_offset
> (and skb->head_frag is not set), we end up aggregating packets in the
> frag_list.
>
> This is of course not good when we are CPU-limited. Also causes a worse
> skb->len/truesize ratio,...
>
> So, let's avoid copying parts of the payload to the linear part. The
> goal here is to err on the side of caution and prefer to copy too little
> instead of copying too much (because once it has been copied over, we
> trigger the above described behavior in skb_gro_receive).
>
> So, we can do a rough estimate of the header-space by looking at
> cqe_l3/l4_hdr_type. This is now done in mlx5e_cqe_estimate_hdr_len().
> We always assume that TCP timestamps are present, as that's the most comm=
on
> use-case.
>
> That header-len is then used in mlx5e_skb_from_cqe_mpwrq_nonlinear for
> the headlen (which defines what is being copied over). We still
> allocate MLX5E_RX_MAX_HEAD for the skb so that if the networking stack
> needs to call pskb_may_pull() later on, we don't need to reallocate
> memory.
>
> This gives a nice throughput increase (ARM Neoverse-V2 with CX-7 NIC and
> LRO enabled):
>
> BEFORE:
> =3D=3D=3D=3D=3D=3D=3D
> (netserver pinned to core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.01    32547.82
>
> (netserver pinned to adjacent core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.00    52531.67
>
> AFTER:
> =3D=3D=3D=3D=3D=3D
> (netserver pinned to core receiving interrupts)
> $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.00    52896.06
>
> (netserver pinned to adjacent core receiving interrupts)
>  $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
>  87380  16384 262144    60.00    85094.90
>
> Additional tests across a larger range of parameters w/ and w/o LRO, w/
> and w/o IPv6-encapsulation, different MTUs (1500, 4096, 9000), different
> TCP read/write-sizes as well as UDP benchmarks, all have shown equal or
> better performance with this patch.
>
> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 49 +++++++++++++++++++=
+++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/ne=
t/ethernet/mellanox/mlx5/core/en_rx.c
> index b8c609d91d11bd315e8fb67f794a91bd37cd28c0..050f3efca34f3b8984c30f335=
ee43f487fef33ac 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -1991,13 +1991,54 @@ mlx5e_shampo_fill_skb_data(struct sk_buff *skb, s=
truct mlx5e_rq *rq,
>         } while (data_bcnt);
>  }
>
> +static u16
> +mlx5e_cqe_estimate_hdr_len(const struct mlx5_cqe64 *cqe, u16 cqe_bcnt)
> +{
> +       u8 l3_type, l4_type;
> +       u16 hdr_len;
> +
> +       hdr_len =3D sizeof(struct ethhdr);
> +
> +       if (cqe_has_vlan(cqe))
> +               hdr_len +=3D VLAN_HLEN;
> +
> +       l3_type =3D get_cqe_l3_hdr_type(cqe);
> +       if (l3_type =3D=3D CQE_L3_HDR_TYPE_IPV4) {
> +               hdr_len +=3D sizeof(struct iphdr);
> +       } else if (l3_type =3D=3D CQE_L3_HDR_TYPE_IPV6) {
> +               hdr_len +=3D sizeof(struct ipv6hdr);
> +       } else {
> +               hdr_len =3D MLX5E_RX_MAX_HEAD;
> +               goto out;
> +       }
> +
> +       l4_type =3D get_cqe_l4_hdr_type(cqe);
> +       if (l4_type =3D=3D CQE_L4_HDR_TYPE_UDP) {
> +               hdr_len +=3D sizeof(struct udphdr);
> +       } else if (l4_type & (CQE_L4_HDR_TYPE_TCP_NO_ACK |
> +                             CQE_L4_HDR_TYPE_TCP_ACK_NO_DATA |
> +                             CQE_L4_HDR_TYPE_TCP_ACK_AND_DATA)) {
> +               /* ACK_NO_ACK | ACK_NO_DATA | ACK_AND_DATA =3D=3D 0x7, bu=
t
> +                * the previous condition checks for _UDP which is 0x2.
> +                *
> +                * As we know that l4_type !=3D 0x2, we can simply check
> +                * if any of the bits of 0x7 is set.
> +                */
> +               hdr_len +=3D sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGN=
ED;
> +       } else {
> +               hdr_len =3D MLX5E_RX_MAX_HEAD;
> +       }
> +
> +out:
> +       return min3(hdr_len, cqe_bcnt, MLX5E_RX_MAX_HEAD);
> +}
> +

Hi Christoph

I wonder if you have tried to use eth_get_headlen() instead of yet
another dissector ?

I doubt you will see a performance difference.

commit cfecec56ae7c7c40f23fbdac04acee027ca3bd66
Author: Eric Dumazet <edumazet@google.com>
Date:   Fri Sep 5 18:29:45 2014 -0700

    mlx4: only pull headers into skb head

    Use the new fancy eth_get_headlen() to pull exactly the headers
    into skb->head.

    This speeds up GRE traffic (or more generally tunneled traffuc),
    as GRO can aggregate up to 17 MSS per GRO packet instead of 8.

    (Pulling too much data was forcing GRO to keep 2 frags per MSS)

    Signed-off-by: Eric Dumazet <edumazet@google.com>
    Cc: Amir Vadai <amirv@mellanox.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>


>  static struct sk_buff *
>  mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw=
_info *wi,
>                                    struct mlx5_cqe64 *cqe, u16 cqe_bcnt, =
u32 head_offset,
>                                    u32 page_idx)
>  {
>         struct mlx5e_frag_page *frag_page =3D &wi->alloc_units.frag_pages=
[page_idx];
> -       u16 headlen =3D min_t(u16, MLX5E_RX_MAX_HEAD, cqe_bcnt);
>         struct mlx5e_frag_page *head_page =3D frag_page;
>         struct mlx5e_xdp_buff *mxbuf =3D &rq->mxbuf;
>         u32 frag_offset    =3D head_offset;
> @@ -2009,6 +2050,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq =
*rq, struct mlx5e_mpw_info *w
>         u32 linear_frame_sz;
>         u16 linear_data_len;
>         u16 linear_hr;
> +       u16 headlen;
>         void *va;
>
>         prog =3D rcu_dereference(rq->xdp_prog);
> @@ -2039,6 +2081,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq =
*rq, struct mlx5e_mpw_info *w
>                 net_prefetchw(va); /* xdp_frame data area */
>                 net_prefetchw(skb->data);
>
> +               headlen =3D mlx5e_cqe_estimate_hdr_len(cqe, cqe_bcnt);
> +
>                 frag_offset +=3D headlen;
>                 byte_cnt -=3D headlen;
>                 linear_hr =3D skb_headroom(skb);
> @@ -2115,6 +2159,9 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq =
*rq, struct mlx5e_mpw_info *w
>                                 pagep->frags++;
>                         while (++pagep < frag_page);
>                 }
> +
> +               headlen =3D mlx5e_cqe_estimate_hdr_len(cqe, cqe_bcnt);
> +
>                 __pskb_pull_tail(skb, headlen);
>         } else {
>                 dma_addr_t addr;
>
> --
> 2.50.1
>
>

