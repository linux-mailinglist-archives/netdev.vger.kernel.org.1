Return-Path: <netdev+bounces-128968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE7897CA46
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 15:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DCDE1F245ED
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 13:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8369019E7E6;
	Thu, 19 Sep 2024 13:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xc68B0mR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4351CA9E
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 13:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726753308; cv=none; b=fJ82G065ynFRd//uCZXfO4UNNpIHYNi8vIQjznKzIk2EFOE8CeJ5RizRcrd+NZIe4+MHMQwR+mjVMZkgHWMwz14lG4tEJ7jx99qyObUwSDcxKk2h0RNNKp4A6GqBOSg1gUPP2pyaLPoRefARBWQBBR+Pk4euuNynKQxjEA1dfo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726753308; c=relaxed/simple;
	bh=Jx9qDE2XMCGBG9YtP2sgDsf3qjRsPBv+Ko7GgIpBgr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dlywQgGg2uPF2R/OYauJpxmAAOzXeHEHYpS5VsnFTQ6TBh9z2isEk9fvt7xAxNG58DSo0SlxnGLHJlEQjW8gzBDRg7S7GF/PotdsHPnF1kL+KMb0l1wMpDdMZxCwbWm32YZ+VDE0gV6kQNi/Nf64QjWc8Fz0GDNlsCE89LRPGdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xc68B0mR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726753305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jq3+Ew/GB+IK7BnD6BkDKowoPSv6TM+STCM5xvJRos8=;
	b=Xc68B0mR/thDaA/gMVy6Zw9i/PHLODRfsYeYIOowIT3C2fS0WpSyr5pI/AUrhpdym+PdXl
	YidakuAzXbQGNFqRCddynhA7zqnOtd2a0CVgJ/4BK3QKummvpBQHRalzBJW8pJCwFbJBKe
	PgcBjM1VfJYt+hxglouXfNqDqvlHBeI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-4lkh9OgZM3GuYw83fUR65g-1; Thu, 19 Sep 2024 09:41:44 -0400
X-MC-Unique: 4lkh9OgZM3GuYw83fUR65g-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-374b9617ab0so357652f8f.3
        for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 06:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726753303; x=1727358103;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jq3+Ew/GB+IK7BnD6BkDKowoPSv6TM+STCM5xvJRos8=;
        b=ElFiarD/JE5qgAqaLBRDVZaCGTVgwr6yWGvzQrM6NM06QIKiFPZhomNvTuCXRzsCVf
         SYQydanafOxgHfLBUqXINt973yAondV+bYdkif75xijzvi8JrMtTYboGIFWgJd4eKPxI
         3q4k9+n9gDO7g0UJipKkDqlsj0JnuHSv/W4MbZV/iC2fH+/POSlXvdSeawjZQmWXPqtU
         x27LgIQsZt4xcclyPbkcE9rvdhjptYbO/ahFEsUOf1zhKcFnWTChku/KJb1OXhLov9/5
         kQelTdoTSAaRTtK1w7gyDO7JkJUbpbE8kePB0VApKy2CVKbgz30ClOwEmuVgXsi42COA
         jxwg==
X-Forwarded-Encrypted: i=1; AJvYcCWyU030rNAeSeGn+Tzzo1Y688CxzM3FCFBCklZ0OKalcCnSAq7COA5aZL7WS4Y0eUqxjxpuCsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRXYO6F07Hb+V4tiTocAcqUCeM4Jys8B6RmTQMd8UVr2pZvBn9
	YA0X6guB+9lNSvhKq4Mnl5HSk9saef2xbHgT+1jLXOL9slYOe4ZgbrSn2YODH2fwXO4LbmAWEg0
	YQj7j4xhefCVv0LKl1W/ysDvcyc/I1/ynkg04d3whDuuj+Yj5MQT3dQ==
X-Received: by 2002:a5d:42c7:0:b0:374:bfb2:39d with SMTP id ffacd0b85a97d-378c2d4d6d5mr14702830f8f.38.1726753302760;
        Thu, 19 Sep 2024 06:41:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8WYfENnwqdWCK8AfPN/scz9qNfhFO4w1/7/dTYpxZLdwdQxp2FBxKk1OUfsivTu6mVlZ8NQ==
X-Received: by 2002:a5d:42c7:0:b0:374:bfb2:39d with SMTP id ffacd0b85a97d-378c2d4d6d5mr14702806f8f.38.1726753302239;
        Thu, 19 Sep 2024 06:41:42 -0700 (PDT)
Received: from [192.168.88.100] (146-241-67-136.dyn.eolo.it. [146.241.67.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e75452b8esm22224015e9.28.2024.09.19.06.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 06:41:41 -0700 (PDT)
Message-ID: <b987d227-f49a-428b-af2f-e081ae439d4b@redhat.com>
Date: Thu, 19 Sep 2024 15:41:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] ipv6: Fix soft lockups in fib6_select_path under
 high next hop churn
To: Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>,
 netdev@vger.kernel.org
Cc: dsahern@gmail.com, edumazet@google.com, idosch@idosch.org,
 kuniyu@amazon.com, adrian.oliver@menlosecurity.com
References: <20240916050735.29155-1-omid.ehtemamhaghighi@menlosecurity.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240916050735.29155-1-omid.ehtemamhaghighi@menlosecurity.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/16/24 07:07, Omid Ehtemam-Haghighi wrote:
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index 9d5aa817411b..d79942e6ff76 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -95,6 +95,7 @@ TEST_PROGS += fdb_flush.sh
>   TEST_PROGS += fq_band_pktlimit.sh
>   TEST_PROGS += vlan_hw_filter.sh
>   TEST_PROGS += bpf_offload.py
> +TEST_PROGS += ipv6_route_update_soft_lockup.sh
>   
>   TEST_FILES := settings
>   TEST_FILES += in_netns.sh lib.sh net_helper.sh setup_loopback.sh setup_veth.sh
> diff --git a/tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh b/tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh
> new file mode 100755
> index 000000000000..f55488e4645c
> --- /dev/null
> +++ b/tools/testing/selftests/net/ipv6_route_update_soft_lockup.sh
> @@ -0,0 +1,226 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Testing for potential kernel soft lockup during IPv6 routing table
> +# refresh under heavy outgoing IPv6 traffic. If a kernel soft lockup
> +# occurs, a kernel panic will be triggered to prevent associated issues.
> +#
> +#
> +#                            Test Environment Layout
> +#
> +# ┌-----------------┐                                             ┌------------------┐
> +# |     SOURCE_NS   |                                             |     SINK_NS      |
> +# |    NAMESPACE    |                                             |    NAMESPACE     |
> +# |(iperf3 clients) |                                             | (iperf3 servers) |
> +# |                 |                                             |                  |
> +# |                 |                                             |                  |
> +# |     ┌-----------|                             nexthops        |---------┐        |
> +# |     |veth_source|<------------------------------------------->|veth_sink|<-┐     |
> +# |     └-----------| 2001:0DB8:1::0:1/96     2001:0DB8:1::1:1/96 |---------┘  |     |
> +# |                 |         ^               2001:0DB8:1::1:2/96 |            |     |
> +# |                 |         .                       .           |            | fwd |
> +# |   ┌---------┐   |         .                       .           |            |     |
> +# |   |   IPv6  |   |         .                       .           |            V     |
> +# |   | routing |   |         .               2001:0DB8:1::1:80/96|         ┌-----┐  |
> +# |   |  table  |   |         .                                   |         | lo  |  |
> +# |   | nexthop |   |         .                                   └---------┴-----┴--┘
> +# |   | update  |   |         ..................................> 2001:0DB8:2::1:1/128
> +# |   └-------- ┘   |
> +# └-----------------┘
> +#
> +# The test script sets up two network namespaces, source_ns and sink_ns,
> +# connected via a veth link. Within source_ns, it continuously updates the
> +# IPv6 routing table by flushing and inserting IPV6_NEXTHOP_ADDR_COUNT nexthop
> +# IPs destined for SINK_LOOPBACK_IP_ADDR in sink_ns. This refresh occurs at a
> +# rate of 1/ROUTING_TABLE_REFRESH_PERIOD per second for TEST_DURATION seconds.
> +#
> +# Simultaneously, multiple iperf3 clients within source_ns generate heavy
> +# outgoing IPv6 traffic. Each client is assigned a unique port number starting
> +# at 5000 and incrementing sequentially. Each client targets a unique iperf3
> +# server running in sink_ns, connected to the SINK_LOOPBACK_IFACE interface
> +# using the same port number.
> +#
> +# The number of iperf3 servers and clients is set to half of the total
> +# available cores on each machine.
> +#
> +# NOTE:  We have tested this script on machines with various CPU specifications,
> +# ranging from lower to higher performance as listed below. The test script
> +# effectively triggered a kernel soft lockup on machines running an unpatched
> +# kernel in under a minute:
> +#
> +# - 1x Intel Xeon E-2278G 8-Core Processor @ 3.40GHz
> +# - 1x Intel Xeon E-2378G Processor 8-Core @ 2.80GHz
> +# - 1x AMD EPYC 7401P 24-Core Processor @ 2.00GHz
> +# - 1x AMD EPYC 7402P 24-Core Processor @ 2.80GHz
> +# - 2x Intel Xeon Gold 5120 14-Core Processor @ 2.20GHz
> +# - 1x Ampere Altra Q80-30 80-Core Processor @ 3.00GHz
> +# - 2x Intel Xeon Gold 5120 14-Core Processor @ 2.20GHz
> +# - 2x Intel Xeon Silver 4214 24-Core Processor @ 2.20GHz
> +# - 1x AMD EPYC 7502P 32-Core @ 2.50GHz
> +# - 1x Intel Xeon Gold 6314U 32-Core Processor @ 2.30GHz
> +# - 2x Intel Xeon Gold 6338 32-Core Processor @ 2.00GHz
> +#
> +# On less performant machines, you may need to increase the TEST_DURATION
> +# parameter to enhance the likelihood of encountering a race condition leading
> +# to a kernel soft lockup and avoid a false negative result.
> +
> +source lib.sh
> +
> +TEST_DURATION=120
> +ROUTING_TABLE_REFRESH_PERIOD=0.01
> +
> +IPERF3_BITRATE="300m"
> +
> +
> +IPV6_NEXTHOP_ADDR_COUNT="128"
> +IPV6_NEXTHOP_ADDR_MASK="96"
> +IPV6_NEXTHOP_PREFIX="2001:0DB8:1"
> +
> +
> +SOURCE_TEST_IFACE="veth_source"
> +SOURCE_TEST_IP_ADDR="2001:0DB8:1::0:1/96"
> +
> +SINK_TEST_IFACE="veth_sink"
> +# ${SINK_TEST_IFACE} is populated with the following range of IPv6 addresses:
> +# 2001:0DB8:1::1:1  to 2001:0DB8:1::1:${IPV6_NEXTHOP_ADDR_COUNT}
> +SINK_LOOPBACK_IFACE="lo"
> +SINK_LOOPBACK_IP_MASK="128"
> +SINK_LOOPBACK_IP_ADDR="2001:0DB8:2::1:1"
> +
> +nexthop_ip_list=""
> +termination_signal=""
> +kernel_softlokup_panic_prev_val=""
> +
> +cleanup() {
> +	echo "info: cleaning up namespaces and terminating all processes within them..."
> +
> +	kill -9 $(pgrep -f "iperf3") > /dev/null 2>&1
> +	sleep 1

This may cause self-test failures in other st running concurrently and 
using iperf3, too. You should capture the iperf3 pid at startup time and 
kill such process only

> +	kill -9 $(pgrep -f "ip netns list | grep -q ${source_ns}") > /dev/null 2>&1

Same here

> +	sleep 1

Also try to avoid explicit sleep. I think you can simply remove this one 
and the previous one.

> +
> +	# Check if any iperf3 instances are still running. This could occur if a core has entered an infinite loop and
> +	# the timeout for the soft lockup to be detected has not expired yet, but either the test interval has already
> +	# elapsed or the test is terminated manually (Ctrl+C)
> +	if pgrep -f "iperf3" > /dev/null; then
> +		echo "FAIL: unable to terminate some iperf3 instances. Soft lockup is underway. A kernel panic is on the way!"
> +		exit ${ksft_fail}
> +	else
> +		if [ "$termination_signal" == "SIGINT" ]; then
> +			echo "SKIP: Termination due to ^C (SIGINT)"
> +		elif [ "$termination_signal" == "SIGALRM" ]; then
> +			echo "PASS: No kernel soft lockup occurred during this ${TEST_DURATION} second test"
> +		fi
> +	fi
> +
> +	cleanup_ns ${source_ns} ${sink_ns}
> +
> +	sysctl -qw kernel.softlockup_panic=${kernel_softlokup_panic_prev_val}
> +}
> +
> +setup_prepare() {
> +	setup_ns source_ns sink_ns
> +
> +	ip -n ${source_ns} link add name ${SOURCE_TEST_IFACE} type veth peer name ${SINK_TEST_IFACE} netns ${sink_ns}
> +
> +	# Setting up the Source namespace
> +	ip -n ${source_ns} addr add ${SOURCE_TEST_IP_ADDR} dev ${SOURCE_TEST_IFACE}
> +	ip -n ${source_ns} link set dev ${SOURCE_TEST_IFACE} qlen 10000
> +	ip -n ${source_ns} link set dev ${SOURCE_TEST_IFACE} up
> +	ip netns exec ${source_ns} sysctl -qw net.ipv6.fib_multipath_hash_policy=1
> +
> +	# Setting up the Sink namespace
> +	ip -n ${sink_ns} addr add ${SINK_LOOPBACK_IP_ADDR}/${SINK_LOOPBACK_IP_MASK} dev ${SINK_LOOPBACK_IFACE}
> +	ip -n ${sink_ns} link set dev ${SINK_LOOPBACK_IFACE} up
> +	ip netns exec ${sink_ns} sysctl -qw net.ipv6.conf.${SINK_LOOPBACK_IFACE}.forwarding=1
> +
> +	ip -n ${sink_ns} link set ${SINK_TEST_IFACE} up
> +	ip netns exec ${sink_ns} sysctl -qw net.ipv6.conf.${SINK_TEST_IFACE}.forwarding=1
> +
> +
> +	# Populating Nexthop IPv6 addresses on the test interface of the sink_ns namespace
> +	echo "info: populating ${IPV6_NEXTHOP_ADDR_COUNT} IPv6 addresses on the ${SINK_TEST_IFACE} interface ..."
> +	for IP in $(seq 1 ${IPV6_NEXTHOP_ADDR_COUNT}); do
> +		ip -n ${sink_ns} addr add ${IPV6_NEXTHOP_PREFIX}::$(printf "1:%x" "${IP}")/${IPV6_NEXTHOP_ADDR_MASK} dev ${SINK_TEST_IFACE};
> +	done
> +
> +	# Preparing list of nexthops
> +	for IP in $(seq 1 ${IPV6_NEXTHOP_ADDR_COUNT}); do
> +		nexthop_ip_list=$nexthop_ip_list" nexthop via ${IPV6_NEXTHOP_PREFIX}::$(printf "1:%x" $IP) dev ${SOURCE_TEST_IFACE} weight 1"
> +	done
> +}
> +
> +
> +test_soft_lockup_during_routing_table_refresh() {
> +	# Start num_of_iperf_servers iperf3 servers in the sink_ns namespace, each listening on ports
> +	# starting at 5001 and incrementing sequentially.
> +	echo "info: starting ${num_of_iperf_servers} iperf3 servers in the sink_ns namespace ..."
> +	for i in $(seq 1 ${num_of_iperf_servers}); do
> +		cmd="iperf3 --bind ${SINK_LOOPBACK_IP_ADDR} -s -p $(printf '5%03d' ${i}) > /dev/null 2>&1"
> +		ip netns exec ${sink_ns} bash -c "while true; do ${cmd}; done &"
> +	done
> +
> +	# Wait for a while for the iperf3 servers to become ready
> +	sleep 2

Use wait_local_port_listen() from net_helper.sh instead. You should 
probably extend it to look for the bind ip, too.

Thanks,

Paolo


