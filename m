Return-Path: <netdev+bounces-189105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4601AB063B
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 00:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9AE71B63B79
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 22:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A7821883C;
	Thu,  8 May 2025 22:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F5rczkk+"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC22221545
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 22:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746745012; cv=none; b=YzEKdVq+c5SVtuLas6mf3nO0ewBuRem1BC7SXfQcA6BtrQ6xIqq7uikG2FUuF6p+E4k1Oo8FM30P4OujO/ixDc59gVa9Jm5lyseS5BD2KI9HHvdNRzKfvYvlrD2Lr2gfvRYSK3rDV2EtJPmE2XBLGUopVHql1aGBQsXKSRoOiVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746745012; c=relaxed/simple;
	bh=iFCO7o1BQBmI/zTqCCB28E79OXy49cfWibq+yBtS1SI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qhy6BlALcSt9c/WTYTelRyOVs1kTzSOUoA02cFxYVtJM0e963WoE3F1NXin1/JpR9vQQGZDI34EsWy8PfjD1wclvW4uZk5XKhH+fnu78eFGHIvkXRkSySAWnsOC6EEuTNKi509m935M5/GI+d951aGobKdL0fL4sG28oBRKrrAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F5rczkk+; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5844d56d-ebea-4a21-8c5d-8eb2318fffdb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746745008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pv7G2L9oei63v6C3lGld30dsvBtB1rmNQ2MtP6VeKnU=;
	b=F5rczkk+0zQcW9kVD8RKRWPFJUcqO0+JmLnhTeQfeL7QJ93H/IJTLaHAlSkYPzvDae6T8U
	Rqhtf7sFGjeEAayXlnNj3u52pprlaakDiPjEvRmpSEdayWZDgZVfQo5ALs5VhuY1ha41Kj
	zHYHWp3D0ZEDZmLo+F8i/zjHGWAW6mI=
Date: Thu, 8 May 2025 23:56:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: mvpp2: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Claudiu Manoil
 <claudiu.manoil@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20250508144630.1979215-1-vladimir.oltean@nxp.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250508144630.1979215-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/05/2025 15:46, Vladimir Oltean wrote:
> New timestamping API was introduced in commit 66f7223039c0 ("net: add
> NDOs for configuring hardware timestamping") from kernel v6.6. It is
> time to convert the mvpp2 driver to the new API, so that the
> ndo_eth_ioctl() path can be removed completely.
> 
> Note that on the !port->hwtstamp condition, the old code used to fall
> through in mvpp2_ioctl(), and return either -ENOTSUPP if !port->phylink,
> or -EOPNOTSUPP, in phylink_mii_ioctl(). Keep the test for port->hwtstamp
> in the newly introduced net_device_ops, but consolidate the error code
> to just -EOPNOTSUPP. The other one is documented as NFS-specific, it's
> best to avoid it anyway.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

