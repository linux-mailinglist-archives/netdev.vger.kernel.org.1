Return-Path: <netdev+bounces-156175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E687A054D8
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 08:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF773A20B0
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 07:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7532D1AC891;
	Wed,  8 Jan 2025 07:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UvW4A9o1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E142B1537C8
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 07:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736322969; cv=none; b=hInNSsWrVt/ZPkXpNLbb9Y5PUl7eNbMx9G5LOPc52vGlXUVhvucU/HcdVlbNNhVdYzGkkAmvW4ZEz/L32yYYOUiT59dXCdU2SxDGBxoN91ONF/9oNxbqIBQ+Wpmc9+9L1ew2vOeCDnwWDVq/rtRgdYtvU4votjEKEtRxZzGJXCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736322969; c=relaxed/simple;
	bh=/QcfGI/qmLmQrg3iSpWplrD8SEdcAMM2P3QcElzS3Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4mV/fvUCIFhSU3OfjSasTXpeIpIDKnZEFkYOKBAXdk5kCCHl+fhPTy3yLUTYoShwKGB4LJnlG4r2a+9IKNXv63cDM+pV6/hRIXXESJZjWXakMPre+1CuN0nZwim2SzhFNxyUGz4hyGk3HKiNjeZkYjdR5/qhVPDbOHXNb9Hqw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UvW4A9o1; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736322968; x=1767858968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/QcfGI/qmLmQrg3iSpWplrD8SEdcAMM2P3QcElzS3Ow=;
  b=UvW4A9o1t8PqrvcdifqXyfrqR9CvaQo75Jbk6u77v9IPc4lr1qfEUpqV
   oxogsEM6XNgK3gWM0INS0Z1RC3PPfRYgUexCOSFn6Xe7NeLxNm0jd+9OA
   0tNveM3sJD7C/rEo0ZyVn19OuaaYGGmZnepNut6CFuxk0x3rmho8Ismys
   kM0WxvoH7ispeIvye3TL+dzRXmiqpCYOeTIntEZz6eDwqvKSmsNlE26BG
   IjC2cPU8vd4EvbdWzRd2Y8kXu2e8UAn8vW06yY11v+WLcKLvteV5AN5VH
   I+AcqApU4bJLI9W8nqD6gxv9g4G6y2FJN1Jtyv5fMYmYvglFAxC/aRslj
   w==;
X-CSE-ConnectionGUID: 6WD+W0rhSZ6rLJsgHELsAA==
X-CSE-MsgGUID: 7KGh48+nRiSpeF88+Q4NIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="47111398"
X-IronPort-AV: E=Sophos;i="6.12,297,1728975600"; 
   d="scan'208";a="47111398"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 23:56:07 -0800
X-CSE-ConnectionGUID: 8llnFxfZSNiF/vYvIByBGw==
X-CSE-MsgGUID: MBrq0LQsSbezJ3pnLT967Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="108072980"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2025 23:56:04 -0800
Date: Wed, 8 Jan 2025 08:52:46 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Fix channel configuration for ETS
 Qdisc
Message-ID: <Z34uzoVY0exNKw8c@mev-dev.igk.intel.com>
References: <20250107-airoha-ets-fix-chan-v1-1-97f66ed3a068@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107-airoha-ets-fix-chan-v1-1-97f66ed3a068@kernel.org>

On Tue, Jan 07, 2025 at 11:26:28PM +0100, Lorenzo Bianconi wrote:
> Limit ETS QoS channel to AIROHA_NUM_QOS_CHANNELS in
> airoha_tc_setup_qdisc_ets() in order to align the configured channel to
> the value set in airoha_dev_select_queue().
> 
> Fixes: 20bf7d07c956 ("net: airoha: Add sched ETS offload support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/mediatek/airoha_eth.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
> index b9f1c42f0a40ca268506b4595dfa1902a15be26c..a30c417d66f2f9b0958fe1dd3829fb9ac530a34c 100644
> --- a/drivers/net/ethernet/mediatek/airoha_eth.c
> +++ b/drivers/net/ethernet/mediatek/airoha_eth.c
> @@ -2840,11 +2840,14 @@ static int airoha_qdma_get_tx_ets_stats(struct airoha_gdm_port *port,
>  static int airoha_tc_setup_qdisc_ets(struct airoha_gdm_port *port,
>  				     struct tc_ets_qopt_offload *opt)
>  {
> -	int channel = TC_H_MAJ(opt->handle) >> 16;
> +	int channel;
>  
>  	if (opt->parent == TC_H_ROOT)
>  		return -EINVAL;
>  
> +	channel = TC_H_MAJ(opt->handle) >> 16;
> +	channel = channel % AIROHA_NUM_QOS_CHANNELS;
> +
>  	switch (opt->command) {
>  	case TC_ETS_REPLACE:
>  		return airoha_qdma_set_tx_ets_sched(port, channel, opt);
> 
> ---
> base-commit: a1942da8a38717ddd9b4c132f59e1657c85c1432
> change-id: 20250107-airoha-ets-fix-chan-e35ccac76d64
> 
> Best regards,
> -- 
> Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>


