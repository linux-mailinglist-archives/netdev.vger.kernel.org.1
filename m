Return-Path: <netdev+bounces-105519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4350A9118EB
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 05:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04181F22EA4
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 03:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1431B8528F;
	Fri, 21 Jun 2024 03:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PbsVJysu"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BF13207;
	Fri, 21 Jun 2024 03:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718939574; cv=none; b=acb4Bgd21TWdNxye/6wWcRouyQsgH2NGUM9XTpPkDBJjeNNp9bSxNYJKTWp59KNwp7I/LPYQvi8PkB4Lxuw8KIFRSZwPOT68GM+78LpJECmriXwzDd7HmsVAnwfUEljK8Vl6SKJeuWZI6QndhSRw0Rd7waaJddGX2yqlJIqf29I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718939574; c=relaxed/simple;
	bh=uCSUHcTauHBP6zOn6YHuV7MpFi2lKxVbRouK6xsPz4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXgmF7VbjD1NgqbVvUhCcKWLYJPGBltw8XDCfTX/sz0lmnSfGGkBAfEaZlbj7BbeaKzBPnrdNSRTFfsFcWNs1qCCKuCZcw+G/M+XmS/UilBI9UJCTnKMNqx9H2ljFgR+wXPpajvBigmslx+/NHgK+SwNaC09uAARCQ2IIByANsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PbsVJysu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WO33cNTPn9NUUeGGOkVxo3S92qWrXCg9qOPXQk9jSr0=; b=PbsVJysujVOHC+yOLzuwpAi3ei
	kTz4cujpB9sVSjqxrx9NKMH9EhttayUvRNN0/ZRe7iIFVr+iBK61p3IsPS1G1DsTohPGqWuk3re4a
	YfJhVyLlnH0ufsUZvlfJmzTfE+cdg1GcHdq2eSmNoTJixDxcDUxXHmYdkH2Bus/2KlKs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sKUhP-000cmD-QD; Fri, 21 Jun 2024 05:12:27 +0200
Date: Fri, 21 Jun 2024 05:12:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Furong Xu <0x1207@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next v1] net: stmmac: xgmac: increase length limit of
 descriptor ring
Message-ID: <788c2744-e1c0-4338-9b86-9119d31841f1@lunn.ch>
References: <20240620085200.583709-1-0x1207@gmail.com>
 <e3yzigcfbbkowias54nijvejc36hbcvfgjgbodycka3kfoqqek@46gktho2hwwt>
 <20240621102627.000060d6@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621102627.000060d6@gmail.com>

> Heavy incoming traffic on some heavy load system, the max 1024 limit defined
> by DMA_MAX_RX_SIZE in drivers/net/ethernet/stmicro/stmmac/common.h is too
> few to achieve high throughput for XGMAC.
> With this patch, ethtool can set a new length than 1024

Please include some benchmark results to show the improvement.

But at some point, more buffers don't help you. If you are
consistently overloaded, you will still overflow the buffers.  So you
might want to look at where is the bottleneck and how do you
prioritise processing packets over whatever else is loading the
system.

Maybe this would help, if the bus is the problem:

https://www.spinics.net/lists/netdev/msg1006370.html

	Andrew

