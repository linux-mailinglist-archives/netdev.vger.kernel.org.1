Return-Path: <netdev+bounces-235952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E77D5C375E9
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 19:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DE831A21ACD
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 18:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D69D26A1B5;
	Wed,  5 Nov 2025 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+P8klHQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED82D268688
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 18:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762368373; cv=none; b=TpALq2pErxNsG/DD3FkRZGwOV1SsfXMXqWv4Pq98UThT/x6sKY6VOY6/ImxdmXhHq1akD7oNy5BeNwE+2bZ3AvlQd7dDhi+lHvuAcoidq/vRYpZ+FsxiU2Pgffo6+16s7aBk78gmWk9PX8iS7eT6Fv0A66r4Udgq6qfgZHHPcfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762368373; c=relaxed/simple;
	bh=/7ve3+tQimCzMR5/qtDRaI5WhPCdOJsQTnRzqLXdSwA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C120BRj/NwegeOGGLziipqUserJrH0ypKff/jzRXkdM7/jBkWDv+5NRMIiJKVQLPtEb9bWNP0YfTkDB/8kxZ0XLPlIheo4cgBwT0F7SjQF79+0ngkTXo8d28r/E2DLoZV8tRJA79gJOIcyM2vDk86ckbawm8OxeAnAl/O45C0Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+P8klHQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C404DC116B1;
	Wed,  5 Nov 2025 18:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762368372;
	bh=/7ve3+tQimCzMR5/qtDRaI5WhPCdOJsQTnRzqLXdSwA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h+P8klHQZq/i1nHmkWblnzc1Yb4JZoInNn+x9o6PpIPgOE0rR2RYzuvy29dJxWRV5
	 nI8yHkl5fgSJHmEMcr+vHfBwITeyD6SFdBcVCWlnk2II0X1MXyqO7mrnry6VDQPmM5
	 s3a5z0KxOxwpUoZQQKdXIwjRtL/x3tUsi/zkwABEEDKzUoHcTED/FAuGp4z/Q89pR7
	 tJdjBN2VGmzHLbJ0s9GixUa2kRe6EQor5r3ekl6GJYO2gOmmL9zbVlCJHrX/sBcnSw
	 jDZGmSGAYGvfz2Ydl5Z2+0WXcYRCpHFsgRPC5YJ+MnHij6/U3p6mR4XIEV73DYqugy
	 BIFbVVmPiNr4w==
Date: Wed, 5 Nov 2025 10:46:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Manish Chopra <manishc@marvell.com>, Marco Crivellari
 <marco.crivellari@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Sunil Goutham <sgoutham@marvell.com>, Richard
 Cochran <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Simon Horman <horms@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>, Kory Maincent
 <kory.maincent@bootlin.com>, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/7] bnx2x: convert to use ndo_hwtstamp
 callbacks
Message-ID: <20251105104610.726fb780@kernel.org>
In-Reply-To: <f28ee997-ed08-4123-83ab-3496e88ed815@linux.dev>
References: <20251103150952.3538205-1-vadim.fedorenko@linux.dev>
	<20251103150952.3538205-2-vadim.fedorenko@linux.dev>
	<20251104173737.3f655692@kernel.org>
	<f28ee997-ed08-4123-83ab-3496e88ed815@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Nov 2025 13:33:08 +0000 Vadim Fedorenko wrote:
> >>   	bp->hwtstamp_ioctl_called = true;
> >> -	bp->tx_type = config.tx_type;
> >> -	bp->rx_filter = config.rx_filter;
> >> +	bp->tx_type = config->tx_type;
> >> +	bp->rx_filter = config->rx_filter;
> >>   
> >>   	rc = bnx2x_configure_ptp_filters(bp);  
> > 
> > bnx2x_configure_ptp_filters() may return -ERANGE if settings were not applied.
> > This may already be semi-broken but with the get in place we will make
> > it even worse.  
> 
> Ah, you mean in case of -ERANGE we will still have new filter
> configuration set in bp object? It's easy to fix, but it will be
> some kind of change of behavior. If it's acceptable, I'm happy to send 
> v3 of the patchset.>

True, you can probably make the -ERANGE handling a separate patch 
for ultimate clarity.

