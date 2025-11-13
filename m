Return-Path: <netdev+bounces-238357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C8EC57AEB
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 14:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AFA01342B98
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 13:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A466184524;
	Thu, 13 Nov 2025 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Z7uXL13l"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921CE610B
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040748; cv=none; b=EEGBDox2eVMOJrIcnD/JDxdfJ++iETm+ovvhUGBTRTiLzLQhSsU0u12nsC6zw9HzNL5DY+suITdhXbbeGHBMRr4y6vc++zT/JAAaqVxBPYXS2GgqseAD4Z0JSnZaXAJ0uq3pJOD2HTolRpOSlvcx5JvR33dK1oAYsbkyu/bBvJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040748; c=relaxed/simple;
	bh=+6WZhRZ8G7kY62j3yiRwKZtjxctjzvo3ZR64XJmnMsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrNSRGjLOwfs35WfqW0Zbb8jczAWT063cjczyKG8BZhTUGF/TXSqSmmdOp+ietOo3ncCBcWb8lL9msiRR3S57XXndBMYGtT2L1A4GQeqIFcM//h7SYleywZx/6UpTzsiKyl5fcE6+yI9NPnvotuT2VleILrflXsexiWZZcnF2bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Z7uXL13l; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GVCMtULvmS3XYNqcG3CcmiwhS75lg/QgAE0XR63BLnA=; b=Z7uXL13lpUPTvNrsCGOzRmv9kX
	oTh/eMuLkoH41BjWt++nlSWv1CucQvbpVrqPpPQB3zACErfXoe2ZQFStQFhHOTyg+x6WOcP9XuxD8
	wvp0cEGmAJCdjZS2u7/C1P58jImkMFjrtozbX+u1h91puPMMzgvwNDU2Xkd6WSQ4FSrQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vJXQY-00Drmb-AU; Thu, 13 Nov 2025 14:31:54 +0100
Date: Thu, 13 Nov 2025 14:31:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/9] phy: rename hwtstamp callback to
 hwtstamp_set
Message-ID: <78b400ee-20e2-41ba-a937-ef03f31662d8@lunn.ch>
References: <20251113113207.3928966-1-vadim.fedorenko@linux.dev>
 <20251113113207.3928966-2-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113113207.3928966-2-vadim.fedorenko@linux.dev>

On Thu, Nov 13, 2025 at 11:31:59AM +0000, Vadim Fedorenko wrote:
> PHY devices has hwtstamp callback which actually performs set operation.
> Rename it to better reflect the action.
> 
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

