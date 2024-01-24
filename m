Return-Path: <netdev+bounces-65552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A65E383B04F
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 18:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190E31F23991
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 17:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D10481AC8;
	Wed, 24 Jan 2024 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="kWaJ5OPD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465ED8120E
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118381; cv=none; b=D1Xif7DkGdp/FgPjqoU4bWqY883hpayZm8LZQXAriRiY+ltMe8hI3UUW6VrLkZpOBbUKFIdeSfG6MzH6PEWPlG3NMuhP2B65T0jg+zZsTk+BOA2HRXje0GKXm5srEc1vpO5J/ebkc9ciWdZ4bt1/TqPPif7f6awK/s75kJml9YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118381; c=relaxed/simple;
	bh=rx8lKKZcE3A1/FLTzYEVMlsLvAtjy/Y784aKerx64Ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2Af3gMYe8+kOzL6BlkUx9AIIW36mmkhEngIiqVp3vxuIoheWYPoVQq5yVRd9QZhy/1ETAYZmFtm1uKlOkp+xmwhCuF3+qffsF6H4vUNxLTF3D8Oof5EtMOUjSs8ObPZy+jHSzkZc64NcLjZGHHqPdQ4LBaQK4dCHurafN94Ra8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=kWaJ5OPD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e7e2e04f0so63128505e9.1
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 09:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1706118377; x=1706723177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eVCU/WWHCSDI7BYE4p1QCv3tn8rHzFU9AC6i2z5h3qE=;
        b=kWaJ5OPD8SWrPQNFWepde48nJ3rr7QNB5TTRhyPau0Hzz3/iFmfcn/mMWPVy3JYDuh
         iD4mCt7zW3M0UUHhr7sbRct9Aekarntzc/UlEMInZtHgjzDFgf0diskPME6cctQasXx/
         6uBZ2JQVnXqqTurTCZuJzDM7HIbkzfnZ5YlyF+McBEWroB7biM2kGvHsDRleO1wqVksJ
         kS0B/jzLusmgcckI258iJU4zv2OA9AVrTVFap/AkaSORK6ORhWWXS0QwwvNbJcnlS0jd
         9oGnpqK2Ab9/vgveCStQia7rNnorHnGfFZej9cAPccihoG62wgkbA3bQLIFGKmw+lY0a
         j5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706118377; x=1706723177;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eVCU/WWHCSDI7BYE4p1QCv3tn8rHzFU9AC6i2z5h3qE=;
        b=Za5H2TeNNkrAZFgV+i6msTeICyM3LPek4S8l/51Xp0byoY5vLDyaQ8RgJe05cdcBeC
         /3TZDOxqij/WyFVI4Vxx8Do6YHi/wj4K/RRtO93rk2uXKd4/AGQkcTyeTXgfWyia570w
         NB1UJFob8eD7wt4RYpG7qAqtZ9ifGdJ4gZn4xUkiK5W03FsQuZRKkEE/Ibp+PUSbaUMc
         z35Hqfl3pK8H+8BMfrS3d23R2Sq6NHVYMDoink6V+u75bkHO8zDeO/uPt5UJAKQmxk7W
         Psab10N6XabeFsoG6/JparA4V7tYW9fxEFFX1txqrf1cde+0rISygGc0Sa38IC4E6Rwa
         LaMA==
X-Gm-Message-State: AOJu0Yy4SP1i2GYm5cXIavUB1BinhZZYt8mZ/35Y9Zj35XaLfoAg4nWl
	bMcSSfj4UtYZqjQIolNiu6lCN/+VDuBHfH2YEl9Ogx6o+TA9a8SOSicZvTfe2Q==
X-Google-Smtp-Source: AGHT+IEkmMRSyW5Nf156YVrdFBl3DnSZXbv256Xf9R4g4JKrV5a1JNhJ61YPNG9vJ0fA/sMCWjitww==
X-Received: by 2002:a05:600c:4e49:b0:40e:c59d:95ef with SMTP id e9-20020a05600c4e4900b0040ec59d95efmr833207wmq.149.1706118377430;
        Wed, 24 Jan 2024 09:46:17 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id bi11-20020a05600c3d8b00b0040e6b0a1bc1sm356339wmb.12.2024.01.24.09.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 09:46:16 -0800 (PST)
Message-ID: <1ad64e3d-5252-4aaf-82be-5162edd1e781@arista.com>
Date: Wed, 24 Jan 2024 17:46:10 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] selftests/net: A couple of typos fixes in
 key-management test
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>,
 Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240118-tcp-ao-test-key-mgmt-v1-0-3583ca147113@arista.com>
 <20240118085129.6313054b@kernel.org>
 <358faa27-3ea3-4e63-a76f-7b5deeed756d@arista.com>
 <20240118091327.173f3cb0@kernel.org>
 <a9a5378d-c908-4a83-a63d-3e9928733a3d@arista.com>
 <20240124071229.6a7262cc@kernel.org>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <20240124071229.6a7262cc@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jakub,

On 1/24/24 15:12, Jakub Kicinski wrote:
> On Fri, 19 Jan 2024 18:39:14 +0000 Dmitry Safonov wrote:
>>> You probably want something smaller to be honest.
>>> tools/testing/selftests/net/config has a lot of stuff in it 
>>> and it's actually missing a lot more. I'm working thru adding
>>> the missing options to tools/testing/selftests/net/config 
>>> right now so far I got:  
>>
>> Thanks!
>>
>> I'll send a patch for it in version 2 (as I anyway need to address
>> Simon's feedback).
> 
> Hi Dmitry!
> 
> I put TCP_AO and VETH in the config and the tests seem to fail with

Thanks for wiring it up and for https://netdev.bots.linux.dev/status.html!

> selftests: net/tcp_ao: rst_ipv4
> not ok 1 # error 834[lib/kconfig.c:143] Failed to initialize kconfig 2: No such file or directory
> # Planned tests != run tests (0 != 1)
> # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:1

Hehe, yeah I wanted to detect kernels with !CONFIG_TCP_AO, to SKIP the
test, rather than FAIL it, which this lib/kconfig.c does.
But from a glance, I think it's failing in your run because there are
checks with and without TCP_AO, but I didn't think of checking for
the hashing algorithms support.

I think what happens is has_tcp_ao():
: strcpy(tmp.alg_name, "hmac(sha1)");
...
: if (setsockopt(sk, IPPROTO_TCP, TCP_AO_ADD_KEY, &tmp, sizeof(tmp)) < 0)

Could you check that what I suppose is failing, is actually failing?
[dima@Mindolluin linux-master]$ grep -e '\<CONFIG_CRYPTO_SHA1\>' -e
'\<CONFIG_CRYPTO_HMAC\>' .config
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_SHA1=y

If that's the case, I'll  add the detection for hashing algorithms to
lib/kconfig.c (together with a patch for
tools/testing/selftests/net/config).
And also heads up for key-management.c - that tries a bunch of hashing
algorithms to check that the work and that the key rotation between
different algorithms works:

: const char *test_algos[] = {
: 	"cmac(aes128)",
: 	"hmac(sha1)", "hmac(sha512)", "hmac(sha384)", "hmac(sha256)",
: 	"hmac(sha224)", "hmac(sha3-512)",
: 	/* only if !CONFIG_FIPS */
: #define TEST_NON_FIPS_ALGOS	2
: 	"hmac(rmd160)", "hmac(md5)"
: };


> The script does:
> 
> target=net/tcp_ao
> make mrproper
> 
> vng -v -b -f tools/testing/selftests/$target
> # build the scripts
> make headers
> make -C tools/testing/selftests/$target
> 
> vng -v -r arch/x86/boot/bzImage --user root
> # inside the VM
> make -C tools/testing/selftests TARGETS=$target run_tests

Thanks,
            Dmitry


