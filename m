Return-Path: <netdev+bounces-214055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 167A3B27FBB
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 14:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE7A14E236D
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 12:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B822130101C;
	Fri, 15 Aug 2025 12:08:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E698301019
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 12:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755259700; cv=none; b=UG2Qa8BSHyjhNrkXt+0kxz6H5ANpZrtWVYuhExy8/JASybKD8JKt4b/HDusUAB3yCkRNnQ6GsvD26IOAHHzB6Ppo9ghJpucYsio6YPvSVZM8hMT2lQsSgB12X6ccH/SeAHxuwem1JYLw96dO9aZnT3TaXmHvfFK2GAofibBXRj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755259700; c=relaxed/simple;
	bh=54bZJzJnN+26/yu0hEcpZWO4aC2JKl10r8YE8+rF7ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=sdP7S15wAtiwM4zcC09UwqSLtIPeJ54pqI7zYP7hvPwnYzZs5vu4xdlmFIitsgyCgZrddzn4oALVOG2/qWr20YR3K4rCGuIdd0poqaOdXhHAMrvc5EAdFe+j1XikMybUlQMxthV18B1UWWXm1D1sulP/0vSxa6rqMyt2uxkzIYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.184] (ip5f5af516.dynamic.kabel-deutschland.de [95.90.245.22])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id A86E261E647AC;
	Fri, 15 Aug 2025 14:07:52 +0200 (CEST)
Message-ID: <f9ef51d9-9a55-40f0-8073-dad5eab741f9@molgen.mpg.de>
Date: Fri, 15 Aug 2025 14:07:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] i40e: fix Jumbo Frame support
 after iPXE boot
To: Jacob Keller <jacob.e.keller@intel.com>
References: <20250814-jk-fix-i40e-ice-pxe-9k-mtu-v1-1-c3926287fb78@intel.com>
Content-Language: en-US
Cc: kheib@redhat.com, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Anthony Nguyen <anthony.l.nguyen@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250814-jk-fix-i40e-ice-pxe-9k-mtu-v1-1-c3926287fb78@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Jacob,


Thank you for your patch.

Am 14.08.25 um 23:21 schrieb Jacob Keller:
> The i40e hardware has multiple hardware settings which define the maximum
> frame size of the physical port. The firmware has an AdminQ command
> (0x0603) to configure all of these settings, but the i40e Linux driver
> never issues this command.
> 
> In most cases this is no problem, as the NVM default value is to set it to
> its maximum value of 9728. Unfortunately, since recent versions the intelxl
> driver maintained within the iPXE network boot stack now issues the 0x0603
> command to set the maximum frame size to a low value. This appears to have

Maybe add (MFS) so the abbreviation is clear.

> occurred because the same intelxl driver is used for both the E700 and E800
> series hardware, and both devices support the same 0x0603 AdminQ command.

Do you have a link to the intelxl change?

> The ice Linux PF driver already issues this command during probe.
> 
> Since commit 3a2c6ced90e1 ("i40e: Add a check to see if MFS is set"), the
> driver does check the I40E_PRTGL_SAH register, but it only logs a warning.

… if MFS is set lower than the default.

> This register also only covers received packets and not transmitted
> packets. Additionally, a warning does not help users, as the larger MTU is
> still not supported.
> 
> Instead, have the i40e driver issue the Set MAC Config AdminQ command
> during boot in a similar fashion to the ice driver. Additionally, instead
> of just checking I40E_PRTGL_SAH, read and update its Max Frame Size field
> to the expected 9K value as well.
> 
> This ensures the driver restores the maximum frame size to its expected
> value at probe, rather than assuming that no other driver has adjusted the
> MAC config.
> 
> This is a better user experience, as we now fix the issues with larger MTU
> instead of merely warning. It also aligns with the way the ice E800 series
> driver works.

Is there a regression potential, that users won’t be able to access 
their systems over the network, because there are faulty switches or such?

To save people search for it, how can the MFS be read out from the 
command line?

> Fixes: 3a2c6ced90e1 ("i40e: Add a check to see if MFS is set")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> Strictly speaking, the "Fixes" tag isn't entirely accurate. The failure is
> really the result of changes in the iPXE driver to support both E700 and E800
> within the same intelxl driver. However, I think the warning added by that
> commit was an insufficient solution and we should be restoring the value to
> its expected default rather than merely issuing a warning to the kernel
> log. Thus, this "fixes" the driver to better handle this case.
> ---
>   drivers/net/ethernet/intel/i40e/i40e_prototype.h |  2 ++
>   drivers/net/ethernet/intel/i40e/i40e_common.c    | 30 ++++++++++++++++++++++++
>   drivers/net/ethernet/intel/i40e/i40e_main.c      | 17 +++++++++-----
>   3 files changed, 43 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
> index aef5de53ce3b..26bb7bffe361 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
> @@ -98,6 +98,8 @@ int i40e_aq_set_mac_loopback(struct i40e_hw *hw,
>   			     struct i40e_asq_cmd_details *cmd_details);
>   int i40e_aq_set_phy_int_mask(struct i40e_hw *hw, u16 mask,
>   			     struct i40e_asq_cmd_details *cmd_details);
> +int i40e_aq_set_mac_config(struct i40e_hw *hw, u16 max_frame_size,
> +			   struct i40e_asq_cmd_details *cmd_details);
>   int i40e_aq_clear_pxe_mode(struct i40e_hw *hw,
>   			   struct i40e_asq_cmd_details *cmd_details);
>   int i40e_aq_set_link_restart_an(struct i40e_hw *hw,
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
> index 270e7e8cf9cf..f6b6a4925b27 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_common.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
> @@ -1189,6 +1189,36 @@ int i40e_set_fc(struct i40e_hw *hw, u8 *aq_failures,
>   	return status;
>   }
>   
> +/**
> + * i40e_aq_set_mac_config
> + * @hw: pointer to the hw struct
> + * @max_frame_size: Maximum Frame Size to be supported by the port

Mention that it needs to be positive (or non-0)?

> + * @cmd_details: pointer to command details structure or NULL
> + *
> + * Configure MAC settings for frame size (0x0603).
> + *
> + * Return: 0 on success, or a negative error code on failure.
> + **/
> +int i40e_aq_set_mac_config(struct i40e_hw *hw, u16 max_frame_size,
> +			   struct i40e_asq_cmd_details *cmd_details)
> +{
> +	struct i40e_aq_set_mac_config *cmd;
> +	struct libie_aq_desc desc;
> +
> +	if (max_frame_size == 0)
> +		return -EINVAL;
> +
> +	i40e_fill_default_direct_cmd_desc(&desc, i40e_aqc_opc_set_mac_config);
> +
> +	cmd->max_frame_size = cpu_to_le16(max_frame_size);
> +
> +#define I40E_AQ_SET_MAC_CONFIG_FC_DEFAULT_THRESHOLD	0x7FFF
> +	cmd->fc_refresh_threshold =
> +		cpu_to_le16(I40E_AQ_SET_MAC_CONFIG_FC_DEFAULT_THRESHOLD);
> +
> +	return i40e_asq_send_command(hw, &desc, NULL, 0, cmd_details);
> +}
> +
>   /**
>    * i40e_aq_clear_pxe_mode
>    * @hw: pointer to the hw struct
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index b83f823e4917..4796fdd0b966 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -16045,13 +16045,18 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   		dev_dbg(&pf->pdev->dev, "get supported phy types ret =  %pe last_status =  %s\n",
>   			ERR_PTR(err), libie_aq_str(pf->hw.aq.asq_last_status));
>   
> -	/* make sure the MFS hasn't been set lower than the default */
>   #define MAX_FRAME_SIZE_DEFAULT 0x2600
> -	val = FIELD_GET(I40E_PRTGL_SAH_MFS_MASK,
> -			rd32(&pf->hw, I40E_PRTGL_SAH));
> -	if (val < MAX_FRAME_SIZE_DEFAULT)
> -		dev_warn(&pdev->dev, "MFS for port %x (%d) has been set below the default (%d)\n",
> -			 pf->hw.port, val, MAX_FRAME_SIZE_DEFAULT);
> +
> +	err = i40e_aq_set_mac_config(hw, MAX_FRAME_SIZE_DEFAULT, NULL);
> +	if (err) {
> +		dev_warn(&pdev->dev, "set mac config ret =  %pe last_status =  %s\n",
> +			 ERR_PTR(err), libie_aq_str(pf->hw.aq.asq_last_status));
> +	}
> +
> +	/* Make sure the MFS is set to the expected value */
> +	val = rd32(hw, I40E_PRTGL_SAH);
> +	FIELD_MODIFY(I40E_PRTGL_SAH_MFS_MASK, &val, MAX_FRAME_SIZE_DEFAULT);
> +	wr32(hw, I40E_PRTGL_SAH, val);
>   
>   	/* Add a filter to drop all Flow control frames from any VSI from being
>   	 * transmitted. By doing so we stop a malicious VF from sending out
The diff looks good:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

