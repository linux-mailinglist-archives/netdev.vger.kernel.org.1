Return-Path: <netdev+bounces-127476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E108C975878
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 18:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C5A7B22CB1
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4A31AB6FE;
	Wed, 11 Sep 2024 16:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3DQ+l1D8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF911A3AB8;
	Wed, 11 Sep 2024 16:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726072418; cv=none; b=e26Dyxwd0KIr6y0g96X/keGKmGxO0GRd0r0Sd6AVZ4b5wqMvD2Llr+mC4iJdGl2BZyt/TMObkLFEajL3fagoLhX2ttLkgD360wL/i1t+i+E4UPI94ChRZkPekbbx9QhN1idn6aXehDleI4x4UqNuAFHyjCf4j5yuTwLFpK/WFis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726072418; c=relaxed/simple;
	bh=KqfZ7m8EhNnWklRAqvkBm7rwHrjSBYj4Do2WyPRns1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rR8nICx0IU1hjR2hqWYofvB6atU+UIINuxKW/sGnI8r/t9CwujVgHTlmFeurcLru+693gLfqPkpNrQxmAz77O43aK8mYMN2ZyBx0aH4/9qfe2KUYxcrSKNzmRP4psr7hjwne5B0X6MyMQ9xWgDVFOoat6deX28J9sbk1fjOXToc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3DQ+l1D8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PcQ5fDBXQF38IS4nRj4kQDxty2PynUOlWmn1XjuXuXM=; b=3DQ+l1D8m98ij39QikYlBuszAn
	PgWs8Jx6RTgqPxRSy4Ykvm2wipX1/HILjJbr48w/hUbni68SCLwg/Udj8FMv+nBcNtibzavtcr5Qo
	VdjcbkgacLKbMAn5Bt82DW1rnc7KgM/ZWNtGJvb8ictWaSYEOd1Qscx2o0J+rS3g3HYo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1soQHV-007ET5-Ud; Wed, 11 Sep 2024 18:33:25 +0200
Date: Wed, 11 Sep 2024 18:33:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thomas Martitz <tmartitz-oss@avm.de>
Cc: Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	jnixdorf-oss@avm.de, bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] net: bridge: drop packets with a local source
Message-ID: <210e3e45-21b3-4cbe-9372-297f32cf6967@lunn.ch>
References: <20240911125820.471469-1-tmartitz-oss@avm.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911125820.471469-1-tmartitz-oss@avm.de>

On Wed, Sep 11, 2024 at 02:58:17PM +0200, Thomas Martitz wrote:
> Currently, there is only a warning if a packet enters the bridge
> that has the bridge's or one port's MAC address as source.
> 
> Clearly this indicates a network loop (or even spoofing) so we
> generally do not want to process the packet. Therefore, move the check
> already done for 802.1x scenarios up and do it unconditionally.

Does 802.1d say anything about this?

Quoting the standard gives you a strong case for getting the patch
merged.

	Andrew

