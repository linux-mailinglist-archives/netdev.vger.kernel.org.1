Return-Path: <netdev+bounces-79714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D33F87ABB7
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 17:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE4E287321
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 16:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00584C61B;
	Wed, 13 Mar 2024 16:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="z+m1ym7W"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDD54C602
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 16:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347744; cv=none; b=SasRUSbwIoCG9/i93dVEz29FicTd+W7P1Ic83+Su/DUzxb/eCOtNEgxlepAHL1EhJc9Iw9MG4wIel1QvgXfNZpkPqKTFg8WZF4/RwZA/vPY5kdo+4KHzMJzXD9NtZovoxbQ5y0zdmsXiyKCvmhSQuPlh71oL/Meq5kRxkCAOs5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347744; c=relaxed/simple;
	bh=icQe38B1m/yKltlZRmVdTn5yp5imxgtq2ygO6bXRSgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUCN7QnJLwusJ2cxjE2GMcJzpU2Jb1oblhDHyl4Hssj+h/30Aa63ybGReTJTsVIATHjptFHEUKvQSVmLp+6d1If+bMBrwPcmsXllyx92hTBRNfXiIgB817fL/Z8qbXK5iVWrt2WABBeAgN/wnFO/FekX4Pi6AqwVV6agrGj449g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=z+m1ym7W; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sFNdlUYzXrYRM5uEYrzWa25yGZKZB4Ifr4apG2CfLSE=; b=z+m1ym7W0lwzHE0bgrEqkdM9pE
	t7ZmPEwLq+U90VZuWw32dd4eup7HdLbO4VvlBNWq76NUNOjgc/aBuFZbOiV/EX/7RCiUWFj87ey6K
	DlWhnBgXU5+qYYzpxxLIKrrFdWdu+vxQXtObwrQ+8XAqrR5M8o3VeJtJs93AWaDzFX4A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rkRaS-00AFVw-Hl; Wed, 13 Mar 2024 17:36:16 +0100
Date: Wed, 13 Mar 2024 17:36:16 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ido Schimmel <idosch@nvidia.com>, netdev <netdev@vger.kernel.org>
Subject: Re: VLAN aware bridge multicast and quierer problems
Message-ID: <08ecdc22-74bc-477a-b5e5-1aa30af2c3b6@lunn.ch>
References: <123ce9de-7ca1-4380-891b-cdbab4c4a10b@lunn.ch>
 <5f483469-fba4-4f43-a51a-66c267126709@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f483469-fba4-4f43-a51a-66c267126709@blackwall.org>

> Hi Andrew,
> Please check again, br_multicast_rcv() which is called before
> br_multicast_querier_exists() should set brmctx and pmctx to
> the proper vlan contexts. If vlan igmp snooping is enabled then
> the call to br_multicast_querier_exists() is done with the vlan's
> contexts. I'd guess per-vlan igmp snooping is not enabled (it is not
> enabled by default).

I will check. However, if per-vlan igmp snooping is not enabled i
would expect it to flood, but it is not.

      Andrew


