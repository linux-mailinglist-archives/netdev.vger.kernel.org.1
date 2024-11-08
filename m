Return-Path: <netdev+bounces-143306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3C79C1E80
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 14:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B61ABB25CA5
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 13:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D771F7073;
	Fri,  8 Nov 2024 13:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mwnMarNk"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A008F1F669E;
	Fri,  8 Nov 2024 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073812; cv=none; b=QUkIU2NmbN8widFUbomdxHYm9ySuQa+oghSQHpnx37JhiXoD0DN8z7Xi2yMvhi28RZISJbdh5uolBdjCPZYToauvihNI6mm/bWsF2+ZlUEESYcCPOjyPHNLPVTC1lVeHiWq6VbhYc6Zq8EfpAu3q3Q77XTnCJWsnGQW1SATARgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073812; c=relaxed/simple;
	bh=i+vmzEYcWOuiGKlgGO074kb90Iqi1D6EiBcRfCbCF0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urGUZBz2zzOZl5vrlcM4MLQLMWXLlbHWn6EUfGbVzieAQM6MWcxajS0hiME8sCNacQ9Uk/gEjb5dY4BOgDFPbmNCHh1rFz6YYtTRMgWETZR4JO6LRhN2qWgSlm+rUYjtAb02ievjzgC8XH3pzAb/TNwk9nHDZEBezgTXrSfpPMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mwnMarNk; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=19X7EJF8fAMpXZhsGOypItPY81GzMBnZQshaGH2s4YU=; b=mwnMarNkJPP5BrkOT90tMZolXv
	pwe3A/vCSQhnJWL0mTrvlxa8hlYOAkarIpL2Y5fNI1cX3g6BChR+mDmZvgrisLqJXZ9A87YOqBRNO
	egH//T1oprUjYWWnyKZwXkO/kndLx/Cbl06dMnjmt7Mzwd69oyGAquottEMauTrF5MNo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t9PN8-00CbJx-T7; Fri, 08 Nov 2024 14:49:58 +0100
Date: Fri, 8 Nov 2024 14:49:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Elliot Ayrey <elliot.ayrey@alliedtelesis.co.nz>
Cc: "David S . Miller" <davem@davemloft.net>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [RFC net-next (resend) 3/4] net: dsa: mv88e6xxx: handle
 member-violations
Message-ID: <e9829b58-664a-4bd1-bc07-5f80915a3eed@lunn.ch>
References: <20241108035546.2055996-1-elliot.ayrey@alliedtelesis.co.nz>
 <20241108035546.2055996-4-elliot.ayrey@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108035546.2055996-4-elliot.ayrey@alliedtelesis.co.nz>

> --- a/drivers/net/dsa/mv88e6xxx/switchdev.c
> +++ b/drivers/net/dsa/mv88e6xxx/switchdev.c
> @@ -79,5 +79,36 @@ int mv88e6xxx_handle_miss_violation(struct mv88e6xxx_chip *chip, int port,
>  				       brport, &info.info, NULL);
>  	rtnl_unlock();
>  
> -	return err;
> +	return notifier_to_errno(err);
> +}

This change does not look obviously correct to me. What has a miss
violation got to do with member violation? Is the existing code wrong?
What about the case when mv88e6xxx_find_vid() returns an error?

	Andrew

