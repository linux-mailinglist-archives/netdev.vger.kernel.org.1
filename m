Return-Path: <netdev+bounces-107396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD2C91ACA4
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 18:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B7FF1F21A89
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3A219A283;
	Thu, 27 Jun 2024 16:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vtgY0/L7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9860B199EA1
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505558; cv=none; b=NjtnFmLdAIHuB4GKw2lpo4zhi5YzR+OODLFN6St+uCXUaHcPYd5pHa21WKlaB+KLnPXBvdPEhhjxYwHi8FJrAEx1vEepqwE3IkiPnXHfN9Z7iQNPk4Xbwnpl8WllDQ9VobmUXDax79wxtTHkEAlnRqeCqPI63gqJIAfPqZYJLPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505558; c=relaxed/simple;
	bh=b5bwtCmd06/L6Jy9QBapgld1YAHWBA3hoFdgraJXVss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxFH9k2fHiGB4l7c1XeSH5+PveSTvV5vks485/0u5g75YZdsEf9K3jcY6Aqc+V9ywa+mcWWpVixG6KzApS4sXTADPqpnMFjHHkwJYj70GdMUv6zSNYLoQ/Xcrea/Htrj+2DKwCLBBoiNMn+D9fMJHlbjGlawbFYzyoDIKSvMcg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vtgY0/L7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Pt0th/sp6sNgNM2uUaxqsQ6Hxx1OBIJpA19l9gnrHro=; b=vtgY0/L7MeMHUD0MFpJRFR2rKP
	sG81CAvCn8fMjS/XTqhXh0LLEqvunmYEC3qGX0x4JG5jWGjkG+hejGd3A4EkPs483E2sH01WHgG6q
	jwTNTwILIXCB/JizmnHD9ObI6FAWyPKSRyPRhgsuNfn+Ro7sGJMbi1lYsbFSt9WfbumE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sMrwY-001Bdc-Id; Thu, 27 Jun 2024 18:25:54 +0200
Date: Thu, 27 Jun 2024 18:25:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
	pabeni@redhat.com, edumazet@google.com, sd@queasysnail.net
Subject: Re: [PATCH net-next v5 07/25] ovpn: keep carrier always on
Message-ID: <c173c738-5b2f-4236-a165-c064d2d82da1@lunn.ch>
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-8-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627130843.21042-8-antonio@openvpn.net>

On Thu, Jun 27, 2024 at 03:08:25PM +0200, Antonio Quartulli wrote:
> An ovpn interface will keep carrier always on and let the user
> decide when an interface should be considered disconnected.
> 
> This way, even if an ovpn interface is not connected to any peer,
> it can still retain all IPs and routes and thus prevent any data
> leak.
> 
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

