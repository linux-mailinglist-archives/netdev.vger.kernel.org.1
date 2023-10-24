Return-Path: <netdev+bounces-43960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CF37D59BA
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 19:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AD142819AB
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 17:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6819B3A29F;
	Tue, 24 Oct 2023 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WSiqAtdN"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC08827EDD
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 17:28:51 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D9D133
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 10:28:50 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ca72f8ff3aso32678975ad.0
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 10:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698168530; x=1698773330; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v5+vnHpkaeDGkL4KU8yjQESLCmsVuX8ylTfakxaPTtU=;
        b=WSiqAtdN8PzA+kCu8lcgn/moDnuGBVsVifULPm264T9xl2ixUN+CEzB/G8SfDDTV8K
         pM/NokKvdXpktq5+3wT1s+7bXFZ5Wz1n07B/3QbktvU3O8cA6e2u08kUIjzMEkJ+g75q
         FuGmP5bOxY51HjMomrGGTqXaam5F5M+pWfakg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698168530; x=1698773330;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5+vnHpkaeDGkL4KU8yjQESLCmsVuX8ylTfakxaPTtU=;
        b=t2kQqAmJDdRcBa7j9FKZ3wZE9aLYdzBF2Xiof0Hdewwi6xYXyyQKh9Y3ZS5QAIPvze
         pa7ODF0aIPLCE4K7rASNUM7LQbgSj/AfFjc3+hiX5gHd4VRgTvbBuGaXld+dgmXWoF4Y
         EaogNroRT31O3fBww1d1Z8mV17VfDx1rrJmptdxGqZeFYu0w89Ei9grjqP0KNudg/WZw
         hKiOgkmmEwi56HukhePXAEZ7P7b4hC33EgVsJJmTQXNZC0dD/QX3zJmVoQZCjMTLd5Cy
         05mhySJfpsEq7EOcqX3R2X1jl/0Ov8+TRQENuE2ekyyzxlwTrLGjA427bihEXv1TbuXZ
         hvRw==
X-Gm-Message-State: AOJu0YzlCN5Itgn0R69nPnLvJyzPZiO5s6NLBoXo8Yaqf7BXi8kBrhsB
	IhFWQyNT4T748TynUJGpO/sJ6Q==
X-Google-Smtp-Source: AGHT+IFQks8f7taxe/T8lJX4HzjJyBwLcpA05m1ZgzLrUenz+1s8G0m8uqUjTVMkOtGRSqaCkc2qWw==
X-Received: by 2002:a17:902:ce88:b0:1ca:59bf:6cc9 with SMTP id f8-20020a170902ce8800b001ca59bf6cc9mr13033744plg.57.1698168529819;
        Tue, 24 Oct 2023 10:28:49 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n17-20020a170902e55100b001bb1f0605b2sm7650806plf.214.2023.10.24.10.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 10:28:49 -0700 (PDT)
Date: Tue, 24 Oct 2023 10:28:48 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Alexandra Winter <wintera@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] s390/ctcm: replace deprecated strncpy with strscpy
Message-ID: <202310241027.516C46AA@keescook>
References: <20231023-strncpy-drivers-s390-net-ctcm_main-c-v1-1-265db6e78165@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-strncpy-drivers-s390-net-ctcm_main-c-v1-1-265db6e78165@google.com>

On Mon, Oct 23, 2023 at 07:35:07PM +0000, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect chid to be NUL-terminated based on its use with format
> strings:
> 
> 	CTCM_DBF_TEXT_(SETUP, CTC_DBF_INFO, "%s(%s) %s", CTCM_FUNTAIL,
> 			chid, ok ? "OK" : "failed");
> 
> Moreover, NUL-padding is not required as it is _only_ used in this one
> instance with a format string.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> We can also drop the +1 from chid's declaration as we no longer need to
> be cautious about leaving a spot for a NUL-byte. Let's use the more
> idiomatic strscpy usage of (dest, src, sizeof(dest)) as this more
> closely ties the destination buffer to the length.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yeah, all looks correct to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

