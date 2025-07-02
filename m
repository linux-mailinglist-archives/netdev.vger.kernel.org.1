Return-Path: <netdev+bounces-203327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C71AF15DD
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 14:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3BAA4E3C05
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 12:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA1C26D4E4;
	Wed,  2 Jul 2025 12:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5fF0Yfp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65EE25E817
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 12:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751459931; cv=none; b=sNBhM85WVvgp1k9vmeD/xIJ8LGAJTDdk1eR9ZvqhhddLWttvt/owy/Y9p4eU0USACzglN2T75ZTP/f2hLg0IQWixdK0gIFPRD3f0cUBZS9/53LqUj2Ui5YAgWkCOhuZ1D2QxrSRgfh3rj8oTWEKu1o0uqKpEqCmUGHDhf85538c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751459931; c=relaxed/simple;
	bh=b3HGW3jI+qyd6yKAhnwh4VLGrmWxkb0h7xtVsUj08uE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzqToN6vf61Xq0GVCDt450fhKW3gzUgRdOx3xmFWaHcVVkaqvgsjijW5SWBOIDDLie/8ymWMj3X0sy94b/tuRfQ6tpg5IdnHkoy/liq1sIxUFE8C/TpSu6dxbu7KmXKU4gBs0RBXj6OC9r9HqDYmP2+cWoXVchv48gDehLX/DIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5fF0Yfp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CA9C4CEED;
	Wed,  2 Jul 2025 12:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751459931;
	bh=b3HGW3jI+qyd6yKAhnwh4VLGrmWxkb0h7xtVsUj08uE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m5fF0YfpFbf9Top8bRaTAc2yWP3wDwEGG3XtdlSNJledzHKIsKZUiAJX3DTAUmO/5
	 0xZJ3QlwkZWR44TSmyrHzcCNGbdsk20sjKq6akjxYLzbpX3NpT8gnu7OjuarUN9FwY
	 Yz5iOj9jf1Z9uyB/n0sPckq9esnkl8LPWcLGw1KY8/p+yQM8Nkqp86LsvdKcLce7is
	 D0szj/B5w9jrCXSPwhEZNSuyCZUqQPCT+EHMDzYI2SeknlB5u10Da+dtAdKaiKEdrZ
	 lwNs3xidG5cLRXBgG4irDyisE88kD5kt0hQFlBRMAaEamJNyg7Tts5lEX+qa+o29EH
	 BWzDW7YvqFhaA==
Date: Wed, 2 Jul 2025 13:38:47 +0100
From: Simon Horman <horms@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	Shyam-sundar.S-k@amd.com
Subject: Re: [PATCH net v3] amd-xgbe: do not double read link status
Message-ID: <20250702123847.GD41770@horms.kernel.org>
References: <20250701065016.4140707-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701065016.4140707-1-Raju.Rangoju@amd.com>

On Tue, Jul 01, 2025 at 12:20:16PM +0530, Raju Rangoju wrote:
> The link status is latched low so that momentary link drops
> can be detected. Always double-reading the status defeats this
> design feature. Only double read if link was already down
> 
> This prevents unnecessary duplicate readings of the link status.
> 
> Fixes: 4f3b20bfbb75 ("amd-xgbe: add support for rx-adaptation")
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---
> Changes since v2:
> - update the commit message
> - avoid using gotos for normal function control flow
> 
> Changes since v1:
> - skip double-read to detect short link drops
> - refine the subject line for clarity

Thanks for the updates.
I agree this addresses Jakub's review of v2.

Reviewed-by: Simon Horman <horms@kernel.org>


