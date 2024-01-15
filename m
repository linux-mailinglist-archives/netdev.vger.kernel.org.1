Return-Path: <netdev+bounces-63592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE0A82E2A7
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 23:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B311F22E27
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 22:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B6B1AADC;
	Mon, 15 Jan 2024 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jUx4kP2p"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91636FBB
	for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 22:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tDsYvMAqNr656GRccaqV8B+ylmOycH6aIoFk3Qctzx4=; b=jUx4kP2pUVHK8ifi0M1RT69zXR
	3YrARSqxvMzjHy1+cYHuBm+J2HeW7grJ9eiYkXfOMogWGZGAxgxpWB0LwOPtofQVRpb4CqmfaNAYq
	7XwqKPV0RihPgSKQEoU4mE1gK6yHuzwdx+5uV0XSKYnOXltZuP2l2K0qmeUTzeiJTKy0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rPVaG-005GpN-8r; Mon, 15 Jan 2024 23:37:32 +0100
Date: Mon, 15 Jan 2024 23:37:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux@armlinux.org.uk, horms@kernel.org,
	netdev@vger.kernel.org, mengyuanlou@net-swift.com
Subject: Re: [RFC PATCH net-next] net: txgbe: use irq_domain for interrupt
 controller
Message-ID: <82534d84-0acf-4ada-9a65-4e5089dff890@lunn.ch>
References: <20240115091621.23312-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115091621.23312-1-jiawenwu@trustnetic.com>

On Mon, Jan 15, 2024 at 05:16:21PM +0800, Jiawen Wu wrote:
> Use irq_domain infrastructure for MAC interrupt controller, which above
> the GPIO interrupt controller.

What is missing from this description is an answer to the question
Why?

> +static void txgbe_misc_irq_mask(struct irq_data *d)
> +{
> +}
> +
> +static void txgbe_misc_irq_unmask(struct irq_data *d)
> +{
> +	struct txgbe *txgbe = irq_data_get_irq_chip_data(d);
> +	struct wx *wx = txgbe->wx;
> +
> +	wx_intr_enable(wx, TXGBE_INTR_MISC);
> +}

This looks odd. You can unmask an interrupt, but you cannot mask it?
Also, typically, an interrupt chip has multiple interrupt sources. d
points to one source. You typically need to look at d->hwirq to
determine which interrupt should be masked/unmasked.

	Andrew

