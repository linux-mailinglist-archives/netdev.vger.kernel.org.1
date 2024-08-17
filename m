Return-Path: <netdev+bounces-119438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0014B955955
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 20:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FA241F212BE
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 18:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427AB139580;
	Sat, 17 Aug 2024 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="quwVD0Pw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CB37442F
	for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723921043; cv=none; b=X/i+1WYXatTVSz8/w8qSV5AJRFCp3FNO4Pfrga09e8sXLx13lzqCzzx0Ii7HCK6XNtvwjrWdN0lW4jETZXRtN2hX8om4JeJVHGBPtTe8vExscbw1vqsSqkjIa5vQXfEtXeamU9NLFsk4yEtrquqzUwv9IqQK+eEQAS1u5A4QjDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723921043; c=relaxed/simple;
	bh=Xb6eieCCadbcimuR1YGLNH+2oi+KMuAN69El5E8L8xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODm1rms7WPwMMCAybk18Za1Qu2gozDG2KLk4YezSvBu1ly6BcQw6uMwdaLR+VLnD6eQQshNKMt0Ff/HaD4bTQLRZ5Lah1HLD5SSxpkEqTKz7lQXY0M0/AxAhsyjvbJyEh8JD7kL/yTXr8byG2jegO2kal8OGkdsZkxj7dJBqJA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=quwVD0Pw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qP13pn4KXZ6QAVGU+5hujIzNapNlvhBDGwMqkEUG/9M=; b=quwVD0PwJNaTEXMgI7eiQ6uw3u
	TwbOc9PJ7O9JztvKX5jcY3tm2Xfae/ZTkARGr3+KcIfidUyhDbmTlIYpQp3QtKd8j4sFlbzz+5zT7
	8ZGabi1HV/n4oQqveHEfVy4bXervfy7tERV9uSyc7JQHbAQZJoAryxXB/beuD669FlNI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sfOc2-0050gj-JA; Sat, 17 Aug 2024 20:57:18 +0200
Date: Sat, 17 Aug 2024 20:57:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Martin Whitaker <foss@martin-whitaker.me.uk>
Cc: netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	Woojung.Huh@microchip.com, ceggers@arri.de,
	arun.ramadoss@microchip.com
Subject: Re: [PATCH net v2] net: dsa: microchip: fix PTP config failure when
 using multiple ports
Message-ID: <ab474f83-aaba-4fe9-b6b7-17be2b075391@lunn.ch>
References: <20240817094141.3332-1-foss@martin-whitaker.me.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817094141.3332-1-foss@martin-whitaker.me.uk>

On Sat, Aug 17, 2024 at 10:41:41AM +0100, Martin Whitaker wrote:
> When performing the port_hwtstamp_set operation, ptp_schedule_worker()
> will be called if hardware timestamoing is enabled on any of the ports.
> When using multiple ports for PTP, port_hwtstamp_set is executed for
> each port. When called for the first time ptp_schedule_worker() returns
> 0. On subsequent calls it returns 1, indicating the worker is already
> scheduled. Currently the ksz driver treats 1 as an error and fails to
> complete the port_hwtstamp_set operation, thus leaving the timestamping
> configuration for those ports unchanged.
> 
> This patch fixes this by ignoring the ptp_schedule_worker() return
> value.
> 
> Link: https://lore.kernel.org/netdev/7aae307a-35ca-4209-a850-7b2749d40f90@martin-whitaker.me.uk/
> Fixes: bb01ad30570b0 ("net: dsa: microchip: ptp: manipulating absolute time using ptp hw clock")
> Signed-off-by: Martin Whitaker <foss@martin-whitaker.me.uk>
> Cc: stable@stable@vger.kernel.org

One stable@ is sufficient. Did i mess that up when i asked you to add
it?

Apart from that:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

It is better to put your Signed-off-by last, because each Maintainer
handling the patch appends there own. So it keeps them together. But
there is no need to repost.

    Andrew

