Return-Path: <netdev+bounces-194138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5739FAC76F0
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 06:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FDA47AEE7B
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 04:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD7E1EF36E;
	Thu, 29 May 2025 04:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luibVPOt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD9810785
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 04:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748491584; cv=none; b=eMTPFU8JeOGHuQat7aCfcLVZxEIR7xTNOMWqAUy773NnUP6GtnC9s8D5kbdCsGjWmaqqFweNMzHoDpjsDWbGcgHatahRty0zSvdUPWErKskmIl4fKPEIVz2XpLem/SF+cVS4i/HKxRD1mniDJ9c+soTlafEBZlkW29MwcqgM+0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748491584; c=relaxed/simple;
	bh=TF3rbKEr7u8TwhjkYuhhiy3ax+5w+OH9QRtAVzF7xco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nqkgQw0UjhLHdxadH8C4P+3KGYwwJsYm2sLwBU1jYB9pcIFuXoemKdC1sRRyp+9sYpHpaJ/jsHxK8RTLOuLP1iRMoCZN44H92jpW6CgoWNw9rPDqKG7sAnonOUjfBhIgksdUxSVudemqeQEu/gUjsszDOjk8E+I8f+Z62PKSYKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luibVPOt; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7376e311086so397450b3a.3
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 21:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748491582; x=1749096382; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=en1TuzA2jcDXl6/d8Wq7yY92hh5djDIHVZnzRgKkq4I=;
        b=luibVPOtbP35VYBi6PKFgXKNQoPP1BkqKOKbc5PjkztjYjhwEsUIHBu+NX8snLb7Cx
         hwAR1EwN4qp+ZaiaIk+R/tNTEtc9AFNoAk9ltnQaZ0hy1O4Z69PAAV0smNn0dIDKKTjr
         N6Q1MyfHz57Ge3t1SeMulY8WkEkddc6QlyG8gpknDfsZdZY6nxihlYPDz2FTquCWE7pj
         G+45soIiUsLMuNL2kJCGg6HjrSU7ULhU9cHYUSxiGJm2LR+CFEjyXUAtzvDXj91NjlA3
         2Kb/qQVPdtBOd9xBvWfi4kLJWrLmhvOIqrvl4hua/gA1MEkiEvKviMfQ3R+MPnLY48EA
         eZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748491582; x=1749096382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=en1TuzA2jcDXl6/d8Wq7yY92hh5djDIHVZnzRgKkq4I=;
        b=HFGDESJevKPCUEKmDNtkm+qzYM0X7LSYV8JVObPuUO4cK6QYJpE6oWkDtBRtjIFlsw
         JNvN1kOD9TQfWmAllffBy61K22RWpsrWUKvOAGKCGArG83vCQHH8J43Iu16PuPiL0amU
         1I+yR0rv8FOmCtFLNVmJnYrRjvpGxF4BPfh6SqOza/dK5TKJ48QfxpBaDCp0R8hJcSac
         y0nju3SNeJJXi7iM2gfglbE1eHsua9pJu7lOsP2HXhk1WxkpUI/r1QpFyIIdcr8aS36M
         qKWS6g4ofVNYO+HdxswhtU9ejm869XaGNX7G5cw3+JAaqa5iAbn5SjDQh40YE0p3i7LY
         tv1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfnsu8bYaijfCxtblFEkSEKlzWty6AH4MPdNfuVD6pXMRQXbhbzr0NqcqEf1xngafeEWei5hI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUt59Xt3CJzrVWiv6chkHD08EXLZBN91b11sEUseAwl9wovPyN
	qOV7iaNNgOx4qOQVWdIDJUu4guD7VcYyPuSqIB1CJoxhx+vg/RnQfpJN
X-Gm-Gg: ASbGnctVAynmoEWnI+QojgQInoBksabLTqlnbMh33Ygi94SYsVOtPuuUr2ju8m0iI07
	HySo6RR35u1KbBrLKHEtbVD2V71PffsKGvZ6P7HTBV0Wh+4eZfp7ApBwmgi7MJBYARUNtdVCnhL
	6PIma0QlvVDwZZCB1iY+GcNc5Jd+wjCZd2nScBWGExnTGMB+SyaX1Vm6uQ6pUA5gG0vTV8ljgYk
	Dvk4ekzNOKEQrKYZwxgKmW+ohQ6Ki8MdIcEYnoW/GySuY6nzDkHVtDdveNL9uBKi+latcgEhF8H
	Enj2HTFCfF+NSAqSf/EmJcahsw+qIFhUiXFlCyAl8SSEYK8ivgKv5awGXklskNTe2socpp3DPsL
	gYihswI9BcxSM+fWpE052oUK8YkQ=
X-Google-Smtp-Source: AGHT+IGAJwA5Vw2P7enkBsL7PjKwvi8TvszQaTChXH2WOuL99LPZ256zzf6KFJ70blpyA9/DySgTBQ==
X-Received: by 2002:a05:6a00:22cd:b0:73e:970:731 with SMTP id d2e1a72fcca58-745fe035f23mr26544577b3a.16.1748491581701;
        Wed, 28 May 2025 21:06:21 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:76aa:9d32:607:b042? ([2001:ee0:4f0e:fb30:76aa:9d32:607:b042])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affafa42sm406123b3a.92.2025.05.28.21.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 21:06:21 -0700 (PDT)
Message-ID: <bf24709c-41a0-4975-98cd-651181d33b75@gmail.com>
Date: Thu, 29 May 2025 11:06:17 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [selftests] 59dd07db92:
 kernel-selftests.drivers/net.queues.py.fail
To: Jakub Kicinski <kuba@kernel.org>,
 kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, "Michael S. Tsirkin"
 <mst@redhat.com>, netdev@vger.kernel.org
References: <202505281004.6c3d0188-lkp@intel.com>
 <0bcbab9b-79c7-4396-8eb4-4ca3ebe274bc@gmail.com>
 <20250528175811.5ff14ab0@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20250528175811.5ff14ab0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/25 07:58, Jakub Kicinski wrote:
> On Wed, 28 May 2025 15:43:17 +0700 Bui Quang Minh wrote:
>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <oliver.sang@intel.com>
>>> | Closes: https://lore.kernel.org/oe-lkp/202505281004.6c3d0188-lkp@intel.com
>>>
>>>
>>>
>>> # timeout set to 300
>>> # selftests: drivers/net: queues.py
>>> # TAP version 13
>>> # 1..4
>>> # ok 1 queues.get_queues
>>> # ok 2 queues.addremove_queues
>>> # ok 3 queues.check_down
>>> # # Exception| Traceback (most recent call last):
>>> # # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-59dd07db92c166ca3947d2a1bf548d57b7f03316/tools/testing/selftests/net/lib/py/ksft.py", line 223, in ksft_run
>>> # # Exception|     case(*args)
>>> # # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-59dd07db92c166ca3947d2a1bf548d57b7f03316/tools/testing/selftests/drivers/net/./queues.py", line 33, in check_xsk
>>> # # Exception|     raise KsftFailEx('unable to create AF_XDP socket')
>>> # # Exception| net.lib.py.ksft.KsftFailEx: unable to create AF_XDP socket
>>> # not ok 4 queues.check_xsk
>>> # # Totals: pass:3 fail:1 xfail:0 xpass:0 skip:0 error:0
>>> not ok 7 selftests: drivers/net: queues.py # exit=1
>>>
>>>
>>>
>>> The kernel config and materials to reproduce are available at:
>>> https://download.01.org/0day-ci/archive/20250528/202505281004.6c3d0188-lkp@intel.com
>> Looking at the log file, it seems like the xdp_helper in net/lib is not
>> compiled so calling this helper from the test fails. There is similar
>> failures where xdp_dummy.bpf.o in net/lib is not compiled either.
>>
>> Error opening object
>> /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-59dd07db92c166ca3947d2a1bf548d57b7f03316/tools/testing/selftests/net/lib/xdp_dummy.bpf.o:
>> No such file or directory
>>
>> I'm still not sure what the root cause is. On my machine, these files
>> are compiled correctly.
> Same here. The get built and installed correctly for me.
> Oliver Sang, how does LKP build the selftests? I've looked at the
> artifacts and your repo for 10min, I can't find it.
> The net/lib has a slightly special way of getting included, maybe
> something goes wrong with that.

I understand why now. Normally, this command is used to run test
pwd: tools/testing/selftests
make TARGETS="drivers/net" run_tests

The LKP instead runs this
make quicktest=1 run_tests -C drivers/net

So the Makefile in tools/testing/selftests is not triggered and net/lib 
is not included either.

Thanks,
Quang Minh.



