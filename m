Return-Path: <netdev+bounces-161065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E26ACA1D0E2
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 07:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 528747A2BA5
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 06:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D8F15852E;
	Mon, 27 Jan 2025 06:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LPu0su/Y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6904EBA42
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 06:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737958904; cv=none; b=etUPhe0AuWiUdlU7vhSYy61moOlDpQf78kl1ljE6BvQk4mFB3Fejq8vFCH95guaxNdTtXoSR5Gw0jp04Zuh0V/DXHw61rfNpADXRBmBEjSg0YXQ8zycCLM0QnDZqtXnXHljOGdQmOx4FCyIYn+cwKnzNY8y5/YFVuocuWYuZPHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737958904; c=relaxed/simple;
	bh=gLgVcpeXmrnwWfEPyO3gi3JHNEofjORs9Alhd3iDPs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iS9XHcF8bfDeyq588aWqskGXH4w1VmprvB9QEyRsPO3BIr8xvTgCYyHJbkSoFdyolbrxtNbKXdV+cMjGcirgcfGn7jNrxBUbkDxezlDwAy1u+nnwpZ8kwbneoQUNo5SPDAfjDonQGI0iIaOwxc/eJuuWCkFxUWY4NAzCrc2zgqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LPu0su/Y; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737958903; x=1769494903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gLgVcpeXmrnwWfEPyO3gi3JHNEofjORs9Alhd3iDPs8=;
  b=LPu0su/Yt8CLSiKP+jP35gmThLjRqQzSC0HeZPrRG1yArrzsrbqQtxOI
   PhSJ5NgjfrHVmo9l9vly2gbADq22DVb5wzPFMdfoZyWek+x9pXDPF3uaG
   nVfyP8XCU4/0WtgP7ieCf79N1GeCnKJ3fdZ4o47VMOzxp1IwciXk94BZZ
   KV8hui4WhGpoFhjz7kviwHpWcnNReeV6tOjbV+ky++LBTK+2/tLrBkhnF
   q54FvlolvbPNrBcxF36CV3hyT4BKkZurcJkiR8uBcr6NmSUM0wfSUg+uk
   L8EaaFdj2P7V9lwBkTpTF6F4APYWbWr0XFHmi3wZmWe6WcUCoVp5GWf2N
   Q==;
X-CSE-ConnectionGUID: W2+QWcT/SsSecWdugZZ/Fg==
X-CSE-MsgGUID: wJOQa7g/RgqSRSmB9Q+2tQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11327"; a="49395861"
X-IronPort-AV: E=Sophos;i="6.13,237,1732608000"; 
   d="scan'208";a="49395861"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2025 22:21:43 -0800
X-CSE-ConnectionGUID: kVv3AiEdSrKMVBMQizo7xQ==
X-CSE-MsgGUID: ZUnvfQwIQiyzwcQfwtlvmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112957217"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2025 22:21:40 -0800
Date: Mon, 27 Jan 2025 07:18:12 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net] ethtool: Fix set RXNFC command with symmetric RSS
 hash
Message-ID: <Z5clJP6mmfrupjos@mev-dev.igk.intel.com>
References: <20250126191845.316589-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250126191845.316589-1-gal@nvidia.com>

On Sun, Jan 26, 2025 at 09:18:45PM +0200, Gal Pressman wrote:
> The sanity check that both source and destination are set when symmetric
> RSS hash is requested is only relevant for ETHTOOL_SRXFH (rx-flow-hash),
> it should not be performed on any other commands (e.g.
> ETHTOOL_SRXCLSRLINS/ETHTOOL_SRXCLSRLDEL).
> 
> This resolves accessing uninitialized 'info.data' field, and fixes false
> errors in rule insertion:
>   # ethtool --config-ntuple eth2 flow-type ip4 dst-ip 255.255.255.255 action -1 loc 0
>   rmgr: Cannot insert RX class rule: Invalid argument
>   Cannot insert classification rule
> 
> Fixes: 13e59344fb9d ("net: ethtool: add support for symmetric-xor RSS hash")
> Cc: Ahmed Zaki <ahmed.zaki@intel.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> ---
>  net/ethtool/ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index 7bb94875a7ec..34bee42e1247 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -998,7 +998,7 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
>  	    ethtool_get_flow_spec_ring(info.fs.ring_cookie))
>  		return -EINVAL;
>  
> -	if (ops->get_rxfh) {
> +	if (cmd == ETHTOOL_SRXFH && ops->get_rxfh) {
>  		struct ethtool_rxfh_param rxfh = {};
>  
>  		rc = ops->get_rxfh(dev, &rxfh);
> -- 
> 2.40.1

Thanks for fixing
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

