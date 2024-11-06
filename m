Return-Path: <netdev+bounces-142561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FD89BF9CE
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 00:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB8B1F22633
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 23:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC9D20CCFE;
	Wed,  6 Nov 2024 23:14:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D81020CCF8
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 23:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730934863; cv=none; b=GPq9Ekr2eag4iufEVS7ICyxBMYPYTqDtAAsdqJlNrQufZ6N8sE0y8TzAVJlGauriG13O6I0/DFaw9cDhOOHmLm9VjDhxiIYZFKDeFx7jnJLgdN82/gBtIU3gNqqxi4KSCDNj8wR/+TfArIzohToaCer16aTIwdtIrQOS5g5J7I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730934863; c=relaxed/simple;
	bh=Ya0DjAkCKKvbbd2j7Brb4E7E3+8m7wJOPerH9jM9M34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dTjUhN7iRphOnLvKAKGLxhkY0PDdnTIzZGsJUCXInBHt7pvtq1CNQdWSOwI4fCw5a3Xet77taGRUsmw5U9uHRrWGTBk0p9kyX2BvRxxXKqSEaNq3690xDxrUNImGNeQTsDJCnZgwo6S6V2hpUXcw7l1fdPE5lFU7jK/LmTsyosI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.53] (ip5f5aedfa.dynamic.kabel-deutschland.de [95.90.237.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id F3EAB61E5FE05;
	Thu, 07 Nov 2024 00:13:43 +0100 (CET)
Message-ID: <4ee8f886-40ed-46bc-9d11-1619d64f7875@molgen.mpg.de>
Date: Thu, 7 Nov 2024 00:13:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v3 2/6] igc: Lengthen the
 hardware retry time to prevent timeouts
To: Christopher S M Hall <christopher.s.hall@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, david.zage@intel.com,
 vinicius.gomes@intel.com, netdev@vger.kernel.org,
 rodrigo.cadore@l-acoustics.com, vinschen@redhat.com,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Mor Bar-Gabay <morx.bar.gabay@intel.com>,
 Avigail Dahan <avigailx.dahan@intel.com>
References: <20241106184722.17230-1-christopher.s.hall@intel.com>
 <20241106184722.17230-3-christopher.s.hall@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20241106184722.17230-3-christopher.s.hall@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Christopher,


Thank you for the patch.

I’d use the more specific summary/title below:

igc: Lengthen hardware retry time to 4 μs to prevent timeouts

Am 06.11.24 um 19:47 schrieb Christopher S M Hall:
> Lengthen the hardware retry timer to four microseconds.
> 
> The i225/i226 hardware retries if it receives an inappropriate response
> from the upstream device. If the device retries too quickly, the root
> port does not respond.

Any idea why? Is it documented somewhere?

> The issue can be reproduced with the following:
> 
> $ sudo phc2sys -R 1000 -O 0 -i tsn0 -m
> 
> Note: 1000 Hz (-R 1000) is unrealistically large, but provides a way to
> quickly reproduce the issue.
> 
> PHC2SYS exits with:
> 
> "ioctl PTP_OFFSET_PRECISE: Connection timed out" when the PTM transaction
>    fails

Why four microseconds, and not some other value?

> Fixes: 6b8aa753a9f9 ("igc: Decrease PTM short interval from 10 us to 1 us")
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
> Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
> Signed-off-by: Christopher S M Hall <christopher.s.hall@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_defines.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
> index 2ff292f5f63b..84521a4c35b4 100644
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> @@ -574,7 +574,7 @@
>   #define IGC_PTM_CTRL_SHRT_CYC(usec)	(((usec) & 0x3f) << 2)
>   #define IGC_PTM_CTRL_PTM_TO(usec)	(((usec) & 0xff) << 8)
>   
> -#define IGC_PTM_SHORT_CYC_DEFAULT	1   /* Default short cycle interval */
> +#define IGC_PTM_SHORT_CYC_DEFAULT	4   /* Default short cycle interval */
>   #define IGC_PTM_CYC_TIME_DEFAULT	5   /* Default PTM cycle time */
>   #define IGC_PTM_TIMEOUT_DEFAULT		255 /* Default timeout for PTM errors */


Kind regards,

Paul

