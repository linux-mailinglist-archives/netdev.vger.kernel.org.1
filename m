Return-Path: <netdev+bounces-131872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D48C98FC9D
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 06:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E841A1F23542
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 04:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED642AD11;
	Fri,  4 Oct 2024 04:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlyWunj1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94879C8FF;
	Fri,  4 Oct 2024 04:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728014493; cv=none; b=A3YCMKjVA43EhT12uJCMS610vSt/o3pW+Slm/elNBGL8GX0KE6um0jhrV3BKe3YfE68SRGs8XiB1F3EsiKruCevPNYrN38cPCoT0GYvTN/UO4ABzAS6bo+snxp8u6LgyykFdicJdHTdm7ob2zD8mSx8NWQsO4clKBAqloIkn74w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728014493; c=relaxed/simple;
	bh=l5S4zSgk39/1vFvakpqrurpzGlXpS1OMzzY3Qu0SpNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YmkSJ/fuOJyWj1W3Rj6htBb7dHvWdb5XxdzX8/pYvgjNKxc+GcSGeqlY6M8opp8GtLhm5SK0iNkY322RHVLXtdTFX2cbd5QjHsmScQaSuesmJ6NoLP7J99TWcpsZM9rFllfW/57N4NvI8UjIXl9etD4UfH5ZhrOpPLgSUCroB1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlyWunj1; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c87853df28so2070892a12.3;
        Thu, 03 Oct 2024 21:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728014490; x=1728619290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtWaB7/+pqgSIbs6QCNNW9clMyGfcjBIDYBUKvysBTA=;
        b=XlyWunj1i/jXiJJhec7g9977fbKM0qdoxvTbL+Znb1Z36ixAvZCqOLK6+HmBoxJw5J
         KwRlAf/sjt24i/KYkBPG1EquG1bJU/qTXz9CMjvdGxmtkn9c3TjvLXZjXOqHzt6Vd06D
         iM1a0jXNOifqt169sET0IdoNO1/Bh3DWcz91mayKfeX88dDmpKeInlcTkgCZ2eFDNXzU
         85Prncba3X2uf6+nut8Cl3zh+U18//2g4t1MUzfm1IzBoXAs+LB2cKaCuPOekXndXvZs
         eZumUanWid7BABQjRSHoMYPlitXQLjQEoaXu+FxcBhRwkmgWMZ7a3mdIKi6hR+E70UpG
         oOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728014490; x=1728619290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtWaB7/+pqgSIbs6QCNNW9clMyGfcjBIDYBUKvysBTA=;
        b=UauRSWw4rAYD26LTcY/v4RnUUTSXcgnd8ll+IK1rtaeMk8BBQ/75EZLF82u/vbFtjY
         7Kyl/t9PHuYSf4AkLyWYFTsVDoCBdwBaII15fzdEHT4sRiLjorJK9VQwlohVoNn/lGkT
         9GYvVjeVDj1FweCQg78+x4Tm1AiJ999b/Nlvvlr943r8W6CAjcMKkJ0w7SaeNzUbj6vR
         /6OiQTIKtLMWn1dqs/vgDKX/MT/kBvUOkklX/UjijJJpIS9yF/q7JB6xq2wV8DXc/gDH
         QcHyvW2lNyr8CyOBbAJz5qyM+EGzsV/txAwSKUM2A6GbGmXrrkmHVPLKx1elOXD78iao
         6JUw==
X-Forwarded-Encrypted: i=1; AJvYcCUBFTZxHAcV0Bv8rD7crOvT2Mj2xZNtpb2g7pcCO0QW06wZGfqgDtqGUb/Bo6G2lncQ0IfKP1be@vger.kernel.org, AJvYcCWN3sYHGOSG1Um3zV4x4e3SAhWl/dYgpPy72fNNGZQbpVEB6naItbM8p1X/mgxtI1A8uo1MVwZ7XNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpJq2aB/y+DbM71zRDmus51RppMebGjuZdKpJfJzg57gzv7SGL
	MvBs0T6oxaWJI0HN6co2nV1HU7+Zi/O07wdG1Zu9L0nux+uqtAuItdihhXu4NELvZQ+MWKFw1uA
	G9ZlSgogWxqzdFYLK+DZpI6P8FDE=
X-Google-Smtp-Source: AGHT+IGUS9+BtlWQHPBUAIwkiyHrg8GBSbYlO2wrTjMmJV4zOOmSlVldyvtvZ/VwCgj6NoXODIWU/Q/le4FT9SpETEk=
X-Received: by 2002:a05:6402:321b:b0:5c7:2122:50d with SMTP id
 4fb4d7f45d1cf-5c8d2e989a1mr941349a12.35.1728014489529; Thu, 03 Oct 2024
 21:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003160620.1521626-1-ap420073@gmail.com> <20241003160620.1521626-6-ap420073@gmail.com>
 <70c16ec6-c1e8-4de2-8da7-a9cc83df816a@amd.com>
In-Reply-To: <70c16ec6-c1e8-4de2-8da7-a9cc83df816a@amd.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Fri, 4 Oct 2024 13:01:17 +0900
Message-ID: <CAMArcTX+j4patttqm+F8zLAE55DDn1mpBuXQoWpf3NCHo96cYw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/7] net: devmem: add ring parameter filtering
To: Brett Creeley <bcreeley@amd.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, almasrymina@google.com, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, donald.hunter@gmail.com, corbet@lwn.net, 
	michael.chan@broadcom.com, kory.maincent@bootlin.com, andrew@lunn.ch, 
	maxime.chevallier@bootlin.com, danieller@nvidia.com, hengqi@linux.alibaba.com, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, 
	ahmed.zaki@intel.com, paul.greenwalt@intel.com, rrameshbabu@nvidia.com, 
	idosch@nvidia.com, asml.silence@gmail.com, kaiyuanz@google.com, 
	willemb@google.com, aleksander.lobakin@intel.com, dw@davidwei.uk, 
	sridhar.samudrala@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 3:35=E2=80=AFAM Brett Creeley <bcreeley@amd.com> wro=
te:
>

Hi Brett,
Thanks a lot for your review!

>
>
> On 10/3/2024 9:06 AM, Taehee Yoo wrote:
> > Caution: This message originated from an External Source. Use proper ca=
ution when opening attachments, clicking links, or responding.
> >
> >
> > If driver doesn't support ring parameter or tcp-data-split configuratio=
n
> > is not sufficient, the devmem should not be set up.
> > Before setup the devmem, tcp-data-split should be ON and
> > tcp-data-split-thresh value should be 0.
> >
> > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > ---
> >
> > v3:
> >   - Patch added.
> >
> >   net/core/devmem.c | 18 ++++++++++++++++++
> >   1 file changed, 18 insertions(+)
> >
> > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > index 11b91c12ee11..a9e9b15028e0 100644
> > --- a/net/core/devmem.c
> > +++ b/net/core/devmem.c
> > @@ -8,6 +8,8 @@
> >    */
> >
> >   #include <linux/dma-buf.h>
> > +#include <linux/ethtool.h>
> > +#include <linux/ethtool_netlink.h>
> >   #include <linux/genalloc.h>
> >   #include <linux/mm.h>
> >   #include <linux/netdevice.h>
> > @@ -131,6 +133,8 @@ int net_devmem_bind_dmabuf_to_queue(struct net_devi=
ce *dev, u32 rxq_idx,
> >                                      struct net_devmem_dmabuf_binding *=
binding,
> >                                      struct netlink_ext_ack *extack)
> >   {
> > +       struct kernel_ethtool_ringparam kernel_ringparam =3D {};
> > +       struct ethtool_ringparam ringparam =3D {};
> >          struct netdev_rx_queue *rxq;
> >          u32 xa_idx;
> >          int err;
> > @@ -146,6 +150,20 @@ int net_devmem_bind_dmabuf_to_queue(struct net_dev=
ice *dev, u32 rxq_idx,
> >                  return -EEXIST;
> >          }
> >
> > +       if (!dev->ethtool_ops->get_ringparam) {
> > +               NL_SET_ERR_MSG(extack, "can't get ringparam");
> > +               return -EINVAL;
> > +       }
>
> Is EINVAL the correct return value here? I think it makes more sense as
> EOPNOTSUPP.

Yes, Thanks for catching this.

>
> > +
> > +       dev->ethtool_ops->get_ringparam(dev, &ringparam,
> > +                                       &kernel_ringparam, extack);
> > +       if (kernel_ringparam.tcp_data_split !=3D ETHTOOL_TCP_DATA_SPLIT=
_ENABLED ||
> > +           kernel_ringparam.tcp_data_split_thresh) {
> > +               NL_SET_ERR_MSG(extack,
> > +                              "tcp-header-data-split is disabled or th=
reshold is not zero");
> > +               return -EINVAL;
> > +       }
> > +
> Maybe just my personal opinion, but IMHO these checks should be separate
> so the error message can be more concise/clear.

I agree, the error message is not clear, it contains two conditions.

>
> Also, a small nit, but I think both of these checks should be before
> getting the rxq via __netif_get_rx_queue().
>

I will drop this patch in a v4 patch.

Thanks a lot!
Taehee Yoo

>
> Thanks,
>
> Brett
> >   #ifdef CONFIG_XDP_SOCKETS
> >          if (rxq->pool) {
> >                  NL_SET_ERR_MSG(extack, "designated queue already in us=
e by AF_XDP");
> > --
> > 2.34.1
> >

