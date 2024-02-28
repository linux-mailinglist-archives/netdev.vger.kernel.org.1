Return-Path: <netdev+bounces-75863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 651C486B623
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 18:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96ACF1C21589
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 17:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7224B12BF1D;
	Wed, 28 Feb 2024 17:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="B/8VyhQl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4491E514
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 17:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709141725; cv=none; b=H19UPhVr/rZM5rcur3qhDz/ZSUQESvRQMSWX2B8eb8ThTr1b7LASw7VqF0OWNKMziuiRO0EvHRSLhDtUxxmrwHBZCyKQ2hZvCHvQxRAxpI3td3DRnWe3UhAeITCi1Yvxuj6Eo+0jlLsb0NyzfE7Cf0t8InZzNENbiJvWFOLEmh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709141725; c=relaxed/simple;
	bh=gXa4lOW8w4knS3r2r0NabDz2CxrK4R8NsTAV1kcwB0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vl62hiZM0jK2aLU6WeLYftF9HaPcVeHDDrrnkR45UlULPEl8lTVe4+qIPGVJWPy3ktC+SiAeG0ftI+HRKIVLJrq3OiaScZa095TxM6ICQMrkLycPo0HnSG7sVMXlfEjPr/xOzksYxi9o9azCfRlJo3l5b0MUfqfTqGSQFx3GFUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=B/8VyhQl; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e4a0e80d14so2439570a34.1
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 09:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1709141722; x=1709746522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bbQzTMpUl3ghDUgX0onzD8w3xC/ny2PhcoxL6ewW680=;
        b=B/8VyhQl+eSbQEoAgqwtIzR6P/MK2AhNqAYlZZjuF9Kup3eYjQgx3LuTj+KMLyagc/
         92sSB8ZKRiVHe6POlcbBfP/LOZaqVcyo+g8GOZa5qoC2QNkRbXZbU4TPLN/HWCjTea9n
         foT67vQmCnQhntx+1vbadxiYdQG6WNy/UK7310hbv7z1gtvcvVCuMjWClAih5c2HPxBN
         eCuBZqjYv4hBINSnlvUkqgm6foq/mV/3z4vnwp+zXEoaf/8I+FJfut0DF8/TlRKvsl0f
         qqNizktppNCFaVt0HwHczIMEf3cqzaKI5ujKioDNicaqN31y6wBS7oeNSigBWvqUsZ0w
         T6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709141722; x=1709746522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bbQzTMpUl3ghDUgX0onzD8w3xC/ny2PhcoxL6ewW680=;
        b=qqdrp108xTHRlvT2waBYoDd5QJ8fbOn+TSozdt5ArrXM0XIiZVs7ZPO7j5W2o2hJr2
         RWtFM7b5ulCj0jzv8IYWeVFR6bVWMHcCdRXLUJZnLJ+W3ZUkfI/2aaPr1irUmUxs7seH
         xjxcR6f29K5GDVVBYy5LYUGukVWmwO/tSzgbRtc1pjjwGLB+656m8niu6b8y+j+oYzRb
         RGa2rz4agB3x2EWESgTLQ5dsD8wpng+BHbUhYKmKmYedKsKhflTxRtw2XRv6bXZES1BO
         7fJAdmWqpEQzB9d9uXD/ZMbe+u++5+X+D6ytrd2L4UWyr52ftClw1TTCYXwkAAUZ/MfA
         qfJw==
X-Forwarded-Encrypted: i=1; AJvYcCVyxS6pH+QS/+jTv9jG0TNlVEjmHPfsTPkdJLH4sYkIzS0jgp+8+UCFQdtXxNLFXmaXOKIG8MbJ0D00uzKQycqPFlzizaGu
X-Gm-Message-State: AOJu0Yy+tVBtTumjU5fTR3sqNpy94CH5DRsA8ZsO1+pVL8yjm8MKk4IL
	guzqclki8vqwD9BNDNJ/RSIwZv8I7FoGQbzj1pNpKGdmqQ859raUj2UtSLda7A==
X-Google-Smtp-Source: AGHT+IHRVarG/W/3caABon1SKUI/pGhSkSr0vzVQC2HmZHrS9OyNsB/ogqu6h0vKysizr70OyadOag==
X-Received: by 2002:a05:6830:c4:b0:6e4:8e99:5895 with SMTP id x4-20020a05683000c400b006e48e995895mr230016oto.25.1709141722515;
        Wed, 28 Feb 2024 09:35:22 -0800 (PST)
Received: from ?IPV6:2804:7f1:e2c2:4c5d:4b62:7f72:d1d3:62a6? ([2804:7f1:e2c2:4c5d:4b62:7f72:d1d3:62a6])
        by smtp.gmail.com with ESMTPSA id d18-20020a63d652000000b005cfbdf71baasm6949821pgj.47.2024.02.28.09.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 09:35:22 -0800 (PST)
Message-ID: <1562999a-05d7-4d4e-8fc0-43c5979793b8@mojatatu.com>
Date: Wed, 28 Feb 2024 14:35:17 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: tc-testing: add mirred to block tdc
 tests
To: Naresh Kamboju <naresh.kamboju@linaro.org>, kuba@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com,
 kernel@mojatatu.com, netdev@vger.kernel.org, pabeni@redhat.com,
 pctammela@mojatatu.com, xiyou.wangcong@gmail.com,
 lkft-triage@lists.linaro.org, anders.roxell@linaro.org,
 Linux Kernel Functional Testing <lkft@linaro.org>
References: <20240206075950.47d0bdc7@kernel.org>
 <20240228164939.150403-1-naresh.kamboju@linaro.org>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <20240228164939.150403-1-naresh.kamboju@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/02/2024 13:49, Naresh Kamboju wrote:
> LKFT tests running kselftests tc-testing noticing following run time errors
> on Linux next master branch.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> This is started from Linux next-20240212 with following commit,
> 
> f51470c5c4a0 selftests: tc-testing: add mirred to block tdc tests
> 
> Run log errors:
> ----------
> # Test e684: Delete batch of 32 mirred mirror ingress actions
> # multiprocessing.pool.RemoteTraceback:
> # """
> # Traceback (most recent call last):
> #   File "/opt/kselftests/default-in-kernel/tc-testing/./tdc.py", line 142, in call_pre_case
> #     pgn_inst.pre_case(caseinfo, test_skip)
> #   File "/opt/kselftests/default-in-kernel/tc-testing/plugin-lib/nsPlugin.py", line 63, in pre_case
> #     self.prepare_test(test)
> #   File "/opt/kselftests/default-in-kernel/tc-testing/plugin-lib/nsPlugin.py", line 36, in prepare_test
> #     self._nl_ns_create()
> #   File "/opt/kselftests/default-in-kernel/tc-testing/plugin-lib/nsPlugin.py", line 130, in _nl_ns_create
> #     ip.link('add', ifname=dev1, kind='veth', peer={'ifname': dev0, 'net_ns_fd':'/proc/1/ns/net'})
> #   File "/usr/lib/python3/dist-packages/pyroute2/iproute/linux.py", line 1593, in link
> #     ret = self.nlm_request(msg, msg_type=msg_type, msg_flags=msg_flags)
> #           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> #   File "/usr/lib/python3/dist-packages/pyroute2/netlink/nlsocket.py", line 403, in nlm_request
> #     return tuple(self._genlm_request(*argv, **kwarg))
> #            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> #   File "/usr/lib/python3/dist-packages/pyroute2/netlink/nlsocket.py", line 985, in nlm_request
> #     for msg in self.get(
> #                ^^^^^^^^^
> #   File "/usr/lib/python3/dist-packages/pyroute2/netlink/nlsocket.py", line 406, in get
> #     return tuple(self._genlm_get(*argv, **kwarg))
> #            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> #   File "/usr/lib/python3/dist-packages/pyroute2/netlink/nlsocket.py", line 770, in get
> #     raise msg['header']['error']
> # pyroute2.netlink.exceptions.NetlinkError: (34, 'Numerical result out of range')

It looks like the ip link add command is returning ERANGE.
We have tested this in NIPA for sometime with 64-bit and this is the 
first time
we are seeing this:

https://github.com/p4tc-dev/tc-executor/tree/storage/artifacts/485544

Could you give us more information on how to reproduce this?

Note: This doesn't seem to be related to the patches in question.
Seems to be a generic thing with nsPlugin itself.

Thanks,
Victor

