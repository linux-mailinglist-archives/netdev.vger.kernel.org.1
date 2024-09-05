Return-Path: <netdev+bounces-125705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9E096E4E4
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 23:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 863BAB2386B
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 21:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB43186E40;
	Thu,  5 Sep 2024 21:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ixHC5iFG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B16727702;
	Thu,  5 Sep 2024 21:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725571059; cv=none; b=dMq43sjX0FK8oiqL5exK7REIqKosLwToWvMjx1WbxkSRJ5Wj7K/GqUm/Q3f4stsGpCA9GfaqSrFpa2K0UOPq0tp2iSTyJmhV4qPWGgjr2rtC/TTo5V/2IidwhipMvaEmSIk7VdEKVwrfv5UYhmdivEUMlr0pcqXeMKiH6yKYFg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725571059; c=relaxed/simple;
	bh=hcry4XdjKUSTQY0U/Ho5UWM2HsfwlzGZVLS1EDQHUcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqQHZaRWcjMgCMakfIu1tZE5m/kQSPh1oZoHuLDTeZV8eh0Pj7Hi9ioqJKhdpryg09gOK+fDYDu5zCLtuK6EfMYq2UYWyOJvnzlQO3QwP6ooFXpA6F/z4/WvNNAGCEHcQxbYySCW33hYNGl0wmn+LMAzs4+itFo9nON5y1toUu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ixHC5iFG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PL7Sp+ZFQRhY6Ewh6HrHlAfDvs9XhUi4/fxylaqLzTQ=; b=ixHC5iFGXuybYl5ObGRC2D36SO
	SSIaCknIpTCiRkQQVC6ROUuLRd88y6gpoiVz3yjffhWWtSHStatzThAEe9YW58dfSAgeK4y95083s
	hsn9Vc13NEDghoUJSD4E3FC7g2GnGMlihv5dPTNf3guaNvb6o6ag9dSXpae15omAHTBc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1smJr9-006iqW-G2; Thu, 05 Sep 2024 23:17:31 +0200
Date: Thu, 5 Sep 2024 23:17:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net,
	chunkeey@gmail.com
Subject: Re: [PATCHv3 net-next 2/9] net: ibm: emac: manage emac_irq with devm
Message-ID: <dc0f5eec-12c6-4d26-a8a8-41e7abed9eae@lunn.ch>
References: <20240905201506.12679-1-rosenp@gmail.com>
 <20240905201506.12679-3-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905201506.12679-3-rosenp@gmail.com>

On Thu, Sep 05, 2024 at 01:14:59PM -0700, Rosen Penev wrote:
> It's the last to go in remove. Safe to let devm handle it.
> 
> Also move request_irq to probe for clarity. It's removed in _remove not
> close.
> 
> Use dev_err_probe instead of printk. Handles EPROBE_DEFER automatically.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

