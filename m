Return-Path: <netdev+bounces-84207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C35F89608D
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 02:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7451F23F54
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 00:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93A446BA;
	Wed,  3 Apr 2024 00:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="U1ptod+k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470AC36C
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 00:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712103338; cv=none; b=BhYLy5aNQ2Rs7N9Ql4AhgpKe2oqjyqW4U0ogftPiH9MPeUf2IhEYGEWkFJICIMUVB2as3neAKUGWEnRHxU6/TmFFhVTRQDNtLLz9D/uSMRXKvobK6DD13jGCSQ95BiN4HWm7ADsYKnlS595i/Wjn5bFrzuBUTQEtRLbTIaJC674=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712103338; c=relaxed/simple;
	bh=LPCkjeRWMWWSeeJOeB2h2H7o2AvbMa0PqbIjbluyxKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SXJuq+KgHnw2HQckhFLSOgZUMp8JSE2150HDb6HyiwEPPcY7FNFYRE48zube69TAatFEJ7rRPE15LT17eT6e8k3iMMShu87DwRiFiOaKK035ofAgLhgIJ1csyaFY8we+T4bwI6hx/R7A9Vgjb/P33hbbnE4WhfFERv/1wE9nfEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=U1ptod+k; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so4585122a12.0
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 17:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1712103335; x=1712708135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pM00jwZmYNO3tMEKktR01JogzF+1t+O98oYD6goaZiM=;
        b=U1ptod+kaM0QL8GYcBK8HO68TbWrTzBvzfZ9pwr7lC/9fLo7ypR8xSlF0IFB3yv30f
         8krMqmYN1l4epDsiSHkxnpAs9KWJCFTxrV0HFEvhq4YuF8AEmC5Ur5sKciwu1Vtcj7XC
         dK18B5S7OX1BbEI1UYe0cGD9S93V869ITQyb1IcErXKJmZ7O35zNb+C8k9tCd+m9DeRD
         rqK3QTLqmFBBvjsCBLB9aBTwyK0UBhDrc13h5HLi6lIOzvJwR4+MPqC00ykEeuEZhJYl
         GJa4VGOKAHVzRRmK5EU+cYU0zcJawQGgqjDxcZ8FxHiDfjwCOy7bzfN/VX+whJg5XCt7
         7itA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712103335; x=1712708135;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pM00jwZmYNO3tMEKktR01JogzF+1t+O98oYD6goaZiM=;
        b=qpJMfa6A/HwIPt0KOnUEoUbafKIVnKL4uL00dAoigymw8Ewl8wD4zYNS6NOgvobNZD
         fmFqstKqGKsxndMlLCRFnugEdYwI78ufq+Hq/jAr5xmogdK25+Qzxnq1U0Qag/TY4Smi
         bRqHT3hKQty4ToDKQsHfdtknqQhlcvh04kNTmyNZZq/3t1h63pXtgTrUBUpSvzRvwVOJ
         8rntpAfpE9gkp6F28Cl2tLWu98HkSCP0XtQbKm3hMVKByJTtRlJcisgymAFeXeGxhyIK
         s4NcLgSrpKE1V7tQZDKn2drbsPtqhHaUOtZuiUDyuk1YN2zvqm9nwgi5ofwax+ej+kXY
         wMNQ==
X-Gm-Message-State: AOJu0YwKZ8xx6WpDwcbxGIfj38OlSu3+0DIjL95+Rx+CD5Y/mrvjF+3b
	UzTu7KF/cqX8XRtfM8703rJEasqoJfs0fdreR9AWKoyPwlw6DD9Mx55qwcY5iaY=
X-Google-Smtp-Source: AGHT+IGk3TSX8HHpaTJFm0NNp0U3b98ZljZPvAasLFxFq+z6hp2s4c96oHv6jcmaANjVHD83+Wv16w==
X-Received: by 2002:a17:90a:ea0b:b0:2a1:2506:b937 with SMTP id w11-20020a17090aea0b00b002a12506b937mr1307605pjy.23.1712103335346;
        Tue, 02 Apr 2024 17:15:35 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:1cbd:da2b:a9f2:881? ([2620:10d:c090:500::7:f97b])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090ac40400b0029f8d8db93esm12493723pjt.19.2024.04.02.17.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 17:15:35 -0700 (PDT)
Message-ID: <fd8a7bc9-4eb9-4898-be79-ab8d3af28ce7@davidwei.uk>
Date: Tue, 2 Apr 2024 17:15:32 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/7] selftests: nl_netdev: add a trivial Netlink
 netdev test
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 shuah@kernel.org, sdf@google.com, donald.hunter@gmail.com,
 linux-kselftest@vger.kernel.org, petrm@nvidia.com
References: <20240402010520.1209517-1-kuba@kernel.org>
 <20240402010520.1209517-5-kuba@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240402010520.1209517-5-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-04-01 18:05, Jakub Kicinski wrote:
> Add a trivial test using YNL.
> 
>   $ ./tools/testing/selftests/net/nl_netdev.py
>   KTAP version 1
>   1..2
>   ok 1 nl_netdev.empty_check
>   ok 2 nl_netdev.lo_check
> 
> Instantiate the family once, it takes longer than the test itself.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/net/Makefile     |  1 +
>  tools/testing/selftests/net/nl_netdev.py | 24 ++++++++++++++++++++++++
>  2 files changed, 25 insertions(+)
>  create mode 100755 tools/testing/selftests/net/nl_netdev.py
> 
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index cb418a2346bc..5e34c93aa51b 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -34,6 +34,7 @@ TEST_PROGS += gre_gso.sh
>  TEST_PROGS += cmsg_so_mark.sh
>  TEST_PROGS += cmsg_time.sh cmsg_ipv6.sh
>  TEST_PROGS += netns-name.sh
> +TEST_PROGS += nl_netdev.py
>  TEST_PROGS += srv6_end_dt46_l3vpn_test.sh
>  TEST_PROGS += srv6_end_dt4_l3vpn_test.sh
>  TEST_PROGS += srv6_end_dt6_l3vpn_test.sh
> diff --git a/tools/testing/selftests/net/nl_netdev.py b/tools/testing/selftests/net/nl_netdev.py
> new file mode 100755
> index 000000000000..40a59857f984
> --- /dev/null
> +++ b/tools/testing/selftests/net/nl_netdev.py
> @@ -0,0 +1,24 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +from lib.py import ksft_run, ksft_pr, ksft_eq, ksft_ge, NetdevFamily
> +
> +
> +nf = NetdevFamily()
> +
> +
> +def empty_check() -> None:
> +    global nf

I know you're rolling your own instead of using unittest or pytest. How
about adding a Test class of some sort and make each test case a method?
Then you wouldn't need to do this for each test case.

Also it would allow you to share some base functionality across
different test suites.

> +    devs = nf.dev_get({}, dump=True)
> +    ksft_ge(len(devs), 1)
> +
> +
> +def lo_check() -> None:
> +    global nf
> +    lo_info = nf.dev_get({"ifindex": 1})
> +    ksft_eq(len(lo_info['xdp-features']), 0)
> +    ksft_eq(len(lo_info['xdp-rx-metadata-features']), 0)
> +
> +
> +if __name__ == "__main__":
> +    ksft_run([empty_check, lo_check])

