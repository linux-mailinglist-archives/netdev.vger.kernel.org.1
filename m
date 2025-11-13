Return-Path: <netdev+bounces-238463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 611CBC59269
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 18:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C3AF3A1836
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 17:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60A635A126;
	Thu, 13 Nov 2025 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITGAJ41J"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75DC287245
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 17:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053763; cv=none; b=nOr438yBSVji9cU5Grx9ciccZHLwzwoUWLMYls/jyXgRpCpczVwE0u5leSij8rjMgREWOM9YeghldykE5hauRNr4NF+pJM+ApRObL1wCSPcUlHNyGjf4CJ4ImG4luKEMA/tVtPVkC06v54IdrIeFnbdsTu+pZk8JwZzI7hZ4nr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053763; c=relaxed/simple;
	bh=62vwBOP9yKsaKuZOOstUW2+mwhy4EqYVKW6wWSai3WY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f0rTCarkX1LnNQKIg1kJBN+sUZya2xgWYppJhbvtuMNoKp5bS9liqV5JKkFFddPmxUU2iO3lqvuwa28xIiLZ00qkCKiNsUmUrTgzHZ+qGYSjHxH+CdrLQEn6dLYTFMu9muTnB/zwbOYxrpsztIE2V2jxdFYQUzIw7WCuC3jApJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ITGAJ41J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763053760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l7WJhtLVedGmTm5Wrszczo4emoT5IEM0tAgaV+QfK+0=;
	b=ITGAJ41J5GodiXCtvbPUVSG4mqO5ftGyuRPNxzn5UX2bbf/QHmR0NLS2cSjKiIsvwD7TId
	lVj0lWen33JCVUevPFfrP5+PtcQ18JqwJbSL8Bji7sF82aHwYx/l3dJxhyUHTgWrFgIqRX
	VLuvASuRLj4Mi5qRjW7JzB81dRLCoJw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-g_Qt6dFGNnSiilkrFUvtVA-1; Thu,
 13 Nov 2025 12:09:17 -0500
X-MC-Unique: g_Qt6dFGNnSiilkrFUvtVA-1
X-Mimecast-MFC-AGG-ID: g_Qt6dFGNnSiilkrFUvtVA_1763053755
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 62C7D18002D7;
	Thu, 13 Nov 2025 17:09:15 +0000 (UTC)
Received: from [10.44.32.61] (unknown [10.44.32.61])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D179C180049F;
	Thu, 13 Nov 2025 17:09:10 +0000 (UTC)
Message-ID: <018e3129-e367-4637-8892-7eb83dcae40f@redhat.com>
Date: Thu, 13 Nov 2025 18:09:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dpll: zl3073x: fix kernel-doc name and missing
 parameter in fw.c
To: Kriish Sharma <kriish.sharma2006@gmail.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251112055642.2597450-1-kriish.sharma2006@gmail.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20251112055642.2597450-1-kriish.sharma2006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 11/12/25 6:56 AM, Kriish Sharma wrote:
> Documentation build reported:
> 
>    Warning: drivers/dpll/zl3073x/fw.c:365 function parameter 'comp' not described in 'zl3073x_fw_component_flash'
>    Warning: drivers/dpll/zl3073x/fw.c:365 expecting prototype for zl3073x_flash_bundle_flash(). Prototype was for zl3073x_fw_component_flash() instead
>    Warning: drivers/dpll/zl3073x/fw.c:365 No description found for return value of 'zl3073x_fw_component_flash'
> 
> The kernel-doc comment above `zl3073x_fw_component_flash()` used the wrong
> function name (`zl3073x_flash_bundle_flash`) and omitted the `@comp` parameter.
> This patch updates the comment to correctly document the
> `zl3073x_fw_component_flash()` function and its arguments.
> 
> Fixes: ca017409da69 ("dpll: zl3073x: Add firmware loading functionality")
> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
> ---
> v2:
>   - Added colon to fix kernel-doc warning for `Return:` line.
> 
> v1: https://lore.kernel.org/all/20251110195030.2248235-1-kriish.sharma2006@gmail.com
> 
>   drivers/dpll/zl3073x/fw.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dpll/zl3073x/fw.c b/drivers/dpll/zl3073x/fw.c
> index def37fe8d9b0..55b638247f4b 100644
> --- a/drivers/dpll/zl3073x/fw.c
> +++ b/drivers/dpll/zl3073x/fw.c
> @@ -352,12 +352,12 @@ struct zl3073x_fw *zl3073x_fw_load(struct zl3073x_dev *zldev, const char *data,
>   }
>   
>   /**
> - * zl3073x_flash_bundle_flash - Flash all components
> + * zl3073x_fw_component_flash - Flash all components
>    * @zldev: zl3073x device structure
> - * @components: pointer to components array
> + * @comp: pointer to components array
>    * @extack: netlink extack pointer to report errors
>    *
> - * Returns 0 in case of success or negative number otherwise.
> + * Return: 0 in case of success or negative number otherwise.
>    */

Reviewed-by: Ivan Vecera <ivecera@redhat.com>


