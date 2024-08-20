Return-Path: <netdev+bounces-119993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E7E957CA4
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 07:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70871C20AE7
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 05:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940FC839F7;
	Tue, 20 Aug 2024 05:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="sMiYI3RC"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5401B17758;
	Tue, 20 Aug 2024 05:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724130864; cv=none; b=dkFzayWFNAckFnetrkgMkrDZfgZ7UBlm3AOW8HhwpDc+4f3rpeNgd/dlADQyvs1jxZbkDoT2trXVhpvmhkLYZeQCO87G93xC0ek/QdGO3AThEse1cdVCsPyQe7PXleBcnPyDZLbGqD5e+lvlOuPYpr1ZRoOpdA5MHr/3+23G7Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724130864; c=relaxed/simple;
	bh=AtvqjKdxrcYuUZ36bpNwTNWYav6f2Wz+lGAYYbtzwf8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R9HvUMu7R5GiHPWCywtVk4C0KJIvrjAVZjiBgPJSTrkF08WTL2JBuOQct/d2muPYHIZ3ejcw2HKd9okdjeGAJl2/VP+2uMO/19sJNbtexnZgAJDrGYW/NCst2Bh804iWIwmT2Qrgeq7yZzDTET4NR5PfrKTOkIc1M224kkK51lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=sMiYI3RC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47K5DWSX01049167, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724130812; bh=AtvqjKdxrcYuUZ36bpNwTNWYav6f2Wz+lGAYYbtzwf8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=sMiYI3RCvlX5GEOY74mUDAC8SI/hezMAH81vAwpDW1pMk+MR1xeKDtW7Uk3tWaNGS
	 8NiLp91ZpOkc6w4MohFWvcrbkFw+VpggC9fYv2rH1CS7JVTvb5u6kobZtszcq9grKV
	 loQ3ZxQJt5J2GDxq0vkzHhuIcAjuhpoL9jiEFulV/ansJUZiX4yTTLXlXJRiooH69D
	 v0EgqVxmGi87bfjprocCgijlt1MvgrCKBoTXFqt5qzT63FteRi+hcU08ZreQDKKV/9
	 gfM/MX1vjmp4YpGxRouj4a9qGzmzEPCZKthuNJ61lVuFgDKQ5nSBxhgFHhXfDwxt49
	 srROW80FjNnAA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47K5DWSX01049167
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 13:13:32 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 13:13:32 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Aug 2024 13:13:32 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::80c2:f580:de40:3a4f]) by
 RTEXMBS03.realtek.com.tw ([fe80::80c2:f580:de40:3a4f%2]) with mapi id
 15.01.2507.035; Tue, 20 Aug 2024 13:13:32 +0800
From: Larry Chiu <larry.chiu@realtek.com>
To: Jakub Kicinski <kuba@kernel.org>, Justin Lai <justinlai0215@realtek.com>
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
        Ping-Ke Shih <pkshih@realtek.com>
Subject: RE: [PATCH net-next v27 07/13] rtase: Implement a function to receive packets
Thread-Topic: [PATCH net-next v27 07/13] rtase: Implement a function to
 receive packets
Thread-Index: AQHa7IJbTCC6rNx3KUa2K50iAPmDs7Ion3AAgAWjPCA=
Date: Tue, 20 Aug 2024 05:13:32 +0000
Message-ID: <5317e88a6e334e4db222529287f643ec@realtek.com>
References: <20240812063539.575865-1-justinlai0215@realtek.com>
	<20240812063539.575865-8-justinlai0215@realtek.com>
 <20240815185452.3df3eea9@kernel.org>
In-Reply-To: <20240815185452.3df3eea9@kernel.org>
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



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Friday, August 16, 2024 9:55 AM
> To: Justin Lai <justinlai0215@realtek.com>
> Cc: davem@davemloft.net; edumazet@google.com; pabeni@redhat.com;
> linux-kernel@vger.kernel.org; netdev@vger.kernel.org; andrew@lunn.ch;
> jiri@resnulli.us; horms@kernel.org; rkannoth@marvell.com;
> jdamato@fastly.com; Ping-Ke Shih <pkshih@realtek.com>; Larry Chiu
> <larry.chiu@realtek.com>
> Subject: Re: [PATCH net-next v27 07/13] rtase: Implement a function to
> receive packets
>=20
>=20
> External mail.
>=20
>=20
>=20
> On Mon, 12 Aug 2024 14:35:33 +0800 Justin Lai wrote:
> > +     if (!delta && workdone)
> > +             netdev_info(dev, "no Rx buffer allocated\n");
> > +
> > +     ring->dirty_idx +=3D delta;
> > +
> > +     if ((ring->dirty_idx + RTASE_NUM_DESC) =3D=3D ring->cur_idx)
> > +             netdev_emerg(dev, "Rx buffers exhausted\n");
>=20
> Memory allocation failures happen, we shouldn't risk spamming the logs.
> I mean these two messages and the one in rtase_alloc_rx_data_buf(),
> the should be removed.
>=20
> There is a alloc_fail statistic defined in include/net/netdev_queues.h
> that's the correct way to report buffer allocation failures.

Hi, Jakub,
Can we just count the rx_alloc_fail here?
If we implement the "netdev_stat_ops", we can report this counter.

> And you should have a periodic service task / work which checks for
> buffers being exhausted, and if they are schedule NAPI so that it tries
> to allocate.

We will redefine the rtase_rx_ring_fill() to check the buffers and
try to get page from the pool.
Should we return the budget to schedule this NAPI if there are some
empty buffers?

Thanks,
Larry


