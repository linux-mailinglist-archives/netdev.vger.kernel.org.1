Return-Path: <netdev+bounces-250284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C1AD27816
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 19:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 286DF32640F1
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 17:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020273A63F1;
	Thu, 15 Jan 2026 17:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wmwrC43/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EFD2F619D
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 17:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499068; cv=none; b=a9rz7ZQMFZ3EAVxULfbO5jf293Jt9N7OKjwUX6zwI2pR2bNbWrQja3N+0sYqEXd1AW7NlFpAku0moJkOtlYsbrG3dXXDxc5dIEtZznY6ybd60KNjPiBX/4BPMD3qNMhUomesRRxjB+1E7z7rfg98vzea/8AYIHzq9EaOELpWO4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499068; c=relaxed/simple;
	bh=WrPyv1uGTabff5FG8aQVGGttyvL+RpPO6d0N2NK1JgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBB8TjwmI7uBds4oppa9bJdUniCWjaoB/PFGptnO7eOH6XkqvOKdKMSobwMXS2hlj+vCvYQQk5gfVG0p6imQxROV5nIhYPjp/Ztu4/0l6CrwSDjhkdMj1UVMocAjZBj89Z4GwB36dMS5kx+rnSLoQtZs6Ry/MP/SCG2m/+ZY1aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wmwrC43/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FH3souKGZI5TVjTFQqVVel+odvaXHoS2q4HbDexphGE=; b=wmwrC43/Iu4sdxvJMW145zob/H
	NwSA2CswbTkCsU3+z1QCTVz5FHuU7y17d+Bkaf6gyYM7z8y91N8mVN9sgAOJp6ZWwvNlWCX7lbBhm
	1qJ1JNX2AF27sb5gleY0U350XjikccMnHXVKfMKgl5BkrEKLAnMlo93NBnOWc5d4J4Ik=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vgROP-002xyg-Us; Thu, 15 Jan 2026 18:44:21 +0100
Date: Thu, 15 Jan 2026 18:44:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: netdev@vger.kernel.org, Ian MacDonald <ian@netstatz.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH net-next v3 2/4] net: ethtool: Add support for 80Gbps
 speed
Message-ID: <952b25fe-9e54-45ec-b6c2-77dcca5ef9a7@lunn.ch>
References: <20260115115646.328898-1-mika.westerberg@linux.intel.com>
 <20260115115646.328898-3-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115115646.328898-3-mika.westerberg@linux.intel.com>

On Thu, Jan 15, 2026 at 12:56:44PM +0100, Mika Westerberg wrote:
> USB4 v2 link used in peer-to-peer networking is symmetric 80Gbps so in
> order to support reading this link speed, add support for it to ethtool.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

