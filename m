Return-Path: <netdev+bounces-246382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09620CEA7BC
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 19:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C19D230204A9
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 18:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D434432D42F;
	Tue, 30 Dec 2025 18:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UbVCgevF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F52B231C91;
	Tue, 30 Dec 2025 18:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767119907; cv=none; b=shXPpFwXpIpEgGILMBJm8txOHL8PIKlUkPpjYf428JGGzb+ZXmajLpAgOz7f6AQ/IdAqDs6cY6nIKuAEW7H1zuxaPltZLZiHNQr4wXTIkfZFNmyeAtzZlClE+gZP/znXmAKPK6nnyUFgbsS1Ex9cauOQ2ctYSPZMZKcHm8871fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767119907; c=relaxed/simple;
	bh=ur0VxoSB6RSnbWIDeXbhT/wa344vQ+T9KG6s/RtqtA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkE7jiBlP5wVlhJPPeGel8h1bH9SaR7EJ9yKti/xNdjSX8zts8eo/JWBZDxgsJ738jEXWhVIOwt+WN+ZLk4UMARN5X7A3e5HsS35jm7svqt/nSPgnxxey7RcOrts05AZE5iGxF/TIHK+KdnlJklo5+UHb2E7Y8WXAQdQCjVvXpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UbVCgevF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BJpNxtvmPujJMM+4H3jPm4H3rGg/lb3Bx3fF2YOrtP4=; b=UbVCgevF8yVFgZDPjydYWIEjYj
	jZu2gH3FsDZs61hGHOcTjjVCoH6RMONxEAFWbhb6iGGrxX1sVkzb3P/UtT9YAE4HOFs8erT+kAIyS
	+S0f4GS2ZL4cyiR2mbCkxSsVAE1kywJnr/NDntN5RXQDxBxP2Ie4mL9pwIsAlL2O/E0U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vaebZ-000tMn-59; Tue, 30 Dec 2025 19:38:01 +0100
Date: Tue, 30 Dec 2025 19:38:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Yohei Kojima <yk@y-koj.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Breno Leitao <leitao@debian.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/5] net: netdevsim: fix inconsistent carrier state
 after link/unlink
Message-ID: <2a1e3bdf-e6b0-4c6f-ac59-cda5ec565b82@lunn.ch>
References: <cover.1767032397.git.yk@y-koj.net>
 <ff1139d3236ab7fec2b2b3a2e22510dcd7b01a21.1767032397.git.yk@y-koj.net>
 <e8180dc5-fc23-4044-bd67-92fc3eebdaa0@lunn.ch>
 <aVLc4J8SQYLPWdZZ@y-koj.net>
 <1c8edd12-0933-4aae-8af3-307b133dce27@lunn.ch>
 <aVP72wedMbegkqzs@desktop.homenetwork>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVP72wedMbegkqzs@desktop.homenetwork>

> Sure, I've submitted the v2 patch here.
> 
> https://lore.kernel.org/netdev/cover.1767108538.git.yk@y-koj.net/
> 
> Following your suggestion, I've removed the unrelated TFO tests and
> the netdevsim test improvement. I will post the removed patches as a
> separate series once net-next reopens.
> 
> However, I kept the regression test for this patch in the v2 series, as
> the "1.5.10. Co-posting selftests" section in the maintainer-netdev
> document says:

Thanks for doing this. I don't know enough about netdevsim to be able
to do a proper review, so i will let somebody else do that.

   Andrew

