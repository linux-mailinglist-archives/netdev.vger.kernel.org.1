Return-Path: <netdev+bounces-131401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E64E98E712
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 01:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B93287164
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 23:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B8F1C6F6D;
	Wed,  2 Oct 2024 23:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UPMSjtoL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7B81C2311;
	Wed,  2 Oct 2024 23:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727912076; cv=none; b=Sb/3vKAJwCopiC/M/3fTeW8PF4SMdXJWN7tFY5Gt8jv8JTyXx0MbXC19OcDiJgzvCVe4RHJ2wSr211rekHFZSTSXdexHUx00E8Uj746GlMhyer7vKhPsIoKF8Kvq7cnll039gOvQS54GsmPbhxVBHcLeCGKsQZZTjtTVN0jmMbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727912076; c=relaxed/simple;
	bh=IR/2THjQ7N/lo1dYF3JRqfaQKnfbHKUU+bWBQEimd/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWeDwv9ZNZyI8vV25bTWIxybEFYpGdAyztPJzq9sPHzzhH3mRpCsVYPiGCkNiSKtyhK1eshZWqb6DRoLcxrUD2UvPALm8F87M3ThMJo+uRxR34h0teDYa5HtbIyJqE5Ey0xxXOJKwGGJgTBbyEG6vS8Ex6SqqsBXwBCzqwMh03w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UPMSjtoL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=z/adl2pW0RCDm1r3rANHkuDq37x7Og47YTxSRMtrFnI=; b=UPMSjtoL/xUVUt8lXK1HxkKdry
	s6VgLmy+by7Qq01QD6TRQExajDup/DIXwxQSl9EDe2j0syl1NT17RBSEzNpnN8AMOE6TQtm5Maqff
	9hYIgm0sLa7kGysUzSWxzu+cUdse70mtEnHv4MbUEf8yuM8nHOBCMHCV6AUCx+WEFe4s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sw8rR-008u9W-I1; Thu, 03 Oct 2024 01:34:25 +0200
Date: Thu, 3 Oct 2024 01:34:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>,
	Dent Project <dentproject@linuxfoundation.org>,
	kernel@pengutronix.de
Subject: Re: [PATCH net-next 05/12] net: pse-pd: Add support for getting and
 setting port priority
Message-ID: <fb74ca91-ab2c-4903-9a1f-cdaab54e354e@lunn.ch>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
 <20241002-feature_poe_port_prio-v1-5-787054f74ed5@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002-feature_poe_port_prio-v1-5-787054f74ed5@bootlin.com>

On Wed, Oct 02, 2024 at 06:28:01PM +0200, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> This patch introduces the ability to configure the PSE PI port priority.
> Port priority is utilized by PSE controllers to determine which ports to
> turn off first in scenarios such as power budget exceedance.
> 
> The pis_prio_max value is used to define the maximum priority level
> supported by the controller. Both the current priority and the maximum
> priority are exposed to the user through the pse_ethtool_get_status call.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

