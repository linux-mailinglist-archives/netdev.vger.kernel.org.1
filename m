Return-Path: <netdev+bounces-199946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBEDAE27C4
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 09:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75ECF1895212
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 07:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF8A19F130;
	Sat, 21 Jun 2025 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zZr2Eyrt"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8194418B0F;
	Sat, 21 Jun 2025 07:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750491201; cv=none; b=uZKhTuPW9Spg/dDuUJLigAy1K/ZKbiDg1ruA/AHaOzpre2kgU2m4a3T8sY78ClJuOstkZ/Usdgp9RSdgVF+JP8lwoNR/WCeIMRBoS/wUZmiue4v8EIWSMoOylJhkFM9U12WU7SPwZoaaoN7vaN0fYs5tKNJSY/J2Y9ElrPW3FMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750491201; c=relaxed/simple;
	bh=ZjRtZGj+bTiV0atdKu/UMz/EA8O50jp8926sPWJkLYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvKBHBtjmY+NHhEywbkKtCxGfFsk/ck39P/rMrHF8ZaPZnq9qY7We49Qw2cBT+opL3VNG+Lvpx0ThcF0fEUERFKIbHXDxUoY2+qXvB5eXVhEgXFHcUTxnPgfgT77MtQAV/6RD+v8G1PxSlxgVU5bevhDpXl1636KuSymqzQ5KFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zZr2Eyrt; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=P6oppky/HuD45K/qSvDG5L56EwYU89EoqMPm448d4Ck=; b=zZr2EyrtjfAoEXFVpYOe75oQ7C
	h7TTzyrajv6hQX9CQRFer7tonijLaBrMATW2Af3XwfGWeRRSSnYo4QAsOnMN617iU76K89P+BTqKD
	dvyxUfF6yMdcRPzJ0FGgkLwtXlaTAZ2uEO/Stp7DvKShIXT1kDz50KFkVIhJIh7fBY3Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uSsin-00GZCR-UD; Sat, 21 Jun 2025 09:33:05 +0200
Date: Sat, 21 Jun 2025 09:33:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <michal.simek@amd.com>,
	Saravana Kannan <saravanak@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net 4/4] net: axienet: Split into MAC and MDIO drivers
Message-ID: <16ebbe27-8256-4bbf-ad0a-96d25a3110b2@lunn.ch>
References: <20250619200537.260017-1-sean.anderson@linux.dev>
 <20250619200537.260017-5-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619200537.260017-5-sean.anderson@linux.dev>

On Thu, Jun 19, 2025 at 04:05:37PM -0400, Sean Anderson wrote:
> Returning EPROBE_DEFER after probing a bus may result in an infinite
> probe loop if the EPROBE_DEFER error is never resolved.

That sounds like a core problem. I also thought there was a time
limit, how long the system will repeat probes for drivers which defer.

This seems like the wrong fix to me.

	Andrew

