Return-Path: <netdev+bounces-86170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F49189DD0E
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 16:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7022F1C21156
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 14:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E49757873;
	Tue,  9 Apr 2024 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvKs02Yg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962CCC139
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712673645; cv=none; b=OEnAVDedkANE0eUU2cahPIJw4ywLqgX+dtoPlcHUkogQFOAR2qWKZ+ewoEnbjeM5ervPRTuBWL0ZK7m1kELmxYeoFnZCIdm8mfhXXVLqo5Td8CUcsjR4Oe6/M4YO9C6BCx7/gLhbEO099rl23rlUNXj107OUMTZTUP/0Qy0mMc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712673645; c=relaxed/simple;
	bh=3OUCC3FZUTl/rt+qxJ7RgQNicPYwq+CFcKZXghoIBxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jz0OEd6rQ916eHpdssOq+6y7p7KEwEsvj3NbZB5rFztrndu2y1wjMgpmyReLw4VAYffLl1EUVOWKOBQOaxFYibGhZ8v6aXhDZKVpD/8eBzurQBpq43KWyyeUKqTkHAS1QCOTgMHWWS8t6WA832FQDWjKT4e4mjfwEzmyTz1QGXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvKs02Yg; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7d5db134badso132043939f.2
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 07:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712673642; x=1713278442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BAhfhJBQ3KuCQAwVFtPaFqwMIpUNSR4aVdjDu/jhZ0M=;
        b=ZvKs02Ygg6FixVE2tf1k41fQyraMB7YN7cTGzzMEf/m1fvIv+LeK3dLewr2jBkIa+S
         mxk/F3kmSUTgnA5jsEFuJgTKtGHBIceUWuOqpRy7XUiQUHnNvqLUNOXpxDy+ycbcRsOs
         jg/5xz1umbVZjjh3h2aFMYcuvdHhswUya4LTPuY66JPaaCv44RerIj8VWBuk+qQUhO79
         bMj4xb9FebgWU0JS18ZTxIYOOjaVxeggKYXmyQlO7J3/QuaceZzxIlWk1kFUG7XwKXW6
         3ggXau/R5lR2/Uf4gibgD15pJ8yyMP38Y/1Lzy+L0w6hYP2UqEG6RlK4kXo9iy25lqFF
         sf2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712673642; x=1713278442;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BAhfhJBQ3KuCQAwVFtPaFqwMIpUNSR4aVdjDu/jhZ0M=;
        b=L4cnCZJYkzClYhe9I/dSzf5HgEWwp9CNTzx0lXlObd0qEsFXV3Nuxruo8s2NIhQoKa
         CsW9UxmT/HMPcZHl348cFmPOTcoYEicNeZXj5Klf0BDSvZtwkqyQx4WnODdq0zrwe2nf
         dMH8HnWpb5xtapawzCvIZddFmy4IC6FuBz1zcglMNcBVfmACxxDkRxnOzfLX+oJPjAXS
         DdbIU/fM1nsuQi9TmbYrdXPf1RcDMOa1NwtAjsBvd8VDH6ibxshkbvbYtlWxe8f1RjQU
         wEeiB4C2QuolNAeK2G1oKhULpLIj6TqLQpj8JB9JlM2m2zUALePTFZFgzQf9Ing1cwkD
         46mg==
X-Forwarded-Encrypted: i=1; AJvYcCUSxfu/S3w63nCaDjxcLRoG8cLecFfozVmesyyAwxYqVg/YbXTtU4+N0i4LnQYEh/jSkaJ7JXbj+aNCAizNiui344xvHqTj
X-Gm-Message-State: AOJu0YxYV9JT+DY8KhH1AC9oKXYuIywadJYoJqOlnSZdR2wK4KJKV5a6
	Y4JF6yjfWX7U/Qp2ffY6dHypKjcctmD6ClWNrm4kEIQXfjFCzfadfqFQ8Wqf
X-Google-Smtp-Source: AGHT+IF1qSQbjZANAV+ocsYnzXLRclbAXbC4pxks+DflTaOzw5MSj55GnlVr2VHC/we08IrDlRVvjA==
X-Received: by 2002:a5d:8744:0:b0:7d0:8cff:cff3 with SMTP id k4-20020a5d8744000000b007d08cffcff3mr11590351iol.8.1712673642598;
        Tue, 09 Apr 2024 07:40:42 -0700 (PDT)
Received: from ?IPV6:2601:282:1e82:2350:6dd8:136a:4594:269? ([2601:282:1e82:2350:6dd8:136a:4594:269])
        by smtp.googlemail.com with ESMTPSA id o1-20020a05660213c100b007d609763041sm693791iov.5.2024.04.09.07.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 07:40:42 -0700 (PDT)
Message-ID: <63122565-b5a3-48d6-829e-2e2a3d5a1021@gmail.com>
Date: Tue, 9 Apr 2024 08:40:40 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: fib_rule_tests: Add VRF tests
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, liuhangbin@gmail.com, gnault@redhat.com,
 ssuryaextr@gmail.com
References: <20240409110816.2508498-1-idosch@nvidia.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20240409110816.2508498-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/9/24 5:08 AM, Ido Schimmel wrote:
> After commit 40867d74c374 ("net: Add l3mdev index to flow struct and
> avoid oif reset for port devices") it is possible to configure FIB rules
> that match on iif / oif being a l3mdev port. It was not possible before
> as these parameters were reset to the ifindex of the l3mdev device
> itself prior to the FIB rules lookup.
> 
> Add tests that cover this functionality as it does not seem to be
> covered by existing ones and I am aware of at least one user that needs
> this functionality in addition to the one mentioned in [1].
> 
> Reuse the existing FIB rules tests by simply configuring a VRF prior to
> the test and removing it afterwards. Differentiate the output of the
> non-VRF tests from the VRF tests by appending "(VRF)" to the test name
> if a l3mdev FIB rule is present.
> 
> Verified that these tests do fail on kernel 5.15.y which does not
> include the previously mentioned commit:
> 
>  # ./fib_rule_tests.sh -t fib_rule6_vrf
>  [...]
>      TEST: rule6 check: oif redirect to table (VRF)                      [FAIL]
>  [...]
>      TEST: rule6 check: iif redirect to table (VRF)                      [FAIL]
> 
>  # ./fib_rule_tests.sh -t fib_rule4_vrf
>  [...]
>      TEST: rule4 check: oif redirect to table (VRF)                      [FAIL]
>  [...]
>      TEST: rule4 check: iif redirect to table (VRF)                      [FAIL]
> 
> [1] https://lore.kernel.org/netdev/20200922131122.GB1601@ICIPI.localdomain/
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  tools/testing/selftests/net/fib_rule_tests.sh | 46 +++++++++++++++++--
>  1 file changed, 43 insertions(+), 3 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>

Thanks, Ido.


