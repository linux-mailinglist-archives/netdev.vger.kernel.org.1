Return-Path: <netdev+bounces-251344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 350C0D3BDA2
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 03:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44B1E4E0663
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 02:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122C821FF4A;
	Tue, 20 Jan 2026 02:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="HbpX+Kki"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6404282EB;
	Tue, 20 Jan 2026 02:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768877376; cv=none; b=auZXITNGoejfm+udDVMTR/hg45ar+02vOw0goX3hwrJ/O6wmVtQTcq3HP1bTcE4c6jLYzptV0oecrVin4dCEBLCEEXncjtKWLyWK1zwLQUNGK6EaZSAgfC3yN+z3VVljYW/0AqMlnkXDPjJ8ca+LUlF7DTtFATZSHtfUzjbcv9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768877376; c=relaxed/simple;
	bh=Jv/RuTPSf0pfy1UnPx1YJcgtHJCsA2sVJ0DAH1+qeLI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CSvnrb5CCxXIzrj4MZcNuX6xd6iGaBPdB0hoN80ZTs+8PiXoURYsQYr3TIETw1nUM1i5s4Qo70NRL6w5HIDnpnY7e0bkqNB4D9dLkS61MbiyQXBxAZ1/1seMPrSVYFyRO9mcRIRF727nBrZ1iCJlJEu1WzKhDd5HUyK+aywQXl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=HbpX+Kki; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60K2nEbH5057942, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768877354; bh=Jv/RuTPSf0pfy1UnPx1YJcgtHJCsA2sVJ0DAH1+qeLI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=HbpX+KkihRQxF7ENzm1IxIK3LpGPZTmGbpbAwKhb1z5Zmr2IdDpA98Rcs007xMtNG
	 Q6fnvG3te5oQbn33O3rWZ22mhwstc6xP66+aaNUZ2CWi7GgvZpU731Bzj1Wl5wK7ey
	 FvkpBm9jzrB+k8bDKHwUDFIKkAQNVyEwIN7Q0jv8sp7Ib8MLwskj/nMh48gGkD1heJ
	 jo3Bic9KqITksjVDmKAbt7/4DbKH+6ehdbIoWbNH+lYhad5YG3BCgl7Am94smhG6TA
	 vkSd9heKKzvIGagvhTlyAtXKRdT8vPdajSFvCjywBl19pysCMZ71o4XKk07PeaoIa3
	 z+HvGRldwOxjg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60K2nEbH5057942
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 10:49:14 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 20 Jan 2026 10:49:15 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 20 Jan 2026 10:49:14 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([fe80::8bac:ef80:dea8:91d5]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::8bac:ef80:dea8:91d5%9]) with mapi id
 15.02.1748.010; Tue, 20 Jan 2026 10:49:14 +0800
From: Hayes Wang <hayeswang@realtek.com>
To: Mingj Ye <insyelu@gmail.com>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        nic_swsd <nic_swsd@realtek.com>, "tiwai@suse.de" <tiwai@suse.de>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] net: usb: r8152: fix transmit queue timeout
Thread-Topic: [PATCH v2] net: usb: r8152: fix transmit queue timeout
Thread-Index: AQHcibCA9au5CBb2aECTjig24ZP78rVaWekw
Date: Tue, 20 Jan 2026 02:49:14 +0000
Message-ID: <fde0f27fa7cc4817bb1297ce0ee1d0eb@realtek.com>
References: <20260120015949.84996-1-insyelu@gmail.com>
In-Reply-To: <20260120015949.84996-1-insyelu@gmail.com>
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

> From: Mingj Ye <insyelu@gmail.com>
> Sent: Tuesday, January 20, 2026 10:00 AM
[...]
> When the TX queue length reaches the threshold, the netdev watchdog
> immediately detects a TX queue timeout.
>=20
> This patch updates the trans_start timestamp of the transmit queue
> on every asynchronous USB URB submission along the transmit path,
> ensuring that the network watchdog accurately reflects ongoing
> transmission activity.
>=20
> Signed-off-by: Mingj Ye <insyelu@gmail.com>
> ---
> v2: Update the transmit timestamp when submitting the USB URB.

Reviewed-by: Hayes Wang <hayeswang@realtek.com>

Best Regards,
Hayes


