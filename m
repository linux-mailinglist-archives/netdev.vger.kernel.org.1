Return-Path: <netdev+bounces-242747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B87EC94824
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 21:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F9574E1094
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 20:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B1023D291;
	Sat, 29 Nov 2025 20:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FSMhgavF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3839936B
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764449400; cv=none; b=gL2lpM5X59gY4ftdnefjmPn2hGlrIqc8Vc3avy/6MajHJRHDyLVrJ1+Jih0uAbUtU+4IUxbiG6AeJr43cw1aKLNzLEfmakLf/QTZubAzizhU64zmDvvf/mxOGWjYXvwEPhXRbmlA2SxjHX9Edl+yBM/Nesvsmv37IGvaKvpqaiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764449400; c=relaxed/simple;
	bh=PSllV1OR6NdbEcUeS5hJpWDjVsxPfphzJOhsT7gEj3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NG4KwLXVrR6wsEAZoF33cwWbPN0rHGQlGkz+NJ4BjHuV5rf9EF+3SFasgXVw7IrGpjBhIZ7o+aADffIeqakakiOeZqyvHCV9OZNEqD60SqdnOy3GWTsj8A64GN303xaR+p1w5jrbpXBQDMKV+aFUfW87+RkxQ7TI1OTnmFSkIcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FSMhgavF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DLTamV30JjMuWvMwN0E8d4IRFb+IO3FrdemZX88bmj8=; b=FSMhgavFiwEcHpj05RkHNTqiKT
	b1E1npLESkDqdKRQIErk4AMIGMXyj3A6fMe8Dtjcze9aZ0Pv1J66+5CWIkvYXe+43JF5adVrHu8Ip
	qvlu3s6V9k7dKay/m6hRzaNMv911qMtYENvbWUK9tDtkNGHcGp9xnTHMb4PGZfzYrZX4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vPRsj-00FQUD-9I; Sat, 29 Nov 2025 21:49:25 +0100
Date: Sat, 29 Nov 2025 21:49:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/4] net: phy: micrel: improve HW
 timestamping config logic
Message-ID: <1b80a0c7-5c44-4fbf-a44e-a43d394fdecc@lunn.ch>
References: <20251129195334.985464-1-vadim.fedorenko@linux.dev>
 <20251129195334.985464-2-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251129195334.985464-2-vadim.fedorenko@linux.dev>

On Sat, Nov 29, 2025 at 07:53:31PM +0000, Vadim Fedorenko wrote:
> The driver was adjusting stored values independently of what was
> actually supported and configured. Improve logic to store values
> once all checks are passing
> 
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

