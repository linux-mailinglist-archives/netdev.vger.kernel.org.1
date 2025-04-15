Return-Path: <netdev+bounces-182580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A98A892AC
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 05:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D43B61898775
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 03:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DC5218AB3;
	Tue, 15 Apr 2025 03:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="d7BS8tEG"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492441C700B;
	Tue, 15 Apr 2025 03:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744689502; cv=none; b=bOVp2FkhWAZ849PdQZ9h8NZZiW75rYq0zmdylPcOmK9ZkGvO3b6LRxGfxooyqMO0ZASW+bv6GUjFFSIeHZxKVeZrII1FYgMokVXe9x5R+djnk3DwVa74yQlR5F2MjdZ/SsJFMJqR1iTE6a538QQ5mdPD8AByLQkrDYfMT46Yu5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744689502; c=relaxed/simple;
	bh=8/7OE/PdvhXXx4ntXvRyNwEbGhavbkvSh1I4OENjYd4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Dqrw4Y/Eo9gIOL/QHUe9fcZl9qtnxwIoCjylpHc6FIVEKtEXeDYVX7NBOjY/b1OjrOd+4x1GQBd/H9qNJIWWimMQHN5LNV9UT6Xtkf4v+QNCm+gvLirbAFI8IKn0/pp6UXLjGK7GRaRXjsYEkO4slzr3AcWWi1Ow0TbOAH3Uk3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=d7BS8tEG; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53F3vSDj9559644, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744689448; bh=8/7OE/PdvhXXx4ntXvRyNwEbGhavbkvSh1I4OENjYd4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=d7BS8tEGrxJz/z1Rizy5jApxZx1ODze1VPoBKsBp5KVV4ArhlMflxy2956t/WVkWY
	 pZKeTyOprCG15703bCZy0CBfCk421UeI/KIJTfp68S/yFeWi7W9AOSqjRznGvIUCt4
	 rrUEovxO49FYgFvTnf5NEr9WLPZpNCMpXCpjeZ4Gi3Cz6D/7gjIh9mm3PrQdyVbSjq
	 QmdrkTTm520HFWDM2mf/ZIo/OK9XiuyuUEJoiL0UjQTN1P2C6nY+9pLxBGWrFfeBQw
	 O3zQJwOUuhpkWXr21HlY30a6Ee888nhGlcPvUS5kDioJ3qX/DTsLFWpHsfpJ/kJksZ
	 1w5CZa4Lb9vFw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53F3vSDj9559644
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 11:57:28 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Apr 2025 11:57:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 15 Apr 2025 11:57:17 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 15 Apr 2025 11:57:17 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Andrew Lunn <andrew@lunn.ch>
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
        Ping-Ke Shih
	<pkshih@realtek.com>,
        Larry Chiu <larry.chiu@realtek.com>,
        kernel test robot
	<lkp@intel.com>
Subject: RE: [PATCH net] rtase: Fix kernel test robot issue
Thread-Topic: [PATCH net] rtase: Fix kernel test robot issue
Thread-Index: AQHbrSDD9CZVAae2F06UCtZ1tmoHg7Oij+6AgAGIZ0A=
Date: Tue, 15 Apr 2025 03:57:17 +0000
Message-ID: <4ae769fc0f9f4c26a26f3fb2233ee025@realtek.com>
References: <20250414093645.21181-1-justinlai0215@realtek.com>
 <3d5a5a7d-a8fb-4a6a-9f3d-3ea27f9d06e7@lunn.ch>
In-Reply-To: <3d5a5a7d-a8fb-4a6a-9f3d-3ea27f9d06e7@lunn.ch>
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

> On Mon, Apr 14, 2025 at 05:36:45PM +0800, Justin Lai wrote:
> > 1. Fix the compile error reported by the kernel test robot by modifying
> > the condition used to detect overflow in rtase_calc_time_mitigation.
> > 2. Fix the compile warning reported by the kernel test robot by
> > increasing the size of ivec->name.
> > 3. Fix a type error in min_t.
>=20
> Looks like three patches should be used, not one. You can then include
> the details of what the test robot reported making it easier to
> understand each fix.
>=20
>=20
>     Andrew
>=20
> ---
> pw-bot: cr

Hi Andrew,

Thank you for your response. I will split this patch into three
separate patches and include the detailed report from the kernel
test robot.

Thanks,
Justin

