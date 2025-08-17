Return-Path: <netdev+bounces-214397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA73EB293F7
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 18:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E02F1B27F8B
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 16:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9A21E51E1;
	Sun, 17 Aug 2025 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XslvMXKX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFD414EC73
	for <netdev@vger.kernel.org>; Sun, 17 Aug 2025 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755446644; cv=none; b=iXcWZKakAZ9Vc5kvFoKQg7m5WTka+b20kvkIUNC5IeawOOW15R24mzI6VNB3wVwbrOmPyWowX5IbnXI8S3R8wvZKfpKnffID7i3Ms/ff06puyb0+w0dYQii+Nklg6A/9nsKXJH2hEkO9e4gyU0hbSc/oeXHnZns03Pw1oLviQss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755446644; c=relaxed/simple;
	bh=R82MBbqb0Nrsf7+Eoct/6OFSTndAY4e18iqnimSRDrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYSqJRh88COjojEd3OwJWZ+VbGN4CP5Mr4Yt67SiQE70IBKZ5YUKj2aG0GMa+xTAPsedw/mYPBjC8Kc3v5rR1VLJilbNiv3o7c8Rs5oQeg/DIXvId9n+q8IwPc3S9lQjGWK07SEmYrNTdUriCiOBUo9bwjEMvc5Txopv4t+iqO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XslvMXKX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zdE0R993uxA9LK/Gcm928RWFPyC6VX59/G/wYy8am1w=; b=XslvMXKX9PoOKnQ672hCHnJ0QD
	PXkmPDbUxNUDI5P4yT/3/8jpgr0KFsAb5Oyx2ihjRrCvKaWlomgGK3XLi0bMQpbFZzLQjPF7+urzx
	pJLMHL3IywQN1RwW4c9lXg/z+oiPo6YbvSOjCPU1XcQ9VnphR8LRyBwLWfGQhklD6eho=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1unfrK-004ybH-2n; Sun, 17 Aug 2025 18:03:50 +0200
Date: Sun, 17 Aug 2025 18:03:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 5/7] net: stmmac: use core wake IRQ support
Message-ID: <00b45ff8-b5fa-4453-a389-a7252aa1da6d@lunn.ch>
References: <aJ8avIp8DBAckgMc@shell.armlinux.org.uk>
 <E1umsfK-008vKj-Pw@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1umsfK-008vKj-Pw@rmk-PC.armlinux.org.uk>

On Fri, Aug 15, 2025 at 12:32:10PM +0100, Russell King (Oracle) wrote:
> The PM core provides management of wake IRQs along side setting the
> device wake enable state. In order to use this, we need to register
> the interrupt used to wakeup the system using devm_pm_set_wake_irq()
> or dev_pm_set_wake_irq(). The core will then enable or disable IRQ
> wake state on this interrupt as appropriate, depending on the
> device_set_wakeup_enable() state. device_set_wakeup_enable() does not
> care about having balanced enable/disable calls.
> 
> Make use of this functionality, rather than explicitly managing the
> IRQ enable state in the set_wol() ethtool op. This removes the IRQ
> wake state management from stmmac.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

