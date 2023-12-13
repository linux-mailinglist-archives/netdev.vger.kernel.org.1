Return-Path: <netdev+bounces-56676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D218106C8
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 01:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 369C31C20D64
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 00:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C243A41;
	Wed, 13 Dec 2023 00:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="n4q5FErS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AAA99
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 16:38:47 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6d099d316a8so2369754b3a.0
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 16:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1702427927; x=1703032727; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X2LgjgyFZCsJsJMuI4smk3aaCnyMQmBBIXOcsAVX1mk=;
        b=n4q5FErS2/oBe03xMBk2Dqc3r3Qejl5xENIwnKo18Ugz3gvaDTPk+vaKhCi3fOXQ7Q
         9dqcqUv9w656Jd03gGX58mUr6898CSvSvg5PE3Gt/RSmPV9XytTWJnlIhV42Gq06HjSf
         W0nvMpLUK+x1bCZ2pqWnabJfw0TiqHnSZjmkfKZwijrWHAB7w0Ut1uyDVJ4ZdKUZtBu/
         UGSslb7BHFuynYdNxyCgZS+a49YIGMPFfEYsoRAhAkvmL21F8w9lEin6fMpuu6/PflVx
         KA+OHXJFh/CGSUa+47BoqYjLBgm6JCcZuToxrqP+nlW57YWPIANHZKao3/4wn0jJv0He
         zt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702427927; x=1703032727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X2LgjgyFZCsJsJMuI4smk3aaCnyMQmBBIXOcsAVX1mk=;
        b=ig878qvDVcpRFDy1lOxtbDayi4sWYvk6cwMr2WzEUgPPBwbYr5RLU9Nw9LgIoWyyO8
         OoWsqbbkcARJB9qsFtlz6o7EVe4bphIhSt0xYpDQqAX09LabE4FgPacB/LHW81Q5uQbk
         BtMVndZsvwEjqwajd6fYjDfawnI54rFdVI5bP9gm2Ry5A/0M4rIY9K3924sWa3rzIPF9
         vkv+GnIJ10w50SbMttH8wUlaQrNo+QtprbqZhFFBBEnJJ7I3fwhYl94/JNfQzHnSA/I4
         swF+QHQZQ+3vqOWjHvmPQu2Pu+YZbZ9AboYhQqaXIulzfytiiVASNe7LQBctupIcA4Dd
         BAEw==
X-Gm-Message-State: AOJu0Yx3rbgau/EbWnVcWlCVQNqoZeHgz5phlOjmQBEOb5l7whwc+0W7
	FwzJdcjsqZOiwbEYVbvhMMER8w==
X-Google-Smtp-Source: AGHT+IExcDonwQf+ccAGx4vwD0y2pxUKlcjlCsfyBz7AL/XsMo48WKP1HdirrhBZPx4zwN7whfUh2A==
X-Received: by 2002:a05:6a00:10d3:b0:68f:d1a7:1a3a with SMTP id d19-20020a056a0010d300b0068fd1a71a3amr7934857pfu.8.1702427927013;
        Tue, 12 Dec 2023 16:38:47 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:40a:5eb5:8916:33a4? ([2620:10d:c090:500::7:721])
        by smtp.gmail.com with ESMTPSA id c7-20020a056a00008700b006ce458995f8sm8789340pfj.173.2023.12.12.16.38.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 16:38:46 -0800 (PST)
Message-ID: <a318c61c-81ce-4eb8-9737-0ea1c0ed57a0@davidwei.uk>
Date: Tue, 12 Dec 2023 16:38:45 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/3] netdevsim: add selftest for forwarding
 skb between connected ports
Content-Language: en-GB
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20231210010448.816126-1-dw@davidwei.uk>
 <20231210010448.816126-4-dw@davidwei.uk> <20231212122935.4e23dd08@kernel.org>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20231212122935.4e23dd08@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023-12-12 12:29, Jakub Kicinski wrote:
> On Sat,  9 Dec 2023 17:04:48 -0800 David Wei wrote:
>> From: David Wei <davidhwei@meta.com>
>>
>> Connect two netdevsim ports in different namespaces together, then send
>> packets between them using socat.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>>  .../selftests/drivers/net/netdevsim/peer.sh   | 111 ++++++++++++++++++
>>  1 file changed, 111 insertions(+)
>>  create mode 100755 tools/testing/selftests/drivers/net/netdevsim/peer.sh
> 
> You need to include this script in the Makefile so it gets run

Thanks, will address.

> 
>> diff --git a/tools/testing/selftests/drivers/net/netdevsim/peer.sh b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
>> new file mode 100755
>> index 000000000000..d1d59a932174
>> --- /dev/null
>> +++ b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
>> @@ -0,0 +1,111 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-2.0-only
>> +
>> +NSIM_DEV_SYS=/sys/bus/netdevsim
>> +NSIM_DEV_DFS=/sys/kernel/debug/netdevsim/netdevsim
>> +
>> +socat_check()
>> +{
>> +	if [ ! -x "$(command -v socat)" ]; then
>> +		echo "socat command not found. Skipping test"
>> +		return 1
>> +	fi
>> +
>> +	return 0
>> +}
>> +
>> +setup_ns()
>> +{
>> +	set -e
>> +	ip netns add nssv
>> +	ip netns add nscl
>> +
>> +	ip link set eni1np1 netns nssv
>> +	ip link set eni2np1 netns nscl
> 
> This assumes you have systemd renaming interfaces.
> I can find out what the netdev is called from sysfs.
> After you create the nsim device in its sysfs dir
> there will be a dir "net" and in it you'll have
> a subdir with the same name as the netdev.

Thanks, will fix.

> 
>> +	ip netns exec nssv ip addr add '192.168.1.1/24' dev eni1np1
>> +	ip netns exec nscl ip addr add '192.168.1.2/24' dev eni2np1
>> +
>> +	ip netns exec nssv ip link set dev eni1np1 up
>> +	ip netns exec nscl ip link set dev eni2np1 up
>> +	set +e
>> +}
>> +
>> +cleanup_ns()
>> +{
>> +	ip netns del nscl
>> +	ip netns del nssv
>> +}
>> +
>> +###
>> +### Code start
>> +###
>> +
>> +modprobe netdevsim
>> +
>> +# linking
>> +
>> +echo 1 > ${NSIM_DEV_SYS}/new_device
> 
> Use $RANDOM to generate a random device ID.

Will do.

> 
>> +echo "2 0" > ${NSIM_DEV_DFS}1/ports/0/peer 2>/dev/null
>> +if [ $? -eq 0 ]; then
>> +	echo "linking with non-existent netdevsim should fail"
>> +	exit 1
>> +fi
>> +
>> +echo 2 > /sys/bus/netdevsim/new_device
>> +
>> +echo "2 0" > ${NSIM_DEV_DFS}1/ports/0/peer
>> +if [ $? -ne 0 ]; then
>> +	echo "linking netdevsim1 port0 with netdevsim2 port0 should succeed"
>> +	exit 1
>> +fi
>> +
>> +# argument error checking
>> +
>> +echo "2 1" > ${NSIM_DEV_DFS}1/ports/0/peer 2>/dev/null
>> +if [ $? -eq 0 ]; then
>> +	echo "linking with non-existent port in a netdevsim should fail"
>> +	exit 1
>> +fi
>> +
>> +echo "1 0" > ${NSIM_DEV_DFS}1/ports/0/peer 2>/dev/null
>> +if [ $? -eq 0 ]; then
>> +	echo "linking with self should fail"
>> +	exit 1
>> +fi
>> +
>> +echo "2 a" > ${NSIM_DEV_DFS}1/ports/0/peer 2>/dev/null
>> +if [ $? -eq 0 ]; then
>> +	echo "invalid arg should fail"
>> +	exit 1
>> +fi
>> +
>> +# send/recv packets
>> +
>> +socat_check || exit 1
> 
> There's a magic return value for skipping kselftests, 1 means fail.

Thanks, will fix.

