Return-Path: <netdev+bounces-198451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 400D3ADC32A
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 09:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30CF53A74E5
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 07:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9E728C872;
	Tue, 17 Jun 2025 07:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="fwVh8mDi"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A9228CF77;
	Tue, 17 Jun 2025 07:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750144861; cv=none; b=qrFBs7ZVVtBKyvU0CJbPdGpoIGVWTHYo4N4WuVkivYMkhOP9V6+7cfTvi3tI/dcpJIxnNnWGwZGF80ULqlicGY9OjMcRdE98FGeziNHfxW6qd2ejf18QqPT2ge3vLlEp3NLg8iwr18bL0RioqzfN8G9D4ynZE6uxc8pE36v2vIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750144861; c=relaxed/simple;
	bh=+dMeJaNU9Vw4n/TfbkPoCtzN+XBmJGEmPcGDrf/Xk44=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SxrM6ZoRwdHTtGlvP4X5N14C58U/3J/5zviZJA5HTpovPQmCFKQWkEoLu6zz6wQmeL8n4I8Vij9EoMyo16kUWnvkKURK9PT5la7i6+lgx0Kciy+rYofyGcnfwWff1mrn6xlgxBLShv83AO+ecdFLEcjN6bGJqb7P0322JG24zqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=fwVh8mDi; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55H7KCtmC1823722, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750144813; bh=sVuaS1fFDiOjECct3A6H6Zdc5xLKjkJu0DxycWPbt2I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=fwVh8mDigVYOgTnPB3ws4ilSz2E6R+UVZy/1iDq9EM9IfyfpbQfZP6FAPp4+1C6ZV
	 lV/xq+Hq6bBMfaQnqvTWN1sz/O4GstUc7Mj/b24CkCIpynke4haH5hYw2C08k5Lleu
	 rF0lEmLmhaFIYKTjl9QABDdBOHF4uBiurcFYNfull/rFdFtLpqor1C7XEqDgxJ0Pgs
	 aFc9ssZvV3AujjGyll+aHJ5ijJLyrFGr/spf5lrMpxqT5RgnOJtFlrwmRdjVvWK3dR
	 Hbo6spuhAEUa/YH3jT8CoZIkLCgdnfvSKx1X+qMZxySJyLDgAqopU1rrtOgyVodfEb
	 NV0tB0v524S3w==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55H7KCtmC1823722
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 15:20:13 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 17 Jun 2025 15:20:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 17 Jun 2025 15:20:17 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 17 Jun 2025 15:20:17 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Joe Damato <joe@dama.to>
CC: "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "horms@kernel.org" <horms@kernel.org>,
        "jdamato@fastly.com" <jdamato@fastly.com>,
        Ping-Ke Shih <pkshih@realtek.com>, Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v2 1/2] rtase: Link IRQs to NAPI instances
Thread-Topic: [PATCH net-next v2 1/2] rtase: Link IRQs to NAPI instances
Thread-Index: AQHb3m33AoUqGLYRxU6yyEFpsNftQ7QFZ3yAgAGLATA=
Date: Tue, 17 Jun 2025 07:20:17 +0000
Message-ID: <69799fd428b94d778a1c2e108a6d3f27@realtek.com>
References: <20250616032226.7318-1-justinlai0215@realtek.com>
 <20250616032226.7318-2-justinlai0215@realtek.com>
 <aFA7VdI7BWQOKW0V@MacBook-Air.local>
In-Reply-To: <aFA7VdI7BWQOKW0V@MacBook-Air.local>
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

> On Mon, Jun 16, 2025 at 11:22:25AM +0800, Justin Lai wrote:
> > Link IRQs to NAPI instances with netif_napi_set_irq. This information
> > can be queried with the netdev-genl API.
> >
> > Also add support for persistent NAPI configuration using
> > netif_napi_add_config().
> >
> > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> > ---
> >  .../net/ethernet/realtek/rtase/rtase_main.c   | 20 +++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
> >
>=20
> Did you test the persistent NAPI config on one of these devices?
>=20
> Reviewed-by: Joe Damato <joe@dama.to>

Hi Joe,

Yes, I tested it, and the persistent NAPI config worked correctly on
the device.

Thanks,
Justin

