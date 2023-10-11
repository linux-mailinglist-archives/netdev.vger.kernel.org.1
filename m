Return-Path: <netdev+bounces-40145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B8F7C5F22
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 23:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F361C20B85
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 21:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA74C20B37;
	Wed, 11 Oct 2023 21:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K7Xj88b+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3C11BDF8
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 21:30:59 +0000 (UTC)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A08AF
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 14:30:57 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-57b5ef5b947so200023eaf.0
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 14:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697059856; x=1697664656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gPdeSN+UCM0bKxtteCsEuwrT+LDscm/iwtDfjRU9nwc=;
        b=K7Xj88b+hXPMjMC0k1QJMzrw77Cb3aBXW9f6kpjs0n/F27xvEvdVDor93w/DjNFBKh
         UL9e6BRtL6hMkzFJMVd7qi5bZkjrHvMDfcahaq/qyUrsNTiIZDFUpvO4os3+Couej6Fm
         yGpnoYKDEP6n8/LpR4w3o93Nsd//CpkaaBMLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697059856; x=1697664656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPdeSN+UCM0bKxtteCsEuwrT+LDscm/iwtDfjRU9nwc=;
        b=UoixCjZPydSK2g+t02TYFaxKKr73mcm2fMgq8sphLvXufG1q0L3Ye4T2dwzZXDTtSD
         m+/YbwbKwYbfBhux/oSyiURJkFsJCGtWbGqSMK22A1Nbp2RBpNNkRP9B1t0FX9vTQBSO
         s75g59xotrt2H19nX6/f4A7Z5vCCm36UrXV2ix/tLdRpnXSrbVWnExBzWWMdW+EQs5e4
         xSgY+v+dlrzDdqcgdPz6w+Zu7eA7lahOzxDc5c6dXkjQ54EqEBQujOrOYxEkqiK5xFjW
         Bl+3Z2pBiQPMMYuzYWFZxeEiCgYrVk99UdwwmQ73bwIiBvon9HVGMu6sgCvKYlhAZycE
         /CiQ==
X-Gm-Message-State: AOJu0Yx3/RJLJe8OzNSbM4q3zenxayE/B3gPGjvRL0Ykj25fo4m16uFC
	NvV9RUnctt9MuXCm+r+nPzRtsg==
X-Google-Smtp-Source: AGHT+IHgiaS0J9V8G4ieZfMxkP6YJcYFtXZ8HWNnNVZcyH53BKixjx9bhz+wn0W15U33LD4O25xHlw==
X-Received: by 2002:a05:6358:528d:b0:134:c279:c829 with SMTP id g13-20020a056358528d00b00134c279c829mr30279195rwa.18.1697059855858;
        Wed, 11 Oct 2023 14:30:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g9-20020a639f09000000b00565dd935938sm309145pge.85.2023.10.11.14.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 14:30:55 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:30:54 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net/mlx4_core: replace deprecated strncpy with strscpy
Message-ID: <202310111430.C419092@keescook>
References: <20231011-strncpy-drivers-net-ethernet-mellanox-mlx4-fw-c-v1-1-4d7b5d34c933@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011-strncpy-drivers-net-ethernet-mellanox-mlx4-fw-c-v1-1-4d7b5d34c933@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 09:04:37PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect `dst` to be NUL-terminated based on its use with format
> strings:
> |       mlx4_dbg(dev, "Reporting Driver Version to FW: %s\n", dst);
> 
> Moreover, NUL-padding is not required.

Yup, since it's only use is for the above report.

> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

