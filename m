Return-Path: <netdev+bounces-244917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B85A1CC2162
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 12:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C754F3018775
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 11:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D12D32861D;
	Tue, 16 Dec 2025 11:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8nBTBSW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484B32367D5
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 11:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765883444; cv=none; b=sZL8yCJ+80jUigHj8Fer3GeMBCRjfGGz0KL9mjHPhGT1LHxUX3+/SqL8ypdtiJ0AtsjFuSqKGiAbJlOKTCGH+SDDeApPWs7lAXruqx8hUntfj9w3twUL0Yp3p5tiT4zlzDAJFl7KN/i3VrEKSycQSh3UGPxGySAlrBmRC4q10A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765883444; c=relaxed/simple;
	bh=NI4NjD3PlzVIL+H2wzrBEamrhhAQClanb0BH5U3FABU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZaeoiXrUuYtC/M5Nbrf0jFlVtcK5Rv9WL0chDnhh9xqhP9heqIrSt3sD4oHd197wvK4vOjbiNumwsImiRZQUh1UMym+SdkFixZUoMVgqIunwoXFeYE4rg56VOoHHoZ0OHjkD7LSe52lQxSqK93nQgniF6nzbDe2ON+RyS0mHks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8nBTBSW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20681C4CEF1;
	Tue, 16 Dec 2025 11:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765883443;
	bh=NI4NjD3PlzVIL+H2wzrBEamrhhAQClanb0BH5U3FABU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y8nBTBSWKksjnlZ+2PG/MKjuDLKIldPjl1WMQ/xAgVQCTsejDmXLijJLHMz1RL2W9
	 vs/+Rjq0f1OxUcnq9IP09X+/OqiadAytMan55jI+Nh+8vucdZsi47uTEJ8EIj+zgFY
	 gOdTtU0CiH2DjOgISJrT9gIW8ptxMdYf8YJBcGaIwr8ATBVd4BqM8Yi25jmO1ehkJW
	 bYt7GD5IczvIwnjkhRKyBE906yfb6pUsfQ3REc/tR0c8iJWtuvPAAGy6muBmSjhgYW
	 EuXyVnREjaFvfD1Re3BGIR35zKRcN1WPASUx4YTxhdOmWvol3dK3YyN9TMXriFqpbe
	 3PQ4rKxPeZmuA==
Date: Tue, 16 Dec 2025 11:10:39 +0000
From: Simon Horman <horms@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
	Shyam-sundar.S-k@amd.com
Subject: Re: [PATCH net] amd-xgbe: reset retries and mode on RX adapt failures
Message-ID: <aUE-L3LsRa4bUn1-@horms.kernel.org>
References: <20251215151728.311713-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215151728.311713-1-Raju.Rangoju@amd.com>

On Mon, Dec 15, 2025 at 08:47:28PM +0530, Raju Rangoju wrote:
> During the stress tests, early RX adaptation handshakes can fail, such
> as missing the RX_ADAPT ACK or not receiving a coefficient update before
> block lock is established. Continuing to retry RX adaptation in this
> state is often ineffective if the current mode selection is not viable.
> 
> Resetting the RX adaptation retry counter when an RX_ADAPT request fails
> to receive ACK or a coefficient update prior to block lock, and clearing
> mode_set so the next bring-up performs a fresh mode selection rather
> than looping on a likely invalid configuration.
> 
> Fixes: 4f3b20bfbb75 ("amd-xgbe: add support for rx-adaptation")
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>

Reviewed-by: Simon Horman <horms@kernel.org>


