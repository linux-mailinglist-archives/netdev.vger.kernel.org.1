Return-Path: <netdev+bounces-27986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7941877DD0B
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 11:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336672818A9
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 09:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BC4D53B;
	Wed, 16 Aug 2023 09:14:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E38D521
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 09:14:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7EEC433CA;
	Wed, 16 Aug 2023 09:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692177259;
	bh=37eOs8xTqJRLNlEmM1vit1aHCveYzgXLxOs2wviDOjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QhsipXjby4kC4pHODKOPzPF0Zf2SXinRhtfkaW9IYoex4TDg8I053r7cz1No0FDDz
	 bOXun6q46fRwNL96AbLOqsNtnwcO8woSdpW0VEsGz5ueA+nRJ94cW+DDA9qRpt+iup
	 ps3sa6y9u3VDuyNl3/Q1J0TK66AMddX2OWUkfTI7qVsDUrtPJtEZRrKO7L7hGoRhuB
	 icv5Cb1+9dTEubm82JXTR3XK18DlZiX+xtzHg7JNPOwyquu1knfHYLmtVwP4DposeK
	 ve9uQadkY3wP7HFDIVh4hZuPgobQroXV7CdhvjRGF8xNPW/NeOZsNScZQeJM1q4i85
	 xlpm4QE1xyISQ==
Date: Wed, 16 Aug 2023 11:14:16 +0200
From: Simon Horman <horms@kernel.org>
To: Wenjun Wu <wenjun1.wu@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	xuejun.zhang@intel.com, madhu.chittim@intel.com,
	qi.z.zhang@intel.com, anthony.l.nguyen@intel.com
Subject: Re: [PATCH iwl-next v3 5/5] iavf: Add VIRTCHNL Opcodes Support for
 Queue bw Setting
Message-ID: <ZNyTaPtGSsEIHLXe@vergenet.net>
References: <20230727021021.961119-1-wenjun1.wu@intel.com>
 <20230816033353.94565-1-wenjun1.wu@intel.com>
 <20230816033353.94565-6-wenjun1.wu@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816033353.94565-6-wenjun1.wu@intel.com>

On Wed, Aug 16, 2023 at 11:33:53AM +0800, Wenjun Wu wrote:
> From: Jun Zhang <xuejun.zhang@intel.com>
> 
> iavf rate tree with root node and queue nodes is created and registered
> with devlink rate when iavf adapter is configured.
> 
> User can configure the tx_max and tx_share of each queue. If any one of
> the queues have been fully updated by user, i.e. both tx_max and
> tx_share have been updated for that queue, VIRTCHNL opcodes of
> VIRTCHNL_OP_CONFIG_QUEUE_BW and VIRTCHNL_OP_CONFIG_QUANTA will be sent
> to PF to configure queues allocated to VF if PF indicates support of
> VIRTCHNL_VF_OFFLOAD_QOS through VF Resource / Capability Exchange.
> 
> Signed-off-by: Jun Zhang <xuejun.zhang@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c

...

> @@ -5005,10 +5035,18 @@ static int iavf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	/* Setup the wait queue for indicating virtchannel events */
>  	init_waitqueue_head(&adapter->vc_waitqueue);
>  
> +	len = struct_size(adapter->qos_caps, cap, IAVF_MAX_QOS_TC_NUM);
> +	adapter->qos_caps = kzalloc(len, GFP_KERNEL);
> +	if (!adapter->qos_caps)

Hi Jun Zhang and Wenjun Wu,

The goto below leads to the function returning err.
Should err be set to an error value here?

As flagged by Smatch and Coccinelle.

> +		goto err_ioremap;
> +
>  	/* Register iavf adapter with devlink */
>  	err = iavf_devlink_register(adapter);
> -	if (err)
> +	if (err) {
>  		dev_err(&pdev->dev, "devlink registration failed: %d\n", err);
> +		kfree(adapter->qos_caps);
> +		goto err_ioremap;
> +	}
>  
>  	/* Keep driver interface even on devlink registration failure */
>  	return 0;

...

