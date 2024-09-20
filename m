Return-Path: <netdev+bounces-129074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 549E697D59B
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 14:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1822B23150
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 12:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468B614E2D8;
	Fri, 20 Sep 2024 12:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XZzwrcRY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D3A1E4B2
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726836271; cv=none; b=Sj2c5GCui9JV4PLtIfzpo5/SqucG51qkDSBP4YjoDXAfpPlIZAnrJFonkRwdcAjZmarPPcc2tVQ1IRVSWOsMgMbY3BAo2mjNeEsvXRobB8UypQI7MjNguMBV/tS20n6sqnVDuwXOWLaD7DgtfVjtM6MZcm7XzFaYH7eIrcrtDpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726836271; c=relaxed/simple;
	bh=B8MzUXbeIjS+MC1pxMl6CzSLrM5Bx82UeVG+v9v3rEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nydTz8r1uYvHnrT8h9bFnUqHdPtnb9GysI1Y84FHy8JQrBJ18WVxCGzFh1aEzonl5R+g97bOcSNt9MDHb+N5pQiSkFJ39mS6am5YHoVfgDMVRsIZ1jlUF5RKOxkF4COZF31Cr2l8LMv4bvGEOXv6KbkiJBOuxX7uzs9zKOMQRXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XZzwrcRY; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8a897bd4f1so256563966b.3
        for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 05:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726836268; x=1727441068; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aDO0vPyvIABvz0DiT33xAJEo0l8Q5gFjEXHJSzmH/NE=;
        b=XZzwrcRYzLhu+bX/CdK2pMnPKrxruGMegxiAZmA6yHWXUbwLr7pNZmHdyS0I2jo66g
         2BCpwOllB832WYrTjaBfF6rpRSBpRC4UDWkDcFdV1h9F+AqNGaQKDJ0g2Klmuuuc77uf
         YUiyFx7YLxX/gQ/mpKrTF0tAxvx/i9KAk9ANNBsFQQodvFox7YO8XIAs7tWO5WjwjvTh
         UNSQVdZhlKFvia99LXeierzjQFtyUEM9Xb36xwmUEL6OQj2SGNA9COrVpPn2qpkpejke
         Aw1LEj1ihfVNsvhxWfOaDK7x22xV6vs2WEEhe9LPNxyjbht6/id3yPkii+WYHNbhw6eC
         WMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726836268; x=1727441068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDO0vPyvIABvz0DiT33xAJEo0l8Q5gFjEXHJSzmH/NE=;
        b=LLIjVus/srMcvd2lRkqs7te+NoLpBgcXM9TPHTziFiZuLn3BlqH4HNuuts6SQ3MT3M
         wFdG5PUw3JDpYWxzShmeZ7unuKNTqldlSuSgtjk609aC2Fp1jzRFAjRXa6IwgFrG0m49
         A2Yp3hX3jRZugcFqq07xemC68+P2FGZHxTe4JM6A6RVszTWnDe1ish9KxinM85BxEZL2
         JovyisQhfINROcvhQPH5RrrycJfVC8UX0T039yLRODeTEHpgaYoSBZS4OvbKv0Dq2on+
         W+kVvfmskEa2adp9OO0Qjl6PT+u/+B1/D2SuPgao4vrPKLUHStbPd7d1UugSIs+FxzSg
         IxjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnk1WdayNY9KFgWuvlwxiQi6EJTVgXhwLzYEQzJg+baAvuGTY8ISiw1Epw4rWSXnKaBvongAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS+oujRgX+cUhHsfP1vWHrpcoSEHMdmwYUQkZK+NY3AU/hG9E9
	dJWcIOnpmDfWLPJP5Iw9B/QPBH5eUsxIwHc615j3fspySLzihpJ6VrwVd14Fp7o=
X-Google-Smtp-Source: AGHT+IGDYr84SfhTE9iCQ3CMFhcNCWIPXNlNOj1ld8jHd8Q6e5bYh+70KLroF2CA85pp6CVhB7OAtQ==
X-Received: by 2002:a17:907:e65b:b0:a8d:c3b:b16 with SMTP id a640c23a62f3a-a90d4ffaf60mr209109866b.28.1726836267822;
        Fri, 20 Sep 2024 05:44:27 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef80:de75:1bb0:80e4:4afd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612e519esm855375566b.176.2024.09.20.05.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 05:44:27 -0700 (PDT)
Date: Fri, 20 Sep 2024 14:44:25 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, stephan@gerhold.net,
	loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] net: wwan: qcom_bam_dmux: Fix missing
 pm_runtime_disable()
Message-ID: <Zu1uKR6v0pI5p01R@linaro.org>
References: <20240920100711.2744120-1-ruanjinjie@huawei.com>
 <lqj3jfaelgeecf5yynpjxza6h4eblhzumx6rif3lgivfqhb4nk@xeft7zplc2xb>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lqj3jfaelgeecf5yynpjxza6h4eblhzumx6rif3lgivfqhb4nk@xeft7zplc2xb>

On Fri, Sep 20, 2024 at 01:48:15PM +0300, Dmitry Baryshkov wrote:
> On Fri, Sep 20, 2024 at 06:07:11PM GMT, Jinjie Ruan wrote:
> > It's important to undo pm_runtime_use_autosuspend() with
> > pm_runtime_dont_use_autosuspend() at driver exit time.
> > 
> > But the pm_runtime_disable() and pm_runtime_dont_use_autosuspend()
> > is missing in the error path for bam_dmux_probe(). So add it.
> 
> Please use devm_pm_runtime_enable(), which handles autosuspend.
> 

This would conflict with the existing cleanup in bam_dmux_remove(),
which probably needs to stay manually managed since the tear down order
is quite important there.

I think this looks reasonable, except that pm_runtime_set_suspended()
should be redundant since it's the default runtime PM state.

Thanks,
Stephan

