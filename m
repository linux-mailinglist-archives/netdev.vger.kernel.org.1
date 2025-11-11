Return-Path: <netdev+bounces-237670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED136C4E811
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 15:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43E284F0C8F
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 14:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13443299928;
	Tue, 11 Nov 2025 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXxF+R1h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E58A55
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762871271; cv=none; b=iM/1I2wtShFfb/hpU9srhnRImfRTVjq51KtVOkcDhMcpH4fcsMeK3hUkwXvE55OCN5K58BbBRc+QwsUUDJiIpTHWUl26GOiDsOL+roP3SSvoLUa8lWeqmczi9jzN0+JC66wndOvmcyhNxqW2UYcxwLE8XdMa2ODkfQkNPYREsQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762871271; c=relaxed/simple;
	bh=IVaLt58dtb0b9qLEVwZRbwYV9avm+AYX5/6wAQ1kzWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YrOm56NATdDW1z/i6cd56yLKjIphWH4y34lusi53bNGGwx1AJ/s1yo5LQ1A06isScV6cjh82QKyKkIUbKZaoVYro0461WG7+K81wcMuqHbgt57m+ZzMNxSSZq/zpobtcUeDH8qFG8KyVCj5L7zgtSKb6SvSlav+Wrkzvped8hyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXxF+R1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C526C4CEFB;
	Tue, 11 Nov 2025 14:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762871270;
	bh=IVaLt58dtb0b9qLEVwZRbwYV9avm+AYX5/6wAQ1kzWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oXxF+R1hKaJgmFEkJLFamnsNCV67cfUPbcxLd/JT+EXIhq/oqbY5nDlbOMr2HP3+O
	 QkOfDu6q1DgN1eGnWJHzrs9RqojB9lI/mKJ5++3uk3TmKo104XhFWEb1gRdx2dR0Re
	 kTt5BuLvgzf8SXz/uDBUTFNUQKhHXcvZT1n1UeyPhclxwa+HxVaxAYaIbeNYzBdTiD
	 BLyaO7+lEorCbVaBr2dLAHwu0fMvE64NiP0w7/MKSSW2sJuz5hcqNmzKQOy9lgL112
	 24845DVuZL3ae3/abE+SiE51dSFUE3ll+Ca7duMfM5MHfe8ZrBbwIx0zlO7Bxegh1O
	 0hGaqzob5WrCw==
Date: Tue, 11 Nov 2025 14:27:45 +0000
From: Simon Horman <horms@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	mbloch@nvidia.com, Adithya Jayachandran <ajayachandra@nvidia.com>
Subject: Re: [PATCH net-next V2 2/3] net/mlx5: MPFS, add support for dynamic
 enable/disable
Message-ID: <aRNH4aEOOTISkIj4@horms.kernel.org>
References: <20251107000831.157375-1-saeed@kernel.org>
 <20251107000831.157375-3-saeed@kernel.org>
 <aQ9gB4lCBaK19bRo@horms.kernel.org>
 <aQ-cWqrZr_1qkgCm@x130>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ-cWqrZr_1qkgCm@x130>

On Sat, Nov 08, 2025 at 11:39:06AM -0800, Saeed Mahameed wrote:
> On 08 Nov 15:21, Simon Horman wrote:
> > On Thu, Nov 06, 2025 at 04:08:30PM -0800, Saeed Mahameed wrote:

...

> > I realise that error handling can be complex at best, and particularly
> > so when configuration ends up being partially applied. But I am wondering
> > if the cleanup here is sufficient.
> > 
> 
> Cleanup is sufficient, the use of index -1 is an indication of the entry was
> not successfully written to HW, so only if index is positive we will delete
> it from hw on cleanup.
> 
> > In a similar vein, I also note that although this function returns an
> > error, it is ignored by callers which are added by the following patch.
> > Likewise for mlx5_esw_fdb_drop_create() which is also added by the
> > following patch.
> > 
> 
> This is best effort as there could be a lot of l2 entries and we might run
> out of space, we don't want to cripple the whole system just because one VF
> mac didn't make it to the mpfs table, the approach here is similar to
> set_rx_mode ndo expectation, which this function also serves.
> 

Thanks for the clarification, I agree this is a reasonable approach.

