Return-Path: <netdev+bounces-202471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F9DAEE073
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A16293AADC7
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858D1285C9C;
	Mon, 30 Jun 2025 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZO+z3+BS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ED025E46A
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751293198; cv=none; b=I/VryIdvtpEmMxqyMlOUN/XnJ8HxWYpoYCe4IHeRNEO95j7VDQM83BqIBD8pHu6azc0lguSQmeuOwLOHvyuCaRBnXHQlvc72DJRNEBceNOBzC13gL8sEY09vlfHD9yDZ5CEjoxGRtrrT/IQwP17yNQTVFnCva2wzwLqBNq03z8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751293198; c=relaxed/simple;
	bh=okEPAxGeUI67Z8DUbJWQ8Cf3p5/Hcr4IkrNPudjZ9oU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MuJ50222FzljB8/FNPUVMeboq3niN7yrszIVGSBSofXiVolRYeNCGUIn/FJfYhro9Iosjlv+q8Td+gUds9ecbPCUnHTCqvXd6cTi2qatSyWssHeCujzbd364NntoVumLJm0CMmHDejue/YVz1KT1xHN9sO5R0+pXZAVdJtoi4CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZO+z3+BS; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-708d90aa8f9so45634567b3.3
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 07:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751293195; x=1751897995; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XZNz81abEgW0MY3vS9sEZI3H/0FwCGSV3q7Vd6ujToI=;
        b=ZO+z3+BS+8kCy/DHlyUcyL8b07Be9mU8+Bfj/PHL0qKYgEGECzoS4QWhppWYKFFCip
         pwu5g5MXlIx+yLfVVSpWpRyjV/c85qVLtRSSIB3p6MPkAtKr7Y5JBLcQm4KOvC8mh2bO
         rrIyXWkxWjKPkYYPyHkOVmk4Mwd489b+6bO/yRQmxE52hksBAvAZZCqFeQrs5D7i+RR3
         Chtc7efKkiG3+wWgps6zXu8IziCSyPgjmK1Z3vUyir8EdrYVrinY28x9fuwVHqwPlkYs
         PyrdQcqof+n7SW5pUgmfej2txps5ZAw3plKEb7m+jq1uXGAKOkaPeEzrxxgRzgK7lNIl
         gxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751293195; x=1751897995;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XZNz81abEgW0MY3vS9sEZI3H/0FwCGSV3q7Vd6ujToI=;
        b=u+uuR6aOurhJE8V6V2+dyVtiXvkkfgTWAseI1tu+CVYtnin0EvOFjiRuEC8grgHxqw
         +drXYexmwOsndecQK0GVOyfILkC+xJnG3vU0ULdTUJ9bY9uvs3j/WbydOSVBwy2k39wv
         7juuA63p+iPr2gtx7J1CagpKrBudVjgbWFmPUqLDKMm9dW2gLSBoluhsE5gDfV7iclNV
         bMchvAYiaI1TOtTS7y/CCubZ42ZY0rZQ7TYcJUn2o04kFvW6w6GqZFR/mqoQ2WdXSVgh
         WVEK4GKywJ/+SATo3aNzvLIMwuwyaBHrRw8as2EBMFXkVbtZVbICxmmbGoI1plNUkijX
         J8qA==
X-Gm-Message-State: AOJu0YxfpJtukOFxfAl6em3yrQ0AylhecBdy8YfRisDTQOYN+1JkC5KZ
	Xbjxs9Mx/Wy3OeFE/FE1lYTxFqMWj+l9BqZPlJu5udbdTy43w21IV3zmCxy7OnKnqOBgoOz8zKc
	/fLi7rOaNRY42/1qI93vJY0GoWkzDmD1tzTFl27hJuA==
X-Gm-Gg: ASbGncu4tL/7N1VTf00+nVtHrS/JhTginP+iCdQZM6zMShlOfE39vmpmmycThaJa2ON
	rujy9WHgQDbyOurIQ4SfL1bd7dNyoIEW3uvVBVtrGY4ft0CBziV3wOG38CYPanUADujYRgNFH19
	Iy3ew0PQPxSOi56h+/sy4dRkePRvD0cBO3hMKbdTXgswpqpX7CJY2zKNE=
X-Google-Smtp-Source: AGHT+IEvlxsuyNjSG2baoIuvTQwgrdpag841OQRlT5eGmzeyivJDJn8CLRei+Oyc3j6Zz+HULGB0qA9R/gOwvS6KYxY=
X-Received: by 2002:a05:690c:6a06:b0:70f:88e2:c4ae with SMTP id
 00721157ae682-715171d56e1mr205407717b3.37.1751293195139; Mon, 30 Jun 2025
 07:19:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627200501.1712389-1-almasrymina@google.com>
In-Reply-To: <20250627200501.1712389-1-almasrymina@google.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 30 Jun 2025 17:19:18 +0300
X-Gm-Features: Ac12FXzHjqOcGcSbvKjlKEVRTT2E_tZYkZTADywaL4gsQ2efvDkNiYV5BxCcVxg
Message-ID: <CAC_iWj+Rzcf7_1wYF3F-iGUMhJ9sNtaY_gw_FmvEMH6QEx+scg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/2] selftests: pp-bench: remove unneeded linux/version.h
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Jun 2025 at 23:05, Mina Almasry <almasrymina@google.com> wrote:
>
> linux/version.h was used by the out-of-tree version, but not needed in
> the upstream one anymore.
>
> While I'm at it, sort the includes.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506271434.Gk0epC9H-lkp@intel.com/
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>  .../selftests/net/bench/page_pool/bench_page_pool_simple.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> diff --git a/tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple.c b/tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple.c
> index f183d5e30dc6..1cd3157fb6a9 100644
> --- a/tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple.c
> +++ b/tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple.c
> @@ -5,15 +5,12 @@
>   */
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> +#include <linux/interrupt.h>
> +#include <linux/limits.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> -
> -#include <linux/version.h>
>  #include <net/page_pool/helpers.h>
>
> -#include <linux/interrupt.h>
> -#include <linux/limits.h>
> -
>  #include "time_bench.h"
>
>  static int verbose = 1;
>
> base-commit: 8efa26fcbf8a7f783fd1ce7dd2a409e9b7758df0
> --
> 2.50.0.727.gbf7dc18ff4-goog
>

