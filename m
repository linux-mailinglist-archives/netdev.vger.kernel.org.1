Return-Path: <netdev+bounces-216794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8A6B35338
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 07:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38DAD1B27DCE
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 05:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A1F2EAB6D;
	Tue, 26 Aug 2025 05:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhytJEQd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A9923FC66;
	Tue, 26 Aug 2025 05:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756185639; cv=none; b=gDQXMF/b0DfM8Yqe21f0iXJoaKqYNkzjTNsJC9BoGwaP5XSqIbFjrRrs/y17psaH5YZWCP5lGzOM+s3MLyMbKKMBLRZAamVUTqDEIij8L6ZoUkhtw6eByl4QTgc+VXoexL+mIm/hD2jBQIPcBgqLlkUHh8ukpbtcx/9c/vnkSpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756185639; c=relaxed/simple;
	bh=9kLJ1DDhm/UJgf9CsejDm19+N2oga2HlgeEWeMCBeCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0RchBke85eWeBRpJEAhePwgskZOa3emIer/Gwz0H+rH0edkUfr83ReqqQPw9eteYRrt7gTO7eBF33m6uokfMSOqZUfqieI6s7+0ZrQ2kdcGPG/l2pHqdHrgDL2qFN70+OlszpU42zPNe5Ib4k8bYfH5C7GXN0LcDBpob8dSQo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhytJEQd; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e39ec6f30so4951128b3a.2;
        Mon, 25 Aug 2025 22:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756185636; x=1756790436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QutLUrnGSwAF469nH73xZsTEKdihcwPCN+fRapP9Sh4=;
        b=AhytJEQdMxIj9RyaxntryIEDDloMfZ1P3IujaPj+sMV4QvL3fmc6gmYHvlIm/P3zeq
         JBEv2Y0m9T/oeee+hSyZAO5hpg7lh9dy1E2Z77gGzZJalefYy0TT7m1qF6zgKSo4Tnwl
         sLxaKbFkxkckNfw9mGTKbIuyUy58xbq1X0NzaFXaiogZ15BMLzQJ5DrQWMYSH8RC3rD7
         gABTObsnGGLsd3g2MWHyJvmedsVn3dUvMxXguBOmur42di6hSjLEcIa1FRJntGVhs4U3
         46+jgJ8QEVagks/F/5T6LHKsxfg/sbbXgSdmJf3UMK/b4CRYh4JOfpb2mlXNzo2clp34
         qMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756185636; x=1756790436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QutLUrnGSwAF469nH73xZsTEKdihcwPCN+fRapP9Sh4=;
        b=tMD6JwPOh8mYmv3FOcEPt4+idGEIfaNYoV6rGLAyq36lMP4NQN7MQc2a8AapTQsB/i
         N0eGgpFMBbAskjvySan96lHi0y7M9tLOyQBfxB86nDErz7li8TjUgfygHwiLmDogBCqa
         /rK1tq//VIjxfGysHuEcSDjcFOAdkYGlb0UdvoO4Fht6wRU7pfhHdi5d7tffHhSc8LiX
         5KK6agcOUpFjwwPOThlwvlHO0LNhxmLURENnlxNV4sLAtkOgdMtFlA/aoMa7136lKcfB
         txnWqon/TTb4tPR89tQYP1ZcX5VGMGCMPEX/8yyuySABKnYMFaQdJ2nSRsLjMIayI8TP
         aKjA==
X-Forwarded-Encrypted: i=1; AJvYcCVXKAXbfsZo71sYM54oL5Hbm01MLHrphwLUn3culDREeK9gr1Q0w4y23c9E8FH/W7JNh3d1qsBhtmEb@vger.kernel.org, AJvYcCWQDBp+uvqd4CEZro0BpEUKttupd8Rd0snxlOxtaH/5Fe2m8Bxqvy/Qff0HdhVB6eS3QHV0x/52hwhHxnoV@vger.kernel.org
X-Gm-Message-State: AOJu0YxhKGVPjXW2QVkA8dC7neuxBwCxeSSMZeN+gR9dD/JsHtsCikw0
	FFcm16DDAuNSmCLrzHVrb2tkCnNnLYlSZqMFQIg5GT+lX8+44og3EwMEMmfPLz0tp+SFcbH4I5E
	pI7f0RSa2Tp+MPq1FxFB/OYRNE/usJkU=
X-Gm-Gg: ASbGncvzQYudXXgSb7dm9aYa1eq847SUQaAhP59BIWYvGTCxCvKxlF1Oyd49xABvc43
	xIbj/yfDY11HjdrySuDPdAfY3Rz3FotSKuszFNg3H/fHcfDTFoJ75huKbT/1fKFyMyIKKN6q6m6
	60HGROSM3Odt2X2gHgkrgtYPDjJ8wbCPmG0EeI8TogXF0GAHBh34/G6X5XUIdug+khCwVHE/iOq
	VvSVntvTQ==
X-Google-Smtp-Source: AGHT+IHv4EDr3Lw63wXuyFGzSBfzt0IfCEdEhKRwOlFTGiAixdOjYgYcMobYtcdaAt2/irOekbdxXsrjxa41/x/7bXU=
X-Received: by 2002:a05:6a20:5493:b0:21e:eb3a:dc04 with SMTP id
 adf61e73a8af0-24340bd0f21mr20918469637.3.1756185635134; Mon, 25 Aug 2025
 22:20:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250824005116.2434998-1-mmyangfl@gmail.com> <20250824005116.2434998-4-mmyangfl@gmail.com>
 <20250825212357.3acgen2qezuy533y@skbuf>
In-Reply-To: <20250825212357.3acgen2qezuy533y@skbuf>
From: Yangfl <mmyangfl@gmail.com>
Date: Tue, 26 Aug 2025 13:19:58 +0800
X-Gm-Features: Ac12FXw5AASl7K2HXzDHUbfIYEeJEK_zsEVQZhnBzMKqeH6QQ9dgKy0nIThFoYw
Message-ID: <CAAXyoMOVY7EvY9CtAphWcZrfNpz+JuUXcTf3M79FSYkbLSTvhg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 3/3] net: dsa: yt921x: Add support for
 Motorcomm YT921x
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 5:24=E2=80=AFAM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> Hi David,
>
> On Sun, Aug 24, 2025 at 08:51:11AM +0800, David Yang wrote:
> > +enum yt921x_fdb_entry_status {
> > +     YT921X_FDB_ENTRY_STATUS_INVALID =3D 0,
> > +     YT921X_FDB_ENTRY_STATUS_MIN_TIME =3D 1,
> > +     YT921X_FDB_ENTRY_STATUS_MOVE_AGING_MAX_TIME =3D 3,
> > +     YT921X_FDB_ENTRY_STATUS_MAX_TIME =3D 5,
> > +     YT921X_FDB_ENTRY_STATUS_PENDING =3D 6,
> > +     YT921X_FDB_ENTRY_STATUS_STATIC =3D 7,
> > +};
> > +
> > +#define YT921X_PVID_DEFAULT          1
>
> If you have a VLAN-unaware bridge with learning enabled, this will
> learn MAC addresses in VID 1. If you also have a VLAN-aware bridge with
> default_pvid 1 on a different port group, this will also learn MAC
> addresses in VID 1.
>

I could set PVID to 0, but I checked my mv88e6352 device and it learns
MAC addresses in VID 4095 when egress is untagged, so I might place a
PVID here anyway.

> Are the two FDB databases isolated, or if two stations with the same MAC
> address are present in both bridges, will the switch attempt to forward
> packets from one bridge to another (leading to packet drops)?
> This can happen, for example, with the MAC addresses of user ports,
> which all inherit the conduit's MAC address when there is no address
> specified in the device tree.
>

FDB isolation is not supported, but port isolation is enforced here.

> There is an even simpler variant of this, which is a standalone port A
> and a VLAN-aware bridge port B. Port A won't have learning enabled, but
> it will still try to forward packets to known destinations, which may
> well be towards port B. The latter situation is very commonly seen in
> the tools/testing/selftests/drivers/net/dsa/ suite, where there are
> cables in loopback between switch ports. See
> tools/testing/selftests/net/forwarding/README for the topology.
>
> Have you ever run the DSA selftests for this new driver? Please include
> test results in the new patch submission, so we can take a look at what
> doesn't pass, and see where we should concentrate our attention.
>
> > +
> > +#define YT921X_FRAME_SIZE_MAX                0x2400  /* 9216 */
> > +
> > +#define YT921X_RST_DELAY_US          10000
> > +
> > +struct yt921x_mib_desc {
> > +     unsigned int size;
> > +     unsigned int offset;
> > +     const char *name;
> > +};
> > +
> > +#define MIB_DESC(_size, _offset, _name) {_size, _offset, _name}
> > +
> > +static const struct yt921x_mib_desc yt921x_mib_descs[] =3D {
> > +     MIB_DESC(1, 0x00, "RxBroadcast"),       /* rx broadcast pkts */
> > +     MIB_DESC(1, 0x04, "RxPause"),           /* rx pause pkts */
> > +     MIB_DESC(1, 0x08, "RxMulticast"),       /* rx multicast pkts, exc=
luding pause and OAM */
> > +     MIB_DESC(1, 0x0c, "RxCrcErr"),          /* rx crc err pkts, len >=
=3D 64B */
> > +
> > +     MIB_DESC(1, 0x10, "RxAlignErr"),        /* rx pkts with odd numbe=
r of bytes */
> > +     MIB_DESC(1, 0x14, "RxUnderSizeErr"),    /* rx crc ok pkts, len < =
64B */
> > +     MIB_DESC(1, 0x18, "RxFragErr"),         /* rx crc err pkts, len <=
 64B */
> > +     MIB_DESC(1, 0x1c, "RxPktSz64"),         /* rx pkts, len =3D=3D 64=
B */
> > +
> > +     MIB_DESC(1, 0x20, "RxPktSz65To127"),    /* rx pkts, len >=3D 65B =
and <=3D 127B */
> > +     MIB_DESC(1, 0x24, "RxPktSz128To255"),   /* rx pkts, len >=3D 128B=
 and <=3D 255B */
> > +     MIB_DESC(1, 0x28, "RxPktSz256To511"),   /* rx pkts, len >=3D 256B=
 and <=3D 511B */
> > +     MIB_DESC(1, 0x2c, "RxPktSz512To1023"),  /* rx pkts, len >=3D 512B=
 and <=3D 1023B */
> > +
> > +     MIB_DESC(1, 0x30, "RxPktSz1024To1518"), /* rx pkts, len >=3D 1024=
B and <=3D 1518B */
> > +     MIB_DESC(1, 0x34, "RxPktSz1519ToMax"),  /* rx pkts, len >=3D 1519=
B */
> > +     MIB_DESC(2, 0x38, "RxGoodBytes"),       /* total bytes of rx ok p=
kts */
> > +     /* 0x3c */
> > +
> > +     MIB_DESC(2, 0x40, "RxBadBytes"),        /* total bytes of rx err =
pkts */
> > +     /* 0x44 */
> > +     MIB_DESC(2, 0x48, "RxOverSzErr"),       /* rx pkts, len > mac fra=
me size */
> > +     /* 0x4c */
> > +
> > +     MIB_DESC(1, 0x50, "RxDropped"),         /* rx dropped pkts, exclu=
ding crc err and pause */
> > +     MIB_DESC(1, 0x54, "TxBroadcast"),       /* tx broadcast pkts */
> > +     MIB_DESC(1, 0x58, "TxPause"),           /* tx pause pkts */
> > +     MIB_DESC(1, 0x5c, "TxMulticast"),       /* tx multicast pkts, exc=
luding pause and OAM */
> > +
> > +     MIB_DESC(1, 0x60, "TxUnderSizeErr"),    /* tx pkts, len < 64B */
> > +     MIB_DESC(1, 0x64, "TxPktSz64"),         /* tx pkts, len =3D=3D 64=
B */
> > +     MIB_DESC(1, 0x68, "TxPktSz65To127"),    /* tx pkts, len >=3D 65B =
and <=3D 127B */
> > +     MIB_DESC(1, 0x6c, "TxPktSz128To255"),   /* tx pkts, len >=3D 128B=
 and <=3D 255B */
> > +
> > +     MIB_DESC(1, 0x70, "TxPktSz256To511"),   /* tx pkts, len >=3D 256B=
 and <=3D 511B */
> > +     MIB_DESC(1, 0x74, "TxPktSz512To1023"),  /* tx pkts, len >=3D 512B=
 and <=3D 1023B */
> > +     MIB_DESC(1, 0x78, "TxPktSz1024To1518"), /* tx pkts, len >=3D 1024=
B and <=3D 1518B */
> > +     MIB_DESC(1, 0x7c, "TxPktSz1519ToMax"),  /* tx pkts, len >=3D 1519=
B */
> > +
> > +     MIB_DESC(2, 0x80, "TxGoodBytes"),       /* total bytes of tx ok p=
kts */
> > +     /* 0x84 */
> > +     MIB_DESC(2, 0x88, "TxCollision"),       /* collisions before 64B =
*/
> > +     /* 0x8c */
> > +
> > +     MIB_DESC(1, 0x90, "TxExcessiveCollistion"),     /* aborted pkts d=
ue to too many colls */
> > +     MIB_DESC(1, 0x94, "TxMultipleCollision"),       /* multiple colli=
sion for one mac */
> > +     MIB_DESC(1, 0x98, "TxSingleCollision"), /* one collision for one =
mac */
> > +     MIB_DESC(1, 0x9c, "TxPkt"),             /* tx ok pkts */
> > +
> > +     MIB_DESC(1, 0xa0, "TxDeferred"),        /* delayed pkts due to de=
fer signal */
> > +     MIB_DESC(1, 0xa4, "TxLateCollision"),   /* collisions after 64B *=
/
> > +     MIB_DESC(1, 0xa8, "RxOAM"),             /* rx OAM pkts */
> > +     MIB_DESC(1, 0xac, "TxOAM"),             /* tx OAM pkts */
>
> Please implement:
>         void    (*get_eth_phy_stats)(struct dsa_switch *ds, int port,
>                                      struct ethtool_eth_phy_stats *phy_st=
ats);
>         void    (*get_eth_mac_stats)(struct dsa_switch *ds, int port,
>                                      struct ethtool_eth_mac_stats *mac_st=
ats);
>         void    (*get_eth_ctrl_stats)(struct dsa_switch *ds, int port,
>                                       struct ethtool_eth_ctrl_stats *ctrl=
_stats);
>         void    (*get_rmon_stats)(struct dsa_switch *ds, int port,
>                                   struct ethtool_rmon_stats *rmon_stats,
>                                   const struct ethtool_rmon_hist_range **=
ranges);
>
> and only the remainder (if any) go through the unstructured .get_ethtool_=
stats().
>
> > +};
> > +
> > +static int yt921x_mib_read(struct yt921x_priv *priv, int port, void *d=
ata)
> > +{
> > +     unsigned char *buf =3D data;
> > +     int res =3D 0;
> > +
> > +     for (size_t i =3D 0; i < sizeof(struct yt921x_mib_raw);
> > +          i +=3D sizeof(u32)) {
> > +             res =3D yt921x_smi_read(priv, YT921X_MIBn_DATA0(port) + i=
,
> > +                                   (u32 *)&buf[i]);
> > +             if (res)
> > +                     break;
> > +     }
> > +     return res;
> > +}
>
> You might want to schedule a periodic work item which catches 32-bit
> wraparounds of those MIB counters which lack _hi/_lo, and turns them
> into 64-bit values.
>
> > +
> > +static int yt921x_read_mib_burst(struct yt921x_priv *priv, int port)
> > +{
> > +     struct yt921x_mib_raw *mib =3D &priv->ports[port].mib;
> > +     int res;
> > +
> > +     yt921x_smi_acquire(priv);
> > +     res =3D yt921x_mib_read(priv, port, mib);
> > +     yt921x_smi_release(priv);
> > +
> > +     return res;
> > +}
> > +
> > +static void
> > +yt921x_dsa_get_strings(struct dsa_switch *ds, int port, u32 stringset,
> > +                    uint8_t *data)
> > +{
> > +     if (stringset !=3D ETH_SS_STATS)
> > +             return;
> > +
> > +     for (size_t i =3D 0; i < ARRAY_SIZE(yt921x_mib_descs); i++)
> > +             ethtool_puts(&data, yt921x_mib_descs[i].name);
> > +}
> > +
> > +static void
> > +yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t=
 *data)
> > +{
> > +     struct yt921x_priv *priv =3D to_yt921x_priv(ds);
> > +     struct yt921x_mib_raw *mib =3D &priv->ports[port].mib;
> > +     struct device *dev =3D to_device(priv);
> > +     int res;
> > +
> > +     res =3D yt921x_read_mib_burst(priv, port);
> > +     if (res)
> > +             dev_dbg(dev, "%s: %i\n", __func__, res);
>
> An error in yt921x_read_mib_burst() deserves a more severe log level
> than dev_dbg() IMO. (not to mention a cleaned up error message)
>
> > +
> > +     for (size_t i =3D 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
> > +             const struct yt921x_mib_desc *desc =3D &yt921x_mib_descs[=
i];
> > +             u32 *valp =3D (u32 *)((u8 *)mib + desc->offset);
> > +
> > +             data[i] =3D valp[0];
> > +             if (desc->size > 1) {
> > +                     data[i] <<=3D 32;
> > +                     data[i] |=3D valp[1];
> > +             }
> > +     }
> > +}
> > +
> > +static int yt921x_dsa_get_sset_count(struct dsa_switch *ds, int port, =
int sset)
> > +{
> > +     if (sset !=3D ETH_SS_STATS)
> > +             return 0;
> > +
> > +     return ARRAY_SIZE(yt921x_mib_descs);
> > +}
> > +
> > +static void
> > +yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
> > +                    struct rtnl_link_stats64 *s)
> > +{
> > +     struct yt921x_priv *priv =3D to_yt921x_priv(ds);
> > +     struct yt921x_mib_raw *mib =3D &priv->ports[port].mib;
> > +     struct device *dev =3D to_device(priv);
> > +     int res;
> > +
> > +     res =3D yt921x_read_mib_burst(priv, port);
> > +     if (res)
> > +             dev_dbg(dev, "%s: %i\n", __func__, res);
>
> Running with CONFIG_DEBUG_ATOMIC_SLEEP=3Dy would have shown that you are
> calling a sleepable function from atomic context (ndo_get_stats64) which
> risks deadlocking the kernel.
>
> > +
> > +     s->rx_length_errors =3D (u64)mib->rx_undersize_errors +
> > +                           mib->rx_fragment_errors;
> > +     s->rx_over_errors =3D yt921x_mib_raw_u64(mib, rx_over_errors);
> > +     s->rx_crc_errors =3D mib->rx_crc_errors;
> > +     s->rx_frame_errors =3D mib->rx_frame_errors;
> > +     /* s->rx_fifo_errors */
> > +     /* s->rx_missed_errors */
> > +
> > +     s->tx_aborted_errors =3D mib->tx_aborted_errors;
> > +     /* s->tx_carrier_errors */
> > +     s->tx_fifo_errors =3D mib->tx_undersize_errors;
> > +     /* s->tx_heartbeat_errors */
> > +     s->tx_window_errors =3D mib->tx_window_errors;
> > +
> > +     s->rx_packets =3D (u64)mib->rx_64byte + mib->rx_65_127byte +
> > +                     mib->rx_128_255byte + mib->rx_256_511byte +
> > +                     mib->rx_512_1023byte + mib->rx_1024_1518byte +
> > +                     mib->rx_jumbo;
> > +     s->tx_packets =3D (u64)mib->tx_64byte + mib->tx_65_127byte +
> > +                     mib->tx_128_255byte + mib->tx_256_511byte +
> > +                     mib->tx_512_1023byte + mib->tx_1024_1518byte +
> > +                     mib->tx_jumbo;
> > +     s->rx_bytes =3D yt921x_mib_raw_u64(mib, rx_good_bytes) -
> > +                   ETH_FCS_LEN * s->rx_packets;
> > +     s->tx_bytes =3D yt921x_mib_raw_u64(mib, tx_good_bytes) -
> > +                   ETH_FCS_LEN * s->tx_packets;
> > +     s->rx_errors =3D (u64)mib->rx_crc_errors + s->rx_length_errors +
> > +                    s->rx_over_errors;
> > +     s->tx_errors =3D (u64)mib->tx_undersize_errors + mib->tx_aborted_=
errors +
> > +                    mib->tx_window_errors;
> > +     s->rx_dropped =3D mib->rx_dropped;
> > +     /* s->tx_dropped */
> > +     s->multicast =3D mib->rx_multicast;
> > +     s->collisions =3D yt921x_mib_raw_u64(mib, tx_collisions);
> > +}
> > +
> > +static int
> > +yt921x_dsa_port_change_mtu(struct dsa_switch *ds, int port, int new_mt=
u)
> > +{
> > +     /* Only serves as packet filter, since the frame size is always s=
et to
> > +      * maximum after reset
> > +      */
> > +
> > +     struct yt921x_priv *priv =3D to_yt921x_priv(ds);
> > +     struct dsa_port *dp =3D dsa_to_port(ds, port);
> > +     struct device *dev =3D to_device(priv);
> > +     int frame_size;
> > +
> > +     frame_size =3D new_mtu + ETH_HLEN + ETH_FCS_LEN;
> > +     if (dsa_port_is_cpu(dp))
> > +             frame_size +=3D YT921X_TAG_LEN;
> > +
> > +     dev_dbg(dev, "%s: port %d, mtu %d, frame size %d\n", __func__,
> > +             port, new_mtu, frame_size);
> > +
> > +     return yt921x_smi_update_bits_burst(priv, YT921X_MACn_FRAME(port)=
,
> > +                                         YT921X_MAC_FRAME_SIZE_M,
> > +                                         YT921X_MAC_FRAME_SIZE(frame_s=
ize));
> > +}
> > +
> > +static int yt921x_dsa_port_max_mtu(struct dsa_switch *ds, int port)
> > +{
> > +     /* Don't want to brother dsa_port_is_cpu() here, so use a fixed v=
alue */
>
> s/brother/bother/
>
> Also, .port_max_mtu() is only called for user ports, so the comment is ir=
relevant.
>
> > +     return YT921X_FRAME_SIZE_MAX - ETH_HLEN - ETH_FCS_LEN - YT921X_TA=
G_LEN;
> > +}
> > +
> > +/******** mirror ********/
> > +
> > +static void
> > +yt921x_dsa_port_mirror_del(struct dsa_switch *ds, int port,
> > +                        struct dsa_mall_mirror_tc_entry *mirror)
> > +{
> > +     struct yt921x_priv *priv =3D to_yt921x_priv(ds);
> > +     struct device *dev =3D to_device(priv);
> > +     u32 mask;
> > +     int res;
> > +
> > +     dev_dbg(dev, "%s: port %d, ingress %d\n", __func__, port,
> > +             mirror->ingress);
> > +
> > +     yt921x_smi_acquire(priv);
> > +     if (mirror->ingress)
> > +             mask =3D YT921X_MIRROR_IGR_PORTn(port);
> > +     else
> > +             mask =3D YT921X_MIRROR_EGR_PORTn(port);
> > +     res =3D yt921x_smi_clear_bits(priv, YT921X_MIRROR, mask);
> > +     yt921x_smi_release(priv);
> > +
> > +     if (res)
> > +             dev_dbg(dev, "%s: %i\n", __func__, res);
> > +}
> > +
> > +static int
> > +yt921x_dsa_port_mirror_add(struct dsa_switch *ds, int port,
> > +                        struct dsa_mall_mirror_tc_entry *mirror,
> > +                        bool ingress, struct netlink_ext_ack *extack)
> > +{
> > +     struct yt921x_priv *priv =3D to_yt921x_priv(ds);
> > +     struct device *dev =3D to_device(priv);
> > +     u32 ctrl;
> > +     u32 val;
> > +     int res;
> > +
> > +     dev_dbg(dev, "%s: port %d, ingress %d\n", __func__, port, ingress=
);
> > +
> > +     yt921x_smi_acquire(priv);
> > +     do {
> > +             u32 srcs;
> > +
> > +             res =3D yt921x_smi_read(priv, YT921X_MIRROR, &val);
> > +             if (res)
> > +                     break;
> > +
> > +             if (ingress)
> > +                     srcs =3D YT921X_MIRROR_IGR_PORTn(port);
> > +             else
> > +                     srcs =3D YT921X_MIRROR_EGR_PORTn(port);
> > +
> > +             ctrl =3D val;
> > +             ctrl |=3D srcs;
> > +             ctrl &=3D ~YT921X_MIRROR_PORT_M;
> > +             ctrl |=3D YT921X_MIRROR_PORT(mirror->to_local_port);
> > +             if (ctrl =3D=3D val)
> > +                     break;
>
> yt921x_smi_update_bits() would have helped here, this is a bit hard to
> follow.
>

I need the original value of the register which cannot be returned by
yt921x_smi_update_bits(), but I could make it nicer.

> > +
> > +             /* other mirror tasks & different dst port -> conflict */
> > +             if ((val & ~srcs & (YT921X_MIRROR_EGR_PORTS_M |
> > +                                 YT921X_MIRROR_IGR_PORTS_M)) !=3D 0 &&
> > +                 ((ctrl ^ val) & YT921X_MIRROR_PORT_M) !=3D 0) {
> > +                     res =3D -EEXIST;
>
> Use NL_SET_ERR_MSG_MOD(extack) to signal this.
>
> > +                     break;
> > +             }
> > +
> > +             res =3D yt921x_smi_write(priv, YT921X_MIRROR, ctrl);
> > +     } while (0);
> > +     yt921x_smi_release(priv);
> > +
> > +     return res;
> > +}
> > +
> > +/******** vlan ********/
> > +
> > +static int
> > +yt921x_vlan_filtering(struct yt921x_priv *priv, int port, bool vlan_fi=
ltering)
> > +{
> > +     struct yt921x_port *pp =3D &priv->ports[port];
> > +     u32 mask;
> > +     u32 ctrl;
> > +     int res;
> > +
> > +     res =3D yt921x_smi_toggle_bits(priv, YT921X_VLAN_IGR_FILTER,
> > +                                  YT921X_VLAN_IGR_FILTER_PORTn_EN(port=
),
> > +                                  vlan_filtering);
> > +     if (res)
> > +             return res;
> > +
> > +     mask =3D YT921X_PORT_VLAN_CTRL1_CVLAN_DROP_TAGGED |
> > +            YT921X_PORT_VLAN_CTRL1_CVLAN_DROP_UNTAGGED;
> > +     ctrl =3D 0;
> > +     if (vlan_filtering) {
> > +             if (!pp->pvid)
> > +                     ctrl |=3D YT921X_PORT_VLAN_CTRL1_CVLAN_DROP_UNTAG=
GED;
> > +             if (!pp->vids_cnt)
> > +                     ctrl |=3D YT921X_PORT_VLAN_CTRL1_CVLAN_DROP_TAGGE=
D;
> > +     }
> > +     res =3D yt921x_smi_update_bits(priv, YT921X_PORTn_VLAN_CTRL1(port=
),
> > +                                  mask, ctrl);
> > +     if (res)
> > +             return res;
> > +
> > +     pp->vlan_filtering =3D vlan_filtering;
>
> The PVID depends on the VLAN filtering state of the port, so this
> function needs to update the PVID.
>

If I got it right the PVID is already set and programmed below by pvid_set(=
).

> > +     return 0;
> > +}
> > +
> > +static int
> > +yt921x_vid_del(struct yt921x_priv *priv, int port, u16 vid)
> > +{
> > +     struct yt921x_port *pp =3D &priv->ports[port];
> > +     u32 mask;
> > +     u32 ctrl;
> > +     u32 val;
> > +     int res;
> > +
> > +     res =3D yt921x_smi_read(priv, YT921X_VLANn_CTRL(port), &val);
> > +     if (res)
> > +             return res;
> > +     ctrl =3D val & ~YT921X_VLAN_CTRL_PORTn(port);
> > +     if (ctrl =3D=3D val)
> > +             return 0;
> > +     res =3D yt921x_smi_write(priv, YT921X_VLANn_CTRL(port), ctrl);
> > +     if (res)
> > +             return res;
> > +
> > +     mask =3D YT921X_VLAN_CTRL1_UNTAG_PORTn(port);
> > +     res =3D yt921x_smi_clear_bits(priv, YT921X_VLANn_CTRL1(port), mas=
k);
> > +     if (res)
> > +             return res;
> > +
> > +     if (pp->vlan_filtering && pp->vids_cnt <=3D 1) {
> > +             mask =3D YT921X_PORT_VLAN_CTRL1_CVLAN_DROP_TAGGED;
> > +             res =3D yt921x_smi_set_bits(priv, YT921X_PORTn_VLAN_CTRL1=
(port),
> > +                                       mask);
> > +             if (res)
> > +                     return res;
> > +     }
> > +
> > +     if (!WARN_ON(pp->vids_cnt <=3D 0))
> > +             pp->vids_cnt--;
> > +     return 0;
> > +}
> > +
> > +/* Seems port_vlan_add() is not state transition method... */
>
> I'm not sure what's a state transition method, but .port_vlan_add() is
> called if and only if a VLAN is added or the flags (PVID, untagged) of
> an existing VLAN are changed.
>

So it's not "adding" VLANs and I cannot always pp->vids_cnt++.

> > +static int
> > +yt921x_vid_set(struct yt921x_priv *priv, int port, u16 vid, bool untag=
ged)
> > +{
> > +     struct yt921x_port *pp =3D &priv->ports[port];
> > +     bool already_added;
> > +     u32 mask;
> > +     u32 ctrl;
> > +     u32 val;
> > +     int res;
> > +
> > +     res =3D yt921x_smi_read(priv, YT921X_VLANn_CTRL(port), &val);
> > +     if (res)
> > +             return res;
> > +     ctrl =3D val | YT921X_VLAN_CTRL_PORTn(port);
> > +     if (ctrl =3D=3D val) {
> > +             already_added =3D true;
> > +     } else {
> > +             already_added =3D false;
> > +             res =3D yt921x_smi_write(priv, YT921X_VLANn_CTRL(port), c=
trl);
> > +             if (res)
> > +                     return res;
> > +     }
> > +
> > +     mask =3D YT921X_VLAN_CTRL1_UNTAG_PORTn(port);
> > +     res =3D yt921x_smi_toggle_bits(priv, YT921X_VLANn_CTRL1(port), ma=
sk,
> > +                                  untagged);
> > +     if (res)
> > +             return res;
> > +
> > +     mask =3D YT921X_PORT_VLAN_CTRL1_CVLAN_DROP_TAGGED;
> > +     res =3D yt921x_smi_clear_bits(priv, YT921X_PORTn_VLAN_CTRL1(port)=
, mask);
> > +     if (res)
> > +             return res;
> > +
> > +     if (!already_added) {
> > +             if (!WARN_ON(pp->vids_cnt >=3D VLAN_N_VID - 1))
> > +                     pp->vids_cnt++;
> > +     }
> > +     return 0;
> > +}
> > +
> > +static int
> > +yt921x_pvid_clear(struct yt921x_priv *priv, int port)
> > +{
> > +     struct yt921x_port *pp =3D &priv->ports[port];
> > +     u32 mask;
> > +     u32 ctrl;
> > +     int res;
> > +
> > +     mask =3D YT921X_PORT_VLAN_CTRL_CVID_M;
> > +     ctrl =3D YT921X_PORT_VLAN_CTRL_CVID(YT921X_PVID_DEFAULT);
> > +     res =3D yt921x_smi_update_bits(priv, YT921X_PORTn_VLAN_CTRL(port)=
,
> > +                                  mask, ctrl);
> > +     if (res)
> > +             return res;
> > +
> > +     if (pp->vlan_filtering) {
> > +             mask =3D YT921X_PORT_VLAN_CTRL1_CVLAN_DROP_UNTAGGED;
> > +             res =3D yt921x_smi_set_bits(priv, YT921X_PORTn_VLAN_CTRL1=
(port),
> > +                                       mask);
> > +             if (res)
> > +                     return res;
> > +     }
> > +
> > +     pp->pvid =3D 0;
>
> A bit confusing that the hardware is programmed with YT921X_PVID_DEFAULT
> (1) but pp->pvid is 0. You might want to rename this to vlan_aware_pvid,
> for clarity. Though on user ports, you can always query it directly
> using br_vlan_get_pvid().
>

See above, if there is no consequence programming to 0.

> > +     return 0;
> > +}
> > +
> > +static int
> > +yt921x_dsa_port_vlan_add(struct dsa_switch *ds, int port,
> > +                      const struct switchdev_obj_port_vlan *vlan,
> > +                      struct netlink_ext_ack *extack)
> > +{
> > +     struct yt921x_priv *priv =3D to_yt921x_priv(ds);
> > +     struct yt921x_port *pp =3D &priv->ports[port];
> > +     struct device *dev =3D to_device(priv);
> > +     u16 vid =3D vlan->vid;
> > +     int res;
> > +
> > +     dev_dbg(dev, "%s: port %d, vid %d, flags 0x%x\n", __func__, port,=
 vid,
> > +             vlan->flags);
>
> Please get rid of these development leftovers. Also, for VLAN
> operations, DSA already has trace events (net/dsa/trace.c).
>
> > +
> > +     yt921x_smi_acquire(priv);
> > +     do {
> > +             res =3D yt921x_vid_set(priv, port, vid,
> > +                                  (vlan->flags &
> > +                                   BRIDGE_VLAN_INFO_UNTAGGED) !=3D 0);
> > +             if (res)
> > +                     break;
> > +
> > +             if ((vlan->flags & BRIDGE_VLAN_INFO_PVID) !=3D 0) {
> > +                     res =3D yt921x_pvid_set(priv, port, vid);
> > +                     if (res)
> > +                             break;
> > +             } else if (pp->pvid =3D=3D vid) {
> > +                     res =3D yt921x_pvid_clear(priv, port);
> > +                     if (res)
> > +                             break;
> > +             }
> > +     } while (0);
> > +     yt921x_smi_release(priv);
> > +
> > +     return res;
> > +}
> > +
> > +/******** bridge ********/
> > +
> > +/* It's caller's responsibility to decide whether ports_mask contains =
cpu
> > + * ports
> > + */
>
> I don't understand this comment. What did the caller decide after all?
>

They can make a bridge without cpu ports. Of course it's never the
case in DSA, but it also serves as a reminder bitwise-oring your cpu
ports after collecting user ports.

> > +static int yt921x_bridge(struct yt921x_priv *priv, u16 ports_mask)
> > +{
> > +     u16 targets_mask =3D ports_mask & ~priv->cpu_ports_mask;
> > +     u32 isolated_mask;
> > +     u32 ctrl;
> > +     int res;
> > +
> > +     isolated_mask =3D 0;
> > +     for (u16 pm =3D targets_mask; pm ; ) {
> > +             struct yt921x_port *pp;
> > +             int port =3D __fls(pm);
> > +
> > +             pm &=3D ~BIT(port);
>
> for_each_set_bit() would be easier to follow.
>
> > +             pp =3D &priv->ports[port];
> > +
> > +             if (pp->isolated)
> > +                     isolated_mask |=3D BIT(port);
> > +     }
> > +
> > +     /* Block from non-cpu bridge ports ... */
> > +     for (u16 pm =3D targets_mask; pm ; ) {
> > +             struct yt921x_port *pp;
> > +             int port =3D __fls(pm);
> > +
> > +             pm &=3D ~BIT(port);
> > +             pp =3D &priv->ports[port];
> > +
> > +             /* to non-bridge ports */
> > +             ctrl =3D ~ports_mask;
> > +             /* to isolated ports when isolated */
> > +             if (pp->isolated)
> > +                     ctrl |=3D isolated_mask;
> > +             /* to itself when non-hairpin */
> > +             if (!pp->hairpin)
> > +                     ctrl |=3D BIT(port);
> > +             else
> > +                     ctrl &=3D ~BIT(port);
> > +
> > +             res =3D yt921x_smi_write(priv, YT921X_PORTn_ISOLATION(por=
t),
> > +                                    ctrl);
>
> Doesn't this write ones outside of the YT921X_PORT_ISOLATION_BLOCKn
> field? I suppose there are some reserved high-order values which should
> be preserved when writing?
>

No, it's safe to write excessive 1s here.

> > +             if (res)
> > +                     return res;
> > +     }
> > +
> > +     for (u16 pm =3D targets_mask; pm ; ) {
> > +             struct yt921x_port *pp;
> > +             int port =3D __fls(pm);
> > +
> > +             pm &=3D ~BIT(port);
> > +             pp =3D &priv->ports[port];
> > +
> > +             pp->bridge_mask =3D ports_mask;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int yt921x_bridge_force(struct yt921x_priv *priv, u16 ports_mas=
k)
>
> The bridge_force() function name is a bit unconventional, what does it
> mean?
>
> > +{
> > +     u16 targets_mask =3D ~ports_mask & (BIT(YT921X_PORT_NUM) - 1) &
> > +                        ~priv->cpu_ports_mask;
>
> What is the intention here? Assume you have one bridge with ports A and B=
,
> and another with ports C and D.
>
> Port D leaves the bridge, then targets_mask, the mask of ports which
> will become standalone, is comprised of ports A, B and D. Why? This
> sounds like a bug, ports A and B should remain untouched, as ports of an
> unrelated bridge.
>

bridge_force() does not know it's Port D/E/F... leaving the bridge.

Although DSA does tell us which port is leaving, we choose to rely on
hardware registers as much as possible, and wipe (force) configs on
all (non-bridge) ports. This also helps killing any unintentional port
leftovers if that (bug) does exist, otherwise errors would accumulate
until a reset is unavoidable. (Should errors emerge in bridge(),
bridge_force() would take care of them.)

> > +     u32 mask;
> > +     int res;
> > +
> > +     res =3D yt921x_bridge(priv, ports_mask);
> > +     if (res)
> > +             return res;
> > +
> > +     /* Block ... to non-cpu bridge ports */
> > +     mask =3D ports_mask & ~priv->cpu_ports_mask;
> > +     /* from non-cpu non-bridge ports */
> > +     for (u16 pm =3D targets_mask; pm ; ) {
> > +             int port =3D __fls(pm);
> > +
> > +             pm &=3D ~BIT(port);
> > +             res =3D yt921x_smi_set_bits(priv, YT921X_PORTn_ISOLATION(=
port),
> > +                                       mask);
> > +             if (res)
> > +                     return res;
> > +     }
> > +
> > +     for (u16 pm =3D targets_mask; pm ; ) {
> > +             struct yt921x_port *pp;
> > +             int port =3D __fls(pm);
> > +
> > +             pm &=3D ~BIT(port);
> > +             pp =3D &priv->ports[port];
> > +
> > +             pp->bridge_mask &=3D ~mask;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static u32
> > +dsa_bridge_ports(struct dsa_switch *ds, const struct net_device *bridg=
e_dev)
> > +{
> > +     struct dsa_port *dp;
> > +     u32 mask =3D 0;
> > +
> > +     dsa_switch_for_each_user_port(dp, ds)
> > +             if (dsa_port_offloads_bridge_dev(dp, bridge_dev))
> > +                     mask |=3D BIT(dp->index);
> > +
> > +     return mask;
> > +}
>
> If this is useful, you should place this in include/net/dsa.h, and you
> can use a const struct dsa_bridge pointer as the second argument.
> Although I am not yet sure whether it is useful or not. I would like to
> see a non-buggy implementation of bridge offloading using it, first.
>
> > +
> > +static void
> > +yt921x_dsa_port_bridge_leave(struct dsa_switch *ds, int port,
> > +                          struct dsa_bridge bridge)
> > +{
> > +     struct yt921x_priv *priv =3D to_yt921x_priv(ds);
> > +     struct device *dev =3D to_device(priv);
> > +     u16 ports_mask;
> > +     int res;
> > +
> > +     ports_mask =3D dsa_bridge_ports(ds, bridge.dev);
> > +
> > +     dev_dbg(dev, "%s: port %d, mask 0x%x\n", __func__, port, ports_ma=
sk);
> > +
> > +     ports_mask |=3D priv->cpu_ports_mask;
> > +
> > +     yt921x_smi_acquire(priv);
> > +     res =3D yt921x_bridge_force(priv, ports_mask);
> > +     yt921x_smi_release(priv);
> > +
> > +     if (res)
> > +             dev_dbg(dev, "%s: %i\n", __func__, res);
> > +}
> > +
> > +static int
> > +yt921x_dsa_port_bridge_join(struct dsa_switch *ds, int port,
> > +                         struct dsa_bridge bridge, bool *tx_fwd_offloa=
d,
> > +                         struct netlink_ext_ack *extack)
> > +{
> > +     struct yt921x_priv *priv =3D to_yt921x_priv(ds);
> > +     struct device *dev =3D to_device(priv);
> > +     u16 ports_mask;
> > +     int res;
> > +
> > +     ports_mask =3D dsa_bridge_ports(ds, bridge.dev);
> > +
> > +     dev_dbg(dev, "%s: port %d, mask 0x%x\n", __func__, port, ports_ma=
sk);
> > +
> > +     ports_mask |=3D priv->cpu_ports_mask;
> > +
> > +     yt921x_smi_acquire(priv);
> > +     res =3D yt921x_bridge(priv, ports_mask);
> > +     yt921x_smi_release(priv);
> > +
> > +     return res;
> > +}
> > +
> > +/******** fdb ********/
> > +
> > +static int yt921x_fdb_wait(struct yt921x_priv *priv, u32 *valp)
> > +{
> > +     struct device *dev =3D to_device(priv);
> > +     u32 val;
> > +     int res;
> > +
> > +     res =3D yt921x_smi_read(priv, YT921X_FDB_RESULT, &val);
> > +     if (res)
> > +             return res;
> > +     if ((val & YT921X_FDB_RESULT_DONE) =3D=3D 0) {
> > +             yt921x_smi_release(priv);
>
> yuck, why is it ok to release the SMI lock here? What's the point of the
> lock in the first place?
>

It's the bus lock, not the driver lock. We need to release the bus
lock when we want to sleep.

> As a matter of fact, .port_fdb_add() and .port_fdb_del() are one of the
> few operations which DSA emits which aren't serialized by rtnl_lock().
> They can absolutely be concurrent with .port_fdb_dump(), .port_mdb_add(),
> .port_mdb_del() etc. It seems like higher-level locking is needed.
>
> > +             res =3D read_poll_timeout(yt921x_smi_read_burst, res,
> > +                                     (val & YT921X_FDB_RESULT_DONE) !=
=3D 0,
> > +                                     YT921X_MDIO_SLEEP_US,
> > +                                     YT921X_MDIO_TIMEOUT_US,
> > +                                     true, priv, YT921X_FDB_RESULT,
> > +                                     &val);
> > +             yt921x_smi_acquire(priv);
> > +             if (res) {
> > +                     dev_warn(dev, "Probably an FDB hang happened\n");
> > +                     return res;
> > +             }
> > +     }
> > +
> > +     *valp =3D val;
> > +     return 0;
> > +}
> > +
> > +static void yt921x_dsa_port_fast_age(struct dsa_switch *ds, int port)
> > +{
> > +     struct yt921x_priv *priv =3D to_yt921x_priv(ds);
> > +     struct device *dev =3D to_device(priv);
> > +     int res;
> > +
> > +     dev_dbg(dev, "%s: port %d\n", __func__, port);
> > +
> > +     yt921x_smi_acquire(priv);
> > +     res =3D yt921x_fdb_flush(priv, BIT(port), 0, false);
> > +     yt921x_smi_release(priv);
> > +
> > +     if (res)
> > +             dev_dbg(dev, "%s: %i\n", __func__, res);
> > +}
> > +
> > +static int
> > +yt921x_dsa_port_vlan_fast_age(struct dsa_switch *ds, int port, u16 vid=
)
> > +{
> > +     struct yt921x_priv *priv =3D to_yt921x_priv(ds);
> > +     struct device *dev =3D to_device(priv);
> > +     int res;
> > +
> > +     dev_dbg(dev, "%s: port %d, vlan %d\n", __func__, port, vid);
> > +
> > +     yt921x_smi_acquire(priv);
> > +     res =3D yt921x_fdb_flush(priv, BIT(port), vid, false);
> > +     yt921x_smi_release(priv);
> > +
> > +     return res;
> > +}
>
> .port_vlan_fast_age() is dead code until dsa_port_supports_mst() returns
> true. I advise you to delete it.
>
> > +
> > +static int
> > +yt921x_dsa_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
> > +{
> > +     struct yt921x_priv *priv =3D to_yt921x_priv(ds);
> > +     struct device *dev =3D to_device(priv);
> > +     u32 ctrl;
> > +     int res;
> > +
> > +     dev_dbg(dev, "%s: %d\n", __func__, msecs);
> > +
> > +     /* AGEING reg is set in 5s step */
> > +     ctrl =3D msecs / 5000;
> > +
> > +     /* Handle case with 0 as val to NOT disable learning */
>
> learning? maybe ageing?
>

0 =3D immediate aged =3D not learning

> > +     if (!ctrl)
> > +             ctrl =3D 1;
> > +     else if (ctrl > 0xffff)
> > +             ctrl =3D 0xffff;
> > +
> > +     yt921x_smi_acquire(priv);
> > +     res =3D yt921x_smi_write(priv, YT921X_AGEING, ctrl);
> > +     yt921x_smi_release(priv);
> > +
> > +     return res;
> > +}
> > +
> > +static int
> > +yt921x_port_config(struct yt921x_priv *priv, int port, unsigned int mo=
de,
> > +                phy_interface_t interface)
> > +{
> > +     struct device *dev =3D to_device(priv);
> > +     u32 mask;
> > +     u32 ctrl;
> > +     int res;
> > +
> > +     if (!yt921x_port_is_external(port)) {
> > +             if (interface !=3D PHY_INTERFACE_MODE_INTERNAL) {
> > +                     dev_err(dev, "Wrong mode %d on port %d\n",
> > +                             interface, port);
> > +                     return -EINVAL;
> > +             }
> > +             return 0;
> > +     }
> > +
> > +     switch (interface) {
> > +     /* SGMII */
> > +     case PHY_INTERFACE_MODE_SGMII:
> > +     case PHY_INTERFACE_MODE_100BASEX:
> > +     case PHY_INTERFACE_MODE_1000BASEX:
> > +     case PHY_INTERFACE_MODE_2500BASEX:
> > +             res =3D yt921x_smi_set_bits(priv, YT921X_SGMII_CTRL,
> > +                                       YT921X_SGMII_CTRL_PORTn(port));
> > +             if (res)
> > +                     return res;
> > +             res =3D yt921x_smi_clear_bits(priv, YT921X_XMII_CTRL,
> > +                                         YT921X_XMII_CTRL_PORTn(port))=
;
> > +             if (res)
> > +                     return res;
> > +
> > +             mask =3D YT921X_SGMII_MODE_M;
> > +             switch (interface) {
> > +             case PHY_INTERFACE_MODE_SGMII:
> > +                     ctrl =3D YT921X_SGMII_MODE_SGMII_PHY;
> > +                     break;
> > +             case PHY_INTERFACE_MODE_100BASEX:
> > +                     ctrl =3D YT921X_SGMII_MODE_100BASEX;
> > +                     break;
> > +             case PHY_INTERFACE_MODE_1000BASEX:
> > +                     ctrl =3D YT921X_SGMII_MODE_1000BASEX;
> > +                     break;
> > +             case PHY_INTERFACE_MODE_2500BASEX:
> > +                     ctrl =3D YT921X_SGMII_MODE_2500BASEX;
> > +                     break;
> > +             default:
> > +                     WARN_ON(1);
> > +                     break;
> > +             }
> > +             res =3D yt921x_smi_update_bits(priv, YT921X_SGMIIn(port),
> > +                                          mask, ctrl);
> > +             if (res)
> > +                     return res;
> > +
> > +             break;
> > +     /* XMII */
> > +     case PHY_INTERFACE_MODE_MII:
> > +     case PHY_INTERFACE_MODE_REVMII:
> > +     case PHY_INTERFACE_MODE_RMII:
> > +     case PHY_INTERFACE_MODE_REVRMII:
> > +     case PHY_INTERFACE_MODE_RGMII:
> > +     case PHY_INTERFACE_MODE_RGMII_ID:
> > +     case PHY_INTERFACE_MODE_RGMII_RXID:
> > +     case PHY_INTERFACE_MODE_RGMII_TXID:
> > +     case PHY_INTERFACE_MODE_INTERNAL:
> > +             /* TODO */
> > +             dev_err(dev, "Untested mode %d\n", interface);
> > +             return -EINVAL;
>
> Delete the code after return below, and add it when it's tested.
> Though I fail to see why you'd add to supported_interfaces an
> unsupported interface.
>
> > +             res =3D yt921x_smi_clear_bits(priv, YT921X_SGMII_CTRL,
> > +                                         YT921X_SGMII_CTRL_PORTn(port)=
);
> > +             if (res)
> > +                     return res;
> > +             res =3D yt921x_smi_set_bits(priv, YT921X_XMII_CTRL,
> > +                                       YT921X_XMII_CTRL_PORTn(port));
> > +             if (res)
> > +                     return res;
> > +
> > +             mask =3D YT921X_XMII_EN | YT921X_XMII_MODE_M;
> > +             ctrl =3D YT921X_XMII_EN;
> > +             switch (interface) {
> > +             case PHY_INTERFACE_MODE_MII:
> > +                     ctrl |=3D YT921X_XMII_MODE_MII;
> > +                     break;
> > +             case PHY_INTERFACE_MODE_REVMII:
> > +                     ctrl |=3D YT921X_XMII_MODE_REVMII;
> > +                     break;
> > +             case PHY_INTERFACE_MODE_RMII:
> > +                     ctrl |=3D YT921X_XMII_MODE_RMII;
> > +                     break;
> > +             case PHY_INTERFACE_MODE_REVRMII:
> > +                     ctrl |=3D YT921X_XMII_MODE_REVRMII;
> > +                     break;
> > +             case PHY_INTERFACE_MODE_RGMII:
> > +             case PHY_INTERFACE_MODE_RGMII_ID:
> > +             case PHY_INTERFACE_MODE_RGMII_RXID:
> > +             case PHY_INTERFACE_MODE_RGMII_TXID:
> > +                     ctrl |=3D YT921X_XMII_MODE_RGMII;
> > +                     break;
> > +             case PHY_INTERFACE_MODE_INTERNAL:
> > +                     ctrl |=3D YT921X_XMII_MODE_DISABLE;
> > +                     break;
> > +             default:
> > +                     WARN_ON(1);
> > +                     break;
> > +             }
> > +             res =3D yt921x_smi_update_bits(priv, YT921X_XMIIn(port),
> > +                                          mask, ctrl);
> > +             if (res)
> > +                     return res;
> > +
> > +             /* TODO: RGMII delay */
> > +
> > +             break;
> > +     default:
> > +             WARN_ON(1);
> > +             break;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void
> > +yt921x_phylink_mac_link_down(struct phylink_config *config, unsigned i=
nt mode,
> > +                          phy_interface_t interface)
> > +{
> > +     struct dsa_port *dp =3D dsa_phylink_to_port(config);
> > +     struct dsa_switch *ds =3D dp->ds;
> > +     struct yt921x_priv *priv =3D to_yt921x_priv(ds);
> > +     struct device *dev =3D to_device(priv);
> > +     int port =3D dp->index;
> > +     int res;
> > +
> > +     dev_dbg(dev, "%s: port %d\n", __func__, port);
> > +
> > +     yt921x_smi_acquire(priv);
> > +     res =3D yt921x_port_down(priv, port);
> > +     yt921x_smi_release(priv);
> > +
> > +     if (res)
> > +             dev_err(dev, "%s: port %d: %i\n", __func__, port, res);
>
> "Failed to bring port %d down: %pe\n", port, ERR_PTR(ret) seems a bit
> more elegant.
>
> > +}
> > +
> > +static int yt921x_dsa_get_eeprom_len(struct dsa_switch *ds)
> > +{
> > +     return YT921X_EDATA_LEN;
> > +}
> > +
> > +static int
> > +yt921x_dsa_get_eeprom(struct dsa_switch *ds, struct ethtool_eeprom *ee=
prom,
> > +                   u8 *data)
> > +{
> > +     struct yt921x_priv *priv =3D to_yt921x_priv(ds);
> > +     unsigned int i =3D 0;
> > +     int res;
> > +
> > +     yt921x_smi_acquire(priv);
> > +     do {
> > +             res =3D yt921x_edata_wait(priv);
> > +             if (res)
> > +                     break;
> > +             for (; i < eeprom->len; i++) {
> > +                     unsigned int offset =3D eeprom->offset + i;
> > +
> > +                     res =3D yt921x_edata_read_cont(priv, offset, &dat=
a[i]);
> > +                     if (res)
> > +                             break;
> > +             }
> > +     } while (0);
> > +     yt921x_smi_release(priv);
> > +
> > +     eeprom->len =3D i;
> > +     return res;
>
> What is contained in this EEPROM?
>

No description, sorry.

> > +}
> > +
> > +static struct dsa_port *
> > +yt921x_dsa_preferred_default_local_cpu_port(struct dsa_switch *ds)
> > +{
> > +     struct dsa_port *ext_dp =3D NULL;
> > +     struct dsa_port *cpu_dp;
> > +
> > +     dsa_switch_for_each_cpu_port(cpu_dp, ds)
> > +             if (yt921x_port_is_external(cpu_dp->index)) {
> > +                     ext_dp =3D cpu_dp;
> > +                     break;
> > +             }
> > +
> > +     return ext_dp;
> > +}
>
> Handling .preferred_default_local_cpu_port() is not necessary if the
> hardware does not support multiple CPU ports, please drop this.
>
> > +
> > +static void
> > +yt921x_dsa_conduit_state_change(struct dsa_switch *ds,
> > +                             const struct net_device *conduit,
> > +                             bool operational)
> > +{
> > +     struct yt921x_priv *priv =3D to_yt921x_priv(ds);
> > +     struct dsa_port *cpu_dp =3D conduit->dsa_ptr;
> > +     struct device *dev =3D to_device(priv);
> > +     int port =3D cpu_dp->index;
> > +     u32 ctrl;
> > +     int res;
> > +
> > +     dev_dbg(dev, "%s: port %d, up %d\n", __func__, port, operational)=
;
> > +
> > +     if (operational)
> > +             priv->active_cpu_ports_mask |=3D BIT(port);
> > +     else
> > +             priv->active_cpu_ports_mask &=3D ~BIT(port);
> > +
> > +     if (priv->active_cpu_ports_mask) {
> > +             ctrl =3D YT921X_EXT_CPU_PORT_TAG_EN |
> > +                    YT921X_EXT_CPU_PORT_PORT_EN |
> > +                    YT921X_EXT_CPU_PORT_PORT(__fls(priv->active_cpu_po=
rts_mask));
> > +             res =3D yt921x_smi_write_burst(priv, YT921X_EXT_CPU_PORT,=
 ctrl);
> > +             if (res)
> > +                     dev_dbg(dev, "%s: %i\n", __func__, res);
> > +     }
> > +}
>
> Handling .conduit_state_change() is not necessary. The hardware supports
> a single CPU port, and nothing is done when the conduit interface becomes
> inactive. priv->active_cpu_ports_mask becomes zero and the hardware is
> not updated in any way. The initialization done in yt921x_dsa_setup() is
> sufficient, please remove this.
>
> > +
> > +static int yt921x_dsa_setup(struct dsa_switch *ds)
> > +{
> > +     struct yt921x_priv *priv =3D to_yt921x_priv(ds);
> > +     struct device *dev =3D to_device(priv);
> > +     struct device_node *np =3D dev->of_node;
> > +     struct device_node *child;
> > +     u32 ctrl;
> > +     u32 val;
> > +     int res;
> > +
> > +     priv->cpu_ports_mask =3D dsa_cpu_ports(ds);
> > +     if (!priv->cpu_ports_mask) {
> > +             dev_err(dev, "No CPU port\n");
>
> dsa_tree_setup_default_cpu() ensures a CPU port exists and fails probing
> otherwise. This is needlessly defensive.
>
> > +             return -ENODEV;
> > +     }
> > +
> > +     res =3D yt921x_detect(priv);
> > +     if (res)
> > +             return res;
> > +
> > +     /* Reset */
> > +     res =3D yt921x_smi_write_burst(priv, YT921X_RST, YT921X_RST_HW);
> > +     if (res)
> > +             return res;
> > +
> > +     /* YT921X_RST_HW is almost same as GPIO hard reset, so we need
> > +      * this delay.
> > +      */
> > +     fsleep(YT921X_RST_DELAY_US);
> > +
> > +     res =3D read_poll_timeout(yt921x_smi_read_burst, res, val =3D=3D =
0,
> > +                             YT921X_MDIO_SLEEP_US, YT921X_RST_TIMEOUT_=
US,
> > +                             false, priv, YT921X_RST, &val);
> > +     if (res) {
> > +             dev_err(dev, "Reset timeout\n");
> > +             return res;
> > +     }
> > +
> > +     /* Always register one mdio bus for the internal/default mdio bus=
. This
> > +      * maybe represented in the device tree, but is optional.
> > +      */
> > +     child =3D of_get_child_by_name(np, "mdio");
> > +     res =3D yt921x_mbus_int_init(priv, child);
> > +     of_node_put(child);
> > +     if (res)
> > +             return res;
> > +     ds->user_mii_bus =3D priv->mbus_int;
>
> I guess you got this snippet from mv88e6xxx_mdios_register(), which is
> different from your case because it is an old driver which has to
> support older device trees, before conventions changed.
>
> Please only register the internal MDIO bus if it is present in the
> device tree. This simplifies the driver and dt-bindings by having a
> single way of describing ports with internal PHYs. Also, remove the
> ds->user_mii_bus assignment after you do that.
>

How to access internal PHYs without registering the internal MDIO bus?
I know .phy_read and .phy_write, but all dsa_user_mii_bus_init() does
is to register and assign to ds->user_mii_bus for you using
phy_read/phy_write. Giving that we have an external bus to register,
it's pretty wired to register buses in two different ways. Also
mt7530.c does so for its internal bus.

> > +
> > +     /* Walk the device tree, and see if there are any other nodes whi=
ch say
> > +      * they are compatible with the external mdio bus.
> > +      */
> > +     child =3D of_get_child_by_name(np, "mdio-external");
> > +     if (!child) {
> > +             priv->mbus_ext =3D NULL;
> > +     } else {
> > +             res =3D yt921x_mbus_ext_init(priv, child);
> > +             of_node_put(child);
> > +             if (res)
> > +                     return res;
> > +
> > +             dev_err(dev, "Untested external mdio bus\n");
> > +             return -ENODEV;
> > +     }
> > +
> > +     yt921x_smi_acquire(priv);
> > +     do {
> > +             /* Enable DSA */
> > +             res =3D yt921x_smi_read(priv, YT921X_CPU_TAG_TPID, &val);
> > +             if (res)
> > +                     break;
> > +             priv->tag_eth_p =3D FIELD_GET(YT921X_CPU_TAG_TPID_TPID_M,=
 val);
> > +             if (priv->tag_eth_p !=3D YT921X_CPU_TAG_TPID_TPID_DEFAULT=
) {
> > +                     dev_warn(dev, "Tag type 0x%x !=3D 0x%x\n",
> > +                              priv->tag_eth_p,
> > +                              YT921X_CPU_TAG_TPID_TPID_DEFAULT);
> > +                     /* Although CPU_TAG_TPID could be configured, we =
choose
> > +                      * not to do so, since there is no way it could b=
e
> > +                      * different from the default, unless you are usi=
ng the
> > +                      * wrong chip.
> > +                      */
>
> Wouldn't have yt921x_detect() seen that you are using the wrong chip?
> Testing CPU_TAG_TPID for an unexpected value after reset seems like a
> strikingly odd thing to do, and a waste of CPU cycles at boot time.
> (also, priv->tag_eth_p could have been a local variable)
>
> > +                     res =3D -EINVAL;
> > +                     break;
> > +             }
> > +
> > +             /* Unconditionally bring up one CPU port, to avoid warnin=
gs from
> > +              * yt921x_tag_rcv() before conduit_state_change() is call=
ed.
> > +              */
>
> What warnings? (not that you shouldn't bring the CPU port up)
>
> > +             ctrl =3D YT921X_EXT_CPU_PORT_TAG_EN |
> > +                    YT921X_EXT_CPU_PORT_PORT_EN |
> > +                    YT921X_EXT_CPU_PORT_PORT(__fls(priv->cpu_ports_mas=
k));
> > +             res =3D yt921x_smi_write(priv, YT921X_EXT_CPU_PORT, ctrl)=
;
> > +             if (res)
> > +                     break;
> > +
> > +             /* Enable MIB */
> > +             res =3D yt921x_smi_set_bits(priv, YT921X_FUNC, YT921X_FUN=
C_MIB);
> > +             if (res)
> > +                     break;
> > +
> > +             ctrl =3D YT921X_MIB_CTRL_CLEAN | YT921X_MIB_CTRL_ALL_PORT=
;
> > +             res =3D yt921x_smi_write(priv, YT921X_MIB_CTRL, ctrl);
> > +             if (res)
> > +                     break;
> > +
> > +             /* Port flags */
> > +             ctrl =3D ~0;
> > +             res =3D yt921x_smi_write(priv, YT921X_FILTER_UNK_UCAST, c=
trl);
> > +             if (res)
> > +                     break;
> > +
> > +             ctrl =3D YT921X_CPU_COPY_TO_EXT_CPU;
> > +             res =3D yt921x_smi_write(priv, YT921X_CPU_COPY, ctrl);
> > +             if (res)
> > +                     break;
> > +
> > +             /* Temperature sensor */
> > +             res =3D yt921x_smi_set_bits(priv, YT921X_SENSOR,
> > +                                       YT921X_SENSOR_TEMP);
> > +     } while (0);
> > +     yt921x_smi_release(priv);
> > +     if (res)
> > +             return res;
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct phylink_mac_ops yt921x_phylink_mac_ops =3D {
> > +     .mac_link_down  =3D yt921x_phylink_mac_link_down,
> > +     .mac_link_up    =3D yt921x_phylink_mac_link_up,
> > +     .mac_config     =3D yt921x_phylink_mac_config,
> > +};
> > +
> > +static const struct dsa_switch_ops yt921x_dsa_switch_ops =3D {
> > +     /* mib */
> > +     .get_strings            =3D yt921x_dsa_get_strings,
> > +     .get_ethtool_stats      =3D yt921x_dsa_get_ethtool_stats,
> > +     .get_sset_count         =3D yt921x_dsa_get_sset_count,
> > +     .get_stats64            =3D yt921x_dsa_get_stats64,
> > +     .get_pause_stats        =3D yt921x_dsa_get_pause_stats,
> > +     /* eee */
> > +     .support_eee            =3D yt921x_dsa_support_eee,
> > +     .set_mac_eee            =3D yt921x_dsa_set_mac_eee,
> > +     /* mtu */
> > +     .port_change_mtu        =3D yt921x_dsa_port_change_mtu,
> > +     .port_max_mtu           =3D yt921x_dsa_port_max_mtu,
> > +     /* mirror */
> > +     .port_mirror_del        =3D yt921x_dsa_port_mirror_del,
> > +     .port_mirror_add        =3D yt921x_dsa_port_mirror_add,
> > +     /* vlan */
> > +     .port_vlan_filtering    =3D yt921x_dsa_port_vlan_filtering,
> > +     .port_vlan_del          =3D yt921x_dsa_port_vlan_del,
> > +     .port_vlan_add          =3D yt921x_dsa_port_vlan_add,
> > +     /* bridge */
> > +     .port_pre_bridge_flags  =3D yt921x_dsa_port_pre_bridge_flags,
> > +     .port_bridge_flags      =3D yt921x_dsa_port_bridge_flags,
> > +     .port_bridge_leave      =3D yt921x_dsa_port_bridge_leave,
> > +     .port_bridge_join       =3D yt921x_dsa_port_bridge_join,
> > +     /* fdb */
> > +     .port_fdb_dump          =3D yt921x_dsa_port_fdb_dump,
> > +     .port_fast_age          =3D yt921x_dsa_port_fast_age,
> > +     .port_vlan_fast_age     =3D yt921x_dsa_port_vlan_fast_age,
> > +     .set_ageing_time        =3D yt921x_dsa_set_ageing_time,
> > +     .port_fdb_del           =3D yt921x_dsa_port_fdb_del,
> > +     .port_fdb_add           =3D yt921x_dsa_port_fdb_add,
> > +     .port_mdb_del           =3D yt921x_dsa_port_mdb_del,
> > +     .port_mdb_add           =3D yt921x_dsa_port_mdb_add,
> > +     /* port */
> > +     .get_tag_protocol       =3D yt921x_dsa_get_tag_protocol,
> > +     .phylink_get_caps       =3D yt921x_dsa_phylink_get_caps,
> > +     .port_setup             =3D yt921x_dsa_port_setup,
> > +     /* chip */
> > +     .get_eeprom_len         =3D yt921x_dsa_get_eeprom_len,
> > +     .get_eeprom             =3D yt921x_dsa_get_eeprom,
> > +     .preferred_default_local_cpu_port       =3D yt921x_dsa_preferred_=
default_local_cpu_port,
> > +     .conduit_state_change   =3D yt921x_dsa_conduit_state_change,
> > +     .setup                  =3D yt921x_dsa_setup,
>
> No STP state handling?
>

Support for (M)STP was suggested for a future series in previous reviews.

> > +};
> > +
> > +/******** debug ********/
> > +
> > +static ssize_t
> > +reg_show(struct device *dev, struct device_attribute *attr, char *buf)
> > +{
> > +     struct yt921x_priv *priv =3D dev_get_drvdata(dev);
> > +
> > +     if (!priv->reg_valid)
> > +             return sprintf(buf, "0x%x: -\n", priv->reg_addr);
> > +
> > +     return sprintf(buf, "0x%x: 0x%08x\n", priv->reg_addr, priv->reg_v=
al);
> > +}
> > +
> > +/* Convenience sysfs attribute to read/write switch internal registers=
, since
> > + * user-space tools cannot gain exclusive access to the device, which =
is
> > + * required for any register operations.
> > + */
> > +static ssize_t
> > +reg_store(struct device *dev, struct device_attribute *attr,
> > +       const char *buf, size_t count)
>
> NACK for exposing a sysfs which allows user space to modify switch
> registers without the driver updating its internal state.
>
> For reading -- also not so sure. There are many higher-level debug
> interfaces which you should prefer implementing before resorting to raw
> register reads. If there's any latching register in hardware, user space
> can mess it up. What use case do you have?
>

It is not possible to debug the device without a register sysfs, see
previous replies for why we need to lock the bus (but not necessarily
the MDIO bus). And if they are to modify switch registers, that's what
they want.

So it's also kind of development leftover, but if anyone wants to
improve the driver, they would come up with pretty the same debug
solution as this, thus I consider it useful in the future. If that
effort is still not appreciated, it might be wrapped inside a #ifdef
DEBUG block so it will not be enabled to end users.

> > +{
> > +     struct yt921x_priv *priv =3D dev_get_drvdata(dev);
> > +     const char *end =3D buf + count;
> > +     const char *p =3D buf;
> > +     bool is_write;
> > +     u32 reg;
> > +     u32 val;
> > +     int res;
> > +
> > +     do {
> > +             unsigned long v;
> > +             char *e;
> > +
> > +             while (p < end && isspace(*p))
> > +                     p++;
> > +             if (p >=3D end)
> > +                     return -EINVAL;
> > +
> > +             v =3D simple_strntoul(p, &e, 0, end - p);
> > +             if (v >=3D YT921X_REG_END)
> > +                     return -EPERM;
> > +             reg =3D v;
> > +             is_write =3D false;
> > +
> > +             p =3D e;
> > +             if (p >=3D end)
> > +                     break;
> > +             if (!isspace(*p))
> > +                     return -EINVAL;
> > +
> > +             do
> > +                     p++;
> > +             while (p < end && isspace(*p));
> > +             if (p >=3D end)
> > +                     break;
> > +
> > +             v =3D simple_strntoul(p, &e, 0, end - p);
> > +             if ((u32)v !=3D v)
> > +                     return -EINVAL;
> > +             val =3D v;
> > +             is_write =3D true;
> > +
> > +             p =3D e;
> > +             if (p >=3D end)
> > +                     break;
> > +             if (!isspace(*p))
> > +                     return -EINVAL;
> > +     } while (0);
> > +
> > +     yt921x_smi_acquire(priv);
> > +     if (!is_write)
> > +             res =3D yt921x_smi_read(priv, reg, &val);
> > +     else
> > +             res =3D yt921x_smi_write(priv, reg, val);
> > +     yt921x_smi_release(priv);
> > +
> > +     if (res) {
> > +             dev_err(dev, "Cannot access register 0x%x: %i\n", reg, re=
s);
> > +             return -EIO;
> > +     }
> > +
> > +     priv->reg_addr =3D reg;
> > +     priv->reg_val =3D val;
> > +     priv->reg_valid =3D !is_write;
> > +
> > +     return count;
> > +}
> > +
> > +static DEVICE_ATTR_RW(reg);
> > +
> > +static struct attribute *yt921x_attrs[] =3D {
> > +     &dev_attr_reg.attr,
> > +     NULL,
> > +};
> > +
> > +ATTRIBUTE_GROUPS(yt921x);
> > +
> > +/******** device ********/
> > +
> > +static void yt921x_mdio_shutdown(struct mdio_device *mdiodev)
> > +{
> > +     struct device *dev =3D &mdiodev->dev;
> > +     struct yt921x_priv *priv =3D dev_get_drvdata(dev);
> > +     struct dsa_switch *ds =3D &priv->ds;
> > +
> > +     dsa_switch_shutdown(ds);
>
> This is an area where we don't want diverging implementations. Please
> test the dev_get_drvdata() for NULL here and in remove(), and return
> without doing anything, like the other DSA drivers. You can consult
> "git log" for the detailed context.
>
> > +}
> > +
> > +static void yt921x_mdio_remove(struct mdio_device *mdiodev)
> > +{
> > +     struct device *dev =3D &mdiodev->dev;
> > +     struct yt921x_priv *priv =3D dev_get_drvdata(dev);
> > +     struct dsa_switch *ds =3D &priv->ds;
> > +
> > +     dsa_unregister_switch(ds);
> > +}
> > +
> > +static int yt921x_mdio_probe(struct mdio_device *mdiodev)
> > +{
> > +     struct device *dev =3D &mdiodev->dev;
> > +     struct yt921x_smi_mdio *mdio;
> > +     struct yt921x_priv *priv;
> > +     struct dsa_switch *ds;
> > +
> > +     priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +     if (!priv)
> > +             return -ENOMEM;
> > +
> > +     mdio =3D devm_kzalloc(dev, sizeof(*mdio), GFP_KERNEL);
> > +     if (!mdio)
> > +             return -ENOMEM;
> > +
> > +     mdio->bus =3D mdiodev->bus;
> > +     mdio->addr =3D mdiodev->addr;
> > +     mdio->switchid =3D 0;
> > +
> > +     priv->smi_ops =3D &yt921x_smi_ops_mdio;
> > +     priv->smi_ctx =3D mdio;
> > +
> > +     ds =3D &priv->ds;
> > +     ds->dev =3D dev;
> > +     ds->configure_vlan_while_not_filtering =3D true;
>
> This is the default for configure_vlan_while_not_filtering, so please
> remove this assignment.
>
> > +     ds->assisted_learning_on_cpu_port =3D true;
> > +     ds->priv =3D priv;
> > +     ds->ops =3D &yt921x_dsa_switch_ops;
> > +     ds->phylink_mac_ops =3D &yt921x_phylink_mac_ops;
> > +     ds->num_ports =3D YT921X_PORT_NUM;
> > +
> > +     dev_set_drvdata(dev, priv);
> > +
> > +     return dsa_register_switch(ds);
> > +}

