Return-Path: <netdev+bounces-111443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40992931107
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 11:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B931CB20CFF
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 09:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6525184101;
	Mon, 15 Jul 2024 09:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQ+b+Pod"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B1D5223
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 09:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721035150; cv=none; b=UZI8bk8DFJ9N9rON/imzFcMMTkKuPQM+RfpkIYq1mn93qMJxAvzRxg2ScdnDbSpTXVUf2Gw3TZ7ur/x4zMQSTljB2IgQFQ6+tCpkKZC9Crd+Y88w9UvpSYYF3GDf7E6wkzSlzJ3KnKxUxw1XHv36uvoApjJarpkJXJh4WtqC9fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721035150; c=relaxed/simple;
	bh=OGEwwfgxN7+lWN8jTR46KPtThgxnduU9S0F8Ja+tCJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMFGwuvTHv8wzGi/ks+ilK+9ruM3wsxK59CRwJj5rCbXFWBCHVyj8AL824e0ciqVVjnn8WuVHV14XuE5LQZuHeLO1+FQlDxmv/Qaq/W9/NjIRnygTbXLPUDdceHPU67sG4giysG/ZR00g3jzXfBInRRBZHKs5D4grvgQWohZE4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQ+b+Pod; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8660FC32782;
	Mon, 15 Jul 2024 09:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721035150;
	bh=OGEwwfgxN7+lWN8jTR46KPtThgxnduU9S0F8Ja+tCJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BQ+b+PodAJ5R3Nl37CkoLXwxpScYomXESlUcBFCov+2PQveavX1peAFOhqqrpX6da
	 5heuN6IsZzqUp/Q14tkZhHJcsfI2GyIh24mMXcZzM5CrmtU432GQUkX4NQz2wUdXpi
	 +JMhPQmkxo7bL9M6w28Ke5mfw1B2VADjHafGaFbCtQxHBQi7Z3HAaylgtqw7OULmh7
	 OyehLJxOVyCtmM8MlJGv/xYN6X2olefdyudQhIJqVXfotUtawlwMgwGcv4qTrOLby8
	 fw9ZpJij8N60PlimcHaq1jgwlGGwdadJ6sB9HvMNajMgNJeRUiqDNS6PutTVq8bgsA
	 V99/3/rBfNbxg==
Date: Mon, 15 Jul 2024 10:17:36 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Subject: Re: [PATCH net-next 3/9] bnxt_en: Support QOS and TPID settings for
 the SRIOV VLAN
Message-ID: <20240715091736.GD8432@kernel.org>
References: <20240713234339.70293-1-michael.chan@broadcom.com>
 <20240713234339.70293-4-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240713234339.70293-4-michael.chan@broadcom.com>

On Sat, Jul 13, 2024 at 04:43:33PM -0700, Michael Chan wrote:
> From: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> 
> With recent changes in the .ndo_set_vf_*() guidelines, resubmitting
> this patch that was reverted eariler in 2023:
> 
> c27153682eac ("Revert "bnxt_en: Support QOS and TPID settings for the SRIOV VLAN")

I acknowledge there was a policy change and thus
this feature can now be accepted.

- [net-next,v2] docs: net: document guidance of implementing the SR-IOV NDOs
  https://git.kernel.org/netdev/net-next/c/4558645d139c

> 
> Add these missing settings in the .ndo_set_vf_vlan() method.
> Older firmware does not support the TPID setting so check for
> proper support.
> 
> Remove the unused BNXT_VF_QOS flag.
> 
> Signed-off-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c

...

> @@ -256,21 +254,21 @@ int bnxt_set_vf_vlan(struct net_device *dev, int vf_id, u16 vlan_id, u8 qos,
>  	if (bp->hwrm_spec_code < 0x10201)
>  		return -ENOTSUPP;
>  
> -	if (vlan_proto != htons(ETH_P_8021Q))
> +	if (vlan_proto != htons(ETH_P_8021Q) &&
> +	    (vlan_proto != htons(ETH_P_8021AD) ||

nit: As a follow-up this could be updated to use eth_type_vlan()

> +	     !(bp->fw_cap & BNXT_FW_CAP_DFLT_VLAN_TPID_PCP)))
>  		return -EPROTONOSUPPORT;
>  
>  	rc = bnxt_vf_ndo_prep(bp, vf_id);
>  	if (rc)
>  		return rc;

...


