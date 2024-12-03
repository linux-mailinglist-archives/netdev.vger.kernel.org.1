Return-Path: <netdev+bounces-148675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49A79E2D55
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A131328322F
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 20:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B2A20ADFF;
	Tue,  3 Dec 2024 20:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xjAGdC1k"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E29207A07;
	Tue,  3 Dec 2024 20:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733258364; cv=none; b=rvXAcav1H6lB3LiU/Ol7PITx3ezB7ccrburDGQtVHoIm2heqEGWu9xMnY5MU2lQvfg0cw1bMLAxZzQYWR2UPUzb2x9AexWkAr/f5CX/JXEXFdzsNz1xWLxEVaQWFl0sE9r7fw5bbDkO7FSBsLV+ezEpJ9gieMVnLSjYvW8AjFr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733258364; c=relaxed/simple;
	bh=aVyWxQcvFjscgZQc04NKaDuf8D5sd+LHmLddW6muEm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBZjvZgyIYUwsGXbLB/UAExfYlTzM27X8MWkGpt6JBbs6VLz09r+4cV6BfhdzotuPRMtB3HjNVhLBcqZN7TDiIhXG8jmxDmqO6bqQ/oQdJWwIheRh4z+X51cOjFQ+w7WcwEA6IRfDAo3M6ARH59qoyvGsRdxLTibQCN2Uqn34s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xjAGdC1k; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JxzLbCSZRbRhuiuslwR2W5ynZnxAOaOKWdk4+/+OIfs=; b=xjAGdC1kQiELBl1TERZPSAWkMS
	2tFWehz7pef3T6BmUwyoDz4Ev57enNl1ecSS2WK8sa43V+SX5eW9p3bzY9UJ/9BXkpTG7QXBQ3tMt
	a8/8jqZavKjTEIT18f2+r9qBWR2LIis6jFif5QtLyZTLYnzGfFdXS7sXLadxcckDPAsk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tIZfx-00F8EE-7n; Tue, 03 Dec 2024 21:39:17 +0100
Date: Tue, 3 Dec 2024 21:39:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v1 10/21] net: usb: lan78xx: Improve error
 handling in dataport and multicast writes
Message-ID: <76e22c46-6c7e-4709-b4c5-594bc839c450@lunn.ch>
References: <20241203072154.2440034-1-o.rempel@pengutronix.de>
 <20241203072154.2440034-11-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203072154.2440034-11-o.rempel@pengutronix.de>

On Tue, Dec 03, 2024 at 08:21:43AM +0100, Oleksij Rempel wrote:
> Update `lan78xx_dataport_write` and `lan78xx_deferred_multicast_write`
> to:
> - Handle errors during register read/write operations.
> - Exit immediately on errors and log them using `%pe` for clarity.
> - Avoid silent failures by propagating error codes properly.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

