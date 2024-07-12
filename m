Return-Path: <netdev+bounces-111030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FC392F6F6
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 10:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D5641F21E7A
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 08:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064611422D2;
	Fri, 12 Jul 2024 08:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="tFm+6zH7"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD39F13D891;
	Fri, 12 Jul 2024 08:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720773142; cv=none; b=j3vXjfu9gJtZuOfs57J2Ojs8A4qPRYqezue4hvEpXOKVCyLos6CzeB+42dAeHmJujjgOZmtS3muzM4b0hqidwY1q5PCvkkp4v576RhQvHfFpkKurS6FbczAa1Mrbcnw7N8B3jJnZlLIkxq2plUgEgU/7nS77NusMWZd83IOlQ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720773142; c=relaxed/simple;
	bh=n1zxY5qH8904VuJHNeImarl5a09WAl8K0FSrsBJ4FYE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QDn3Cuzh/OAT1Ni5ORfMEhHOfzn22p8arwVmYo6sMCVhTaA1I/eaXzEfFbVRgJ6O31TMWYVL/ISjEZWai/z1UkSwwasExh2p0STUQPkH2yuEnaJm8mgljzORqnhucdrzrCWJxyTA+PE+U5N0qwMLp5BoOPIkiv0XgRkE4S6Cdk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=tFm+6zH7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46C8VgfiE313779, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1720773102; bh=n1zxY5qH8904VuJHNeImarl5a09WAl8K0FSrsBJ4FYE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=tFm+6zH7wRiw3WALQ3iK4Q3wGDDloNokBkw1Nl9WlEWJwsi8jLopXajw2RpdRttdT
	 f38w3sqUSIZ8gMHGiXGsjzbQ3Ke5IRGJnyqCuAkjv8oTvNBr/Zt7FLStdQGn6jVCYw
	 55Z3ib+RcKnWUd/C39KSc6bxfqkbLSXoMQVMfyUHELs6FbIPscfddHWiH3xT/agWZa
	 cowp0T2I3ZFuZzCIDrpCepoep8lyoiKGnWzdxDq06xE1cc8OdLS08k1+4dC+dDzXLF
	 RsjC6eBhD64TwkJXT4QfrQ+k748CPE38hXC6YDEuxEXJjwpLNLUgHD0NvNRrsiZ9eF
	 X98GmQMDmDn6A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46C8VgfiE313779
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jul 2024 16:31:42 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 16:31:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Jul 2024 16:31:42 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 12 Jul 2024 16:31:42 +0800
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
Subject: RE: [PATCH net-next v23 04/13] rtase: Implement the interrupt routine and rtase_poll
Thread-Topic: [PATCH net-next v23 04/13] rtase: Implement the interrupt
 routine and rtase_poll
Thread-Index: AQHa0no69wfdkW7mNUmbfRSXLRon/rHxzNEAgAD5ekA=
Date: Fri, 12 Jul 2024 08:31:41 +0000
Message-ID: <55abfcf00da1494fbc98fc0389ab7c3a@realtek.com>
References: <20240710033234.26868-1-justinlai0215@realtek.com>
	<20240710033234.26868-5-justinlai0215@realtek.com>
 <20240711183640.02241a9a@kernel.org>
In-Reply-To: <20240711183640.02241a9a@kernel.org>
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

> On Wed, 10 Jul 2024 11:32:25 +0800 Justin Lai wrote:
> > +#ifdef CONFIG_NET_POLL_CONTROLLER
> > +/* Polling 'interrupt' - used by things like netconsole to send skbs
> > + * without having to re-enable interrupts. It's not called while
> > + * the interrupt routine is executing.
> > + */
> > +static void rtase_netpoll(struct net_device *dev) {
> > +     const struct rtase_private *tp =3D netdev_priv(dev);
> > +     const struct pci_dev *pdev =3D tp->pdev;
> > +
> > +     disable_irq(pdev->irq);
> > +     rtase_interrupt(pdev->irq, dev);
>=20
> Why do you need to implement a separate netpoll handler?
> netpoll is optional, if driver doesn't implement it core will just core y=
our NAPI
> handlers with a budget of 0 (to only clean up Tx, see NAPI documentation)=
.
>=20
> disable_irq() sleeps, you most definitely can't call it here.
> --
> pw-bot: cr

Hi Jakub,

After confirming, I think there is no need to implement the netpoll handler=
,
so I will remove it.

