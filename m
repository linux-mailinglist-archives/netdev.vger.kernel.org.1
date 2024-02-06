Return-Path: <netdev+bounces-69535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F270F84B999
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 16:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 317A11C235F8
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8E2133431;
	Tue,  6 Feb 2024 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gyfa5wvt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF9B12B14D
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233369; cv=none; b=pPLpeyTpWoh7RBSs8qTFB+muTmmhTjQ08wOSoCo+Vzgbb+qbJBRxr3GrmHyHP9LZ7Mdfnp9K4CoXQtOnSyBsIMiTbmNI662zR+GcTNtqyAlfO9rWcYP+DWvNWATNpO9FNnIw8/JkJ0xtwJXp/02mg4LSELL0wjmnR7qGuqxSkTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233369; c=relaxed/simple;
	bh=yKBiIG9BG+Q7j6QRZoyKWECEwh2S2tJ8ZY9vaXCGYao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fClwBvF84HLVmegTj2BrWgjOXxWch3IGwK+YHmc29RKVQJdDDbohjimWURulQbOVCpktuS+XMdwAWIMzIrgHft0DiI5ubEUELgwQuilcU7TMF+WMcwXlLK28NllP1MinO6HZsALhjttP81j7q02L+Iy62P3A9u1qwrHe0xH8vIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gyfa5wvt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=y77cc7ydr1ZSgBVmSGezYHmzr8PjwperPu32cwCQL0M=; b=gyfa5wvtGLWJSShDoDQJRwunhf
	CX124KYAVdSreYAP7IBSw8ki6CyGrPXnN1MYoqhItiGTIPmgmAhiD+k1+DnMohCmAL4fJpF8+nzW2
	ltJUvQI6J6u1hJcNOx3Y1/gHTq0a96F5E12CvEpbDkhWx4zz8WOOFzKLQ/uv3pX7mitQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rXNNn-0079Jb-Ug; Tue, 06 Feb 2024 16:29:11 +0100
Date: Tue, 6 Feb 2024 16:29:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, maciej.fijalkowski@intel.com,
	netdev@vger.kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH] net: txgbe: fix GPIO interrupt blocking
Message-ID: <9259e4eb-8744-45cf-bdea-63bc376983a4@lunn.ch>
References: <20240206070824.17460-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206070824.17460-1-jiawenwu@trustnetic.com>

On Tue, Feb 06, 2024 at 03:08:24PM +0800, Jiawen Wu wrote:
> GPIO interrupt is generated before MAC IRQ is enabled, it causes
> subsequent GPIO interrupts that can no longer be reported if it is
> not cleared in time. So clear GPIO interrupt status at the right
> time.

This does not sound correct. Since this is an interrupt controller, it
is a level interrupt. If its not cleared, as soon as the parent
interrupt is re-enabled, is should cause another interrupt at the
parent level. Servicing that interrupt, should case a descent to the
child, which will service the interrupt, and atomically clear the
interrupt status.

Is something wrong here, like you are using edge interrupts, not
level?

> And executing function txgbe_gpio_irq_ack() manually since
> handle_nested_irq() does not call .irq_ack for irq_chip.

I don't know the interrupt code too well, so could you explain this in
more detail. Your explanation sounds odd to me.

What is the big picture problem here? Do you have the PHY interrupt
connected to a GPIO and you are loosing PHY interrupts?

	Andrew

