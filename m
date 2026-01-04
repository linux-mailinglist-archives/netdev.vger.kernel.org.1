Return-Path: <netdev+bounces-246822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ED591CF1640
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 23:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 691CF30006C4
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 22:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866C6262FC0;
	Sun,  4 Jan 2026 22:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wYABjYYf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B317224B04;
	Sun,  4 Jan 2026 22:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767564098; cv=none; b=dQJSnS/21FRSpnpl5fh6IO1DfVyE+MqpMzNWPkWXVEUM27s7Z8izMrrO5ZgrBqAEWA7smIMCabYUAOd3Y21FEpSsXGUFn6jG78L09k/P3KSSZLpGm4JUkZiZCtZDEijuJxv7wCPk2GORiw9iSGv5r7b61NsLAd7kwscxV0rF5oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767564098; c=relaxed/simple;
	bh=ULpW7UO/2fS+tMpyP1n99MJwdPA6migaX4mlT/de+A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlqGikmpd0RGvUpzS7jTcd+o40GI+M1FafoqBPgEnbHgXnc9ytiOCDDgrZrS0FQfuYgT6cjiaO/iQUyCVff2zgmbRGyrFjIg8VfESQIYhEY6pvHqi6iKEOkFnOxKTd0okeAaq88n4kQFfrUfyUy7cx7VHXzZWCLR2JBtpHmRCng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wYABjYYf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aeuB7RE4nWCYjEZEiNhs/O/FKrA2fhaoXeDG211Y5xE=; b=wYABjYYf58NcIGmxuQeCgHjmRh
	RjpXxbZF9ZQNYKAzU9bDpHGhOm+zVdjrjM1MujzXcaicgBkzhgeX6vdfrvXBn5rOodfEJBf4J5Y2k
	Ahb+ZhJx0PCwJ2C19pEBlipNqrNKNFGT9tOJCS/lvPYwANxpcVseaffYNlI4gAJ9Nd34=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vcW9u-001PFO-Dc; Sun, 04 Jan 2026 23:01:10 +0100
Date: Sun, 4 Jan 2026 23:01:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yixun Lan <dlan@gentoo.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: spacemit: Remove broken flow control
 support
Message-ID: <d9d2781e-dffe-465e-a684-49d5e4c42d93@lunn.ch>
References: <20260104-k1-ethernet-actually-remove-fc-v3-1-3871b055064c@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260104-k1-ethernet-actually-remove-fc-v3-1-3871b055064c@iscas.ac.cn>

On Sun, Jan 04, 2026 at 02:00:04PM +0800, Vivian Wang wrote:
> The current flow control implementation doesn't handle autonegotiation
> and ethtool operations properly. Remove it for now so we don't claim
> support for something that doesn't really work. A better implementation
> will be sent in future patches.
> 
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

