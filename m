Return-Path: <netdev+bounces-229642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E2364BDF203
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 16:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B76A04F5136
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 14:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B188B2C029D;
	Wed, 15 Oct 2025 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrtwihAJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4C62C0278
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760539255; cv=none; b=SEz0kyKBrOf2VlhKj3Q7yOKRoZ8KSV8kH3tVKmN7dAQGphVtwQ3NRPn9jlkIsX8cgIgQFIsT/Wu8m8s9XhT6kTxFqAsuL6FpnhNoegVjzyJuZW2PSZ8MvbD/Ux1eY79Ics9A1ShSXwN1FHPtYaHDXTkL6QCn0swOZNHKFspxDgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760539255; c=relaxed/simple;
	bh=koO2xyvwa0fJSPSIQAfcP0phePRAWpFPiP1iReyMWkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qglHHnjG9YH3CHn8Z9hU/GqqlLrtyDVVFyTUqCgMmRWUGS5XRbLk6bUQHwS60eW0d4wVICQPKfsjDy45osEhAQ5ab2eRQQ8LhRYVSIyrrKO+6IkFNPQ1ZF1ceKXna0A/NEyjx+74mKfgQb3nfjWONZgD0VUOIoQiefrpvoTvxfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrtwihAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7324EC4CEF8;
	Wed, 15 Oct 2025 14:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760539255;
	bh=koO2xyvwa0fJSPSIQAfcP0phePRAWpFPiP1iReyMWkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QrtwihAJ1J4ksE6SvNI8K3AKaym9HNTunwdJv2evs+wf2aYRNGkQMrz4Vxjcpa33W
	 xmGOMptoib4h1emaX5dbvrdcsLAkG8+zDUDBd6o42bkMnXaOHsqzapi3gpjoFCbYXb
	 hM5UAO2sOTsV1iGaIxCVe3rTY0AprRUXUyQc94QS/BtWbx/VnJwD5J+pqR+LwuVHTI
	 Gre3mDtt7mSnIJj+HPhOvH6lkFD/R6YJsYFlYX+8AAkdkDsGPRMPLqCC7ZNM5+H5BY
	 UCmdZLVVifsEKnYHc4qV0bWXU1HUybRes6wcIamAWG1jstkNfTnrgujtRU7spz9UeF
	 FogrbLzPWx3Wg==
Date: Wed, 15 Oct 2025 15:40:50 +0100
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
Subject: Re: [PATCH net-next v2 7/7] funeth: convert to ndo_hwtstamp API
Message-ID: <aO-ycuW7B0zzHjG0@horms.kernel.org>
References: <20251014224216.8163-1-vadim.fedorenko@linux.dev>
 <20251014224216.8163-8-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014224216.8163-8-vadim.fedorenko@linux.dev>

On Tue, Oct 14, 2025 at 10:42:16PM +0000, Vadim Fedorenko wrote:
> Convert driver to use .ndo_hwtstamp_get()/.ndo_hwtstamp_set() callbacks.
> .ndo_eth_ioctl() implementation becomes empty, remove it.
> 
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Reviewed-by: Simon Horman <horms@kernel.org>


