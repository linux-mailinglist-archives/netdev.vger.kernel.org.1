Return-Path: <netdev+bounces-57031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CE3811A9F
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 18:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247131F21378
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 17:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD973AC1B;
	Wed, 13 Dec 2023 17:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlRBHqgM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320471D6AC
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 17:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991ADC433C8;
	Wed, 13 Dec 2023 17:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702487683;
	bh=svCcv04oY4pPhaP+PSf8jygjO7luSLUDKs0GTRKp+Xs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RlRBHqgMa0oO92ov5WJduQRlrUcruMUHUti+EQXht5DU6hsCeDs4z7oTsO4CNbcWY
	 +UwIcHpj/mUePiokaJV/x1QYB+HBw2mUJIoow7/PWjs/ZrhGVbwSDydK/zHJPUXzMM
	 OQChXs3G89WUVY4M+9PE/JtvvQw6f1KKPkbnQ/PsoKABbW6Qx4lOZfgZIYWgdggLKT
	 DHCvANtI0UaRvZvjFzfsyZ7U685lsz+b4URNIYi1rS5RsBzg2A+2tfhVgnkuyEnLoe
	 w2oykk6gRAZQPzmoJIcW+McUhc2NnvLbukhCEFK0NHdq6TafGLymxJlLUP0GywYncx
	 c9BNrNegUScHA==
Date: Wed, 13 Dec 2023 17:14:37 +0000
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Kunwu Chan <chentao@kylinos.cn>, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, jacob.e.keller@intel.com,
	karol.kolacinski@intel.com, michal.michalik@intel.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kunwu Chan <kunwu.chan@hotmail.com>
Subject: Re: [PATCH v2 iwl-next] ice: Fix some null pointer dereference
 issues in ice_ptp.c
Message-ID: <20231213171437.GI5817@kernel.org>
References: <20231212024015.11595-1-chentao@kylinos.cn>
 <1abd6bcb-6f6c-10a7-9b6f-e5e038233af8@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1abd6bcb-6f6c-10a7-9b6f-e5e038233af8@intel.com>

On Wed, Dec 13, 2023 at 10:49:10AM +0100, Przemek Kitszel wrote:
> On 12/12/23 03:40, Kunwu Chan wrote:
> > devm_kasprintf() returns a pointer to dynamically allocated memory
> > which can be NULL upon failure.
> > 
> > Fixes: d938a8cca88a ("ice: Auxbus devices & driver for E822 TS")
> > Cc: Kunwu Chan <kunwu.chan@hotmail.com>
> > Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> You found the bug (or some some static analysis tool in that case);
> there is no need to add Suggested-by for every person that suggests
> something during review - the tag is for "person/s that suggested
> making such change in the repo".
> 
> Subject line would be better if less generic, eg:
> ice: avoid null deref of ptp auxbus name
> 
> > Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> > ---
> >   drivers/net/ethernet/intel/ice/ice_ptp.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> > index e9e59f4b5580..848e3e063e64 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> > @@ -2743,6 +2743,8 @@ static int ice_ptp_register_auxbus_driver(struct ice_pf *pf)
> >   	name = devm_kasprintf(dev, GFP_KERNEL, "ptp_aux_dev_%u_%u_clk%u",
> >   			      pf->pdev->bus->number, PCI_SLOT(pf->pdev->devfn),
> >   			      ice_get_ptp_src_clock_index(&pf->hw));
> > +	if (!name)
> > +		return -ENOMEM;
> >   	aux_driver->name = name;
> >   	aux_driver->shutdown = ice_ptp_auxbus_shutdown;
> > @@ -2989,6 +2991,8 @@ static int ice_ptp_create_auxbus_device(struct ice_pf *pf)
> >   	name = devm_kasprintf(dev, GFP_KERNEL, "ptp_aux_dev_%u_%u_clk%u",
> >   			      pf->pdev->bus->number, PCI_SLOT(pf->pdev->devfn),
> >   			      ice_get_ptp_src_clock_index(&pf->hw));
> > +	if (!name)
> > +		return -ENOMEM;
> >   	aux_dev->name = name;
> >   	aux_dev->id = id;
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Regarding iwl-next vs iwl-net: this bug is really unlikely to manifest,
> as we take care of both earlier and future mem allocs for ptp auxbus,
> and auxiliary_device_init() checks for null name, so no big deal,
> so: -next is fine

Thanks. FWIIW, this looks good to me too.

Reviewed-by: Simon Horman <horms@kernel.org>


