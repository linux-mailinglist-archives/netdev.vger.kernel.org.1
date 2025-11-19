Return-Path: <netdev+bounces-240159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DC298C70E6D
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0570B4E018B
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACB62E62C6;
	Wed, 19 Nov 2025 19:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="F6pln4dJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA7934DB60;
	Wed, 19 Nov 2025 19:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763581919; cv=none; b=jkVVZXxD4w3dEqkTQb4H08yuJudYzSqc2I/984wiiKVKFRMgbLKaEbwqVVaGRMsvbgbLagfgESJe+SUy/WUC+ZSU262UmI2Lw6dGjnhzVXb81AQVC+d5uQ5RaRmGhZH+wU0iqXXa5yfy3V5ve/6k0FYJAXMbjmhI7ja7RPztNgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763581919; c=relaxed/simple;
	bh=xk95UURiSzEbIEbTh795kb7YWO/yWBYiVU0rKCqfYyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yn2cAJkCvRs9qgVlqqsM7zkdSyxpWCyXlL90CdnyLQSO68YqQQc0qYd8gP5qBBZukbrFZJrc+35pscENMbXdOM5esq0iDkOvOoDkcbX37q1oM8LKuEf7rhUt7+J+OmApS6wmCcQMEvkdTt9oodkNe7534343BzNP39kmV7b2vbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=F6pln4dJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Dg+ZfMlkkva2YqCScrw1/cbaetvEkaxgzLwIQZgnGh4=; b=F6pln4dJ+YqiJig6hY3QPemhNm
	tATG9SMWl+R1km6OTNq4RfvHlZtEwuQT9ulsgU0GvI49LLfrH3XtwI2O4tXKZ6HsT4/apTp3Hic6L
	HTEmW2NCTyFaoZHUley8+ZUMgcsLyTtHwyInPy532n1gMnU3NWGz9UldZ3vU8g91c3bI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vLoDP-00EXnU-35; Wed, 19 Nov 2025 20:51:43 +0100
Date: Wed, 19 Nov 2025 20:51:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 resend] net: stmmac: add support for dwmac 5.20
Message-ID: <c73c4683-6bc4-42e9-9f5b-9b5bcd2f0aa6@lunn.ch>
References: <20251119153526.13780-1-jszhang@kernel.org>
 <aR3snSb1YUFh9Dwp@shell.armlinux.org.uk>
 <aR3p4NBK-AnCGK6a@xhacker>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aR3p4NBK-AnCGK6a@xhacker>

On Thu, Nov 20, 2025 at 12:01:36AM +0800, Jisheng Zhang wrote:
> On Wed, Nov 19, 2025 at 04:13:17PM +0000, Russell King (Oracle) wrote:
> > On Wed, Nov 19, 2025 at 11:35:26PM +0800, Jisheng Zhang wrote:
> > > The dwmac 5.20 IP can be found on some synaptics SoCs. 
> > > 
> > > The binding doc has been already upstreamed by
> > > commit 13f9351180aa ("dt-bindings: net: snps,dwmac: Add dwmac-5.20
> > > version")
> > > 
> > > So we just need to add a compatibility flag in dwmac generic driver.
> > 
> > Do we _need_ to add it to the generic driver? Do the platforms that are
> > using this really not need any additional code to support them?
> > 
> > Looking at all the DT that mention dwmac-5.20 in their compatible
> > strings, that is always after other compatibles that point to other
> > platform specific drivers.
> > 
> > So, can you point to a platform that doesn't have its own platform
> > glue, and would be functional when using the dwmac-generic driver?
> 
> Synatpics platforms use the dwmac-generic driver, it's enough now.
> But we haven't upstreamed related platforms, but will do soon.

Please make this patch part of the patchset when you upstream the
platforms. We prefer to only add things which have users.

    Andrew

---
pw-bot: cr

