Return-Path: <netdev+bounces-136512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D369A1F6C
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 12:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9C31C24930
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 10:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555AD1D958E;
	Thu, 17 Oct 2024 10:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5bHAQ1v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAEA1CCB44
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 10:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729159623; cv=none; b=BzZkJn7I2fnJULaAGL8OiojpCiA7KpDGDAMN+iDMI4WHEiSuGb03xzxQufY5njFhAUDgOeJlgjp2SWfuTW0nW6vBjjzuSVh5C4b8Jf6XgGvxi/vDoPn9UO32Dkx7tHt1EnJCQUJc0cQcOR0RN/53CQOw0TR5foufRUvBNKDln+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729159623; c=relaxed/simple;
	bh=YBkxxstuUuf5CLdZWYU59di/a9T0f/45jEPdXIIjQnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lmhq/qo4z0wroBCYPz22NUzHwd1t6qF1JaKQNDHRjOh3PYqx6gW4E2bPdoDcKLmsWkT4407JblUhZ+jVMPMdhs1wz4mGutIzQTAi90JnbuxG8/9mPOqnZANViVQZCI70xM3x3wXiSqMx/9ok4HJ5seF8xXF2Eibx0pJgKec8BtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5bHAQ1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD0EC4CEC3;
	Thu, 17 Oct 2024 10:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729159622;
	bh=YBkxxstuUuf5CLdZWYU59di/a9T0f/45jEPdXIIjQnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e5bHAQ1vwmQYbcHlq+dDEFuUA/WDDRObnFq7f1E1szmDJq63GJ3X9HsSWfbo+NOTN
	 U6pEH0oUahvD0CLsbs9hqjzLF5dPGJto4ZaBGA0RuJFVI6aVTekIGWS3L6CGZo5/QY
	 h40jab6SjO2/SFpOuoLYndl1f8O4KjylfawNA4q2rdeQlm1QGt+fJBbWsPZic+HAhQ
	 hDVuOqjq69SpH1xL+TPRwyTyllE7PuY4KKyPxwedD0m2TIauxxpltJqcZ4oHddl7Xk
	 V3J+Yy8poRbKDTBfuxvywwvXiPB8wop2ORpVE1DqyeAkLXjFvro92P6ldpQdSJXj7Y
	 Jy8R+K0crQuqg==
Date: Thu, 17 Oct 2024 11:06:59 +0100
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Dan Nowlin <dan.nowlin@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH iwl-next v2 1/2] ice: refactor "last" segment of DDP pkg
Message-ID: <20241017100659.GD1697@kernel.org>
References: <20241003001433.11211-4-przemyslaw.kitszel@intel.com>
 <20241003001433.11211-5-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003001433.11211-5-przemyslaw.kitszel@intel.com>

On Thu, Oct 03, 2024 at 02:10:31AM +0200, Przemek Kitszel wrote:
> Add ice_ddp_send_hunk() that buffers "sent FW hunk" calls to AQ in order
> to mark the "last" one in more elegant way. Next commit will add even
> more complicated "sent FW" flow, so it's better to untangle a bit before.
> 
> Note that metadata buffers were not skipped for NOT-@indicate_last
> segments, this is fixed now.
> 
> Minor:
>  + use ice_is_buffer_metadata() instead of open coding it in
>    ice_dwnld_cfg_bufs();
>  + ice_dwnld_cfg_bufs_no_lock() + dependencies were moved up a bit to have
>    better git-diff, as this function was rewritten (in terms of git-blame)
> 
> CC: Paul Greenwalt <paul.greenwalt@intel.com>
> CC: Dan Nowlin <dan.nowlin@intel.com>
> CC: Ahmed Zaki <ahmed.zaki@intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Hi Przemek,

Some minor feedback from my side.

> ---
> git: --inter-hunk-context=6
> 
> v2: fixed one kdoc warning
> ---
>  drivers/net/ethernet/intel/ice/ice_ddp.c | 280 ++++++++++++-----------
>  1 file changed, 145 insertions(+), 135 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
> index 016fcab6ba34..a2bb8442f281 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ddp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
> @@ -1210,6 +1210,127 @@ ice_aq_download_pkg(struct ice_hw *hw, struct ice_buf_hdr *pkg_buf,
>  	return status;
>  }
>  
> +/**
> + * ice_is_buffer_metadata - determine if package buffer is a metadata buffer
> + * @buf: pointer to buffer header
> + * Return: whether given @buf is a metadata one.
> + */
> +static bool ice_is_buffer_metadata(struct ice_buf_hdr *buf)
> +{
> +	return le32_to_cpu(buf->section_entry[0].type) & ICE_METADATA_BUF;

I see this is moving existing logic around.
And I see that this is a no-op on LE systems.
But it might be nicer to perform the byte-order conversion on the constant.

> +}
> +
> +/**
> + * struct ice_ddp_send_ctx - sending context of current DDP segment
> + * @hw: pointer to the hardware struct
> + *
> + * Keeps current sending state (header, error) for the purpose of proper "last"
> + * bit settting in ice_aq_download_pkg(). Use via calls to ice_ddp_send_hunk().

setting

> + */
> +struct ice_ddp_send_ctx {
> +	struct ice_hw *hw;
> +/* private: only for ice_ddp_send_hunk() */
> +	struct ice_buf_hdr *hdr;
> +	int err;
> +};
> +
> +/**
> + * ice_ddp_send_hunk - send one hunk of data to FW
> + * @ctx - current segment sending context
> + * @hunk - next hunk to send, size is always ICE_PKG_BUF_SIZE

Tooling seems to expect the following syntax.

 * @ctx: ...
 * @hunk: ...

> + *
> + * Send the next hunk of data to FW, retrying if needed.
> + *
> + * Notice: must be called once more with a NULL @hunk to finish up; such call
> + * will set up the "last" bit of an AQ request. After such call @ctx.hdr is
> + * cleared, @hw is still valid.
> + *
> + * Return: %ICE_DDP_PKG_SUCCESS if there were no problems; a sticky @err
> + *         otherwise.
> + */
> +static enum ice_ddp_state ice_ddp_send_hunk(struct ice_ddp_send_ctx *ctx,
> +					    struct ice_buf_hdr *hunk)

...

> +/**
> + * ice_dwnld_cfg_bufs_no_lock
> + * @ctx: context of the current buffers section to send
> + * @bufs: pointer to an array of buffers
> + * @start: buffer index of first buffer to download
> + * @count: the number of buffers to download
> + *
> + * Downloads package configuration buffers to the firmware. Metadata buffers
> + * are skipped, and the first metadata buffer found indicates that the rest
> + * of the buffers are all metadata buffers.
> + */
> +static enum ice_ddp_state
> +ice_dwnld_cfg_bufs_no_lock(struct ice_ddp_send_ctx *ctx, struct ice_buf *bufs,
> +			   u32 start, u32 count)
> +{
> +	struct ice_buf_hdr *bh;
> +	enum ice_ddp_state err;
> +
> +	if (!bufs || !count) {
> +		ctx->err = ICE_DDP_PKG_ERR;
> +		return ctx->err;
> +	}
> +
> +	bufs += start;
> +	bh = (struct ice_buf_hdr *)bufs;

Again I see that, to some extent, this is moving existing logic around.
But as bh is set in each loop iteration does it also need to be set here?

> +
> +	for (int i = 0; i < count; i++, bufs++) {
> +		bh = (struct ice_buf_hdr *)bufs;
> +		/* Metadata buffers should not be sent to FW,
> +		 * their presence means "we are done here".
> +		 */
> +		if (ice_is_buffer_metadata(bh))
> +			break;
> +
> +		err = ice_ddp_send_hunk(ctx, bh);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * ice_get_pkg_seg_by_idx
>   * @pkg_hdr: pointer to the package header to be searched

...

> @@ -1454,17 +1459,16 @@ ice_dwnld_sign_and_cfg_segs(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr,
>  	}
>  
>  	count = le32_to_cpu(seg->signed_buf_count);
> -	state = ice_download_pkg_sig_seg(hw, seg);
> +	state = ice_download_pkg_sig_seg(ctx, seg);
>  	if (state || !count)
>  		goto exit;
>  
>  	conf_idx = le32_to_cpu(seg->signed_seg_idx);
>  	start = le32_to_cpu(seg->signed_buf_start);
>  
> -	state = ice_download_pkg_config_seg(hw, pkg_hdr, conf_idx, start,
> -					    count);
> -
> +	return ice_download_pkg_config_seg(ctx, pkg_hdr, conf_idx, start, count);

This changes the conditions under which this function sets
ctx->err, which is then changed again by the following patch.
Is that intentional?

>  exit:
> +	ctx->err = state;
>  	return state;
>  }

...

