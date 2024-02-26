Return-Path: <netdev+bounces-75038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A518C867E68
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 18:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7432EB264F6
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 17:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B91312C7F0;
	Mon, 26 Feb 2024 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKthYGNn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161C212AAEF
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 17:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967369; cv=none; b=quBdVtdv7BuPI+liXkpMMbAq5TxQfjg6g4qpZw2976NzZHt/fgv9n57W0BJYhEVG5yNW/ahpC9zEq4Cx/8HIPNzWSA94UNI7vldBgZbzfcSfc/2cezPWUulnF3Wja+XKREbrSbaoCQBgVfaLLp6GE8wgD6yZhg3cEZc4aSyGimU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967369; c=relaxed/simple;
	bh=O59zq4ZquGyuGfD7zdDDda7h6I2IBDplOrak/rEy9pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RD8gU9mxQ1QiFZhbUTUPwT23dIMF0vbY1MaDJpyIjolmVYAhM7FpJP50X5vzbg0bzHBWB1friLRmjwblBUucPrs34Qr6Diu7Zce9oGmZRZ7o6TZo6ibN9D1716RDgmAi7RfjUDTzf7hG/PVGA8ZoLYUSqapL2A28YAVGHh7tD0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKthYGNn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB7CC433C7;
	Mon, 26 Feb 2024 17:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708967368;
	bh=O59zq4ZquGyuGfD7zdDDda7h6I2IBDplOrak/rEy9pM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OKthYGNnPHmyphliFdWZkO6MenLmjV2iwS2X6auMHX808B8tsBTweDlL5ykcQE3z9
	 sVVxjLCd/o5nnC92pYJQD2FADGjclYiPQbW9WyMWts0G6R3/NgPY0LVlOinxAvTLZv
	 rE6Nl6pzzmL2JZ7kv4Q8eMO8MlUepmnl/g5BvjpUAiRFTVp45zGYpsmCA8vQvIw7Dj
	 xyCIZHqwveELhvdlYm8EAE0b/evE5McaWWDZ1vkGMUDCCS0IOWQxzB1Mzahqvf5I+T
	 GGVJ2UiZArvPajJzDO+Nw4Keaj4mBT8kl2SZrFu2Bf6gl1uqP4zIZ3WoO2kjz6Hqqs
	 rLHa09yXXrLFg==
Date: Mon, 26 Feb 2024 17:09:25 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [iwl-net v1] ice: reconfig host after changing MSI-X on VF
Message-ID: <20240226170925.GF13129@kernel.org>
References: <20240223064024.4333-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223064024.4333-1-michal.swiatkowski@linux.intel.com>

On Fri, Feb 23, 2024 at 07:40:24AM +0100, Michal Swiatkowski wrote:
> During VSI reconfiguration filters and VSI config which is set in
> ice_vf_init_host_cfg() are lost. Recall the host configuration function
> to restore them.
> 
> Without this config VF on which MSI-X amount was changed might had a
> connection problems.
> 
> Fixes: 4d38cb44bd32 ("ice: manage VFs MSI-X using resource tracking")
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


