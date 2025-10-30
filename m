Return-Path: <netdev+bounces-234265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3171EC1E545
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 05:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81953B6D9F
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 04:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6182EACEF;
	Thu, 30 Oct 2025 04:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="mbQNOEcM"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6188723F42D;
	Thu, 30 Oct 2025 04:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761797608; cv=none; b=uM76EXOmG/pJODFmWZVP4IqQc5ZMOnspcR++qZAp2fxEIRPAjthLE/N8qaU2GvaFHrAdD/94Kd7hCvGXyRsf/+L0kniAxcm/ht7remc2RB113HmdaNxss0bhMsZJpGBt1K71VKI/ZhRAeV4miLF6mcBfSV8R0ToNx2BQbdRMwi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761797608; c=relaxed/simple;
	bh=cJeYb9u6VkHP5W7lpdpCnObrTqkT19FaCQNUI3AOvxM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CdQ1es/FqRiHVXUny6V4ZZBXRvEgnJO+FJ/yw8MxdHD5XHJJhdi6mExT97D5FZEr5/vw2vuHvmhedLZzfc8pHuQqy0KNDaZg16DO3stTTLevTUoXr9H5NPuTeMD6gTGlPH4YSCNmxfJsxfnYHLrj/F1XDvBLbtGfJ2PSe5LV5pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=mbQNOEcM; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1761797602;
	bh=cJeYb9u6VkHP5W7lpdpCnObrTqkT19FaCQNUI3AOvxM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mbQNOEcMEYOr6a714d8/0UHWK2Tfp5+09uBZCVyu5LFe4X5BZhiiWRh1UOmoPlzW0
	 OXKQMr1hdEB2PwpHTjlZ+PrZ26hfEKYeKW2pYF1HvOlCXaMT03zgsbkPa2Q6XBuUE4
	 o+EfwnZa/zTHjgCCwwWNQFUWf2Fc2JpYSyV3XJKUD0JUWyTwsaYkJ5e+2A0qL9xnb1
	 y9c8+Wg4soZ9ekdXzUkaJCyUkjq8n8m4nvI8jDfjdwAoEuWQeHk4BwE7K9mECvSZr7
	 xZHjNOOSt1b3sV10tSLB2pSqZHNhEgr6h65zYc37TpK5f9l5N1q0wu+H8odWhw5+yv
	 MDNVxrZ/P+DTQ==
Received: from [192.168.14.220] (unknown [144.6.157.237])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D4C8A79118;
	Thu, 30 Oct 2025 12:13:20 +0800 (AWST)
Message-ID: <3b38dd392e06dc7d187c5bb247418bf189180a1e.camel@codeconstruct.com.au>
Subject: Re: [PATCH 2/4] net: mctp i3c: switch to use i3c_xfer from
 i3c_priv_xfer
From: Matt Johnston <matt@codeconstruct.com.au>
To: Frank Li <Frank.Li@nxp.com>, Guenter Roeck <linux@roeck-us.net>, Jeremy
 Kerr <jk@codeconstruct.com.au>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Mark Brown
 <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-i3c@lists.infradead.org
Date: Thu, 30 Oct 2025 12:13:20 +0800
In-Reply-To: <20251028-lm75-v1-2-9bf88989c49c@nxp.com>
References: <20251028-lm75-v1-0-9bf88989c49c@nxp.com>
	 <20251028-lm75-v1-2-9bf88989c49c@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-28 at 10:57 -0400, Frank Li wrote:
> Switch to use i3c_xfer instead of i3c_priv_xfer because framework will
> update to support HDR mode. i3c_priv_xfer is now an alias of i3c_xfer.
>=20
> Replace i3c_device_do_priv_xfers() with i3c_device_do_xfers(..., I3C_SDR)
> to align with the new API.
>=20
> Prepare for removal of i3c_priv_xfer and i3c_device_do_priv_xfers().

Acked-by: Matt Johnston <matt@codeconstruct.com.au>

