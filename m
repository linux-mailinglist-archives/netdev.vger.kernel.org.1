Return-Path: <netdev+bounces-131942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F1A990037
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 11:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25B342825F0
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 09:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D3C146A6B;
	Fri,  4 Oct 2024 09:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="cBFicA1y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DFB12EBE9
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728035433; cv=none; b=LYygx48Zq4wplZpmJkKxNDXbRpWVOYaG7tjbk4JcNhDuqgmMmEBmmAqDTCgSMDCWw1iMirrW39yXkn+fr0EYonhFVM4TIEvMRTb0Fddxjx9OS+fewtX2kgj51KtydCb/GR0Lcw6XxKyHg60sskX5RUxy4BVEo/sRbb5NhqT+VIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728035433; c=relaxed/simple;
	bh=7vD5kRrXC1IjoNQnuyE8QGl4zU/Vw1XtooLkPtjBXcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OECuJyiqF6fz78qpTAP+GqjnGc/2743YfsBAoTnxYYg/dLj+Fvq2EmdMr77cEI8mj1Hol3fuZ7P5JMlvskmbTNrOwSEP0m7x1vxSdDC+8p7IQWSA+VNmI82Le/zi410MSWKvZP+KGvsWFXRusGxSs6eAy+39Dl8ACcpgvn7cLaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=cBFicA1y; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42e5e758093so16790285e9.1
        for <netdev@vger.kernel.org>; Fri, 04 Oct 2024 02:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1728035428; x=1728640228; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t1R/M1Y/T/oV/rlMOlZ1xmp6TRllbAzUQyMMOYw2sDg=;
        b=cBFicA1yI+UxewmSM6/XAL2glsm8+QbWCniFM2UZOr4QbBbuDVp5tmI3CPVI2SqLoT
         86HTqW8GuEMF0kx54G/rgGxdxrR4cKUJ2521F7AedmcgwdI+aw3tPdUjmteN8RDtV3Uq
         vTusYwLRdKwBpNHs/XPU22Gzq5irk98Svy5O6NaM+HpII0r7ISW5eGlb4HnKuFQ2mZpg
         VbGZm2CcgKirVvG2sP5LQIIEFcmsHsZh2z5W+NboW4Bj6ZaDd5TlTsiJNZmZWjXKeQ3r
         /EpDiGy+ocLawmIig4B+gmPdWvlTS23c8cs3DRDXO+tXQ5iYlW5ONQZGtUMy/1ZOa+vw
         oSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728035428; x=1728640228;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1R/M1Y/T/oV/rlMOlZ1xmp6TRllbAzUQyMMOYw2sDg=;
        b=UiBDP/iHvrB/Ve2jNR7nbWQ0CcLsmBl2ar88hKgEgr3RAHd8sx0l+LReSUNaOldAHp
         SKPnjqRJEz0lRfqNDdAL+u2eGFJtyxYP5bJk3esjkVHAZLpigQ+Zngw8kvn4+/Rz/3em
         YGxy99YCkr6hdTFObS+cfMXEiR7zCt8xr3ihc2rEwgY+nHEaQcPB1rkrQEO/OpR+UI1J
         9NGYD8LZ+pX9QAiFh59Xt+M+/fxv8PRMMBZvwAvZlcc+cd+uaphWW5kK4d8R+kK3uEsp
         MWixdBOD2TOdZo3snG7G6QV9vL6+7Y7b3v65ycp8K7biXmoU0nFErl7cIo0k8BWnbctJ
         S++g==
X-Gm-Message-State: AOJu0YyoPKXr2PcKJA4xyiLRUw4hasf76Q/hrhN9hfc1Z0O/Srnx9oKt
	d0bSsQ7tfGEAQpIyHN632a3lj8qfVcJAVjlTVGSKsqYOP3SO/KYrp+ctKdLFHzE=
X-Google-Smtp-Source: AGHT+IGNqvq+dU7ywC0ShZTFvSLfsIRRvctTKyKCXriq6gJkjfFVClIc9NmLdbCEe5DvKkEyNMaRvQ==
X-Received: by 2002:a05:600c:4449:b0:42c:bf70:a303 with SMTP id 5b1f17b1804b1-42f85af4635mr13057275e9.29.1728035427984;
        Fri, 04 Oct 2024 02:50:27 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:1a03:e947:3ea2:4ac7? ([2001:67c:2fbc:1:1a03:e947:3ea2:4ac7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86a0a7d7sm11386985e9.2.2024.10.04.02.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 02:50:27 -0700 (PDT)
Message-ID: <fe21cf06-538b-4a3c-8d07-5b18ba56b1a9@openvpn.net>
Date: Fri, 4 Oct 2024 11:50:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 24/24] testing/selftest: add test tool and
 scripts for ovpn module
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Eric Dumazet <edumazet@google.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
 <20241002-b4-ovpn-v8-24-37ceffcffbde@openvpn.net>
 <1bd5d44c-4cbe-4514-99f3-31760e31a7f2@linuxfoundation.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <1bd5d44c-4cbe-4514-99f3-31760e31a7f2@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 03/10/2024 00:35, Shuah Khan wrote:
> On 10/2/24 03:02, Antonio Quartulli wrote:
>> The ovpn-cli tool can be compiled and used as selftest for the ovpn
>> kernel module.
>>
> 
> Does this test load ovpn module before running tests? If so does
> it unload the modules after tests are complete?

The module is self loaded upon first netlink API call.

Therefore I presume I should take care of unloading too.

> 
>> It implementes the netlink API and can thus be integrated in any
> 
> Spelling - implements

ACK

> 
>> script for more automated testing.
>>
>> Along with the tool, 2 scripts are added that perform basic
>> functionality tests by means of network namespaces.
>>
>> The scripts can be performed in sequence by running run.sh
>>
>> Cc: shuah@kernel.org
>> Cc: linux-kselftest@vger.kernel.org
>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
>> ---
>>   MAINTAINERS                                       |    1 +
>>   tools/testing/selftests/Makefile                  |    1 +
>>   tools/testing/selftests/net/ovpn/.gitignore       |    2 +
>>   tools/testing/selftests/net/ovpn/Makefile         |   18 +
>>   tools/testing/selftests/net/ovpn/config           |    8 +
>>   tools/testing/selftests/net/ovpn/data-test-tcp.sh |    9 +
>>   tools/testing/selftests/net/ovpn/data-test.sh     |  153 ++
>>   tools/testing/selftests/net/ovpn/data64.key       |    5 +
>>   tools/testing/selftests/net/ovpn/float-test.sh    |  118 ++
>>   tools/testing/selftests/net/ovpn/ovpn-cli.c       | 1822 
>> +++++++++++++++++++++
>>   tools/testing/selftests/net/ovpn/tcp_peers.txt    |    5 +
>>   tools/testing/selftests/net/ovpn/udp_peers.txt    |    5 +
>>   12 files changed, 2147 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 
>> f753060d4e2467a786778ddd4f835861a603ce02..ffd997cc6a1f1fbc5bc954b585bc15ef7bf2486a 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -17457,6 +17457,7 @@ T:    git 
>> https://github.com/OpenVPN/linux-kernel-ovpn.git
>>   F:    drivers/net/ovpn/
>>   F:    include/uapi/linux/ovpn.h
>>   F:    Documentation/netlink/spec/ovpn.yaml
>> +F:    tools/testing/selftests/net/ovpn/
>>   P54 WIRELESS DRIVER
>>   M:    Christian Lamparter <chunkeey@googlemail.com>
>> diff --git a/tools/testing/selftests/Makefile 
>> b/tools/testing/selftests/Makefile
>> index 
>> b38199965f99014f3e2636fe8d705972f2c0d148..3ae2dd6492ca70d5e317c6e5b4e2560b060e3214 100644
>> --- a/tools/testing/selftests/Makefile
>> +++ b/tools/testing/selftests/Makefile
>> @@ -68,6 +68,7 @@ TARGETS += net/hsr
>>   TARGETS += net/mptcp
>>   TARGETS += net/netfilter
>>   TARGETS += net/openvswitch
>> +TARGETS += net/ovpn
>>   TARGETS += net/packetdrill
>>   TARGETS += net/rds
>>   TARGETS += net/tcp_ao
>> diff --git a/tools/testing/selftests/net/ovpn/.gitignore 
>> b/tools/testing/selftests/net/ovpn/.gitignore
>> new file mode 100644
>> index 
>> 0000000000000000000000000000000000000000..ee44c081ca7c089933659689303c303a9fa9713b
>> --- /dev/null
>> +++ b/tools/testing/selftests/net/ovpn/.gitignore
>> @@ -0,0 +1,2 @@
>> +# SPDX-License-Identifier: GPL-2.0+
>> +ovpn-cli
>> diff --git a/tools/testing/selftests/net/ovpn/Makefile 
>> b/tools/testing/selftests/net/ovpn/Makefile
>> new file mode 100644
>> index 
>> 0000000000000000000000000000000000000000..65e23eb0ba86d31aa365b08a8c3468dc56a0d1a4
>> --- /dev/null
>> +++ b/tools/testing/selftests/net/ovpn/Makefile
>> @@ -0,0 +1,18 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2020-2024 OpenVPN, Inc.
>> +#
>> +CFLAGS = -Wall -I../../../../../usr/include
>> +CFLAGS += $(shell pkg-config --cflags libnl-3.0 libnl-genl-3.0)
>> +
>> +LDFLAGS = -lmbedtls -lmbedcrypto
>> +LDFLAGS += $(shell pkg-config --libs libnl-3.0 libnl-genl-3.0)
>> +
>> +ovpn-cli: ovpn-cli.c
>> +    $(CC) -o ovpn-cli ovpn-cli.c $(CFLAGS) $(LDFLAGS)
>> +
>> +TEST_PROGS = data-test.sh \
>> +    data-test-tcp.sh \
>> +    float-test.sh
>> +TEST_GEN_FILES = ovpn-cli
> 
> Can you make sure "make kselftest-install" installs all
> of the scripts and executables necessary to run this test?

ok, will do!
Thanks for your feedback!


Regards,

> 
> thanks,
> -- Shuah

-- 
Antonio Quartulli
OpenVPN Inc.

