Return-Path: <netdev+bounces-241542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1327DC85763
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 15:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA923AB21D
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 14:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5A1325725;
	Tue, 25 Nov 2025 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rzxbj8aq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ORm37aIE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93179326920
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 14:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764081612; cv=none; b=iISs82KjdyYJCKpTJwZd0rN5j+SMX+itFeWwInd7VM4Yx5cKr8m92qkN8+pW1kXhl3lvD62ITbSKIRd/qnEVUu43neYntAER/XBWRKidYDHMRYSuz0dkAftwoxliBDPmiebKitHvnGQBTXJaXgKAeUfhlh8B8i5gbtyofwIZnXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764081612; c=relaxed/simple;
	bh=q1IiVjIt9YL3X0z8+fKySuASLmhHi9xnE3naPm0SRvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JpK0iB/dKURRhlzsrrntddDyh1j24ZlBe3ijLrV+RmA0AIx99symKxhcsPFC6LxWMhqeQzWBMatv9x9pVZwaWF3HQydaWdloe7AgnzXSZiv4kXXaC3aA33QVHF4U+3C1sJuTzafkrBsD+vEW5IsKKJncX2dn3Qroysooiegc6bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rzxbj8aq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ORm37aIE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764081609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I5ogNRULO41Q+K2Bde0Qs6KvHkLMydku4fyWWl5Godc=;
	b=Rzxbj8aqxkLqmEXTLOCwNboJzxRwtqAn7KdGWB/bO6MEWUl0rOJtr2CVyQSnfjbBgbx32x
	3L+RX02jaxwN6Z2LUJ2+pJjGjlM5dmtsMQ6Ui8mrbOuYocvuDCfXGYHTpVj4mCg8WzMP2v
	qv6i7lEXhwsX579gqjn2GX6Dx528Xzk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-qrC6evJIO1Ct1ZrW6yJvWw-1; Tue, 25 Nov 2025 09:40:05 -0500
X-MC-Unique: qrC6evJIO1Ct1ZrW6yJvWw-1
X-Mimecast-MFC-AGG-ID: qrC6evJIO1Ct1ZrW6yJvWw_1764081605
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-429cbed2b8fso3125064f8f.1
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 06:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764081604; x=1764686404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I5ogNRULO41Q+K2Bde0Qs6KvHkLMydku4fyWWl5Godc=;
        b=ORm37aIE/hxaLvSR/YAMQfjWvOwz/Argor4bSlUsU8QpVaDppt4X8iZKeSOEszHOeq
         bC9ctR8zrNuu//Oo1AQ8c8WbalLZ/kzY5h5b+AmPqpnJVtzvTt6Sxw3FKIF15zgw0Lxf
         ryOOIKy8WIdV0n1dNUNIdt4T5Kbp2hpApP6SMdRy5y+WRPkCyOHCSCMeubeAGcS2HYcC
         LAPwRc7c7Ml01EsGgTSRdsVzOUC+pAlHgymEytgaWMDF0E9ev00yYFt+q6U2TP5iIx6q
         lWou1Ys0+cTtlwLa1zUHynE1BPHnI+ccQINwf6B5jAGoSyTbGX4cjFYUzaKdEz5UwjTH
         sLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764081604; x=1764686404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5ogNRULO41Q+K2Bde0Qs6KvHkLMydku4fyWWl5Godc=;
        b=KJ7bJLr2PoC/pN8cbIaED5V1x09LeAm0jUIGIyvL5D7Xspdzz5bwziAnKuWMBNZwev
         MloX8c5PtOOGlUMIdKW0nz8fYx9CPY/DX8otGaOhNQQpPwZz5NeDx/Xq1JxQZ0RkwXTL
         dzve84WHr6aN+VTmuaNY3S4camD3uv4ZFCQdA5pdhoift8OG73zvugIKtm8f384I0s8F
         FVRjKIxVkvygde8WDVjRzKEg5r8yJ7BE1EcQHTQ0gYVsXZ9pWkIVgRioGh+08AlyfW5X
         IC8uHpAKaBpgFMXHAGdRHg5xSVDePVU4BN25gNbw5k5tR6zgmdZZsrSZZfrBEWhmWd9n
         JJCw==
X-Forwarded-Encrypted: i=1; AJvYcCUJnYwjLtx3GYaJZ1GwxRx0K6rjXQgSfNDM3QvbbFjQ6AqedSIFgOMmSonGliCmWniR+jzZnOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyExadavbfQcKk1pcryrliFfLkCc9OjQn2km/ZqBphFlCa4zlt2
	18G6sFHt6kvxm2ugBJevFxnSd3H3fyj3ALcGyo/aGafJ2S98BCV2KxglxnY7HURfoFw3X/C/ThP
	PiTMEO4efwAUfin8Ei8vu3ecgJi9TFpu8f5Uuk8Eeq062Fwhx/VyDADczCQ==
X-Gm-Gg: ASbGncuX8GyxWDGkLsMVt1osV3qPZ5vcU61zmBGcMVnjISFpWfFK+w7YZYzhBP5y2ES
	QcC/5KHH8+/6Fde8XgKoGwNkZao12a33tAJOYp0vMszam5vhMJ6eZ43PfXM5KuZNm05x45zTUdd
	zajuxaSxW7lvi87tliMOx/qPhPju2yfG0RqqUDWPT/gg3eXSA83wJohNHKnWulGooS+SWCCsNFD
	YoXhzy6DvwBWVt6u4BDDOP8C9gOD8PfySUOJUANUYNCW4bkIU8hAxJYVnsG5+YoPUWBUU+H9/1k
	z2PC4BkbA+wfIaMNdMwizFSkHuk6699RcZ4Pwqi0Nn+w3jrsgkIfN9yPr0GX3BRbSJDW45ep3ps
	=
X-Received: by 2002:a05:600c:840f:b0:477:952d:fc00 with SMTP id 5b1f17b1804b1-477c0176752mr182829075e9.12.1764081604582;
        Tue, 25 Nov 2025 06:40:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE61ZQMvheL9QSNtpZPlW4HtLiNOD7Dc5SwbcJjYNes5UJ3YLVDfBHcBGJWoI19GxB3WPyx7Q==
X-Received: by 2002:a05:600c:840f:b0:477:952d:fc00 with SMTP id 5b1f17b1804b1-477c0176752mr182828715e9.12.1764081604183;
        Tue, 25 Nov 2025 06:40:04 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47906cb9715sm15413665e9.2.2025.11.25.06.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 06:40:03 -0800 (PST)
Message-ID: <0550ee33-ce43-4703-966d-c112e774e6ce@redhat.com>
Date: Tue, 25 Nov 2025 15:40:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 12/12] selftests: net: selftest for ipvlan-macnat
 mode
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>, netdev@vger.kernel.org,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: andrey.bokhanko@huawei.com, edumazet@google.com,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Shuah Khan <shuah@kernel.org>
References: <20251120174949.3827500-1-skorodumov.dmitry@huawei.com>
 <20251120174949.3827500-13-skorodumov.dmitry@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251120174949.3827500-13-skorodumov.dmitry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/25 6:49 PM, Dmitry Skorodumov wrote:
> diff --git a/tools/testing/selftests/net/ipvtap_macnat_bridge.py b/tools/testing/selftests/net/ipvtap_macnat_bridge.py
> new file mode 100755
> index 000000000000..7dc4a626e5bb
> --- /dev/null
> +++ b/tools/testing/selftests/net/ipvtap_macnat_bridge.py
[...]
> +    TAP = sys.argv[1]
> +    IPVTAP = sys.argv[2]
> +
> +    print(f"Starting TAP bridge between {TAP} and {IPVTAP} in {ns_name}")
> +    bridge = TapBridge(TAP, IPVTAP)
> +    bridge.run()

This is not a complete review, but you need to add CONFIG_IPVTAP and
CONFIG_TAP to tools/testing/selftests/net/config.

> diff --git a/tools/testing/selftests/net/ipvtap_macnat_test.sh b/tools/testing/selftests/net/ipvtap_macnat_test.sh
> new file mode 100755
> index 000000000000..927d75af776b
> --- /dev/null
> +++ b/tools/testing/selftests/net/ipvtap_macnat_test.sh
> @@ -0,0 +1,333 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Tests for ipvtap in macnat mode
> +
> +NS_TST0=ipvlan-tst-0
> +NS_TST1=ipvlan-tst-1
> +NS_PHY=ipvlan-tst-phy

Please use lib.sh / setup_ns instead, to avoid netns name conflicts and
leverage automatic cleanup

> +
> +IP_HOST=172.25.0.1
> +IP_PHY=172.25.0.2
> +IP_TST0=172.25.0.10
> +IP_TST1=172.25.0.30
> +
> +IP_OK0=("172.25.0.10" "172.25.0.11" "172.25.0.12" "172.25.0.13")
> +IP6_OK0=("fc00::10" "fc00::11" "fc00::12" "fc00::13" )
> +
> +IP_OVFL0="172.25.0.14"
> +IP6_OVFL0="fc00::14"
> +
> +IP6_HOST=fc00::1
> +IP6_PHY=fc00::2
> +IP6_TST0=fc00::10
> +IP6_TST1=fc00::30
> +
> +MAC_HOST="92:3a:00:00:00:01"
> +MAC_PHY="92:3a:00:00:00:02"
> +MAC_TST0="92:3a:00:00:00:10"
> +MAC_TST1="92:3a:00:00:00:30"
> +
> +VETH_HOST=vethtst
> +VETH_PHY=vethtst.p
> +
> +#
> +# The testing environment looks this way:
> +#
> +# |------HOST------|     |------PHY-------|
> +# |      veth<----------------->veth      |
> +# |------|--|------|     |----------------|
> +#        |  |
> +#        |  |            |-----TST0-------|
> +#        |  |------------|----ipvtap      |
> +#        |               |----------------|
> +#        |
> +#        |               |-----TST1-------|
> +#        |---------------|----ivtap       |
> +#                        |----------------|
> +#
> +# The macnat mode is for virtual machines, so ipvtap-interface is supposed
> +# to be used only for traffic monitoring and doesn't have ip-address.
> +#
> +# To simulate a virtual machine on ipvtap, we create TAP-interfaces
> +# in TST environments and assing IP-addresses to them.
> +# TAP and IPVTAP are connected with simple python script.
> +#
> +
> +ns_run() {
> +	ns=$1
> +	shift
> +	if [[ "$ns" == "default" ]]; then
> +		"$@" >/dev/null
> +	else
> +		ip netns exec "$ns" "$@" >/dev/null
> +	fi
> +}
> +
> +configure_ns() {
> +	local ns=$1
> +	local n=$2
> +	local ip=$3
> +	local ip6=$4
> +	local mac=$5
> +
> +	ns_run "$ns" ip link set lo up
> +
> +	if ! ip link add netns "$ns" name "ipvtap0.$n" link $VETH_HOST \
> +	    type ipvtap mode l2macnat bridge; then
> +		exit_error "FAIL: Failed to configure ipvtap link."
> +	fi
> +	ns_run "$ns" ip link set "ipvtap0.$n" up
> +
> +	ns_run "$ns" ip tuntap add mode tap "tap0.$n"
> +	ns_run "$ns" ip link set dev "tap0.$n" address "$mac"
> +	# disable dad
> +	ns_run "$ns" sysctl -w "net/ipv6/conf/tap0.$n/accept_dad"=0
> +	ns_run "$ns" ip link set "tap0.$n" up
> +	ns_run "$ns" ip a a "$ip/24" dev "tap0.$n"
> +	ns_run "$ns" ip a a "$ip6/64" dev "tap0.$n"
> +}
> +
> +start_macnat_bridge() {
> +	local ns=$1
> +	local n=$2
> +	ip netns exec "$ns" python3 ipvtap_macnat_bridge.py \
> +		"tap0.$n" "ipvtap0.$n" &
> +}
> +
> +configure_veth() {
> +	local ns=$1
> +	local veth=$2
> +	local ip=$3
> +	local ip6=$4
> +	local mac=$5
> +
> +	ns_run "$ns" ip link set lo up
> +	ns_run "$ns" ethtool -K "$veth" tx off rx off
> +	ns_run "$ns" ip link set dev "$veth" address "$mac"
> +	ns_run "$ns" ip link set "$veth" up
> +	ns_run "$ns" ip a a "$ip/24" dev "$veth"
> +	ns_run "$ns" ip a a "$ip6/64" dev "$veth"
> +}
> +
> +setup_env() {
> +	ip netns add $NS_TST0
> +	ip netns add $NS_TST1
> +	ip netns add $NS_PHY
> +
> +	# setup simulated other-host (phy) and host itself
> +	ip link add $VETH_HOST type veth peer name $VETH_PHY \
> +	    netns $NS_PHY >/dev/null
> +
> +	# host config
> +	configure_veth default $VETH_HOST $IP_HOST $IP6_HOST $MAC_HOST
> +	configure_veth $NS_PHY $VETH_PHY $IP_PHY $IP6_PHY $MAC_PHY
> +
> +	# TST namespaces config
> +	configure_ns $NS_TST0 0 $IP_TST0 $IP6_TST0 $MAC_TST0
> +	configure_ns $NS_TST1 1 $IP_TST1 $IP6_TST1 $MAC_TST1
> +}
> +
> +ping_all() {
> +	# This will learn MAC/IP addresses on ipvtap
> +	local ns=$1
> +
> +	ns_run "$ns" ping -c 1 $IP_TST0
> +	ns_run "$ns" ping -c 1 $IP6_TST0
> +
> +	ns_run "$ns" ping -c 1 $IP_TST1
> +	ns_run "$ns" ping -c 1 $IP6_TST1
> +
> +	ns_run "$ns" ping -c 1 $IP_HOST
> +	ns_run "$ns" ping -c 1 $IP6_HOST
> +
> +	ns_run "$ns" ping -c 1 $IP_PHY
> +	ns_run "$ns" ping -c 1 $IP6_PHY
> +}
> +
> +check_mac_eq() {
> +	# Ensure IP corresponds to MAC.
> +	local ns=$1
> +	local ip=$2
> +	local mac=$3
> +	local dev=$4
> +
> +	if [[ "$ns" == "default" ]]; then
> +		out=$(
> +			ip neigh show "$ip" dev "$dev" \
> +			| grep "$ip" \
> +			| grep "$mac"
> +		)
> +	else
> +		out=$(
> +			ip netns exec "$ns" \
> +			ip neigh show "$ip" dev "$dev" \
> +			| grep "$ip" \
> +			| grep "$mac"
> +		)
> +	fi
> +
> +	if [[ $out'X' == "X" ]]; then
> +		exit_error "FAIL: '$ip' is not '$mac'"
> +	fi
> +}
> +
> +cleanup_env() {
> +	ip link del $VETH_HOST
> +	ip netns del $NS_TST0
> +	ip netns del $NS_TST1
> +	ip netns del $NS_PHY
> +}
> +
> +exit_error() {
> +	echo "$1"
> +	exit 1

It would be better to try to run all the test-cases and return a single
fail/success code. lib.sh can help with that. too.

/P


