Return-Path: <netdev+bounces-102787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 984129049ED
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 06:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472C71F2362E
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 04:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B8D208A4;
	Wed, 12 Jun 2024 04:21:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58328179B7;
	Wed, 12 Jun 2024 04:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718166085; cv=none; b=FGNqi/TXQc/CrnUVwlrZ68Ko3/UOZSXjCvxAod4sy1xyD09yAUwbGMJ3Sdip3wlG3OWTZt2GfU4LdkRfR3wZD9yOXuJmoOo4DTCjNhLyw02GZbmDHI811dcw3GXm92qg/nXEmxcoiaii05jw+/ydtjmg62zJ/Z/nEbgHeljiJJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718166085; c=relaxed/simple;
	bh=SO2mP7JAos8SHqZ+Wh9MxKGiIDIdaOKMZcDcbVhjwNw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VUPoaI7yAFFD1nh3SnJ38RmwojDBJ7lPDNAjRWAvegzWafZjkScsQGqobmWN6fHIYO0+2lIUqSdUagF43MP3X0Y8FN18saf7cXp0DFh6TMDYXum73VpY8F2Q0KuvD1FFUGR0vw89CQ5N9uPltBT8tu06JJIq7ie1ObkJwArYIZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45C4KUPj8881504, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45C4KUPj8881504
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jun 2024 12:20:30 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Jun 2024 12:20:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 12 Jun 2024 12:20:29 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 12 Jun 2024 12:20:29 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
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
        Ping-Ke Shih <pkshih@realtek.com>, Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v20 06/13] rtase: Implement .ndo_start_xmit function
Thread-Topic: [PATCH net-next v20 06/13] rtase: Implement .ndo_start_xmit
 function
Thread-Index: AQHauLdmYuDGRjyaP0maBwRhxExTNLG77l8AgAefqjA=
Date: Wed, 12 Jun 2024 04:20:29 +0000
Message-ID: <4a894465ea0747d08c96282602bcdf6b@realtek.com>
References: <20240607084321.7254-1-justinlai0215@realtek.com>
 <20240607084321.7254-7-justinlai0215@realtek.com>
 <20240607155420.GA3743392@maili.marvell.com>
In-Reply-To: <20240607155420.GA3743392@maili.marvell.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

> On 2024-06-07 at 14:13:14, Justin Lai (justinlai0215@realtek.com) wrote:
> > Implement .ndo_start_xmit function to fill the information of the
> > packet to be transmitted into the tx descriptor, and then the hardware
> > will transmit the packet using the information in the tx descriptor.
> > In addition, we also implemented the tx_handler function to enable the
> > tx descriptor to be reused.
> >
> > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> > ---
> >  .../net/ethernet/realtek/rtase/rtase_main.c   | 285 ++++++++++++++++++
> >  1 file changed, 285 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > index 23406c195cff..6bdb4edbfbc1 100644
> > --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> > @@ -256,6 +256,68 @@ static void rtase_mark_to_asic(union rtase_rx_desc
> *desc, u32 rx_buf_sz)
> >                  cpu_to_le32(RTASE_DESC_OWN | eor | rx_buf_sz));  }
> >
> > +static u32 rtase_tx_avail(struct rtase_ring *ring) {
> > +     return READ_ONCE(ring->dirty_idx) + RTASE_NUM_DESC -
> > +            READ_ONCE(ring->cur_idx); }
> dirty_idx and cur_idx wont wrap ? its 32bit in size.
>=20
> >
cur_idx and dirty_idx may wrap, but all we want is the difference between
them, so this won't have any effect. In addition, the difference between
the two will not exceed RTASE_NUM_DESC, and dirty_idx will not exceed
cur_idx, so the calculation won't go wrong.

