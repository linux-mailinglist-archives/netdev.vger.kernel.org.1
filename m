Return-Path: <netdev+bounces-217067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17275B373E2
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 22:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A24A1BA4416
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 20:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE1A221265;
	Tue, 26 Aug 2025 20:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="JvdZBeYy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634D9366
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 20:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756240320; cv=none; b=I5fUY75Vay8F50KXJJnHX/qrcGS2Q4JxGa2WKGSEX59XL3ohRUC0YQQgpB2tlK19Fwro+S0vsLGBX0xRfKzYuckYcvFUqouJr/hzpOH4uh1kWT0mG54UN8jseYuRKsqMyyNyPSM8LNsmyhC9hAEuna7RJtlzPGPXEgbx0fr2U2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756240320; c=relaxed/simple;
	bh=fNVrdOY5HyQqKeF3cwlpJjIRSB0zwEDboNJzdlzXVzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=POFauJH2AHYs3cB2CFCqORw1WV8qh876kjDb+Dg0WW6dKBSmpkaYL2GoADbAV4dJ8gTlx2avv6bmgcBTeY9ekp0IV9iWERL4mAya/AJte+/lBtDIUeg6+N9utoGHpVWdu4KcFqpKAkyYKCaG8+UJ6l1jwIH4FMMRjPyW4WcgSWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=JvdZBeYy; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-333f7ebc44dso3174221fa.0
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 13:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1756240316; x=1756845116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Va1n1gV/MLT4QqnP3ruFE6lhI0hoKBLxprKjH74yr4=;
        b=JvdZBeYyrx8a+3+JKDsrhEoN7LNWMeA53E+PVaI8ueh136ZYAi9HE3CMrhMEjKxKmL
         KXl+SBrf1gF13D7ciGef6O/b6UPvlTQRZz2GOGfYhW+NYeN48pm6ZE5q5mlSyThol6WC
         z6zDDQp/1wkQpwIYcuHieXtXB8nqrBGSUg9w0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756240316; x=1756845116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Va1n1gV/MLT4QqnP3ruFE6lhI0hoKBLxprKjH74yr4=;
        b=nUyXa14nrwvslIrM+yRlHEO//vddJpY4T6lWl51XWuJxI0oNB9OPx/kI59RY8ggX04
         NuR6vu5bj5jd02znz4RmSJ9FeP2iVqqNjAt6gEVVaB9cwhjBCWAkUc5mjeFmBnY0JfT+
         dX2NrXA6vF+lP7rbFwSK5F6zlTu8h4lcqmD/0nF5Wzgf4rMOvaAXP/9rDBMh0/F0j1Rb
         MbZzmPN8Dddgm6nT+Dhoo2RiZ2UH4Mq0TwNloxCksIVvNBYuduWvzcqLSpE8Mm5+VP03
         Q3XWsElBo6uDaJFCPSzfgDCbsewF12J3XojZgr+UrlgNzyZzz7C2ZgqeF0FU5su0aA8k
         VlgA==
X-Forwarded-Encrypted: i=1; AJvYcCV0+ZBQPOGRQ7OQOtor8Bc196xbWSLq27WuZHssKdH/KMDOuHRT2+JJgGqoVOn93PguwNVoj7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA4TTMN/tDjZPeIOoPi0QDco2FPoJmYDHNuwAx2oMh6okH/yHr
	Zk7cHszMWrQwQ/hKvNVhjb/WtvlHTVQwPA8FURC3roppGt5vnx3EmylcA0n5YIBkgBkrzj9THIU
	9YgLDQI6PkiPnfqhs7U1o31FllIGXO4dQqthcimxLAw==
X-Gm-Gg: ASbGncvbUwuIfxBl8d4lTT1qjC+LwII6wPYclnHV0H731oY+pa5B52kL7XTrbiSFRIw
	ESoAMg8Whvap/Yc89bcF2VE2xCnifSyJu15IuAHtrXPbgwxs8xt2GrchBjW3ArBY6zQ6WITvDfZ
	m9UhfqlWDb7BCAlqtFbnDu2NZH+Jy2wl8YcW94ogaXPCEdZuITh2ntL8iYCITsM8n5uTQYKv0+t
	786nvgfQDcrhFWjGGLQzDRk32//xpXGjCnNwmPwGzf27ga+yiBONu4=
X-Google-Smtp-Source: AGHT+IHjuWUItN7jLMA8SQKOzEzYHXroZMef9H8zmej/tCFSWQwK7Psol/oNTl7eZnooCQY3DbPxDhnc4MxpJ27+l9A=
X-Received: by 2002:a05:651c:31c2:b0:329:1550:1446 with SMTP id
 38308e7fff4ca-3368b720e58mr5951491fa.0.1756240316457; Tue, 26 Aug 2025
 13:31:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v3-0-5527e9eb6efc@openai.com>
 <20250825-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v3-2-5527e9eb6efc@openai.com>
 <CANn89iJ5brG-tSdyEPYH67BL1rkU5CKfvUO4Jc03twfVFKFPqQ@mail.gmail.com>
In-Reply-To: <CANn89iJ5brG-tSdyEPYH67BL1rkU5CKfvUO4Jc03twfVFKFPqQ@mail.gmail.com>
From: Christoph Paasch <cpaasch@openai.com>
Date: Tue, 26 Aug 2025 13:31:44 -0700
X-Gm-Features: Ac12FXzJ_jAqqOuphOMKptwcKZJmM02rSAIzsiVI-7ZjS3MJatM0p50mEOvd67Q
Message-ID: <CADg4-L9GdJUVcGBoR3+jAt5QsSEwtiQptx2KY7UF8ga1yA7SWQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] net/mlx5: Avoid copying payload to the
 skb's linear part
To: Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Gal Pressman <gal@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 11:38=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Mon, Aug 25, 2025 at 8:47=E2=80=AFPM Christoph Paasch via B4 Relay
> <devnull+cpaasch.openai.com@kernel.org> wrote:
> >
> > From: Christoph Paasch <cpaasch@openai.com>
> >
> > mlx5e_skb_from_cqe_mpwrq_nonlinear() copies MLX5E_RX_MAX_HEAD (256)
> > bytes from the page-pool to the skb's linear part. Those 256 bytes
> > include part of the payload.
> >
> > When attempting to do GRO in skb_gro_receive, if headlen > data_offset
> > (and skb->head_frag is not set), we end up aggregating packets in the
> > frag_list.
> >
> > This is of course not good when we are CPU-limited. Also causes a worse
> > skb->len/truesize ratio,...
> >
> > So, let's avoid copying parts of the payload to the linear part. The
> > goal here is to err on the side of caution and prefer to copy too littl=
e
> > instead of copying too much (because once it has been copied over, we
> > trigger the above described behavior in skb_gro_receive).
> >
> > So, we can do a rough estimate of the header-space by looking at
> > cqe_l3/l4_hdr_type. This is now done in mlx5e_cqe_estimate_hdr_len().
> > We always assume that TCP timestamps are present, as that's the most co=
mmon
> > use-case.
> >
> > That header-len is then used in mlx5e_skb_from_cqe_mpwrq_nonlinear for
> > the headlen (which defines what is being copied over). We still
> > allocate MLX5E_RX_MAX_HEAD for the skb so that if the networking stack
> > needs to call pskb_may_pull() later on, we don't need to reallocate
> > memory.
> >
> > This gives a nice throughput increase (ARM Neoverse-V2 with CX-7 NIC an=
d
> > LRO enabled):
> >
> > BEFORE:
> > =3D=3D=3D=3D=3D=3D=3D
> > (netserver pinned to core receiving interrupts)
> > $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
> >  87380  16384 262144    60.01    32547.82
> >
> > (netserver pinned to adjacent core receiving interrupts)
> > $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
> >  87380  16384 262144    60.00    52531.67
> >
> > AFTER:
> > =3D=3D=3D=3D=3D=3D
> > (netserver pinned to core receiving interrupts)
> > $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
> >  87380  16384 262144    60.00    52896.06
> >
> > (netserver pinned to adjacent core receiving interrupts)
> >  $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
> >  87380  16384 262144    60.00    85094.90
> >
> > Additional tests across a larger range of parameters w/ and w/o LRO, w/
> > and w/o IPv6-encapsulation, different MTUs (1500, 4096, 9000), differen=
t
> > TCP read/write-sizes as well as UDP benchmarks, all have shown equal or
> > better performance with this patch.
> >
> > Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> > ---
> >  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 49 +++++++++++++++++=
+++++++-
> >  1 file changed, 48 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/=
net/ethernet/mellanox/mlx5/core/en_rx.c
> > index b8c609d91d11bd315e8fb67f794a91bd37cd28c0..050f3efca34f3b8984c30f3=
35ee43f487fef33ac 100644
> > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > @@ -1991,13 +1991,54 @@ mlx5e_shampo_fill_skb_data(struct sk_buff *skb,=
 struct mlx5e_rq *rq,
> >         } while (data_bcnt);
> >  }
> >
> > +static u16
> > +mlx5e_cqe_estimate_hdr_len(const struct mlx5_cqe64 *cqe, u16 cqe_bcnt)
> > +{
> > +       u8 l3_type, l4_type;
> > +       u16 hdr_len;
> > +
> > +       hdr_len =3D sizeof(struct ethhdr);
> > +
> > +       if (cqe_has_vlan(cqe))
> > +               hdr_len +=3D VLAN_HLEN;
> > +
> > +       l3_type =3D get_cqe_l3_hdr_type(cqe);
> > +       if (l3_type =3D=3D CQE_L3_HDR_TYPE_IPV4) {
> > +               hdr_len +=3D sizeof(struct iphdr);
> > +       } else if (l3_type =3D=3D CQE_L3_HDR_TYPE_IPV6) {
> > +               hdr_len +=3D sizeof(struct ipv6hdr);
> > +       } else {
> > +               hdr_len =3D MLX5E_RX_MAX_HEAD;
> > +               goto out;
> > +       }
> > +
> > +       l4_type =3D get_cqe_l4_hdr_type(cqe);
> > +       if (l4_type =3D=3D CQE_L4_HDR_TYPE_UDP) {
> > +               hdr_len +=3D sizeof(struct udphdr);
> > +       } else if (l4_type & (CQE_L4_HDR_TYPE_TCP_NO_ACK |
> > +                             CQE_L4_HDR_TYPE_TCP_ACK_NO_DATA |
> > +                             CQE_L4_HDR_TYPE_TCP_ACK_AND_DATA)) {
> > +               /* ACK_NO_ACK | ACK_NO_DATA | ACK_AND_DATA =3D=3D 0x7, =
but
> > +                * the previous condition checks for _UDP which is 0x2.
> > +                *
> > +                * As we know that l4_type !=3D 0x2, we can simply chec=
k
> > +                * if any of the bits of 0x7 is set.
> > +                */
> > +               hdr_len +=3D sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALI=
GNED;
> > +       } else {
> > +               hdr_len =3D MLX5E_RX_MAX_HEAD;
> > +       }
> > +
> > +out:
> > +       return min3(hdr_len, cqe_bcnt, MLX5E_RX_MAX_HEAD);
> > +}
> > +
>
> Hi Christoph
>
> I wonder if you have tried to use eth_get_headlen() instead of yet
> another dissector ?

I just tried eth_get_headlen() out - and indeed, no measurable perf differe=
nce.

I will submit a new version.


Christoph

>
> I doubt you will see a performance difference.
>
> commit cfecec56ae7c7c40f23fbdac04acee027ca3bd66
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Fri Sep 5 18:29:45 2014 -0700
>
>     mlx4: only pull headers into skb head
>
>     Use the new fancy eth_get_headlen() to pull exactly the headers
>     into skb->head.
>
>     This speeds up GRE traffic (or more generally tunneled traffuc),
>     as GRO can aggregate up to 17 MSS per GRO packet instead of 8.
>
>     (Pulling too much data was forcing GRO to keep 2 frags per MSS)
>
>     Signed-off-by: Eric Dumazet <edumazet@google.com>
>     Cc: Amir Vadai <amirv@mellanox.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
>
>
> >  static struct sk_buff *
> >  mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_m=
pw_info *wi,
> >                                    struct mlx5_cqe64 *cqe, u16 cqe_bcnt=
, u32 head_offset,
> >                                    u32 page_idx)
> >  {
> >         struct mlx5e_frag_page *frag_page =3D &wi->alloc_units.frag_pag=
es[page_idx];
> > -       u16 headlen =3D min_t(u16, MLX5E_RX_MAX_HEAD, cqe_bcnt);
> >         struct mlx5e_frag_page *head_page =3D frag_page;
> >         struct mlx5e_xdp_buff *mxbuf =3D &rq->mxbuf;
> >         u32 frag_offset    =3D head_offset;
> > @@ -2009,6 +2050,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_r=
q *rq, struct mlx5e_mpw_info *w
> >         u32 linear_frame_sz;
> >         u16 linear_data_len;
> >         u16 linear_hr;
> > +       u16 headlen;
> >         void *va;
> >
> >         prog =3D rcu_dereference(rq->xdp_prog);
> > @@ -2039,6 +2081,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_r=
q *rq, struct mlx5e_mpw_info *w
> >                 net_prefetchw(va); /* xdp_frame data area */
> >                 net_prefetchw(skb->data);
> >
> > +               headlen =3D mlx5e_cqe_estimate_hdr_len(cqe, cqe_bcnt);
> > +
> >                 frag_offset +=3D headlen;
> >                 byte_cnt -=3D headlen;
> >                 linear_hr =3D skb_headroom(skb);
> > @@ -2115,6 +2159,9 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_r=
q *rq, struct mlx5e_mpw_info *w
> >                                 pagep->frags++;
> >                         while (++pagep < frag_page);
> >                 }
> > +
> > +               headlen =3D mlx5e_cqe_estimate_hdr_len(cqe, cqe_bcnt);
> > +
> >                 __pskb_pull_tail(skb, headlen);
> >         } else {
> >                 dma_addr_t addr;
> >
> > --
> > 2.50.1
> >
> >

