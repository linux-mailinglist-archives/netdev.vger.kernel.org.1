Return-Path: <netdev+bounces-244903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA266CC14BD
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 08:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4D843033715
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 07:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E669532B9AA;
	Tue, 16 Dec 2025 07:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LzQ/G/NB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482A83191B7;
	Tue, 16 Dec 2025 07:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765869701; cv=none; b=Vmt9iMQiivBW2AZnTAlcyBJeopO3BClj+bk4LMyB4E8/Ivf/0RGmXp00GhreLE6xNlXxvAPbYGuehmx62Umhob6QqBnKIqVRLYJnU+4rBqge4vX1b9oU9gmPWZqL2CRMCHRKlEjDyJC27PgE9FhqZFF/Da0q7pQI0Y2rZ49KsXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765869701; c=relaxed/simple;
	bh=uXFTfHR2wqqRf1SFTf8PJjhWpeWZ0CLwMfUoOoOHdnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mItN3OYn/EXHcgguwMxV2Lvxcec2DYWEreS9vQly5rq6BPqWwC1N97z2VP9p7AojA+dQ7p7LtFU0v1nRBqY4QF5z5KmTbhDhARqT3cqciS4nsd+B1sWq1n59+XWtIKtLlxwmDFl7qjrdCnzv03++MtqdwD82tesfepPdjmkduwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LzQ/G/NB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IX5RTmAfTnrwSDTueLgmdGx+dwMsA2t+I3EZ0qw9TFk=; b=LzQ/G/NB+wflg7Lpl/voqDuZkv
	Wwy/7wcQvkF2wJsTUAclrnYfwRIKS1xOqihNDIra/1MoKhOE3TeaIFUPIIBvXUuCotMfcfJNmjd7j
	RDADL/xvUnwX+UxLDXLC4YUTGmT8cFUnPQ/RKXyps9i5LNh6lC8XU11KPh6OvV0yPYSs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vVPN7-00H5Rj-1T; Tue, 16 Dec 2025 08:21:25 +0100
Date: Tue, 16 Dec 2025 08:21:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	Frank.Sae@motor-comm.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, salil.mehta@huawei.com,
	shiyongbang@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 6/6] net: phy: motorcomm: fix duplex setting
 error for phy leds
Message-ID: <d8b3a059-d877-4db6-8afb-3023b8ee5fa3@lunn.ch>
References: <20251215125705.1567527-1-shaojijie@huawei.com>
 <20251215125705.1567527-7-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215125705.1567527-7-shaojijie@huawei.com>

On Mon, Dec 15, 2025 at 08:57:05PM +0800, Jijie Shao wrote:
> fix duplex setting error for phy leds
> 
> Fixes: 355b82c54c12 ("net: phy: motorcomm: Add support for PHY LEDs on YT8521")
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Please don't mix new development and fixes in one patchset. Please
base this patch on net, and send it on its own.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Fixes are accepted any time, it does not matter about the merge
window.

	Andrew

