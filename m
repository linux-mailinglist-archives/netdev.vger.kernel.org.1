Return-Path: <netdev+bounces-24047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA5A76E9A0
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 15:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E612814A2
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 13:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCF01F163;
	Thu,  3 Aug 2023 13:11:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EA71ED51
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 13:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A311C433C8;
	Thu,  3 Aug 2023 13:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691068291;
	bh=NFgjhsYWKg2kV+IdSU2QgpqJ/xaClNZ3CuB7+zRizSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QItRHDP0Kz/gHLGpJUI7kH4nlfINPbSSuXKkXQAeJswaJN1lpxtIG0ydN0DoqQyw+
	 4ktIX+sNgpp6y3H6P5s6X1YoxaFn9loWWSL+ebUxdGw5JGT8i8PaHHmvgWY5x7yfa2
	 8fqHWuvaK4Tz2r6EJGjalQPqv7Bqv3CIxQHtFNw1rBJTwK66yNCtyv+ThOHyw/AiwZ
	 uG0VqyjFKqWEhi/26P97oo4sS4D+HRlyTUw0vMN2sw1F/dB9LkdWRHjSbVMFWabbIK
	 KlBti9mA5dUQqdGuk9H7OYp12UK1qeka+W2rnniWjxO7zUowFfsykM+cHSdiC0+2GH
	 IEBBzezxejJLA==
Date: Thu, 3 Aug 2023 16:11:26 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net] ice: Block switchdev mode when ADQ is acvite and
 vice versa
Message-ID: <20230803131126.GD53714@unreal>
References: <20230801115235.67343-1-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801115235.67343-1-marcin.szycik@linux.intel.com>

On Tue, Aug 01, 2023 at 01:52:35PM +0200, Marcin Szycik wrote:
> ADQ and switchdev are not supported simultaneously. Enabling both at the
> same time can result in nullptr dereference.
> 
> To prevent this, check if ADQ is active when changing devlink mode to
> switchdev mode, and check if switchdev is active when enabling ADQ.
> 
> Fixes: fbc7b27af0f9 ("ice: enable ndo_setup_tc support for mqprio_qdisc")
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_eswitch.c | 5 +++++
>  drivers/net/ethernet/intel/ice/ice_main.c    | 6 ++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> index ad0a007b7398..2ea5aaceee11 100644
> --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> @@ -538,6 +538,11 @@ ice_eswitch_mode_set(struct devlink *devlink, u16 mode,
>  		break;
>  	case DEVLINK_ESWITCH_MODE_SWITCHDEV:
>  	{
> +		if (ice_is_adq_active(pf)) {
> +			dev_err(ice_pf_to_dev(pf), "switchdev cannot be configured - ADQ is active. Delete ADQ configs using TC and try again\n");

It needs to be reported through netlink extack.

> +			return -EOPNOTSUPP;
> +		}
> +
>  		dev_info(ice_pf_to_dev(pf), "PF %d changed eswitch mode to switchdev",
>  			 pf->hw.pf_id);
>  		NL_SET_ERR_MSG_MOD(extack, "Changed eswitch mode to switchdev");

Thanks

