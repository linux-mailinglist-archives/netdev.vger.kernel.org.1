Return-Path: <netdev+bounces-102206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA88B901E8E
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 11:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF5C283ABD
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 09:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6E442AA1;
	Mon, 10 Jun 2024 09:45:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5728C1DA4C
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 09:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718012750; cv=none; b=ILU8CVr52DIxDm1tQO8ZgpHB4dm9tlLI0jwRn1GOvb8Aav6raSpcf+TJpQVU9v3qiQXbNW3ygJCRdlIDuP/XePGW8rCgB2i3CdUh0ko427jniorH3K0wm0U9mZRVVRCBWDhg92ivQ02xi1tkTLqlyfv2PbGn7Ss+BnReyuWh3jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718012750; c=relaxed/simple;
	bh=tE0urKDo1iCeCScMovRS4kWxooEg5E+Xm6Hbn/awP9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jiCKYAJ62rOELuuK9jvXvoJIPVyl2ehdJAZu7KZ0lRHm4Z6IVkglriU9nZl4IB5IGBKkDs2VOxa1f62rR0A8lY8hnAGEBpEo9TjHbrVsa2YCWmRbze04tcVeBYmQ8VfQP/a1COmBizbNQHfOOYMKA2fkwEZrBnOioQu36kz+tic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id B7BBC61E5FE01;
	Mon, 10 Jun 2024 11:45:17 +0200 (CEST)
Message-ID: <a2ad5189-10d1-4e6b-8509-b1ce4e1e7526@molgen.mpg.de>
Date: Mon, 10 Jun 2024 11:45:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] i40e: fix hot issue NVM content
 is corrupted after nvmupdate
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Kelvin Kang <kelvin.kang@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, Jan Sokolowski <jan.sokolowski@intel.com>,
 Leon Romanovsky <leonro@nvidia.com>
References: <20240610092051.2030587-1-aleksandr.loktionov@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240610092051.2030587-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Aleksandr, dear Kelvin,


Thank you for your patch.


Am 10.06.24 um 11:20 schrieb Aleksandr Loktionov:
> After 230f3d53a547 patch all I/O errors are being converted into EAGAIN
> which leads to retries until timeout so nvmupdate sometimes fails after
> more than 20 minutes!
> 
> Remove misleading EIO to EGAIN conversion and pass all errors as is.
> 
> Fixes: 230f3d53a547 ("i40e: remove i40e_status")

This commit is present since v6.6-rc1, released September last year 
(2023). So until now, nobody noticed this?

> Co-developed-by: Kelvin Kang <kelvin.kang@intel.com>
> Signed-off-by: Kelvin Kang <kelvin.kang@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Please give more details about your test setup. For me it’s also not 
clear, how the NVM content gets corrupted as stated in the 
summary/title. Could you please elaborate that in the commit message.

> ---
>   drivers/net/ethernet/intel/i40e/i40e_adminq.h | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.h b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
> index ee86d2c..55b5bb8 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_adminq.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
> @@ -109,10 +109,6 @@ static inline int i40e_aq_rc_to_posix(int aq_ret, int aq_rc)
>   		-EFBIG,      /* I40E_AQ_RC_EFBIG */
>   	};
>   
> -	/* aq_rc is invalid if AQ timed out */
> -	if (aq_ret == -EIO)
> -		return -EAGAIN;
> -
>   	if (!((u32)aq_rc < (sizeof(aq_to_posix) / sizeof((aq_to_posix)[0]))))
>   		return -ERANGE;

The referenced commit 230f3d53a547 does:

```
diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.h 
b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
index ee394aacef4d..267f2e0a21ce 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
@@ -5,7 +5,6 @@
  #define _I40E_ADMINQ_H_

  #include "i40e_osdep.h"
-#include "i40e_status.h"
  #include "i40e_adminq_cmd.h"

  #define I40E_ADMINQ_DESC(R, i)   \
@@ -117,7 +116,7 @@ static inline int i40e_aq_rc_to_posix(int aq_ret, 
int aq_rc)
         };

         /* aq_rc is invalid if AQ timed out */
-       if (aq_ret == I40E_ERR_ADMIN_QUEUE_TIMEOUT)
+       if (aq_ret == -EIO)
                 return -EAGAIN;

         if (!((u32)aq_rc < (sizeof(aq_to_posix) / 
sizeof((aq_to_posix)[0]))))
```

So I do not see yet, why removing the whole hunk is the solution.


Kind regards,

Paul

