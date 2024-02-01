Return-Path: <netdev+bounces-68014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1368845981
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 15:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3AB01C29A23
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 14:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A9F5D488;
	Thu,  1 Feb 2024 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="d1sKTZQc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA55C5D477
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706796116; cv=none; b=FvHiGOTr70bcJxIJL8NIroGFluTrZba2sHuE2bH/eZnhBiTkAxcomjThOf2HvLb8MxMeP/ll+F2MnAjWa6QbvqzeIIIYU4SbQDDcq7yOcZLBj0XbolnXFNLWwIW5Jd5nR6acCvEklfDyi5TXOAdgccNUTlZ8FhvCsMZ+en5IH0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706796116; c=relaxed/simple;
	bh=frJYg2PC2XdkrXkJAOqtJTdtAXRNCmZKF9NX2CrmgFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxJ2LNXBF2Ty/3bZVQUJefHFMBHlPVrMa3k2CX/HKTf1tbHnYWYendmrlQ37Q5Sz/We2G6gfUHP9VZwM2/g5ULnwx7d3+Fxy39BN06vgfJUAnTeDJfJ8TUv0LchwhLCmL9jRtTujSZ0ebtPN8S5CtW1ztlBkHhWREmqtjj8cVas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=d1sKTZQc; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51124d86022so1538175e87.0
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 06:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706796111; x=1707400911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=frJYg2PC2XdkrXkJAOqtJTdtAXRNCmZKF9NX2CrmgFk=;
        b=d1sKTZQc2gejwXWVy98BoRcKXeL41FYhyEuTg52qCm7aFDIHlzsDw30Mpq9T0gwmIM
         E4OxVEbzIX+orj2FOEsPranw0Q32c4BOfJ1J7nvsCq7Hbn5usxPMJszWsI0Rn4Yju9FR
         0e1XOcXm0pwG/CafdofiJmTuqI93jVZkq+owJlJKPUWlRKxpDoavhGbI3xNU164RVfZb
         b93fbzumUmKjBFcj2mIMM2xKL8TdwSObEBsZarMuudEEi75smvB1Hwg9sm/Vegb7DDh9
         4TWqiWLLUPU6bHQ4dxEnKptvPqPk/f6a54ZoPITGz2TWDEx9HcZX6oB0zEJ50lX275vz
         4FiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706796111; x=1707400911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frJYg2PC2XdkrXkJAOqtJTdtAXRNCmZKF9NX2CrmgFk=;
        b=cCNNVnAGH0XFwVyWl22eF9ECTs8uPOLgSuIQHvVFs/RcLSLIM86Ote6YBfYd/DnNit
         A1zYA9qbviUUrCNFIdcFhiIAlpAoPQKfdlySse6orNfV4PZNjpzvUFpWAdwA7Y9w8z8B
         vQrlZdtxRMQ4Ibl4sxa/tDfqersC/dpEVzIswkK+/kX2zfjqcugowdoPKpp1rlGFtxEf
         Gwm0BXHu6J8qphYr2ycpU1NomfiodW7Rmqfm4ERBJLxg1XtfWcO+Ct7qiMaajuA+TXII
         1vExzTEzfEsB/oCCwLm1IpmNlEv92N4x1dq14zxFZemr2DTXjyDUoOkKv4+ivADVZx/p
         QeQw==
X-Gm-Message-State: AOJu0YzNtTLmXri4ptCQrDp9DhFfCa5ZCZA4qQaHcZGmLKtKTt/Lp5WP
	hzi6ki7bGOlAixD3dRy43zhoTToE5ccBXqef+idg8lD+5up0FTQIWAEKscVYq+g=
X-Google-Smtp-Source: AGHT+IG9TMHzKkmn1MLR1nInbrtFVlsDxHGMGq2QfUrOTwbaE4ygUkEUKBLaWl1pYF85hpICE28dmQ==
X-Received: by 2002:a19:644b:0:b0:510:1bbc:96bb with SMTP id b11-20020a19644b000000b005101bbc96bbmr1735662lfj.24.1706796110872;
        Thu, 01 Feb 2024 06:01:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUMUxcq+7ehGQMeOzDkjytYLdEGh+MFJsN5LN+Wo6HUMb8mpckZqVVBQZcZjn46Siy4LaYqrUr5sKwXzK41prZddw6UddEgcDb/pO6bgMZyHzUtuU/vh7XDX03QV+/ltap6yQ8jkrY9cBahHEyZyjuggDddkRxBi3hGPk2Qor9c//vjtd7MQHxijx5QmjX/iHl2Lxli8tfKKF3h56esd8ouQa7/6LZYJPqI113ZZLQPgXCO8wMA9lSsweVD2u3fuE7aKBrYV5ViKmdUbd/EC4tp2jc8HiIOm7CgBeRV5uDtLuJs1ftucK8EZvb9XhGEvSIuGdKLAEGqT0zW3sIVVARhARQ9+rAhzn+Y4zghcp0FjWcckXdOAXR7BPRUlFKCVoHT04W4CEYL4QN4SVKVw+CWXPUIyTj4cA==
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id s6-20020a05600c044600b0040faf410320sm4406076wmb.20.2024.02.01.06.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 06:01:50 -0800 (PST)
Date: Thu, 1 Feb 2024 15:01:47 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] octeontx2-pf: Fix a memleak otx2_sq_init
Message-ID: <ZbukS3j_cS57FmZ9@nanopsycho>
References: <20240201124714.3053525-1-alexious@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201124714.3053525-1-alexious@zju.edu.cn>

Thu, Feb 01, 2024 at 01:47:13PM CET, alexious@zju.edu.cn wrote:
>When qmem_alloc and pfvf->hw_ops->sq_aq_init fails, sq->sg should be
>freed to prevent memleak.
>
>Fixes: c9c12d339d93 ("octeontx2-pf: Add support for PTP clock")
>Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>

Acked-by: Jiri Pirko <jiri@nvidia.com>

