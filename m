Return-Path: <netdev+bounces-67475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22114843A01
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 10:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C552D1F2EC6C
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 09:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA85979DA0;
	Wed, 31 Jan 2024 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="f9LxpZ/6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B0383CA7
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 08:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691100; cv=none; b=PpFv+yixdOcuWL7GkCMPQ3SCZfSB6VuYHIqUE36eMQkkQTBw4NNEGh6pUdJpwJU0Kzp9SPCo66aGZWzmzjFyBceVnI7v6W0VfTCQin5mVxmo+W73BC+ZnYEP+CAyiEcbRRFAvFYBvlrfVkYPT7vY5zI+UyxgVbXSJAOFzwFGzaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691100; c=relaxed/simple;
	bh=+HZnsn1/MkCaoivr01gvsJ7BfEnFkoml1HUOCcIsbLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5v7bodfiE7G1nxYsqjYAgHuPnfWiDOLvmKeKkWkON3SuD7OA/Q1wskBu1DaL1l/W5gJvzVqWDdk/eRk7kA4TYtEbC3g2P9q2Z4cob9dtAmgv8ILPQG6EYx0ZfKlLqe0GqXSiZE4QJMwE6EnCInDyji/+NZW9x0JFn44RglbdPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=f9LxpZ/6; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e913e3f03so52053135e9.3
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 00:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706691096; x=1707295896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ijq5orVogbjLbCPMiy9gjbAaVLRNrLxAzjMkC5Y9Gg=;
        b=f9LxpZ/6Cw/H2OYLYDCSNG+VZbb1Qzj7yJ4ScSzfdwFhxZlj7XeHgsu9mT1nv1k/Mi
         Nt6+aYlx7PKLPBKPT5Z4N8Yd7IIwluITHXwHOuylBD+afHbfDZHNBN4JmbbV7F0WLvS3
         V4PbqCgEDOAYbnWwdRqzApveCeypl8sDM083VRjJXThP0ZSDqlpI3qPgLYBdd6vbYQjF
         LdODmR3KVoFg8lXU+zLR/BKO2TDIxE/vSqanDMLOlacWJ29g1z+XI3VGthd0qdTsWVvi
         AhEWH/xTpR/7W8TqwuG9Qzb/QWO6CrEuWigb8BM8u716fyuw02+AypaXed8HRl992xKa
         Ac1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706691096; x=1707295896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ijq5orVogbjLbCPMiy9gjbAaVLRNrLxAzjMkC5Y9Gg=;
        b=wo5q37jcslV7PHuUf5InvpMIS6TSi+ignG0+Z8qwHNxdqL3IiKMKN2Gz2CTqidSPTG
         dLWUY/8ekSDOlIY6yPlaXR/wR1mXE9+APjf02RzONKM7FGFJz6DM6Zz++wpczuaBukYA
         XXwQZjrO9d9eCJJXgqcctZRxLJelB2zCgUKjDA6xOalhMNlnsUQ+5XguXcV45FtivpKI
         K1Rw3ptzopL1BYwY3npyXzhr9w/b0xz9PexnuDqOphMTJd/N/wAEMBhp1LuNS1smORu+
         iUuChKlotVPSZyeG931W79lxrN9W2UsQRdou8MhJgnEKvg1LLnl1sB/M6FDthRt1kX/Y
         xDeg==
X-Gm-Message-State: AOJu0YxCsVT7uf5tLHU4fJbjO+9QCquBaURYOfprx0gIVixsgaWpUo1f
	xTnlrirRIJIcxgAZxx9kVSekZpZ7Urse1lIwK7iGrVxzKPE+arWh6SgR5H2G/UI=
X-Google-Smtp-Source: AGHT+IGB/JJLPoGalsVoZQA5VW7ARvBaMUWAVbeNxirMG8Zha76RplcSJLHJv6lRbyuJXpHgbV8QVA==
X-Received: by 2002:a05:6000:4023:b0:33a:ee10:cb87 with SMTP id cp35-20020a056000402300b0033aee10cb87mr766803wrb.53.1706691095699;
        Wed, 31 Jan 2024 00:51:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWWCTvegTyw3kDlC6LtinaPnjKLO+34Dg15YE6+6hFsmVWDlR3RCaq8SLXukEse6/8xNCkm6VYSTj3ij0ZmsR8cu3W9J7kcyKohrP+3GMrv7DiCc+FRPtg116BWcle+X6wwu+KCOqy3r9FWnuEvyYSFxkBNIUFGNH4W1ukzcOWhmBIzN8C0H78ercsCC663LfaogGmNXYPG1PqC1DQuXCRV7VsNy5PRko744ohnIb0=
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ch19-20020a5d5d13000000b00337b47ae539sm12874558wrb.42.2024.01.31.00.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 00:51:35 -0800 (PST)
Date: Wed, 31 Jan 2024 09:51:32 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com,
	arkadiusz.kubalewski@intel.com
Subject: Re: [patch net-next] dpll: move xa_erase() call in to match
 dpll_pin_alloc() error path order
Message-ID: <ZboKFGaHNnDeHWVi@nanopsycho>
References: <20240130155814.268622-1-jiri@resnulli.us>
 <c5e27a8a-739e-4b7d-a189-46b9c30361c8@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5e27a8a-739e-4b7d-a189-46b9c30361c8@linux.dev>

Tue, Jan 30, 2024 at 10:14:49PM CET, vadim.fedorenko@linux.dev wrote:
>On 30/01/2024 15:58, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> This is cosmetics. Move the call of xa_erase() in dpll_pin_put()
>> so the order of cleanup calls matches the error path of
>> dpll_pin_alloc().
>
>Jiri, remind me please, why do we clean up xarray in error path in the
>same order we allocate them?

Yeah, that calls for another cosmetics patch :) Feel free to send it.

>
>The patch looks good,
>
>Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>   drivers/dpll/dpll_core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
>> index 5152bd1b0daf..61e5c607a72f 100644
>> --- a/drivers/dpll/dpll_core.c
>> +++ b/drivers/dpll/dpll_core.c
>> @@ -560,9 +560,9 @@ void dpll_pin_put(struct dpll_pin *pin)
>>   {
>>   	mutex_lock(&dpll_lock);
>>   	if (refcount_dec_and_test(&pin->refcount)) {
>> +		xa_erase(&dpll_pin_xa, pin->id);
>>   		xa_destroy(&pin->dpll_refs);
>>   		xa_destroy(&pin->parent_refs);
>> -		xa_erase(&dpll_pin_xa, pin->id);
>>   		dpll_pin_prop_free(&pin->prop);
>>   		kfree(pin);
>>   	}
>

