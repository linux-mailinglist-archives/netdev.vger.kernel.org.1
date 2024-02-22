Return-Path: <netdev+bounces-74040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6815485FB87
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 15:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7131F24D31
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 14:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE90E148313;
	Thu, 22 Feb 2024 14:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QXvIVA2V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0025A14691D
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 14:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708613304; cv=none; b=MvRm4+RbkLBldG4t5UL/Rq5fpddtaqoeb6Uoup73BfRLWE0TBvNdX8VjIweYAA2jztE4H9dX2xsOtZpbj9kMZ6sRu9kaNvCUYQZx+r03Zp+/VYG6b/NcFly2I7Rchp1bTchhgLz+h0qKs43a+UVi9Y5Do6mBuE8LWowZ9sOixio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708613304; c=relaxed/simple;
	bh=oTNiQOVa9UPc+CcXKg/4uP4XhIhH0XZw8JWypLjnUrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KdbHhszFT7xtiTit+zwpVNUGVqDrlYEbUkR6eGm6nsl+tq/B4NyyNSAxJuO7IFSN+WXfAi02Og+2LfKxZJyqLzH3YaP/o8wlw9AwodRkxgSwlQYM4swkwqVuUCYRSVvGpP2lEvyrb9z6hTGT9Nz4JhT7lPyVMoP0hPfME5fTAvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QXvIVA2V; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5101cd91017so10363657e87.2
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 06:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708613301; x=1709218101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=peIj76sTqyfZMIrz7VgORO7dcy5u5KgAsi9Knmv8iBM=;
        b=QXvIVA2Vmwewwfw9hfU6jg46jk+xCtAE6LgAIdZWdCQRkxBquR1ZoRpdNC2x6Vfs8x
         lOC9dsb90JgiELVmwcyP0jEcvI1wFRaHLVTMc5w89JWh6ufQu1gaXtPYP95wVQqqfJoh
         vcXnvc/BXlfpLO1c1SVOheXDRgS2ThIuPuXNAd/ogBWQZqEAp0ID/WnET1aJ/eUwhL8b
         I9MVrT/nn2dj2G7CUDwOnIeNjFa//hIy9gLuo58VJnpyzfRYCGB988sS3hf1CupHiCXO
         Cp+aaqymR+eZ+DcOBa1y8sjlGaHFtIGuGORJCz4jRaKr0j/q24DFHOGF/odka+uAjNrM
         2v9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708613301; x=1709218101;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=peIj76sTqyfZMIrz7VgORO7dcy5u5KgAsi9Knmv8iBM=;
        b=gTGd4NfWp2bdRVuhc2gGvHC38fPuOw/iHp/vLbHWeZFfPG7yj3528EWmH3MEy5DPbu
         NYVwarhMaCE+hLMiFQECj7NDNJFMV9+TJfG8lcTCNPUViCEjBi347MzOH6h7WLeB2/Ga
         p6dBpghJFkPBKEZUYUBtUDzkfwudf7eq4+PqjnXtBxv2Ouz7P7GRJp5h6GXJZYqnpU0z
         gi+Ng4WbuM6qYse/RUDcoY3iAVFFoa1FAcPlJGPwYjsi6binJNm4qGg6edw6PA631DzI
         0tEw9Oddtp9GQRzCQj8g6R/MsTdbHV1Wwp5YT/erDtYVtZieJeHMNc9x5IWK6rS3lcw/
         UBTw==
X-Forwarded-Encrypted: i=1; AJvYcCWKjZum6+0PaLuccx8RrO9x9cJuHKkRFHySraF5kSgFUB61E2sh0MmNRx1KXiqRvPGLlQnXN2YDTmg1ZMUDI7cV5GFRnvsi
X-Gm-Message-State: AOJu0Yxsll7S4Qgbvwqk1A7SxRSgzfJxiqj0wPGxUP80nApkjdQd6mzI
	73VCaazz/YFhd9r420o4TydWKpLxmR1NlN9vAlQrrjpqYZwKIhPtP7f3Ep1MP5I=
X-Google-Smtp-Source: AGHT+IHjV4zsu+gepvm6hVV3ZEWYhg3xi0pO8rAfzf0Mj/Hk8VjjKzGsYl5EVyFm+i8ZMKbveXDTJQ==
X-Received: by 2002:a05:6512:3b0b:b0:512:e240:c5af with SMTP id f11-20020a0565123b0b00b00512e240c5afmr463099lfv.1.1708613301172;
        Thu, 22 Feb 2024 06:48:21 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id f19-20020a05600c155300b00411ff030f06sm22717689wmg.9.2024.02.22.06.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 06:48:20 -0800 (PST)
Message-ID: <e9947180-a10e-4359-b015-096506c1e39f@linaro.org>
Date: Thu, 22 Feb 2024 15:48:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] thermal: core: Drop the .set_trip_hyst() thermal
 zone operation
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, netdev@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 linux-wireless@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
References: <6017196.lOV4Wx5bFT@kreacher> <2923201.e9J7NaK4W3@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2923201.e9J7NaK4W3@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/02/2024 19:32, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> None of the users of the thermal core provides a .set_trip_hyst()
> thermal zone operation, so drop that callback from struct
> thermal_zone_device_ops and update trip_point_hyst_store()
> accordingly.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


