Return-Path: <netdev+bounces-242105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37523C8C5F4
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 00:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A6984347729
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 23:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDE02E5407;
	Wed, 26 Nov 2025 23:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netstatz.com header.i=@netstatz.com header.b="QB1l9PfH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C2F4207A
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 23:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764200407; cv=none; b=UGcnVsH2IgF/1Z+lD9MknCJ90t99rmLSh9t7cYhwr18NgCYEdvNqooagdNKWH/8aKuwc8TuFtS4WVpbkOFtTOSlBXgSf5qFT0rj217lg7DFirLxtek2rfnlsiygmsuRk3U48CLE9j7OHLprBTBnsSyKaaRrnfE4m8THmRmKN7YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764200407; c=relaxed/simple;
	bh=Q9b3OcodIomfme9T2BX+BiciLaT51ycgl9p/7LKVqXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XAa2seuJdNvqPQ+nz3O3yZExa7hMgtlYmRA/nl3IlUJMhjk+eGGeWtTNEvtqowkqGtKXFEuS68W0ewQdXzidOdlbhqXXO81atP6Z7zyq80IHyxs3/X+nu77x81C58wCsEqXOqMGmHYd9PunrrVPOLx3QTsXrL29QWsiMzMdYNgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netstatz.com; spf=pass smtp.mailfrom=netstatz.com; dkim=pass (2048-bit key) header.d=netstatz.com header.i=@netstatz.com header.b=QB1l9PfH; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netstatz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netstatz.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-37b8aa5adf9so2833941fa.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 15:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netstatz.com; s=google; t=1764200402; x=1764805202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HsiDPjrgN14J/5W6liFnWIpbc9ddZhq61KZPmLktPc=;
        b=QB1l9PfH8n66gnKUyUeDARkO/myHgRGaH7i+cPRhFemHe1RZCWqIgNyJ5hxOBkqIPL
         nARJoGn2s5dSsDNoECTESVX+H985ZsyYqaca+khQBsCLwCEZb/sWMTIT6PIWNYS98Dpq
         p8UBymbZWcsDlBqfvawNlqz9Hb0SsyUyKegJFvF/HEEiB8iqU6iYQhqDDw0VeSNDOfb4
         OZI7NKpAIdVDiME/Ij6KrVnuPiGTZmUKnC59HIZ77Ki3z1SgbiJR9T+S6OtAG/hipiaW
         +u47YW0ReDpWDwVcMFoGweBBhrvRw/AuFB4rO9gh51fqL2vWlIA+ALdKMTaTPiqKXsJ9
         rZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764200402; x=1764805202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6HsiDPjrgN14J/5W6liFnWIpbc9ddZhq61KZPmLktPc=;
        b=KUX0l2OKkJIs8imMkXDeeglIQX8xDx4dmWPx7f2xDVCok5JnPlleYJb6bAwrN6wjci
         d1Zu53WiLsPxpzPDk++tWfI0UoEslh9O1050xUDNFUhw1gyzJtl/x595uNShDVRKqhsl
         JF5szkSqnwCUOMu3K/8yiD0XUuZ8qaeb9W4QHwyD1BGe6KJ9hheJzR0JhZGKWQQgr7IT
         gWdVxgmGoInRITqo5AE9MobFNL2FUOKK/Lh2faBCJCmVqbugERq18Rm/KvQ98hkz+vrJ
         WhEalLLEFB/rpPkjbziI4IJb49/VD9ACE8Reobw3k6moaPAx9ovxPOR5BPXNW6BhlNUd
         TFdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVQeTXOABqzDHxdIuz6kufwbsjTDw1l4YLJUGbWsN0rAD/wy5SicYsxz0WcJB/3m6Tz3QcVuA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ZThR6+SP0zcGCGFc1J49er2EI/Fk+slD2hk2TMLzRyX7yF9L
	vzNSs4bq2N1vBmGzHNs1nf9iyYOIUWPXN0o3mRUB7TYtCzfCZAWXvEXzyUlVOT24TEFagW+y7Ro
	3HDtC6rjRZ3rQjFF4lh2sACq+k69H1ZQu3e937UF0TA==
X-Gm-Gg: ASbGncs5yUCz4oNTKzU2Ajk9Le/fmGQRaUWcRXEw4TziBcFK/2tm9an84QzzpAOzlCp
	JqnhhWDw41blqe5U8343dI5CNngNqSRPpZdzHoS/kYArBwHGwQw86KDspO85mqYLFBs8aV7r7nZ
	obDJyF3Fxzy+lleUDLKFQ9wEIyjiHsBQ1ZLy2ADUa+GWWSaEsY0tcJQXtH8CUKpH2rDNMYBLRHV
	UuJR9dkYjrbD1RGFMcI+sIQnw5msheBpY+lV1api49hmuzmPOVCLxJ+kZZmhygpcLdqHo6RHg==
X-Google-Smtp-Source: AGHT+IFOW548tjwqKM7+P1cVIngqKY2IkbW0/vTEKXtw5Ft0BmrtgAVjBrcoCWA6b+cj2DagcfMozSwkJk1zYWAauxc=
X-Received: by 2002:a05:6512:e9c:b0:594:253c:209a with SMTP id
 2adb3069b0e04-596b505fc67mr3292989e87.14.1764200401751; Wed, 26 Nov 2025
 15:40:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJzfF9N4Hak23sc-zh0jMobbkjK7rg4odhic1DQ1cC+=MoQoA@mail.gmail.com>
 <20251121060825.GR2912318@black.igk.intel.com> <CAFJzfF8aQ8KsOXTg6oaOa_Zayx=bPZtsat2h_osn8r4wyT2wOw@mail.gmail.com>
In-Reply-To: <CAFJzfF8aQ8KsOXTg6oaOa_Zayx=bPZtsat2h_osn8r4wyT2wOw@mail.gmail.com>
From: Ian MacDonald <ian@netstatz.com>
Date: Wed, 26 Nov 2025 18:39:50 -0500
X-Gm-Features: AWmQ_bmrsef0ydaSgxMjMojYjheaLX-6oldNTNe7BaMZeMij6ubDQrsedS8jGt4
Message-ID: <CAFJzfF9UxBkvDkuSOG2AVd_mr3mkJ9yMa3D0s6rFvFdiMDKvPA@mail.gmail.com>
Subject: Re: net: thunderbolt: missing ndo_set_mac_address breaks 802.3ad bonding
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mika Westerberg <westeri@kernel.org>, Yehezkel Bernat <YehezkelShB@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 1121032@bugs.debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mika,

Following up on the previous discussion, your patch enabling MAC address
changes allowed bonding to enslave thunderbolt_net devices, but 802.3ad
still could not form an aggregator because the driver does not report
link speed or duplex via ethtool. Bonding logs:

    bond0: (slave thunderbolt0): failed to get link speed/duplex

Bonding (802.3ad) requires non-zero speed/duplex values for LACP port
key calculation.

The patch below adds a minimal get_link_ksettings() implementation and
registers ethtool_ops. It reports a fixed 10Gbps full-duplex link,
which is sufficient for LACP and seems consistent with ThunderboltIP
host-to-host bandwidth with the USB4v1/TB3 hardware I am using.

With this change, 802.3ad bonding comes up correctly on my USB4/TB
host-to-host setup. I also added link mode bitmaps, though they are not
strictly required for LACP/802.3ad.

Signed-off-by: Ian MacDonald <ian@netstatz.com>

---
 drivers/net/thunderbolt/main.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.=
c
index 4f4694db6..b9e276693 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -15,6 +15,7 @@
 #include <linux/jhash.h>
 #include <linux/module.h>
 #include <linux/etherdevice.h>
+#include <linux/ethtool.h>
 #include <linux/rtnetlink.h>
 #include <linux/sizes.h>
 #include <linux/thunderbolt.h>
@@ -1257,6 +1258,28 @@ static void tbnet_get_stats64(struct net_device *dev=
,
  stats->rx_missed_errors =3D net->stats.rx_missed_errors;
 }

+static int tbnet_get_link_ksettings(struct net_device *dev,
+     struct ethtool_link_ksettings *cmd)
+{
+ /* ThunderboltIP is a software-only full-duplex network tunnel.
+ * We report fixed link settings to satisfy bonding (802.3ad)
+ * requirements for LACP port key calculation. Speed is set to
+ * 10Gbps as a conservative baseline.
+ */
+ ethtool_link_ksettings_zero_link_mode(cmd, supported);
+ ethtool_link_ksettings_add_link_mode(cmd, supported, 10000baseT_Full);
+
+ ethtool_link_ksettings_zero_link_mode(cmd, advertising);
+ ethtool_link_ksettings_add_link_mode(cmd, advertising, 10000baseT_Full);
+
+ cmd->base.speed =3D SPEED_10000;
+ cmd->base.duplex =3D DUPLEX_FULL;
+ cmd->base.autoneg =3D AUTONEG_DISABLE;
+ cmd->base.port =3D PORT_NONE;
+
+ return 0;
+}
+
 static const struct net_device_ops tbnet_netdev_ops =3D {
  .ndo_open =3D tbnet_open,
  .ndo_stop =3D tbnet_stop,
@@ -1265,6 +1288,10 @@ static const struct net_device_ops tbnet_netdev_ops =
=3D {
  .ndo_get_stats64 =3D tbnet_get_stats64,
 };

+static const struct ethtool_ops tbnet_ethtool_ops =3D {
+ .get_link_ksettings =3D tbnet_get_link_ksettings,
+};
+
 static void tbnet_generate_mac(struct net_device *dev)
 {
  const struct tbnet *net =3D netdev_priv(dev);
@@ -1315,6 +1342,7 @@ static int tbnet_probe(struct tb_service *svc,
const struct tb_service_id *id)

  strcpy(dev->name, "thunderbolt%d");
  dev->netdev_ops =3D &tbnet_netdev_ops;
+ dev->ethtool_ops =3D &tbnet_ethtool_ops;

  /* ThunderboltIP takes advantage of TSO packets but instead of
  * segmenting them we just split the packet into Thunderbolt
--=20
2.47.3



> On Fri, Nov 21, 2025 at 3:11=E2=80=AFAM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > The below allows me to change it using "ip link set" command. I wonder =
if
> > you could try it with the bonding case and see it that makes any
> > difference?
> >
> > diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/m=
ain.c
> > index dcaa62377808..57b226afeb84 100644
> > --- a/drivers/net/thunderbolt/main.c
> > +++ b/drivers/net/thunderbolt/main.c
> > @@ -1261,6 +1261,7 @@ static const struct net_device_ops tbnet_netdev_o=
ps =3D {
> >         .ndo_open =3D tbnet_open,
> >         .ndo_stop =3D tbnet_stop,
> >         .ndo_start_xmit =3D tbnet_start_xmit,
> > +       .ndo_set_mac_address =3D eth_mac_addr,
> >         .ndo_get_stats64 =3D tbnet_get_stats64,
> >  };
> >
> > @@ -1281,6 +1282,9 @@ static void tbnet_generate_mac(struct net_device =
*dev)
> >         hash =3D jhash2((u32 *)xd->local_uuid, 4, hash);
> >         addr[5] =3D hash & 0xff;
> >         eth_hw_addr_set(dev, addr);
> > +
> > +       /* Allow changing it if needed */
> > +       dev->priv_flags |=3D IFF_LIVE_ADDR_CHANGE;
> >  }
> >
> >  static int tbnet_probe(struct tb_service *svc, const struct tb_service=
_id *id)

Basic testing below on Debian with kernel 6.17.8 shows aggregate
speeds within the expected range.

- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID][Role] Interval           Transfer     Bitrate         Retr
[  5][TX-C]   0.00-10.07  sec  5.58 GBytes  4.76 Gbits/sec    0
    sender
[  5][TX-C]   0.00-10.07  sec  5.58 GBytes  4.76 Gbits/sec
     receiver
[  7][TX-C]   0.00-10.07  sec  5.58 GBytes  4.76 Gbits/sec    0
    sender
[  7][TX-C]   0.00-10.07  sec  5.58 GBytes  4.76 Gbits/sec
     receiver
[  9][TX-C]   0.00-10.07  sec  5.59 GBytes  4.77 Gbits/sec    0
    sender
[  9][TX-C]   0.00-10.07  sec  5.59 GBytes  4.77 Gbits/sec
     receiver
[ 11][TX-C]   0.00-10.07  sec  5.59 GBytes  4.77 Gbits/sec    0
    sender
[ 11][TX-C]   0.00-10.07  sec  5.59 GBytes  4.77 Gbits/sec
     receiver
[SUM][TX-C]   0.00-10.07  sec  22.3 GBytes  19.1 Gbits/sec    0
     sender
[SUM][TX-C]   0.00-10.07  sec  22.3 GBytes  19.1 Gbits/sec
     receiver
[ 13][RX-C]   0.00-10.07  sec  3.72 GBytes  3.18 Gbits/sec    1
    sender
[ 13][RX-C]   0.00-10.07  sec  3.72 GBytes  3.17 Gbits/sec
     receiver
[ 15][RX-C]   0.00-10.07  sec  11.1 GBytes  9.50 Gbits/sec    4
    sender
[ 15][RX-C]   0.00-10.07  sec  11.1 GBytes  9.50 Gbits/sec
     receiver
[ 17][RX-C]   0.00-10.07  sec  3.72 GBytes  3.18 Gbits/sec    1
    sender
[ 17][RX-C]   0.00-10.07  sec  3.72 GBytes  3.17 Gbits/sec
     receiver
[ 19][RX-C]   0.00-10.07  sec  3.73 GBytes  3.18 Gbits/sec    1
    sender
[ 19][RX-C]   0.00-10.07  sec  3.73 GBytes  3.18 Gbits/sec
     receiver
[SUM][RX-C]   0.00-10.07  sec  22.3 GBytes  19.0 Gbits/sec    7
     sender
[SUM][RX-C]   0.00-10.07  sec  22.3 GBytes  19.0 Gbits/sec
     receiver

iperf Done.
ai2:~# iperf3 --bidir -c 10.10.13.1 -P 4 -t 10

ai2:~# networkctl status bond0
=E2=97=8F 3: bond0
                 NetDev File: /etc/systemd/network/50-bond0.netdev
                   Link File: /usr/lib/systemd/network/99-default.link
                Network File: /etc/systemd/network/53-bond0.network
                       State: routable (configured)
                Online state: online
                        Type: bond
                        Kind: bond
                      Driver: bonding
            Hardware Address: 82:36:12:ad:a1:c0
                         MTU: 1500 (min: 68, max: 65535)
                       QDisc: noqueue
IPv6 Address Generation Mode: eui64
                        Mode: 802.3ad
                      Miimon: 500ms
                     Updelay: 0
                   Downdelay: 0
    Number of Queues (Tx/Rx): 16/16
            Auto negotiation: no
                       Speed: 20Gbps
                      Duplex: full
                     Address: 10.10.13.2
                              fe80::8036:12ff:fead:a1c0
           Activation Policy: up
         Required For Online: yes
          DHCPv6 Client DUID: DUID-EN/Vendor:0000ab111c6e5c59896f0172

Nov 26 22:46:11 ai2 systemd-networkd[641]: bond0: netdev ready
Nov 26 22:46:11 ai2 systemd-networkd[641]: bond0: Configuring with
/etc/systemd/network/53-bond0.network.
Nov 26 22:46:11 ai2 systemd-networkd[641]: bond0: Link UP
Nov 26 17:46:52 ai2 systemd-networkd[641]: bond0: Gained carrier
Nov 26 17:46:53 ai2 systemd-networkd[641]: bond0: Gained IPv6LL

ai2:~# ethtool thunderbolt0
Settings for thunderbolt0:
Supported ports: [  ]
Supported link modes:   10000baseT/Full
Supported pause frame use: No
Supports auto-negotiation: No
Supported FEC modes: Not reported
Advertised link modes:  10000baseT/Full
Advertised pause frame use: No
Advertised auto-negotiation: No
Advertised FEC modes: Not reported
Speed: 10000Mb/s
Duplex: Full
Auto-negotiation: off
Port: None
PHYAD: 0
Transceiver: internal

