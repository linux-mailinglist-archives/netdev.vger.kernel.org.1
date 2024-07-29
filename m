Return-Path: <netdev+bounces-113606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A010C93F447
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 13:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE597B219BF
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 11:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B84A14533F;
	Mon, 29 Jul 2024 11:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="XWGQvg2w"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB21145B3B;
	Mon, 29 Jul 2024 11:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253171; cv=none; b=iKr2SoUSesLXLYLDhBovkNQmieAeDMSzHokB1r4c+zvj4PAxmHl92x2K9SPxVgTKpBW3nCY3sNdBthSTWSUeb9503xF+a0aQFsbXI/l+b3WTi5RCmAsU2tW+gYiiysv3aoXWht/D4NQYxvyX0WLyRNHlTafuCjDK6CiNjsva+4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253171; c=relaxed/simple;
	bh=uwMSRHQv4M1HsfaKWWnP6QSj4MiMrFSxDzgsURzOyHg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b0pyOrRsyFTiA7jRRHclCL59WsdXWKTtXX0NiO4iVeIbw7eRSIVmHnLwROE3ZUno+Yyjf1163SqWSgMlq+oPQrOmKFgnwUfYfKkeToyHPmkiaO0pQeTP7OAYj2qaXx9vE73JnL/C4WcKFKH7NQKJ6sN+1UJv/9Dmx+zbuQ/FLFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=XWGQvg2w; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46TBd4oB53920833, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722253144; bh=uwMSRHQv4M1HsfaKWWnP6QSj4MiMrFSxDzgsURzOyHg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=XWGQvg2wpYW99gXeqQiTUdFjavoXAgPpRVV65uLveP18ixtVPoo4iDh9x6IvqjcRE
	 A7xG7u0JvXRfipgvSb1iPjxW+8FUuKo5J9VH/tEsfsF/UmW0uZLsFfTOcd1Qc49ln2
	 nIhWUZYUqXMu1sDU86hAUpEX2IJ0PRI5RxDoBGUtYBE6vi/f8k6vVvgEScTHLFFWm7
	 DvtqStXSk/rmNXEnCI9QKrXIHyLwVv9sXLXYx6VgqhDCKA+LszT4qXeBE+k8cXW2bP
	 Y6bDlUu08c70t/TtI293Mu6OHLdQFv7RD9xKhU2bOXyDKfA3SjhV2HSwRNDA7Uguxq
	 JlWq52RjGPUCA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46TBd4oB53920833
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 19:39:04 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 19:39:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jul 2024 19:39:03 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 29 Jul 2024 19:39:03 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Joe Damato <jdamato@fastly.com>
CC: "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "horms@kernel.org" <horms@kernel.org>,
        "rkannoth@marvell.com" <rkannoth@marvell.com>,
        Ping-Ke Shih
	<pkshih@realtek.com>,
        Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v25 08/13] rtase: Implement net_device_ops
Thread-Topic: [PATCH net-next v25 08/13] rtase: Implement net_device_ops
Thread-Index: AQHa4YARnlUWdwvH+0WY0xFzPyuoM7IM+z0AgACXoYA=
Date: Mon, 29 Jul 2024 11:39:03 +0000
Message-ID: <f55076d3231f40dead386fe6d7de58c9@realtek.com>
References: <20240729062121.335080-1-justinlai0215@realtek.com>
 <20240729062121.335080-9-justinlai0215@realtek.com>
 <ZqdvAmRc3sBzDFYI@LQ3V64L9R2>
In-Reply-To: <ZqdvAmRc3sBzDFYI@LQ3V64L9R2>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

> On Mon, Jul 29, 2024 at 02:21:16PM +0800, Justin Lai wrote:
> > 1. Implement .ndo_set_rx_mode so that the device can change address
> > list filtering.
> > 2. Implement .ndo_set_mac_address so that mac address can be changed.
> > 3. Implement .ndo_change_mtu so that mtu can be changed.
> > 4. Implement .ndo_tx_timeout to perform related processing when the
> > transmitter does not make any progress.
> > 5. Implement .ndo_get_stats64 to provide statistics that are called
> > when the user wants to get network device usage.
> > 6. Implement .ndo_vlan_rx_add_vid to register VLAN ID when the device
> > supports VLAN filtering.
> > 7. Implement .ndo_vlan_rx_kill_vid to unregister VLAN ID when the
> > device supports VLAN filtering.
> > 8. Implement the .ndo_setup_tc to enable setting any "tc" scheduler,
> > classifier or action on dev.
> > 9. Implement .ndo_fix_features enables adjusting requested feature
> > flags based on device-specific constraints.
> > 10. Implement .ndo_set_features enables updating device configuration
> > to new features.
> >
> > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> > ---
> >  .../net/ethernet/realtek/rtase/rtase_main.c   | 235 ++++++++++++++++++
> >  1 file changed, 235 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > index 8fd69d96219f..80673fa1e9a3 100644
>=20
> [...]
>=20
> > +static void rtase_dump_state(const struct net_device *dev) {
>=20
> [...]
>=20
> > +
> > +     netdev_err(dev, "tx_packets %lld\n",
> > +                le64_to_cpu(counters->tx_packets));
> > +     netdev_err(dev, "rx_packets %lld\n",
> > +                le64_to_cpu(counters->rx_packets));
> > +     netdev_err(dev, "tx_errors %lld\n",
> > +                le64_to_cpu(counters->tx_errors));
> > +     netdev_err(dev, "rx_errors %d\n",
> > +                le32_to_cpu(counters->rx_errors));
> > +     netdev_err(dev, "rx_missed %d\n",
> > +                le16_to_cpu(counters->rx_missed));
> > +     netdev_err(dev, "align_errors %d\n",
> > +                le16_to_cpu(counters->align_errors));
> > +     netdev_err(dev, "tx_one_collision %d\n",
> > +                le32_to_cpu(counters->tx_one_collision));
> > +     netdev_err(dev, "tx_multi_collision %d\n",
> > +                le32_to_cpu(counters->tx_multi_collision));
> > +     netdev_err(dev, "rx_unicast %lld\n",
> > +                le64_to_cpu(counters->rx_unicast));
> > +     netdev_err(dev, "rx_broadcast %lld\n",
> > +                le64_to_cpu(counters->rx_broadcast));
> > +     netdev_err(dev, "rx_multicast %d\n",
> > +                le32_to_cpu(counters->rx_multicast));
> > +     netdev_err(dev, "tx_aborted %d\n",
> > +                le16_to_cpu(counters->tx_aborted));
> > +     netdev_err(dev, "tx_underun %d\n",
> > +                le16_to_cpu(counters->tx_underun));
>=20
> You use le64/32/16_to_cpu here for all stats, but below in rtase_get_stat=
s64, it
> is only used for tx_errors.
>=20
> The code should probably be consistent? Either you do or don't need to us=
e
> them?
>=20
> > +}
> > +
> [...]
> > +
> > +static void rtase_get_stats64(struct net_device *dev,
> > +                           struct rtnl_link_stats64 *stats) {
> > +     const struct rtase_private *tp =3D netdev_priv(dev);
> > +     const struct rtase_counters *counters;
> > +
> > +     counters =3D tp->tally_vaddr;
> > +
> > +     dev_fetch_sw_netstats(stats, dev->tstats);
> > +
> > +     /* fetch additional counter values missing in stats collected by =
driver
> > +      * from tally counter
> > +      */
> > +     rtase_dump_tally_counter(tp);
> > +     stats->rx_errors =3D tp->stats.rx_errors;
> > +     stats->tx_errors =3D le64_to_cpu(counters->tx_errors);
> > +     stats->rx_dropped =3D tp->stats.rx_dropped;
> > +     stats->tx_dropped =3D tp->stats.tx_dropped;
> > +     stats->multicast =3D tp->stats.multicast;
> > +     stats->rx_length_errors =3D tp->stats.rx_length_errors;
>=20
> See above; le64_to_cpu for tx_errors, but not the rest of the stats. Why?

The rtase_dump_state() function is primarily used to dump certain hardware
information. Following discussions with Jakub, it was suggested that we
should design functions to accumulate the 16-bit and 32-bit counter values
to prevent potential overflow issues due to the limited size of the
counters. However, the final decision was to temporarily refrain from
reporting 16-bit and 32-bit counter information. Additionally, since
tx_packet and rx_packet data are already provided through tstat, we
ultimately opted to modify it to the current rtase_get_stats64() function.

Thanks
Justin

