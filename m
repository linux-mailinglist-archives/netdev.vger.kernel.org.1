Return-Path: <netdev+bounces-119125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B06B6954374
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 09:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612B728126D
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 07:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884861474CF;
	Fri, 16 Aug 2024 07:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="BtP/w0Hj"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F8C146017;
	Fri, 16 Aug 2024 07:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723794692; cv=none; b=miMAF4DDCZyxhZYSJBNnwFm91NYIeoEG7/2FHx6oruWak5zGId95c51+n8Y+TzZlEbUWw8LosvsnksHEIOkZSP4NkSyH6umEkQWWob76aFWdJ5GRRWcjBR1W0oBwgESYymktMtIFuJFNC7tOfNoNq+MP01oxYs87S3sHs4o60wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723794692; c=relaxed/simple;
	bh=bnyAfH+ev0FhWqNoOsERGAc1djGIBHFpQvIiRrY1a1w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VRQ8MDFBg+exEYiudDzz2HtQW7vf94KJ9lO5F9/A4Fu6ntv4smH2E/5hArSy+6dMOimd0PF6BIsnahj/wGHOIM5eHIkthYX3gJ+6PaGZtcYb0PloHHV+DefhItWecn49daTGQ/0GcgR060JalT7/glBIRhRF87DjxdnPqRtjt3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=BtP/w0Hj; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47G7okfV7817816, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723794646; bh=bnyAfH+ev0FhWqNoOsERGAc1djGIBHFpQvIiRrY1a1w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=BtP/w0HjcA1Dqzf4wbW7XEXY3DfG75o9aT4FPpUdtYJJPp8VH3WAuKWeIGp7qC4i0
	 DNfgaXSat/12+tWZPBWPbK8CuSWJF5cEr7r8WwejpjP+USQ8zACaypHiFwMX90euYo
	 qx6qqZ2wcmYdthKBsDa8QT9KI2E2SMY3iB03cOAP1P6WwDDrRpYgkYGP4dNw2Jw9UR
	 hWV+Ho9RGOgRMDosjTVd7FMs5pGY6AbwbGi164yLVQues2Fuff2Nx4jF0cQwDT/C0j
	 0WHhxCV7doDGlHnZLcI+8RpB+OQPNtviJg5i3N7tKaHS9ouzET15I45zjj7LjY2Y01
	 9vc6OvLyglqtA==
Received: from mail.realtek.com (smtpsrv.realtek.com[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47G7okfV7817816
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Aug 2024 15:50:46 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 15:50:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 Aug 2024 15:50:45 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 16 Aug 2024 15:50:45 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: Jakub Kicinski <kuba@kernel.org>
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
        Ping-Ke Shih <pkshih@realtek.com>, Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v27 07/13] rtase: Implement a function to receive packets
Thread-Topic: [PATCH net-next v27 07/13] rtase: Implement a function to
 receive packets
Thread-Index: AQHa7IJbqA7Iv5MkSUushVJbxjZdzbIon3AAgADoo1A=
Date: Fri, 16 Aug 2024 07:50:45 +0000
Message-ID: <3adea6bbe1384e0ea6a06f4343d03ac2@realtek.com>
References: <20240812063539.575865-1-justinlai0215@realtek.com>
	<20240812063539.575865-8-justinlai0215@realtek.com>
 <20240815185452.3df3eea9@kernel.org>
In-Reply-To: <20240815185452.3df3eea9@kernel.org>
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
> I mean these two messages and the one in rtase_alloc_rx_data_buf(), the
> should be removed.
>=20
> There is a alloc_fail statistic defined in include/net/netdev_queues.h th=
at's the
> correct way to report buffer allocation failures.
> And you should have a periodic service task / work which checks for buffe=
rs
> being exhausted, and if they are schedule NAPI so that it tries to alloca=
te.

Hi Jakub,

Thank you for the comments you provided. I will modify it.

Thanks
Justin

