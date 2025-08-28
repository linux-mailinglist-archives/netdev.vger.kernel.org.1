Return-Path: <netdev+bounces-217942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C73B3A779
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 19:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC52188372E
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 17:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2848B334726;
	Thu, 28 Aug 2025 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIpLehis"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E5C245006
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 17:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756401232; cv=none; b=sOKvU/nNAncnn+4OcolVg94DNNqMXVTKyXfNQ6z+u3qlCKpNnU7wlwAIBeyMYj1saMhypgFNa+ExmmE3RXFDDkbKwEqEnDennrfUPjIzkC7KuRqbDpkezgOrfLV/qtgU1GiPNycnrtVmnd40FoGWyQWUYoH1ebXPlFKpPyxaGm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756401232; c=relaxed/simple;
	bh=ABcHVBvetar4+CQuBoP+z4v1K9+yhwTD3xNRdLwXNNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yq6YTvcgh6SRHWT/EKmAI1b+SUZ9xFjTfehHIuVxuEmx8V5PPCEJKksJS6urBfBB8fdRhwQrIS82acvr5CAHvav9EgaFDu6x1mKqpeMAi9uO02Iedo3kRCgbz2R43VC0MW2IvcfkQeny5jE5Dgy2xEkYpLnR3h2O+XzWqfEq/tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIpLehis; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FAD8C4CEEB;
	Thu, 28 Aug 2025 17:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756401231;
	bh=ABcHVBvetar4+CQuBoP+z4v1K9+yhwTD3xNRdLwXNNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dIpLehisJjYx0Lj/McQSPOg5WYFlFmtpuGDn6+A9rLzJSTmXLwBvNz1ht4cak3Ces
	 eJiQPBnLt45hTqXneaVCvn5I9WhGpj3uMTq3qGRyvJIvreuNlvP3U6Q4zMGkRD9R4V
	 0yc5vojg0u0NfLJAENDz9HF5769lmhs3tlzNDxSPdr2+Y1fhe/7xKDRS/uHgYJSCSB
	 BVSPNks7YVwnPbWQKKBprQcRXHl+v5qCdnq+BEnoCnehCCcKzFieGzbl5IQkJrxxeS
	 InKlBOjbmAujqnfY9le3a/9bpldAkPgSg+CqeouNLrTo+5DNH0GExxNacWvhD9XxsY
	 N5AXs4je+OAQw==
Date: Thu, 28 Aug 2025 18:13:47 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, mschmidt@redhat.com,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: Re: [PATCH iwl-next v3 5/5] iavf: add RSS support for GTP protocol
 via ethtool
Message-ID: <20250828171347.GC31759@horms.kernel.org>
References: <20250827185338.1943489-1-aleksandr.loktionov@intel.com>
 <20250827185338.1943489-6-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827185338.1943489-6-aleksandr.loktionov@intel.com>

On Wed, Aug 27, 2025 at 06:53:38PM +0000, Aleksandr Loktionov wrote:
> Extend the iavf driver to support Receive Side Scaling (RSS)
> configuration for GTP (GPRS Tunneling Protocol) flows using ethtool.
> 
> The implementation introduces new RSS flow segment headers and hash field
> definitions for various GTP encapsulations, including:
> 
>   - GTPC
>   - GTPU (IP, Extension Header, Uplink, Downlink)
>   - TEID-based hashing
> 
> The ethtool interface is updated to parse and apply these new flow types
> and hash fields, enabling fine-grained traffic distribution for GTP-based
> mobile workloads.
> 
> This enhancement improves performance and scalability for virtualized
> network functions (VNFs) and user plane functions (UPFs) in 5G and LTE
> deployments.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

> ---
>  .../net/ethernet/intel/iavf/iavf_adv_rss.c    | 119 ++++++++++++++----
>  .../net/ethernet/intel/iavf/iavf_adv_rss.h    |  31 +++++
>  .../net/ethernet/intel/iavf/iavf_ethtool.c    |  89 +++++++++++++
>  3 files changed, 216 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_adv_rss.c b/drivers/net/ethernet/intel/iavf/iavf_adv_rss.c

...

> @@ -211,6 +274,16 @@ iavf_print_adv_rss_cfg(struct iavf_adapter *adapter, struct iavf_adv_rss *rss,
>  			 IAVF_ADV_RSS_HASH_FLD_UDP_DST_PORT |
>  			 IAVF_ADV_RSS_HASH_FLD_SCTP_DST_PORT))
>  		strcat(hash_opt, "dst port,");
> +	if (hash_flds & (IAVF_ADV_RSS_HASH_FLD_GTPC_TEID | IAVF_ADV_RSS_HASH_FLD_GTPC_TEID))

nit: Perhaps this is an artifact of development.
     But IAVF_ADV_RSS_HASH_FLD_GTPC_TEID seems to repeated on
     the line above without effect.

Flagged by Coccinelle.

> +		strcat(hash_opt, "gtp-c,");
> +	if (hash_flds & IAVF_ADV_RSS_HASH_FLD_GTPU_IP_TEID)
> +		strcat(hash_opt, "gtp-u ip,");
> +	if (hash_flds & IAVF_ADV_RSS_HASH_FLD_GTPU_EH_TEID)
> +		strcat(hash_opt, "gtp-u ext,");
> +	if (hash_flds & IAVF_ADV_RSS_HASH_FLD_GTPU_UP_TEID)
> +		strcat(hash_opt, "gtp-u ul,");
> +	if (hash_flds & IAVF_ADV_RSS_HASH_FLD_GTPU_DWN_TEID)
> +		strcat(hash_opt, "gtp-u dl,");
>  
>  	if (!action)
>  		action = "";

...


