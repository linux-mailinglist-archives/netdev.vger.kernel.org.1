Return-Path: <netdev+bounces-125710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1A396E4F9
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 23:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99EE528A967
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 21:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3AD1A4E6F;
	Thu,  5 Sep 2024 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BGRLeVc7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52949443;
	Thu,  5 Sep 2024 21:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725571295; cv=none; b=Fq9ZPhZWPj2F5+8r+SJ/02ta+o0JBf35bA+U99InfDeMBuvtc9xqyNaAANs1ZoiG+b3MbXH3wx3hmuN3eTYE3ZM4An2xA8ThkFmpoPnY0KDRSwKAIgdY9tgCRJ5KO7th/vqPjQpnL6nC3wcO2lEpa0yK/S4IhrCrX39xy1NW0Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725571295; c=relaxed/simple;
	bh=4IVvOel3qLlOXXGj8gmLQKzUAMETbKPhpfvxnd5qrg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4FZ6GkI9CfuAyZTvPJt2lXt8AwxlCXAbA8Mn0uvQB59/ZFsMg+h7aLT0974QncS73SuVYSxjCkFXqj3XPxjiz3adnNVJ07p1aCO/FWVWeEEe42idPs5+fs7bzlBQf4r58NOyMQWDbFQsm2Yv9irMIPjBlWBID3qy3HKt3VysGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BGRLeVc7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ULTDaU0ouby3tbdV1HfboMY1hzhW1DRiJvo6QZ7BPfI=; b=BGRLeVc7s6dC9FKCXVPuFY/AQs
	JjO+zEGaWl06FSh+m0Kl5gtmJ0Rf4xYATFJk2EF1ROSf3IqmYfCMdRkOq3iCG7XDBVPBu15UVnJO6
	0E8N9wkpmVgOxyhamteinofEF2Q8TP79ar+g2UEKgP1bqjlUzJ4I7JC2w5Ory68i5f+Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1smJux-006iuJ-Ss; Thu, 05 Sep 2024 23:21:27 +0200
Date: Thu, 5 Sep 2024 23:21:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net,
	chunkeey@gmail.com
Subject: Re: [PATCHv3 net-next 6/9] net: ibm: emac: use netdev's phydev
 directly
Message-ID: <f05b16ed-751c-461c-b18c-ba859492a99e@lunn.ch>
References: <20240905201506.12679-1-rosenp@gmail.com>
 <20240905201506.12679-7-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905201506.12679-7-rosenp@gmail.com>

On Thu, Sep 05, 2024 at 01:15:03PM -0700, Rosen Penev wrote:
> Avoids having to use own struct member.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

