Return-Path: <netdev+bounces-183619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E26F1A9151C
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 09:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59C263A8881
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 07:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131C821B9E5;
	Thu, 17 Apr 2025 07:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YwTsQGIt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577882192FA
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 07:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744874793; cv=none; b=GRbWAeqXaO3MX4U8cgApf//pxlyMIFWPiPU3kBCu393myO0vsyV04ABdhtGKF44D+TJlNFyKqlmGSZKyWjUeRlpkyVQiFKbWCcs7G+zFS/pff1HXDro8NLcXPUXYIAsaShIPslGj//vTzbrFv/Alg95SupAb8KA8U/McELog90c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744874793; c=relaxed/simple;
	bh=Pt4wMjTOPxLyncUhsljlu78aefYEy0zJC2OQzWrprQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iMkbcv7e0CmqEz/UtrKLsS5STXeFujYoZJ4s3UwHstBrmZKFoPWe6Ww9PgSTEeg3ocrP7ZVm5UOusLYtTmp6Nt5dl9lpA7JGx5cptQlMTFwKE8RQmDjY2qu2th4o6t1fS1WOCirnUuQoq570VMtb/nq8TT/8YnoHgppkqzYw9Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YwTsQGIt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744874788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Udp20JCu0lxnLB5nbtOFfZ2GpP06hSOWr1XwI2XNqTs=;
	b=YwTsQGItdi6+imIMzgmeMpHYDQE+ULd34i8Ptza9OWjt+4UlGyl1S1qe9qVCGhmuhp1DPm
	sraAHv4IYTEWH3eU4P5sJHREnG1L73yUCRUmGJYpsQSWwoZ9nRq1kVGiljSQLcsC//iNbL
	9qvXXAGgaQKHmnxVYn2bWpi9GhqltM8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-uufqsfZzNPmATd9aTCMqXA-1; Thu, 17 Apr 2025 03:26:26 -0400
X-MC-Unique: uufqsfZzNPmATd9aTCMqXA-1
X-Mimecast-MFC-AGG-ID: uufqsfZzNPmATd9aTCMqXA_1744874784
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d0830c3f7so2961975e9.2
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 00:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744874784; x=1745479584;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Udp20JCu0lxnLB5nbtOFfZ2GpP06hSOWr1XwI2XNqTs=;
        b=dlYelbEPToVsz4VhyLHIYoqrDIw3i+Bi1oEd4Wv2S0h/w0OTZEgcxVpkTbHsHczaYH
         IdHSLf3L1FaFq0HpKpdt8IG4upDbfmmhGim+z34+A8lb+1Grufxcf1cEbT7BL5ZQyTty
         WdhOvl8PyJy+Lc6OvIFW+FULgLyCmSzTLRsFsqUL3gSFmCZ64IzcTR0+7k3gCgYPc0fl
         DwT5tZoBUUIIw9eE2OvP3CilxWMWU3BmMbI1ucQoSxSOWAvzls+16vAABr1Yd1MfwOEl
         +QqdeDcg54Huwol9W1D8lPhyV9syDl7URb5uA3Lcn4v+i/vWlCEBlGbaEOT2OfjRVYGG
         RE1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFUYrd92MLjiTzu+ZlpUD5iVbIq75IaoGvKnOJquLIUmmGx6rW/Mm2vKC6KG/xsB5nglXMF5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4hBcotmzgelTMhAgWhLQC6gcjW0A8dxxf8INf9Z5vZ5yihMp3
	hD6erve743RcVHG9ko1r79oy8IO6F5YuJ9n7J9u5a7STiI2B6tJPhR6Bdxy9z8PVdnHZ7s8FD2U
	yPiz/4MTptG9HCCMvz4JVzXhraF4T+jjPEHJJcMw3umCxRY9a6iXAMg==
X-Gm-Gg: ASbGncuGO1ttu4lTQ6FFZYaMgCNX9sPqSwsRqjVd2ETvyqnjFw7Un5nhg0x1aHG4x9v
	uEtsNOcGro/0gixo78nt98AYjL2W9l6r8TZDFr52zg1LQWeNyhtnF7pvNvECjrXWtrCEGyj2Hl+
	Q+CbccbjXOBYQeus/7rOOcUycLYw4O2muMk2bkTq57c6rvb1ySXHwAPggn+4jUiKyYlwenEuioX
	lYR7FvrMgDttSVeDMWl/ZuWvBZxOHNZkjnd1Y39WjirjhFZfodKdRJuP2ehc6oC0DAInqcU9Whd
	umW0grZ/qvlLMso23QI7vtVKk5TM/IvaIBagmiqVtw==
X-Received: by 2002:a05:6000:144f:b0:391:241d:a13e with SMTP id ffacd0b85a97d-39ee5b9f5b6mr4191463f8f.48.1744874784106;
        Thu, 17 Apr 2025 00:26:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX40ws3+eqraZDVy9FNzNzHM8/7zc1TFMhaZr7xBFr7xp/tveKs9AoQ1WnxQPtgH7HvwyHGw==
X-Received: by 2002:a05:6000:144f:b0:391:241d:a13e with SMTP id ffacd0b85a97d-39ee5b9f5b6mr4191442f8f.48.1744874783782;
        Thu, 17 Apr 2025 00:26:23 -0700 (PDT)
Received: from [192.168.88.253] (146-241-55-253.dyn.eolo.it. [146.241.55.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae96c03dsm18792656f8f.24.2025.04.17.00.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 00:26:23 -0700 (PDT)
Message-ID: <b1fa9607-f9bd-4feb-a22f-55453a9403e9@redhat.com>
Date: Thu, 17 Apr 2025 09:26:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/4] selftests: drv-net: Test that NAPI ID is
 non-zero
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 "open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)"
 <bpf@vger.kernel.org>
References: <20250417013301.39228-1-jdamato@fastly.com>
 <20250417013301.39228-5-jdamato@fastly.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250417013301.39228-5-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/25 3:32 AM, Joe Damato wrote:
> diff --git a/tools/testing/selftests/drivers/net/napi_id.py b/tools/testing/selftests/drivers/net/napi_id.py
> new file mode 100755
> index 000000000000..aee6f90be49b
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/napi_id.py
> @@ -0,0 +1,24 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +from lib.py import ksft_run, ksft_exit
> +from lib.py import ksft_eq, NetDrvEpEnv
> +from lib.py import bkg, cmd, rand_port, NetNSEnter
> +
> +def test_napi_id(cfg) -> None:
> +    port = rand_port()
> +    listen_cmd = f'{cfg.test_dir / "napi_id_helper"} {cfg.addr_v['4']} {port}'

Not really a full review, but this is apparently causing self-tests
failures:

# selftests: drivers/net: napi_id.py
#   File
"/home/virtme/testing-17/tools/testing/selftests/drivers/net/./napi_id.py",
line 10
#     listen_cmd = f'{cfg.test_dir / "napi_id_helper"} {cfg.addr_v['4']}
{port}'
#                                                                   ^
# SyntaxError: f-string: unmatched '['
not ok 1 selftests: drivers/net: napi_id.py # exit=1

the second "'" char is closing the python format string, truncating the
cfg.addr_v['4'] expression.

Please run the self test locally before the next submission, thanks!

/P


