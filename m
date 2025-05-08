Return-Path: <netdev+bounces-189022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6BDAAFEB4
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 17:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736C9A00E27
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 15:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2024627B4E1;
	Thu,  8 May 2025 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LG78GHTG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCA328751F;
	Thu,  8 May 2025 15:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746716829; cv=none; b=nuG/Cr4uyKxLUPFlz4AzHt3FZZt0AKfH8e9ITnrGQ/ZjMAZMRrLuh2c6nIs8nMXjgUbCKQWfws+dBUI/xjY1jfAGKuCRxvz7lc5LBWrvmfo8uY0fCs8jUBAv7v6dxxK+v+/3uXSfLyZxGiOVrnakSLdEE5ov38HL8wVHobNo3dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746716829; c=relaxed/simple;
	bh=gkIDMz5TEBKXM/Y+ME2NrXi07S8weRmBSmKKYT2U8wY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMs2TVwXMtBxUveJMZ4D5BET8Ufu9/v4jzRySlDaGZkxFz+TjISVbd3DAoUCWac2epWvNxDlLORFZKZu6SHwWxGjVUH6Dt5Z/e24FZH/bn2op4srGet8t8rXxYJV0htup7xScn1g3qGPrr6hLv6DlH+AOj/aX82UOLzs0yoBp14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LG78GHTG; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad212f4030aso37738466b.2;
        Thu, 08 May 2025 08:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746716825; x=1747321625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HiVkKNZFxbP0htxLifSGKzwIRCP5A7bJf/YYu6PDh0A=;
        b=LG78GHTGsi+iztqi9znG7zK3umUag0rBgEjgXwj2Nl2QMd/TYPjSXK/xRe9ZY2vtM2
         KEybVLOhbFM9AOo/5EwnxdFzn0rOJ5rZL1n6EI8mjCVfrn14BQ5Q1wYnVI1+Jy69Nr2t
         AAKO7SX2LtdYZ+e9N1eUC++aAwDU1yelSPz4w3i7ebzfxcZ5nJaOMlBg2aES6IgeFMtc
         OcpNPXKp2SWyjebiE2wEQrmPM/RivD8GsoPodQ+oWvYLR1LDeCu9XVyFopqAeGV+2qRA
         yqZhx7ZC3ZIfS5+craxsJP+f+9y/djabA98Kc2UhTxP6eUa5Uy+nvzJ1ugXwHSWF4HxF
         Nelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746716825; x=1747321625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HiVkKNZFxbP0htxLifSGKzwIRCP5A7bJf/YYu6PDh0A=;
        b=WxAWEnEIX3PxNu2S5ukKPkA24lCsNHYalzR1fptuVMg+8OrMLvr7qrZkO568zSTfIm
         6uI44XxQjw045rUkK1Z96u2QHsgE/i2M9sIMANJajsiQy/cHTVOJJ0tgQk0UsMIwsT3m
         M0OSs5lPYubgJsHJDoAHzjdxxrpUXCWzR2GMWEv312tpO3qI8Id3LyHorZhGJm30V/Ds
         gzIfQ+ITQ7cuFmeZcwbHZTUmSORlhgadvSmwxArS12NkwuqxcPCpYusrCRUINVx7UPHx
         jSwqZl+FzC2hu8qsp7EPTAA1ppYe8aCvFxcPKfX/EzPWc19fNKEpYV7ZIjfULnkyP8Iz
         2KTA==
X-Forwarded-Encrypted: i=1; AJvYcCUnwQPv4yru29EJnYDof2KOeWHkw+A3FlTrwpflxlRFE4jT+PWpu2opHH8Io8kV9HZxA4sxkOPs7wE=@vger.kernel.org, AJvYcCXWkcFsQunbeJDzvcYQMos/B/cnPXrDxixfMBjFWKp2TvJ3/QOCSyDyS3xVKQgRZ8sUtl+CIVg9@vger.kernel.org
X-Gm-Message-State: AOJu0Yx343UR4iVG+t4wLA6BiSTLF6OZju/ttvNR2KHtHHgBh38j8xEP
	8uSnnT/uLukpuKZzPKGDAdOrHs3e5xgWb3rHaIADsyYAZymflrkZLIdRnA==
X-Gm-Gg: ASbGncsM6DJxr+hPrSwRteX1Ex/wc/ll2J5sgIUSV1d6Q+LeDMSe5Zt+stUfQY6072W
	dKFCWRcaikv59ApepQMfbjCZ5fokkCzpj/ULxJOD3xFS89ob/URyy86Ud2xzlsZpvs4aLqCyi6a
	rB9rAsAao5cF6Eip7p4GD7ilSeQ4hYO2+BJPxoi71SePGB3247zTaAoekcRxis3wIYh6XxmPhGY
	4Bj6dBmgpQmeQ44Eyifc6Lpgwcnoww2e1rGBDlcZ8F1KxueHXaM1LceUcXIu5L/Bjg/S/7tBege
	uc3pOipmj+5WL7P83GhST6Qqjy6YeHtHXbcYy2t8ulngnNEYLsHHzXqabF+A4JJshReVmLcdAl/
	J6O4lB5XknRq61VetHlADCPWBAT8/
X-Google-Smtp-Source: AGHT+IHdkDjzLYixOJEgs5zQT1V8olt+pRAWuT7ub3y030yXBTkyLYaB47yPJfQGeZ71e21BfUEE2g==
X-Received: by 2002:a05:6402:2809:b0:5fc:348a:e21 with SMTP id 4fb4d7f45d1cf-5fc348a34a1mr2971318a12.31.1746716814421;
        Thu, 08 May 2025 08:06:54 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd2b3be5sm41005585e9.0.2025.05.08.08.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 08:06:54 -0700 (PDT)
Message-ID: <ab7323df-380c-497b-806b-66bfbd7c4af0@gmail.com>
Date: Thu, 8 May 2025 16:06:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 08/22] sfc: initialize dpa
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
 <20250417212926.1343268-9-alejandro.lucero-palau@amd.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20250417212926.1343268-9-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/04/2025 22:29, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use hardcoded values for defining and initializing dpa as there is no
> mbox available.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Acked-by: Edward Cree <ecree.xilinx@gmail.com>

