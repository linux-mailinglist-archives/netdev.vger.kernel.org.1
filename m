Return-Path: <netdev+bounces-142475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6337D9BF4BF
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 19:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2721E283D5A
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 18:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FA9204089;
	Wed,  6 Nov 2024 18:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Xilc8MxY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428AB8C11
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730916116; cv=none; b=T4fDIrSRCjT+os5Oj28kqKqPr4anNkfjTX0btIhVp41Lw5vNm3HojvuT+npi4Z1Fr4jPyI/2XNWaxIeg7AcVueXGcol4CKZPc8nizmdfaaBaJORDuRgW4VVuHUwLuqK6u3bAUEbUQTxGAzfTyQ20WrQmWbk+e4UdrvkkLGn/tTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730916116; c=relaxed/simple;
	bh=5mrLtGE3OVS4snr2/kBU1QTEKYfHzqaEDax138VkFU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEQAmNk4qixn0jxF04hKpM2Ev3qQVjf9qFsis8wym1su58lGSYL+59YdbzSpXSZqms199AQVryhBwEVxmQJa9uCPAPAa84cg8DkWgblLLZehXga1y3+yC+Gb419NtTqB21dczV3LLxiHGuhHJKHBoYL7GdCWRFYGZY00L2FLnEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Xilc8MxY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oBMwvJLufnYVyoJJyTyr1p1cjy1efyzSZcCXwaNo1x4=; b=Xilc8MxYO0reXB9JCO/+nPHz1o
	BkUjwQLBU/tYhIPNi9WWBseIJdznUY5PsvRTc/roMsmuMjXH+b/hYHVOmbVbEjkwEKTAXA4NoxCFh
	vGbFISvQ/QU4UAJ8C9NmHscjYsUwtWBpUjVVGV6QLwexbzY+DE56uz69ATg3WBCWl/ro=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t8kLg-00CMfJ-F1; Wed, 06 Nov 2024 19:01:44 +0100
Date: Wed, 6 Nov 2024 19:01:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	horms@kernel.org, netdev@vger.kernel.org, mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com
Subject: Re: [PATCH net] net: txgbe: fix lost GPIO interrupt
Message-ID: <0312f05a-d2b1-466d-a0a2-9279544466bd@lunn.ch>
References: <20241106101717.981850-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106101717.981850-1-jiawenwu@trustnetic.com>

On Wed, Nov 06, 2024 at 06:17:17PM +0800, Jiawen Wu wrote:
> Sometimes when clearing interrupts for workaround in txgbe_up_complete(),
> the GPIO interrupt is lost once due to the interrupt polarity is
> consistent with the GPIO state. It causes the SFP state cannot be updated
> immediately. That is, SFP driver can only get into the correct state if
> the GPIO state changes again.

If i remember correctly, the basic issue is that your hardware cannot
do IRQ_TYPE_EDGE_BOTH? You try to fake it by configuring for
IRQ_TYPE_EDGE_RISING when the GPIO is low, IRQ_TYPE_EDGE_FALLING when
the GPIO is high. And then hope you can handle the interrupt fast
enough you don't miss an edge?

Maybe you should just accept the interrupt controller hardware is
broken, and let the SFP driver poll the GPIO? Do you really need to
know in less than a second the SFP has been ejected, or changed is LOS
status?

	Andrew

