Return-Path: <netdev+bounces-180119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 864D4A7FA67
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9779A1883D51
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DC3265627;
	Tue,  8 Apr 2025 09:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TLNIO8NI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D943525FA28;
	Tue,  8 Apr 2025 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105884; cv=none; b=RsVPzsmAccuBLw9ce3geFX/o1mEC2ibv9wyxYcJXecvOjpC5A+76zMOgvF0uQ0YhWAjO4mNAwAubSdo74YB8jARE8xDjEQEBJfvBMBxOPOXdXfm7haTGy4gD98Y6y+A/XstPqZhbs6d3TxxW0mSFCdb9zqUNvAepwdA9WWjk91g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105884; c=relaxed/simple;
	bh=MdhhuR8u+f2L8BEApKaP9yJB+uq9wXeBIyQyuHw/GDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERo4akuItUS2eTd4LtnNzod9P8xMIRdqkh44/IUlzypdzmJ/3SQEfCL8O7SK3J6GKnikLGgYp39HcZKeTcd/Mq4r3CcT/BY4gt4E00UUs1YiY9VpmXCVmz2PNYrZ8QHDZrbQ+YeR9lYzsukWMlTMhwwj+ZZx0prG+8KQ5mN8aY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=TLNIO8NI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ESiiW9LM+nOg1COvw8+IqrZlBUEJUPwPm3jfljatJPA=; b=TLNIO8NI/VPs2Uj48PZi4GSgXw
	Af5qcZ9XMj/7wycoyyV+/OwM8V3e9RJEn0VmfAtyUsoD3oMCftyWSMt7rtzPVkn/iyM8lzxtzj5E3
	myfwNRDcs2IKx/+G//t2x4LNRtiRy5NCZqbHk8KKBxYnvrGiMWm77SCD3WD8+sA+QYv+6YaDYxVsT
	QnQ8ELbI970wp+9VdvQOa9uBFTA32nyggWOvXZNa/WaYymijdPD2ot5SvrvvU6Go2wepyQCBFtqQD
	62+fx0KkCV/I3V7F9cROj5o53HIYA/IXkh8iVatWp1WCvHctV02C36gYR7CUYDB9K9mgrbVwx2n35
	UxEy0IZA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54152)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u25bp-00075n-1P;
	Tue, 08 Apr 2025 10:51:09 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u25bn-0001KC-1T;
	Tue, 08 Apr 2025 10:51:07 +0100
Date: Tue, 8 Apr 2025 10:51:07 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: dimitri.fedrau@liebherr.com
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH net-next v2 2/3] net: phy: Add helper for getting MAC
 termination resistance
Message-ID: <Z_Txi9sdQh2BF0bk@shell.armlinux.org.uk>
References: <20250408-dp83822-mac-impedance-v2-0-fefeba4a9804@liebherr.com>
 <20250408-dp83822-mac-impedance-v2-2-fefeba4a9804@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408-dp83822-mac-impedance-v2-2-fefeba4a9804@liebherr.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 08, 2025 at 09:45:33AM +0200, Dimitri Fedrau via B4 Relay wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> 
> Add helper which returns the MAC termination resistance value. Modifying
> the resistance to an appropriate value can reduce signal reflections and
> therefore improve signal quality.
> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

