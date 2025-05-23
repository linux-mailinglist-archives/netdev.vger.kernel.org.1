Return-Path: <netdev+bounces-193018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 842DDAC2353
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 15:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 448CD162A11
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 13:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7342E62C;
	Fri, 23 May 2025 13:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HtJ1bTQ9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F5B171CD;
	Fri, 23 May 2025 13:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748005434; cv=none; b=MXXfTwkHI6cMKcnYLnupXbAngFLeyx8j/Cdjqu8xQq+iG3c/2c/57P6C44vSEbcLJMO8ch8MvmEHBQb00vVxSOvBo5v4o9iewqxfpqhSBHm5yXF0ji+Dn50DRbiXnbI50AqzRZHaDQ5u8blVAXUBfeAkh5JglOQzBj0t8LOzoV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748005434; c=relaxed/simple;
	bh=OMGuUkbqqCWhUea9xIW3EaDMOIE2TeB79BGGkbGhFO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNdicVmvipVg1tN7tHa6lfeOse+A8vCFpHbaVv0NmOqSdiY6OduNIXqX/Xe+rz365zLjVdAH5jSf9fBpHlfejhf2k2MPP92y/fdwt3hAP6SdafGbge/2rb70N8jDnnUi0YrH0CdShkkTARerAQiV3SSXIbzFH6fvdf2mjky4Q5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HtJ1bTQ9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aroteuNK34qZVJ8MjdrV9bQBExaX3Mr+yw+fdkXj0pE=; b=HtJ1bTQ9g744Py5j2bvmFXn/2z
	ygrNK+q9Mk33nQQW91CKYW9/0fLkgdWsjtOioMUWwpDgKpGINBYHh7msSDKgj0DXVv0QUHs1hgJ+1
	F0lZdUrqR8yZG6PyOPFvoTK88he8FyPwSq6EhQgjsnTSfbypNj7dlKSeUFpQfWKcGUQM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uIS3r-00Dbwg-VJ; Fri, 23 May 2025 15:03:43 +0200
Date: Fri, 23 May 2025 15:03:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: Synchronize c45_ids to phy_id
Message-ID: <098e1f6a-1e0f-4819-98d7-146a28110043@lunn.ch>
References: <20250522131918.31454-1-yajun.deng@linux.dev>
 <831a5923-5946-457e-8ff6-e92c8a0818fd@lunn.ch>
 <5d16e7c3201df22074019574d947dab1b5934b87@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d16e7c3201df22074019574d947dab1b5934b87@linux.dev>


> > The second point has already been made by Russell, there are lots of
> > 
> > different C45 IDs, and phylib will try to find a driver based on any
> > 
> > of them.
> 
> I noticed that. I tested the BCM89890, 88X3310 and 88Q2110 PHY devices,
> and the ID is always the same in different MMDs.

Try a Marvel 10G PHY. They have different IDs. It has been speculated
Marvell licensed part of the PHY from a different vendor, and you see
the vendors OUI in some locations.

	Andrew

