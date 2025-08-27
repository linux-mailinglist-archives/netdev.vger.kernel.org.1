Return-Path: <netdev+bounces-217494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB7DB38E70
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 00:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DA9A1884321
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 22:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E061E0DE3;
	Wed, 27 Aug 2025 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dA5qVwiJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC1572612
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 22:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756333685; cv=none; b=rBcHy3KNAADvABG0zqIzAavv6r1RMJ/P/7fHVERjntKOJcvNjmOCATptsbtWw1Kw8X9mMUysiJpcI2b2GIWvzwqtSzBhFQR/ZdU1Rp7t8x9R1NKmKnaffRzk8T5VTwBEJseLAS7/qpzbsbA5yGtqq0ROhHRdd02i8qudHGHSbGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756333685; c=relaxed/simple;
	bh=D8K7fUQ1jQ9XfdszSyfIqAcChID45mXDDX+UUifmYGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EF4jUGiaGcIYYbMF5UORZ2gkxCpZ1yejJ4FoT9EgIqF+40NytzASX8TqLFswz3QyvqjcW+NLJ+5/YKvoS09vKFqSBZiAlkr/ZDYJIQgUdLOIcCHogUXPK82zSy53iPGPE5FsNKR1AHM6l/IZYtvlfX9IPMc/W9e64EgVizqeC6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dA5qVwiJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HShRShST24jXNkqiKWFmvQxhSXT7ZDIEBJBA2WkGO+E=; b=dA5qVwiJREh6NgeQ9HW9kKIsVM
	SRyFjOvSlhJPNj6rxDDP7NEP+ufTkuaXCPm4sZgmo6SmSn2FWrwDhth4ph5NLD5kzcczA/BcFslx6
	FD/vR7ft2a4ISMBEmjkp4+82SVPNRnS582rmIIrHVFtqRf9+uw2DsWQRSnzt6bIV/pYM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1urOcS-006GiV-W8; Thu, 28 Aug 2025 00:27:52 +0200
Date: Thu, 28 Aug 2025 00:27:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v3 net] net: phy: fixed_phy: fix missing calls to
 gpiod_put in fixed_mdio_bus_exit
Message-ID: <13904019-f838-454f-966a-f56235bc5883@lunn.ch>
References: <b3fae8d9-a595-4eb8-a90e-de2f9caebca0@gmail.com>
 <aK90BbEGJAVFiPAC@shell.armlinux.org.uk>
 <7f390adf-5ee2-44cd-8793-36b04f1fe73f@gmail.com>
 <aK98Nq-rauPoRXJP@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK98Nq-rauPoRXJP@shell.armlinux.org.uk>

> Last time I booted mine was in April

Mine died a few years ago.

It is quiet an interesting board for testing because it has an older
generation switch.

So we should keep it, while there is still an example in use.

	Andrew

