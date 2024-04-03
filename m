Return-Path: <netdev+bounces-84514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F36B889718C
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 15:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93B7A1F21B19
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 13:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104291482F3;
	Wed,  3 Apr 2024 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dLM3bGsp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A729147C89
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 13:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152183; cv=none; b=PP+to4jpRF9VIesmq2xzdWxWuEiyEBBC73pIwkXCGAss1CwXgFLScEdTIqAb12AUFPkWN91BWBRH1lA+bLoH28rdUG04+ATeauE+ePA08ryeszDFA9oIzlYwqVoTDWhfx6vIsq5EH1BuALj3XHI4HH1P43P0RXZhmFMDPaE65L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152183; c=relaxed/simple;
	bh=Ask5S9ZLPMtqeta3og4u6fldBYa5pODHPBXWwEJ6uz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2WKsqGFVpYQYgj1LCU7MSBUIowmQr1Fh3z9ZNh1LUXByAoOBUVCfhzMYwcPB9215+NWdgmtzU8VpqKVf5V882TijuLqrwPQX9UJe3nNQRLgnrUC1Y582x3mCdRL6Eoe0mbOayC2dFSmI7DRndsPv7057YY6HdY/u5GwWxFBgII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dLM3bGsp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=p5ed33sJQnP+0D/KgfgliQpZCAocWMCLPbVfEtxjLdE=; b=dLM3bGsp8kfQY+jq/s4pafhJvF
	Rk4DkpCSiQPAFCN97eIgG59j2AdranIBj4trmXHi0Whsy3ZYTSjoeZZijYFF8mPLVbN6wmxHvlvDf
	fvUAsp4+S64oLW7ZC1EvhoHJzBSwpleHJwCeVrVZrfhx1xrXbUpZLUioTQK9uPDj2xdM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rs0zh-00C57n-L0; Wed, 03 Apr 2024 15:49:37 +0200
Date: Wed, 3 Apr 2024 15:49:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, edumazet@google.com,
	marcin.szycik@linux.intel.com, anthony.l.nguyen@intel.com,
	kuba@kernel.org, intel-wired-lan@lists.osuosl.org,
	pabeni@redhat.com, przemyslaw.kitszel@intel.com
Subject: Re: [Intel-wired-lan] [PATCH net-next 0/3] ethtool: Max power support
Message-ID: <61a89488-e79a-4175-8868-3de36af7f62d@lunn.ch>
References: <20240329092321.16843-1-wojciech.drewek@intel.com>
 <38d874e3-f25b-4af2-8c1c-946ab74c1925@lunn.ch>
 <a3fd2b83-93af-4a59-a651-1ffe0dbddbe4@intel.com>
 <dc601a7c-7bb7-4857-8991-43357b15ed5a@lunn.ch>
 <ad026426-f6a4-4581-b090-31ab65fb4782@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad026426-f6a4-4581-b090-31ab65fb4782@intel.com>

> > $ ethtool --set-module enp1s0f0np0 power-max-set 4000
> > 
> > actually talk to the SFP module and tell it the maximum power it can
> > consume. So in this case, it is not the cage, but the module?
> 
> It does not work that way in ice example.
> > 
> > Or is it talking to some entity which is managing the overall power
> > consumption of a number of cages, and asking it to allocate a maximum
> > of 4W to this cage. It might return an error message saying there is
> > no power budget left?
> 
> That's right, we talk to firmware to set those restrictions.
> In the ice implementation, the driver is responsible for checking if the
> overall board budget is not exceeded.

So i can get the board to agree that the cage can supply 3W to the
module, but how do i then tell the module this?

I would also suggest you don't focus too much on ICE. I find it better
to think about an abstract system. A board with a power supply to a
number of SFP cages, and some cages have modules in them. What does
the kAPI look like, the use cases for this abstract system.

    Andrew




