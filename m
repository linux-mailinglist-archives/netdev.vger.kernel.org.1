Return-Path: <netdev+bounces-187083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F82AA4DCA
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 15:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84929A4411
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 13:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE8825CC73;
	Wed, 30 Apr 2025 13:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hc0WgRX+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A58A1F941;
	Wed, 30 Apr 2025 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746020844; cv=none; b=RR8ydsKm6SYMyZK4R2OxnA0B6QXKCukmDaZAb4I5W4fgglpxV4l2x7kA9vj4alnhx90t849vR9ScBDrDW0CfukQ7SxlBP9GcSabKFtWefNFnIiygLY0u19mt2GlwsOeuo+JiMjUEt7gOMqgavUtijQmgclS+5EaA+B5V/R76MRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746020844; c=relaxed/simple;
	bh=GcaAoH6dCzAb1JlU5q+mHHRSvI+7/632P5/2toH8O4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psUPnY0+op2DPSQuBRRyBWJeQOL+PcopB4XytesE4yB3eq29TrlL+qQXjQvwr8xQwZ45nrpACufrzLVwtuIAkaXHfd8NGawb4JusyQw5l+RrZEPVNY37jdQO3rWuLPLWYplwq83jl3rW9q9s+CzWuxUAjg3p3C9nsHwrz34paSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hc0WgRX+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bZe3M9h06AUyxfr1GE/E1aMTE3+nPp9Fn4FTblSWCxg=; b=hc0WgRX+GldYgUM0Js+R/HNOJZ
	/IEulvL8GO5OO09VNy9TlYAvBwOZE6QtMaoIpEdNOlsBYPEYYDnwMKZ0XFU1b7ogmAKn2RGfz/k3n
	EWfib4KKIMWiBAMCRNTdF30XrOqbXP5RSeQs+ECYhze0cK6rB+P3G1bLgm126KLlPRxI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uA7m8-00BDmu-4o; Wed, 30 Apr 2025 15:47:00 +0200
Date: Wed, 30 Apr 2025 15:47:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net V2 4/4] net: vertexcom: mse102x: Fix RX error handling
Message-ID: <bd31ce70-4157-42fe-b398-f1ed6e188506@lunn.ch>
References: <20250430133043.7722-1-wahrenst@gmx.net>
 <20250430133043.7722-5-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430133043.7722-5-wahrenst@gmx.net>

On Wed, Apr 30, 2025 at 03:30:43PM +0200, Stefan Wahren wrote:
> In case the CMD_RTS got corrupted by interferences, the MSE102x
> doesn't allow a retransmission of the command. Instead the Ethernet
> frame must be shifted out of the SPI FIFO. Since the actual length is
> unknown, assume the maximum possible value.

I assume the SPI transfer won't get the beginning of the next frames
to make up the shortfall of bytes when the frame is short?

> Fixes: 2f207cbf0dd4 ("net: vertexcom: Add MSE102x SPI support")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

