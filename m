Return-Path: <netdev+bounces-150486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B879EA69F
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 04:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA82E166CE7
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 03:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73F21D4609;
	Tue, 10 Dec 2024 03:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zCSujAu0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4E81D5CD4
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 03:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733801320; cv=none; b=uZlKert/dfqgzLt6LIL4ILC6wuq4jyW/wgvL2IWa4LtLrh8yf+qyahVnp5w330zfwnNWelCVdHMEzGPy4GI2YVap7VlW+806gxfUD3zfsDQxGw3trpKxDaZM0OhzM8+ZOSquhPRf9Fm2oqAHae6+KDXAlKmWerlKL3rGBZ/tshM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733801320; c=relaxed/simple;
	bh=8ZjoMrkpGhvqaHmWz56d2HnDt6npNs1OUjUIB6kSozM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcfZMDW9XijnUZSXVI7HK1St0JtUMEwObBURynk/tAnckW9s5ELlN5gJC9GQ9DQ1KF55VBn0oO3g1QXWo7rudLbMaAECUsBWh519YsbgOE25M+SnmpSkSXplKFsJ1PZ7ZyK1VLjPXfzxrUU7aaj0b7zAnW5jAWGUDyxlnbUTdzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zCSujAu0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jqsScO1BrCYUlXGxgKhDktsvDknhF9QrcqKB7Z6tVCg=; b=zCSujAu04X06np3J1EIJD1IUw2
	YM1Y2uS32WriS1jikq09CJUVWGFtLvqQekaQmUdg1luNMZrbpgccjXH3XQPFU9CdD+OGICYWnNSR2
	bSqI+u8B3AyuOFcvw1ekhmr1178Ilyhd9r8pxtcZly6hcPjxy43SZY4oYYevLDkeQPjY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKqvJ-00Fkde-0J; Tue, 10 Dec 2024 04:28:33 +0100
Date: Tue, 10 Dec 2024 04:28:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next 09/10] net: lan743x: use netdev in
 lan743x_phylink_mac_link_down()
Message-ID: <243d3de2-e5ea-4e58-86e8-035262994803@lunn.ch>
References: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
 <E1tKeg3-006SND-0e@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tKeg3-006SND-0e@rmk-PC.armlinux.org.uk>

On Mon, Dec 09, 2024 at 02:23:59PM +0000, Russell King (Oracle) wrote:
> Use the netdev that we already have in lan743x_phylink_mac_link_down().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

