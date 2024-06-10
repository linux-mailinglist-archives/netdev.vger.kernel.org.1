Return-Path: <netdev+bounces-102161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7A7901B59
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 08:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99789B20975
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 06:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AB81802E;
	Mon, 10 Jun 2024 06:37:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5855912E48
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 06:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718001451; cv=none; b=TpVddymE6Jzm5T5kSBoo2/h/4ssaSWSwjNfk1BNP+ORjuFZWohgCZ4Ltc21sjsAxw/tB6jVQt36kIMQ9EFixK0Q47ehS9wf4zgj0c50WxxAOdrczE1Ay/LhnBUyYpcvNwAKXtK2toL9D0mboWzK+Bb8gfTUPlM03pkO2l+OZ95U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718001451; c=relaxed/simple;
	bh=b6SJUrHE287S2H528OrXBtViER8v/17sB2tsGOwjTkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TfHU/W+FIttPPV617VxI2SDI5X2mBTJJ9YOa/x2tEnSwK4bg2EGNSeix/nzGlO4RbofkuGqFRwXiIo07+63P1Im+aRX6fTANnHk2zLUDY+gYsXai76pc8tgqNuAt6HrBeCgMYZXJpIV3q8htgBfxUvc3pMtmiZWURPhnar6KJ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af503.dynamic.kabel-deutschland.de [95.90.245.3])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1F6F661E5FE01;
	Mon, 10 Jun 2024 08:36:01 +0200 (CEST)
Message-ID: <6ec4337f-7bf4-442d-8eca-128e528fde2a@molgen.mpg.de>
Date: Mon, 10 Jun 2024 08:36:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [iwl-net][PATCH] Revert "e1000e: move force SMBUS near the end of
 enable_ulp function"
To: Hui Wang <hui.wang@canonical.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, kuba@kernel.org, anthony.l.nguyen@intel.com,
 vitaly.lifshits@intel.com, dima.ruinskiy@intel.com, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, sasha.neftin@intel.com,
 naamax.meir@linux.intel.com
Cc: todd.e.brandt@intel.com, dmummenschanz@web.de, rui.zhang@intel.com,
 jacob.e.keller@intel.com, horms@kernel.org, regressions@lists.linux.dev,
 Naama Meir <naamax.meir@linux.intel.com>
References: <20240610013222.12082-1-hui.wang@canonical.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240610013222.12082-1-hui.wang@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Hui,


Thank you for your patch.


Am 10.06.24 um 03:32 schrieb Hui Wang:
> This reverts commit bfd546a552e140b0a4c8a21527c39d6d21addb28
> 
> Commit bfd546a552e1 ("e1000e: move force SMBUS near the end of
> enable_ulp function") introduces system suspend failure on some
> ethernet cards, at the moment, the pciid of the affected ethernet
> cards include [8086:15b8] and [8086:15bc].
> 
> About the regression the commit bfd546a552e1 ("e1000e: move force

… regression introduced by commit …

> SMBUS near the end of enable_ulp function") tried to fix, looks like
> it is not trivial to fix, we need to find a better way to resolve it.

Please send a revert for commit 861e8086029e (e1000e: move force SMBUS 
from enable ulp function to avoid PHY loss issue), present since Linux 
v6.9-rc3 and not containing enough information in the commit messsage, 
so we have a proper baseline. (That’s also why I originally suggested to 
split it into two commits (revert + your change).)

> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218940
> Reported-by: Dieter Mummenschanz <dmummenschanz@web.de>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218936
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
>   drivers/net/ethernet/intel/e1000e/ich8lan.c | 22 ---------------------
>   drivers/net/ethernet/intel/e1000e/netdev.c  | 18 +++++++++++++++++
>   2 files changed, 18 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> index 2e98a2a0bead..f9e94be36e97 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> @@ -1225,28 +1225,6 @@ s32 e1000_enable_ulp_lpt_lp(struct e1000_hw *hw, bool to_sx)
>   	}
>   
>   release:
> -	/* Switching PHY interface always returns MDI error
> -	 * so disable retry mechanism to avoid wasting time
> -	 */
> -	e1000e_disable_phy_retry(hw);
> -
> -	/* Force SMBus mode in PHY */
> -	ret_val = e1000_read_phy_reg_hv_locked(hw, CV_SMB_CTRL, &phy_reg);
> -	if (ret_val) {
> -		e1000e_enable_phy_retry(hw);
> -		hw->phy.ops.release(hw);
> -		goto out;
> -	}
> -	phy_reg |= CV_SMB_CTRL_FORCE_SMBUS;
> -	e1000_write_phy_reg_hv_locked(hw, CV_SMB_CTRL, phy_reg);
> -
> -	e1000e_enable_phy_retry(hw);
> -
> -	/* Force SMBus mode in MAC */
> -	mac_reg = er32(CTRL_EXT);
> -	mac_reg |= E1000_CTRL_EXT_FORCE_SMBUS;
> -	ew32(CTRL_EXT, mac_reg);
> -
>   	hw->phy.ops.release(hw);
>   out:
>   	if (ret_val)
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index da5c59daf8ba..220d62fca55d 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -6623,6 +6623,7 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool runtime)
>   	struct e1000_hw *hw = &adapter->hw;
>   	u32 ctrl, ctrl_ext, rctl, status, wufc;
>   	int retval = 0;
> +	u16 smb_ctrl;
>   
>   	/* Runtime suspend should only enable wakeup for link changes */
>   	if (runtime)
> @@ -6696,6 +6697,23 @@ static int __e1000_shutdown(struct pci_dev *pdev, bool runtime)
>   			if (retval)
>   				return retval;
>   		}
> +
> +		/* Force SMBUS to allow WOL */
> +		/* Switching PHY interface always returns MDI error
> +		 * so disable retry mechanism to avoid wasting time
> +		 */
> +		e1000e_disable_phy_retry(hw);
> +
> +		e1e_rphy(hw, CV_SMB_CTRL, &smb_ctrl);
> +		smb_ctrl |= CV_SMB_CTRL_FORCE_SMBUS;
> +		e1e_wphy(hw, CV_SMB_CTRL, smb_ctrl);
> +
> +		e1000e_enable_phy_retry(hw);
> +
> +		/* Force SMBus mode in MAC */
> +		ctrl_ext = er32(CTRL_EXT);
> +		ctrl_ext |= E1000_CTRL_EXT_FORCE_SMBUS;
> +		ew32(CTRL_EXT, ctrl_ext);
>   	}
>   
>   	/* Ensure that the appropriate bits are set in LPI_CTRL

Naama also added Tested-by lines two both commits in question. Could 
Intel’s test coverage please extended to the problem at hand?

Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

