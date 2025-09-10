Return-Path: <netdev+bounces-221673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2060DB5184C
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 15:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EE171BC0EF7
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 13:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE1C212578;
	Wed, 10 Sep 2025 13:51:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6093F31D382
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512298; cv=none; b=a/z4kLVJHISa5BAL+PSrLkdOVot44wa+XovvrBqmTU/dMOn62LKwpZaKDGmZNsCQwTJn73oahTEO/8j3rhDux5hapBKnEnotAuvrm1qERLBNINUgYy4AN+PWcgyh8qwmsLfPG5Na+ppjQ28MOjczg48xtTPIanTbMHJA8R9mTHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512298; c=relaxed/simple;
	bh=JRi/9Q8PE5ujQHXV5wCsGiZzCx0IdffGhZDc/DTGW3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VZSinWEy1n+ojyHWjp4C1gSRoBiSmQbnm4K3rBbmPNIPZbEPizWQQWrVntMK8y9yrv7IAOytA2kh4iJpWAj64VkIe75Lxm5sm7Hbf1Na3WVkMA1L2RFWgATJ8Gk+YOTjtCpk8pYen8sFob4Kqzu1JlCc4t9WmLJiBDw2/k4mmss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.205] (p5dc55aad.dip0.t-ipconnect.de [93.197.90.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 957A761E64852;
	Wed, 10 Sep 2025 15:50:34 +0200 (CEST)
Message-ID: <5d0627e4-4289-486b-80bb-a6cdc085e149@molgen.mpg.de>
Date: Wed, 10 Sep 2025 15:50:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v2 iwl-net] igc: don't fail igc_probe()
 on LED setup error
To: Kohei Enju <enjuk@amazon.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Kurt Kanzenbach <kurt@linutronix.de>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Vitaly Lifshits <vitaly.lifshits@intel.com>, kohei.enju@gmail.com
References: <20250910134745.17124-1-enjuk@amazon.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250910134745.17124-1-enjuk@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Kohei,


Thank you for your patch.

Am 10.09.25 um 15:47 schrieb Kohei Enju:
> When igc_led_setup() fails, igc_probe() fails and triggers kernel panic
> in free_netdev() since unregister_netdev() is not called. [1]
> This behavior can be tested using fault-injection framework, especially
> the failslab feature. [2]
> 
> Since LED support is not mandatory, treat LED setup failures as
> non-fatal and continue probe with a warning message, consequently
> avoiding the kernel panic.
> 
> [1]
>   kernel BUG at net/core/dev.c:12047!
>   Oops: invalid opcode: 0000 [#1] SMP NOPTI
>   CPU: 0 UID: 0 PID: 937 Comm: repro-igc-led-e Not tainted 6.17.0-rc4-enjuk-tnguy-00865-gc4940196ab02 #64 PREEMPT(voluntary)
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>   RIP: 0010:free_netdev+0x278/0x2b0
>   [...]
>   Call Trace:
>    <TASK>
>    igc_probe+0x370/0x910
>    local_pci_probe+0x3a/0x80
>    pci_device_probe+0xd1/0x200
>   [...]
> 
> [2]
>   #!/bin/bash -ex
> 
>   FAILSLAB_PATH=/sys/kernel/debug/failslab/
>   DEVICE=0000:00:05.0
>   START_ADDR=$(grep " igc_led_setup" /proc/kallsyms \
>           | awk '{printf("0x%s", $1)}')
>   END_ADDR=$(printf "0x%x" $((START_ADDR + 0x100)))
> 
>   echo $START_ADDR > $FAILSLAB_PATH/require-start
>   echo $END_ADDR > $FAILSLAB_PATH/require-end
>   echo 1 > $FAILSLAB_PATH/times
>   echo 100 > $FAILSLAB_PATH/probability
>   echo N > $FAILSLAB_PATH/ignore-gfp-wait
> 
>   echo $DEVICE > /sys/bus/pci/drivers/igc/bind

Sweet!

> Fixes: ea578703b03d ("igc: Add support for LEDs on i225/i226")
> Signed-off-by: Kohei Enju <enjuk@amazon.com>
> ---
> Changes:
>    v1->v2:
>      - don't fail probe when led setup fails
>      - rephrase subject and commit message
>    v1: https://lore.kernel.org/intel-wired-lan/20250906055239.29396-1-enjuk@amazon.com/
> ---
>   drivers/net/ethernet/intel/igc/igc.h      |  1 +
>   drivers/net/ethernet/intel/igc/igc_main.c | 12 +++++++++---
>   2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index 266bfcf2a28f..a427f05814c1 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -345,6 +345,7 @@ struct igc_adapter {
>   	/* LEDs */
>   	struct mutex led_mutex;
>   	struct igc_led_classdev *leds;
> +	bool leds_available;
>   };
>   
>   void igc_up(struct igc_adapter *adapter);
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index e79b14d50b24..728d7ca5338b 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -7335,8 +7335,14 @@ static int igc_probe(struct pci_dev *pdev,
>   
>   	if (IS_ENABLED(CONFIG_IGC_LEDS)) {
>   		err = igc_led_setup(adapter);
> -		if (err)
> -			goto err_register;
> +		if (err) {
> +			netdev_warn_once(netdev,
> +					 "LED init failed (%d); continuing without LED support\n",
> +					 err);
> +			adapter->leds_available = false;
> +		} else {
> +			adapter->leds_available = true;
> +		}
>   	}
>   
>   	return 0;
> @@ -7392,7 +7398,7 @@ static void igc_remove(struct pci_dev *pdev)
>   	cancel_work_sync(&adapter->watchdog_task);
>   	hrtimer_cancel(&adapter->hrtimer);
>   
> -	if (IS_ENABLED(CONFIG_IGC_LEDS))
> +	if (IS_ENABLED(CONFIG_IGC_LEDS) && adapter->leds_available)
>   		igc_led_free(adapter);
>   
>   	/* Release control of h/w to f/w.  If f/w is AMT enabled, this

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

