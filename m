Return-Path: <netdev+bounces-52406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600057FEA86
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 09:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD72CB20F00
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 08:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2B720DFE;
	Thu, 30 Nov 2023 08:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040BE10E5;
	Thu, 30 Nov 2023 00:27:51 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AU8R1Zn83390710, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AU8R1Zn83390710
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Nov 2023 16:27:01 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 30 Nov 2023 16:27:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 30 Nov 2023 16:27:00 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 30 Nov 2023 16:27:00 +0800
From: Hayes Wang <hayeswang@realtek.com>
To: Douglas Anderson <dianders@chromium.org>,
        Jakub Kicinski
	<kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Grant Grundler
	<grundler@chromium.org>,
        Laura Nao <laura.nao@collabora.com>, Edward Hill
	<ecgh@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Simon Horman
	<horms@kernel.org>,
        =?iso-8859-1?Q?Bj=F8rn_Mork?= <bjorn@mork.no>,
        "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net v3 2/5] r8152: Add RTL8152_INACCESSIBLE checks to more loops
Thread-Topic: [PATCH net v3 2/5] r8152: Add RTL8152_INACCESSIBLE checks to
 more loops
Thread-Index: AQHaIwq1MymGLXN5NEmSvndbZQxPZbCSgm9w
Date: Thu, 30 Nov 2023 08:27:00 +0000
Message-ID: <72e1773d60c94a43ba9d97fa89a8dd1c@realtek.com>
References: <20231129132521.net.v3.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
 <20231129132521.net.v3.2.I79c8a6c8cafd89979af5407d77a6eda589833dca@changeid>
In-Reply-To: <20231129132521.net.v3.2.I79c8a6c8cafd89979af5407d77a6eda589833dca@changeid>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Douglas Anderson <dianders@chromium.org>
[...]
>=20
> Previous commits added checks for RTL8152_INACCESSIBLE in the loops in
> the driver. There are still a few more that keep tripping the driver
> up in error cases and make things take longer than they should. Add
> those in.
>=20
> All the loops that are part of this commit existed in some form or
> another since the r8152 driver was first introduced, though
> RTL8152_INACCESSIBLE was known as RTL8152_UNPLUG before commit
> 715f67f33af4 ("r8152: Rename RTL8152_UNPLUG to RTL8152_INACCESSIBLE")
>=20
> Fixes: ac718b69301c ("net/usb: new driver for RTL8152")
> Reviewed-by: Grant Grundler <grundler@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Acked-by: Hayes Wang <hayeswang@realtek.com>

Best Regards,
Hayes


