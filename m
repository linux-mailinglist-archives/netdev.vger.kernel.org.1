Return-Path: <netdev+bounces-137835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA1F9AA036
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 12:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE1BE1F224DD
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 10:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEE719A2BD;
	Tue, 22 Oct 2024 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GjDhUwEm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EFD178388
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729593624; cv=none; b=r0MbkM4bvGdj8ql7yEBNI7mkMjNrd0UnAi2iehHFhQ1U9IeJlCF51VOP/qsqdNnRmr3DPSkmmk/g7LJ/J179zu5ZhPnCRlb8MwXW7k+V0JkbqwiRkYdoLzsU9ZDt1d/KoDDnakg5WhoBnvbEMS9tT85QAj2uVwN9kLmoU6erI0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729593624; c=relaxed/simple;
	bh=YCseHNrngvlrYE3BM08vZtUmYduLM9OjKS1hwMxVHak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HdtU2IsVR2X6ZtJVQXafq+CyFAuOVYB+f59Ww9EfXJ34SA2+1gER6L0JQ+6v3pVZrTO4OUpbrJU5k5MNDE85nhVBcQXcndby7ZeKDUvPrMJmKUceMaVHwg22hvCq23cLoGXg040NlAa4Tb++YUD0q+bKQoWQz7w18s2FVGArzuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GjDhUwEm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729593621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yppw7FZOn3fNBKkv5OCqzgX3hvFIIoyZHQclDbbxYDo=;
	b=GjDhUwEmJOlQE56qUNk73f255ZqQnHeHTjUJ7pnt3dkNxamoTSk6nn8sWPM06L8z1FtMjZ
	TnhF/g3s5xwldieKC0m1TULZjZCOaDKzNVU/pB9KnZDNCddx/GfxFBCq1xSauCudE0b5Z5
	KYRmJW2P5nVqRAcgbUVitToUUzF2DqA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-uZ_nWoBkNm6jezMurwdpmg-1; Tue, 22 Oct 2024 06:40:19 -0400
X-MC-Unique: uZ_nWoBkNm6jezMurwdpmg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d56061a4cso2800977f8f.2
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 03:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729593619; x=1730198419;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yppw7FZOn3fNBKkv5OCqzgX3hvFIIoyZHQclDbbxYDo=;
        b=g2ozee+0gDfUPbZ7DzgRF8Ic8FL61mD2Bc2in8ZJ2OoDurdPcf4oN7F7ji7f575E75
         8COo4IuMGvyRTs9m5BqwW+ONR3APfd2YRziMjUd+sp6QEcQZRRQggHF8qJVlV6INOYdm
         glWrN+tKp8AajMQUFrdFsp80NCCEJ/dB9fwBTy9WyovUVm1XS1ldxMmeSwrID6dkQedP
         iQH9I7UBVxHTILbqYdN1Aq3SoiLLYAE28OecWFvQIGnly5s8jR6+sn8GiCZvajIt7eZG
         SM5lRHNpFikNinawF2yOrqTwfaao5nXD30yFQgLTZxPW5jE5C+2Os1VstAVTARd6yC3K
         oOqA==
X-Forwarded-Encrypted: i=1; AJvYcCUmT9cQhyNZ+0vGxXnheCqhjLzi1URTxdGorPskInpjDQ9IfyBmixRX/nYqvFE/CWh5RCwOtjk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0p1f7ZCfPbengNHhRuEb9UClP9HL7IfqQ4IiI7cl2dfoGRuGS
	Z8AsLJwNQ6qYpgRwZSaqZDG2/RPIUj3BxHdhYe50j3ZVe1Fk+iBLT4XJ48yuuEg/SbpDY1CHvHr
	c5ZPCnn4q/j7LPz3QDa0wljyYlpVmGc4ms54UuOpe0RQZDKst/nu3Vw==
X-Received: by 2002:adf:e88d:0:b0:37d:ff4:dc64 with SMTP id ffacd0b85a97d-37ef0b90351mr2327887f8f.25.1729593618662;
        Tue, 22 Oct 2024 03:40:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDQH9Mi/A7o8VYMmo1Y8qPuV1KvjlODrMjk1LMBVE0L6hlbkL0p0VJWpbUoKW+SgnHllU/dA==
X-Received: by 2002:adf:e88d:0:b0:37d:ff4:dc64 with SMTP id ffacd0b85a97d-37ef0b90351mr2327866f8f.25.1729593618207;
        Tue, 22 Oct 2024 03:40:18 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910:d583:6ebb:eb80:7cd8? ([2a0d:3344:1b73:a910:d583:6ebb:eb80:7cd8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a5b384sm6301944f8f.57.2024.10.22.03.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 03:40:17 -0700 (PDT)
Message-ID: <af9bf6e1-f6fa-4683-a3bd-82cebcce6fb8@redhat.com>
Date: Tue, 22 Oct 2024 12:40:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] selftests: nic_performance: Add selftest
 for performance of NIC driver
Content-Language: en-US
To: Mohan Prasad J <mohan.prasad@microchip.com>, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, andrew@lunn.ch
Cc: edumazet@google.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, horms@kernel.org, brett.creeley@amd.com,
 rosenp@gmail.com, UNGLinuxDriver@microchip.com, willemb@google.com,
 petrm@nvidia.com
References: <20241016215014.401476-1-mohan.prasad@microchip.com>
 <20241016215014.401476-4-mohan.prasad@microchip.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241016215014.401476-4-mohan.prasad@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/16/24 23:50, Mohan Prasad J wrote:
> Add selftest case to check the send and receive throughput.
> Supported link modes between local NIC driver and partner
> are varied. Then send and receive throughput is captured
> and verified. Test uses iperf3 tool.
> 
> Signed-off-by: Mohan Prasad J <mohan.prasad@microchip.com>
> ---
>  .../testing/selftests/drivers/net/hw/Makefile |   1 +
>  .../drivers/net/hw/nic_performance.py         | 121 ++++++++++++++++++
>  2 files changed, 122 insertions(+)
>  create mode 100644 tools/testing/selftests/drivers/net/hw/nic_performance.py
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> index 0dac40c4e..289512092 100644
> --- a/tools/testing/selftests/drivers/net/hw/Makefile
> +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> @@ -11,6 +11,7 @@ TEST_PROGS = \
>  	hw_stats_l3_gre.sh \
>  	loopback.sh \
>  	nic_link_layer.py \
> +	nic_performance.py \
>  	pp_alloc_fail.py \
>  	rss_ctx.py \
>  	#
> diff --git a/tools/testing/selftests/drivers/net/hw/nic_performance.py b/tools/testing/selftests/drivers/net/hw/nic_performance.py
> new file mode 100644
> index 000000000..152c62511
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/nic_performance.py
> @@ -0,0 +1,121 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +#Introduction:
> +#This file has basic performance test for generic NIC drivers.
> +#The test comprises of throughput check for TCP and UDP streams.
> +#
> +#Setup:
> +#Connect the DUT PC with NIC card to partner pc back via ethernet medium of your choice(RJ45, T1)
> +#
> +#        DUT PC                                              Partner PC
> +#┌───────────────────────┐                         ┌──────────────────────────┐
> +#│                       │                         │                          │
> +#│                       │                         │                          │
> +#│           ┌───────────┐                         │                          │
> +#│           │DUT NIC    │         Eth             │                          │
> +#│           │Interface ─┼─────────────────────────┼─    any eth Interface    │
> +#│           └───────────┘                         │                          │
> +#│                       │                         │                          │
> +#│                       │                         │                          │
> +#└───────────────────────┘                         └──────────────────────────┘
> +#
> +#Configurations:
> +#To prevent interruptions, Add ethtool, ip to the sudoers list in remote PC and get the ssh key from remote.
> +#Required minimum ethtool version is 6.10
> +#Change the below configuration based on your hw needs.
> +# """Default values"""
> +time_delay = 8 #time taken to wait for transitions to happen, in seconds.
> +test_duration = 10  #performance test duration for the throughput check, in seconds.
> +send_throughput_threshold = 80 #percentage of send throughput required to pass the check
> +receive_throughput_threshold = 50 #percentage of receive throughput required to pass the check

Please allow the user to override this parameters with env variable
and/or with the command line.

> +
> +import time
> +import json
> +from lib.py import ksft_run, ksft_exit, ksft_pr, ksft_true
> +from lib.py import KsftFailEx, KsftSkipEx
> +from lib.py import NetDrvEpEnv
> +from lib.py import cmd
> +from lib.py import LinkConfig
> +
> +def verify_throughput(cfg, link_config) -> None:
> +    protocols = ["TCP", "UDP"]
> +    common_link_modes = link_config.common_link_modes
> +    speeds, duplex_modes = link_config.get_speed_duplex_values(common_link_modes)
> +    """Test duration in seconds"""
> +    duration = test_duration
> +    target_ip = cfg.remote_addr
> +
> +    for protocol in protocols:
> +        ksft_pr(f"{protocol} test")
> +        test_type = "-u" if protocol == "UDP" else ""
> +        send_throughput = []
> +        receive_throughput = []
> +        for idx in range(0, len(speeds)):
> +            bit_rate = f"-b {speeds[idx]}M" if protocol == "UDP" else ""

Always use '-b 0'. Will work with both TCP and UDP and is usually more
efficient than forcing a specific speed.

> +            if link_config.set_speed_and_duplex(speeds[idx], duplex_modes[idx]) == False:
> +                raise KsftFailEx(f"Not able to set speed and duplex parameters for {cfg.ifname}")
> +            time.sleep(time_delay)
> +            if link_config.verify_link_up() == False:
> +                raise KsftSkipEx(f"Link state of interface {cfg.ifname} is DOWN")
> +            send_command=f"iperf3 {test_type} -c {target_ip} {bit_rate} -t {duration} --json"
> +            receive_command=f"iperf3 {test_type} -c {target_ip} {bit_rate} -t {duration} --reverse --json"
> +            send_result = cmd(send_command)
> +            receive_result = cmd(receive_command)
> +            if send_result.ret != 0 or receive_result.ret != 0:
> +                raise KsftSkipEx("Unexpected error occurred during transmit/receive")
> +
> +            send_output = send_result.stdout
> +            receive_output = receive_result.stdout
> +
> +            send_data = json.loads(send_output)
> +            receive_data = json.loads(receive_output)
> +            """Convert throughput to Mbps"""
> +            send_throughput.append(round(send_data['end']['sum_sent']['bits_per_second'] / 1e6, 2))
> +            receive_throughput.append(round(receive_data['end']['sum_received']['bits_per_second'] / 1e6, 2))
> +
> +            ksft_pr(f"{protocol}: Send throughput: {send_throughput[idx]} Mbps, Receive throughput: {receive_throughput[idx]} Mbps")
> +
> +        """Check whether throughput is not below the threshold (default values set at start)"""
> +        for idx in range(0, len(speeds)):
> +            send_threshold = float(speeds[idx]) * float(send_throughput_threshold / 100)
> +            receive_threshold = float(speeds[idx]) * float(receive_throughput_threshold / 100)
> +            ksft_true(send_throughput[idx] >= send_threshold, f"{protocol}: Send throughput is below threshold for {speeds[idx]} Mbps in {duplex_modes[idx]} duplex")
> +            ksft_true(receive_throughput[idx] >= receive_threshold, f"{protocol}: Receive throughput is below threshold for {speeds[idx]} Mbps in {duplex_modes[idx]} duplex")
> +
> +def test_throughput(cfg, link_config) -> None:
> +    common_link_modes = link_config.common_link_modes
> +    if not common_link_modes:
> +        KsftSkipEx("No common link modes found")
> +    if link_config.partner_netif == None:
> +        KsftSkipEx("Partner interface name not available")
> +    if link_config.check_autoneg_supported() and link_config.check_autoneg_supported(remote=True):
> +        KsftSkipEx("Auto-negotiation not supported by local or remote")
> +    cfg.require_cmd("iperf3", remote=True)
> +    try:
> +        """iperf3 server to be run in the remote pc"""
> +        command = "iperf3 -s -D"
> +        process = cmd(command, host=cfg.remote)

It's probably better use '--one-off' and run the command in background.

You should wait for the listener to be available with wait_port_listen()

Also you can consider extending the existing GenerateTraffic() class in

tools/testing/selftests/drivers/net/lib/py/load.py

[...]
> +def main() -> None:
> +    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
> +        link_config = LinkConfig(cfg)
> +        ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg, link_config,))

Instead of having a single test with all proto and speeds, what about
using a tests list, each of them using a given protocol and speed, so
that the user see more fine grain results?

Thanks

Paolo


