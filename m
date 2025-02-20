Return-Path: <netdev+bounces-168111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6B9A3D8CA
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 12:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518163B2953
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 11:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34AA1F150A;
	Thu, 20 Feb 2025 11:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZndTmzGw"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5107E1D5CC6
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 11:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740051143; cv=none; b=Wvg8TdH8fdD5g0Ezjy7ZLg9wXYdY/zYD6zSoBQxyVuaBPFDh810EVo2IoJCfziis/7TFPLz77XB52yUCw8BoLiI8wr1gn6aiwryWAQxrfitqL8HOqyARgq1JssbjlS39Lay9bgii4hBPDNe86NBuXifCjCm6HGs1ZkRx6JBbiuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740051143; c=relaxed/simple;
	bh=bNvbDJGWT1yvWSomLsFsEndsnAg/ia+FuGewA1LXWAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMCOzbO0li++YBp0++gF/xt5WBRSRlr1crCZ7GwPNbuQkzPZh8OivJ98yWIRmZWtS1r82D1XiL+33bn/RmbExcpGzKhzVOM5Ndpwp0S8klJu4rJQm1bUqVs4GdbUsM5eXXSz9UPG7vsSs/Ae2wWFi/6kU4phlyTLGk3VjU0D3zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ZndTmzGw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DgYnuu4GrziXutA01vJopkluwgdC1j+AGO94ZJgvZSQ=; b=ZndTmzGw1/pyXnq+GMqVQBV7nq
	T5bUGmaaE3S6k88qZWjYFXR/S1Bd2xqd/w5l11eZLNhQbLauF8qw0ZWfMo2P14Im8JRpGkhxUEfai
	sLfhY9vvv5upUOg+c29zPm6TEzpjcGJ20OR70QyYAc2RRnTs0MydvR+z+8RrpO+m9X2KicOxdVMIH
	OS+gVOldNETm0uf4fExApeYJpx6f7zaUHPBPO4swp7m/Ccf5gj2r9lI5GmSFYN9r7OYSUPMnn/ar5
	+iB7gLcBBvgNTvtv0MO9qjJbBdJEJdPcoDx6Y2bu+HedQPbfrQmXspjBemRNrNKSvt3xtj3WAck3g
	S9nUVkwA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54614)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tl4ms-0000mi-2o;
	Thu, 20 Feb 2025 11:32:14 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tl4mq-0000vq-1O;
	Thu, 20 Feb 2025 11:32:12 +0000
Date: Thu, 20 Feb 2025 11:32:12 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: remove unused feature array
 declarations
Message-ID: <Z7cSvGxAOgxLQTdM@shell.armlinux.org.uk>
References: <b2883c75-4108-48f2-ab73-e81647262bc2@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2883c75-4108-48f2-ab73-e81647262bc2@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 19, 2025 at 09:15:05PM +0100, Heiner Kallweit wrote:
> After 12d5151be010 ("net: phy: remove leftovers from switch to linkmode
> bitmaps") the following declarations are unused and can be removed too.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

