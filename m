Return-Path: <netdev+bounces-185105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 968F5A9889D
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 13:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00EAC7AA681
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 11:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1315B223DD9;
	Wed, 23 Apr 2025 11:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="YLY04CUA"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EA62701C0;
	Wed, 23 Apr 2025 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745407952; cv=none; b=FdjmrIKfFdeeGTxdCJLrfeOO43v7kJvCvvsaxgFEoclgGXhFWVHM4jCHXwaO4z5dCJTyS5owtXT+4Xq1WmOdpQDYi0UXFR9RJMvk7Ja9XAvMKzkXmw9mb44A0/q0WoXbJyLz51oGjfryIhSJJG9dWZv90mXks4F9kFgEekf+A4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745407952; c=relaxed/simple;
	bh=DxaGI1hjzmUVNeyuzADxz1+yGkPl6JZZjtGe+adGZ4o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y/V8upXT7xylVbhs+qNtLOcRjMGOGZcjayOKm9gTH5mRohfDy9lJr+hvT/TYXL6CDebV1aLfsD6sGwwm7v7KnXy2AklaYsbSTgw3WVANybqaf8zbDimcZzTWP10/7znn5XpiH5aTQcjaeD2ikE9Ke+zc+VHoFwPeKgSMiBR14ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=YLY04CUA; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53NBW2pgC2492977, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745407922; bh=DxaGI1hjzmUVNeyuzADxz1+yGkPl6JZZjtGe+adGZ4o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=YLY04CUAgHpN/0C1YO9mQSWWpH2I79YiYOCI+z40ntEhfj8paNzDP9bzdjkIAWpFh
	 C9xNFoYgwJGbYLzHZF13KVZ2q90CQXl/J9c2CDfGX1SlmeaMG0NUXegGvtzJj5EFtU
	 3GKOe81/7bMSP7fjfG+0i0JlILCAmH3dnlaQWg1uAklgW/uUY5+dbSZI7M6dc1WfEx
	 Tf9Fv6Lovi7/YvdNjkYnjSdKY/OQbk/gpYzZILM/QMocqDJQ4g5exh2d/EKh+WkCNC
	 hUqXEPEzJ/cJbZ5zr7xHTdZekwpn827a5oENccvFjEe0NN7enBk8JkWCYxAIM71wBe
	 pTBTJR6lQAAkw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53NBW2pgC2492977
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 19:32:02 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Apr 2025 19:32:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 23 Apr 2025 19:32:01 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Wed, 23 Apr 2025 19:32:01 +0800
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
Subject: RE: [PATCH net v3 1/3] rtase: Modify the condition used to detect overflow in rtase_calc_time_mitigation
Thread-Topic: [PATCH net v3 1/3] rtase: Modify the condition used to detect
 overflow in rtase_calc_time_mitigation
Thread-Index: AQHbr3bGQZBcM8+BV0aT2Y9FDkzNELOvLZGAgAHx31A=
Date: Wed, 23 Apr 2025 11:32:01 +0000
Message-ID: <59893ad874224d209b1b43c00c56ba00@realtek.com>
References: <20250417085659.5740-1-justinlai0215@realtek.com>
 <20250417085659.5740-2-justinlai0215@realtek.com>
 <20250422132023.GG2843373@horms.kernel.org>
In-Reply-To: <20250422132023.GG2843373@horms.kernel.org>
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

> On Thu, Apr 17, 2025 at 04:56:57PM +0800, Justin Lai wrote:
> > Fix the following compile error reported by the kernel test robot by
> > modifying the condition used to detect overflow in
> > rtase_calc_time_mitigation.
> >
> > In file included from include/linux/mdio.h:10:0,
> >                   from
> drivers/net/ethernet/realtek/rtase/rtase_main.c:58:
> >  In function 'u16_encode_bits',
> >      inlined from 'rtase_calc_time_mitigation.constprop' at drivers/net=
/
> >      ethernet/realtek/rtase/rtase_main.c:1915:13,
> >      inlined from 'rtase_init_software_variable.isra.41' at drivers/net=
/
> >      ethernet/realtek/rtase/rtase_main.c:1961:13,
> >      inlined from 'rtase_init_one' at drivers/net/ethernet/realtek/
> >      rtase/rtase_main.c:2111:2:
> > >> include/linux/bitfield.h:178:3: error: call to '__field_overflow'
> >       declared with attribute error: value doesn't fit into mask
> >     __field_overflow();     \
> >     ^~~~~~~~~~~~~~~~~~
> >  include/linux/bitfield.h:198:2: note: in expansion of macro
> > '____MAKE_OP'
> >    ____MAKE_OP(u##size,u##size,,)
> >    ^~~~~~~~~~~
> >  include/linux/bitfield.h:200:1: note: in expansion of macro
> > '__MAKE_OP'
> >   __MAKE_OP(16)
> >   ^~~~~~~~~
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes:
> > https://lore.kernel.org/oe-kbuild-all/202503182158.nkAlbJWX-lkp@intel.
> > com/
> > Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this
> > module")
> > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
>=20
> Hi Justin,
>=20
> FWIIW, I note that this problem is reported by GCC 7.5.0 on sparc64 but n=
ot by
> GCC 14.2.0. And I think that is because in the end the values passed to
> u16_encode_bits (line 1915 in the trace above) are the same with and with=
out
> this patch. That is to say, this the compiler error above is a false posi=
tive of
> sorts.
>=20
> But I believe GCC 7.5.0 is a supported compiler version for sparc64.
> And this does result in an error, without W=3D1 or any other extra KCFLAG=
S set.
> So I agree this is appropriate to treat as a fix for net.
>=20
> And in any case, fix or no fix, it seems nice to limit the scope of the
> initialisation of msb.
>=20
> Reviewed-by: Simon Horman <horms@kernel.org>

Hi Simon,

Thank you for your review. I will repost this patch separately in the
net tree.

Thanks,
Justin


