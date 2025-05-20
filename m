Return-Path: <netdev+bounces-191721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B631ABCDCA
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 05:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A9697A7D31
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 03:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C52258CF1;
	Tue, 20 May 2025 03:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="VOg79n2N"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7BE257451;
	Tue, 20 May 2025 03:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747711214; cv=none; b=YH7g6Z506Uf+U7XnJMq0YtD2iVoXiyDgRi18mPvh+B+Gz3Bf9hZZgA/8FnCZX3WgVgpXAtjwJZu6iOwBY1XEU9SWukZsoKaK4TiV523eRUd8JLFNvuzjQFklRTP/69zpMiLEHlPMLbS6n1vk8wqYtH5YWnlUCCQvHExs+klK/s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747711214; c=relaxed/simple;
	bh=VKH7KRryI4ktofS9C7UuxsXcayJGKdrDWZTcnz1iCV8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fTHXDvtaz2kmz+pJdOpf3zvxjhukFkPFNxOv+V0MlQVgqS5YSVhvq//VSpKzb9ZEBTijDFqR4IZFTWRTGFdZoZJWg/kgT6/NsKhQiuY3sgwIS2HNhBVpD45OgETccWKLo8dQMqrM8Ozeg6y64Xf/L4gWkCM+fpkbqPaXptVKtCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=VOg79n2N; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54K3JglR61991624, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747711182; bh=VKH7KRryI4ktofS9C7UuxsXcayJGKdrDWZTcnz1iCV8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=VOg79n2NWp3+9ktcKp9gtbrYjJUIk53irYbowRSnVHj9Ux8pIM2POAFnWSdpPZ8He
	 QwbfGXyJoVDyWu2aMSLTfTyCLTeaCpChYYUQjfr2c8+VRAC1B3WoL9TEbbDWzT15Pr
	 AIWgLgP0UnfM2ymQUE2ymcgcj6V1vup9/PfnhCUVd6VwdoNkZKkxb0TrT6kB3beEm/
	 RKFX2pIcOqk96VElM0nQ06TPkV2UlmQd/kzhCUGWlY+krnYzQX5IQkBu6+xs8yS1Lc
	 asJXJOxgPng6U42lBO2qp6HzQ9zOuebgyRcAS+SAm4kyur6U/3Hu8r2M1IZPnmC9aX
	 FmDhcEXtd+Slg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54K3JglR61991624
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 11:19:42 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 May 2025 11:19:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 May 2025 11:19:42 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 20 May 2025 11:19:41 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Jakub Kicinski <kuba@kernel.org>
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
	<larry.chiu@realtek.com>, Joe Damato <jdamato@fastly.com>
Subject: RE: [PATCH net-next v2] rtase: Use min() instead of min_t()
Thread-Topic: [PATCH net-next v2] rtase: Use min() instead of min_t()
Thread-Index: AQHbtawdSIC/HJstr0OxTEOUNg41/rPaAlkAgAAn8wCAAAG8AIAA1A0g
Date: Tue, 20 May 2025 03:19:41 +0000
Message-ID: <73c27a5a4c814a5a9cdf6319314f8480@realtek.com>
References: <20250425063429.29742-1-justinlai0215@realtek.com>
	<bb78d791abe34d9cbac30e75e7bec373@realtek.com>
	<20250519153218.0036db7f@kernel.org> <20250519153830.112e1e0a@kernel.org>
In-Reply-To: <20250519153830.112e1e0a@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

> On Mon, 19 May 2025 15:32:18 -0700 Jakub Kicinski wrote:
> > On Mon, 19 May 2025 12:16:11 +0000 Justin Lai wrote:
> > > I apologize for the interruption, I would like to ask why this patch
> > > is rejected on patchwork.
> >
> > Hm, unclear, sorry about that.
>=20
> It doesn't apply, perhaps that's why? Please rebase and repost.

Hi Jakub,

Thank you for your reply. I will rebase and repost.

Thanks,
Justin

