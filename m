Return-Path: <netdev+bounces-189074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5F7AB04AA
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 22:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317B81C0613E
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 20:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCBE21CC64;
	Thu,  8 May 2025 20:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GrM7841/"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CD54317D
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 20:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746736286; cv=none; b=cOan6q6/p8TvCi+wq53jJ3ypzxxHbZhNGu0GaIq0bIl6GIWMCzKEmmyabS7belwoFFV86y0IKpIGS1JduL5XOyMhukhmYgxQcbY9ehGYzLgpvfR7jsjdWylX4HgJGzt6Ff8lvDgz3xJhbNaNXOsyiypmiheGzR1sVo/6u0l7qsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746736286; c=relaxed/simple;
	bh=gd0BwwG5w09uJhkXIDfgJ5Uk8ErI23tIU8/DzIlGpWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WpCu6oVWIT6/zJPt4My9VghXRQLfaTml/fw4+UwQ4awGJtXuHvReMtha0Xg3E8mKtw3qmmy28Z+w0SscU2NVQHG2VOXgpXuLYH9nCsfz2zd6mskUl56J0amBS6vE/nOIKSpZrihh5tuapHzhHeu7OsaO1x8J7/gxwdb9RHII1R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GrM7841/; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <69734ded-6f49-417f-b3ef-eaddc61c7246@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746736273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7WWdi9wi8qFaUHGCCi3RkcRTzpU0CevyoRiGyfseR4g=;
	b=GrM7841/JkvbH0/6b2EJpD6DM+YozbVXnNIu2z1+ZYy6aZ0nlZPi9tNVMyV5aM5r8Ex0dH
	6E5Psd8ZCurd5y2gMV6Q712izo2J9BednRnfUtk0gsXZTGvgBJz1S96QlgUW5b4yFt2ORk
	hjKdTmtJ6+K90M3kS1b6qas3mgv8jJo=
Date: Thu, 8 May 2025 21:31:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: enetc: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Claudiu Manoil <claudiu.manoil@nxp.com>,
 Simon Horman <horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20250508114310.1258162-1-vladimir.oltean@nxp.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250508114310.1258162-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/05/2025 12:43, Vladimir Oltean wrote:
> New timestamping API was introduced in commit 66f7223039c0 ("net: add
> NDOs for configuring hardware timestamping") from kernel v6.6. It is
> time to convert the ENETC driver to the new API, so that the
> ndo_eth_ioctl() path can be removed completely.
> 
> Move the enetc_hwtstamp_get() and enetc_hwtstamp_set() calls away from
> enetc_ioctl() to dedicated net_device_ops for the LS1028A PF and VF
> (NETC v4 does not yet implement enetc_ioctl()), adapt the prototypes and
> export these symbols (enetc_ioctl() is also exported).
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Again, extack can be potentially used to provide some info in case of
enetc_hwtstamp_set() fail, but in this case it's more obvious.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

