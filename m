Return-Path: <netdev+bounces-112439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E7F93914C
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 17:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A17F1C2137F
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 15:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B0316DC19;
	Mon, 22 Jul 2024 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Be9pn3q+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA3D16CD1D
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721660675; cv=none; b=ht574S50gwnVuSBEAH2HOXt6d7S8zMNk3guP2simzblBTvXyU5/gdwswiHit+4GT2/D9fdx/oq8yO3Ny7xJQfJ5axi0PMU/GbXLbb52gq1YXv5cfDk5GoNHG3905KY/qi13/JvZ/Tfednr51knP2avG5BVlHDgZVyB1uK13x2cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721660675; c=relaxed/simple;
	bh=7kkoTuqfC4Oik6634QuQWnmFJIwKloEbGGhIQxEOBhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyanJVWpFP0GTUB54k3GtmlH1TopHFfFTB1CXwmUxKdfT11krRL77ZKUA32oKj9Ziu73Ujv5p/+zgFbXs44vRPjkSqLUA/kHo3jxTWLo1YFIVrFqJW+b1+djJahW4q2Sjlf8dCq8jJvGTmuoOCARrFQX6vQUNaSlD6rz+8KauT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Be9pn3q+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C558C116B1;
	Mon, 22 Jul 2024 15:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721660674;
	bh=7kkoTuqfC4Oik6634QuQWnmFJIwKloEbGGhIQxEOBhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Be9pn3q+l/H6+qhD1kJCjzFrlrvkINr5HxkO8Ctlt6QAGi7V1NzJbGFAV/sHkKx2L
	 eLKHIMFaAc4TZp4D67EdrViFiFUxRilJqCsOHu9Xd+RdfT8VOPaLsYaLKc3S98N4oD
	 Ak80NTs5mNiXijLRAHY/e8CMlBER7+wefsnTE/BnhDctECIDHVdXPjyiCPROIJGPo0
	 sVuKEMH8GqDf2irzkFmYiN5XME+L+K3RC5OjQBzEVtZuMjX8ZDdLQ3rZFgW2xSgv7p
	 MzGFuqXEmACQm+A8qjjgKyYEuXLd02tmzr6l8YnMBJ8sFrGBUm3J0FG1rC4YDKKUHh
	 rb2+1mvZEHEuw==
Date: Mon, 22 Jul 2024 16:04:31 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: Re: [PATCH iwl-next v3 12/13] iavf: refactor add/del FDIR filters
Message-ID: <20240722150431.GK715661@kernel.org>
References: <20240710204015.124233-1-ahmed.zaki@intel.com>
 <20240710204015.124233-13-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710204015.124233-13-ahmed.zaki@intel.com>

On Wed, Jul 10, 2024 at 02:40:14PM -0600, Ahmed Zaki wrote:
> In preparation for a second type of FDIR filters that can be added by
> tc-u32, move the add/del of the FDIR logic to be entirely contained in
> iavf_fdir.c.
> 
> The iavf_find_fdir_fltr_by_loc() is renamed to iavf_find_fdir_fltr()
> to be more agnostic to the filter ID parameter (for now @loc, which is
> relevant only to current FDIR filters added via ethtool).
> 
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h        |  5 ++
>  .../net/ethernet/intel/iavf/iavf_ethtool.c    | 56 ++-------------
>  drivers/net/ethernet/intel/iavf/iavf_fdir.c   | 72 +++++++++++++++++--
>  drivers/net/ethernet/intel/iavf/iavf_fdir.h   |  7 +-
>  4 files changed, 83 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
> index 23a6557fc3db..85bd6a85cf2d 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf.h
> @@ -444,6 +444,11 @@ struct iavf_adapter {
>  	spinlock_t adv_rss_lock;	/* protect the RSS management list */
>  };
>  
> +/* Must be called with fdir_fltr_lock lock held */
> +static inline bool iavf_fdir_max_reached(struct iavf_adapter *adapter)
> +{
> +	return (adapter->fdir_active_fltr >= IAVF_MAX_FDIR_FILTERS);

nit: these parentheses seem unnecessary.

> +}
>  
>  /* Ethtool Private Flags */
>  

...

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_fdir.c b/drivers/net/ethernet/intel/iavf/iavf_fdir.c

...

> +/**
> + * iavf_fdir_del_fltr - delete a flow director filter from the list
> + * @adapter: pointer to the VF adapter structure
> + * @loc: location to delete.
> + *
> + * Return: 0 on success or negative errno on failure.
> + */
> +int iavf_fdir_del_fltr(struct iavf_adapter *adapter, u32 loc)
> +{
> +	struct iavf_fdir_fltr *fltr = NULL;
> +	int err = 0;
> +
> +	spin_lock_bh(&adapter->fdir_fltr_lock);
> +	fltr = iavf_find_fdir_fltr(adapter, loc);
> +
> +	if (fltr) {
> +		if (fltr->state == IAVF_FDIR_FLTR_ACTIVE) {
> +			fltr->state = IAVF_FDIR_FLTR_DEL_REQUEST;
> +		} else if (fltr->state == IAVF_FDIR_FLTR_INACTIVE) {
> +			list_del(&fltr->list);
> +			kfree(fltr);
> +			adapter->fdir_active_fltr--;
> +			fltr = NULL;
> +		} else {
> +			err = -EBUSY;
> +		}
> +	} else if (adapter->fdir_active_fltr) {
> +		err = -EINVAL;
> +	}
> +
> +	if (fltr && fltr->state == IAVF_FDIR_FLTR_DEL_REQUEST)
> +		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_DEL_FDIR_FILTER);

It seems that prior to this change the condition and call to
iavf_schedule_aq_request were not protected by fdir_fltr_lock, and now they
are. If so, is this change intentional.

> +
> +	spin_unlock_bh(&adapter->fdir_fltr_lock);
> +	return err;
>  }

...

