Return-Path: <netdev+bounces-59669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86EA81BADD
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 16:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E064F1C229FD
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 15:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256EE41C7A;
	Thu, 21 Dec 2023 15:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJCPJQpP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB76360B3
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 15:35:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66998C433C8;
	Thu, 21 Dec 2023 15:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703172925;
	bh=MRVxiUU/5WhXcsoURMm4LApVrWo9wUSaDt/JjoevQs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tJCPJQpPNph9pG0BBZn/XdIkiSaFTgkKt/OQTQlWywW92h8xv3o20oUswuydj5Yu1
	 zjur+uQiynr2diojouIXHrNHU/SLwWlf3zYEphwQGqgHFGYh2IREMTxnnFQs34ACQ+
	 xUnBkNB1nWKiCMggrmbAjhVIQsj/qSy/vlYqazcO6HB81JZCAlt7hAQBfJSFAHk72j
	 4KQfGzW4qZqCMH5flhX9V5ky2uTsbZveDVf36vUTNbC2B4yYB+3Ih+Do9oMKNr8nU0
	 8+H6nZ7vHbwGCv8LYuKiaufZgCzZUiGLErxLDArOYGA0+FkMTntvs5/wv3BD0J5XOd
	 NBy4aFLzEBtJw==
Date: Thu, 21 Dec 2023 16:35:19 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v2] i40e: add trace events related to SFP module
 IOCTLs
Message-ID: <20231221153519.GB1056991@kernel.org>
References: <20231220173837.3326983-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231220173837.3326983-1-aleksandr.loktionov@intel.com>

On Wed, Dec 20, 2023 at 06:38:37PM +0100, Aleksandr Loktionov wrote:
> Add trace events related to SFP module IOCTLs for troubleshooting.
> 
> Example:
>         echo "i40e_*" >/sys/kernel/tracing/set_ftrace_filter
>         echo "i40e_ioctl*" >/sys/kernel/tracing/events/i40e/filter
>         echo 1  >/sys/kernel/tracing/tracing_on
>         echo 1  >/sys/kernel/tracing/events/i40e/enable
>         ...
>         cat     /sys/kernel/tracing/trace
> 
> Riewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v1->v2 applied to proper git branch
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  5 +++++
>  drivers/net/ethernet/intel/i40e/i40e_trace.h   | 18 ++++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> index c841779..bdf2b6b 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -1074,6 +1074,7 @@ static int i40e_get_link_ksettings(struct net_device *netdev,
>  	ethtool_link_ksettings_zero_link_mode(ks, supported);
>  	ethtool_link_ksettings_zero_link_mode(ks, advertising);
>  
> +	i40e_trace(ioctl_get_link_ksettings, pf, hw_link_info->link_info);
>  	if (link_up)
>  		i40e_get_settings_link_up(hw, ks, netdev, pf);
>  	else

Hi Aleksandr,

I think that i40e_trace.h needs to be included in i40e_ethtool.c
as part of this patch.

 .../i40e_ethtool.c: In function ‘i40e_get_link_ksettings’:
 .../i40e_ethtool.c:1077:9: error: implicit declaration of function ‘i40e_trace’ [-Werror=implicit-function-declaration]
 1077 |         i40e_trace(ioctl_get_link_ksettings, pf, hw_link_info->link_info);
      |         ^~~~~~~~~~

...

Flagged by gcc-13 W=1 build

...

-- 
pw-bot: changes-requested

