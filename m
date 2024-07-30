Return-Path: <netdev+bounces-114048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A602B940D5D
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 11:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1329B25923
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 09:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0ED194C6E;
	Tue, 30 Jul 2024 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="U8ZjN8M1"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E421194AF2;
	Tue, 30 Jul 2024 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331514; cv=none; b=PvzEVG9VjH3gHDxcJa/wb+a1I+iSJqh08vygq+tPssEZnyTtGScAk++fD9pRcCoo9ursYeaxNtkdcfb5t4T6RYtC/ImbwYHHQIXX3p4FOfuIOR88mz2PCA/xwwsDatMCXmQdtMaYUAQFn6Os6+eOa59yZ5wL3G+waKELkSCZ9AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331514; c=relaxed/simple;
	bh=LV6HWM6DuQ9VHyfMX6QFrPrJ77gDJA4H7MMa1ftJpD0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fG4Qb9TWh6npv6DNZHZlcgPQt4PLbRIax4grZpxGhoYwdfGe6IJYmQzBabtuFEu0NfJef0Yvyu/OWrN2VzgNrrT7teKaeY9LF76ePGCOtHaW/jKBrWs+RztkM9vcNj2JXmb8RBt+WEvfWvwCPPgjweNsyKalipqxt520Y4qhcOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=U8ZjN8M1; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46U9OXXf8930143, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722331473; bh=LV6HWM6DuQ9VHyfMX6QFrPrJ77gDJA4H7MMa1ftJpD0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=U8ZjN8M1Y77o9v8/DX1UVkoJzJ57Hlhsbr4DIqN8at5eocCKrHGqsivJFPDTV32jF
	 7AjAJxzdpVsVwkha+k2H1CiV5IvGsG86NydVNZ1oUFZhtMmX0rlifmL0UA7KWYTOXN
	 bnqbvYtTzrQFIDuxgdtzDvEE6sWAT2zKMO6KXqKHP+z4k/zf0Kfo2rUc5mMLm4PmQZ
	 kGTa59CIQMnmfIpOA+f2IXLeSowz3qWFTQY7GX2VJ2AwFt4Oq13xL54isgJ+HvEkAU
	 59izoX7d0c4SGrriM43RsdTs3ek9vBBDvWvH8eVGuLhSYMJzhhgDAo+XMHtGpDo+a9
	 FQgoGzVlVxSdQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46U9OXXf8930143
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jul 2024 17:24:33 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 17:24:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jul 2024 17:24:33 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 30 Jul 2024 17:24:33 +0800
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
Subject: RE: [PATCH net-next v25 02/13] rtase: Implement the .ndo_open function
Thread-Topic: [PATCH net-next v25 02/13] rtase: Implement the .ndo_open
 function
Thread-Index: AQHa4X+gIt8gKL1ChE+yE/iOvi6B7bIOA7qAgAD9e+A=
Date: Tue, 30 Jul 2024 09:24:32 +0000
Message-ID: <24521b998abd478f88116950488fda17@realtek.com>
References: <20240729062121.335080-1-justinlai0215@realtek.com>
	<20240729062121.335080-3-justinlai0215@realtek.com>
 <20240729191559.1683ec63@kernel.org>
In-Reply-To: <20240729191559.1683ec63@kernel.org>
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

> On Mon, 29 Jul 2024 14:21:10 +0800 Justin Lai wrote:
> > +     page =3D page_pool_dev_alloc_pages(tp->page_pool);
> > +     if (!page) {
> > +             netdev_err(tp->dev, "failed to alloc page\n");
> > +             goto err_out;
> > +     }
> > +
> > +     buf_addr =3D page_address(page);
> > +     mapping =3D page_pool_get_dma_addr(page);
> > +
> > +     skb =3D build_skb(buf_addr, PAGE_SIZE);
>=20
> Don't build_skb() before packet was received.
>=20
> One of the benefits of build_skb() is that the skb is supposed to be more=
 likely
> to be still in CPU cache.

Ok, I will modify it.

Thanks
Justin

