Return-Path: <netdev+bounces-243834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3C5CA8555
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 17:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5DF9E3011B11
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 16:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9558631D38F;
	Fri,  5 Dec 2025 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCCv/XhL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D211A32B998;
	Fri,  5 Dec 2025 16:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764951373; cv=none; b=XVjYQK4ACMSm/YylBk8kFUtkHaSxf/yf3RguzLX7VtIsRbhvtHvWxLaFNs2KtUUp2LQKdKop2Wl1RcDKZGwMAGGBvkT8DwPhY3IyqFaMgqAOJOstJWGHF5zyHaHbrjRkS/iIQJmTIUt3GuNgoDEXERUZT3HIljpyR+dXmv9/qvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764951373; c=relaxed/simple;
	bh=ZdEQEkqkc+Ag6znUyPweT6q9aTx5i6UmppHhWOoNMvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYd5yW1mT8x8b8hvanaXMJ+e9UM8+7qs+Re8MfTkZ7yOV1bBBvvrBRyIRRP/aIzIZugJ9UpoOpwUPIowKB0WwxniTmNrRMBHDHXNxKm1Kq77PTlOIU9gmm6sXvibqVuDGPhMj42o4e480nQvJg4KUbiGCN3jtG07kugpY0Tr3TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCCv/XhL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDCBC4CEF1;
	Fri,  5 Dec 2025 16:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764951371;
	bh=ZdEQEkqkc+Ag6znUyPweT6q9aTx5i6UmppHhWOoNMvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QCCv/XhLhrC/32IZLIuYyb2e7GttsSUPQxwa2w4kQKU5LhieM/N2c40m6gb/f1RJJ
	 WGxJOerIHFub+uiFtiWuFTQJb9eMKwa2qkTfYd/bVNap6A9Hk4vFHZI6NL96IIehdC
	 nRSoXQZMBLivop+cZ2pF7vWZOgnSMliVjcoXn4m8cr7cfF2AsEEWlixHJAFFJiuu7/
	 Wx/sOwI8kpUQU6DsupW/BWZ32uOSrhzq0ZPZGhbM4U3L7+KlwtJjdREoAlqjsuhVQh
	 W0+kCbKgjVCy4j/op51yfc6l19Vx554ZsZ+xWBY4Wat+ukSuWjfoTVedCJT7mguobh
	 oLgDJ7BWjEXag==
Date: Fri, 5 Dec 2025 16:16:06 +0000
From: Simon Horman <horms@kernel.org>
To: Ding Hui <dinghui@sangfor.com.cn>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jacob.e.keller@intel.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ice: Fix incorrect timeout in ice_release_res()
Message-ID: <aTMFRkYZGtk3a_EP@horms.kernel.org>
References: <20251205081609.23091-1-dinghui@sangfor.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205081609.23091-1-dinghui@sangfor.com.cn>

On Fri, Dec 05, 2025 at 04:16:08PM +0800, Ding Hui wrote:
> The commit 5f6df173f92e ("ice: implement and use rd32_poll_timeout for
> ice_sq_done timeout") converted ICE_CTL_Q_SQ_CMD_TIMEOUT from jiffies
> to microseconds.
> 
> But the ice_release_res() function was missed, and its logic still
> treats ICE_CTL_Q_SQ_CMD_TIMEOUT as a jiffies value.
> 
> So correct the issue by usecs_to_jiffies().
> 
> Fixes: 5f6df173f92e ("ice: implement and use rd32_poll_timeout for ice_sq_done timeout")
> Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>

Thanks,

I agree with the analysis above and that the problem was introduced
by the cited commit.

As a fix for code present in net this should probably be targeted
at net (or iwl-net?) rather than net-next. But perhaps there is
no need to repost just to address that.

> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index 6fb0c1e8ae7c..5005c299deb1 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -1885,7 +1885,7 @@ void ice_release_res(struct ice_hw *hw, enum ice_aq_res_ids res)
>  	/* there are some rare cases when trying to release the resource
>  	 * results in an admin queue timeout, so handle them correctly
>  	 */
> -	timeout = jiffies + 10 * ICE_CTL_Q_SQ_CMD_TIMEOUT;
> +	timeout = jiffies + 10 * usecs_to_jiffies(ICE_CTL_Q_SQ_CMD_TIMEOUT);
>  	do {
>  		status = ice_aq_release_res(hw, res, 0, NULL);
>  		if (status != -EIO)

I agree this minimal change is appropriate as a bug fix.

But I think that it would be good to provide a follow-up
that reworks this code a bit to to use read_poll_timeout().
As per the aim of the cited commit.

This should be targeted at net-next (or iwl-next?).
Once this bug fix propagates to in net-next.

Reviewed-by: Simon Horman <horms@kernel.org>

