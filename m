Return-Path: <netdev+bounces-177931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E90B5A73255
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 13:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B62C83A3BC4
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 12:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4695E20B209;
	Thu, 27 Mar 2025 12:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="m+/t5mH1"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC40838FA6;
	Thu, 27 Mar 2025 12:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743078939; cv=none; b=WFznovcKjE1HYStGnMQ9FCSVkkZ26thN2UfEhC2lUpfzrzn0vsNXi2bbUEZi/xavczZH34BOcAXb4XU+5yfk96aKJO47Xkt1A3JPXj+pNhRpI3P4L3McdSrqnvZ6gf+g1aMkaKbIjeeZ9XUC3KYWqC6HRAFKyg4UEQMY//e+fzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743078939; c=relaxed/simple;
	bh=Lt9UQTIwLqmLVd5QOwg+Zd8a6+yM24ga6+JKTypDu04=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AsZD7oGanPA5gH0HY0UdxhmX2XDap0gmlWzjkHWx9quUqVZDu/VngONy7mEc4uAv5kO/iynMwc9QlTTBfAeB5gSKhh9CtT6RKpExtYz0ig0FdGatpb32bboLkEC2Ydk1VcjDZyDFmpAhKilkEufScKP+TampS3Cr0B72m5ikANE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=m+/t5mH1; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52RCZ46W0047706, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1743078904; bh=Lt9UQTIwLqmLVd5QOwg+Zd8a6+yM24ga6+JKTypDu04=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=m+/t5mH11TQeCax5Mr2U24SL8nwZv+OK1DrEsPmUfceTxn8mLLhmiXMcdTKg3cHDi
	 LdejULDrvBFlwii5PXIKLlukAqnXHijmcN3hd2Afcpk04aK7OP5VFbBZzRI86PXbVK
	 /ZNkUgbIP/oao9P1nBRjtmv2bMXxZL4D2w2uH+1I5HZ1DyRxvGYa0u8KXGTr1TaMz0
	 Qub2lVJLD5WfLnNhDlHmcu57dg86NV+k/zP7xvPBWVqQkJlNfuM8Sd9EJuxYOmQLWL
	 H07vUjKCjmC2XHHXE1mQgTAz41o6B5AyIXRvgr1Qv3nnxSmvhVwMMXEuRaN3WGLsx+
	 sE/U4m579Y/nQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52RCZ46W0047706
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 20:35:04 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Mar 2025 20:35:04 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 27 Mar 2025 20:34:59 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25]) by
 RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25%5]) with mapi id
 15.01.2507.035; Thu, 27 Mar 2025 20:34:59 +0800
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
	<larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v2] rtase: Add ndo_setup_tc support for CBS offload in traffic control setup
Thread-Topic: [PATCH net-next v2] rtase: Add ndo_setup_tc support for CBS
 offload in traffic control setup
Thread-Index: AQHbnspnjt1ZroxVD0e8mPtSPQ9ZcLOGP7yAgACqpVA=
Date: Thu, 27 Mar 2025 12:34:58 +0000
Message-ID: <88849bcf554b4636b6914a2e041d160d@realtek.com>
References: <20250327034313.12510-1-justinlai0215@realtek.com>
 <20250327101925.GF892515@horms.kernel.org>
In-Reply-To: <20250327101925.GF892515@horms.kernel.org>
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

> External mail : This email originated from outside the organization. Do n=
ot
> reply, click links, or open attachments unless you recognize the sender a=
nd
> know the content is safe.
>=20
>=20
>=20
> On Thu, Mar 27, 2025 at 11:43:13AM +0800, Justin Lai wrote:
> > Add support for ndo_setup_tc to enable CBS offload functionality as
> > part of traffic control configuration for network devices.
> >
> > Signed-off-by: Justin Lai <justinlai0215@realtek.com>
> > ---
> > v1 -> v2:
> > - Add a check to ensure that qopt->queue is within the specified range.
> > - Add a check for qopt->enable and handle it appropriately.
>=20
> Thanks Justin,
>=20
> This patch looks good to me.
> But net-next is currently closed for the merge-window.
> So please repost this patch once it re-opens, which
> I expect to be around the 14th April.
>=20
> RFC patches are welcome any time.
>=20
> --
> pw-bot: deferred

Hi Simon,

Thank you for your review. I will repost this patch once the net-next
re-opens.

Justin

