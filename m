Return-Path: <netdev+bounces-194144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F59AC7752
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 06:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 680C41BA00F9
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 04:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8EE2512E5;
	Thu, 29 May 2025 04:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgZxjl3S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17881D5CFE
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 04:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748494164; cv=none; b=EbKMqO8WFlb4QuxPUAYSpAsaFKCAhR4BpjdN8TyqqbWCpsEKMOh4Av+jVHJ0bHYpbUf4mozMzTgixqfrAPKaVXg+zuAUJQG8YK7rVsURojxVVhVo7hsdq+90hG609fWMDjI9pydRRR2Lizam3gqVTYxDB0l07gtqp/J6js7HY7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748494164; c=relaxed/simple;
	bh=KuIyapUJOtw3Yf1WElONkoBSM/dkSF+iqc1V+0HiFeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fwUK+oX/Z6kzg4MuyTAQH6R0rAlIC6con4KgrOyuhJa9srTRtbjc+8iYMjA6CbIPhIEzdNmPYnFcm4EHv8t6s9edu9ocFarYxshwtN/b57nnXquEIqw5ppISvxRyPgnOz9ydgIzHmLogJd5ObL62dq+uA4+VYXU/KcEQrca6rKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgZxjl3S; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-742b614581dso430371b3a.3
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 21:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748494162; x=1749098962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KTgJbCERSHdgIE7+4s3Qkj0l29r+g1ZPn6a/TqEhts4=;
        b=DgZxjl3SZXvIuE3n3g1dOyoHweEULmjVadtQe+NJtEro5Dt27DZSBhMGiuGY1i/plz
         hZFop1e2VW1W5/QwKcljGqMxySpGn25cWP9eAPTDgZrQYrSWk72nlihGX6JfPTWJr1YV
         Uql9PNK4nT+0tOwpoA5qKJsjdfVXF2mIAZF3vNF9HRNvUqWrahACI2rFqHFs38OcRCZW
         ddhGVhhbE6aatVTBwBbZr+QmxRRf4wWKbX06Vq3dm2VBt4r19i9tEVjVdpek7zkpzY9u
         QlHEQkk0I3SfjAkMEewMfldd8xsK7ZyM4q+qp9e2Ufa5ZdroyYPlDmLfoV+bLvpNysmg
         X8uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748494162; x=1749098962;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KTgJbCERSHdgIE7+4s3Qkj0l29r+g1ZPn6a/TqEhts4=;
        b=V7S2IVSTYDYjvL/30hYxCX58miFuP6xPewLOa6l3JU1Ko3x0znqotII7k55QVWpDzB
         fD3Cy+7gfqI0SXEVGJdAcpmNbYyBfqMAQ2NTLiTd0M54DsX8zHxOytV+Tc5berr6wJV8
         HVHhXCCK2cE8fF1LUXEhB8Tt4EwBUMEeEeKip9S/4u8LRvF+ABNTNJF+5k/N38sWQCR3
         5938gySN1ziITwjif+59aGLlpvPcQZC9NyHE/WXfVq11p1O6JNk75vzhZq0F5NPLCNiM
         kIVEiQfuNNA1A24ArPJt1X17lfX/v0FF1RUznJWjZGGfpL2UgNLsMYsYR5D5bQ5Uy0Tv
         9wTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeyXTeOTXBUp0qcphdMoxyUYyACL1p4lhmhELPTds1cOrlGxCLcGqirvJfFNxG8AAAvsPvzJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo6ECDZ0wTbvlKhr50JmEkCWIto2NjGvs27ThXrlVQqB/5PFvF
	w2aQpt+KPSDyD21lnq3L0otnk4Bdc9tLwZ0TNEXjyj7Z0eskLapcEPIl
X-Gm-Gg: ASbGncv+fBw8JvuQ/JwsSxnd/9a8jKRiN6XFEXjzR029wDSB60rGrTi9qsM1TePpZ7l
	FedAM+kzlQ9HuITAitjFWR3F6EwRC00aXtdvno0sY/bLcIihSPb5L1yg255MfDtLWvlr8zx2ozl
	3W8+TN4s80qUhizjPFui8PkOOPYNGmhOADtlMlToCk42oqsvkLN3MLWL3Jxy5NiHriv88rKgpFF
	h4eVpU71HNQYAGqU8C61OoR1M6pu9zrmwM4oeg6kSc84ZdEhNPcRdk+1lZXUDlN+um2DRQEGvkB
	RWkL9BO20GFYOO3y/mI8D+w4YZ6itiBnnuywkRhNlPmNKT4za+VdZEwOyZfu/cO5Z+59pmxbzs6
	tvGLHnynrRA5phsXgQwQ4Bjk+q/Hnk42Uj8BopQ==
X-Google-Smtp-Source: AGHT+IGJUq/3x6zmGN2r4k3qEc9eVrk5tWOyUsZncH3eedaLv36DBIitp/2O4+32DfIKRfvtSCqUew==
X-Received: by 2002:a05:6a00:b89:b0:747:a049:d570 with SMTP id d2e1a72fcca58-747a049d761mr5876457b3a.10.1748494162056;
        Wed, 28 May 2025 21:49:22 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:76aa:9d32:607:b042? ([2001:ee0:4f0e:fb30:76aa:9d32:607:b042])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afff7e3bsm463894b3a.175.2025.05.28.21.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 21:49:21 -0700 (PDT)
Message-ID: <0b86612e-591b-46c3-adbe-538a1f1b0cba@gmail.com>
Date: Thu, 29 May 2025 11:49:17 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [selftests] 59dd07db92:
 kernel-selftests.drivers/net.queues.py.fail
To: Philip Li <philip.li@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
 kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org
References: <202505281004.6c3d0188-lkp@intel.com>
 <0bcbab9b-79c7-4396-8eb4-4ca3ebe274bc@gmail.com>
 <20250528175811.5ff14ab0@kernel.org>
 <bf24709c-41a0-4975-98cd-651181d33b75@gmail.com> <aDfiTYmW1mHBEjg6@rli9-mobl>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <aDfiTYmW1mHBEjg6@rli9-mobl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/25 11:27, Philip Li wrote:
> On Thu, May 29, 2025 at 11:06:17AM +0700, Bui Quang Minh wrote:
>> On 5/29/25 07:58, Jakub Kicinski wrote:
>>> On Wed, 28 May 2025 15:43:17 +0700 Bui Quang Minh wrote:
>>>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>>>> the same patch/commit), kindly add following tags
>>>>> | Reported-by: kernel test robot <oliver.sang@intel.com>
>>>>> | Closes: https://lore.kernel.org/oe-lkp/202505281004.6c3d0188-lkp@intel.com
>>>>>
>>>>>
>>>>>
>>>>> # timeout set to 300
>>>>> # selftests: drivers/net: queues.py
>>>>> # TAP version 13
>>>>> # 1..4
>>>>> # ok 1 queues.get_queues
>>>>> # ok 2 queues.addremove_queues
>>>>> # ok 3 queues.check_down
>>>>> # # Exception| Traceback (most recent call last):
>>>>> # # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-59dd07db92c166ca3947d2a1bf548d57b7f03316/tools/testing/selftests/net/lib/py/ksft.py", line 223, in ksft_run
>>>>> # # Exception|     case(*args)
>>>>> # # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-59dd07db92c166ca3947d2a1bf548d57b7f03316/tools/testing/selftests/drivers/net/./queues.py", line 33, in check_xsk
>>>>> # # Exception|     raise KsftFailEx('unable to create AF_XDP socket')
>>>>> # # Exception| net.lib.py.ksft.KsftFailEx: unable to create AF_XDP socket
>>>>> # not ok 4 queues.check_xsk
>>>>> # # Totals: pass:3 fail:1 xfail:0 xpass:0 skip:0 error:0
>>>>> not ok 7 selftests: drivers/net: queues.py # exit=1
>>>>>
>>>>>
>>>>>
>>>>> The kernel config and materials to reproduce are available at:
>>>>> https://download.01.org/0day-ci/archive/20250528/202505281004.6c3d0188-lkp@intel.com
>>>> Looking at the log file, it seems like the xdp_helper in net/lib is not
>>>> compiled so calling this helper from the test fails. There is similar
>>>> failures where xdp_dummy.bpf.o in net/lib is not compiled either.
>>>>
>>>> Error opening object
>>>> /usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-59dd07db92c166ca3947d2a1bf548d57b7f03316/tools/testing/selftests/net/lib/xdp_dummy.bpf.o:
>>>> No such file or directory
>>>>
>>>> I'm still not sure what the root cause is. On my machine, these files
>>>> are compiled correctly.
>>> Same here. The get built and installed correctly for me.
>>> Oliver Sang, how does LKP build the selftests? I've looked at the
>>> artifacts and your repo for 10min, I can't find it.
>>> The net/lib has a slightly special way of getting included, maybe
>>> something goes wrong with that.
>> I understand why now. Normally, this command is used to run test
>> pwd: tools/testing/selftests
>> make TARGETS="drivers/net" run_tests
>>
>> The LKP instead runs this
>> make quicktest=1 run_tests -C drivers/net
>>
>> So the Makefile in tools/testing/selftests is not triggered and net/lib is
>> not included either.
> hi Jakub and Quang Minh, sorry for the false positive report. And thanks for
> helping root cause the issue in LKP side. We will fix the bot asap to avoid
> missing the required dependencies during the kselftest.

I've created a pull request, please help me to review it: 
https://github.com/intel/lkp-tests/pull/514.

Thanks,
Quang Minh.



