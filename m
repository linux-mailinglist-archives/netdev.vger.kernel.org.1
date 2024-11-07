Return-Path: <netdev+bounces-142748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 294DB9C038F
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 12:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 990DDB219D2
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 11:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3A61F428C;
	Thu,  7 Nov 2024 11:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lex7c8kD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF73F1DF72F
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 11:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730977981; cv=none; b=szAAXAudDA2B/V5M7RKPZl18yTCJnEmmhGSA9elCVq3TgWD/OkHg23l/XrA2YH1SV3vKQpRA/4Bwc3r3Md+jLXQCJ0sWaq2TBxygjoHDKd0/76RBYqDuwR2Dcs782dt7bhrVqHE+7j7dncHNCvavYQmsAtIUJU7YzlgNZWWbYjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730977981; c=relaxed/simple;
	bh=FAssYMuT3g1UCnr1f1768ULjkSWodEn3Mogao3a8VUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sb4vArjs/hZakp5cHf9fmhAcC/CHTkTJPT32Akd4UXiwD+3XIZandOnovcK2nlgGVgx+Lly7a3hk8Hy7qn7KuqxKp5rlc+qOp4rWiqgo+MW9cOYI/v4JKYbV2X/i18Qo1Yr+WKs03rR3uIIhB7DhwUPbsSSkKeiMrEhgp/KZrGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lex7c8kD; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9ed49edd41so141937266b.0
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 03:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730977978; x=1731582778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bxTnaansLsGwyX4X1dG26PErwNbDYPOXaZq2IphXvjY=;
        b=Lex7c8kD3zYiRs4DGV0a3U+TV0ZBngibsHmu8H/sOuaKOmYJM9jLFDszlFkuHRE+ld
         73BsE+ZVSB+RhTJZW8xW6cgolYAnlLCCBWY++bXYTJCpeEae2sX5xtYsSVSb2wiudeMC
         3cOZnwh3QqvmdyDiOsq4ViHR7ip+1UfVcSQsrZ3OPOb20t0c/St70pC4Wgg4pi49JpYg
         9fOvjfjPHHXwwr2Ey7pt/MV43rxvT5tGdoMXma9FUDaAYkq73TcOoovYCJBBVwVP2FMh
         UEE5iX7t0UCLTxFTZH6NU36JgO7AwuwBN6OgOM8RaImxN4qmTZQPb7SZ9Sy3AOKzWPGb
         2/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730977978; x=1731582778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxTnaansLsGwyX4X1dG26PErwNbDYPOXaZq2IphXvjY=;
        b=tO2v1qPYSQO+gtQ3kSlCMIaQi/8twZSOrMQYkAhTBTscoe3Aqs10MMz5eGMviF/6KM
         +eqL0rgctL5pPwKyWv/JkC7NAvdj7NR31RkcJUmnHxNb5HrnL3sndv52HgDcN1qOu9yh
         WPIHKiblNy/atQt+BKqa6W5sX0b62g09pMDd2p6Hn9fdf0YK4Dm2wPcDsaWqDKj7o71E
         NrRI1mPqrsHk8u7QGVgbrIg9tWJz8YZdlk01U9D6u0nFWKF0GoFWjKNkHhr8uWp2tpO0
         eI9+qpQArbLwmJrMc4pZlNTTYjqMP2xXOmxUXtHBphub7EzlT+mCr5jlyvob5YicZkGX
         tITw==
X-Forwarded-Encrypted: i=1; AJvYcCUK/lQZC98cfOOQYi9AIbFpWqQbmUJoAB3yuM+Tyvv+tR4VDpEYOCRs3eYz7O96eMGqaDH/rYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb9s5z9EnV8l1zi6jthPHa45NYdJaBIvr7rYYZAIu2o73OAn64
	SGdIjD1WpJm9+2aW0Ju4vma1t5ba+HPaQzQCoktwKko8O79U0jlLT2Y+v/RyxM4=
X-Google-Smtp-Source: AGHT+IFphj611143VdJsImYjeAH+pxPMUc82CFGVDH/4iqS20JWIIoXXYG/sr/hULPByHmo8QW5suw==
X-Received: by 2002:a17:907:7d8d:b0:a9a:1e4d:856d with SMTP id a640c23a62f3a-a9de5edb084mr4352238366b.22.1730977978083;
        Thu, 07 Nov 2024 03:12:58 -0800 (PST)
Received: from localhost ([154.14.63.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0e0fabesm77450566b.174.2024.11.07.03.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 03:12:57 -0800 (PST)
Date: Thu, 7 Nov 2024 14:12:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Cindy Lu <lulu@redhat.com>,
	jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com,
	sgarzare@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v3 5/9] vhost: Add kthread support in function
 vhost_worker_queue()
Message-ID: <e55d4e60-37ed-49ad-a8cc-f7b6adb03b09@suswa.mountain>
References: <20241105072642.898710-6-lulu@redhat.com>
 <247f4cd6-5653-4eef-9436-5699b44c4b82@suswa.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <247f4cd6-5653-4eef-9436-5699b44c4b82@suswa.mountain>

On Thu, Nov 07, 2024 at 01:38:56PM +0300, Dan Carpenter wrote:
> Hi Cindy,
> 
> kernel test robot noticed the following build warnings:
> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Cindy-Lu/vhost-Add-a-new-parameter-to-allow-user-select-kthread/20241105-153254
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
> patch link:    https://lore.kernel.org/r/20241105072642.898710-6-lulu%40redhat.com
> patch subject: [PATCH v3 5/9] vhost: Add kthread support in function vhost_worker_queue()
> config: x86_64-randconfig-161-20241106 (https://download.01.org/0day-ci/archive/20241107/202411071251.tQLG8K6C-lkp@intel.com/config)
> compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202411071251.tQLG8K6C-lkp@intel.com/
> 
> New smatch warnings:
> drivers/vhost/vhost.c:241 vhost_worker_queue() error: we previously assumed 'worker' could be null (see line 241)
> 

I only meant to send this warning.

> Old smatch warnings:
> drivers/vhost/vhost.c:311 vhost_dev_flush() warn: iterator 'i' not incremented
> drivers/vhost/vhost.c:678 vhost_attach_cgroups() error: uninitialized symbol 'ret'.
> drivers/vhost/vhost.c:673 vhost_attach_cgroups() warn: iterator 'i' not incremented
> 

Not these.  I need to fix these for systems without the cross function
DB...  #embarassing.

regards,
dan carpenter


