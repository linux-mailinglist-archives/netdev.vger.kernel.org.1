Return-Path: <netdev+bounces-111604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF8F931C38
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 22:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C95A1C214AA
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 20:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1872113B5B6;
	Mon, 15 Jul 2024 20:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iZDLEJK5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2606013A3E8;
	Mon, 15 Jul 2024 20:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721076449; cv=none; b=EHOnTNS9ChABFutMuhyS4NLnaeFF0aRoV07h18rVrcj5YF/nqXnVkWknpJEM+dG9q5o7ouZ0rR2Gk6oC3JeE4777A9JtlZmVGHZBZRdssdtadEkf1t9dFSWAkwqswYjvZ50ZMWhdX9FboreyJe6MmKZJJ7EmPbI5T5VQpwqZHNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721076449; c=relaxed/simple;
	bh=pb2oCnJWKQIhzo9wXBYUYrMHHmaf+b7rPM/tkxJu0Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGI/0OEyiEk3Uh9qO+56E3/DDPo8MG70+g4t2J8HZIDlZtPBHiOThkJms0woN/+0JQxlHH0Hi3n1j120itCEIfjRmYTX6UpfcMgdUKM0jP9QzvS44gziecHQVOXrrC0AnVHhCkJ3b80XhhFnIiZV4IWbkmjaVcC0uot0O5edXGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iZDLEJK5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=h6mb+ttP+p/S1IA97Zq2CR38QMY+RuQZ7bDACOxXijc=; b=iZDLEJK5uOykGDsmQ7TeUDkAh1
	/HTAGLtLV5/6VdX16fRGRkZVQv3G0iQiDvdtE4k/VQHJ1IsGz/QeFizK4W1EIo1uGaZQZq4P9Xxvv
	eCRpjeJb/+b1yTJRmHtDFfjfjuFdA11/NNz07vSH9K2V1bt5wZGUdNEWYFNdcOOPwpLw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sTSbN-002bAW-Hr; Mon, 15 Jul 2024 22:47:17 +0200
Date: Mon, 15 Jul 2024 22:47:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Shenwei Wang <shenwei.wang@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH net-next] net: fec: Enable SOC specific rx-usecs
 coalescence default setting
Message-ID: <6521b6ed-ed67-469e-9cc8-b08c489cba10@lunn.ch>
References: <20240715195449.244268-1-shenwei.wang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715195449.244268-1-shenwei.wang@nxp.com>

On Mon, Jul 15, 2024 at 02:54:49PM -0500, Shenwei Wang wrote:
> The current FEC driver uses a single default rx-usecs coalescence setting
> across all SoCs. This approach leads to suboptimal latency on newer, high
> performance SoCs such as i.MX8QM and i.MX8M.

Does ethtool -C work on these devices?

Interrupt coalescence is more than latency. It is also about CPU load.

Does NAPI polling work correctly on these devices? If so, interrupts
should be disabled quite a bit, and then interrupt latency does not
matter so much.

Have you benchmarked CPU usage with this patch, for a range of traffic
bandwidths and burst patterns. How does it differ?

> For example, the following are the ping result on a i.MX8QXP board:
> 
> $ ping 192.168.0.195
> PING 192.168.0.195 (192.168.0.195) 56(84) bytes of data.
> 64 bytes from 192.168.0.195: icmp_seq=1 ttl=64 time=1.32 ms
> 64 bytes from 192.168.0.195: icmp_seq=2 ttl=64 time=1.31 ms
> 64 bytes from 192.168.0.195: icmp_seq=3 ttl=64 time=1.33 ms
> 64 bytes from 192.168.0.195: icmp_seq=4 ttl=64 time=1.33 ms
> 
> The current default rx-usecs value of 1000us was originally optimized for
> CPU-bound systems like i.MX2x and i.MX6x. However, for i.MX8 and later
> generations, CPU performance is no longer a limiting factor. Consequently,
> the rx-usecs value should be reduced to enhance receive latency.
> 
> The following are the ping result with the 100us setting:
> 
> $ ping 192.168.0.195
> PING 192.168.0.195 (192.168.0.195) 56(84) bytes of data.
> 64 bytes from 192.168.0.195: icmp_seq=1 ttl=64 time=0.554 ms
> 64 bytes from 192.168.0.195: icmp_seq=2 ttl=64 time=0.499 ms
> 64 bytes from 192.168.0.195: icmp_seq=3 ttl=64 time=0.502 ms
> 64 bytes from 192.168.0.195: icmp_seq=4 ttl=64 time=0.486 ms
> 
> Fixes: df727d4547de ("net: fec: don't reset irq coalesce settings to defaults on "ip link up"")

Fixes is not correct here. It was never broken. This is maybe an
optimisation, maybe a deoptimisation, depending on your use case.

And next-next is closed at the moment anyway.

	Andrew

