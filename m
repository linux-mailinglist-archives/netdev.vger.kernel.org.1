Return-Path: <netdev+bounces-107287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9542391A795
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 088821F2475A
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EAD18732E;
	Thu, 27 Jun 2024 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LGpk/FyV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A2416130C;
	Thu, 27 Jun 2024 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719493891; cv=none; b=d+ut76JH9IRCmiifWbnogq2njSzxn40pXJKdGUyMjgsrWlXcvggfDntZ+3/FpLx+EXA3E1pAX6lxzQqCsUpJHsr4rFaEeuC6zYMg3SznrZyNq1lLBQ8WFW9d4arv2k4eTfOVgv9f4phCWPFMxpDYTeJsX9yvgUNZmOLrknrOSJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719493891; c=relaxed/simple;
	bh=YmP7X1GRca4T4K3lxrvScWg38NSg1qKJljA68i99kw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyZjv52/ITiMKCBHHUxaoNc0exzwH/iEhSLy39U9WYfKaMfjoxPeUKMAL6BVU0/a+qNzjhYvvXJ8dCgF4+/kewPrbdszjrubZ+n3mPw5KBTxFOgKfC+W9KQtJjUOLeGipRPWSHsvcqCmWxYpKX5p/JGLt7GDGKn/fCKwv6Pzvxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LGpk/FyV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mI1PSmTo6/+KkOgUv9A2Kz8Uoyk93m/Hj5ya8tzVzg8=; b=LGpk/FyVoLtmTWbvzG7Zw08b8B
	Ro4FEjYfck2CQzGBhYHHlkFKFQvfKm5Z68lqdXZh0fGSigID2W+1HyRy9uNkB1qFgVxmoSSjP+VQ+
	iyHsilTq8uU33cg3MmnG6wzyYjoH6/iRNVbT2aMxCkeJ9t7LXHhWJIkunQKfvIJay4vQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sMou4-001A9G-5g; Thu, 27 Jun 2024 15:11:08 +0200
Date: Thu, 27 Jun 2024 15:11:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Tomer Maimon <tmaimon77@gmail.com>, openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 04/10] net: pcs: xpcs: Convert xpcs_compat to
 dw_xpcs_compat
Message-ID: <0a933394-2324-40a0-b1cb-8e5a93f85e83@lunn.ch>
References: <20240627004142.8106-1-fancer.lancer@gmail.com>
 <20240627004142.8106-5-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627004142.8106-5-fancer.lancer@gmail.com>

On Thu, Jun 27, 2024 at 03:41:24AM +0300, Serge Semin wrote:
> The xpcs_compat structure has been left as the only dw-prefix-less
> structure since the previous commit. Let's unify at least the structures
> naming in the driver by adding the dw_-prefix to it.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

