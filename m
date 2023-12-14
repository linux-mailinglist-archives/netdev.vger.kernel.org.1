Return-Path: <netdev+bounces-57494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C59788132E5
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 15:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040D51C210D0
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9F759E43;
	Thu, 14 Dec 2023 14:20:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFB69A
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 06:20:28 -0800 (PST)
Received: from [141.14.220.40] (g40.guest.molgen.mpg.de [141.14.220.40])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 35D8661E5FE04;
	Thu, 14 Dec 2023 15:20:07 +0100 (CET)
Message-ID: <ed0ebf46-1c24-45d1-a841-7733a3b70966@molgen.mpg.de>
Date: Thu, 14 Dec 2023 15:20:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] i40e: add trace events related
 to SFP module IOCTLs
Content-Language: en-US
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20231214141012.224894-1-aleksandr.loktionov@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20231214141012.224894-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Aleksandr,


Thank you for your patch.


Am 14.12.23 um 15:10 schrieb Aleksandr Loktionov:
> Add trace events related to SFP module IOCTLs for troubleshooting.

Maybe list the three events? Maybe even a usage example.

> Riewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Reviewed

> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>   src/CORE/i40e_ethtool.c |  5 +++++
>   src/CORE/i40e_trace.h   | 18 ++++++++++++++++++
>   2 files changed, 23 insertions(+)
> 
> diff --git a/src/CORE/i40e_ethtool.c b/src/CORE/i40e_ethtool.c
> index 0838566..e9d9d4b 100644
> --- a/src/CORE/i40e_ethtool.c
> +++ b/src/CORE/i40e_ethtool.c
> @@ -1057,6 +1057,7 @@ static int i40e_get_link_ksettings(struct net_device *netdev,
>   	ethtool_link_ksettings_zero_link_mode(ks, supported);
>   	ethtool_link_ksettings_zero_link_mode(ks, advertising);
>   
> +	i40e_trace(ioctl_get_link_ksettings, pf, hw_link_info->link_info);
>   	if (link_up)
>   		i40e_get_settings_link_up(hw, ks, netdev, pf);
>   	else
> @@ -7219,9 +7220,12 @@ static int i40e_get_module_info(struct net_device *netdev,
>   		modinfo->eeprom_len = I40E_MODULE_QSFP_MAX_LEN;
>   		break;
>   	default:
> +		i40e_trace(ioctl_get_module_info, pf, ~0UL);
>   		netdev_dbg(vsi->netdev, "SFP module type unrecognized or no SFP connector used.\n");

Is it useful, if there is a debug print already?


Kind regards,

Paul


>   		return -EOPNOTSUPP;
>   	}
> +	i40e_trace(ioctl_get_module_info, pf, (((u64)modinfo->type) << 32) |
> +		   modinfo->eeprom_len);
>   	return 0;
>   }
>   
> @@ -7244,6 +7248,7 @@ static int i40e_get_module_eeprom(struct net_device *netdev,
>   	u32 value = 0;
>   	int i;
>   
> +	i40e_trace(ioctl_get_module_eeprom, pf, ee ? ee->len : 0U);
>   	if (!ee || !ee->len || !data)
>   		return -EINVAL;
>   
> diff --git a/src/CORE/i40e_trace.h b/src/CORE/i40e_trace.h
> index cac0f7c..f54fc36 100644
> --- a/src/CORE/i40e_trace.h
> +++ b/src/CORE/i40e_trace.h
> @@ -428,6 +428,24 @@ DEFINE_EVENT(
>   
>   	TP_ARGS(pf, val));
>   
> +DEFINE_EVENT(
> +	i40e_ioctl_template, i40e_ioctl_get_module_info,
> +	TP_PROTO(struct i40e_pf *pf, u64 val),
> +
> +	TP_ARGS(pf, val));
> +
> +DEFINE_EVENT(
> +	i40e_ioctl_template, i40e_ioctl_get_module_eeprom,
> +	TP_PROTO(struct i40e_pf *pf, u64 val),
> +
> +	TP_ARGS(pf, val));
> +
> +DEFINE_EVENT(
> +	i40e_ioctl_template, i40e_ioctl_get_link_ksettings,
> +	TP_PROTO(struct i40e_pf *pf, u64 val),
> +
> +	TP_ARGS(pf, val));
> +
>   DECLARE_EVENT_CLASS(
>   	i40e_nvmupd_template,

