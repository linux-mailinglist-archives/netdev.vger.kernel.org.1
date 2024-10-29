Return-Path: <netdev+bounces-139751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5E49B3FA9
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 02:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3F91C2029A
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 01:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E7E2A1D8;
	Tue, 29 Oct 2024 01:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ttq0HJbJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB94E2260C
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 01:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730164771; cv=none; b=Gon6+dDhAt7H0XzjmK3smzJQacy3+oRWtHjZDSwxCYRGRpFzza6YpEtlafUlEbNHRYzK+z7ZZFTYI4iySxx1YSpikWii1viC6WN1HErKgFn8qAebABIGfKS2r+CFh4C+SDwKKsCAFIt2EeddmyrvfFsNSG1s6OcKtRAIIkxsrVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730164771; c=relaxed/simple;
	bh=q4QfEo2zXCXXhBbukse6z0ugqcEoY6e8TZCDvrIjGIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/rpZ9HPbe/4SKg0yCeUbHSEKTcWVp/x0O+4PG3FI3E4fIhwV5wp7wrLGoj9MzHYBE2uMMd613YNRH4QEfCCS6+ShC+0XxJrjMJWcgnMcDRFigtBBGSezKzK321UEjHCqFN6C5g1xAt1LljoEwJUFqeALBVkvQ2NteZI+VR8Qrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ttq0HJbJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so47243945e9.3
        for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 18:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730164768; x=1730769568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7NqPbYxXVoStVB+VHiCxCoEHhw26j77NLuPqeD7DmUU=;
        b=Ttq0HJbJGEK+Rs9KCE4i4++qOBmUMob2gGvrv0IvnWuuCA5RQC9i4ZodXSUWMtcgr2
         QAioP2I3X4v1tAlQZVJq1Ml52SCwZB1kxiMFlUaMbBcCsOD8wPhmoBh29eefpnCG3jvi
         bQmbOpOiN31FDGcGgN2IcJu/GA2dm/OZrDc0qjmc5v7HAUAJ0hbmZ+2fNhdmR2Q/HG9F
         T0ty1w0DK64RcIAkGT5WzK0c1Vz8W1EU2+YYSzfFu01AXgxkF8wdcU5rS2NohMqOWqzX
         RbAz8d11JDuI2EYLQnhjW+TgRg8nQgpn8FNRlJjVITvLJ94sLJDzHsZK3rCdfXbGSMUp
         OXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730164768; x=1730769568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7NqPbYxXVoStVB+VHiCxCoEHhw26j77NLuPqeD7DmUU=;
        b=UjhUthPNkySxx6QFIJ7FV/BGrI52NaOgtvK9wVdRXz3hqtHoUqZoyQU7Xc14EBAQGM
         PCqxzy3zJIH8coD8fbdrBHwk6eGRroUmuEyRvrvgVwnfgXYELKeDgMydtnsqrOhDAof9
         Jr0VvAvKvVqfn6addQPGqKXCzjgP7f+txbjN8+GKdkwmlcCKO0Ctd0FprHTwpchTtsT/
         RfMGZ3PpQ8XWLK6qDlFqSitmHLtzcUwqDn4X7TfACYwxjABEmUFxRECsw9bL6UcJvLcz
         GoNPVp/b9thfPUVLZQ9H4Q9SE4M4wh96r80NNiWemINR+74Qx1zxYO8ImEZaeDL398jD
         33AQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoQs5vnVXkMPECc6lD2dEP0dXn/wgOkNU3+We1HfuC+byHTIkpwJ5Kerw7UFcw4iRh8yyh2kE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXYUiSMbrQOFM9tmBNkdx+V4kydxB1t+MeTpwOSMRJSzJiX0fk
	M5WzpfhCfg94iRG/nHNAI9K90jXbjHUePnoUega1Jriv3j+ZxrHF
X-Google-Smtp-Source: AGHT+IGh9hDA6CEELzgUa44edYR6yHqgHJb+fWAXCUGYTW3Jt1sdl1iGkGNeWV7z4UjUW1sl8AlI6g==
X-Received: by 2002:a05:600c:350b:b0:431:44fe:fd9a with SMTP id 5b1f17b1804b1-4319acb8a7cmr84141915e9.19.1730164767820;
        Mon, 28 Oct 2024 18:19:27 -0700 (PDT)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b1333bsm10920565f8f.14.2024.10.28.18.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 18:19:27 -0700 (PDT)
Message-ID: <e825de58-c75c-412b-8ec8-f5792f480a51@gmail.com>
Date: Tue, 29 Oct 2024 03:19:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [net] net: wwan: t7xx: Change PM_AUTOSUSPEND_MS to 5000
To: wojackbb@gmail.com, netdev@vger.kernel.org
Cc: chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com,
 ricardo.martinez@linux.intel.com, loic.poulain@linaro.org,
 johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 angelogioacchino.delregno@collabora.com, linux-mediatek@lists.infradead.org,
 matthias.bgg@gmail.com
References: <20241028073015.692794-1-wojackbb@gmail.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20241028073015.692794-1-wojackbb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Jack,

On 28.10.2024 09:30, wojackbb@gmail.com wrote:
> From: Jack Wu <wojackbb@gmail.com>
> 
> Because optimizing the power consumption of t7XX,
> change auto suspend time to 5000.
> 
> The Tests uses a script to loop through the power_state
> of t7XX.
> (for example: /sys/bus/pci/devices/0000\:72\:00.0/power_state)
> 
> * If Auto suspend is 20 seconds,
>    test script show power_state have 0~5% of the time was in D3 state
>    when host don't have data packet transmission.
> 
> * Changed auto suspend time to 5 seconds,
>    test script show power_state have 50%~80% of the time was in D3 state
>    when host don't have data packet transmission.

What negative outcomes of putting the modem into the suspended state? 
Out of curiosity, is the chipset capable to comeback from the suspended 
state on receiving data from a network?

> Signed-off-by: Jack Wu <wojackbb@gmail.com>
> ---
>   drivers/net/wwan/t7xx/t7xx_pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
> index e556e5bd49ab..dcadd615a025 100644
> --- a/drivers/net/wwan/t7xx/t7xx_pci.c
> +++ b/drivers/net/wwan/t7xx/t7xx_pci.c
> @@ -48,7 +48,7 @@
>   #define T7XX_INIT_TIMEOUT		20
>   #define PM_SLEEP_DIS_TIMEOUT_MS		20
>   #define PM_ACK_TIMEOUT_MS		1500
> -#define PM_AUTOSUSPEND_MS		20000
> +#define PM_AUTOSUSPEND_MS		5000
>   #define PM_RESOURCE_POLL_TIMEOUT_US	10000
>   #define PM_RESOURCE_POLL_STEP_US	100
>   


