Return-Path: <netdev+bounces-111652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A81C5931F13
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 05:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52C3B1F223EC
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 03:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEDAB641;
	Tue, 16 Jul 2024 03:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="pNhi+IHp"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DB13224;
	Tue, 16 Jul 2024 03:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721098948; cv=none; b=oMt0Og14ZRjiVSr/RTn2e5xKIzf+7q8hXhowj0alcuKoK6zLikDzl25gY1TbmEF02UQfBxm5bPaZpkeSEeED9X6TWkLu3+0P88MaIDkttplY2JCSPrzKiHHy1tw6lUvqpx6OokdWxSiaF+92HAF/8RDGQ+gSD6z9yXjaBcKGrrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721098948; c=relaxed/simple;
	bh=3pNgEHFGTvAI+GEAp/ruHV8Mn3DiUl+0KhvdRdpKuHA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PhrH+S1/Uv2XPSwvJrlJ630zuLrtNtK+bJl7wrgdj0oUE2IhAuKAa+zvdN01eMf8DlSxQ4oH6gdOKrLp5p7DzViAcUHdywYGOcLfxBV9l1yNTrji07SOn52/n13TN9LXiHrNMsX1ebv7VgZ5KnK68XKkWydCx/waqkIYQ+REwP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=pNhi+IHp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46G31oNQ2366112, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721098910; bh=3pNgEHFGTvAI+GEAp/ruHV8Mn3DiUl+0KhvdRdpKuHA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=pNhi+IHp/VrDUh43JMginECavVYk5Y9kug/oftPBkkZwa7k56oHsMbTU9o2e3qfne
	 YdvBlQMqNetoj64w8EbvuggddtIT0hquVbyvmLNsGAUK421/l3K3Hfz4jSjx2g8Dvk
	 tgLG3U6bw+8KXNih4Jsn6XDQ+Hr1X5rbphkxIgZw1lf1mBkHhOFPbDUwBAzbu26u43
	 p33oECdGjcoeLe06JYVBtCIwYrO7JDUg3McqUbUOhyd6qfglXiLcoyiGgvi1Xs0tTE
	 uxKasxZZl2vYYUpTRvFLFg2IT6dyZ6eBWmw7qXKQsAHGzHtZyadf2Nf20j1w3Ac5u3
	 njEj4Y/Ygx3vg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46G31oNQ2366112
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jul 2024 11:01:50 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 11:01:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Jul 2024 11:01:49 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 16 Jul 2024 11:01:49 +0800
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
        "jdamato@fastly.com" <jdamato@fastly.com>,
        Ping-Ke Shih <pkshih@realtek.com>, Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v24 00/13] Add Realtek automotive PCIe driver
Thread-Topic: [PATCH net-next v24 00/13] Add Realtek automotive PCIe driver
Thread-Index: AQHa1oZMG7/rZMIDUEmvFL30FgTtirH3QEEAgAFqSWA=
Date: Tue, 16 Jul 2024 03:01:49 +0000
Message-ID: <91a34dd8e23843459ccaa7f48171caf9@realtek.com>
References: <20240715071158.110384-1-justinlai0215@realtek.com>
 <20240715062006.7d640a30@kernel.org>
In-Reply-To: <20240715062006.7d640a30@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> On Mon, 15 Jul 2024 15:11:45 +0800 Justin Lai wrote:
> > This series includes adding realtek automotive ethernet driver and
> > adding rtase ethernet driver entry in MAINTAINERS file.
> >
> > This ethernet device driver for the PCIe interface of Realtek
> > Automotive Ethernet Switch,applicable to RTL9054, RTL9068, RTL9072,
> > RTL9075, RTL9068, RTL9071.
>=20
> Sorry, net-next is closed already for v6.11:
>=20
> https://lore.kernel.org/all/20240714204612.738afb58@kernel.org/

Hi Jakub,

Thank you for providing this information. I will repost my patch when
net-next reopens next time.

Thanks
Justin

