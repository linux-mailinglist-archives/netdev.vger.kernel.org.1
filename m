Return-Path: <netdev+bounces-27173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A9977AA08
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 18:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3721A1C20963
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 16:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC1E63DA;
	Sun, 13 Aug 2023 16:30:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D9C944D
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 16:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772E0C433C7;
	Sun, 13 Aug 2023 16:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691944211;
	bh=k/DBSLeuTDT5ffAyIQgS9LkNXlXka5DsrXBly3EUM0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LFQxSkVPvVNMY5UGkTgEyjqDjqrB49JwReYXKnsxLTmIytnyOC5Ivrm5bumPDj79S
	 MrikeE1aFQxDkFQe1kVJ/+07ZhzCDiOkBDfqo/61gIqGiubQiqUP58XpxzbhespKlm
	 B1xHwCRETs+nH4YDTfs45b/adRiPbJNurMxwmYd3xEg8wSHna1y9Yc692MgvWNvXHu
	 bLYi0ygSqCg1UvXQniVEKnWwb7NAouzpXrvq2a3mXgj9u/bHhtTlJCgSWC2n9EbWTi
	 V0h56gbG8V2PxbpIPCwTqh54dOr6O82h487xNMQYbyVbUyWKZFi9ZkMRV+uLJt7OjD
	 +MULKkHfQW09g==
Date: Sun, 13 Aug 2023 18:30:06 +0200
From: Simon Horman <horms@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Krishnanand Prabhu <krishnanand.prabhu@intel.com>,
	Luca Coelho <luciano.coelho@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH net] wifi: iwlwifi: mvm: add dependency for PTP clock
Message-ID: <ZNkFDufqMRYoIAGV@vergenet.net>
References: <20230812052947.22913-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812052947.22913-1-rdunlap@infradead.org>

+ Richard Cochran

On Fri, Aug 11, 2023 at 10:29:47PM -0700, Randy Dunlap wrote:
> When the code to use the PTP HW clock was added, it didn't update
> the Kconfig entry for the PTP dependency, leading to build errors,
> so update the Kconfig entry to depend on PTP_1588_CLOCK_OPTIONAL.
> 
> aarch64-linux-ld: drivers/net/wireless/intel/iwlwifi/mvm/ptp.o: in function `iwl_mvm_ptp_init':
> drivers/net/wireless/intel/iwlwifi/mvm/ptp.c:294: undefined reference to `ptp_clock_register'
> drivers/net/wireless/intel/iwlwifi/mvm/ptp.c:294:(.text+0xce8): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `ptp_clock_register'
> aarch64-linux-ld: drivers/net/wireless/intel/iwlwifi/mvm/ptp.c:301: undefined reference to `ptp_clock_index'
> drivers/net/wireless/intel/iwlwifi/mvm/ptp.c:301:(.text+0xd18): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `ptp_clock_index'
> aarch64-linux-ld: drivers/net/wireless/intel/iwlwifi/mvm/ptp.o: in function `iwl_mvm_ptp_remove':
> drivers/net/wireless/intel/iwlwifi/mvm/ptp.c:315: undefined reference to `ptp_clock_index'
> drivers/net/wireless/intel/iwlwifi/mvm/ptp.c:315:(.text+0xe80): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `ptp_clock_index'
> aarch64-linux-ld: drivers/net/wireless/intel/iwlwifi/mvm/ptp.c:319: undefined reference to `ptp_clock_unregister'
> drivers/net/wireless/intel/iwlwifi/mvm/ptp.c:319:(.text+0xeac): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `ptp_clock_unregister'
> 
> Fixes: 1595ecce1cf3 ("wifi: iwlwifi: mvm: add support for PTP HW clock (PHC)")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/all/202308110447.4QSJHmFH-lkp@intel.com/
> Cc: Krishnanand Prabhu <krishnanand.prabhu@intel.com>
> Cc: Luca Coelho <luciano.coelho@intel.com>
> Cc: Gregory Greenman <gregory.greenman@intel.com>
> Cc: Johannes Berg <johannes.berg@intel.com>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: linux-wireless@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested

> ---
>  drivers/net/wireless/intel/iwlwifi/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff -- a/drivers/net/wireless/intel/iwlwifi/Kconfig b/drivers/net/wireless/intel/iwlwifi/Kconfig
> --- a/drivers/net/wireless/intel/iwlwifi/Kconfig
> +++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
> @@ -66,6 +66,7 @@ config IWLMVM
>  	tristate "Intel Wireless WiFi MVM Firmware support"
>  	select WANT_DEV_COREDUMP
>  	depends on MAC80211
> +	depends on PTP_1588_CLOCK_OPTIONAL
>  	help
>  	  This is the driver that supports the MVM firmware. The list
>  	  of the devices that use this firmware is available here:
> 

