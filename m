Return-Path: <netdev+bounces-103078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF74F90629C
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 05:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 595B328420C
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 03:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1393D12FF7B;
	Thu, 13 Jun 2024 03:17:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6A812EBE6;
	Thu, 13 Jun 2024 03:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718248666; cv=none; b=Zc3Z25W58UWD8qTn8+4befa83iPnQX2d4SsOGvTGqCgTjy1f1m8POFmdPn7i4H4lgw/ICKuls6IochyiK7iJQ/llf8ZFF7LjPl6rSBAw0o11Ks8mVU/vusKvGQDhANDl2XGXiXKrLBJAtCOvv2FO2U69Aww7DKi2pxhoBNlR2Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718248666; c=relaxed/simple;
	bh=CyteLJH+68fyXpdPXq9xYXyRtYjEX4sE6Z58tEnCb8A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DX6swwTNBCHxDunvPIKkLP4wDW4J+dZps4qlUSe3VpDFGAsWZu1Eyca4uHWEkSt/GFGFIAupYkHJMl3/IS+KSRBZDIS/Hxmf+j06uAC4vsBNLZsWkzT55KyuqdzmKDMbSNNrdY8mB57/PcWBJVutKO7jDsF7msny8M7lhv4kq6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45D3GXEV02037793, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45D3GXEV02037793
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 11:16:33 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 11:16:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 13 Jun 2024 11:16:27 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 13 Jun 2024 11:16:27 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "andrew@lunn.ch"
	<andrew@lunn.ch>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "rkannoth@marvell.com" <rkannoth@marvell.com>,
        "Ping-Ke
 Shih" <pkshih@realtek.com>,
        Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v20 08/13] rtase: Implement net_device_ops
Thread-Topic: [PATCH net-next v20 08/13] rtase: Implement net_device_ops
Thread-Index: AQHauLeU3KHUR0FCCkajORloGcGgcbHEXNMAgACmHxA=
Date: Thu, 13 Jun 2024 03:16:27 +0000
Message-ID: <2f6dfc4920694035bf630fccc4f3a943@realtek.com>
References: <20240607084321.7254-1-justinlai0215@realtek.com>
	<20240607084321.7254-9-justinlai0215@realtek.com>
 <20240612173944.05121bf0@kernel.org>
In-Reply-To: <20240612173944.05121bf0@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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

> On Fri, 7 Jun 2024 16:43:16 +0800 Justin Lai wrote:
> > +static void rtase_get_stats64(struct net_device *dev,
> > +                           struct rtnl_link_stats64 *stats) {
> > +     const struct rtase_private *tp =3D netdev_priv(dev);
> > +     const struct rtase_counters *counters;
> > +
> > +     counters =3D tp->tally_vaddr;
> > +
> > +     if (!counters)
> > +             return;
>=20
> Same question about how this can be null as in the ethtool patch..

This check seems unnecessary, I will remove it.

>=20
> > +     netdev_stats_to_stats64(stats, &dev->stats);
>=20
> Please dont use this field, there is a comment on it:
>=20
>         struct net_device_stats stats; /* not used by modern drivers */
>=20
> You can store the fields you need for counters in struct rtase_private

Ok, I will remove all parts that use struct net_device_stats stats.

>=20
> > +     dev_fetch_sw_netstats(stats, dev->tstats);

