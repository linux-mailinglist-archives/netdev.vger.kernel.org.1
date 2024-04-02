Return-Path: <netdev+bounces-84075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31793895783
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 16:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623001C20940
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 14:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93DB81AB6;
	Tue,  2 Apr 2024 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="305pCUs/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11AB3398A
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 14:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712069587; cv=none; b=U1LzgwhlA7/4ZPMHMCsqY9X2abHGi0RVZzYy4wBi+PoSSIyurBDrb2Jd5NWd3d1ikMEsVBb8SfqEPIe/U15tbETll8HRKiNVxRjPmPMlU6WWnN2Om8bdDxU/1WjE+97RfPUfjaM89T97W2vYhxyWHmsl02BXkAluELPJL4B0qy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712069587; c=relaxed/simple;
	bh=HV7zLIBJLSGwjahJgSVXvpcI/rngZP/3Q/XiFUTbLrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCoPu93Hvh05quXC3ay5+UmTn4jso9/lufXJ77AiIMVds7RSKi/KrDhiw0xI9b5HIUCnJktJ5H3Mvj0HuWQyocHs+dcVg0bPof5x+god+wB/BHoPVIK6SVpALIe6ADz4rdI0IzKsd+fHNqdmIsV0MuKpPGgC6DgnEN0Z9owA+d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=305pCUs/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eOYGeU8zVgOXLLkcl8kxoaRkqhvrkHQcK86uuV0YpBQ=; b=305pCUs/ZO+uIQnNfe52Za6VL7
	Hh4K86PWCIVFnZiya076vP51zTgydYfDBJeOfCoRdQKwFYn9sbOQ5h/CzXUFXC5tmYhflPtqSX2az
	7eOZPBvaAnCrrI9SpxHzfVrCHTNiYFqT3pk9Ps3z5bDFyfmQ6c/3DGqgLWBrYYqFmVB4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rrfVW-00BxKe-Ab; Tue, 02 Apr 2024 16:53:02 +0200
Date: Tue, 2 Apr 2024 16:53:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Wojciech Drewek <wojciech.drewek@intel.com>, netdev@vger.kernel.org,
	idosch@nvidia.com, edumazet@google.com,
	marcin.szycik@linux.intel.com, anthony.l.nguyen@intel.com,
	intel-wired-lan@lists.osuosl.org, pabeni@redhat.com,
	przemyslaw.kitszel@intel.com
Subject: Re: [Intel-wired-lan] [PATCH net-next 0/3] ethtool: Max power support
Message-ID: <06f5880d-94e3-454e-b056-9bf2059a52fe@lunn.ch>
References: <20240329092321.16843-1-wojciech.drewek@intel.com>
 <38d874e3-f25b-4af2-8c1c-946ab74c1925@lunn.ch>
 <a3fd2b83-93af-4a59-a651-1ffe0dbddbe4@intel.com>
 <20240402072547.0ac0f186@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402072547.0ac0f186@kernel.org>

On Tue, Apr 02, 2024 at 07:25:47AM -0700, Jakub Kicinski wrote:
> On Tue, 2 Apr 2024 13:38:59 +0200 Wojciech Drewek wrote:
> > > Also, this is about the board, the SFP cage, not the actual SFP
> > > module?  Maybe the word cage needs to be in these names?  
> > 
> > It's about cage. Thanks for bringing it to my attention because now I
> > see it might be misleading. I'm extending {set|show}-module command
> > but the changes are about max power in the cage. With that in mind
> > I agree that adding 'cage' to the names makes sense.
> 
> Noob question, what happens if you plug a module with higher power
> needs into the cage?

https://www.optcore.net/wp-content/uploads/2017/04/QSFP-MSA.pdf

Section 3.2:

 It is recommended that the host, through the management interface,
 identify the power consumption class of the module before allowing the
 module to go into high power mode.

So it should start in lower power mode. Table 7 suggests the module
can assume 1.5W, since that is the lowest power level.

   Andrew

