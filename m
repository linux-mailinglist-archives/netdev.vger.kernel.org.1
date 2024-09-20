Return-Path: <netdev+bounces-129075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F46597D5AE
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 14:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9998B237F5
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 12:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CA714D280;
	Fri, 20 Sep 2024 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dUksR6TR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E1F6D1B9
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726836359; cv=none; b=lceIu3KPTY9u9n4gzjxrQf8mmg9VoGHCPs/xpFME1t9HoCRKxhfAyn+csphrGBCQZmLQcjRSp/RQJKGkWMaQbXdD55G+dOL/DFgp6budQD9D4Nf5rDJTxZLZ7fiujyWNk7Ne1zxLAaMHhXDffiP5YtSemFs+r0xVxJ8TZZ5BeHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726836359; c=relaxed/simple;
	bh=R2gOVpiCbjfuz7Dp6+3JCDij+4BOOZYtAqhxOPfH/Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDSh65MbOUZNLTzEyicMDQcy02JmGntZwIKXtCXLkvnQU0r7IEnROZ9fukkIUAIQ5HePAzm3LqiEL0AQJ2xJPMJhPa2XM0b4fh9YYUtGHO6DfbkycLZDfDfcvoPTgavWwpsNKYiQhjUqgButAMjvRUsw+lfQ8caSj/1ZQPbtmBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dUksR6TR; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d6d0fe021so283402066b.1
        for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 05:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726836356; x=1727441156; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YwTiYmEfOd8mBE/Nzbj2VSocNy/QK2H3gkxcThcAQRM=;
        b=dUksR6TRefLSjaJ9dpTFFP1dM46+jtOCC5HSb26OecJMUEYu4Kuht10SoqnqJJjggd
         0rgC45iPaicLTG0pjHI6vU7n35gfAJ60kocGEwIyyVdY5RQlNrRem+Ub/fSOc79bGhg6
         AYAA6rN1GX1p/es4iol4DB1vFxqznVPKHvvy//YVZKj+IfvwTGxpOXm6kSheQ9uuttJg
         Uhy9Xh95jiZ9kyQ557AkFAt3QXob4nd4fvV3by2fYvI+YkzKPAZQ5AlWFvYlleHMsVNv
         aZGlSgS3yNYaU+R3wfUPBYtXdRXN2LnIyS0WVCVceWkfYYULLgdbjNuAu7f2iEncZ8ZM
         yWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726836356; x=1727441156;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YwTiYmEfOd8mBE/Nzbj2VSocNy/QK2H3gkxcThcAQRM=;
        b=IlxeqWoKvk7iZS10lLj1RGK4eYbpmLgwHrYwXJ9bA/zGy+thYHQ/Rt4o69MEPdARea
         irak7rUhQUjbEDp7ERLZK6zD9d0HcrU0/afR+nLh6LnsMueM42O9mTF4yJcNviTiizQH
         NBBNDRxEBrPBbKtNpvdlLVdnAQZ0x6H6VmYMHfO28sIATODoDlAbBf/XTDvF1Eb3Sa6x
         3lhVO0YMLDSQZRqHWzqQQmm22kyrqbpGLAk8iTOYDr7Q7XToKgl3Gi66m1SGS6s2FswT
         vavYJQ2GU0zbt0JEbjJB39b+SiXQtxLavEiwHJJ3DjxHQ3Mj5Q1b7qZcRSgGrMtIdvqC
         JP+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGJpkobl4dUoFD0nZO39XLMkmf7s/QcnngBTTXMr72twOAL/L1OVB8A8GoDwNzV/sxHrT9fEo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmk52PN7BH6ZiFY+YRbQg8UKTtcci/9e24fsJ+fWwVV0erzDLi
	8v0FplGMbAZdQG7c/LIDqi4BjIEc9lNg9VRvLd19fRcOb4WvcU2NMiIhdvI3lkc=
X-Google-Smtp-Source: AGHT+IHGwICbuNnMgYbN3bSgPNlhca6dG//YktxfuPG7h4nzRgeCOYXVhhGD5ZHGPSVwtQ4FQvO/ew==
X-Received: by 2002:a17:907:f7a5:b0:a8d:3705:4101 with SMTP id a640c23a62f3a-a90d5034300mr205674566b.39.1726836355723;
        Fri, 20 Sep 2024 05:45:55 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef80:de75:1bb0:80e4:4afd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90613315d8sm846631566b.214.2024.09.20.05.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 05:45:55 -0700 (PDT)
Date: Fri, 20 Sep 2024 14:45:53 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: stephan@gerhold.net, loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] net: wwan: qcom_bam_dmux: Fix missing
 pm_runtime_disable()
Message-ID: <Zu1ugT3cYptfeUaa@linaro.org>
References: <20240920100711.2744120-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240920100711.2744120-1-ruanjinjie@huawei.com>

On Fri, Sep 20, 2024 at 06:07:11PM +0800, Jinjie Ruan wrote:
> It's important to undo pm_runtime_use_autosuspend() with
> pm_runtime_dont_use_autosuspend() at driver exit time.
> 
> But the pm_runtime_disable() and pm_runtime_dont_use_autosuspend()
> is missing in the error path for bam_dmux_probe(). So add it.
> 
> Fixes: 21a0ffd9b38c ("net: wwan: Add Qualcomm BAM-DMUX WWAN network driver")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/net/wwan/qcom_bam_dmux.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam_dmux.c
> index 26ca719fa0de..34a4e8095161 100644
> --- a/drivers/net/wwan/qcom_bam_dmux.c
> +++ b/drivers/net/wwan/qcom_bam_dmux.c
> @@ -823,17 +823,17 @@ static int bam_dmux_probe(struct platform_device *pdev)
>  	ret = devm_request_threaded_irq(dev, pc_ack_irq, NULL, bam_dmux_pc_ack_irq,
>  					IRQF_ONESHOT, NULL, dmux);
>  	if (ret)
> -		return ret;
> +		goto err_disable_pm;
>  
>  	ret = devm_request_threaded_irq(dev, dmux->pc_irq, NULL, bam_dmux_pc_irq,
>  					IRQF_ONESHOT, NULL, dmux);
>  	if (ret)
> -		return ret;
> +		goto err_disable_pm;
>  
>  	ret = irq_get_irqchip_state(dmux->pc_irq, IRQCHIP_STATE_LINE_LEVEL,
>  				    &dmux->pc_state);
>  	if (ret)
> -		return ret;
> +		goto err_disable_pm;
>  
>  	/* Check if remote finished initialization before us */
>  	if (dmux->pc_state) {
> @@ -844,6 +844,12 @@ static int bam_dmux_probe(struct platform_device *pdev)
>  	}
>  
>  	return 0;
> +
> +err_disable_pm:
> +	pm_runtime_disable(dev);
> +	pm_runtime_dont_use_autosuspend(dev);
> +	pm_runtime_set_suspended(dev);

Please drop the pm_runtime_set_suspended(dev); line, it should be
unneeded since runtime PM documentation says:

	the initial runtime PM status of all devices is ‘suspended’

Thanks,
Stephan

