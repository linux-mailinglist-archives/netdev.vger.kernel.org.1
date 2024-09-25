Return-Path: <netdev+bounces-129809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9618D986505
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 18:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C66F91C217D2
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 16:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476BB5336B;
	Wed, 25 Sep 2024 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cIkU1HrO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECEF13CAA5
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727282485; cv=none; b=FL6vSfXh8bfX30XOnfEbnA3wGJoTJLDWez0VMYe3tGG6mf+ztyWFbzyO1JdrosdwfN6Qw8ma7LgywZuGCZmPCWkMJapvcUBjJpmm8GWiUGRmeSnR7sgx/jI4fILnxSCrZpNg715tmHDmtbxjRa7SuPE4878cT5c0JCIon6JUQYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727282485; c=relaxed/simple;
	bh=PI67tLirlz221GqZjEYs9n3s8qaQlx8hfCr23HTlcm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XyHgLiX9Og61QTqGGrzicesnmjKCaCmkEkjk549spydt3l3UDYi4yF7BPaKcru/muF5p1FaTySwCC0i+XBNChl0g3wROTqFeJA4U3Sm/+I+GR6JegzWHrc7SvzRf/wrNaIq8Fh2WijbvhY5mmpF5FmNYWjAA0mnqOnZcq4vrJ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cIkU1HrO; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e28ac7b12bso67909b6e.3
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 09:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727282482; x=1727887282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ooWKkaH8UA51S7NKCStf2gXeN7ic3yySCOlAB9zd8A=;
        b=cIkU1HrOEtjVGDPshVSdsT6rSNS0sMD6xZVk5OvU9L5BdUw5iAqTVtklXvA0HyHn9N
         gFthYUMf8ecP54K1fbCXasO2BKcNb7qLTg1F/7SrjRqyTXKhXXPxB+VPqTctcJNVRIhk
         C5fExHjkS8XmQKBBC7OJbvtt+2RyhFAxMpFLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727282482; x=1727887282;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ooWKkaH8UA51S7NKCStf2gXeN7ic3yySCOlAB9zd8A=;
        b=eFqblyu6G7dSjF47v4DKgxkjRHbesYRthz5VUhzOkBRd4uWEwVuWjkOPe7icJrDzeF
         OZvPVBh4t9nozP0Ew/M3osFcU2xdKL6H2D2AxeAZrmrJb7ZuiMKeQE3hKsbvyYwswF70
         VmZmomEH6gs8M0KL+KYSHXOfelg1hO9q1sI4pDFQePob1T96SdzdFoo1nXOGW45mdSm/
         /WWpQyw+kCgDTej1j2exp/zd7VCiOtQTSQtEU2ulzg4OcHA5tyKxZOGfzMgLue1dd38O
         GdqlOe6ZJ+S8581c4loii+yHWlbC4FItvKPWKMqvgup8JQsQFQ28k1XV6L6JGPH1jRO6
         ncgw==
X-Forwarded-Encrypted: i=1; AJvYcCXp8Nkcv9Vw5ngZmsG51UFMYnN3uQazX3+KbezX2O3aM7q4KRCzkG7gfUhW9WBhe/YYxWhsh+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQErNV08wNvilNsh9Wjwo+2CjCvgJUf7wFUaJTxQscx20qlFRM
	TIjWLfF3PzVqHRStCM2xpwiUa7XBjgnvzJqrAnleAskeRsITtA/Zyr65aSmE7Js=
X-Google-Smtp-Source: AGHT+IEu+wsD5M8hLLJhawisq6UBLFx5/tPt56xJ6tx3Ztxg/IR/TZ9MyYAirmSPX4RgkZwIftpF1A==
X-Received: by 2002:a05:6871:e01a:b0:27c:df8c:8dac with SMTP id 586e51a60fabf-286e13655e6mr2784227fac.13.1727282482594;
        Wed, 25 Sep 2024 09:41:22 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-283afabfcffsm1399050fac.58.2024.09.25.09.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 09:41:21 -0700 (PDT)
Message-ID: <62f52cb9-1173-46aa-96a0-d48de011fdc2@linuxfoundation.org>
Date: Wed, 25 Sep 2024 10:41:20 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] selftests: add unshare_test and msg_oob to
 gitignore
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Allison Henderson <allison.henderson@oracle.com>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-mm@kvack.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240925-selftests-gitignore-v2-0-bbbbdef21959@gmail.com>
 <20240925-selftests-gitignore-v2-1-bbbbdef21959@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240925-selftests-gitignore-v2-1-bbbbdef21959@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/24 06:23, Javier Carrasco wrote:
> These executables are missing from their corresponding gitignore files.
> Add them to the lists.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>   tools/testing/selftests/core/.gitignore | 1 +
>   tools/testing/selftests/net/.gitignore  | 1 +
>   2 files changed, 2 insertions(+)
> 

Can you split these into two patches. It will be easier
for the net patch to go through the net tree.

I take the core changes through my tree. net changes go
through net tree.

Also helps avoid any future merge conflicts if new tests
get added to net

> diff --git a/tools/testing/selftests/core/.gitignore b/tools/testing/selftests/core/.gitignore
> index 6e6712ce5817..7999361992aa 100644
> --- a/tools/testing/selftests/core/.gitignore
> +++ b/tools/testing/selftests/core/.gitignore
> @@ -1 +1,2 @@
>   close_range_test
> +unshare_test
> diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
> index 1c04c780db66..9dcdff533414 100644
> --- a/tools/testing/selftests/net/.gitignore
> +++ b/tools/testing/selftests/net/.gitignore
> @@ -17,6 +17,7 @@ ipv6_flowlabel
>   ipv6_flowlabel_mgr
>   log.txt
>   msg_zerocopy
> +msg_oob
>   ncdevmem
>   nettest
>   psock_fanout
> 

thanks,
-- Shuah

