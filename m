Return-Path: <netdev+bounces-174573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDE4A5F501
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 13:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91DE63B46DD
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 12:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E921026739F;
	Thu, 13 Mar 2025 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yj9m9GR8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3903A263F2F
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 12:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741870613; cv=none; b=Dc8q4RcQzXy58avI9WdjbWwJv6GZDCj30vir4WmZzAegmWsXOnmREtg6YoQnGjjnuFbPJYR3MnKbWLKCAWKdSIPwRNNR1TgBSZCz0ys3UsSozOVyoSSLK5X+yvdzbPL16iY8CdmeoO+0HL2/scgNbj43NxhNbrzPw8g3YQh0Eoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741870613; c=relaxed/simple;
	bh=sHZbfdxQGp4mdAR2Febo0n1NWIDVS+DyHzbiuUQ0mhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I0pqli7/jpH96GBsRHK7wxMIMc37T8ycxi+ZHJC2LR2X1hsWa/cLBu8lOoQNkAw9eEeFaqLT1CHG7TD7Ob7r5qm4sfwE/wga7TyvhrLG0zrF92v4AVEXUD1nbe+5CncZ5K7BU4uEFAReZyPBJCEdrQGzxuDIpX3hU0mZe9buea4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yj9m9GR8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741870611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+f8njczfxaG2co+pkvStJWQ0iTaUQVmmbS67uxHnnY=;
	b=Yj9m9GR8/DeqMJHlJqjFRBflQGVKeBgAprsu212IAf/p2TzP6L51LYpXyvAsgdE0k36IB1
	V/AVq+eKTB2OtJN+uigLSWJ2qIi9sLk1cV75o0T6oPVU10Xu4jJ8T7NUvsWGzeJZbm8k47
	hEicZ7vc+Q2sDh7DjSi1yfQ1a2ZtKn8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-mQZDAztLMAylzldZg9wQ3A-1; Thu, 13 Mar 2025 08:56:49 -0400
X-MC-Unique: mQZDAztLMAylzldZg9wQ3A-1
X-Mimecast-MFC-AGG-ID: mQZDAztLMAylzldZg9wQ3A_1741870609
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43ce8f82e66so4752845e9.3
        for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 05:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741870608; x=1742475408;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l+f8njczfxaG2co+pkvStJWQ0iTaUQVmmbS67uxHnnY=;
        b=kLf9joSSVlXz5ixucnGeCzmiYSYIbtvAGJqSYGmncM8gdrlUgazEQUM+zqQGFgNNKg
         MbOecqy5cD4l68ZpRHtxTiovIL9vb0CwPZFtnMMJenUNyXPZpg+Nknouobr1+2SfeO03
         nBQnSKMPQ9H5n/Fui9x9k6D+1lhT2wZ3CUCQWLLdpT1Wfd1fIOPG2M0d5ZPhbyp3I7qf
         zTcPKNcWDH6pLAoDo3Mz7wcsbde4ugh26E6FmtPKMETjkrQOqf5AZja2eSPQaZzHh9uz
         ux4wdvvfxXo9DPv8sEL85oIX3+PXWQy10Nw0n71UzSzcz8BvUbE6ElCV+lQ8sahRormd
         mB4w==
X-Forwarded-Encrypted: i=1; AJvYcCUherPRgZeh1+lnUMoV0wH/4JNtzAmR2nMTZo5KhUsalU0w/a2uj2EvPxoKsu/EzopIK6QiDpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU1mTHT2X+c5JFlVCMGqd3NCcZ3u2zcAOzr4sW1XEUMMbY6RmU
	qKdsYVBdzPaI04G3T168Qpyvsf2NCA3o8yv3UM6+fGEYtUivA+MNyOuqVUqjVHGSALLCUrSut01
	U4CvM+aLZaw5fQzVwErnrcjBAAMXjkD3o9UdxxtM7N8SkobYhha17dA==
X-Gm-Gg: ASbGncsFQbDtHqzC25HdpYAhU6V04XDsxsnCx3KLzGCkpv33QkwmPMiZqYy7xp84ywZ
	7j1BMV/RUdOVXfkKqOoiSvj3vnadAL18mMLjv5LcB0Fn95dz82VMq0shKL4miKCllOPdOoXS5KX
	/L2vwsd0j1/OCKflca7uQa7YK5lX2oJq4M04xixnZDFmGJdw78zutM4F4lA3wgVK+bdf3+SxOWC
	XS6+1U+TFntjMxz68WVojIj74N0bgmvEJGT8If36qtTfETRBiCMMtw9ikD+S0Tm6Os9YnaQN9f7
	8jeH04x4DFSlN5YNNTZ+vfUh2HOri1aiZNnqjI4i
X-Received: by 2002:a05:600c:548e:b0:43c:f70a:2af0 with SMTP id 5b1f17b1804b1-43cf70a2d2bmr157969675e9.16.1741870608602;
        Thu, 13 Mar 2025 05:56:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDa8ie+Wz/9pwdX9IQXaSESSe0ds+RYH5z8oo0ZoXLXzFF6SIuQIjrJS2rEfZaRhu/aenE9A==
X-Received: by 2002:a05:600c:548e:b0:43c:f70a:2af0 with SMTP id 5b1f17b1804b1-43cf70a2d2bmr157969485e9.16.1741870608203;
        Thu, 13 Mar 2025 05:56:48 -0700 (PDT)
Received: from [192.168.88.253] (146-241-6-87.dyn.eolo.it. [146.241.6.87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df35f7sm2079659f8f.13.2025.03.13.05.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 05:56:47 -0700 (PDT)
Message-ID: <3c39994e-548e-4d67-b8e4-3236d27a6ca6@redhat.com>
Date: Thu, 13 Mar 2025 13:56:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 7/7] selftests: net: test for lwtunnel dst ref loops
To: Justin Iurman <justin.iurman@uliege.be>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
References: <20250311141238.19862-1-justin.iurman@uliege.be>
 <20250311141238.19862-8-justin.iurman@uliege.be>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250311141238.19862-8-justin.iurman@uliege.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 3:12 PM, Justin Iurman wrote:
> diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
> index 5b9baf708950..61e5116987f3 100644
> --- a/tools/testing/selftests/net/config
> +++ b/tools/testing/selftests/net/config
> @@ -107,3 +107,5 @@ CONFIG_XFRM_INTERFACE=m
>  CONFIG_XFRM_USER=m
>  CONFIG_IP_NF_MATCH_RPFILTER=m
>  CONFIG_IP6_NF_MATCH_RPFILTER=m
> +CONFIG_IPV6_ILA=m
> +CONFIG_IPV6_RPL_LWTUNNEL=y
> diff --git a/tools/testing/selftests/net/lwt_dst_cache_ref_loop.sh b/tools/testing/selftests/net/lwt_dst_cache_ref_loop.sh
> new file mode 100755
> index 000000000000..9161f16154a5
> --- /dev/null
> +++ b/tools/testing/selftests/net/lwt_dst_cache_ref_loop.sh
> @@ -0,0 +1,250 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Author: Justin Iurman <justin.iurman@uliege.be>
> +#
> +# WARNING
> +# -------
> +# This is just a dummy script that triggers encap cases with possible dst cache
> +# reference loops in affected lwt users (see list below). Some cases are
> +# pathological configurations for simplicity, others are valid. Overall, we
> +# don't want this issue to happen, no matter what. In order to catch any
> +# reference loops, kmemleak MUST be used. The results alone are always blindly
> +# successful, don't rely on them. Note that the following tests may crash the
> +# kernel if the fix to prevent lwtunnel_{input|output|xmit}() reentry loops is
> +# not present.
> +#
> +# Affected lwt users so far (please update accordingly if needed):
> +#  - ila_lwt (output only)
> +#  - ioam6_iptunnel (output only)
> +#  - rpl_iptunnel (both input and output)
> +#  - seg6_iptunnel (both input and output)
> +
> +source lib.sh
> +
> +check_compatibility()
> +{
> +  setup_ns tmp_node &>/dev/null
> +  if [ $? != 0 ]
> +  then

We don't have formal codying stile written for shell files, but please
use tabs for indenting, and keep the 'then' keyword on the same line
with 'if'

> +    echo "SKIP: Cannot create netns."
> +    exit $ksft_skip
> +  fi
> +
> +  ip link add name veth0 netns $tmp_node type veth \
> +    peer name veth1 netns $tmp_node &>/dev/null
> +  local ret=$?
> +
> +  ip -netns $tmp_node link set veth0 up &>/dev/null
> +  ret=$((ret + $?))
> +
> +  ip -netns $tmp_node link set veth1 up &>/dev/null
> +  ret=$((ret + $?))
> +
> +  if [ $ret != 0 ]
> +  then
> +    echo "SKIP: Cannot configure links."
> +    cleanup_ns $tmp_node

If you add a:

trap cleanup EXIT

after setup, you can drop the explicit call in the various exit paths.

/P


