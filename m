Return-Path: <netdev+bounces-185114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069A2A988EE
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 13:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4742744462B
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 11:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E13212B04;
	Wed, 23 Apr 2025 11:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="UtZ38tZH"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E99FFC08;
	Wed, 23 Apr 2025 11:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745409216; cv=none; b=HP6V+2V2JorT8WSVgD/oMVWyb02ohL/tBz36F8G/2ehLyNB7AC75K8zg2nkhueos/7BuRlrLJGP66E8FivwHt4ExSMwFGCPniZ9vXg2A1hHkO4D1t4z0w+oc8pyab3BSkIAwRCn+J5nwI7kwn2nOPyQ1+k/Vz0N//8ZR+GZU3yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745409216; c=relaxed/simple;
	bh=+kK7btHAHff0LuxX+LDGwowq2qltp/DMymR9Ft8jerQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hnd07qD2rZJmIrDEnr2TSFsMOUc5SNo4D8udmf8THinwc06KLiJGjPQ9eL7cFDY9GFDPxNQ8568OVNM7y0sNpnoyWr4qFuRGI7d1dNkQv2sdGQPSgRf3c2X9qSi4/seZ4IGbWw4tgt54LUFSMQO5gZ3EDTCgN5UPF9SXb91o3rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=UtZ38tZH; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53NBrDdvD2525642, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745409193; bh=+kK7btHAHff0LuxX+LDGwowq2qltp/DMymR9Ft8jerQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=UtZ38tZH7S+tyhObrJEy+IaQpbd9GdRVVk+kg5wV3smkgw4h1QcmKjms6Srb1idHT
	 3RYJDf36XHDsJM0gx8YDIIoYhpXtqQ01mCRH96YXKaBVokb4wQrOt0PLFVQH2FbB45
	 4wP7am+DSJTaB8u7tHuGeMV4Kbjzk2QmYW79ymoi07WmkGohrbuny5VwA3y/Qrzewl
	 M0olqDmPQhws4JktOQ/mlo+1qlTDdXh7KKDPdXeYeaiZ4AB15eFIYU/J4VW9l6ojfo
	 ryCXKSJdZDxfSgX3wkG3accbxITgmdTwOxR8H1btgiFqsHuQh/KFy1q7a5/ysp974E
	 jGFnrQTbuod1A==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53NBrDdvD2525642
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 19:53:13 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Apr 2025 19:53:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 23 Apr 2025 19:53:12 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Wed, 23 Apr 2025 19:53:12 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Simon Horman <horms@kernel.org>
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
        Ping-Ke Shih <pkshih@realtek.com>,
        Larry Chiu
	<larry.chiu@realtek.com>,
        kernel test robot <lkp@intel.com>
Subject: RE: [PATCH net v3 2/3] rtase: Increase the size of ivec->name
Thread-Topic: [PATCH net v3 2/3] rtase: Increase the size of ivec->name
Thread-Index: AQHbr3bUaMxZGlGmW0m7GLJEQs9VprOvJrAAgAH/QwA=
Date: Wed, 23 Apr 2025 11:53:12 +0000
Message-ID: <01039f49e5104f31975999590e6c0a7e@realtek.com>
References: <20250417085659.5740-1-justinlai0215@realtek.com>
 <20250417085659.5740-3-justinlai0215@realtek.com>
 <20250422125546.GF2843373@horms.kernel.org>
In-Reply-To: <20250422125546.GF2843373@horms.kernel.org>
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

> On Thu, Apr 17, 2025 at 04:56:58PM +0800, Justin Lai wrote:
> > Fix the following compile warning reported by the kernel test robot by
> > increasing the size of ivec->name.
> >
> > drivers/net/ethernet/realtek/rtase/rtase_main.c: In function 'rtase_ope=
n':
> > >> drivers/net/ethernet/realtek/rtase/rtase_main.c:1117:52: warning:
> > '%i' directive output may be truncated writing between 1 and 10 bytes
> > into a region of size between 7 and 22 [-Wformat-truncation=3D]
> >      snprintf(ivec->name, sizeof(ivec->name), "%s_int%i",
> >                                                      ^~
> >  drivers/net/ethernet/realtek/rtase/rtase_main.c:1117:45: note:
> >  directive argument in the range [0, 2147483647]
> >      snprintf(ivec->name, sizeof(ivec->name), "%s_int%i",
> >                                               ^~~~~~~~~~
> >  drivers/net/ethernet/realtek/rtase/rtase_main.c:1117:4: note:
> >  'snprintf' output between 6 and 30 bytes into a destination of  size
> > 26
> >      snprintf(ivec->name, sizeof(ivec->name), "%s_int%i",
> >      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >        tp->dev->name, i);
> >        ~~~~~~~~~~~~~~~~~
>=20
> Hi Justin,
>=20
> Given that the type of i is u16, it's theoretical range of values is [0, =
65536].
> (I expect that in practice the range is significantly smaller.)
>=20
> So the string representation of i should fit in the minumum of 7 bytes av=
ailable
> (only a maximum of 5 are needed).
>=20
> And I do notice that newer compilers do not seem to warn about this.
>=20
> So I don't really think this needs updating.
> And if so, certainly not as a fix for 'net'.
>=20
> Also, as an aside, as i is unsigned, the format specifier really ought to=
 be %u
> instead of %i. Not that it seems to make any difference here given the ra=
nge of
> values discussed above.
>=20
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes:
> > https://lore.kernel.org/oe-kbuild-all/202503182158.nkAlbJWX-lkp@intel.
> > com/
> > Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this
> > module")
> > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
>=20
> --
> pw-bot: changes-requested

Hi Simon,

Thank you for your reply. I will modify the format specifier to %u.
Since the warning from the kernel test robot is a false positive, I
will not address this warning, meaning I will not increase the size
of ivec->name. This patch will be posted to net-next.

Thanks,
Justin

