Return-Path: <netdev+bounces-151577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 538329F00D0
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 01:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842B9188A837
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 00:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBA7383;
	Fri, 13 Dec 2024 00:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="PiQE1S2O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FF410F7
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 00:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734049963; cv=none; b=SG46Nw5BllJz+uGckV2vhN+JWN3QFT3+IMDhWeopghnJtN02qP/Jm43qJ3JfYDcS6JiYqQp2w5lNQCjMeNtJfvPWbNzcLSr6astFDe5NzKhJPOzkZ9NoNaybBBA1FadFv9GVFBWvJy4AU0Senx7/lNeenTzNJ2NKF1uub3nOdWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734049963; c=relaxed/simple;
	bh=UGBSLmiHtdHlQW61iJdVtiJgYeOeFZv7Sjbh/KXxNlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Er3lm7fA+c5BVsQvX/hAUmMEHN+bS814mNGNhTFRiN7haag2eWC7vvPgpUfGJKLJQdICeT9N4F+zF+3CCDjVJk6iWBEXkdtBp6Oy7NX/CMbuhckvNu0uIRPcr9M5ffjdZ8j4eloFuR311HwGgpKVVtSwWDNZjvtowMloAmyuwRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=PiQE1S2O; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e3988fdb580so935123276.2
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 16:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1734049960; x=1734654760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1xqVE/4FZUuHPUklFrnCBLjAYIJGtDzqs84F5snF0k=;
        b=PiQE1S2O3/RAiIaSJjDWrOGzVTn+UqVFLNwkn9kAEJCnjaOevvOPI+NizozU3lSrwG
         zcimLFigDDlujgmQqa2tTugFHlJZpJI2p9mOao5JgMInI0FKXbGmLE7qu/3tUW9jDI2o
         J/d9MTnc6j+dwBLVgQcdJHTqq0aJhnyP+pAa5kwNNzAShmMgXiIiIi3Pp/tekzL4bp6P
         H8bCM6zPMbFVEuqTLIfDlHVgODnQCcdxAWrKSs/7JnRGn1pmU6lxw9Ka9cXxpuSeVrCH
         Kqp+VwxZlZ/SeTIPPe4n3nnmkXJ5Mk1/YfZ3upfvCE77Y9g6u5nATgf3A2/S+sbEWnm5
         1kdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734049960; x=1734654760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1xqVE/4FZUuHPUklFrnCBLjAYIJGtDzqs84F5snF0k=;
        b=ohKlSs9/HLM1t7mv9sS1pHIBHzMVkQ4B8Wqw69TaUIHGSONwXgi4HKcI3A0vYoDkeE
         cHrZlGohlpq7ejeEBZw3nOjVx/NuXA9cBU6TWGfEL5XBkGoOjdRkT2G3GpEBWsiFKhiH
         zYsOp/f53G2TMY7k92b75HEzVzOB8QuE8Sdz0eF4AmTeVp+aCBYVMMCJSKtHhGQkl6yG
         CzhrW5WNUiIF3nVEMfOlye0Hum12eC278h25XUPYb2bAh4SL4UE8PKkGK009HDamQntb
         O9SJlM/2sGNAgWC2vGOKNdR4nvr/7vOf7iBAkrKwpDVwh5/E+SbHVeJ9wciPmqrH35lp
         QlNw==
X-Forwarded-Encrypted: i=1; AJvYcCVwJoE9/z/Ry6j7pyM0+uByZafGT4TXNf+jkvWL6f/8ifU8sYA52hV3PLxwu1jpyKHlPBlxiGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkiUc/j/7R3NolNFJYOpUrAwJ9kZtSP6i7bbdCIBfbNC083cEL
	KofTgmazj9TKn9qi/vMpE+jZALcHLON30ZIaB4GJu6TzZ11csJhUINjlZ7E3pS9MJHPGJgGBZ07
	VNphe9n+0yeOILP1JSQiCvUhUO/76ydXc2qqRrw==
X-Gm-Gg: ASbGncshdhYqWmOWRdsFyE+gBDm8CroioycWi/d2riOt3ESPHi1RDZCKBhX9pvahVs3
	Swtkix/DKNDu2JTEEIPED+rpCMv6XNz9t5wdRJQ==
X-Google-Smtp-Source: AGHT+IF39f2BqM4YRqvWo4v8Shf3KrfB3H9aJWunSkI4rryXWHgKAdGM2jLC0uDz1OQ/vECYe+aqEg9DoP8ztBEjoiE=
X-Received: by 2002:a05:6902:1893:b0:e30:cd96:4001 with SMTP id
 3f1490d57ef6-e434d19a0e6mr545000276.7.1734049960053; Thu, 12 Dec 2024
 16:32:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212215132.3111392-1-tharvey@gateworks.com> <20241213000023.jkrxbogcws4azh4w@skbuf>
In-Reply-To: <20241213000023.jkrxbogcws4azh4w@skbuf>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 12 Dec 2024 16:32:28 -0800
Message-ID: <CAJ+vNU2WQ2n588vOcofJ5Ga76hsyff51EW-e6T8PbYFY_4xu0A@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: microchip: ksz9477: fix multicast filtering
To: Vladimir Oltean <olteanv@gmail.com>, Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
	Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 4:00=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> On Thu, Dec 12, 2024 at 01:51:32PM -0800, Tim Harvey wrote:
> > commit 331d64f752bb ("net: dsa: microchip: add the enable_stp_addr
> > pointer in ksz_dev_ops") introduced enabling of the reserved multicast
> > address table function to filter packets based on multicast MAC address
> > but only configured one MAC address group, group 0 for
> > (01-80-C2-00)-00-00 for bridge group data.
> >
> > This causes other multicast groups to fail to be received such as LLDP
> > which uses a MAC address of 01-80-c2-00-00-0e (group 6).
> >
> > Enabling the reserved multicast address table requires configuring the
> > port forward mask for all eight address groups as the mask depends on
> > the port configuration.
>

Hi Vladimir,

> Personal experience reading your commit message: it took me a long while
> to realize that the reason why the 8 pre-configured Reserved Multicast
> table entries don't work is written here: "the mask depends on the port
> configuration." It is absolutely understated IMO.
>

Yes, if you are going to enable the reserved multicast address table
it should be configured fully as the default configuration makes an
assumption on what user/host ports are valid.

> > The table determines the forwarding ports for
> > 48 specific multicast addresses and is addressed by the least
> > significant 6 bits of the multicast address. Changing a forwarding
> > port mask for one address also makes the same change for all other
> > addresses in the same group.
> >
> > Add configuration of the groups as such:
> >  - leave these as default:
> >    group 1 (01-80-C2-00)-00-01 (MAC Control Frame) (drop)
> >    group 3 (01-80-C2-00)-00-10) (Bridge Management) (all ports)
> >  - forward to cpu port:
> >    group 0 (01-80-C2-00)-00-00 (Bridge Group Data)
> >    group 2 (01-80-C2-00)-00-03 (802.1X access control)
> >    group 6 (01-80-C2-00)-00-02, (01-80-C2-00)-00-04 =E2=80=93 (01-80-C2=
-00)-00-0F
> >  - forward to all but cpu port:
>
> Why would you not forward packets to the CPU port as a hardcoded configur=
ation?
> What if the KSZ ports are bridged together with a foreign interface
> (different NIC, WLAN, tunnel etc), how should the packets reach that?
>

If that is the correct thing to do I can certainly do that. I was
assuming that the default policy above must be somewhat standard. This
patch leaves the policy that was created by the default table
configuration and just updates the port configuration based on the dt
definition of the user vs host ports.

> >    group 4 (01-80-C2-00)-00-20 (GMRP)
> >    group 5 (01-80-C2-00)-00-21 (GVRP)
> >    group 7 (01-80-C2-00)-00-11 - (01-80-C2-00)-00-1F,
> >            (01-80-C2-00)-00-22 - (01-80-C2-00)-00-2F
>
> Don't you want to forgo the (odd) hardware defaults for the Reserved Mult=
icast
> table, and instead follow what the Linux bridge does in br_handle_frame()=
?
> Which is to trap all is_link_local_ether_addr() addresses to the CPU, do
> _not_ call dsa_default_offload_fwd_mark() for those packets (aka let the
> bridge know that they haven't been forwarded in hardware, and if they
> should reach other bridge ports, this must be done in software), and let =
the
> user choose, via the bridge group_fwd_mask, if they should be forwarded
> to other bridge ports or not?

Again, I really don't know what the 'right' thing to do is for
multicast packets but the enabling of the reserved multicast table
done in commit 331d64f752bb ("net: dsa: microchip: add the
enable_stp_addr pointer in ksz_dev_ops") breaks forwarding of all
multicast packets that are not sent to 01-80-C2-00-00-00

> >
> > Datasheets:
> > [1] https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ9897S-Data-Shee=
t-DS00002394C.pdf
> > [2] https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ9896C-Data-Shee=
t-DS00002390C.pdf
> > [3] https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ9893R-Data-Shee=
t-DS00002420D.pdf
> > [4] https://ww1.microchip.com/downloads/en/DeviceDoc/00002330B.pdf
> > [5] https://ww1.microchip.com/downloads/en/DeviceDoc/KSZ9563R-Data-Shee=
t-DS00002419D.pdf
> > [6] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/Prod=
uctDocuments/DataSheets/KSZ9567R-Data-Sheet-DS00002329.pdf
> > [7] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/Prod=
uctDocuments/DataSheets/KSZ9567R-Data-Sheet-DS00002329.pdf
>
> [6] and [7] are the same.
>
> Also, you'd better specify in the commit message what's with these datash=
eet
> links, which to me and I suppose all other non-expert readers, are pasted=
 here
> out of the blue, with no context.
>
> Like for example: "KSZ9897, ..., have arbitrary CPU port assignments, as
> can be seen in the driver's ksz_chip_data :: cpu_ports entries for these
> families, and the CPU port selection on a certain board rarely coincides
> with the default host port selection in the Reserved Multicast address
> table".

I was just trying to be thorough. I took the time to look up the
datasheets for all the switches that the ksz9447 driver supports to
ensure they all had the same default configuration policy and same
configuration method/registers so I thought I would include them in
the message. I can drop the datasheet links if they add no value. I
was also expecting perhaps the commit message was confusing so I
wanted to show where the information came from.

What you're suggesting above regarding trapping all
is_link_local_ether_addr() addresses to the CPU and not calling
dsa_default_offload_fwd_mark() is beyond my understanding. If the
behavior of the reserved multicast address table is non-standard then
it should be disabled and the content of ksz9477_enable_stp_addr()
removed. However based on Arun's commit message it seems that prior to
that patch STP BPDU packets were not being forwarded to the CPU so
it's unclear to me what the default behavior was for multicast without
the reserved muticast address table being enabled. I know that if the
table is disabled by removing the call to ksz9477_enable_stp_addr then
LLDP packets are forwarded to the cpu port like they were before that
patch.

All of your coding style comments below make complete sense to me so
as soon as we figure out what the proper fix is for commit
331d64f752bb ("net: dsa: microchip: add the enable_stp_addr pointer in
ksz_dev_ops") breaking multicast I can resubmit with those resolved.

Best Regards,

Tim

>
> >
> > Fixes: 331d64f752bb ("net: dsa: microchip: add the enable_stp_addr poin=
ter in ksz_dev_ops")
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> >  drivers/net/dsa/microchip/ksz9477.c | 84 +++++++++++++++++++++++++----
> >  1 file changed, 75 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/micr=
ochip/ksz9477.c
> > index d16817e0476f..d8fe809dd461 100644
> > --- a/drivers/net/dsa/microchip/ksz9477.c
> > +++ b/drivers/net/dsa/microchip/ksz9477.c
> > @@ -1138,25 +1138,24 @@ void ksz9477_config_cpu_port(struct dsa_switch =
*ds)
> >       }
> >  }
> >
> > -int ksz9477_enable_stp_addr(struct ksz_device *dev)
> > +static int ksz9477_reserved_muticast_group(struct ksz_device *dev, int=
 index, int mask)
> >  {
> > +     const u8 *shifts;
> >       const u32 *masks;
> >       u32 data;
> >       int ret;
> >
> > +     shifts =3D dev->info->shifts;
> >       masks =3D dev->info->masks;
> >
> > -     /* Enable Reserved multicast table */
> > -     ksz_cfg(dev, REG_SW_LUE_CTRL_0, SW_RESV_MCAST_ENABLE, true);
> > -
> > -     /* Set the Override bit for forwarding BPDU packet to CPU */
> > -     ret =3D ksz_write32(dev, REG_SW_ALU_VAL_B,
> > -                       ALU_V_OVERRIDE | BIT(dev->cpu_port));
> > +     /* write the PORT_FORWARD value to the Reserved Multicast Address=
 Table Entry 2 Register */
>
> In netdev the coding style limits the line length to 80 characters where
> that is easy, like here.
>
> > +     ret =3D ksz_write32(dev, REG_SW_ALU_VAL_B, mask);
> >       if (ret < 0)
> >               return ret;
> >
> > -     data =3D ALU_STAT_START | ALU_RESV_MCAST_ADDR | masks[ALU_STAT_WR=
ITE];
> > -
> > +     /* write to the Static Address and Reserved Multicast Table Contr=
ol Register */
> > +     data =3D (index << shifts[ALU_STAT_INDEX]) |
> > +             ALU_STAT_START | ALU_RESV_MCAST_ADDR | masks[ALU_STAT_WRI=
TE];
> >       ret =3D ksz_write32(dev, REG_SW_ALU_STAT_CTRL__4, data);
> >       if (ret < 0)
> >               return ret;
> > @@ -1167,8 +1166,75 @@ int ksz9477_enable_stp_addr(struct ksz_device *d=
ev)
> >               dev_err(dev->dev, "Failed to update Reserved Multicast ta=
ble\n");
> >               return ret;
> >       }
> > +     return ksz9477_wait_alu_sta_ready(dev);
> > +}
> > +
> > +int ksz9477_enable_stp_addr(struct ksz_device *dev)
> > +{
> > +     int ret;
> > +     int cpu_mask =3D dsa_cpu_ports(dev->ds);
> > +     int user_mask =3D dsa_user_ports(dev->ds);
>
> Also, in netdev, the coding style is to sort lines with variable
> declarations in the reverse order of their length (so-called reverse
> Christmas tree).
>
> > +     /* array of indexes into table:
> > +      * The table is indexed by the low 6 bits of the MAC address.
> > +      * Changing the PORT_FORWARD value for any single address affects
> > +      * all others in group
> > +      */
> > +     u16 addr_groups[8] =3D {
>
> Array can be static const. Also, since all elements are initialized,
> specifying its size explicitly is not necessary ("[8]" can be "[]").
>
> > +             /* group 0: (01-80-C2-00)-00-00 (Bridge Group Data) */
> > +             0x000,
> > +             /* group 1: (01-80-C2-00)-00-01 (MAC Control Frame) */
> > +             0x001,
> > +             /* group 2: (01-80-C2-00)-00-03 (802.1X access control) *=
/
> > +             0x003,
> > +             /* group 3: (01-80-C2-00)-00-10) (Bridge Management) */
> > +             0x010,
> > +             /* group 4: (01-80-C2-00)-00-20 (GMRP) */
> > +             0x020,
> > +             /* group 5: (01-80-C2-00)-00-21 (GVRP) */
> > +             0x021,
> > +             /* group 6: (01-80-C2-00)-00-02, (01-80-C2-00)-00-04 =E2=
=80=93 (01-80-C2-00)-00-0F */
> > +             0x002,
> > +             /* group 7: (01-80-C2-00)-00-11 - (01-80-C2-00)-00-1F,
> > +              *          (01-80-C2-00)-00-22 - (01-80-C2-00)-00-2F
> > +              */
> > +             0x011,
> > +     };
> > +
> > +     /* Enable Reserved multicast table */
> > +     ksz_cfg(dev, REG_SW_LUE_CTRL_0, SW_RESV_MCAST_ENABLE, true);
> > +
> > +     /* update reserved multicast address table:
> > +      * leave as default:
> > +      *  - group 1 (01-80-C2-00)-00-01 (MAC Control Frame) (drop)
> > +      *  - group 3 (01-80-C2-00)-00-10) (Bridge Management) (all ports=
)
> > +      * forward to cpu port:
> > +      *  - group 0 (01-80-C2-00)-00-00 (Bridge Group Data)
> > +      *  - group 2 (01-80-C2-00)-00-03 (802.1X access control)
> > +      *  - group 6 (01-80-C2-00)-00-02, (01-80-C2-00)-00-04 =E2=80=93 =
(01-80-C2-00)-00-0F
> > +      * forward to all but cpu port:
> > +      *  - group 4 (01-80-C2-00)-00-20 (GMRP)
> > +      *  - group 5 (01-80-C2-00)-00-21 (GVRP)
> > +      *  - group 7 (01-80-C2-00)-00-11 - (01-80-C2-00)-00-1F,
> > +      *            (01-80-C2-00)-00-22 - (01-80-C2-00)-00-2F
> > +      */
> > +     if (ksz9477_reserved_muticast_group(dev, addr_groups[0], cpu_mask=
))
> > +             goto exit;
>
> err =3D (function return code), and print it with %pe, ERR_PTR(err) pleas=
e.
> We want to distinguish between -ETIMEDOUT in ksz9477_wait_alu_sta_ready()
> vs whatever ksz_write32() may return.
>
> > +     if (ksz9477_reserved_muticast_group(dev, addr_groups[2], cpu_mask=
))
> > +             goto exit;
> > +     if (ksz9477_reserved_muticast_group(dev, addr_groups[6], cpu_mask=
))
> > +             goto exit;
> > +     if (ksz9477_reserved_muticast_group(dev, addr_groups[4], user_mas=
k))
> > +             goto exit;
> > +     if (ksz9477_reserved_muticast_group(dev, addr_groups[5], user_mas=
k))
> > +             goto exit;
> > +     if (ksz9477_reserved_muticast_group(dev, addr_groups[7], user_mas=
k))
> > +             goto exit;
> >
> >       return 0;
> > +
> > +exit:
> > +     dev_err(dev->dev, "Failed to update Reserved Multicast table\n");
> > +     return ret;
> >  }
> >
> >  int ksz9477_setup(struct dsa_switch *ds)
> > --
> > 2.34.1
> >
>

