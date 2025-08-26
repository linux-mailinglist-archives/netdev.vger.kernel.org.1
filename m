Return-Path: <netdev+bounces-216765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A8BB35133
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 03:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1399916831D
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 01:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01DF1D5CD4;
	Tue, 26 Aug 2025 01:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJP+myPI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12415193077;
	Tue, 26 Aug 2025 01:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756172893; cv=none; b=l5l6hukR++6lO65/C9Zp/vH6P5j9KTr7N9swz/oqMu9FxQPp2YUBknSfMmOVQXscF61Pp2VEXbGxv1NHHrCT7soRVc7WQkT+MMQV/rhrkju1YNNUjXCI3ZtjNcelnm9VpVkF01KGDkVw6RYbg0BhQgCOSW/ZiVPdhI7NGpE1j/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756172893; c=relaxed/simple;
	bh=TXlmb/9qREB29LaLCNsyKNtucJXD1nPqxFKoaQ87A6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iiOiZWlIyccU4kl9tvMxIEA5cR2aDoB92CMeQhgAVunz5Op9KyA+eI9eQrynS1PggpkDNCqilThRY9yPMcRl6PNfVBoJUnUdsxvxG397BuAenXxDW85D6n7CFgc01oW7vJghG921u/K0kuWyOYjaAASpAZzApDia4FfCnHDpNUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJP+myPI; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e1fc69f86so4730786b3a.0;
        Mon, 25 Aug 2025 18:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756172891; x=1756777691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2rv87CiIlaUXE3+jm7goSIfKAqP/cKTN5D58jERWFo=;
        b=jJP+myPIxu0k7I018gScAu+KOWT0ebiBi0yWu8ppIrAHTC1/XoufUih5fcqSoWGV8l
         Q9gThA2mXhmRwAidFEEW8XtwT9VQcVVcs9sIbWUfjLyDcJkAM8i+TC2sqrpU+44Hp141
         JL2GxRt6IPF7rqjXQR7pNypfmtIXODHfxijFINHYL+NHtSKu8aNPeia1UkEE+X3TkCJa
         025OHI3QeIcurpeyD7EdTeTivbJfrJR2KsnWd8fxRJxTjm8E2HXIXyvtXWqkvaNOZ+QL
         Bv+OEZfjtmgNSVVJTixG7TLDZRWc9xwcTZi2EV7RPTQf3kWH/juBuDw2y3FhUZSL82YC
         r+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756172891; x=1756777691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2rv87CiIlaUXE3+jm7goSIfKAqP/cKTN5D58jERWFo=;
        b=npS+e2WfhSYraHyZn/Waj/sTvy5ITnVxjOVI6LoJbXwE+yG+t3iVUeR3+CLZ+xHFE2
         /mU4yNkjfPJgscTBpVE7lVDEAFg76ZmdvvOizphnhpXS/3fE3/2FDSMH1Xu4lku2aoyQ
         iqwwpntbTh6hd/uDUaTbKCurXA3vZ5UZstFrJh32TEmMeUIeRSjOQVqdNLiWqGxlFjLc
         QdZQ5eZKg0qa0eD8D0fAb9p8o7QRenhtjK1CGL91UFMPKsjmZaF/Zn4lFB90dGL5LpL3
         fnQx4DCtwplrELH/52cj1eNtm4CNwme52J9y4lRH5vDH3yytwVpXCkrj2x+NqKUdpAAz
         TRMw==
X-Forwarded-Encrypted: i=1; AJvYcCU73QaMu8pR1f+SDud0zbmhsLqHMFUb3WbIRSCzkZ8YfBCMyKsTvSrORtvqOf9gp4lv+DG4MnscAJHHuhZz@vger.kernel.org, AJvYcCWKnF/NIURUhrg+Se1gBdqsnHfA7fBO25AEQn049EoVUFZ++vFeW0bg8fFBDJxRyRfGIST0g4edxRAj@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzk7VNebPuUO824U9IenHU9EKB6xI7gTHS9Fzi1ZBSeR3fubce
	OWthr+Lof3WQzJIXkOljOVnzglF6vX+fRAr7cpWO+VpooGMa1Ai1CVJND9O02ajD/c8Poceihl8
	p2inm0WFhG6/iEWL67+3B/EzhiVushhY=
X-Gm-Gg: ASbGncvtk3ifyyb4SIB9d3M6mskjocJSsgs/gFmt3o0jcoG9OIqZf/lmZGZs7z2hPXq
	iitwznpGbFeaBm6ywPPARBA1ZGZ8nh3NAtkjOts11zXfGkgkF3VLh5pZGKxQOgeBPxYCfHpGoCp
	tqNneCo6+T2Dj+aOb/TgES2lJm3OIdL0zHTFnoXbqxjHyDw8TDkqqt4QNl3eP+NKb2b0k637kgI
	i4DbQY6Ng==
X-Google-Smtp-Source: AGHT+IHjfLbOVpZrDHzYBkDUKw+cBdTlEH4KPss4LsVbT67Db2YSjQtRdqCtT/4qEhlvM37k+3mSndedIkiRowmTXzM=
X-Received: by 2002:a05:6a20:748a:b0:240:d246:dacc with SMTP id
 adf61e73a8af0-243877fba70mr1932171637.10.1756172891196; Mon, 25 Aug 2025
 18:48:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824005116.2434998-1-mmyangfl@gmail.com> <20250824005116.2434998-3-mmyangfl@gmail.com>
 <20250825221507.vfvnuaxs7hh2jy7d@skbuf>
In-Reply-To: <20250825221507.vfvnuaxs7hh2jy7d@skbuf>
From: Yangfl <mmyangfl@gmail.com>
Date: Tue, 26 Aug 2025 09:47:34 +0800
X-Gm-Features: Ac12FXxoYQa5rIxNbeupCI_mYuItTrgsF0jY2pXnIzUJ4_52WcYuVhlKDw_TzCw
Message-ID: <CAAXyoMNh-6_NtYGBYYBhbiH0UPWCOoiZNhMkgeGqPzKP3HA-_g@mail.gmail.com>
Subject: Re: [PATCH net-next v6 2/3] net: dsa: tag_yt921x: add support for
 Motorcomm YT921x tags
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 6:15=E2=80=AFAM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> On Sun, Aug 24, 2025 at 08:51:10AM +0800, David Yang wrote:
> > diff --git a/net/dsa/Makefile b/net/dsa/Makefile
> > index 555c07cfeb71..4b011a1d5c87 100644
> > --- a/net/dsa/Makefile
> > +++ b/net/dsa/Makefile
> > @@ -39,6 +39,7 @@ obj-$(CONFIG_NET_DSA_TAG_SJA1105) +=3D tag_sja1105.o
> >  obj-$(CONFIG_NET_DSA_TAG_TRAILER) +=3D tag_trailer.o
> >  obj-$(CONFIG_NET_DSA_TAG_VSC73XX_8021Q) +=3D tag_vsc73xx_8021q.o
> >  obj-$(CONFIG_NET_DSA_TAG_XRS700X) +=3D tag_xrs700x.o
> > +obj-$(CONFIG_NET_DSA_TAG_YT921X) +=3D tag_yt921x.o
> >
> >  # for tracing framework to find trace.h
> >  CFLAGS_trace.o :=3D -I$(src)
> > diff --git a/net/dsa/tag_yt921x.c b/net/dsa/tag_yt921x.c
> > new file mode 100644
> > index 000000000000..ab7f97367e76
> > --- /dev/null
> > +++ b/net/dsa/tag_yt921x.c
> > @@ -0,0 +1,126 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Motorcomm YT921x Switch Extended CPU Port Tagging
> > + *
> > + * Copyright (c) 2025 David Yang <mmyangfl@gmail.com>
> > + *
> > + * +----+----+-------+-----+----+---------
> > + * | DA | SA | TagET | Tag | ET | Payload ...
> > + * +----+----+-------+-----+----+---------
> > + *   6    6      2      6    2       N
> > + *
> > + * Tag Ethertype: CPU_TAG_TPID_TPID (default: 0x9988)
> > + * Tag:
> > + *   2: Service VLAN Tag
> > + *   2: Rx Port
> > + *     15b: Rx Port Valid
> > + *     14b-11b: Rx Port
> > + *     10b-0b: Unknown value 0x80
> > + *   2: Tx Port(s)
> > + *     15b: Tx Port(s) Valid
> > + *     10b-0b: Tx Port(s) Mask
> > + */
> > +
> > +#include <linux/etherdevice.h>
> > +#include <linux/list.h>
> > +#include <linux/slab.h>
>
> Why include list.h and slab.h?
>
> > +
> > +#include "tag.h"
> > +
> > +#define YT921X_NAME  "yt921x"
> > +
> > +#define YT921X_TAG_LEN       8
> > +
> > +#define ETH_P_YT921X 0x9988
>
> You can add a header in include/linux/dsa/ which is shared with the
> switch driver, to avoid duplicate definitions.
>
> > +
> > +#define YT921X_TAG_PORT_EN           BIT(15)
> > +#define YT921X_TAG_RX_PORT_M         GENMASK(14, 11)
> > +#define YT921X_TAG_RX_CMD_M          GENMASK(10, 0)
> > +#define  YT921X_TAG_RX_CMD(x)                        FIELD_PREP(YT921X=
_TAG_RX_CMD_M, (x))
> > +#define   YT921X_TAG_RX_CMD_UNK_NORMAL                       0x80
> > +#define YT921X_TAG_TX_PORTS_M                GENMASK(10, 0)
> > +#define  YT921X_TAG_TX_PORTn(port)           BIT(port)
> > +
> > +static struct sk_buff *
> > +yt921x_tag_xmit(struct sk_buff *skb, struct net_device *netdev)
> > +{
> > +     struct dsa_port *dp =3D dsa_user_to_port(netdev);
> > +     unsigned int port =3D dp->index;
> > +     __be16 *tag;
> > +     u16 tx;
> > +
> > +     skb_push(skb, YT921X_TAG_LEN);
> > +     dsa_alloc_etype_header(skb, YT921X_TAG_LEN);
> > +
> > +     tag =3D dsa_etype_header_pos_tx(skb);
> > +
> > +     /* We might use yt921x_priv::tag_eth_p, but
> > +      * 1. CPU_TAG_TPID could be configured anyway;
> > +      * 2. Are you using the right chip?
>
> The tag format sort of becomes fixed ABI as soon as user space is able
> to run "cat /sys/class/net/eth0/dsa/tagging", see "yt921x", and record
> it to a pcap file. Unless the EtherType bears some other meaning rather
> than being a fixed value, then if you change it later to some other
> value than 0x9988, you'd better also change the protocol name to
> distinguish it from "yt921x".
>

"EtherType" here does not necessarily become EtherType; better to
think it is a key to enable port control over the switch. It could be
a dynamic random value as long as everyone gets the same value all
over the kernel, see the setup process of the switch driver. Ideally
only the remaining content of the tag should become the ABI (and is
actually enforced by the switch), but making a dynamic "EtherType" is
clearly a worse idea so I don't know how to clarify the fact...

> Also, you can _not_ use yt921x_priv :: tag_eth_p, because doing so would
> assume that typeof(ds->priv) =3D=3D struct yt921x_priv. In principle we
> would like to be able to run the tagging protocols on the dsa_loop
> driver as well, which can be attached to any network interface. Very
> few, if any, tagging protocol drivers don't work on dsa_loop.
>
> > +      */
> > +     tag[0] =3D htons(ETH_P_YT921X);
> > +     /* Service VLAN tag not used */
> > +     tag[1] =3D 0;
> > +     tag[2] =3D 0;
> > +     tx =3D YT921X_TAG_PORT_EN | YT921X_TAG_TX_PORTn(port);
> > +     tag[3] =3D htons(tx);
> > +
> > +     /* Now tell the conduit network device about the desired output q=
ueue
> > +      * as well
> > +      */
> > +     skb_set_queue_mapping(skb, port);
>
> This is generally used for integrated DSA switches, for lossless
> backpressure during CPU transmission, where the conduit interface driver
> is known, and has set up its queues in a special way, as a result of the
> fact that it is attached to a known DSA switch (made by the same vendor).
> What do you need it for, in a discrete MDIO-controlled switch?
>
> > +
> > +     return skb;
> > +}
> > +
> > +static struct sk_buff *
> > +yt921x_tag_rcv(struct sk_buff *skb, struct net_device *netdev)
> > +{
> > +     unsigned int port;
> > +     __be16 *tag;
> > +     u16 rx;
> > +
> > +     if (unlikely(!pskb_may_pull(skb, YT921X_TAG_LEN)))
> > +             return NULL;
> > +
> > +     tag =3D (__be16 *)skb->data;
>
> Use dsa_etype_header_pos_rx() and validate the CPU_TAG_TPID_TPID as well.
>

See the above explanation why rx "EtherType" is not considered part of ABI.

> > +
> > +     /* Locate which port this is coming from */
> > +     rx =3D ntohs(tag[1]);
> > +     if (unlikely((rx & YT921X_TAG_PORT_EN) =3D=3D 0)) {
> > +             dev_warn_ratelimited(&netdev->dev,
> > +                                  "Unexpected rx tag 0x%04x\n", rx);
> > +             return NULL;
> > +     }
> > +
> > +     port =3D FIELD_GET(YT921X_TAG_RX_PORT_M, rx);
> > +     skb->dev =3D dsa_conduit_find_user(netdev, 0, port);
> > +     if (unlikely(!skb->dev)) {
> > +             dev_warn_ratelimited(&netdev->dev,
> > +                                  "Couldn't decode source port %u\n", =
port);
> > +             return NULL;
> > +     }
> > +
> > +     /* Remove YT921x tag and update checksum */
> > +     skb_pull_rcsum(skb, YT921X_TAG_LEN);
> > +
> > +     dsa_default_offload_fwd_mark(skb);
> > +
> > +     dsa_strip_etype_header(skb, YT921X_TAG_LEN);
> > +
> > +     return skb;
> > +}
> > +
> > +static const struct dsa_device_ops yt921x_netdev_ops =3D {
> > +     .name   =3D YT921X_NAME,
> > +     .proto  =3D DSA_TAG_PROTO_YT921X,
> > +     .xmit   =3D yt921x_tag_xmit,
> > +     .rcv    =3D yt921x_tag_rcv,
> > +     .needed_headroom =3D YT921X_TAG_LEN,
> > +};
> > +
> > +MODULE_DESCRIPTION("DSA tag driver for Motorcomm YT921x switches");
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_YT921X, YT921X_NAME);
> > +
> > +module_dsa_tag_driver(yt921x_netdev_ops);
> > --
> > 2.50.1
> >
>

