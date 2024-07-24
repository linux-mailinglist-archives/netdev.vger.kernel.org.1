Return-Path: <netdev+bounces-112805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65ACF93B502
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 18:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2204F282E4F
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 16:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FAC1CD3F;
	Wed, 24 Jul 2024 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hY5k8GqE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9AB17C6A
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721838620; cv=none; b=HiZNMUfywVY513+lxnrsp3H5gVyE4zhYNXS1hngRLS2dl5kWax66vbKhQXoiaLd525DUuoKLm/vtzD8pmrPjIZOJ1pSMKUvHUV2BBEjnLMM+eqJXq3xXfr1ci3pBdXE5tfoGHh0sD9rysd8DB6dE2/FesHIM61enCcsKKSpiGS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721838620; c=relaxed/simple;
	bh=pdloUzkhjOyyHbG95eWHh1DIEfSYhXIR31SEwN6htKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBz2iCvgrlEYEOdqG8/DOL9WS2T5Ts21Ry89sdZaDnlY4O6lHCb8skD8epBp2HKS9Fxdr9Yw5BWxGzmXdAy9svd3E+i0SLyV7iEW0cFahuVBmR032e5AxMaqEexblnI/q6qh5hEK32FUF4/wscaqZoPRqQVu21m+I4RGHecF3/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hY5k8GqE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042E8C32781;
	Wed, 24 Jul 2024 16:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721838620;
	bh=pdloUzkhjOyyHbG95eWHh1DIEfSYhXIR31SEwN6htKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hY5k8GqENKG0OR27HYyUIxDVN8GPu3pDYZS1R/j9pCzxr7qolas9c3+CdVjq/cxwV
	 RGYc3u2SSjb/ahXnIJa4x46hRtuOwhwgZl8dc4VUud2+nSnwPqZI+zaAtsqzhRXQhb
	 Onl4uEPRwBS7btndxhck60b61WDVAIesjxdYGUTflLCqiCQNcG51Ja1enAm2SxyeX7
	 1/ZRkyI+SSzn1ep71a5J/r6W6DUIi59Fbk5QPQUWsgWlfdhakms6NGCJRTDfnIGCBR
	 AUUk/9R4BtNP5WOxRxZEWEbbCrcBZlGGBTVJ1dhF+eh2TbfaNpsJm1h46xSW+97fSs
	 gB7uHDacJ3x/g==
Date: Wed, 24 Jul 2024 17:30:16 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: Re: [PATCH iwl-next v3 12/13] iavf: refactor add/del FDIR filters
Message-ID: <20240724163016.GB97837@kernel.org>
References: <20240710204015.124233-1-ahmed.zaki@intel.com>
 <20240710204015.124233-13-ahmed.zaki@intel.com>
 <20240722150431.GK715661@kernel.org>
 <4691e62b-0597-4184-8e85-0e74d8cdab85@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4691e62b-0597-4184-8e85-0e74d8cdab85@intel.com>

On Wed, Jul 24, 2024 at 10:14:19AM -0600, Ahmed Zaki wrote:

...

> > > +/**
> > > + * iavf_fdir_del_fltr - delete a flow director filter from the list
> > > + * @adapter: pointer to the VF adapter structure
> > > + * @loc: location to delete.
> > > + *
> > > + * Return: 0 on success or negative errno on failure.
> > > + */
> > > +int iavf_fdir_del_fltr(struct iavf_adapter *adapter, u32 loc)
> > > +{
> > > +	struct iavf_fdir_fltr *fltr = NULL;
> > > +	int err = 0;
> > > +
> > > +	spin_lock_bh(&adapter->fdir_fltr_lock);
> > > +	fltr = iavf_find_fdir_fltr(adapter, loc);
> > > +
> > > +	if (fltr) {
> > > +		if (fltr->state == IAVF_FDIR_FLTR_ACTIVE) {
> > > +			fltr->state = IAVF_FDIR_FLTR_DEL_REQUEST;
> > > +		} else if (fltr->state == IAVF_FDIR_FLTR_INACTIVE) {
> > > +			list_del(&fltr->list);
> > > +			kfree(fltr);
> > > +			adapter->fdir_active_fltr--;
> > > +			fltr = NULL;
> > > +		} else {
> > > +			err = -EBUSY;
> > > +		}
> > > +	} else if (adapter->fdir_active_fltr) {
> > > +		err = -EINVAL;
> > > +	}
> > > +
> > > +	if (fltr && fltr->state == IAVF_FDIR_FLTR_DEL_REQUEST)
> > > +		iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_DEL_FDIR_FILTER);
> > 
> > It seems that prior to this change the condition and call to
> > iavf_schedule_aq_request were not protected by fdir_fltr_lock, and now they
> > are. If so, is this change intentional.
> > 
> 
> yes it is, fltr is member of the list that should be protected by the
> spinlock.

Thanks,

I would suggest moving this into a separate patch: changing locking is a
bit different to refactoring.

Or, if not, at least mentioning it in the patch description.

