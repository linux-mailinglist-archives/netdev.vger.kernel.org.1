Return-Path: <netdev+bounces-149450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE729E5A31
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 16:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762F318817AE
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 15:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5FC21C164;
	Thu,  5 Dec 2024 15:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7WTE0hR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2161D515B
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413731; cv=none; b=cwMto5zfh4cnL0m0S2zUcaKYs0pROgZEaNWEV98ib78M3hRGJ6mayk8Lpt4KKFAWK/tS4+3qqg9GTOskoPE2k+6VJ4WkTNHp1J43t0PWBzHXYcn2lU5owBUGGwuhzXKL3ga0Y4whxkVPZp4KLMOW9DomBIzclaH1UYz1M42GrjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413731; c=relaxed/simple;
	bh=FVETqPaNbDJA0GbmT6XrNaS9JqjCL2hEt0mD7BWC3p0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=bdPUenmG5uYHFxX37oBFvHxVTpw/gEt/4o1Sff+TjzjYaI/onLcjvyd5HAQYoYAzza1YDzbEMzz65hJB9oHga8cudKCKUD9H8hUWTXA3ZDM9ZuY5DEwOElAufLS2vfpSjfujjFkqobzAr4MMMrgP+ZkvafeArrg6hlEAK8VfKhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7WTE0hR; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b65f2daae6so110337985a.1
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 07:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733413728; x=1734018528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tX2u4qfDrn/4zXFOMD3/KGXPVFWMSazAQdnVQPExMs4=;
        b=C7WTE0hRpb72Xs1wXunyN+RxKwKBV/Z67bAmlVhaKiVGIVPNMBzHEKzl6Sts06Zgwm
         5Bpwr7Y5//2mDj0/z68fLTzzkVNed1ScJK0rFJJFugqJ6eBPrSlh0YJVOBRW4Dis4Tya
         nh3DN5m06pHmef2V0cDLi5K3EaZC3k4og+ZD4n/3elxDWXCdarZ/snG1/6VIdrBjOO77
         sLzbrtiT7YBsjFQygbZpM3BV4kaTkm+QFvNAYhkJEivRD/sN+PnLTg//+IOQ+lKkkaA2
         dT2i0viOTuSlNLu9bRkgGMgspzvVdw8ebZhNMW5bzU0z96IPQAdfg5FLovt9tpkER+ly
         uaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733413728; x=1734018528;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tX2u4qfDrn/4zXFOMD3/KGXPVFWMSazAQdnVQPExMs4=;
        b=PVobmBXJ+W1oHXpTXeqlaJVWJ1ginGa/8qG3XbWv0p69Aypad6g7d3wR0SdrZkCFHR
         6S0HtMs5kSrvmk+wiHKZZmWydVRgAcy+9GjOJtdazKhtkUfQdhPfNl/X91zixfK0ehCl
         CCujXk7Pm3h6ZPSk+0yI99xRWR/Pb9nyNUqk3GvYRn/qZRx/VRimv8z/L7F4oj6lMXQC
         bdEtb9arQEIPYH+NrHm2YHuEjEMshnhXUsyvE/at89RZzTDwvQWK7WWeZsJIan//WKDN
         s0i40tQz0FKmsTQn5MH/OYbM1Msa7eIogbiWbvSwv2C+EtxCVsJwMN8c6FYdEemEbNfm
         sJuw==
X-Forwarded-Encrypted: i=1; AJvYcCXIS5c+Bh8TK32g7xjEtT80+H4xA4PBuEJy0ym5j/Il4ZZYWDtCjmEaL5nqWCo4L6WVNJxbeF0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzibnx/OKDJiP5OOCoGZy2BBkQ/t7jSCp0xc65Oa+8Pd1OURwzp
	n2QXN5eOAph7dsvNA0Wm/118YXbtF7xI622SGdJFzehp5SJGAWu1
X-Gm-Gg: ASbGncu5nFLZpLHKtbknDwOgMWEMbZ48f7xCo7KhAs0E/od19qT3bvSJrlbyrZljDRl
	OkoC1JD82ZbJvgwnX38pbVI2hepGdXCzZzLpAL/mKAtQmd/r3IqZoX8tmsH0fCwzWBzVfPJxOrM
	1M/Dtm1FtIyNCcBX8vqUXqRWg9SXex2F1v8M8gRTFCnaBK0A6cMWs8RBGZosYUnoZKkcrLcVokp
	B+kvXyvFK5BgtkGvjtEN5Cl1HgOlGehXuAVQak8w/UYybH7PsZ6JlKweSAKjpTEya+9U51hzvtO
	Ga9t3O9qWa7yOaa7nljwCA==
X-Google-Smtp-Source: AGHT+IGHGIfiwOx6OzfJICyk1Pek1ZkjsN9ntVSUtbivIgBiGVcOGoh7wxnEa26ZKy/+eBptc0nOZg==
X-Received: by 2002:a05:620a:1a26:b0:7b6:7332:f25e with SMTP id af79cd13be357-7b6a619acbfmr1445098785a.38.1733413728578;
        Thu, 05 Dec 2024 07:48:48 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6b5a9eb25sm70814685a.102.2024.12.05.07.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 07:48:47 -0800 (PST)
Date: Thu, 05 Dec 2024 10:48:47 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Anna Emese Nyiri <annaemesenyiri@gmail.com>, 
 netdev@vger.kernel.org
Cc: fejes@inf.elte.hu, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemb@google.com, 
 idosch@idosch.org, 
 Anna Emese Nyiri <annaemesenyiri@gmail.com>
Message-ID: <6751cb5f3c7d3_119ae629480@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241205133112.17903-4-annaemesenyiri@gmail.com>
References: <20241205133112.17903-1-annaemesenyiri@gmail.com>
 <20241205133112.17903-4-annaemesenyiri@gmail.com>
Subject: Re: [PATCH net-next v5 3/4] selftests: net: test SO_PRIORITY
 ancillary data with cmsg_sender
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Anna Emese Nyiri wrote:
> Extend cmsg_sender.c with a new option '-Q' to send SO_PRIORITY
> ancillary data.
> 
> cmsg_so_priority.sh script added to validate SO_PRIORITY behavior 
> by creating VLAN device with egress QoS mapping and testing packet
> priorities using flower filters. Verify that packets with different
> priorities are correctly matched and counted by filters for multiple
> protocols and IP versions.
> 
> Suggested-by: Ido Schimmel <idosch@idosch.org>
> Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
> ---
>  tools/testing/selftests/net/Makefile          |   1 +
>  tools/testing/selftests/net/cmsg_sender.c     |  11 +-
>  .../testing/selftests/net/cmsg_so_priority.sh | 151 ++++++++++++++++++
>  3 files changed, 162 insertions(+), 1 deletion(-)
>  create mode 100755 tools/testing/selftests/net/cmsg_so_priority.sh
> 
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index cb2fc601de66..f09bd96cc978 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -32,6 +32,7 @@ TEST_PROGS += ioam6.sh
>  TEST_PROGS += gro.sh
>  TEST_PROGS += gre_gso.sh
>  TEST_PROGS += cmsg_so_mark.sh
> +TEST_PROGS += cmsg_so_priority.sh
>  TEST_PROGS += cmsg_time.sh cmsg_ipv6.sh
>  TEST_PROGS += netns-name.sh
>  TEST_PROGS += nl_netdev.py
> diff --git a/tools/testing/selftests/net/cmsg_sender.c b/tools/testing/selftests/net/cmsg_sender.c
> index 876c2db02a63..99b0788f6f0c 100644
> --- a/tools/testing/selftests/net/cmsg_sender.c
> +++ b/tools/testing/selftests/net/cmsg_sender.c
> @@ -59,6 +59,7 @@ struct options {
>  		unsigned int proto;
>  	} sock;
>  	struct option_cmsg_u32 mark;
> +	struct option_cmsg_u32 priority;
>  	struct {
>  		bool ena;
>  		unsigned int delay;
> @@ -97,6 +98,8 @@ static void __attribute__((noreturn)) cs_usage(const char *bin)
>  	       "\n"
>  	       "\t\t-m val  Set SO_MARK with given value\n"
>  	       "\t\t-M val  Set SO_MARK via setsockopt\n"
> +	       "\t\t-P val  Set SO_PRIORITY via setsockopt\n"

Not in the actual code

> +	       "\t\t-Q val  Set SO_PRIORITY via cmsg\n"
>  	       "\t\t-d val  Set SO_TXTIME with given delay (usec)\n"
>  	       "\t\t-t      Enable time stamp reporting\n"
>  	       "\t\t-f val  Set don't fragment via cmsg\n"
> @@ -115,7 +118,7 @@ static void cs_parse_args(int argc, char *argv[])
>  {
>  	int o;
>  
> -	while ((o = getopt(argc, argv, "46sS:p:P:m:M:n:d:tf:F:c:C:l:L:H:")) != -1) {
> +	while ((o = getopt(argc, argv, "46sS:p:P:m:M:n:d:tf:F:c:C:l:L:H:Q:")) != -1) {
>  		switch (o) {
>  		case 's':
>  			opt.silent_send = true;
> @@ -148,6 +151,10 @@ static void cs_parse_args(int argc, char *argv[])
>  			opt.mark.ena = true;
>  			opt.mark.val = atoi(optarg);
>  			break;
> +		case 'Q':
> +			opt.priority.ena = true;
> +			opt.priority.val = atoi(optarg);
> +			break;
>  		case 'M':
>  			opt.sockopt.mark = atoi(optarg);
>  			break;
> @@ -252,6 +259,8 @@ cs_write_cmsg(int fd, struct msghdr *msg, char *cbuf, size_t cbuf_sz)
>  
>  	ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
>  			  SOL_SOCKET, SO_MARK, &opt.mark);
> +	ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
> +			SOL_SOCKET, SO_PRIORITY, &opt.priority);
>  	ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
>  			  SOL_IPV6, IPV6_DONTFRAG, &opt.v6.dontfrag);
>  	ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
> diff --git a/tools/testing/selftests/net/cmsg_so_priority.sh b/tools/testing/selftests/net/cmsg_so_priority.sh
> new file mode 100755
> index 000000000000..016458b219ba
> --- /dev/null
> +++ b/tools/testing/selftests/net/cmsg_so_priority.sh
> @@ -0,0 +1,151 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +source lib.sh
> +
> +IP4=192.0.2.1/24
> +TGT4=192.0.2.2
> +TGT4_RAW=192.0.2.3
> +IP6=2001:db8::1/64
> +TGT6=2001:db8::2
> +TGT6_RAW=2001:db8::3
> +PORT=1234
> +DELAY=4000
> +TOTAL_TESTS=0
> +FAILED_TESTS=0
> +
> +if ! command -v jq &> /dev/null; then
> +    echo "Error: jq is not installed." >&2
> +    exit 1

use KSFT_ and in these cases skip rather than fail.

> +fi
> +
> +check_result() {
> +    ((TOTAL_TESTS++))
> +    if [ "$1" -ne 0 ]; then
> +        ((FAILED_TESTS++))
> +    fi
> +}
> +
> +cleanup()
> +{
> +    cleanup_ns $NS
> +}
> +
> +trap cleanup EXIT
> +
> +setup_ns NS
> +
> +create_filter() {
> +    local handle=$1
> +    local vlan_prio=$2
> +    local ip_type=$3
> +    local proto=$4
> +    local dst_ip=$5
> +    local ip_proto
> +
> +    if [[ "$proto" == "u" ]]; then
> +        ip_proto="udp"
> +    elif [[ "$ip_type" == "ipv4" && "$proto" == "i" ]]; then
> +        ip_proto="icmp"
> +    elif [[ "$ip_type" == "ipv6" && "$proto" == "i" ]]; then
> +        ip_proto="icmpv6"
> +    fi
> +
> +    tc -n $NS filter add dev dummy1 \
> +        egress pref 1 handle "$handle" proto 802.1q \
> +        flower vlan_prio "$vlan_prio" vlan_ethtype "$ip_type" \
> +        dst_ip "$dst_ip" ${ip_proto:+ip_proto $ip_proto} \
> +        action pass
> +}
> +
> +ip -n $NS link set dev lo up
> +ip -n $NS link add name dummy1 up type dummy
> +
> +ip -n $NS link add link dummy1 name dummy1.10 up type vlan id 10 \
> +    egress-qos-map 0:0 1:1 2:2 3:3 4:4 5:5 6:6 7:7
> +
> +ip -n $NS address add $IP4 dev dummy1.10
> +ip -n $NS address add $IP6 dev dummy1.10
> +
> +ip netns exec $NS sysctl -wq net.ipv4.ping_group_range='0 2147483647'
> +
> +ip -n $NS neigh add $TGT4 lladdr 00:11:22:33:44:55 nud permanent \
> +    dev dummy1.10
> +ip -n $NS neigh add $TGT6 lladdr 00:11:22:33:44:55 nud permanent \
> +    dev dummy1.10
> +ip -n $NS neigh add $TGT4_RAW lladdr 00:11:22:33:44:66 nud permanent \
> +    dev dummy1.10
> +ip -n $NS neigh add $TGT6_RAW lladdr 00:11:22:33:44:66 nud permanent \
> +    dev dummy1.10
> +
> +tc -n $NS qdisc add dev dummy1 clsact
> +
> +FILTER_COUNTER=10
> +
> +for i in 4 6; do
> +    for proto in u i r; do
> +        echo "Test IPV$i, prot: $proto"
> +        for priority in {0..7}; do
> +            if [[ $i == 4 && $proto == "r" ]]; then
> +                TGT=$TGT4_RAW
> +            elif [[ $i == 6 && $proto == "r" ]]; then
> +                TGT=$TGT6_RAW
> +            elif [ $i == 4 ]; then
> +                TGT=$TGT4
> +            else
> +                TGT=$TGT6
> +            fi
> +
> +            handle="${FILTER_COUNTER}${priority}"
> +
> +            create_filter $handle $priority ipv$i $proto $TGT
> +
> +            pkts=$(tc -n $NS -j -s filter show dev dummy1 egress \
> +                | jq ".[] | select(.options.handle == ${handle}) | \
> +                .options.actions[0].stats.packets")
> +
> +            if [[ $pkts == 0 ]]; then
> +                check_result 0
> +            else
> +                echo "prio $priority: expected 0, got $pkts"
> +                check_result 1
> +            fi
> +
> +            ip netns exec $NS ./cmsg_sender -$i -Q $priority -d "${DELAY}" \
> +	            -p $proto $TGT $PORT
> +
> +            pkts=$(tc -n $NS -j -s filter show dev dummy1 egress \
> +                | jq ".[] | select(.options.handle == ${handle}) | \
> +                .options.actions[0].stats.packets")
> +            if [[ $pkts == 1 ]]; then
> +                check_result 0
> +            else
> +                echo "prio $priority -Q: expected 1, got $pkts"
> +                check_result 1
> +            fi
> +
> +            ip netns exec $NS ./cmsg_sender -$i -P $priority -d "${DELAY}" \
> +	            -p $proto $TGT $PORT
> +
> +            pkts=$(tc -n $NS -j -s filter show dev dummy1 egress \
> +                | jq ".[] | select(.options.handle == ${handle}) | \
> +                .options.actions[0].stats.packets")
> +            if [[ $pkts == 2 ]]; then
> +                check_result 0
> +            else
> +                echo "prio $priority -P: expected 2, got $pkts"
> +                check_result 1
> +            fi
> +        done
> +        FILTER_COUNTER=$((FILTER_COUNTER + 10))
> +    done
> +done
> +
> +if [ $FAILED_TESTS -ne 0 ]; then
> +    echo "FAIL - $FAILED_TESTS/$TOTAL_TESTS tests failed"
> +    exit 1
> +else
> +    echo "OK - All $TOTAL_TESTS tests passed"
> +    exit 0
> +fi
> +
> -- 
> 2.43.0
> 



