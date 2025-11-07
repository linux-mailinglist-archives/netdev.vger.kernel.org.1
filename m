Return-Path: <netdev+bounces-236603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F90C3E43F
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 03:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C816F4E232E
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 02:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A06E2E2F14;
	Fri,  7 Nov 2025 02:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6bbgn9rh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC2D2F1FCA
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 02:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762483000; cv=none; b=GFkGQ5LbXiAVwhy9pPRpn1LQvwTmCGkrUD/JrB0eUb5ogsiqIZjvE/Ajm1IwQ9X+Kk40N8Xrq4lBwlK88Pm7C9XZ3U/y5ICpHiV8gqBilQyzCtEvWGzUcW7EU5BSMDqhFokwHx+UrSiwJNrX34PevNIcGt8hjlVRNDI7+6GoEGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762483000; c=relaxed/simple;
	bh=Dv5aI87IOAKZhjNnUeLSnCuPI/fgS5AB01OFLL5TmGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/FBAfd0PFvfLtP4GqCvh0O1W6Yn/dDL9oGC1Y+DJHe4pd5dAffu69WvDD5xH8QijYfVS6JqUxp0vlsLqFJFd3LCOUeE6uKGxct+lhEI6TUeoWU1WH8y/INyMILx5vsDt8yRblsFcjY7+T9UockqUQt6IZoxi9PeGcJWw3/JIcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6bbgn9rh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=B1EFHANqWQbWmG+Bip0T1fqDDVx9nIp+yKDS7H6HnqU=; b=6bbgn9rhJb7z7RT+afvzMfRBQK
	6GIzu038NBsjZDU0CToxAoa4g0INk2Gbd0GrAQ5xiLxpGoaem97b/sntFMmENX0pFZYCei0wlDKtF
	07085irs83OAZ+XqD5wZBL64sXMHr9QhJzLvKVAt6H00Sn+HgUCJNIgc7Tfa6zytSZTo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vHCKx-00DB89-QG; Fri, 07 Nov 2025 03:36:27 +0100
Date: Fri, 7 Nov 2025 03:36:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org
Subject: Re: [PATCH net] bonding: fix mii_status when slave is down
Message-ID: <7a6372b3-b170-49b9-ae62-eb0d1266bd6c@lunn.ch>
References: <20251106180252.3974772-1-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106180252.3974772-1-nicolas.dichtel@6wind.com>

On Thu, Nov 06, 2025 at 07:02:52PM +0100, Nicolas Dichtel wrote:
> netif_carrier_ok() doesn't check if the slave is up. Before the below
> commit, netif_running() was also checked.

I assume you have a device which is reporting carrier, despite being
admin down? That is pretty unusual, and suggests its PHY handing is
broken. What device is it? You might want to also fix it.

	Andrew

