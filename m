Return-Path: <netdev+bounces-217703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B64B399D3
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 453DD560530
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B495530C62D;
	Thu, 28 Aug 2025 10:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbWqQDCu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1BA30C625
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 10:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376737; cv=none; b=uhM1Hdpl88zcm3AsNl3Mft5niLf5NcAkRc+FDGrz1PS2sWGT4BCjTcO0jlJ/mfZ85c3QFZeouVKe4Y+c1XW0z5X2A7oisTXMSR7HjzwbTpgQ88kwPbZnbfCv64l8T1lUI+6BJ+Sh2jljbAfQlLRudgm7MgZofM64FMH5iYb3it8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376737; c=relaxed/simple;
	bh=XHwowNJoQXA5hf+/fubqTR8Fxm4LloI3Io0Eo7zrZL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VL7GMfLCEa9IQY6EQfUPXEJg/TZp9F7aydsvkHtx6o5Zh8CLw3/4dd3rGYUFcGCCNQPIaKkMsITP9Af6iG8L81/5Cjr9GOI9MTq/xwBoJmjdwHrRgdW9A7Gp22OMy1QTBvfzYP7s0s/ga5LwuQhRWkAePGMQglMCF+bmA7odbEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbWqQDCu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE2AC4CEF5;
	Thu, 28 Aug 2025 10:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756376737;
	bh=XHwowNJoQXA5hf+/fubqTR8Fxm4LloI3Io0Eo7zrZL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sbWqQDCuV6aIKD2KWkEklZGivoIeS4ZmJXLZp8J0E3S3/lppWSLsOs8hj9QhTpV40
	 tt7kcA88nv5VK7YswbcWkcsrcG2Hgmj0lcU3A0J81G3BCXLTjzSoljzVQFT5x8R1B1
	 DmOb6klfQDj9ZasR/7ISgtX+NXSpMixJdFdTIA/nuQ34l6wYg/Pvdgb0+nUZLvF8QI
	 qL7hy37A5MsbXAU4kG6pzJIYo0RlqmhhKwLTyLTFciiEdcWkbFD3aSvBcS7B4ah05p
	 E/cOop7NVEXfxX0A05EOxirXz26wPx3/GKFgL54q2U2K6M2vXf7pkgdmZGn76+dyWC
	 iEntaSJbKEMsg==
Date: Thu, 28 Aug 2025 11:25:33 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, kernel-team@meta.com,
	andrew+netdev@lunn.ch, pabeni@redhat.com, davem@davemloft.net
Subject: Re: [net-next PATCH 1/4] fbnic: Move promisc_sync out of netdev code
 and into RPC path
Message-ID: <20250828102533.GV10519@horms.kernel.org>
References: <175623715978.2246365.7798520806218461199.stgit@ahduyck-xeon-server.home.arpa>
 <175623748769.2246365.2130394904175851458.stgit@ahduyck-xeon-server.home.arpa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175623748769.2246365.2130394904175851458.stgit@ahduyck-xeon-server.home.arpa>

On Tue, Aug 26, 2025 at 12:44:47PM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> In order for us to support the BMC possibly connecting, disconnecting, and
> then reconnecting we need to be able to support entities outside of just
> the NIC setting up promiscuous mode as the BMC can use a multicast
> promiscuous setup.
> 
> To support that we should move the promisc_sync code out of the netdev and
> into the RPC section of the driver so that it is reachable from more paths.
> 
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>

Reviewed-by: Simon Horman <horms@kernel.org>


