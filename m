Return-Path: <netdev+bounces-38173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8437B9A1C
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 04:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id AADF8281D1D
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 02:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47462139E;
	Thu,  5 Oct 2023 02:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i4L/3Aj8"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4F67E
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 02:58:47 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF277127
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 19:58:43 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c5cd27b1acso3595415ad.2
        for <netdev@vger.kernel.org>; Wed, 04 Oct 2023 19:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696474723; x=1697079523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0kNnoNX+VycKJxCFVsIPAbCtAe5boObmTDcjKlCDp2k=;
        b=i4L/3Aj8ygTjSUp9/p9XDWPSBBKIRjWIC5psTSo5nX3ZwidzXnhiCBlczgVVI2zjpZ
         9XWh+QJWSXuMiPpDWrlgZpJl/Z8tuZxCXx3YMi3JB62A4zXJlhkRATn11k3SCHNFLDbf
         Tk89LjB5wR/1YdxTpbiNiRU0F/Rvj9JM4j2NY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696474723; x=1697079523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kNnoNX+VycKJxCFVsIPAbCtAe5boObmTDcjKlCDp2k=;
        b=wn0Q8WVwGbt6aMnY2f8/q7CLKplp56N/OXmHwMqdAKEI/RuZBBd4UOju9+ZcL7fJiB
         DmFEmW2VWP6VCDAtyIMhmpHBjE/SQtpHySA/0e+BFvpcROB3hQIxz/daZeRFXjaoAdb7
         zMA6Vu2syR/0KwbVmGuitEjmup9uhpHk3dpSHAkvfBJ76B+aofyifb2vrYeUOeVHcEma
         QcEVzh5eL6wcUdV87fnMBZFEB6jfGhV/4BjhDbkcx4adIhamJ+9RTkaFKC/SDC93sHpf
         7qqSBmr0hyzMSsw8JMENHuXz8Dvd0RzzuS83VoPkKYpkZ0OAIR2BR27AD2/WDM6jUjuk
         4sFw==
X-Gm-Message-State: AOJu0YwS/LRpSDx+njG4WrpKjW5lY1QQHN84r/AmNzlmTsfimhEJ7bXS
	AWXoOPqfL/Blo556eHLu4I+r3A==
X-Google-Smtp-Source: AGHT+IEuvtkB5cCQbgCWYrRd54NAG8rv4yhh7aSFHMbN97v3p48aULxm0ARxKFDY+QpqB2XuHsjBOg==
X-Received: by 2002:a17:903:1cc:b0:1c7:2661:91e1 with SMTP id e12-20020a17090301cc00b001c7266191e1mr3864559plh.15.1696474722969;
        Wed, 04 Oct 2023 19:58:42 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902eaca00b001b8a85489a3sm313410pld.262.2023.10.04.19.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 19:58:42 -0700 (PDT)
Date: Wed, 4 Oct 2023 19:58:39 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] can: peak_pci: replace deprecated strncpy with strscpy
Message-ID: <202310041958.12F8A261A@keescook>
References: <20231005-strncpy-drivers-net-can-sja1000-peak_pci-c-v1-1-c36e1702cd56@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005-strncpy-drivers-net-can-sja1000-peak_pci-c-v1-1-c36e1702cd56@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 05, 2023 at 12:05:35AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> NUL-padding is not required since card is already zero-initialized:
> |       card = kzalloc(sizeof(*card), GFP_KERNEL);
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yup, this looks like a standard direct replacement.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

