Return-Path: <netdev+bounces-121053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C8195B82A
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 16:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68CF281648
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 14:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF38F1C93DF;
	Thu, 22 Aug 2024 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyICycbx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76951EB5B;
	Thu, 22 Aug 2024 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724336392; cv=none; b=YGBZ9Yst5I6b5J9x5HVr68qSbi1oCIt6EUY/6BVKwZAV1sNciQ+eFiN+mi79x8ni1LqiwvlpuixZPKdYrZ0X62S21LONZM1UaIqBfWSoaNgbplxQAdoOkewmXN+xx7A4uichSwprJr6JfeD64+aMt02WwL1CSh1mnp684mqJv1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724336392; c=relaxed/simple;
	bh=nu70M4Tk8dgT7/n3RmX83JpbuBVn5SHffxATT8oiPRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nLIjdq7IcOVn3MeM4Wo+sg3aEL1SWee+KbXaFnFP7qDrKQ+I1TfhQiuTa9qaLBnhAY3I4dHGF1fasZ7b4WxnG/ZWISGUwwGL4MYY4PkXba4spoSpJi4B2e1TZf6X/9wEX63ivhhXFuwR2LY2ieAGX0sUk8zAwSlWwekTG7iIrJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyICycbx; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e13c23dbabdso840726276.3;
        Thu, 22 Aug 2024 07:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724336389; x=1724941189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDqczWv8dyK1hQrKrgW75fShWZ03/vp6rp/2WR6QUIY=;
        b=CyICycbxXfptEOJ1nmFy73gxzHi67f4DQ9CS4z5GNJPBDy5nNOZky+Wz7iT2UT2d7P
         nolHZr8gr54mvF08mX0bicqXnuUv1CpQGr0Lyv3LzLMpYc85PWdm9CHE5nvwRz0wClfJ
         97HePnJeYTHr4yAbIj9z/CSY1dZLMEASPaLkS546kA/0Id2+5zZuVsEv+xdG5RY6RKZa
         tiaIYbxXoLj5ub62lnUet8l3xiLcmGfrvCjUaWkbUN+D/JHLXxnsr9IsBMNT1EFQTU+E
         cEJFW2br70h1NnnzFzuITdgbzvBypQK+bIqWTPlztHme8H6ecPGbZmb/fSC/ZVQJIwVX
         aklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724336389; x=1724941189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDqczWv8dyK1hQrKrgW75fShWZ03/vp6rp/2WR6QUIY=;
        b=cJY3vg5HiQC91NTSwAbU+CVXGUGPRmk1ZjhjpN8gMFf5kiINykpS2GHBxbnpjmP7rr
         4UiuJaUNMnyM084kM/jFW9h2I1kN92wtfJ/HVyzV3aFXGAilxX5Lto00i0KkFIIH9eLi
         PoLQ3N5Tc5hvJ3OwbTZrkdZ4uK3bO5ud1pAAyfQJfBeyaMWuInWcALDiXkjWjWlRqOGO
         Zt7oDGAMBVG0tJEUOv7Zv/qa4wzKqL6PHXJH3ayeKS/c0QhSWaBK3HMjH0joLfjJP0Wj
         xqdm42xC05QMpy0JMfLq6+hcAHbCfEBnMwj9PT7UhYuWWLpospn4lwnM/f2LX/b7Ok0z
         3Ojw==
X-Forwarded-Encrypted: i=1; AJvYcCXkknSxjxU49owWP/r7p1YCWkG6l0fjmby6EKL4UKtfAXPfhhkfyrxEy1xPgGH30w/OreZaI6CeFF1fDLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyta6yUsqP/+YOHvoyEKB8i3POKi1o1xso1pJXvyifpunTzuLBv
	YN6X/sRw4CTBUb58VlDUJXaVrNo6HcjZKSFdLTHmS1KfGSo4+U18RypguK/FX0/i0zndT4TofxO
	0yaGT8sE5Y+S5d2znDvgmIfoWSVo=
X-Google-Smtp-Source: AGHT+IHznSytjbXKT/MSZ7NJW+NvtFNa5LRir3CMydeVa4XdmGj4ET806XF6O1yxW1duKsxMaT+PUR9JLbwK2uLGhTY=
X-Received: by 2002:a05:6902:993:b0:e0b:cc1d:3731 with SMTP id
 3f1490d57ef6-e17902b1e46mr2811186276.2.1724336389339; Thu, 22 Aug 2024
 07:19:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240811195649.2360966-1-paweldembicki@gmail.com> <20240813113405.a65caznayd2tsx2v@skbuf>
In-Reply-To: <20240813113405.a65caznayd2tsx2v@skbuf>
From: =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Date: Thu, 22 Aug 2024 16:19:38 +0200
Message-ID: <CAJN1Kkw=fnYpqL79cEPOYG9_zQVE+HDvYP1GoK4UkprmJ5qy7w@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dsa: vsc73xx: implement FDB operations
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

wt., 13 sie 2024 o 13:34 Vladimir Oltean <olteanv@gmail.com> napisa=C5=82(a=
):
>
> On Sun, Aug 11, 2024 at 09:56:49PM +0200, Pawel Dembicki wrote:
> > This commit introduces implementations of three functions:
> > .port_fdb_dump
> > .port_fdb_add
> > .port_fdb_del
> >
> > The FDB database organization is the same as in other old Vitesse chips=
:
> > It has 2048 rows and 4 columns (buckets). The row index is calculated b=
y
> > the hash function 'vsc73xx_calc_hash' and the FDB entry must be placed
> > exactly into row[hash]. The chip selects the row number by itself.
>
> You mean "selects the bucket" maybe?
>
> >
> > Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> > ---
> >  drivers/net/dsa/vitesse-vsc73xx-core.c | 302 +++++++++++++++++++++++++
> >  drivers/net/dsa/vitesse-vsc73xx.h      |   2 +
> >  2 files changed, 304 insertions(+)
> >
> > diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/v=
itesse-vsc73xx-core.c
> > index a82b550a9e40..7da1641b8bab 100644
> > --- a/drivers/net/dsa/vitesse-vsc73xx-core.c
> > +++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
> > @@ -46,6 +46,8 @@
> >  #define VSC73XX_BLOCK_MII_EXTERNAL   0x1 /* External MDIO subblock */
> >
> >  #define CPU_PORT     6 /* CPU port */
> > +#define VSC73XX_NUM_FDB_RECORDS      2048
>
> Terminology issue perhaps, but do you call a "record" as something that
> holds 1 FDB entry, or 4? There should be 2048 * 4 records, and 2048 "rows=
"?
>
> There's also vsc73xx_port_read_mac_table_entry(), which calls an FDB
> "entry" an array of 4 addresses. Do you have a consistent name for a
> switch data structure that holds a single address?
>
> > +#define VSC73XX_NUM_BUCKETS  4
> >
> >  /* MAC Block registers */
> >  #define VSC73XX_MAC_CFG              0x00
> > @@ -197,6 +199,21 @@
> >  #define VSC73XX_SRCMASKS_MIRROR                      BIT(26)
> >  #define VSC73XX_SRCMASKS_PORTS_MASK          GENMASK(7, 0)
> >
> > +#define VSC73XX_MACHDATA_VID                 GENMASK(27, 16)
> > +#define VSC73XX_MACHDATA_VID_SHIFT           16
> > +#define VSC73XX_MACHDATA_MAC0_SHIFT          8
> > +#define VSC73XX_MACHDATA_MAC1_SHIFT          0
> > +#define VSC73XX_MACLDATA_MAC2_SHIFT          24
> > +#define VSC73XX_MACLDATA_MAC3_SHIFT          16
> > +#define VSC73XX_MACLDATA_MAC4_SHIFT          8
> > +#define VSC73XX_MACLDATA_MAC5_SHIFT          0
> > +#define VSC73XX_MAC_BYTE_MASK                        GENMASK(7, 0)
> > +
> > +#define VSC73XX_MACTINDX_SHADOW                      BIT(13)
> > +#define VSC73XX_MACTINDX_BUCKET_MASK         GENMASK(12, 11)
> > +#define VSC73XX_MACTINDX_BUCKET_MASK_SHIFT   11
> > +#define VSC73XX_MACTINDX_INDEX_MASK          GENMASK(10, 0)
> > +
> >  #define VSC73XX_MACACCESS_CPU_COPY           BIT(14)
> >  #define VSC73XX_MACACCESS_FWD_KILL           BIT(13)
> >  #define VSC73XX_MACACCESS_IGNORE_VLAN                BIT(12)
> > @@ -204,6 +221,7 @@
> >  #define VSC73XX_MACACCESS_VALID                      BIT(10)
> >  #define VSC73XX_MACACCESS_LOCKED             BIT(9)
> >  #define VSC73XX_MACACCESS_DEST_IDX_MASK              GENMASK(8, 3)
> > +#define VSC73XX_MACACCESS_DEST_IDX_MASK_SHIFT        3
> >  #define VSC73XX_MACACCESS_CMD_MASK           GENMASK(2, 0)
> >  #define VSC73XX_MACACCESS_CMD_IDLE           0
> >  #define VSC73XX_MACACCESS_CMD_LEARN          1
> > @@ -329,6 +347,13 @@ struct vsc73xx_counter {
> >       const char *name;
> >  };
> >
> > +struct vsc73xx_fdb {
> > +     u16 vid;
> > +     u8 port;
> > +     u8 mac[6];
>
> u8 mac[ETH_ALEN]
>
> > +     bool valid;
> > +};
> > +
> >  /* Counters are named according to the MIB standards where applicable.
> >   * Some counters are custom, non-standard. The standard counters are
> >   * named in accordance with RFC2819, RFC2021 and IEEE Std 802.3-2002 A=
nnex
> > @@ -1829,6 +1854,278 @@ static void vsc73xx_port_stp_state_set(struct d=
sa_switch *ds, int port,
> >               vsc73xx_refresh_fwd_map(ds, port, state);
> >  }
> >
> > +static u16 vsc73xx_calc_hash(const unsigned char *addr, u16 vid)
> > +{
> > +     /* VID 5-0, MAC 47-44 */
> > +     u16 hash =3D ((vid & GENMASK(5, 0)) << 4) | (addr[0] >> 4);
> > +
> > +     /* MAC 43-33 */
> > +     hash ^=3D ((addr[0] & GENMASK(3, 0)) << 7) | (addr[1] >> 1);
> > +     /* MAC 32-22 */
> > +     hash ^=3D ((addr[1] & BIT(0)) << 10) | (addr[2] << 2) | (addr[3] =
>> 6);
> > +     /* MAC 21-11 */
> > +     hash ^=3D ((addr[3] & GENMASK(5, 0)) << 5) | (addr[4] >> 3);
> > +     /* MAC 10-0 */
> > +     hash ^=3D ((addr[4] & GENMASK(2, 0)) << 8) | addr[5];
> > +
> > +     return hash;
> > +}
> > +
> > +static int
> > +vsc73xx_port_wait_for_mac_table_cmd(struct vsc73xx *vsc)
> > +{
> > +     int ret, err;
> > +     u32 val;
> > +
> > +     ret =3D read_poll_timeout(vsc73xx_read, err,
> > +                             err < 0 ||
> > +                             ((val & VSC73XX_MACACCESS_CMD_MASK) =3D=
=3D
> > +                              VSC73XX_MACACCESS_CMD_IDLE),
> > +                             VSC73XX_POLL_SLEEP_US, VSC73XX_POLL_TIMEO=
UT_US,
> > +                             false, vsc, VSC73XX_BLOCK_ANALYZER,
> > +                             0, VSC73XX_MACACCESS, &val);
> > +     if (ret)
> > +             return ret;
> > +     return err;
> > +}
> > +
> > +static int vsc73xx_port_read_mac_table_entry(struct vsc73xx *vsc, u16 =
index,
> > +                                          struct vsc73xx_fdb *fdb)
> > +{
> > +     int ret, i;
> > +     u32 val;
> > +
> > +     if (!fdb)
> > +             return -EINVAL;
> > +     if (index >=3D VSC73XX_NUM_FDB_RECORDS)
> > +             return -EINVAL;
> > +
> > +     for (i =3D 0; i < VSC73XX_NUM_BUCKETS; i++) {
> > +             vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_MAC=
TINDX,
> > +                           (i ? 0 : VSC73XX_MACTINDX_SHADOW) |
> > +                           i << VSC73XX_MACTINDX_BUCKET_MASK_SHIFT |
> > +                           index);
>
> Could you check for error codes from vsc73xx_read() and vsc73xx_write()
> as well? This is applicable to the entire patch.
>
> > +             ret =3D vsc73xx_port_wait_for_mac_table_cmd(vsc);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> > +                                 VSC73XX_MACACCESS,
> > +                                 VSC73XX_MACACCESS_CMD_MASK,
> > +                                 VSC73XX_MACACCESS_CMD_READ_ENTRY);
> > +             ret =3D vsc73xx_port_wait_for_mac_table_cmd(vsc);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             vsc73xx_read(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_MACA=
CCESS,
> > +                          &val);
> > +             fdb[i].valid =3D val & VSC73XX_MACACCESS_VALID;
> > +             if (!fdb[i].valid)
> > +                     continue;
> > +
> > +             fdb[i].port =3D (val & VSC73XX_MACACCESS_DEST_IDX_MASK) >=
>
> > +                           VSC73XX_MACACCESS_DEST_IDX_MASK_SHIFT;
> > +
> > +             vsc73xx_read(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_MACH=
DATA,
> > +                          &val);
> > +             fdb[i].vid =3D (val & VSC73XX_MACHDATA_VID) >>
> > +                          VSC73XX_MACHDATA_VID_SHIFT;
> > +             fdb[i].mac[0] =3D (val >> VSC73XX_MACHDATA_MAC0_SHIFT) &
> > +                             VSC73XX_MAC_BYTE_MASK;
> > +             fdb[i].mac[1] =3D (val >> VSC73XX_MACHDATA_MAC1_SHIFT) &
> > +                             VSC73XX_MAC_BYTE_MASK;
> > +
> > +             vsc73xx_read(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_MACL=
DATA,
> > +                          &val);
> > +             fdb[i].mac[2] =3D (val >> VSC73XX_MACLDATA_MAC2_SHIFT) &
> > +                             VSC73XX_MAC_BYTE_MASK;
> > +             fdb[i].mac[3] =3D (val >> VSC73XX_MACLDATA_MAC3_SHIFT) &
> > +                             VSC73XX_MAC_BYTE_MASK;
> > +             fdb[i].mac[4] =3D (val >> VSC73XX_MACLDATA_MAC4_SHIFT) &
> > +                             VSC73XX_MAC_BYTE_MASK;
> > +             fdb[i].mac[5] =3D (val >> VSC73XX_MACLDATA_MAC5_SHIFT) &
> > +                             VSC73XX_MAC_BYTE_MASK;
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +static void
> > +vsc73xx_fdb_insert_mac(struct vsc73xx *vsc, const unsigned char *addr,=
 u16 vid)
> > +{
> > +     u32 val;
> > +
> > +     val =3D (vid << VSC73XX_MACHDATA_VID_SHIFT) & VSC73XX_MACHDATA_VI=
D;
> > +     val |=3D (addr[0] << VSC73XX_MACHDATA_MAC0_SHIFT);
> > +     val |=3D (addr[1] << VSC73XX_MACHDATA_MAC1_SHIFT);
> > +     vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_MACHDATA, v=
al);
> > +
> > +     val =3D (addr[2] << VSC73XX_MACLDATA_MAC2_SHIFT);
> > +     val |=3D (addr[3] << VSC73XX_MACLDATA_MAC3_SHIFT);
> > +     val |=3D (addr[4] << VSC73XX_MACLDATA_MAC4_SHIFT);
> > +     val |=3D (addr[5] << VSC73XX_MACLDATA_MAC5_SHIFT);
> > +     vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_MACLDATA, v=
al);
> > +}
> > +
> > +static int vsc73xx_fdb_del_entry(struct vsc73xx *vsc, int port,
> > +                              const unsigned char *addr, u16 vid)
> > +{
> > +     struct vsc73xx_fdb fdb[VSC73XX_NUM_BUCKETS];
> > +     u16 hash =3D vsc73xx_calc_hash(addr, vid);
> > +     int bucket, ret;
> > +
> > +     mutex_lock(&vsc->fdb_lock);
> > +
> > +     ret =3D vsc73xx_port_read_mac_table_entry(vsc, hash, fdb);
> > +     if (ret)
> > +             goto err;
> > +
> > +     for (bucket =3D 0; bucket < VSC73XX_NUM_BUCKETS; bucket++) {
> > +             if (fdb[bucket].valid && fdb[bucket].port =3D=3D port &&
> > +                 !memcmp(addr, fdb[bucket].mac, ETH_ALEN))
>
> ether_addr_equal()
>
> > +                     break;
> > +     }
> > +
> > +     if (bucket =3D=3D VSC73XX_NUM_BUCKETS) {
> > +             /* Can't find MAC in MAC table */
> > +             ret =3D -ENODATA;
> > +             goto err;
> > +     }
> > +
> > +     vsc73xx_fdb_insert_mac(vsc, addr, vid);
> > +     vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_MACTINDX, h=
ash);
> > +
> > +     ret =3D vsc73xx_port_wait_for_mac_table_cmd(vsc);
> > +     if (ret)
> > +             goto err;
> > +
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_MACAC=
CESS,
> > +                         VSC73XX_MACACCESS_CMD_MASK,
> > +                         VSC73XX_MACACCESS_CMD_FORGET);
> > +     ret =3D  vsc73xx_port_wait_for_mac_table_cmd(vsc);
> > +err:
> > +     mutex_unlock(&vsc->fdb_lock);
> > +     return ret;
> > +}
> > +
> > +static int vsc73xx_fdb_add_entry(struct vsc73xx *vsc, int port,
> > +                              const unsigned char *addr, u16 vid)
> > +{
> > +     struct vsc73xx_fdb fdb[VSC73XX_NUM_BUCKETS];
> > +     u16 hash =3D vsc73xx_calc_hash(addr, vid);
> > +     int bucket, ret;
> > +     u32 val;
> > +
> > +     mutex_lock(&vsc->fdb_lock);
> > +
> > +     vsc73xx_port_read_mac_table_entry(vsc, hash, fdb);
> > +
> > +     for (bucket =3D 0; bucket < VSC73XX_NUM_BUCKETS; bucket++) {
> > +             if (!fdb[bucket].valid)
> > +                     break;
> > +     }
> > +
> > +     if (bucket =3D=3D VSC73XX_NUM_BUCKETS) {
> > +             /* Bucket is full */
> > +             ret =3D -EOVERFLOW;
> > +             goto err;
> > +     }
> > +
> > +     vsc73xx_fdb_insert_mac(vsc, addr, vid);
> > +
> > +     vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_MACTINDX, h=
ash);
> > +     ret =3D vsc73xx_port_wait_for_mac_table_cmd(vsc);
> > +     if (ret)
> > +             goto err;
> > +
> > +     val =3D (port << VSC73XX_MACACCESS_DEST_IDX_MASK_SHIFT) &
> > +           VSC73XX_MACACCESS_DEST_IDX_MASK;
> > +
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> > +                         VSC73XX_MACACCESS,
> > +                         VSC73XX_MACACCESS_VALID |
> > +                         VSC73XX_MACACCESS_CMD_MASK |
> > +                         VSC73XX_MACACCESS_DEST_IDX_MASK |
> > +                         VSC73XX_MACACCESS_LOCKED,
> > +                         VSC73XX_MACACCESS_VALID |
> > +                         VSC73XX_MACACCESS_CMD_LEARN |
> > +                         VSC73XX_MACACCESS_LOCKED | val);
> > +     ret =3D vsc73xx_port_wait_for_mac_table_cmd(vsc);
> > +
> > +err:
> > +     mutex_unlock(&vsc->fdb_lock);
> > +     return ret;
> > +}
> > +
> > +static int vsc73xx_fdb_add(struct dsa_switch *ds, int port,
> > +                        const unsigned char *addr, u16 vid, struct dsa=
_db db)
> > +{
> > +     struct vsc73xx *vsc =3D ds->priv;
> > +
> > +     if (!vid) {
> > +             switch (db.type) {
> > +             case DSA_DB_PORT:
> > +                     vid =3D dsa_tag_8021q_standalone_vid(db.dp);
> > +                     break;
> > +             case DSA_DB_BRIDGE:
> > +                     vid =3D dsa_tag_8021q_bridge_vid(db.bridge.num);
>
> I appreciate the intention, but if you don't set ds->fdb_isolation
> (which you don't, although I believe the driver satisfies the documented
> requirements), db.bridge.num will always be passed as 0 in the
> .port_fdb_add() and .port_fdb_del() methods. Thus, dsa_tag_8021q_bridge_v=
id(0)
> will always be different than what dsa_tag_8021q_bridge_join() selects
> as VLAN-unaware bridge PVID for your ports. The FDB entry will be in a
> different VLAN than what your switch classifies the packets to. This
> means it won't match.
>
> Assuming this went through a reasonable round of testing (add bridge FDB
> entry towards expected port, make sure it isn't sent to others) and this
> issue was not noticed, then maybe the switch performs shared VLAN learnin=
g?
> Case in which, if you can't configure it to independent VLAN learning,
> it does not pass the ds->fdb_isolation requirements, plus the entire
> dance of picking a proper VID is pointless, as any chosen VID would have
> the same behavior.
>

ds->fdb_isolation was missed in this patch accidentally. Vsc73xx has
enabled independent learning by default.

> > +                     break;
> > +             default:
> > +                     return -EOPNOTSUPP;
> > +             }
> > +     }
> > +
> > +     return vsc73xx_fdb_add_entry(vsc, port, addr, vid);
> > +}
> > +
> > +static int vsc73xx_fdb_del(struct dsa_switch *ds, int port,
> > +                        const unsigned char *addr, u16 vid, struct dsa=
_db db)
> > +{
> > +     struct vsc73xx *vsc =3D ds->priv;
> > +
> > +     if (!vid) {
> > +             switch (db.type) {
> > +             case DSA_DB_PORT:
> > +                     vid =3D dsa_tag_8021q_standalone_vid(db.dp);
> > +                     break;
> > +             case DSA_DB_BRIDGE:
> > +                     vid =3D dsa_tag_8021q_bridge_vid(db.bridge.num);
> > +                     break;
> > +             default:
> > +                     return -EOPNOTSUPP;
> > +             }
> > +     }
> > +
> > +     return vsc73xx_fdb_del_entry(vsc, port, addr, vid);
> > +}
> > +
> > +static int vsc73xx_port_fdb_dump(struct dsa_switch *ds,
> > +                              int port, dsa_fdb_dump_cb_t *cb, void *d=
ata)
> > +{
> > +     struct vsc73xx_fdb fdb[VSC73XX_NUM_BUCKETS];
> > +     struct vsc73xx *vsc =3D ds->priv;
> > +     u16 i, bucket;
> > +
> > +     mutex_lock(&vsc->fdb_lock);
> > +
> > +     for (i =3D 0; i < VSC73XX_NUM_FDB_RECORDS; i++) {
> > +             vsc73xx_port_read_mac_table_entry(vsc, i, fdb);
> > +
> > +             for (bucket =3D 0; bucket < VSC73XX_NUM_BUCKETS; bucket++=
) {
> > +                     if (!fdb[bucket].valid || fdb[bucket].port !=3D p=
ort)
> > +                             continue;
> > +
> > +                     /* We need to hide dsa_8021q VLANs from the user =
*/
> > +                     if (vid_is_dsa_8021q(fdb[bucket].vid))
> > +                             fdb[bucket].vid =3D 0;
> > +                     cb(fdb[bucket].mac, fdb[bucket].vid, false, data)=
;
>
> "cb" is actually dsa_user_port_fdb_do_dump(). It can return -EMSGSIZE
> when the netlink skb is full, and it is very important that you
> propagate that to the caller:
>
>         err =3D cb();
>         if (err)
>                 goto unlock;
>
> otherwise, you might notice that large FDB dumps will have missing FDB en=
tries.
>
> > +             }
> > +     }
> > +
> > +     mutex_unlock(&vsc->fdb_lock);
> > +     return 0;
> > +}
> > +
> >  static const struct phylink_mac_ops vsc73xx_phylink_mac_ops =3D {
> >       .mac_config =3D vsc73xx_mac_config,
> >       .mac_link_down =3D vsc73xx_mac_link_down,
> > @@ -1851,6 +2148,9 @@ static const struct dsa_switch_ops vsc73xx_ds_ops=
 =3D {
> >       .port_bridge_join =3D dsa_tag_8021q_bridge_join,
> >       .port_bridge_leave =3D dsa_tag_8021q_bridge_leave,
> >       .port_change_mtu =3D vsc73xx_change_mtu,
> > +     .port_fdb_add =3D vsc73xx_fdb_add,
> > +     .port_fdb_del =3D vsc73xx_fdb_del,
> > +     .port_fdb_dump =3D vsc73xx_port_fdb_dump,
> >       .port_max_mtu =3D vsc73xx_get_max_mtu,
> >       .port_stp_state_set =3D vsc73xx_port_stp_state_set,
> >       .port_vlan_filtering =3D vsc73xx_port_vlan_filtering,
> > @@ -1981,6 +2281,8 @@ int vsc73xx_probe(struct vsc73xx *vsc)
> >               return -ENODEV;
> >       }
> >
> > +     mutex_init(&vsc->fdb_lock);
> > +
> >       eth_random_addr(vsc->addr);
> >       dev_info(vsc->dev,
> >                "MAC for control frames: %02X:%02X:%02X:%02X:%02X:%02X\n=
",
> > diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitess=
e-vsc73xx.h
> > index 3ca579acc798..a36ca607671e 100644
> > --- a/drivers/net/dsa/vitesse-vsc73xx.h
> > +++ b/drivers/net/dsa/vitesse-vsc73xx.h
> > @@ -45,6 +45,7 @@ struct vsc73xx_portinfo {
> >   * @vlans: List of configured vlans. Contains port mask and untagged s=
tatus of
> >   *   every vlan configured in port vlan operation. It doesn't cover ta=
g_8021q
> >   *   vlans.
> > + * @fdb_lock: Mutex protects fdb access
> >   */
> >  struct vsc73xx {
> >       struct device                   *dev;
> > @@ -57,6 +58,7 @@ struct vsc73xx {
> >       void                            *priv;
> >       struct vsc73xx_portinfo         portinfo[VSC73XX_MAX_NUM_PORTS];
> >       struct list_head                vlans;
> > +     struct mutex                    fdb_lock; /* protects fdb access =
*/
>
> Redundant comment since it's already in the kernel-doc?
>
> >  };
> >
> >  /**
> > --
> > 2.34.1
> >

