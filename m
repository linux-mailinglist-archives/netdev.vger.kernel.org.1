Return-Path: <netdev+bounces-103496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2A890853F
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 09:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC74B1C22F52
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 07:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43081494A1;
	Fri, 14 Jun 2024 07:44:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B598149011
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 07:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718351049; cv=none; b=rj/iJNawtmDUDsouumlqTir1sT4AHM5c9bVq7S0tYxL/iM1saT9AgiUTBTFhyOe3qaR0oGOtQcgrwEWCSApbqnwpv0faibtQcBvrnfvGZuA8oErdm6OVKTEEW8rqJ12AEUlglUxEaSRl+31ctgsFszJ3IfA0ZQV1bMoHIkwPJ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718351049; c=relaxed/simple;
	bh=FhwAo2soTVY5Q/Vf2BMbk4s4pBBjUYLzbSNF24NYRHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LkaVHYM6axp1ownbDFqndySx3lk9RCbxS5vyGC/x9Rj6aUzKuenYCqDF35zEB8qZtLpVxe2SbCYTzC4dNQwV1LfPMY8NLL1rhg7ynPDQKtzPW21E3AJKvSzB8yP4jj3Nk7AJic3O8r4Hm6lqco0zTxrLq8FyU8d5+vIuh/Nso2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af505.dynamic.kabel-deutschland.de [95.90.245.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 738F561E5FE01;
	Fri, 14 Jun 2024 09:43:35 +0200 (CEST)
Message-ID: <178b72a4-0cb6-4e91-ad91-f0d52abef560@molgen.mpg.de>
Date: Fri, 14 Jun 2024 09:43:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v3] i40e: fix hot issue NVM
 content is corrupted after nvmupdate
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, Kelvin Kang <kelvin.kang@intel.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
References: <20240612110402.3356700-1-aleksandr.loktionov@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240612110402.3356700-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Aleksandr,


Am 12.06.24 um 13:04 schrieb Aleksandr Loktionov:
> The bug affects users only at the time when they try to update NVM, and
> only F/W versions that generate errors while nvmupdate. For example X710DA2
> with 0x8000ECB7 F/W is affected, but there are probably more...
> 
> After 230f3d53a547 patch, which should only replace F/W specific error codes
> with Linux kernel generic, all EIO errors started to be converted into EAGAIN
> which leads nvmupdate to retry until it timeouts and sometimes fails after
> more than 20 minutes in the middle of NVM update, so NVM becomes corrupted.
> 
> Remove wrong EIO to EGAIN conversion and pass all errors as is.

I am still not convinced your change is correct with this statement. The 
blamed commit converts the error

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

> Fixes: 230f3d53a547 ("i40e: remove i40e_status")
> Co-developed-by: Kelvin Kang <kelvin.kang@intel.com>
> Signed-off-by: Kelvin Kang <kelvin.kang@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> reproduction:
> ./nvmupdate64

Would be nice to have in the commit message, and also any error messages 
it throws.

> v2->v3 commit messege typos
> v1->v2 commit message update
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

… but you remove the check entirely. Why is that correct?

>   	if (!((u32)aq_rc < (sizeof(aq_to_posix) / sizeof((aq_to_posix)[0]))))
>   		return -ERANGE;
>   


Kind regards,

Paul

