Return-Path: <netdev+bounces-143806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 542779C4439
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 18:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A52728955E
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 17:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049431A76BB;
	Mon, 11 Nov 2024 17:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="MwtmfSxA"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC97C53389;
	Mon, 11 Nov 2024 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731347655; cv=none; b=r0kEWt79/LFU3zg2jCYFO509dJ0yBpwVkVHlU+q9jxuO4DHHpOaFU0NioknK9F2P3u9tg81srfuC8EHoxRp6st1WWSyTv1oif6CrH2Jc3Af4uiZdynfsR7H39upAyMR36UrW5K4p40iS0mlqXdO3D6po28SiUOTnCwUQ6RUwCFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731347655; c=relaxed/simple;
	bh=RQuehUcu7CPF8BzmE6YF+Hi6bonnL+vCx1x91FtB77Q=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=AdA8nKdoxWOfzcakLhD6/cpt8cJvkvyKirWpl6qXEBkyIEwqgmm4Dgzj5FbAd1nZTWzo8d9/I+yxkY91ayJt0rMRRNqCXwtz8zRzBbg4Ne83ZdQbp4x7UGWsnGDsrErqw/BnRpJlwS02+6EfXJvHMdpeCWqLRYzyHammYvIHbnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=MwtmfSxA; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1731347639;
	bh=RQuehUcu7CPF8BzmE6YF+Hi6bonnL+vCx1x91FtB77Q=;
	h=From:To:Subject:Mime-Version:Date:Message-ID;
	b=MwtmfSxAeBrpGREOuvQBAKowDITw+bRLkqsKwe/fj/Y1Sma4mUUNSyyDq9+LoEZ8z
	 P7SX4pGevD5Aie90gc/CrmQ2vIBiHqsNPudYAxtiTjvWa2fSAeHEt+jVpbjguLHRYo
	 1oztXU11iPhVE9wAd6IzZy/dg3VE9eKqz5u8kbSg=
X-QQ-GoodBg: 1
X-QQ-SSF: 00400000000000F0
X-QQ-FEAT: D4aqtcRDiqT6iyfUez+DXx4B7ybItHVbSxkDlA8/kMI=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: HxKBLVwctrUt98P+84o/bvHPxqJKkf1pbjYx6rm38RI=
X-QQ-STYLE: 
X-QQ-mid: t5gz7a-2t1731347617t5659572
From: "=?utf-8?B?V2VudGFvIEd1YW4=?=" <guanwentao@uniontech.com>
To: "=?utf-8?B?QW5kcmV3IEx1bm4=?=" <andrew@lunn.ch>
Cc: "=?utf-8?B?546L5pix5Yqb?=" <wangyuli@uniontech.com>, "=?utf-8?B?aGthbGx3ZWl0MQ==?=" <hkallweit1@gmail.com>, "=?utf-8?B?bGludXg=?=" <linux@armlinux.org.uk>, "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>, "=?utf-8?B?ZWR1bWF6ZXQ=?=" <edumazet@google.com>, "=?utf-8?B?a3ViYQ==?=" <kuba@kernel.org>, "=?utf-8?B?cGFiZW5p?=" <pabeni@redhat.com>, "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?5Y2g5L+K?=" <zhanjun@uniontech.com>, "=?utf-8?B?Zi5mYWluZWxsaQ==?=" <f.fainelli@gmail.com>, "=?utf-8?B?c2ViYXN0aWFuLmhlc3NlbGJhcnRo?=" <sebastian.hesselbarth@gmail.com>, "=?utf-8?B?bXVndW50aGFudm5t?=" <mugunthanvnm@ti.com>, "=?utf-8?B?Z2VlcnQrcmVuZXNhcw==?=" <geert+renesas@glider.be>
Subject: Re: [PATCH] net: phy: fix may not suspend when phy has WoL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Tue, 12 Nov 2024 01:53:37 +0800
X-Priority: 3
Message-ID: <tencent_36F99FAA42FE3D9C1BC36653@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <ACDD37BE39A4EE18+20241111080627.1076283-1-wangyuli@uniontech.com>
	<tencent_6056758936AF2CEE58AEBC36@qq.com>
	<3e486556-e654-4b3a-82c2-602c853788f0@lunn.ch>
In-Reply-To: <3e486556-e654-4b3a-82c2-602c853788f0@lunn.ch>
X-QQ-ReplyHash: 3341295578
X-BIZMAIL-ID: 18139226908605465664
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
	by smtp.qq.com (ESMTP) with SMTP
	id ; Tue, 12 Nov 2024 01:53:38 +0800 (CST)
Feedback-ID: t:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OBlwWD/GWDEohf/ygnOrzPn/4/fjZPsUuAHdKBwfFfLnEuWd3mSYk1ZY
	Y/ABAu9sScJS8jyVd97C9oXM19D1OfYJUS72g0JP/Ns7YD6i37+Iyrt+OUyzfdM+L2N9aF4
	0pTXNRgB198CmsSEYruwWHZduKR4uaxuXkwpPLaRcvY3+aBqRxCKfhSOcOvTh+ORSNaqZxf
	Cmz6f7M58qizBrNcR4ubB/M0ZkiBlWDS1B58zb69g/9LmgzjfdEoB4OXO0Z/MdDHGNkkQOZ
	ZOXm2O0C9fx41X1aSQfatF2INubR8mlQD75eYLCUuwUs3ZV1ZjcZXv5ezi1ZcludGu90qeR
	cE8C749gmQgtJdPqE0E/jFwkb8toCd4LLf44rKSBn8PaXlQQ9URfs89cveeIzfxMfsd9kk8
	1SOhYQT5V5lZef7b7BlMA0WO+eA00+kercj22E85gv40XkfdPza55xExudiUq+Ex4+/DPD7
	PVLstiMXNy9ham7QI+6P9ngPCaXs9j74H+OnTjkFt0KkMSwK5ejwj+flEFZhVWSC04/rrmO
	tAvusHZpkYdxcn6jpzf8bAv1lM+8bU1Bant3eLKomDJ+GQhh4eppSV2JtPI/1wCTuRgb267
	7fhoEsZCUO9N3c0c2i0j9Y4BYOl+K7EuzT8khoxBgEmi7DrDyWirIPEuKoV6eQp0KkeiUJb
	+bYnjm06vMT8s2p6LvxpPnkn/EWaAktt1OvOk7zPSWubZp3ddbS7lqdQULDiT4WRRWolhPU
	C9znCEJkP5qgGrdAS3EUu0bP7Fjcevysj0dUP+b8R6s3UP95v25LiYM6UmyA7fnvRBGHy2q
	njQLH0nd0Pq+HZgWNRtE/3wPolKMzx//PQpu6SsosO/aMfbZ4GHQdgqefNj1qbbXWoC9dt4
	MgGvAEX2GoJ0nB89lPX/OJMN8btPRveAKDe3AJf7QByRwn0mKWLbmXz85zWQt//suHRkwCq
	eRch+yGMAonWLlwvGDzFejbY0OXmDmZbb9qnkqtUORaOD0ZsgqnSQRunfIkPizZ+8hEM=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

VGhhbmtzLCBJIHdpbGwgcGF5IGF0dGVudGlvbiB0byBpdCBpbiB0aGUgZnV0dXJlLg0KDQpC
UnMNCldlbnRhbyBHdWFu


