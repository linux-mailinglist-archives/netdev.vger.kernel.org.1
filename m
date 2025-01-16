Return-Path: <netdev+bounces-159035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1695AA142DF
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 21:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EC997A2376
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 20:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF55B1DDC16;
	Thu, 16 Jan 2025 20:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RHP6CIuC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E741926AEC;
	Thu, 16 Jan 2025 20:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058589; cv=none; b=NySQ6hYF+6RP+gJqZl46p1KKCwTHRJXiswy+pOyJH6TxVKtuV+JX9B/W9LaUSjgw/P108oPo4s7uJaE/SYDoV9OuixKei1i07IFajcD3I42n2hjM38U6AOxRLZZ9IcglxLzOR3GLXeK1s7K9Utpjuer3Yzm9CEqLQ7IN3RgkRtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058589; c=relaxed/simple;
	bh=1JE+ymPgq9mt5oWcmIP5doFiILO2bPYks3EqHl6e5RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o90TlDWPUYwlhPXd9fIA/Fv8ZRAlwuDrYS/aP2MIaA1NBX45BUoNqPWrkHzBud5+CQZ9AItZVLbzEPXBH3ScgIvY6UOo30Kk8aBVb5eWgRER6ENg5eS00g0K4qW3nPV25B9w64NVMBZaucqGvCAdN4L2B9/EHgIs3/tGiPPBQmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RHP6CIuC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qTn0XJzLZzbvEDnsM9fN083POcmzoNp1hBp9n5GW3D8=; b=RHP6CIuC9TA9hnSf9xr3gZ/SMT
	e7Iblvyxkl6dFUGN/wB1huW3vyFA7bshkOJnWiUOJWF69i47V+TstW3fqKClqDJkq3zHUWBXO/jpt
	n+7sUCKnnZ7O2/lkrgYlGDI/S7mL0jxi7z6x2jHhej6TS1GZUqir6fq5ckNJFDdUw5V0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tYWHg-005E3N-W1; Thu, 16 Jan 2025 21:16:09 +0100
Date: Thu, 16 Jan 2025 21:16:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: stmmac: Limit FIFO size by hardware feature
 value
Message-ID: <636bad71-8da8-4fda-a433-1586d93683a5@lunn.ch>
References: <20250116020853.2835521-1-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116020853.2835521-1-hayashi.kunihiko@socionext.com>

On Thu, Jan 16, 2025 at 11:08:52AM +0900, Kunihiko Hayashi wrote:
> Tx/Rx FIFO size is specified by the parameter "{tx,rx}-fifo-depth" from
> the platform layer.
> 
> However, these values are constrained by upper limits determined by the
> capabilities of each hardware feature. There is a risk that the upper
> bits will be truncated due to the calculation, so it's appropriate to
> limit them to the upper limit values.

Are these values hard coded in the platform layer? Or can they come
from userspace?

If they are hard coded, we should also fix them. So maybe add a
netdev_warn(), and encourage the platform maintainers to fix their
platform. If they are coming from userspace, we should consider
failing the ethtool call with an -EINVAL, and maybe an extack with the
valid range?

	Andrew

