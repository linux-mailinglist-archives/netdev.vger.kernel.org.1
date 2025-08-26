Return-Path: <netdev+bounces-216954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA9AB36750
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 16:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989EA8E5CA7
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A6A352FE1;
	Tue, 26 Aug 2025 13:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UG5Wugfz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1777225390;
	Tue, 26 Aug 2025 13:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216301; cv=none; b=P2A3D/UAYMz44d+Gvl6F9zdopUuODNvSNSkWrTYM4A1NidEJs/KcY9/i96fbHbLUqps982veqqf6gkiJH66oOocKIHoHJEwRSjKTOF53ch/4dauV5YMvRZ+roj0Fy9bn04N9VMnoIJv6C/IHREe/u07Z/d0y5zuRXhNv0Vg2S/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216301; c=relaxed/simple;
	bh=SIw362ifD+ufSkuQj8iP4FiWJdIeDGR76AzxDKtwiCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxRaBAni5DCL2D1FeT4Q/W2T4WrDnCSydcNXBDMsEhNgXNX1bgWfDHdXQlp8ateXJ5mRuztHYY0M8ckw54m/KoxohkqN45bxL8rezk0SYg3Pjpt4GQoyoR14m+QQdBDNTkooeHIKOHmgMvvvRHusVD+joAv3Kpv+UMuXp1YKLJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UG5Wugfz; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b05a59dso5410845e9.1;
        Tue, 26 Aug 2025 06:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756216294; x=1756821094; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ywd60c3QRi+wtoh5EX+H9Sap8GLDH/kDWZe0fMofRPA=;
        b=UG5WugfzAH1ND5Z34AXj7BGfzuthQmOc+ZCDJNzdjrjR9nqb4nB9Xfy1A9NmvFtFUX
         2H9n/Z9Q72UTDs1LHHY2A689o7askYimeV/s+5EABnvOSyKtLuH6fk3Ti1yCbYS/RXsW
         JwNSu5P+HztNRBv/q5xdlXy9ZzGo9c7EneCVvLjCMAdYZgWEGXmgCqu5n3U+5iL30N7r
         8W19pXytjA+peg2pZpCRUDWPfb6YlwLcR3P+IMKaVQRVe/I0l87w6ZAau88NdNSQsTtm
         v57UIYjUqFxUGDfhk0bR8+/TVZLplQs66XJFS0Ux3ba+VYWzADvK+bWr0zkV/86TA58N
         cZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756216294; x=1756821094;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ywd60c3QRi+wtoh5EX+H9Sap8GLDH/kDWZe0fMofRPA=;
        b=NCIaSj0B7bvaEuSrDHDe8Fvfzr04AsseuTfm7VEhQtfjQnJq2dCpX6HDxcalq0189t
         rTa05RSQB6Zg+2Kv2O8XhLzyQyCs+oMx4Zqg2Sj+pu81Qig2SEh78hLqoxlym4GuqHrN
         xuIRZyvqe3w9EuulJuq/9y0R55fJwiEQbLl1QuQv2/Y44U5mxxzUPlpPDejvEvyKkTfA
         WPjqyaY/DqWF2gzSGeEyp5knGFuvfrhjQbC8iLvmCQlE0nQdw/JmjCuQjzKHhoUbh7Ch
         9lIfoZtwBHJ2PwWjJ486SDCNkM+EO9jzlzba8sGIEqx3oVByhMFuUTEVnxWMt9IEaqnb
         uqPA==
X-Forwarded-Encrypted: i=1; AJvYcCXS26C0yIiVJbgRzd9EPrE4wxnOHh0T6WTegrsKJ7RrwxX8qEWA5G9KC54wQ2h6bWeK44vmu2yoyb6OiR96@vger.kernel.org, AJvYcCXxyAJnkvYDbqme0P3idFSVYsN81d8qZJpuL8UrrZFiaIC5+B9/iwDagNBrnVmNawPkeKr8gRnGzJe+@vger.kernel.org
X-Gm-Message-State: AOJu0YwyJuGfb6nQqeUwIElPK+6zYLM3s1HIfBrJqnXC1HadT8H4AedR
	CtiZV7SeV6Rh83jmtiloxFRVlptAWde3buuoHyUpyZlVzaB9n3ALw3fi
X-Gm-Gg: ASbGncvLzf2o6Ac9mvB8wGHGkRNZfhh4FapIGTyQSeELCmwK0uva/KqshuHbLYLDEaM
	RDOd4NTHkt+i2lR1o0wFZqje4F8DZV7kpsdsFoiYzJx35NlhpeiGFizwSmuY7D2TuPrFKcY11US
	DiM0dlSDHWK854mR0ZmRgGcZads+hapqfZ0eI9ZYpHWku/IwADJ+0IxcoQLRZ/+yUTTy7EDYVVO
	AYs0cxVE3HElNHM1IR5xgdvfa4ABikKhdtllqmuYH4Bpg/PiWOKCXTYgRc8rQxO7Fc63WiYJAYk
	y9CaxSP2aMGSR+7Ya8zkIMXGtwmgibVnhRQdoHqZs7sBfn3FbI99H4Jm00N6NNFaFuyfx5vQfQk
	N34g0BdzS1QQc1rP+hrA7KH9v
X-Google-Smtp-Source: AGHT+IE2CbHpFJdF5EwM7Jkrq/EmxXnw4LDO+wdIGj4AKnAGlKfdOuZcCP+ZNPQCxcXaZQX6jhB9kQ==
X-Received: by 2002:a05:600c:4715:b0:459:ddd6:1cbf with SMTP id 5b1f17b1804b1-45b517396aemr64705215e9.0.1756216293541;
        Tue, 26 Aug 2025 06:51:33 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:63b:fbf0:5e17:81ec])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7116e1478sm16289614f8f.46.2025.08.26.06.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 06:51:32 -0700 (PDT)
Date: Tue, 26 Aug 2025 16:51:30 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Yangfl <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 3/3] net: dsa: yt921x: Add support for
 Motorcomm YT921x
Message-ID: <20250826135130.fyflt62y3fjoekmg@skbuf>
References: <20250824005116.2434998-1-mmyangfl@gmail.com>
 <20250824005116.2434998-4-mmyangfl@gmail.com>
 <20250825212357.3acgen2qezuy533y@skbuf>
 <CAAXyoMOVY7EvY9CtAphWcZrfNpz+JuUXcTf3M79FSYkbLSTvhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAXyoMOVY7EvY9CtAphWcZrfNpz+JuUXcTf3M79FSYkbLSTvhg@mail.gmail.com>

On Tue, Aug 26, 2025 at 01:19:58PM +0800, Yangfl wrote:
> On Tue, Aug 26, 2025 at 5:24 AM Vladimir Oltean <olteanv@gmail.com> wrote:
> > > +#define YT921X_PVID_DEFAULT          1
> >
> > If you have a VLAN-unaware bridge with learning enabled, this will
> > learn MAC addresses in VID 1. If you also have a VLAN-aware bridge with
> > default_pvid 1 on a different port group, this will also learn MAC
> > addresses in VID 1.
> 
> I could set PVID to 0, but I checked my mv88e6352 device and it learns
> MAC addresses in VID 4095 when egress is untagged, so I might place a
> PVID here anyway.
> 
> > Are the two FDB databases isolated, or if two stations with the same MAC
> > address are present in both bridges, will the switch attempt to forward
> > packets from one bridge to another (leading to packet drops)?
> > This can happen, for example, with the MAC addresses of user ports,
> > which all inherit the conduit's MAC address when there is no address
> > specified in the device tree.
> 
> FDB isolation is not supported, but port isolation is enforced here.

Somehow, I fail to see how this answer addresses what I said.

When writing a new device driver, you have to think about FDB isolation.
At the most basic level, that can be achieved by not reusing the same
VLAN across multiple forwarding domains where MAC address namespace
collisions might exist. That is all.

There are things I don't understand in what you're trying to transmit,
such as:
- "I might place a PVID here anyway" - do you have the option of _not_
having a default port PVID, for when the port is standalone? I don't
understand the optionality of "I might".
- "my mv88e6352 device (...) learns MAC addresses in VID 4095 when egress
is untagged" - actually it learns in MV88E6XXX_VID_BRIDGED when under a
VLAN-unaware bridge, not when "egress is untagged".

but I strongly suggest taking a look at the selftests before you follow
up to this part again.

> > > +static int
> > > +yt921x_dsa_port_mirror_add(struct dsa_switch *ds, int port,
> > > +                        struct dsa_mall_mirror_tc_entry *mirror,
> > > +                        bool ingress, struct netlink_ext_ack *extack)
> > > +{
> > > +     struct yt921x_priv *priv = to_yt921x_priv(ds);
> > > +     struct device *dev = to_device(priv);
> > > +     u32 ctrl;
> > > +     u32 val;
> > > +     int res;
> > > +
> > > +     dev_dbg(dev, "%s: port %d, ingress %d\n", __func__, port, ingress);
> > > +
> > > +     yt921x_smi_acquire(priv);
> > > +     do {
> > > +             u32 srcs;
> > > +
> > > +             res = yt921x_smi_read(priv, YT921X_MIRROR, &val);
> > > +             if (res)
> > > +                     break;
> > > +
> > > +             if (ingress)
> > > +                     srcs = YT921X_MIRROR_IGR_PORTn(port);
> > > +             else
> > > +                     srcs = YT921X_MIRROR_EGR_PORTn(port);
> > > +
> > > +             ctrl = val;
> > > +             ctrl |= srcs;
> > > +             ctrl &= ~YT921X_MIRROR_PORT_M;
> > > +             ctrl |= YT921X_MIRROR_PORT(mirror->to_local_port);
> > > +             if (ctrl == val)
> > > +                     break;
> >
> > yt921x_smi_update_bits() would have helped here, this is a bit hard to
> > follow.
> 
> I need the original value of the register which cannot be returned by
> yt921x_smi_update_bits(), but I could make it nicer.

Some of the API functions like regmap_update_bits_base() or
phy_modify_changed() have a way of telling the caller whether there was
any change in the original value or not. Maybe you can draw some
inspiration from them.

> > > +
> > > +             /* other mirror tasks & different dst port -> conflict */
> > > +             if ((val & ~srcs & (YT921X_MIRROR_EGR_PORTS_M |
> > > +                                 YT921X_MIRROR_IGR_PORTS_M)) != 0 &&
> > > +                 ((ctrl ^ val) & YT921X_MIRROR_PORT_M) != 0) {
> > > +                     res = -EEXIST;
> >
> > Use NL_SET_ERR_MSG_MOD(extack) to signal this.
> >
> > > +                     break;
> > > +             }
> > > +
> > > +             res = yt921x_smi_write(priv, YT921X_MIRROR, ctrl);
> > > +     } while (0);
> > > +     yt921x_smi_release(priv);
> > > +
> > > +     return res;
> > > +}
> > > +
> > > +/******** vlan ********/
> > > +
> > > +static int
> > > +yt921x_vlan_filtering(struct yt921x_priv *priv, int port, bool vlan_filtering)
> > > +{
> > > +     struct yt921x_port *pp = &priv->ports[port];
> > > +     u32 mask;
> > > +     u32 ctrl;
> > > +     int res;
> > > +
> > > +     res = yt921x_smi_toggle_bits(priv, YT921X_VLAN_IGR_FILTER,
> > > +                                  YT921X_VLAN_IGR_FILTER_PORTn_EN(port),
> > > +                                  vlan_filtering);
> > > +     if (res)
> > > +             return res;
> > > +
> > > +     mask = YT921X_PORT_VLAN_CTRL1_CVLAN_DROP_TAGGED |
> > > +            YT921X_PORT_VLAN_CTRL1_CVLAN_DROP_UNTAGGED;
> > > +     ctrl = 0;
> > > +     if (vlan_filtering) {
> > > +             if (!pp->pvid)
> > > +                     ctrl |= YT921X_PORT_VLAN_CTRL1_CVLAN_DROP_UNTAGGED;
> > > +             if (!pp->vids_cnt)
> > > +                     ctrl |= YT921X_PORT_VLAN_CTRL1_CVLAN_DROP_TAGGED;
> > > +     }
> > > +     res = yt921x_smi_update_bits(priv, YT921X_PORTn_VLAN_CTRL1(port),
> > > +                                  mask, ctrl);
> > > +     if (res)
> > > +             return res;
> > > +
> > > +     pp->vlan_filtering = vlan_filtering;
> >
> > The PVID depends on the VLAN filtering state of the port, so this
> > function needs to update the PVID.
> 
> If I got it right the PVID is already set and programmed below by pvid_set().

Yes, and yt921x_pvid_set() is not called from yt921x_vlan_filtering().
Have a look at Documentation/networking/switchdev.rst section, it
explains that the PVID configured by the bridge should only take effect
if the port is currently VLAN-aware, which is a state that
yt921x_vlan_filtering() changes. If the hardware PVID remains the same
when the port is VLAN-aware and VLAN-unaware, there is probably a bug
somewhere.

> > > +     return 0;
> > > +}
> > > +
> > > +/* Seems port_vlan_add() is not state transition method... */
> >
> > I'm not sure what's a state transition method, but .port_vlan_add() is
> > called if and only if a VLAN is added or the flags (PVID, untagged) of
> > an existing VLAN are changed.
> 
> So it's not "adding" VLANs and I cannot always pp->vids_cnt++.

In theory, it's adding VLANs as long as struct switchdev_obj_port_vlan :: changed
is false. Though, because switchdev_obj_port_vlan objects are added from
two sources (switchdev and .ndo_vlan_rx_add_vid()), there might still be
bugs which allow a switchdev VLAN to change an .ndo_vlan_rx_add_vid()
VLAN and not set the "changed" flag, or vice versa. Those would be just
bugs that need to be better sealed, though, since the goal is to not
permit multiple sources from adding the same VLAN ID to a port. One
would need to delete the first before adding the second.

This is just for your general information. I am wondering when will your
logic of tracking the number of VLAN IDs, and setting YT921X_PORT_VLAN_CTRL1_CVLAN_DROP_TAGGED,
make a difference? If there is no VLAN ID configured and the port is
VLAN-aware, won't the port drop all tagged packets without this flag set?
It seems extra complexity with no clear benefit.

> > > +static int
> > > +yt921x_pvid_clear(struct yt921x_priv *priv, int port)
> > > +{
> > > +     struct yt921x_port *pp = &priv->ports[port];
> > > +     u32 mask;
> > > +     u32 ctrl;
> > > +     int res;
> > > +
> > > +     mask = YT921X_PORT_VLAN_CTRL_CVID_M;
> > > +     ctrl = YT921X_PORT_VLAN_CTRL_CVID(YT921X_PVID_DEFAULT);
> > > +     res = yt921x_smi_update_bits(priv, YT921X_PORTn_VLAN_CTRL(port),
> > > +                                  mask, ctrl);
> > > +     if (res)
> > > +             return res;
> > > +
> > > +     if (pp->vlan_filtering) {
> > > +             mask = YT921X_PORT_VLAN_CTRL1_CVLAN_DROP_UNTAGGED;
> > > +             res = yt921x_smi_set_bits(priv, YT921X_PORTn_VLAN_CTRL1(port),
> > > +                                       mask);
> > > +             if (res)
> > > +                     return res;
> > > +     }
> > > +
> > > +     pp->pvid = 0;
> >
> > A bit confusing that the hardware is programmed with YT921X_PVID_DEFAULT
> > (1) but pp->pvid is 0. You might want to rename this to vlan_aware_pvid,
> > for clarity. Though on user ports, you can always query it directly
> > using br_vlan_get_pvid().
> 
> See above, if there is no consequence programming to 0.

I think we're talking past each other, and my previous comment wasn't
expressed in the clearest way.

You have to decide what pp->pvid means - whether it tracks only the PVID
from the bridge layer (as it currently does), or the PVID which the port
is programmed with, and which will have a different value from the
above, in the situations that the port is standalone or under a bridge
that is currently VLAN-unaware.

The bridge layer indeed will not attempt to add VID 0 or VID 4095, so
you could use any of these values as an indication that the port has no
bridge PVID (and should drop untagged and VID0-tagged packets). You are
currently using pp->pvid == 0 as an indication of "no bridge PVID", and
that is functionally fine.

I suggested that you rename pp->pvid to pp->vlan_aware_pvid, in order to
make it clearer that the two uses of the number 0 are different. It is
valid for the hardware PVID programmed to YT921X_PORT_VLAN_CTRL_CVID to
be 0, and it is valid for the bridge VLAN-aware PVID to be absent, but
the two are absolutely independent and separate conditions.

Whereas you are responding to this comment by saying (rephrased) "to
solve the inconsistency, I can program YT921X_PORT_VLAN_CTRL_CVID to 0
and that shouldn't have any consequences", but this further blurs the
line between the two PVID concepts instead of separating them.

I don't believe that when the bridge PVID gets deleted and the port is
VLAN-aware, the port should be reconfigured to YT921X_PVID_DEFAULT.
It should be sufficient that YT921X_PORT_VLAN_CTRL1_CVLAN_DROP_UNTAGGED
gets set - the hardware PVID in this case can be whatever it may.

> > > +     return 0;
> > > +}
> > > +
> > > +/******** bridge ********/
> > > +
> > > +/* It's caller's responsibility to decide whether ports_mask contains cpu
> > > + * ports
> > > + */
> >
> > I don't understand this comment. What did the caller decide after all?
> 
> They can make a bridge without cpu ports. Of course it's never the
> case in DSA, but it also serves as a reminder bitwise-oring your cpu
> ports after collecting user ports.

Perhaps for you it's clear, but for me it still isn't. If, as you say,
DSA always expects the CPU port to be in the forwarding mask, then what
decision is left in the caller's responsibility? To do what it has to do?

It would be, for me, much clearer to express what you just said as:
"The caller must make sure that the CPU port is part of the ports_mask".

> > > +static int yt921x_bridge(struct yt921x_priv *priv, u16 ports_mask)
> > > +{
> > > +     u16 targets_mask = ports_mask & ~priv->cpu_ports_mask;
> > > +     u32 isolated_mask;
> > > +     u32 ctrl;
> > > +     int res;
> > > +
> > > +     isolated_mask = 0;
> > > +     for (u16 pm = targets_mask; pm ; ) {
> > > +             struct yt921x_port *pp;
> > > +             int port = __fls(pm);
> > > +
> > > +             pm &= ~BIT(port);
> >
> > for_each_set_bit() would be easier to follow.
> >
> > > +             pp = &priv->ports[port];
> > > +
> > > +             if (pp->isolated)
> > > +                     isolated_mask |= BIT(port);
> > > +     }
> > > +
> > > +     /* Block from non-cpu bridge ports ... */
> > > +     for (u16 pm = targets_mask; pm ; ) {
> > > +             struct yt921x_port *pp;
> > > +             int port = __fls(pm);
> > > +
> > > +             pm &= ~BIT(port);
> > > +             pp = &priv->ports[port];
> > > +
> > > +             /* to non-bridge ports */
> > > +             ctrl = ~ports_mask;
> > > +             /* to isolated ports when isolated */
> > > +             if (pp->isolated)
> > > +                     ctrl |= isolated_mask;
> > > +             /* to itself when non-hairpin */
> > > +             if (!pp->hairpin)
> > > +                     ctrl |= BIT(port);
> > > +             else
> > > +                     ctrl &= ~BIT(port);
> > > +
> > > +             res = yt921x_smi_write(priv, YT921X_PORTn_ISOLATION(port),
> > > +                                    ctrl);
> >
> > Doesn't this write ones outside of the YT921X_PORT_ISOLATION_BLOCKn
> > field? I suppose there are some reserved high-order values which should
> > be preserved when writing?
> 
> No, it's safe to write excessive 1s here.

Still not the best practice, but ok.

> > > +             if (res)
> > > +                     return res;
> > > +     }
> > > +
> > > +     for (u16 pm = targets_mask; pm ; ) {
> > > +             struct yt921x_port *pp;
> > > +             int port = __fls(pm);
> > > +
> > > +             pm &= ~BIT(port);
> > > +             pp = &priv->ports[port];
> > > +
> > > +             pp->bridge_mask = ports_mask;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int yt921x_bridge_force(struct yt921x_priv *priv, u16 ports_mask)
> >
> > The bridge_force() function name is a bit unconventional, what does it
> > mean?
> >
> > > +{
> > > +     u16 targets_mask = ~ports_mask & (BIT(YT921X_PORT_NUM) - 1) &
> > > +                        ~priv->cpu_ports_mask;
> >
> > What is the intention here? Assume you have one bridge with ports A and B,
> > and another with ports C and D.
> >
> > Port D leaves the bridge, then targets_mask, the mask of ports which
> > will become standalone, is comprised of ports A, B and D. Why? This
> > sounds like a bug, ports A and B should remain untouched, as ports of an
> > unrelated bridge.
> 
> bridge_force() does not know it's Port D/E/F... leaving the bridge.
> 
> Although DSA does tell us which port is leaving, we choose to rely on
> hardware registers as much as possible, and wipe (force) configs on
> all (non-bridge) ports. This also helps killing any unintentional port
> leftovers if that (bug) does exist, otherwise errors would accumulate
> until a reset is unavoidable. (Should errors emerge in bridge(),
> bridge_force() would take care of them.)

Did you understand what I said? It doesn't look like it, or I don't
understand in which way what you said is related to it.

In yt921x_bridge_force(), targets_mask holds the user ports which are
not part of this bridge (all of them). You force them all as standalone.

But in the example I gave with two bridges, you are configuring the
ports of br0 as standalone, when an unrelated port leaves br1. According
to my understanding of the code, that isolates the ports of br0 from
each other, which is not what the user has asked for.

> > > +/******** fdb ********/
> > > +
> > > +static int yt921x_fdb_wait(struct yt921x_priv *priv, u32 *valp)
> > > +{
> > > +     struct device *dev = to_device(priv);
> > > +     u32 val;
> > > +     int res;
> > > +
> > > +     res = yt921x_smi_read(priv, YT921X_FDB_RESULT, &val);
> > > +     if (res)
> > > +             return res;
> > > +     if ((val & YT921X_FDB_RESULT_DONE) == 0) {
> > > +             yt921x_smi_release(priv);
> >
> > yuck, why is it ok to release the SMI lock here? What's the point of the
> > lock in the first place?
> 
> It's the bus lock, not the driver lock. We need to release the bus
> lock when we want to sleep.

What Andrew said, basically.

> > As a matter of fact, .port_fdb_add() and .port_fdb_del() are one of the
> > few operations which DSA emits which aren't serialized by rtnl_lock().
> > They can absolutely be concurrent with .port_fdb_dump(), .port_mdb_add(),
> > .port_mdb_del() etc. It seems like higher-level locking is needed.
> >
> > > +             res = read_poll_timeout(yt921x_smi_read_burst, res,
> > > +                                     (val & YT921X_FDB_RESULT_DONE) != 0,
> > > +                                     YT921X_MDIO_SLEEP_US,
> > > +                                     YT921X_MDIO_TIMEOUT_US,
> > > +                                     true, priv, YT921X_FDB_RESULT,
> > > +                                     &val);
> > > +             yt921x_smi_acquire(priv);
> > > +             if (res) {
> > > +                     dev_warn(dev, "Probably an FDB hang happened\n");
> > > +                     return res;
> > > +             }
> > > +     }
> > > +
> > > +     *valp = val;
> > > +     return 0;
> > > +}
> > > +
> > > +static void yt921x_dsa_port_fast_age(struct dsa_switch *ds, int port)
> > > +{
> > > +     struct yt921x_priv *priv = to_yt921x_priv(ds);
> > > +     struct device *dev = to_device(priv);
> > > +     int res;
> > > +
> > > +     dev_dbg(dev, "%s: port %d\n", __func__, port);
> > > +
> > > +     yt921x_smi_acquire(priv);
> > > +     res = yt921x_fdb_flush(priv, BIT(port), 0, false);
> > > +     yt921x_smi_release(priv);
> > > +
> > > +     if (res)
> > > +             dev_dbg(dev, "%s: %i\n", __func__, res);
> > > +}
> > > +
> > > +static int
> > > +yt921x_dsa_port_vlan_fast_age(struct dsa_switch *ds, int port, u16 vid)
> > > +{
> > > +     struct yt921x_priv *priv = to_yt921x_priv(ds);
> > > +     struct device *dev = to_device(priv);
> > > +     int res;
> > > +
> > > +     dev_dbg(dev, "%s: port %d, vlan %d\n", __func__, port, vid);
> > > +
> > > +     yt921x_smi_acquire(priv);
> > > +     res = yt921x_fdb_flush(priv, BIT(port), vid, false);
> > > +     yt921x_smi_release(priv);
> > > +
> > > +     return res;
> > > +}
> >
> > .port_vlan_fast_age() is dead code until dsa_port_supports_mst() returns
> > true. I advise you to delete it.
> >
> > > +
> > > +static int
> > > +yt921x_dsa_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
> > > +{
> > > +     struct yt921x_priv *priv = to_yt921x_priv(ds);
> > > +     struct device *dev = to_device(priv);
> > > +     u32 ctrl;
> > > +     int res;
> > > +
> > > +     dev_dbg(dev, "%s: %d\n", __func__, msecs);
> > > +
> > > +     /* AGEING reg is set in 5s step */
> > > +     ctrl = msecs / 5000;
> > > +
> > > +     /* Handle case with 0 as val to NOT disable learning */
> >
> > learning? maybe ageing?
> 
> 0 = immediate aged = not learning

Ok, I had other hardware in mind, where ageing_time==0 was a special
value for "never age".

> > > +     if (!ctrl)
> > > +             ctrl = 1;
> > > +     else if (ctrl > 0xffff)
> > > +             ctrl = 0xffff;
> > > +
> > > +     yt921x_smi_acquire(priv);
> > > +     res = yt921x_smi_write(priv, YT921X_AGEING, ctrl);
> > > +     yt921x_smi_release(priv);
> > > +
> > > +     return res;
> > > +}
> > > +
> > > +static int
> > > +yt921x_dsa_get_eeprom(struct dsa_switch *ds, struct ethtool_eeprom *eeprom,
> > > +                   u8 *data)
> > > +{
> > > +     struct yt921x_priv *priv = to_yt921x_priv(ds);
> > > +     unsigned int i = 0;
> > > +     int res;
> > > +
> > > +     yt921x_smi_acquire(priv);
> > > +     do {
> > > +             res = yt921x_edata_wait(priv);
> > > +             if (res)
> > > +                     break;
> > > +             for (; i < eeprom->len; i++) {
> > > +                     unsigned int offset = eeprom->offset + i;
> > > +
> > > +                     res = yt921x_edata_read_cont(priv, offset, &data[i]);
> > > +                     if (res)
> > > +                             break;
> > > +             }
> > > +     } while (0);
> > > +     yt921x_smi_release(priv);
> > > +
> > > +     eeprom->len = i;
> > > +     return res;
> >
> > What is contained in this EEPROM?
> >
> 
> No description, sorry.

So why do you dump it?

> > I guess you got this snippet from mv88e6xxx_mdios_register(), which is
> > different from your case because it is an old driver which has to
> > support older device trees, before conventions changed.
> >
> > Please only register the internal MDIO bus if it is present in the
> > device tree. This simplifies the driver and dt-bindings by having a
> > single way of describing ports with internal PHYs. Also, remove the
> > ds->user_mii_bus assignment after you do that.
> 
> How to access internal PHYs without registering the internal MDIO bus?
> I know .phy_read and .phy_write, but all dsa_user_mii_bus_init() does
> is to register and assign to ds->user_mii_bus for you using
> phy_read/phy_write. Giving that we have an external bus to register,
> it's pretty wired to register buses in two different ways. Also
> mt7530.c does so for its internal bus.

What Andrew said. If you need the internal MDIO bus, you describe it in
the device tree.

> > No STP state handling?
> 
> Support for (M)STP was suggested for a future series in previous reviews.

Ok, I expect yt921x_dsa_port_vlan_fast_age() will be removed from next
submissions until it isn't dead code anymore.

> > NACK for exposing a sysfs which allows user space to modify switch
> > registers without the driver updating its internal state.
> >
> > For reading -- also not so sure. There are many higher-level debug
> > interfaces which you should prefer implementing before resorting to raw
> > register reads. If there's any latching register in hardware, user space
> > can mess it up. What use case do you have?
> 
> It is not possible to debug the device without a register sysfs, see
> previous replies for why we need to lock the bus (but not necessarily
> the MDIO bus). And if they are to modify switch registers, that's what
> they want.

When I said "higher level debugging interfaces", I had in mind "higher
level" in the sense Andrew mentioned - devlink regions, etc for
functional areas of interest that the developer has foreseen - and not
"lower level" like MDIO bus level access, which is even worse than the
sysfs due to the non-atomic accesses that you mention.

> So it's also kind of development leftover, but if anyone wants to
> improve the driver, they would come up with pretty the same debug
> solution as this, thus I consider it useful in the future. If that
> effort is still not appreciated, it might be wrapped inside a #ifdef
> DEBUG block so it will not be enabled to end users.

I see no problem with people who want to debug building their own
modified kernel with extra yt921x_smi_read() and yt921x_smi_write()
calls for the register of interest. That's pretty far from "anybody who
wants to debug has to have the sysfs".

