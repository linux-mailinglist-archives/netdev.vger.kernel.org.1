Return-Path: <netdev+bounces-98576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5318D1CD0
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4823E1F23645
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A8416F282;
	Tue, 28 May 2024 13:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f5L6pwjZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3A116F0F4;
	Tue, 28 May 2024 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902484; cv=none; b=SUB3gcpWLQK4eqfavhNIyPLUyiAGVSrKG/7KTEq4T+5UM8AvAzM0xVN4QLfv6MHUlJypGl+5UMslrshOs/NOwt85E3alWcStOMC4ThCN8A+O58jEl/WCqEbhwjGE/gVOPZ66nbUVo4aWFL7BXwQA8rV0DwIpJBERcnZgWy+1zig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902484; c=relaxed/simple;
	bh=xN17DrOG0FDUje+V37rDrgEQBArqB1WqYIU/EaCXBN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEqbonxFNDJrGXtdU7LZJMydvHk+1txq42N4XpUWfaCNM1Id6BxFQjdQm3aPJUXJy+oA0hQ1wWzZSD/X/MaZd7eHsujSYnPEv7Auag8chamRje7cdLaOeB2NFDxRp6LrD1pGG15mPGKdRkEG08cM7NdWl/eplScK3cCBewWhV1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=f5L6pwjZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=czokYyi0W54VxyNcd6w6h3/QqzXqnKZPzDpLPxCZmeM=; b=f5L6pwjZ7szzMMd61aNL9N3pOa
	7jw/7ztZTkCBUebQSy5i2gdXOPkpAcEySvQYdOBIze4bWKy53CiAgWr+AJUyov57gZhHnjpkfs9cD
	WS8HR5V9Ea7XcKjrAFM0uxn88y3KFYAYpvwHJnWKdq6t8NYk9W42Bcgk0d1fzosFOnDU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sBwl3-00G9s8-Mq; Tue, 28 May 2024 15:20:53 +0200
Date: Tue, 28 May 2024 15:20:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [net PATCH] net: stmmac: update priv->speed to SPEED_UNKNOWN
 when link down
Message-ID: <775f3274-69b4-4beb-84f3-a796343fc095@lunn.ch>
References: <20240528092010.439089-1-xiaolei.wang@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528092010.439089-1-xiaolei.wang@windriver.com>

On Tue, May 28, 2024 at 05:20:10PM +0800, Xiaolei Wang wrote:
> The CBS parameter can still be configured when the port is
> currently disconnected and link down. This is unreasonable.

This sounds like a generic problem. Can the core check the carrier
status and error out there? Maybe return a useful extack message.

If you do need to return an error code, ENETDOWN seems more
appropriate.

       Andrew

