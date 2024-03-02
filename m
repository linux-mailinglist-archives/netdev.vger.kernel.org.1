Return-Path: <netdev+bounces-76828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6353C86F103
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 16:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 140941F2181D
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 15:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C74E179BC;
	Sat,  2 Mar 2024 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oJZbKrFT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73847E8
	for <netdev@vger.kernel.org>; Sat,  2 Mar 2024 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709395158; cv=none; b=VhbqxnDu9eNzrRwZIS7KAqSCT8J48hz+QHbfcL9xKZ2WUh4RPfaufr5eHMunFt+1wZboKaYb8kp/Wyo1MqwocB6Sk8jvrVKq4aHFhD5mRWNBPPhGAMedEsvYlz9lAkLmJ188j6f/t8vckZB5kpSwyFopq0ACYxclsLUZTtWK6YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709395158; c=relaxed/simple;
	bh=G6LlD7qCd7SpGQ6DRWk8SSaLyrn/9K2Ain8u825jBKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhbEDR/qo86y8qD+lVci+Z3CX0LVEjQu9eWHcs24dijZy7bHd/cPlWuVcJIaEzG486Sw5mnze/wLQd8w26z8amLaOdL07DpEZnBE8rBqUBkinLjF+Cuxn2JhjVYs00gpZWtCt8sUvHOzYC2Z61zS6uH5h/TvbnCIayAU0yHm3Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oJZbKrFT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dQiVYgANK05QlsuCL/5Qzx0OucN3+2xDZ+JUskNT1IY=; b=oJZbKrFT5BUTLpPmeHTaYudbng
	vhuxh7GrECDqP4HT0AZGMgCWq2Sk1kNuZ2k6BPU4YE+UYGJQKtxVJYiT2Fc2j8IyA9FypF0bVQtP3
	OXZrsiOWuyB2246GYaq+tICwAkYtUy5twSktfihiTd/n3fQbcNuWWbg5X5X4O179NNJc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rgRll-009Cke-Nu; Sat, 02 Mar 2024 16:59:25 +0100
Date: Sat, 2 Mar 2024 16:59:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net-next] ethtool: ignore unused/unreliable fields in
 set_eee op
Message-ID: <6ca4202e-831f-4d9a-8f32-78dee21ac578@lunn.ch>
References: <ad7ee11e-eb7a-4975-9122-547e13a161d8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad7ee11e-eb7a-4975-9122-547e13a161d8@gmail.com>

On Sat, Mar 02, 2024 at 03:18:27PM +0100, Heiner Kallweit wrote:
> This function is used with the set_eee() ethtool operation. Certain
> fields of struct ethtool_keee() are relevant only for the get_eee()
> operation. In addition, in case of the ioctl interface, we have no
> guarantee that userspace sends sane values in struct ethtool_eee.
> Therefore explicitly ignore all fields not needed for set_eee().
> This protects from drivers trying to use unchecked and unreliable
> data, relying on specific userspace behavior.
> 
> Note: Such unsafe driver behavior has been found and fixed in the
> tg3 driver.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

