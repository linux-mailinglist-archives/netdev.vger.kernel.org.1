Return-Path: <netdev+bounces-113597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE87393F415
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 13:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F89EB2194B
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 11:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E4B145B3E;
	Mon, 29 Jul 2024 11:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="G97w9aGI"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFD8145B3B;
	Mon, 29 Jul 2024 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252752; cv=none; b=UNe+ShZPWzEda0K9JrW2G3HAgloY3auAa/DxyeRzko/S9NC3f0qAX4He0RnaapYTmpIZdzdJ+s1/QZ6RAnfVfZv3NjlkuNLQgFHjJ/lx5i3v16sjsCTnNaZ6cWSZ1AimtxqD5xznY4PsFf5TKPdEovhEXytu26qhwX9yHbxkOf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252752; c=relaxed/simple;
	bh=OIqYNP07lmUDbb+iEBCiVn0Q8zOlpBINYIEaSEre6wM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XqGeKg+Cr8qupJRewzgaREvF9L8sfZ+QuNisGIXn6IxSvzu6uaoOjW2sP5puAIBfpStHYADz0TCIR2y4Tus08RNP4F3Ta+unlBb90Pgxqe8Y64qNvTtbsFlaUSmxUFUjrixkp3haP4Amy8fLU7zCNEv7IXVsTPRzAvaES8XYqOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=G97w9aGI; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46TBVrUfA3916887, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722252713; bh=OIqYNP07lmUDbb+iEBCiVn0Q8zOlpBINYIEaSEre6wM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=G97w9aGI4KwdD+xT+dkKAusF++L0gUU4UXpyLSszkgmWHO5iETfLroM7N8VVuw7I7
	 MmkngebihxWcDDp+G+34VmgZ+kwVR42DW7PyHyzRwt34CudfXTdgPY7fPMkIIitPfS
	 nFVJuRpJPsBYn/qSfKFkGhcxtC9p94733Njiyd+QHCq5vycRqXSGzS2uQwfX+bnIBK
	 hugtS8vAQEUdeC25WMwybMWicxAQRSx1M76XRG868FgVEABy+9SuwkvbuRMpRs1Bbz
	 6Q3XkqLwEvqvTpSf7ioK2zP9hbES6rOALRZCiLYuTrad5NCAwaN8Rmd0J9RKkD0MbO
	 pWn8+1XDSrxEg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46TBVrUfA3916887
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 19:31:53 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 19:31:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jul 2024 19:31:52 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 29 Jul 2024 19:31:52 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Markus Elfring <Markus.Elfring@web.de>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        "David
 S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, "Jiri
 Pirko" <jiri@resnulli.us>,
        Joe Damato <jdamato@fastly.com>, Larry Chiu
	<larry.chiu@realtek.com>,
        Paolo Abeni <pabeni@redhat.com>, Ping-Ke Shih
	<pkshih@realtek.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        Simon Horman
	<horms@kernel.org>
Subject: RE: [PATCH net-next v25 01/13] rtase: Add support for a pci table in this module
Thread-Topic: [PATCH net-next v25 01/13] rtase: Add support for a pci table in
 this module
Thread-Index: AQHa4X+QuLAVVbX1HE21ZavZM+hY77IM65kAgACnJwA=
Date: Mon, 29 Jul 2024 11:31:52 +0000
Message-ID: <a00539c18c894f0192bea94b48fcfa69@realtek.com>
References: <20240729062121.335080-2-justinlai0215@realtek.com>
 <446be4e4-ea7e-47ec-9eba-9130ed662e2c@web.de>
In-Reply-To: <446be4e4-ea7e-47ec-9eba-9130ed662e2c@web.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

PiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0ZWsvcnRhc2UvcnRhc2UuaA0KPiA+
IEBAIC0wLDAgKzEsMzM4IEBADQo+IOKApg0KPiA+ICsjaWZuZGVmIF9SVEFTRV9IXw0KPiA+ICsj
ZGVmaW5lIF9SVEFTRV9IXw0KPiDigKYNCj4gDQo+IEkgc3VnZ2VzdCB0byBvbWl0IGxlYWRpbmcg
dW5kZXJzY29yZXMgZnJvbSBzdWNoIGlkZW50aWZpZXJzLg0KPiBodHRwczovL3dpa2kuc2VpLmNt
dS5lZHUvY29uZmx1ZW5jZS9kaXNwbGF5L2MvRENMMzctQy4rRG8rbm90K2RlY2xhcmUrb3IrZA0K
PiBlZmluZSthK3Jlc2VydmVkK2lkZW50aWZpZXINCj4gDQo+IFJlZ2FyZHMsDQo+IE1hcmt1cw0K
DQpIaSBNYXJrdXMsDQoNClRoYW5rIHlvdSBmb3IgeW91ciByZXNwb25zZSwgSSB3aWxsIG1vZGlm
eSBpdC4NCg0KSnVzdGluDQo=

