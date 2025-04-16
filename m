Return-Path: <netdev+bounces-183139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4F9A8B1A6
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 09:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB851904D83
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 07:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1E822B8A7;
	Wed, 16 Apr 2025 07:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="n18/EU8Y"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BC522B5AA;
	Wed, 16 Apr 2025 07:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744787082; cv=none; b=QLDmP6l/aJW1lH2IrdE3xToOmkofpxpi9I6Y2jMrOIt7ucqEDqixh6idxOkFTL4x/e0P2TZCNzNAMrljbpUowB1lzYIfUZLZm3dnCU8xU50WJ6vU2Gl/SWGOGEJ9RW+yJMNv2AtrPsR13Vz6zmunF1ILEbJ4Kaeo4/+qfH6Vfrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744787082; c=relaxed/simple;
	bh=HS/z4N64pw2j7J+mRowqcRtfuewBz9oZ/SCe+FNi88M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P16QS69MQq2n1qds4DVWu5dyupjrwZ5jzT4D1IZ1iad+8Xz4G9rUYvSAcW0VJo2zN1nTKmCF2r/62+8GKEAdsIpZXlsj5HrW7B8Puj+VbXY2PVO397YkjxxldAINdUzcnEegAyx8a/vDnJLCkPNyO0lykcbfxeNiLjKG2x4uD4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=n18/EU8Y; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53G749voC2842662, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744787049; bh=HS/z4N64pw2j7J+mRowqcRtfuewBz9oZ/SCe+FNi88M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=n18/EU8YmpQ0gZurQCDKb6mcdcDzZiwDjj9W1fng3wCxM86JhA4Yu/NUFhrbQlIQL
	 zlKC370tSMUmdf6rn40ZlXWDcgU6fRbbwT96KPESQqxABWVcFo6gxac5dW+Vs+EvKY
	 fi7QN8iUoEpWUxZ57bDhSjEGhbGQ7KPJo85JKoy7pf/rhbHnT/swXE8CIZoP/guE+t
	 IvjZ4EyiNCzHz+A2amiWhXfBxib/usTe1Dj/3PKmPh0pO8ZF7QWDUzfoE4jinw09yh
	 GwwLS/6M4H69FXl27YmJ0GPBbdBbiaseV8dGupWCOdnDRjnmFKkzx1h8VJ59RpZmkZ
	 f2Ti/EYnEbQhQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53G749voC2842662
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 15:04:09 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Apr 2025 15:04:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 16 Apr 2025 15:04:09 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Wed, 16 Apr 2025 15:04:09 +0800
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
	<larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v3] rtase: Add ndo_setup_tc support for CBS offload in traffic control setup
Thread-Topic: [PATCH net-next v3] rtase: Add ndo_setup_tc support for CBS
 offload in traffic control setup
Thread-Index: AQHbrO80xvliwf3v7k6gHUORMXC8/LOk63SAgADsrVA=
Date: Wed, 16 Apr 2025 07:04:09 +0000
Message-ID: <b9fcab27bc6a4d35ba32438623e5b259@realtek.com>
References: <20250414034202.7261-1-justinlai0215@realtek.com>
 <20250415172303.19022025@kernel.org>
In-Reply-To: <20250415172303.19022025@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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

>=20
> On Mon, 14 Apr 2025 11:42:02 +0800 Justin Lai wrote:
> > Add support for ndo_setup_tc to enable CBS offload functionality as
> > part of traffic control configuration for network devices.
>=20
> This is some semi-switch-like device right? Or am I misremembering?
> Could you clarify where the limits are applied?
> From CPU into the switch or on the switch ports?
> Should be documented in the commit msg.
> --
> pw-bot: cr

Hi Jakub,

Yes, this device is a switch, and CBS is applied from the CPU to the
switch. More specifically, CBS is applied at the GMAC in the topmost
architecture diagram in this driver. I will post a new version and
add this information to the commit message.

Thanks,
Justin

