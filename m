Return-Path: <netdev+bounces-248293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BDBD06975
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 01:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5E7C3004B8C
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 00:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC06F450FE;
	Fri,  9 Jan 2026 00:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="N+wQbmHR"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6838C10A1E;
	Fri,  9 Jan 2026 00:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767917252; cv=none; b=HVi+9194ELiBq/1l4+1HI5rHc3W2Az2poa3HaLRTA/nIBZUQWIE2rsvofQRz2B5ONVIPJBoMOknaZp13uLBDCzfMbeWqnb+HBhNoe7WpeMeKVV97GMX579n85AsKFMbi2VRg47ENE0TKMVekQKG4537YZq+GtTa0s9A7Zb/PB28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767917252; c=relaxed/simple;
	bh=slaMzHuaaj5FePbxfjcaFwt2M1YRzPYQ5M2hknJhAVc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hkhwFpMbB/aGeLs32YfJMatwCsSUEirMxDgMSG3+JlXnb2u6A0cEPEIEfMYBps0kOIG6I3d9O3EGbh3wPg+Xa1QKWm+KuOPIyj64r+yagEJesr5U7PPFjStzaQBA47Ng0C/4ymWCJLymVngrrvbhyo0QtpuMSBJ9HyoPu7xZ4TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=N+wQbmHR; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1767917242;
	bh=slaMzHuaaj5FePbxfjcaFwt2M1YRzPYQ5M2hknJhAVc=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=N+wQbmHR5y48GEK6KFeiIzb0yna4jdsWZldpgaUYI0q+2pVMlUrzJcijbZPZQ5LmD
	 9q/XcTRNh3vLNeO2WOzgJ9FcqqFPFCxHOnsxlEisdUqvhKx1S6b/hQ5U+aEAkzcbq1
	 wb2j6xOu5pm9MHRU2Apt7Nr0cJQV0gJCLg5k5gCBwQf7yjsVPujJjYqRRxQ2IAP/1Q
	 mY+NK4rzG6mR4txXDpaYV1NMmTutr+BCRETBYHS27lg4Z437I5jNY6DeVrV609EcCL
	 iiIelv8aNd2O6ImSYPOuE00zBvDZr2HPPoYL4JJEW01RTSBZ+WzERR1DffoIlHWy1R
	 n1m8flsqqx4dQ==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 3FF327E142;
	Fri,  9 Jan 2026 08:07:20 +0800 (AWST)
Message-ID: <ea3db627f1d7fb4afb1d7b36253ff369341fbad3.camel@codeconstruct.com.au>
Subject: Re: [PATCH] net: mctp-i2c: fix duplicate reception of old data
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Jian Zhang <zhangjian.3032@bytedance.com>, Matt Johnston
 <matt@codeconstruct.com.au>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 09 Jan 2026 08:07:19 +0800
In-Reply-To: <20260108101829.1140448-1-zhangjian.3032@bytedance.com>
References: <20260108101829.1140448-1-zhangjian.3032@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jian,

> The MCTP I2C slave callback did not handle I2C_SLAVE_READ_REQUESTED
> events. As a result, i2c read event will trigger repeated reception
> of old data, reset rx_pos when a read request is received.

Makes sense. You're just invoking any i2c read from the peer controller
to trigger this, is that right?

Cheers,


Jeremy

