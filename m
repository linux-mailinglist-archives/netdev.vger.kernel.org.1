Return-Path: <netdev+bounces-184385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C74E7A9529D
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 16:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B65353B43F9
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 14:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD04A166F29;
	Mon, 21 Apr 2025 14:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3Jo7K93"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFD213A418;
	Mon, 21 Apr 2025 14:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745245185; cv=none; b=jQDXtWcCUBdMY76WIOZuvn5SLLKJ1xzTUOGT9ULEUV3cQHzcficVR/ztqnkEBM3M0NSdzT+0JKSYUGwiJpIz8lakKa34LD7/NDpdFW7yLk2X0wuoMith1TVvTbsJYN7W7vap6eoMOwRBNUKBOM3fyfRnscDtDHjs+Bo1ic+NADs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745245185; c=relaxed/simple;
	bh=Tr9+pqiq4D1eXz6CFkFBVMqYsvom8aBnfD6QBxYvocg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhanomHGxtcgxml67b4VsGrQ5VBqwOgnIOAq0C6rMuvXQaBLPBqMxGzFu2CFSKAXTXBgTtyKcmIUgV8a6/Dua4pJQxrQbVytBXZp7VYALQtgj62Wjh0Amvs6+IAkM4iOk5RzNIrKI47/po2/7HCYtJI6sOXGju/HTQmxFi1uVgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3Jo7K93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A95C4CEE4;
	Mon, 21 Apr 2025 14:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745245185;
	bh=Tr9+pqiq4D1eXz6CFkFBVMqYsvom8aBnfD6QBxYvocg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t3Jo7K93LVgH9rdJjTmiOPAouPdZfKVSSsI7tt0fE5/7NBNVaKUOx2TsqBgxaCnsx
	 Z7XXaeoqdpcPl/j8zO29nasbGPGUeZReKOfPCG6Ag71sWYNoH69DrPvAqv6XHr5h4+
	 c+8qagFwgMr0+CDx/i7qjqdHTkccn08kGgN1SR9suu+8LjldZMoLT4aNJ7bqJ5pfez
	 XQFZ1fmQeeyR5vpQHfmuVM4+O+Tcys00pb6Xq31Y6QNAr4YSADBc0pEUsdetpE8Reo
	 mWdp8kB+FdDO3RCPww9QmdbioUw8FXut2rQ1PvdJcPYRb7qQvxIZB0P1JAhK30yoyY
	 nDS0mdRdLjsHw==
Date: Mon, 21 Apr 2025 15:19:37 +0100
From: Simon Horman <horms@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Lee Trager <lee@trager.us>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Wenjun Wu <wenjun1.wu@intel.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Karlsson, Magnus" <magnus.karlsson@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Josh Hay <joshua.a.hay@intel.com>,
	Milena Olech <milena.olech@intel.com>, pavan.kumar.linga@intel.com,
	"Singhai, Anjali" <anjali.singhai@intel.com>,
	Phani R Burra <phani.r.burra@intel.com>
Subject: Re: [PATCH iwl-next 06/14] libeth: add bookkeeping support for
 control queue messages
Message-ID: <20250421141937.GI2789685@horms.kernel.org>
References: <20250408124816.11584-1-larysa.zaremba@intel.com>
 <20250408124816.11584-7-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408124816.11584-7-larysa.zaremba@intel.com>

On Tue, Apr 08, 2025 at 02:47:52PM +0200, Larysa Zaremba wrote:
> From: Phani R Burra <phani.r.burra@intel.com>
> 
> All send control queue messages are allocated/freed in libeth itself
> and tracked with the unique transaction (Xn) ids until they receive
> response or time out. Responses can be received out of order, therefore
> transactions are stored in an array and tracked though a bitmap.
> 
> Pre-allocated DMA memory is used where possible. It reduces the driver
> overhead in handling memory allocation/free and message timeouts.
> 
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Phani R Burra <phani.r.burra@intel.com>
> Co-developed-by: Victor Raj <victor.raj@intel.com>
> Signed-off-by: Victor Raj <victor.raj@intel.com>
> Co-developed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Co-developed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  drivers/net/ethernet/intel/libeth/controlq.c | 578 +++++++++++++++++++
>  include/net/libeth/controlq.h                | 169 ++++++
>  2 files changed, 747 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/libeth/controlq.c b/drivers/net/ethernet/intel/libeth/controlq.c

...

> +/**
> + * libeth_ctlq_xn_deinit - deallocate and free the transaction manager resources
> + * @xnm: pointer to the transaction manager
> + * @ctx: controlq context structure
> + *
> + * All Rx processing must be stopped beforehand.
> + */
> +void libeth_ctlq_xn_deinit(struct libeth_ctlq_xn_manager *xnm,
> +			   struct libeth_ctlq_ctx *ctx)
> +{
> +	bool must_wait = false;
> +	u32 i;
> +
> +	/* Should be no new clear bits after this */
> +	spin_lock(&xnm->free_xns_bm_lock);
> +		xnm->shutdown = true;

nit: The line above is not correctly indented.

     Flagged by Smatch.

> +
> +	for_each_clear_bit(i, xnm->free_xns_bm, LIBETH_CTLQ_MAX_XN_ENTRIES) {
> +		struct libeth_ctlq_xn *xn = &xnm->ring[i];
> +
> +		spin_lock(&xn->xn_lock);
> +
> +		if (xn->state == LIBETH_CTLQ_XN_WAITING ||
> +		    xn->state == LIBETH_CTLQ_XN_IDLE) {
> +			complete(&xn->cmd_completion_event);
> +			must_wait = true;
> +		} else if (xn->state == LIBETH_CTLQ_XN_ASYNC) {
> +			__libeth_ctlq_xn_push_free(xnm, xn);
> +		}
> +
> +		spin_unlock(&xn->xn_lock);
> +	}
> +
> +	spin_unlock(&xnm->free_xns_bm_lock);
> +
> +	if (must_wait)
> +		wait_for_completion(&xnm->can_destroy);
> +
> +	libeth_ctlq_xn_deinit_dma(&ctx->mmio_info.pdev->dev, xnm,
> +				  LIBETH_CTLQ_MAX_XN_ENTRIES);
> +	kfree(xnm);
> +	libeth_ctlq_deinit(ctx);
> +}
> +EXPORT_SYMBOL_NS_GPL(libeth_ctlq_xn_deinit, "LIBETH_CP");

...

