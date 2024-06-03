Return-Path: <netdev+bounces-100219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1067F8D82F8
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 14:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE125281394
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 12:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D73812C482;
	Mon,  3 Jun 2024 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3wW+9H/V"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14BA12BF3D;
	Mon,  3 Jun 2024 12:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419316; cv=none; b=o2yt3YHjEXXDZWsmRiUVFDSPWOgVnq3xMgfzIvxoXt8R4a1otxWqmPFU3DzjuPMVsQ6JO+CNOCT5lljQtyCtnavsZC9jBzPchBDCvBbsve82+pj/inYYPK6qhDOS+1u7XAokhdnXxHCD1BgqmwwMvY+Jqm8DdBWeE1Mw0mBhau0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419316; c=relaxed/simple;
	bh=op87+8r8O3Mu5KD/3h70GE8nRgroZsZIqPFDj5tkTyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gdX4hau7Ox0EY5F7sCmPdLkuUj5SGlP+fAJcSFWODas3T59BfiOlbKPXLMpxCmWSeFnPs0IZprokjm/jeQRf718N4bN01qC+ix9jCIhylITytcgI1WDekNa/jAgXdUde//n5TUQb9U2ALaocyR6HLjcGsrRFpdAXIOFvweLe064=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3wW+9H/V; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=k3zi+BtUVkLV4ak06ZQFcUP+j95KYU+wWjPkD8Hh1mA=; b=3wW+9H/VS/eqVfFrcyL9/cjet/
	Z8Fga8RgijpeSd8Cmqvx/30swWSAnR5e4vQumKq0v3Q2qhnntUUECq1Vs1oaYp567krr+z0Bz9Bcd
	balMSQ6BcwRWonxLx+11wGpyuf39ZcuWcgK69Zhmwydrw2XABg/SdThgp8PBf9xcyrEc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sE7DF-00Gi09-Ji; Mon, 03 Jun 2024 14:54:57 +0200
Date: Mon, 3 Jun 2024 14:54:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yojana Mallik <y-mallik@ti.com>
Cc: schnelle@linux.ibm.com, wsa+renesas@sang-engineering.com,
	diogo.ivo@siemens.com, rdunlap@infradead.org, horms@kernel.org,
	vigneshr@ti.com, rogerq@ti.com, danishanwar@ti.com,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com, rogerq@kernel.org,
	s-vadapalli@ti.com
Subject: Re: [PATCH net-next v2 1/3] net: ethernet: ti: RPMsg based shared
 memory ethernet driver
Message-ID: <08696402-e0e3-4559-a02d-84cac79871ab@lunn.ch>
References: <20240531064006.1223417-1-y-mallik@ti.com>
 <20240531064006.1223417-2-y-mallik@ti.com>
 <389e1f57-1666-4298-a970-74f730740e4c@lunn.ch>
 <319616d8-533e-48c6-b97e-6285d284ac9e@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <319616d8-533e-48c6-b97e-6285d284ac9e@ti.com>

On Mon, Jun 03, 2024 at 02:26:06PM +0530, Yojana Mallik wrote:
> Hi Andrew,
> 
> On 6/2/24 21:51, Andrew Lunn wrote:
> >> +struct request_message {
> >> +	u32 type; /* Request Type */
> >> +	u32 id;	  /* Request ID */
> >> +} __packed;
> >> +
> >> +struct response_message {
> >> +	u32 type;	/* Response Type */
> >> +	u32 id;		/* Response ID */
> >> +} __packed;
> >> +
> >> +struct notify_message {
> >> +	u32 type;	/* Notify Type */
> >> +	u32 id;		/* Notify ID */
> >> +} __packed;
> > 
> > These are basically identical.
> > 
> 
> The first patch introduces only the RPMsg-based driver.
> The RPMsg driver is registered as a network device in the second patch.
> struct icve_mac_addr mac_addr is added as a member to
> struct request_message in the second patch. Similarly struct icve_shm shm_info
> is added as a member to struct response_message in the second patch. From
> second patch onward struct request_message and struct response_message are not
> identical. These members are used for the network device driver. As this patch
> introduces only RPMsg-based ethernet driver these members were not used in this
> patch and hence not mentioned in this patch. I understand this has led to the
> confusion of the structures looking similar in this patch. Kindly suggest if I
> should add these members in this patch itself instead of introducing them in
> the next patch.

I think your first patch should add documentation of the whole
protocol. With a clear understanding of what the end goal is, it
becomes easier to understand the step by step implementation stages.

	Andrew

