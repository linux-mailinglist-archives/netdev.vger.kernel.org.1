Return-Path: <netdev+bounces-222628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08390B551A3
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 16:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B25A17C2CE9
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 14:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4321732BF38;
	Fri, 12 Sep 2025 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lywUhWjw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FE532A82D
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757687319; cv=none; b=Cm/ZF7XuwYH4irCGnteqTRh5Sy5lpd9A+C+5wWKGA2Swd3MgbYDz83Qe/PhPz6M/BFMs3KQodRp/xHTNe4YKNQJyLT6hihcBJpF+mM63ZECc6qt0yqypFUXMXrciUDWBkc/poO3r9HHlAkKsDOKdZHP3ODw0D6Ohq6+u9sV+pRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757687319; c=relaxed/simple;
	bh=ln4LSDz4z0GBtHdfaQdU2oy01/F3Qmayqfdti+7xSBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ki4bwgBSWKc9cGVUlqLpD3Zfjc7k8VPOrd8kPLDyako5bweBkqI8swnEOYeSfDLoHsgOQAKpXWQZpP9UaugjrpknsvfwXHl7J9ZdlhKjPwaK75gcenCV/wdfowSD4EYK0OGsIwfkwIq67cXZx+ZtlnPTVMtLGDMBLjEDEhcS57s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lywUhWjw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2445824dc27so16910355ad.3
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 07:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757687316; x=1758292116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLUpR90LE58OzXIw+QX3bYrOA4Su+xcaS0EertGeCHk=;
        b=lywUhWjwlS570J5XTj017UAw+ZCrJ1DuYeAJxqjfffFLS0BEmcIIRyO67SnNk2NX8Z
         ooBRgP7H0x/86kyZRnez9Jg4+d+bCykyY8+0rPOHCXt1rEdqAeY6P96BPXDqk3gxK1id
         qxtCIgoLzOfQnp5qINFxsqESNxMyvIZsQ/fUB5br41thYYBOETsM6PnyDRcG/hKhp37O
         fCHvg5tGcs0wfHLjYpqwpD2zNUw/AYLTSLUDbL3mUaTYgQ+uqNO1qeGUWI/2h24CXiJ5
         qUSgwPxQnBlxGgFHNEuJBgXjfVsT3+zhdg0sU6y46LRIfbnzvrhzDqpKvJs2Bmvo8W0e
         9TeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757687316; x=1758292116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLUpR90LE58OzXIw+QX3bYrOA4Su+xcaS0EertGeCHk=;
        b=UDREuz6XrzN7pDfCK53wTuJXEn2jjG498b4J/TReLEsdDee7j4LsdP9NbNd9SqNkiB
         GDNqpufIoZr0D8cqzghQE67LAaG3LcGaMm1HM1eXw2VN+2a0aYjDJUeXtqaaAZkbGr0T
         qyi+o1KmbRVfI6sCoDPanr90H5GYH/K4Rgnja8wvrKbpbANJSoPwA/neD+75rxv/Iscf
         yM7UfsjWk110sfO6G0Smo3Xw7RQwi2TxMg8037+KQHMs9cDnfUG5rqSO17vw+oxWPmoH
         2utF1GcfhhreGAhau/aTlzicAHtadHUlrFPXGyJNkbMIA0hiD0zHmyy4hIg/iNRCs2Av
         P4YQ==
X-Gm-Message-State: AOJu0YzKdycZNPHtPlHpOt3AOnWqEle+A79G7zfzygUdnZV+X2+6yrK8
	R2uaWnaVv3N+E0nRtEit0iwlOzGjWJJ2h3iXSTTUywJlcoBCtdYpeWEgXxGJkfBc0d023mxIYAm
	3Dlh/K0jWrwOHOgDzLpLgN9T+0bgXuk0=
X-Gm-Gg: ASbGncsYJ7xAr2eq5jSXK6CGIqqxRPQwRSiKIiGzka+lKVP9PPwZ/vNQErIPwlcKkJs
	bjxKYGnyF2amSqjEwjirgPR1MLQtFDEkC1tls55zCa0VKDlwc5AFOobIee+mLe5eIyei+vqkovL
	m5+Pp8lDuRYMfIBJOomf8vN3tJs94/rc5RIWkwJX+sYNNNROFyzJ+IDsEapUUe6Tvk/mOO1fo4R
	LuKoKyRRX8kOLE2m11+/TnstOIwiEwc3OT3eMP+
X-Google-Smtp-Source: AGHT+IEcneNw16gbJJql70fTxorBqm72kbhal+B5SJ4p7LAMv7dgrrIOquxya5RkH6h/fyvtOefakEGfVGjkH3C6Rwc=
X-Received: by 2002:a17:902:ce89:b0:25c:5747:4491 with SMTP id
 d9443c01a7336-25d26c4ab81mr40310785ad.46.1757687315938; Fri, 12 Sep 2025
 07:28:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912024620.4032846-1-mmyangfl@gmail.com> <20250912024620.4032846-4-mmyangfl@gmail.com>
 <ae9f7bb0-aef3-4c53-91a3-6631fea6c734@lunn.ch>
In-Reply-To: <ae9f7bb0-aef3-4c53-91a3-6631fea6c734@lunn.ch>
From: Yangfl <mmyangfl@gmail.com>
Date: Fri, 12 Sep 2025 22:27:58 +0800
X-Gm-Features: Ac12FXx50TgVM93R2-OvnvYQQ_QMFrwWUgGE9FqVhKAwulOVqxoeDn2iCv7B0no
Message-ID: <CAAXyoMPLRHfSUGboC4SO+gBD0TdHq19fNs7AK3W2ZQnHT48gyA@mail.gmail.com>
Subject: Re: [PATCH net-next v8 3/3] net: dsa: yt921x: Add support for
 Motorcomm YT921x
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 8:56=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +static void yt921x_reg_mdio_verify(u32 reg, u16 val, bool lo)
> > +{
> > +     const char *desc;
> > +
> > +     switch (val) {
> > +     case 0xfade:
> > +             desc =3D "which is likely from a non-existent register";
> > +             break;
> > +     case 0xdead:
> > +             desc =3D "which is likely a data race condition";
> > +             break;
>
> Where did these two values come from? Are they documented in the datashee=
t?
>

I don't have the comprehensive datasheet and it (along with other
parts) is not mentioned in the documents I have, so I dug them out by
testing.

> > +     default:
> > +             return;
> > +     }
> > +
> > +     /* Skip registers which are likely to have any valid values */
> > +     switch (reg) {
> > +     case YT921X_MAC_ADDR_HI2:
> > +     case YT921X_MAC_ADDR_LO4:
> > +     case YT921X_FDB_OUT0:
> > +     case YT921X_FDB_OUT1:
> > +             return;
> > +     }
> > +
> > +     pr_warn("%s: Read 0x%x at 0x%x %s32, %s; "
> > +             "consider reporting a bug if this happens again\n",
> > +             __func__, val, reg, lo ? "lo" : "hi", desc);
>
> You probably have a warning from checkpatch about pr_warn. Ideally you
> want to give an indication which device has triggered this, making use
> of a struct device. You might want to include that in context.
>

I don't want to introduce priv struct layout into register
implementations, which makes unnecessary dependency between functions.
The warning will not appear if no bugs exist, and it can still be
easily identified by its function name.

> > +static int
> > +yt921x_intif_read(struct yt921x_priv *priv, int port, int reg, u16 *va=
lp)
> > +{
> > +     if ((u16)val !=3D val)
> > +             dev_err(dev,
> > +                     "%s: port %d, reg 0x%x: Expected u16, got 0x%08x\=
n",
> > +                     __func__, port, reg, val);
> > +     *valp =3D (u16)val;
> > +     return 0;
>
> You don't treat this as an error, you don't return -EIO or -EPROTO etc.
> So maybe this should be dev_info() or dev_dbg().
>
> > +static int
> > +yt921x_mbus_int_write(struct mii_bus *mbus, int port, int reg, u16 dat=
a)
> > +{
> > +     struct yt921x_priv *priv =3D mbus->priv;
> > +     int res;
> > +
> > +     if (port >=3D YT921X_PORT_NUM)
> > +             return 0;
>
> -ENODEV.
>

mdio-tools complains a lot when returning an error code. Also that is
what dsa_user_phy_write() returns for a non-existing port.

> > +yt921x_mbus_int_init(struct yt921x_priv *priv, struct device_node *mnp=
)
> > +{
> > +     struct device *dev =3D to_device(priv);
> > +     struct mii_bus *mbus;
> > +     int res;
> > +
> > +     if (!mnp)
> > +             res =3D devm_mdiobus_register(dev, mbus);
> > +     else
> > +             res =3D devm_of_mdiobus_register(dev, mbus, mnp);
>
> You can call devm_of_mdiobus_register() with a NULL pointer for the
> OF, and it will do the correct thing.
>
> > +static int yt921x_extif_wait(struct yt921x_priv *priv)
> > +{
> > +     u32 val;
> > +     int res;
> > +
> > +     res =3D yt921x_reg_read(priv, YT921X_EXT_MBUS_OP, &val);
> > +     if (res)
> > +             return res;
> > +     if ((val & YT921X_MBUS_OP_START) !=3D 0) {
> > +             res =3D read_poll_timeout(yt921x_reg_read, res,
> > +                                     (val & YT921X_MBUS_OP_START) =3D=
=3D 0,
> > +                                     YT921X_POLL_SLEEP_US,
> > +                                     YT921X_POLL_TIMEOUT_US,
> > +                                     true, priv, YT921X_EXT_MBUS_OP, &=
val);
> > +             if (res)
> > +                     return res;
> > +     }
> > +
> > +     return 0;
>
> In mv88e6xxx, we have the generic mv88e6xxx_wait_mask() and on top of
> that mv88e6xxx_wait_bit(). That allows us to have register specific
> wait functions as one liners. Please consider something similar.
>
> > +static int yt921x_mib_read(struct yt921x_priv *priv, int port, void *d=
ata)
> > +{
>
> As far as i can see, data is always a pointer to struct
> yt921x_mib_raw. I would be better to not have the void in the middle.
> It also makes it clearer what assumption you are making about the
> layout of that structure.
>
> > +     unsigned char *buf =3D data;
> > +     int res =3D 0;
> > +
> > +     for (size_t i =3D 0; i < sizeof(struct yt921x_mib_raw);
> > +          i +=3D sizeof(u32)) {
> > +             res =3D yt921x_reg_read(priv, YT921X_MIBn_DATA0(port) + i=
,
> > +                                   (u32 *)&buf[i]);
> > +             if (res)
> > +                     break;
> > +     }
> > +     return res;
> > +}
> > +
> > +static void yt921x_poll_mib(struct work_struct *work)
> > +{
> > +     struct yt921x_port *pp =3D container_of_const(work, struct yt921x=
_port,
> > +                                                 mib_read.work);
> > +     struct yt921x_priv *priv =3D (void *)(pp - pp->index) -
> > +                                offsetof(struct yt921x_priv, ports);
>
> Can you make container_of() work for this?
>

Impossible, also see ar9331_sw_port_to_priv().

> > +     unsigned long delay =3D YT921X_STATS_INTERVAL_JIFFIES;
> > +     struct device *dev =3D to_device(priv);
> > +     struct yt921x_mib *mib =3D &pp->mib;
> > +     struct yt921x_mib_raw raw;
> > +     int port =3D pp->index;
> > +     int res;
> > +
> > +     yt921x_reg_lock(priv);
> > +     res =3D yt921x_mib_read(priv, port, &raw);
> > +     yt921x_reg_unlock(priv);
> > +
> > +     if (res) {
> > +             dev_err(dev, "Failed to %s port %d: %i\n", "read stats fo=
r",
> > +                     port, res);
> > +             delay *=3D 4;
> > +             goto end;
> > +     }
> > +
> > +     spin_lock(&pp->stats_lock);
> > +
> > +     /* Handle overflow of 32bit MIBs */
> > +     for (size_t i =3D 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
> > +             const struct yt921x_mib_desc *desc =3D &yt921x_mib_descs[=
i];
> > +             u32 *rawp =3D (u32 *)((u8 *)&raw + desc->offset);
> > +             u64 *valp =3D &((u64 *)mib)[i];
> > +             u64 newval;
> > +
> > +             if (desc->size > 1) {
> > +                     newval =3D ((u64)rawp[0] << 32) | rawp[1];
> > +             } else {
> > +                     newval =3D (*valp & ~(u64)U32_MAX) | *rawp;
> > +                     if (*rawp < (u32)*valp)
> > +                             newval +=3D (u64)1 << 32;
> > +             }
>
> There are way too many casts here. Think about your types, and how you
> can remove some of these casts. In general, casts are bad, and should
> be avoided where possible.
>

Some casts are necessary for shifting operations, otherwise an error
will pop out for shift overflow.

Others are just synonyms of val & 0xffffffff. I'd consider casts are
neater than magic numbers.

> > +static void
> > +yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t=
 *data)
> > +{
> > +     struct yt921x_priv *priv =3D to_yt921x_priv(ds);
> > +     struct yt921x_port *pp =3D &priv->ports[port];
> > +     struct yt921x_mib *mib =3D &pp->mib;
> > +     size_t j;
> > +
> > +     spin_lock(&pp->stats_lock);
> > +
> > +     j =3D 0;
> > +     for (size_t i =3D 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
> > +             const struct yt921x_mib_desc *desc =3D &yt921x_mib_descs[=
i];
> > +
> > +             if (!desc->unstructured)
> > +                     continue;
> > +
> > +             data[j] =3D ((u64 *)mib)[i];
> > +             j++;
> > +     }
> >
>
> ethtool APIs are called in a context where you can block. So it would
> be good to updated the statistics first before copying them. You just
> need to think about your locking in case the worker is running.
>
> > +static int yt921x_dsa_get_sset_count(struct dsa_switch *ds, int port, =
int sset)
> > +{
> > +     int cnt;
> > +
> > +     if (sset !=3D ETH_SS_STATS)
> > +             return 0;
> > +
> > +     cnt =3D 0;
>
> Please do the zeroing above when you declare the local variable.
>
> > +     for (size_t i =3D 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
> > +             const struct yt921x_mib_desc *desc =3D &yt921x_mib_descs[=
i];
> > +
> > +             if (desc->unstructured)
> > +                     cnt++;
> > +     }
> > +
> > +     return cnt;
> > +}
>
> > +static int
> > +yt921x_set_eee(struct yt921x_priv *priv, int port, struct ethtool_keee=
 *e)
> > +{
>
> > +     /* Enable / disable port EEE */
> > +     res =3D yt921x_reg_toggle_bits(priv, YT921X_EEE_CTRL,
> > +                                  YT921X_EEE_CTRL_ENn(port), enable);
> > +     if (res)
> > +             return res;
> > +     res =3D yt921x_reg_toggle_bits(priv, YT921X_EEEn_VAL(port),
> > +                                  YT921X_EEE_VAL_DATA, enable);
>
> How do these two different registers differ? Why are there two of
> them? Maybe add a comment to explain this.
>

Datasheet gives no explanation here too, so this is a carbon copy of the sa=
mple
code. I'm also confused too.

> > +static bool yt921x_dsa_support_eee(struct dsa_switch *ds, int port)
> > +{
> > +     struct yt921x_priv *priv =3D to_yt921x_priv(ds);
> > +
> > +     return (priv->pon_strap_cap & YT921X_PON_STRAP_EEE) !=3D 0;
>
> What does the strapping actually tell you?
>

Whether EEE capability is present.

> > +static int
> > +yt921x_dsa_port_mirror_add(struct dsa_switch *ds, int port,
> > +                        struct dsa_mall_mirror_tc_entry *mirror,
> > +                        bool ingress, struct netlink_ext_ack *extack)
> > +{
> > +     struct yt921x_priv *priv =3D to_yt921x_priv(ds);
> > +     u32 ctrl;
> > +     u32 val;
> > +     int res;
> > +
> > +     yt921x_reg_lock(priv);
> > +     do {
> > +             u32 srcs;
> > +             u32 dst;
> > +
> > +             if (ingress)
> > +                     srcs =3D YT921X_MIRROR_IGR_PORTn(port);
> > +             else
> > +                     srcs =3D YT921X_MIRROR_EGR_PORTn(port);
> > +             dst =3D YT921X_MIRROR_PORT(mirror->to_local_port);
> > +
> > +             res =3D yt921x_reg_read(priv, YT921X_MIRROR, &val);
> > +             if (res)
> > +                     break;
> > +
> > +             /* other mirror tasks & different dst port -> conflict */
> > +             if ((val & ~srcs & (YT921X_MIRROR_EGR_PORTS_M |
> > +                                 YT921X_MIRROR_IGR_PORTS_M)) !=3D 0 &&
> > +                 (val & YT921X_MIRROR_PORT_M) !=3D dst) {
> > +                     NL_SET_ERR_MSG_MOD(extack,
> > +                                        "Sniffer port is already confi=
gured,"
> > +                                        " delete existing rules & retr=
y");
> > +                     res =3D -EBUSY;
> > +                     break;
> > +             }
> > +
> > +             ctrl =3D val & ~YT921X_MIRROR_PORT_M;
> > +             ctrl |=3D srcs;
> > +             ctrl |=3D dst;
> > +
> > +             if (ctrl !=3D val)
> > +                     res =3D yt921x_reg_write(priv, YT921X_MIRROR, ctr=
l);
> > +     } while (0);
>
> What does a while (0) loop bring you here?
>

break statement instead of goto err.

>
>     Andrew
>
> ---
> pw-bot: cr

