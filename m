Return-Path: <netdev+bounces-120481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D1D959860
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 830161F22AF6
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 10:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AE51E1FF6;
	Wed, 21 Aug 2024 09:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="mIZn/Hsm"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A4D1E1FF7;
	Wed, 21 Aug 2024 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724231020; cv=none; b=sC7/IKsIxNhSIhTwTztLmF362A2HiZ8qykr/B4nHrqR/HOKPyCimUrcWGsplqN8ap4Zyop0xh0bY+Dno6vhyVSuJIvbLYm5K0vqOpzTOvN2zGczfycewmeprTkt/+qZFanfbcjvyZ/U63u8YHl1+rEvJyNRe6w+zv4OlgIFN9zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724231020; c=relaxed/simple;
	bh=sw2+Z8rLhQlYryAwMKWoIHotGZId5qg3Nd/8YG+7ulA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OBL6b7A8DmxSyNuqvwccNYcdoz/TbOWlsP2WxwcG6ktfgH8MoCL85BAEon3LRhSh3tueYWwbmQOAJtJiALdv6Noy6B3+h3hxQU3CKLsmnP9XDeWlGepbxnYtgCfuGrsHqqd8atf2gjZJZTF88xH+uMgw6zZp4nj9lOFsRto5piU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=mIZn/Hsm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47L92fgT62493302, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724230962; bh=sw2+Z8rLhQlYryAwMKWoIHotGZId5qg3Nd/8YG+7ulA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=mIZn/HsmzbTRKhwo7gfp/ghVgNWXdztcOcrokBAXEQJPIxgBxdUHweHkcBNVmaEz/
	 LwNRDmpPBf1Eb4fST9Br9Gf9xWciIL51XdiJCaT/Fe0YM5Afn9sFW7CCLf3+KmHmUA
	 5SO2SGp/q7w27HpBJfZlCuJ10oUNN3kBmn5WEAmlGscpNns2zqAFihG/yb6pViydaZ
	 KcWYzJJXUBxhpkl3Bb45ZaBRQXVH+zbnRNk080a/Gj/L7w4x+kET2JL58cRetKCAdf
	 3zMfSdtHwcuiXpirgvADTjPHNSnx8UBW+YY543vqGZ7QHTry0CUuNuFlH5UrDAVI3e
	 8QcpiOzlCvhnA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47L92fgT62493302
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 17:02:41 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 17:02:42 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Aug 2024 17:02:41 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::80c2:f580:de40:3a4f]) by
 RTEXMBS03.realtek.com.tw ([fe80::80c2:f580:de40:3a4f%2]) with mapi id
 15.01.2507.035; Wed, 21 Aug 2024 17:02:41 +0800
From: Larry Chiu <larry.chiu@realtek.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Justin Lai <justinlai0215@realtek.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "horms@kernel.org" <horms@kernel.org>,
        "rkannoth@marvell.com" <rkannoth@marvell.com>,
        "jdamato@fastly.com"
	<jdamato@fastly.com>,
        Ping-Ke Shih <pkshih@realtek.com>
Subject: RE: [PATCH net-next v27 07/13] rtase: Implement a function to receive packets
Thread-Topic: [PATCH net-next v27 07/13] rtase: Implement a function to
 receive packets
Thread-Index: AQHa7IJbTCC6rNx3KUa2K50iAPmDs7Ion3AAgAWjPCCAAXwoAIABRScg
Date: Wed, 21 Aug 2024 09:02:41 +0000
Message-ID: <14b068505fda436e92b58b2ea86e45a6@realtek.com>
References: <20240812063539.575865-1-justinlai0215@realtek.com>
	<20240812063539.575865-8-justinlai0215@realtek.com>
	<20240815185452.3df3eea9@kernel.org>
	<5317e88a6e334e4db222529287f643ec@realtek.com>
 <20240820074102.52c7c43a@kernel.org>
In-Reply-To: <20240820074102.52c7c43a@kernel.org>
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


> > > And you should have a periodic service task / work which checks for
> > > buffers being exhausted, and if they are schedule NAPI so that it tri=
es
> > > to allocate.
> >
> > We will redefine the rtase_rx_ring_fill() to check the buffers and
> > try to get page from the pool.
> > Should we return the budget to schedule this NAPI if there are some
> > empty buffers?
>=20
> I wouldn't recommend that. If system is under memory stress
> we shouldn't be adding extra load by rescheduling NAPI.

Okay, I get it, but there's a problem.
If all buffers are empty, it indicates that the memory allocation failed
multiple times. Should we keep trying to allocate or just log an error=20
message and stop it?

