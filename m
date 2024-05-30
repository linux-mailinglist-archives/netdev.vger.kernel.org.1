Return-Path: <netdev+bounces-99301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D81E98D45F7
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 09:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3734DB2104E
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 07:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8497316F;
	Thu, 30 May 2024 07:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lmq72Mm8"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400851CD20
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 07:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717053766; cv=none; b=KHzQuFoyw6yqJ2znOgkA/M0wekrpZeGksGcdNljqh+yDvUSp/FjeTnkyqwK6WFX+fiH6qgt2UejYoV7PgFQDMkOKXJJvvjKEuYJjn4wZvfz0zTsAdDVqy4DjVUkwHzVs1WCMw1pNUA8vr4EKHiraCH2z+FtlMNQ6GB1+9/maW9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717053766; c=relaxed/simple;
	bh=ZHMvWcAgW2V4u+BvmrVa8WAs8F/hf3YNFThVq/o6xJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8mlEKgmqSnSmJx53MKJjgNH9hyYNeRhA95i5kTGUvI7U7HkfJP4hLugEcVVwIoI0bY5XYGNRpJdviUV0WIG3RniUy9j4cAstyGQsq/ZD+Kcyf14xABzMP8LIJuG8V9hcZO6bNlFqYJmDKTwjKBF9Si/NGHuPSbMXT7VTDJSkHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=lmq72Mm8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=A/73ebAlsC/3BTmrvK4IFg/WQ37OWh2ZE3F/n1tmBwI=; b=lmq72Mm8NiAK+mUV3kHBmewYb+
	t25+eQf+oSrqyb7Z3OBhhGAqtv6KbE2ewaOas5OOY1rjZboxbAF8xYQs39/6TuZxWLnunzZ1ZebOA
	D7nJmfOOzitdS3khvqd6g1F/B1mF5lJJc3eTJUewX1jEBFKSzT7kQnwekSM47JnAM14h8wEjVekBn
	8qluXnsZNP/YdHfmUf6Z/YglvGfmOoRSSJq551/OXI3gTeEevm93jp1aJY+E9vITl9tQhPkiIoJT+
	Udth2B6lgAu7mgq7ImjnVBeEBkm4ioLzdHgm60+BgHvrOoEAE7EqJortH6ypt9m8rEElRbRS5uZEL
	oIuesvGA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34450)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sCa7E-00073A-23;
	Thu, 30 May 2024 08:22:24 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sCa7C-0004yH-O6; Thu, 30 May 2024 08:22:22 +0100
Date: Thu, 30 May 2024 08:22:22 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Yanteng Si <siyanteng@loongson.cn>, andrew@lunn.ch,
	hkallweit1@gmail.com, peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	fancer.lancer@gmail.com, Jose.Abreu@synopsys.com,
	guyinggang@loongson.cn, netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
Subject: Re: [PATCH net-next v13 12/15] net: stmmac: Fixed failure to set
 network speed to 1000.
Message-ID: <ZlgpLm3L6EdFO60f@shell.armlinux.org.uk>
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <e7ae2409f68a2f953ba7c823e248de7d67dfd4e9.1716973237.git.siyanteng@loongson.cn>
 <CAAhV-H6ZJwWQOhAPmoaH4KYr66LCurKq94f87FQ05yEX6XYoNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H6ZJwWQOhAPmoaH4KYr66LCurKq94f87FQ05yEX6XYoNg@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, May 30, 2024 at 10:25:01AM +0800, Huacai Chen wrote:
> Hi, Yanteng,
> 
> The title should be "Fix ....." rather than "Fixed .....", and it is

I would avoid the ambiguous "Fix" which for stable folk imply that this
is a bug fix - but it isn't. It's adding support for requiring 1G
speeds to always be negotiated.

I would like this patch to be held off until more thought can be put
into how to handle this without having a hack in the driver (stmmac
has too many hacks and we're going to have to start saying no to
these.)

However, I'm completely overloaded right now to have any bandwidth
to think about this.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

