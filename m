Return-Path: <netdev+bounces-229641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93559BDF1FD
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 16:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 806564EC111
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 14:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A622D3750;
	Wed, 15 Oct 2025 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjqocMhx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D261E2D373E
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 14:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760539241; cv=none; b=SW/jDQBXVY9H1APh/l03v58YLI6gL/jzhn4EvGwoix1yYM5qni8U59wlpIp9G+bksO7OTerClHVhsshj7xBlvFckUganTzmE7MWq+symkcqRSZRjMs8VSRBg9lREtAfNZRORyDFThOI4E+z4/uRN5iPFo1ajq7eMbo4ZdEd7c0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760539241; c=relaxed/simple;
	bh=wIDmIYUrvpRsKFioX8rKlOh94AODCVu7475ZZLL0EiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfVDxQYtvOGFh+ik/63w3+5L09/8aDaOIXPJsEyLTcRC75fd4s4satH7aZy+YDy72fEjk1O6fTPxy5YFj+EeS+64XQVC8Fvco+xay29C3kS71EtoYv98DAeBrxcl50GjY46tn/WAXFFYFMonj/E1rz/LW3HiTMyUt1nTnisf7FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjqocMhx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594F7C4CEF8;
	Wed, 15 Oct 2025 14:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760539241;
	bh=wIDmIYUrvpRsKFioX8rKlOh94AODCVu7475ZZLL0EiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rjqocMhxUu2vCVL6pV/zMSGv9OxhSo6sKgQ5mXmT06a1bzLLPtuAlEiF5GZ3UN5c1
	 3to6TOdSphRztMugQhmAGgiz2Lv6xnPIJnexDcQQUYffOtHBIJ8C58m3rw/2585miM
	 DbPSpl59ZlZiXgaG1yCJuOMD6PlCTpnW6XncQ2yenvzG4m5FwmMwV2TAzQ16ojT4mf
	 9+iNqSLb8hd3SJWkqybepL4l0WhwJv2rYNcRbE99YtFchuluJtcXZpnhRCT5xJrmgm
	 z3eQvmUB/KuHRWqhOwHdLrQ8E8xwWdn3dQOkQbyHELhDDuT2NVq7OHZewE5IfN2WYJ
	 NzoD6c8/UCSGA==
Date: Wed, 15 Oct 2025 15:40:36 +0100
From: Simon Horman <horms@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Egor Pomozov <epomozov@marvell.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Dimitris Michailidis <dmichail@fungible.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/7] net: atlantic: convert to ndo_hwtstamp
 API
Message-ID: <aO-yZKCDHggMRR1y@horms.kernel.org>
References: <20251014224216.8163-1-vadim.fedorenko@linux.dev>
 <20251014224216.8163-5-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014224216.8163-5-vadim.fedorenko@linux.dev>

On Tue, Oct 14, 2025 at 10:42:13PM +0000, Vadim Fedorenko wrote:
> Convert driver to .ndo_hwtstamp_get()/.ndo_hwtstamp_set() callbacks.
> .ndo_eth_ioctl() becomes empty so remove it. Also simplify code with no
> functional changes.
> 
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Reviewed-by: Simon Horman <horms@kernel.org>


