Return-Path: <netdev+bounces-114050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968BC940D74
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 11:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B47A21C24102
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 09:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9B6194C8D;
	Tue, 30 Jul 2024 09:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="CyJeCkcJ"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8564E2B9B0;
	Tue, 30 Jul 2024 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331673; cv=none; b=QVEHiCWv/5OT1ay/gDsp6AO23rD/u4tq/V799tJFdvrKJZwnyJ+Xy2B1V0qcey/rqmPSHJ/cNxHEwWIA0jw0xfLAhvdgMbTRAVDyO6uE7nnNuo9XqJ4p4ej4JSH4OuHqtUMH8WunTckUu1VxcVQOPoTC9TcAU2NRAfFWPZSJlo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331673; c=relaxed/simple;
	bh=nVihgOe1slRJXjj8XROlogOSbWXhZykhQjb6429MPw4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KrYchzax/eHcBvS4n2KbO8BvOwWgvFHBuwfxm9ensbcG1AXfdaKbATDO5VtSm7XnbXoM8iKy3tkYjSi2UFqmmsHrSSz5skO63/EiHs4oYlq5WCC9KGzoY1YM0JaQQIz5vXNbYVcKgQJ47MDy57AX8MnpALbkp8mMdx3mV1VEYEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=CyJeCkcJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46U9RRGk8931633, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722331647; bh=nVihgOe1slRJXjj8XROlogOSbWXhZykhQjb6429MPw4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=CyJeCkcJT79Rp2gB/lMcSIzfVlJOfjl7mplvsUhAiKvaBhjxKFnei6u3VGwDAoyu/
	 PTRl7mCu5cElXkU5IKRvc0pMPh8oX4bkewA3eHVGv2tmfaz1sReCMoJGBtYSwiqHz1
	 Wn5N2uDYoow2B1Gf13NmGjtta3kBoOznYmk2JoozoK6AX/kuKBgf2n4DBr5B5SQZ4/
	 8za5qbM18uZRKgyJHpk1jaFjndLvUcRSn4A43lRhnqje9IeQBKCofv5TSpPcJtblXC
	 F93M3YnFfmw1ER5EC+DkbNUDTQDL9ieFpLvYxtqb5lyNtWk5ywomPzH6EU2/acMNUx
	 TKrQ1uxBPYCig==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46U9RRGk8931633
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jul 2024 17:27:27 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 17:27:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jul 2024 17:27:27 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 30 Jul 2024 17:27:27 +0800
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
Subject: RE: [PATCH net-next v25 06/13] rtase: Implement .ndo_start_xmit function
Thread-Topic: [PATCH net-next v25 06/13] rtase: Implement .ndo_start_xmit
 function
Thread-Index: AQHa4X/5GX51OPMFC0qnvNtitEutvrIOA0gAgAD7rOA=
Date: Tue, 30 Jul 2024 09:27:27 +0000
Message-ID: <f43b61ec5e624ae78dc5d564e8735ef3@realtek.com>
References: <20240729062121.335080-1-justinlai0215@realtek.com>
	<20240729062121.335080-7-justinlai0215@realtek.com>
 <20240729191424.589aff98@kernel.org>
In-Reply-To: <20240729191424.589aff98@kernel.org>
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

> On Mon, 29 Jul 2024 14:21:14 +0800 Justin Lai wrote:
> > +     stop_queue =3D !netif_subqueue_maybe_stop(dev, ring->index,
> > +                                             rtase_tx_avail(ring),
> > +
> RTASE_TX_STOP_THRS,
> > +
> RTASE_TX_START_THRS);
> > +
> > +     if (door_bell || stop_queue)
> > +             rtase_w8(tp, RTASE_TPPOLL, BIT(ring->index));
> > +
> > +     return NETDEV_TX_OK;
> > +
> > +err_dma_1:
> > +     ring->skbuff[entry] =3D NULL;
> > +     rtase_tx_clear_range(ring, ring->cur_idx + 1, frags);
> > +
> > +err_dma_0:
> > +     tp->stats.tx_dropped++;
> > +     dev_kfree_skb_any(skb);
> > +     return NETDEV_TX_OK;
> > +
> > +err_stop:
> > +     netif_stop_queue(dev);
> > +     tp->stats.tx_dropped++;
> > +     return NETDEV_TX_BUSY;
>=20
> If you're dropping a packet you should somehow check that the previous xm=
it
> didn't enqueue a packet to the ring and skip the doorbell because door_be=
ll
> was false. If that's the case you have to ring the doorbell now.
>=20
> Also you shouldn't increment dropped if you return TX_BUSY.

Thank you for your response. I will modify it.
>=20
> Please fix these issues in the driver you're copying from, too.

I will inform the person responsible for the R8169 of the issues we've
identified and discuss what modifications need to be made.

Thanks
Justin

