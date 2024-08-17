Return-Path: <netdev+bounces-119434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC91695594D
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 20:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03ADA282326
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 18:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8217815359A;
	Sat, 17 Aug 2024 18:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="w+wcCaUf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB485225A2;
	Sat, 17 Aug 2024 18:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723919953; cv=none; b=HMC2kzQECUcQwIG9ZxBd2m4/jv8PzcpckTn6KcOtJ6dCYnVk1FEqsBaYFDTnmUdbgYvOqsk6pKrxUPP2zqUEtLwAUmY9dDT2DEq88PV7gRCag7hOj2oYDq6se3kZAuNlVXoNqv1sy1a7PBLbjSmiwAt8TqOWXHsgA+U1KL6G2qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723919953; c=relaxed/simple;
	bh=RBOqHWcpOL200wMzaRpoDYXleqvQIbaH30VxNbJAsxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlfh5KycsVW2i5yong5AQv43iAVgbraXUzLH2dwHow03VbK/F6ASyR4q2GxaFwzhssTOQXgRCRLwwEu/FZhQOAq2yF2Cf4Iky91VT9h4T+QS2W82/kafaOizkA+KG6ux8pk8XyytlMOtmYKtAfAtQ4Cd1AJic/73qQYX9eMdbrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=w+wcCaUf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Wa5LEgwkZY0FD5bZdQisEp2BTUIPn539FfsMHm+YsHo=; b=w+wcCaUfK7heUmNoKPawgyetpe
	OuBZE5dp4+sJucaQBuIc2K8EjnQvaUrUmaZ2NGK6+PYkIXsBSXye4mX57p5bgsgtHwV9cavdsQvvr
	gHTqB0ACKjhvFPpFGYRos/IV8MMGP7+3cHJkpiWFb1Gty7RyD5D34qu9Lv1FyJfHYqbw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sfOKL-0050bg-Dx; Sat, 17 Aug 2024 20:39:01 +0200
Date: Sat, 17 Aug 2024 20:39:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de, nbd@nbd.name
Subject: Re: [PATCH RFC net-next] net: ag71xx: disable GRO by default
Message-ID: <981a8ff4-d4f3-4e1c-8201-d7331ae29f96@lunn.ch>
References: <20240816224741.596989-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816224741.596989-1-rosenp@gmail.com>

On Fri, Aug 16, 2024 at 03:47:33PM -0700, Rosen Penev wrote:
> ```
> Currently this is handled in userspace with ethtool. Not sure if this
> should be done in the kernel or if this is even the proper place for it.
> ```

Comments like this should be placed under the ---. If the patch is
merged, anything in the commit message under the --- is then
discarded.

> ag71xx is usually paired with qca8k or ar9331, both DSA drivers.

Can it be used without a switch? It looks like this option will
disable offloads which are useful when there is no switch.

	Andrew

