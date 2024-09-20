Return-Path: <netdev+bounces-129061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727C497D46B
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 12:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37871C21FCE
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 10:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB35413C3EE;
	Fri, 20 Sep 2024 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cEHYrjde"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D979455887
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726829302; cv=none; b=ooIw6Gr+cWJRWxbdSnYo9XILvKzCL4M44dEpjHgRHf/XMolZb8wyB264ttyRcD7HiEFOkecQYEbMsrebt9EgMUHOj0H8qb9AyINin8KlhD95t6s2WkZr4jI+TJXMCQGfvkgxjeAI0vlLiIxzjPxtIR14/1Z1x21bOqrIWUJclu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726829302; c=relaxed/simple;
	bh=etFf4qTBVZ/vq0hx3z2kleY01er8ESytRExqWIN/Hrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HE4P5dW5M8w+qa0UBJ2zw92O+9OP3W/F+IZ7kufFnRQ1EigkMuKnh3egp2FXlWywh8BlxgjtrDwn6LzT9PBxFnnn/c4buOpZUAwH7de8t012oRlbDhUItuJYrTw/osRhZxZRVPWuyPCYFZkYTWm8FBNCuc98RuRYoCNj5pe8IpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cEHYrjde; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5365b71a6bdso2253044e87.2
        for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 03:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726829299; x=1727434099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d0wX2HgJsGjDVHhStjJhEGEpLyVcLkj6YKdYCnWWVDw=;
        b=cEHYrjdejRNLAQBYFJhQFP7Vm3N5d3j1XHnC0Wl2fYPdX1peB+rZo4myxDc3PA1q8S
         9ZQakl1bvDAl7Q0skalxEPVJbOf+UQ/N7pCzG/6ZMxIKM4+6kaHilUl1czqHE6/sdqrr
         jQv1a/87i2RClqOZEHsfMwvAhfcB0qNH9ju1cZsAqMupyLS4TdiT8VKAwCa0vbiO7Dk9
         ul3YERk0UROxHjhW+7V/A3ru52gLe1Bnl3o7Vgl+/Os9rgDlsYo0f9r+XsUoc4o6NTRQ
         4K2stap0VHl3POd802Vsnk234hzMUQc4K7UXOTXM7bvvdWSgmwdBKBTT1xebdlv3/tmO
         eohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726829299; x=1727434099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0wX2HgJsGjDVHhStjJhEGEpLyVcLkj6YKdYCnWWVDw=;
        b=nmuJ0fSFMsUivHYnAi5/hd/+zAO7ge3VJXSIGoC3lMWxtURXQF5Bco/mN3IRKI4ap0
         /tDyimv66QDU2hZN/UCEZ64UFbcGPcySAL9JHrrmQKTrlsJ+IpGmMcyzhWmvlD+pmT3S
         lyJZr++ouF3qIADlKRMkFzhFZMqLUpHkFcOMvOHF7nhKnBXKix8Uc11gLJndqwkJzpOU
         PTbg6cgEuqPpjgt+KXqWIR+30AjJGtoXyuM0cEdIBcPdGvjgVeQrCBHyqPljoVOJedWY
         qDTe1E6HvNCcpjKu6rkPhknAlSct+++D0XeC1zmEbvN8o4vEWbHHh2wxLyu3tMay/n71
         cC/w==
X-Forwarded-Encrypted: i=1; AJvYcCX+umeJHRCRuXjWAk26q4UV+BNcq4E6Yiy0/iU2owxV85DXq7nYp64zQcGlxQad359ljGK2W7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIZxMKMUIZmwXfKtCsgEwyKWMoj0Gi8PBnxOUDr3vEbAKhkmpg
	hyy00qwOnIrJRtn434DVOG715EKXtPOXiqxCMaKE1vRV7YPMMZ0E42S3mYdsNpY=
X-Google-Smtp-Source: AGHT+IE0YX9FHsU+6bvH0oBSe1wloxjPMmlH/cCbWXoHTmT7BpXouXLIrHoZol8sfO4CBI02grA25g==
X-Received: by 2002:ac2:4f03:0:b0:533:d3e:16fe with SMTP id 2adb3069b0e04-536ac32f114mr1511695e87.38.1726829298938;
        Fri, 20 Sep 2024 03:48:18 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870965a7sm2129787e87.172.2024.09.20.03.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 03:48:17 -0700 (PDT)
Date: Fri, 20 Sep 2024 13:48:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: stephan@gerhold.net, loic.poulain@linaro.org, ryazanov.s.a@gmail.com, 
	johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] net: wwan: qcom_bam_dmux: Fix missing
 pm_runtime_disable()
Message-ID: <lqj3jfaelgeecf5yynpjxza6h4eblhzumx6rif3lgivfqhb4nk@xeft7zplc2xb>
References: <20240920100711.2744120-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920100711.2744120-1-ruanjinjie@huawei.com>

On Fri, Sep 20, 2024 at 06:07:11PM GMT, Jinjie Ruan wrote:
> It's important to undo pm_runtime_use_autosuspend() with
> pm_runtime_dont_use_autosuspend() at driver exit time.
> 
> But the pm_runtime_disable() and pm_runtime_dont_use_autosuspend()
> is missing in the error path for bam_dmux_probe(). So add it.

Please use devm_pm_runtime_enable(), which handles autosuspend.

Also please provide details of the platform on which you have tested
your patch.

> 
> Fixes: 21a0ffd9b38c ("net: wwan: Add Qualcomm BAM-DMUX WWAN network driver")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/net/wwan/qcom_bam_dmux.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 

-- 
With best wishes
Dmitry

