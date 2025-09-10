Return-Path: <netdev+bounces-221815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D64F3B51F12
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 19:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9F931B261B1
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 17:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8314232A3E7;
	Wed, 10 Sep 2025 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="A4WR/c/E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F49E22422A
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 17:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757525812; cv=none; b=LMJiGe1JXNXB+nb2JnLkWcTgkOwLRCgYfm+8pYXuH2JPdLiayGH8AQhQL6VKMELqz8S+1nNBzmMs0lKA27vs4g6GaogvTCYusiWUWdBn63pt44Bkzg/ZwMqUwDevaIL7RNpI+uGyZ9JGAOEWXkw637JEqO/QtjZGLbpd4+tb6os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757525812; c=relaxed/simple;
	bh=LLQZmVzNV815aKaKxBWvuCiW/5PiZ8Fj7HtxZEXVcEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qdmgys756POzKkOQzvWiWw57ErZKSChoMX5IQhNNQ/cjV8yQAFJgAsZTCEI4WO1HQqObWk5sKmRAdguSJpzP07NE49I9VV+vhcppYo2DGp1WHLF4xpdbqbFU4wJetjtVcGYkqJAf9uoBKCddE1G2sZKk6CvKJmcgqx2elWcGvjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=A4WR/c/E; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-56088927dcbso8725414e87.3
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 10:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1757525809; x=1758130609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZgp1Av0IrI1VbVe6ba4FsK2/2iO2cWo8lh5Kh0scDw=;
        b=A4WR/c/EChqmEShGYtxkVNFumw3/tLB0aB2Cfo61E0qfHLlVO3ksYoBAmSmJhgmIqm
         ovMtjwfTHxd1YqJqIYUZ67/QwMCAQ8C8EnWgvmmsLxR0AU5tOGGic0rxHpnE2FMKm436
         24DkIvuOuDtsqFp8JJ1oQ5fXbrAGFfINQjjoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757525809; x=1758130609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZgp1Av0IrI1VbVe6ba4FsK2/2iO2cWo8lh5Kh0scDw=;
        b=pBmdwWFHv98GTuLPi2Q2J+1RLNMW2rSNrHAqC3PMKQt+EpccAHbw8IYF3Tlf6cSZ5q
         ZltvqLPgM9UOFYSk1ZcPQMsQ1dwDr5TZoar6nXq3x+JIAdbFpXNBRwNvsRnxkvArNw2e
         27djvdBOHblEzoL2YZHSw0EVY2HFbgHkyaIlqGNPpo3dMwlG7NzlMQyLGlL1glYrqW0v
         ClETMeb+Przy86R3F/KqL2tjlGvjOfTjFessgrgHHqINrehwnUq2CETQfZdGgvC1QfRg
         Ondx5FX7tCCkd4T+FlzCWB0M3Lw4UwnjqmG+SEsiWelB6f0oYldO5HOOLi3fBvrOqmu8
         xwDg==
X-Forwarded-Encrypted: i=1; AJvYcCVX8n35bNW7oA4zLU7uSTXiZmqfHXgag2z3gPz/fwVYIGiw7Jouo/woqoRujCYJ14HXQNBcBtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdNHo7tA1qnHV20qRGKy2qUCQ3MKBtLGnDAEUy2fyGrmKa9EsE
	h600dDJVaiiu4G8Xp5vcZiGIDBBo0PwmlM8hgtFL8KkSBJ+hrYWVh+n6J3n2KSljKMh+pOAhAKy
	8FYaEYxqxMZ02vjL2qpaQGM8DjHjr7HJM2qezJSrFLg==
X-Gm-Gg: ASbGnctHUILi+HTUOGuCRVs/KJkM33qzFzaCduiEmeON7n7snGis8AqysSmOTAhsG9Z
	I/d65qZU3RwYIaGVpfWYhGoGd8+/Yih+tawnjEQVv9bU/jL46r2OtXbijpjS9ZEFemV9U+jPH0Y
	uI+TE+xT+NBloGEzLTTyeBBthpI5CnP0knOQRT5n+fQgj8BOHYSbuCoSdsdHWYXsJ51JI/AW1y8
	3uvoOoz70rqu+4BlPhziup4QqEs4BmvJgxz5vTkOwiMLmi49WCgDG8pkA4EbmG9gg==
X-Google-Smtp-Source: AGHT+IEYro1yLA2HJ0lSiLmsgZxDRscIjl9YnGbe8L+zsVFBmVtUnfEiensqayS3z+8kLd1Sw+behbmHKEwjxXxcVAw=
X-Received: by 2002:a05:6512:118b:b0:55f:6c72:b70d with SMTP id
 2adb3069b0e04-56261bc60fcmr5252641e87.48.1757525808710; Wed, 10 Sep 2025
 10:36:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v5-0-ea492f7b11ac@openai.com>
 <20250904-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v5-2-ea492f7b11ac@openai.com>
 <CAMB2axO4ySD2Lo9xzkkYdUqL2tHPcO02-h2HZiWT993wsU3NtA@mail.gmail.com>
 <CADg4-L92GbxSXaqg1KuoGxt2c_yC=gbmKywVPvcAjHY_7v2H1g@mail.gmail.com>
 <CADg4-L8dLtzPL-x8o1HAHrbQ2fQ0MxB3Gm68HVj9Jp3-YunwrA@mail.gmail.com> <CAMB2axO3d9Wr64RRxYQd8rg5QVxt5MO=ZzRtJG8njeDYNBW-tw@mail.gmail.com>
In-Reply-To: <CAMB2axO3d9Wr64RRxYQd8rg5QVxt5MO=ZzRtJG8njeDYNBW-tw@mail.gmail.com>
From: Christoph Paasch <cpaasch@openai.com>
Date: Wed, 10 Sep 2025 10:36:36 -0700
X-Gm-Features: AS18NWBuzj_9J7VCJmWMWuMIdt3c4bav1a2rRfaZyb5Rl8dB5QA7U4C5abrPeKI
Message-ID: <CADg4-L8a-FbB4A_dttfQXYuvOdnEcrYOYi4fG_7KBBWfaLL_ag@mail.gmail.com>
Subject: Re: [PATCH net-next v5 2/2] net/mlx5: Avoid copying payload to the
 skb's linear part
To: Amery Hung <ameryhung@gmail.com>
Cc: Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 8:17=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> On Tue, Sep 9, 2025 at 11:18=E2=80=AFAM Christoph Paasch <cpaasch@openai.=
com> wrote:
> >
> > On Mon, Sep 8, 2025 at 9:00=E2=80=AFPM Christoph Paasch <cpaasch@openai=
.com> wrote:
> > >
> > > On Thu, Sep 4, 2025 at 4:30=E2=80=AFPM Amery Hung <ameryhung@gmail.co=
m> wrote:
> > > >
> > > > On Thu, Sep 4, 2025 at 3:57=E2=80=AFPM Christoph Paasch via B4 Rela=
y
> > > > <devnull+cpaasch.openai.com@kernel.org> wrote:
> > > > >
> > > > > From: Christoph Paasch <cpaasch@openai.com>
> > > > >
> > > > > mlx5e_skb_from_cqe_mpwrq_nonlinear() copies MLX5E_RX_MAX_HEAD (25=
6)
> > > > > bytes from the page-pool to the skb's linear part. Those 256 byte=
s
> > > > > include part of the payload.
> > > > >
> > > > > When attempting to do GRO in skb_gro_receive, if headlen > data_o=
ffset
> > > > > (and skb->head_frag is not set), we end up aggregating packets in=
 the
> > > > > frag_list.
> > > > >
> > > > > This is of course not good when we are CPU-limited. Also causes a=
 worse
> > > > > skb->len/truesize ratio,...
> > > > >
> > > > > So, let's avoid copying parts of the payload to the linear part. =
We use
> > > > > eth_get_headlen() to parse the headers and compute the length of =
the
> > > > > protocol headers, which will be used to copy the relevant bits ot=
 the
> > > > > skb's linear part.
> > > > >
> > > > > We still allocate MLX5E_RX_MAX_HEAD for the skb so that if the ne=
tworking
> > > > > stack needs to call pskb_may_pull() later on, we don't need to re=
allocate
> > > > > memory.
> > > > >
> > > > > This gives a nice throughput increase (ARM Neoverse-V2 with CX-7 =
NIC and
> > > > > LRO enabled):
> > > > >
> > > > > BEFORE:
> > > > > =3D=3D=3D=3D=3D=3D=3D
> > > > > (netserver pinned to core receiving interrupts)
> > > > > $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
> > > > >  87380  16384 262144    60.01    32547.82
> > > > >
> > > > > (netserver pinned to adjacent core receiving interrupts)
> > > > > $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256K
> > > > >  87380  16384 262144    60.00    52531.67
> > > > >
> > > > > AFTER:
> > > > > =3D=3D=3D=3D=3D=3D
> > > > > (netserver pinned to core receiving interrupts)
> > > > > $ netperf -H 10.221.81.118 -T 80,9 -P 0 -l 60 -- -m 256K -M 256K
> > > > >  87380  16384 262144    60.00    52896.06
> > > > >
> > > > > (netserver pinned to adjacent core receiving interrupts)
> > > > >  $ netperf -H 10.221.81.118 -T 80,10 -P 0 -l 60 -- -m 256K -M 256=
K
> > > > >  87380  16384 262144    60.00    85094.90
> > > > >
> > > > > Additional tests across a larger range of parameters w/ and w/o L=
RO, w/
> > > > > and w/o IPv6-encapsulation, different MTUs (1500, 4096, 9000), di=
fferent
> > > > > TCP read/write-sizes as well as UDP benchmarks, all have shown eq=
ual or
> > > > > better performance with this patch.
> > > > >
> > > > > Reviewed-by: Eric Dumazet <edumazet@google.com>
> > > > > Reviewed-by: Saeed Mahameed <saeedm@nvidia.com>
> > > > > Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> > > > > ---
> > > > >  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 5 +++++
> > > > >  1 file changed, 5 insertions(+)
> > > > >
> > > > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/dr=
ivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > > > > index 8bedbda522808cbabc8e62ae91a8c25d66725ebb..0ac31c7fb64cd6072=
0d390de45a5b6b453ed0a3f 100644
> > > > > --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > > > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> > > > > @@ -2047,6 +2047,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct m=
lx5e_rq *rq, struct mlx5e_mpw_info *w
> > > > >                 dma_sync_single_for_cpu(rq->pdev, addr + head_off=
set, headlen,
> > > > >                                         rq->buff.map_dir);
> > > > >
> > > > > +               headlen =3D eth_get_headlen(rq->netdev, head_addr=
, headlen);
> > > > > +
> > > > >                 frag_offset +=3D headlen;
> > > > >                 byte_cnt -=3D headlen;
> > > > >                 linear_hr =3D skb_headroom(skb);
> > > > > @@ -2123,6 +2125,9 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct m=
lx5e_rq *rq, struct mlx5e_mpw_info *w
> > > > >                                 pagep->frags++;
> > > > >                         while (++pagep < frag_page);
> > > > >                 }
> > > > > +
> > > > > +               headlen =3D eth_get_headlen(rq->netdev, mxbuf->xd=
p.data, headlen);
> > > > > +
> > > >
> > > > The size of mxbuf->xdp.data is most likely not headlen here.
> > > >
> > > > The driver currently generates a xdp_buff with empty linear data, p=
ass
> > > > it to the xdp program and assumes the layout If the xdp program doe=
s
> > > > not change the layout of the xdp_buff through bpf_xdp_adjust_head()=
 or
> > > > bpf_xdp_adjust_tail(). The assumption is not correct and I am worki=
ng
> > > > on a fix. But, if we keep that assumption for now, mxbuf->xdp.data
> > > > will not contain any headers or payload. The thing that you try to =
do
> > > > probably should be:
> > > >
> > > >         skb_frag_t *frag =3D &sinfo->frags[0];
> > > >
> > > >         headlen =3D eth_get_headlen(rq->netdev, skb_frag_address(fr=
ag),
> > > > skb_frag_size(frag));
> >
> > So, when I look at the headlen I get, it is correct (even with my old
> > code using mxbuf->xdp.data).
> >
> > To make sure I test the right thing, which scenario would
> > mxbuf->xdp.data not contain any headers or payload ? What do I need to
> > do to reproduce that ?
>
> A quick look at the code, could it be that
> skb_flow_dissect_flow_keys_basic() returns false so that
> eth_get_headlen() always returns sizeof(*eth)?

No, the headlen values were correct (meaning, it was the actual length
of the headers):

This is TCP-traffic with a simple print after eth_get_headlen:
[130982.311088] mlx5e_skb_from_cqe_mpwrq_nonlinear xdp headlen is 86

So, eth_get_headlen was able to correctly parse things.

My xdp-program is as simple as possible:
SEC("xdp.frags")
int xdp_pass_prog(struct xdp_md *ctx)
{
    return XDP_PASS;
}


> The linear part
> contains nothing meaning before __psk_pull_tail(), so it is possible
> for skb_flow_dissect_flow_keys_basic() to fail.
>
> >
> > Thanks,
> > Christoph
> >
> > >
> > > Ok, I think I understand what you mean! Thanks for taking the time to=
 explain!
> > >
> > > I will do some tests on my side to make sure I get it right.
> > >
> > > As your change goes to net and mine to netnext, I can wait until your=
s
> > > is in the tree so that there aren't any conflicts that need to be
> > > taken care of.
>
> Will Copy you in the mlx5 non-linear xdp fixing patchset.

Thx!


Christoph

