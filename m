Return-Path: <netdev+bounces-175668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A922A670ED
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 11:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3503B823D
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193A1207DF6;
	Tue, 18 Mar 2025 10:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="LLRjkuuU"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE61207A27;
	Tue, 18 Mar 2025 10:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742292898; cv=none; b=SQWEnfCKFl5dzZDyc6CaPqdCjmSlk45gjkzXKJBtf5BDgaovXKl6Kp7CRj6YlHCTC6GZcpg/H9zYmy44Qk/mBvTyI3MHusE4gXABMJGxw7UZSI3rG5oAnygunXg6caty8yFUGXgW5RqDg8NzK0XrAbuWHOviZNB8sRN1fX7xn7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742292898; c=relaxed/simple;
	bh=nTWbgF+ovETK40mhMxNeCdkXcRyxjSqIKUT6AykaE6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qy+7f0UKMXXx0V26VwC4EuxH+TzEEJqlbYNJhXbybYXzanI2yHnani82IWYq1zWFFQ+DI/+aE4Mi95UbhjK8BF5o0PQI1jDBWecuybGUWAQQbEmG2t37i0I0msGI+XrgGfRB+CIHNf5gw4ErCdl9I/V2iuYXDt/P1lilFPtg7Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=LLRjkuuU; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qOygiTV7vrKY1WXHvWHPQYGJdFcrmfXZbEYu0/ob0+4=; b=LLRjkuuUqv7/2IKkv65vhDJsKw
	V8Y6shPhf9JRvYPOCHNgcMpF18sXzsIxYZT5M7kmGcq+9ifhfQCCr7qiAkUqjc6wbazlGcVQ7vrgc
	n88hErLxM1TICj8fCv1/JW5FtCCMe2bIZE7tu0LJ1tkB24zLJgGa4UusrCQjCTEyTKvlMbfsQD1n1
	ptAqtTBBd8oS7SMl9y4kBy899YdensxOw/RQj7Stg/0BhzX/A9A8xAKJyhEGRjjZdLlNgoc/HKjLH
	XS9KRXLTrD21Xq/KoEvjokZSu8DAOGZOEcWwv+l0urFnqmBdTTSo4t+sBmll1j/YVlOiMNlHL0X1L
	lZfT1+Jw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40276)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tuTy6-0004qx-23;
	Tue, 18 Mar 2025 10:14:42 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tuTy2-0004WF-2N;
	Tue, 18 Mar 2025 10:14:38 +0000
Date: Tue, 18 Mar 2025 10:14:38 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v4 08/10] net: usb: lan78xx: Transition
 get/set_pause to phylink
Message-ID: <Z9lHjsIl-b_Jgc6O@shell.armlinux.org.uk>
References: <20250318093410.3047828-1-o.rempel@pengutronix.de>
 <20250318093410.3047828-9-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318093410.3047828-9-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Mar 18, 2025 at 10:34:08AM +0100, Oleksij Rempel wrote:
> Replace lan78xx_get_pause and lan78xx_set_pause implementations with
> phylink-based functions. This transition aligns pause parameter handling
> with the phylink API, simplifying the code and improving
> maintainability.

Doesn't this user API get broken in patch 3 (in other words, shouldn't
this patch be part of patch 3) ?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

