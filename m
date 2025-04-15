Return-Path: <netdev+bounces-182778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15204A89E5C
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8F2190265D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262C22949F9;
	Tue, 15 Apr 2025 12:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="LleNsB4O"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CFA289378;
	Tue, 15 Apr 2025 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744720920; cv=none; b=e706KjInlKoozdhcMG5ysFrUgW/1EXIw1RWBDB2UtJ8Dteu+VlPkpK7zlmk3BQgrOdgD2PglzXlsv11+IvaGyxqFSpJkYDdTikauvV6siwUselVCrf1X6iGjgfRwJmbRp5qqMeRfjsxG9MfeVMO2uZqwQDPY3Rq2ioORuTAK/os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744720920; c=relaxed/simple;
	bh=vsmMQlFlXn7cA94x4exBXUrDaqEX3/lnnG8SkJOCMTk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ecfcJ/D6xYLgNA2sqP7/Z1fZ9H9CKkQnxyvP2KM6AIwisf75pOmfHZV8YL8IWql6oC3VPlKcpPDhxGOvn2TnBZjmQM4CONIiAfKADxXeCrUAJBu0StNR0xERzZPeGEd+pCU5rCqI5pL12kuqwRlkA156PowqL9eEMyJmtlp4HHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=LleNsB4O; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53FCfYqM51336531, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744720894; bh=vsmMQlFlXn7cA94x4exBXUrDaqEX3/lnnG8SkJOCMTk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=LleNsB4Oz/Lt40dBzESYZYO8DRv3oo8Vo8s/6K64rs2FAqiLu6ohs7PplwJ7SUek3
	 Gdb096FLNSi+ZW2kJAwJujhA6URY8mM5HEc67z0UFZus1nDPXGM+9kbMs1256DDAmn
	 /dOaF2/nyaTHlX3rBwAtesmd7WjOoZV1MLs2rmn2dAECQ0+ex00Z0JJLF3mk/qX5HG
	 Th+4OcEq6zwbp/Y6s0s/C2ZUjtoQPqkrPvZjUs5VK+JWFPcNtquh2ImqDRxf4SkkL0
	 DbuqQj0jOY50wzKynbrn8cXGLBQlBidFjeDRPzllZgB6NwPjEZqUin7hiBbfeqRbOn
	 QoSJsEpzy5rrA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53FCfYqM51336531
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 20:41:34 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Apr 2025 20:41:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 15 Apr 2025 20:41:32 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 15 Apr 2025 20:41:32 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Justin Lai <justinlai0215@realtek.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "horms@kernel.org"
	<horms@kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Larry Chiu
	<larry.chiu@realtek.com>
Subject: RE: [PATCH net 0/3] Fix kernel test robot issue and type error in min_t
Thread-Topic: [PATCH net 0/3] Fix kernel test robot issue and type error in
 min_t
Thread-Index: AQHbrgHOEsIq73mK7ECaNxAB6KgJnLOkp9Rw
Date: Tue, 15 Apr 2025 12:41:32 +0000
Message-ID: <d0162fcf96b540e0a8ef9012b135d8e4@realtek.com>
References: <20250415122144.8830-1-justinlai0215@realtek.com>
In-Reply-To: <20250415122144.8830-1-justinlai0215@realtek.com>
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
> From: Justin Lai <justinlai0215@realtek.com>
> Sent: Tuesday, April 15, 2025 8:22 PM
> To: kuba@kernel.org
> Cc: davem@davemloft.net; edumazet@google.com; pabeni@redhat.com;
> andrew+netdev@lunn.ch; linux-kernel@vger.kernel.org;
> netdev@vger.kernel.org; horms@kernel.org; Ping-Ke Shih
> <pkshih@realtek.com>; Larry Chiu <larry.chiu@realtek.com>; Justin Lai
> <justinlai0215@realtek.com>
> Subject: [PATCH net 0/3] Fix kernel test robot issue and type error in mi=
n_t
>=20
> This patch set mainly involves fixing the kernel test robot issue and the=
 type
> error in min_t.
> Details are as follows:
> 1. Fix the compile error reported by the kernel test robot 2. Fix the com=
pile
> warning reported by the kernel test robot 3. Fix a type error in min_t
>=20
> Justin Lai (3):
>   rtase: Fix the compile error reported by the kernel test robot
>   rtase: Fix the compile warning reported by the kernel test robot
>   rtase: Fix a type error in min_t
>=20
>  drivers/net/ethernet/realtek/rtase/rtase.h      | 2 +-
>  drivers/net/ethernet/realtek/rtase/rtase_main.c | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>=20
> --
> 2.34.1
>=20

Sorry, this patch set was posted incompletely. I will post it again in
24 hours.

