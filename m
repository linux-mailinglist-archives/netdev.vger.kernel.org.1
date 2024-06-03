Return-Path: <netdev+bounces-100056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C14CE8D7BBC
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 08:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29F95B222B8
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 06:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913CF38DE1;
	Mon,  3 Jun 2024 06:39:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C0B38F91;
	Mon,  3 Jun 2024 06:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717396776; cv=none; b=WJjL2bg4B4YN7/ZrpWoiKbE6EDaMRwPobpPAtxiwNmnHBcISFD55rBlUgka/QPj7orK4IPqZI1eYRXcQxyJBFU2viJSmrz/TBsOlcTWFMgYh5P287SyUMu8fb32isM6odkPjhhqlaBPStdj6l5Nq3saXV9AD4ma7L8tA9TpBQus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717396776; c=relaxed/simple;
	bh=Hmi6GmS0Jk8m638a9+xALCK7h1XugpsP21TZuVpusoQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WGokKBzJD0k4fThozWrf/oornORWmOFbuXFqKoPSfskhJeWloo4qSr1aw/ojRzuv2PYn8C7HsMs6NFVBRKwerkR8SWJb7r1OHMK20xXPo55sNSwA+/KOatXvkOInf+1t9olJTbn5fSocYCGJHy2Dnj7CJrJXskm0uWXkl49LeJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4536d2vM52498792, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4536d2vM52498792
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Jun 2024 14:39:02 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 14:39:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 3 Jun 2024 14:39:02 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 3 Jun 2024 14:39:02 +0800
From: Hayes Wang <hayeswang@realtek.com>
To: Douglas Anderson <dianders@chromium.org>,
        "David S . Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC: "danielgeorgem@google.com" <danielgeorgem@google.com>,
        Andrew Lunn
	<andrew@lunn.ch>, Grant Grundler <grundler@chromium.org>,
        Heiner Kallweit
	<hkallweit1@gmail.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH REPOST net-next 2/2] r8152: Wake up the system if the we need a reset
Thread-Topic: [PATCH REPOST net-next 2/2] r8152: Wake up the system if the we
 need a reset
Thread-Index: AQHasusweTibC+IgXEuw091SCEGxx7G1mr4A
Date: Mon, 3 Jun 2024 06:39:02 +0000
Message-ID: <e1b15f78c48143f6b70e25f5c48ae205@realtek.com>
References: <20240530164304.REPOST
 net-next.1.Ibeda5c0772812ce18953150da5a0888d2d875150@changeid>
 <66590f25.170a0220.8b5ad.1752@mx.google.com>
In-Reply-To: <66590f25.170a0220.8b5ad.1752@mx.google.com>
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

Douglas Anderson <dianders@chromium.org>
> Sent: Friday, May 31, 2024 7:43 AM
[...]
> If we get to the end of the r8152's suspend() routine and we find that
> the USB device is INACCESSIBLE then it means that some of our
> preparation for suspend didn't take place. We need a USB reset to get
> ourselves back in a consistent state so we can try again and that
> can't happen during system suspend. Call pm_wakeup_event() to wake the
> system up in this case.
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Acked-by: Hayes Wang <hayeswang@realtek.com>

Best Regards,
Hayes


