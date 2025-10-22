Return-Path: <netdev+bounces-231901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB16BFE628
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 00:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BC1D18C512C
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 22:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDCA30596F;
	Wed, 22 Oct 2025 22:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+qTnGPB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ED42F83B4
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 22:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761171139; cv=none; b=J0JOYkAj2zyS+fCnMR0uRKqQZ0elgPxBgoTZSzb/iGfR4yDqNAGwIcWNsXS6lVP9Ajk4LI1KomUX9+yEk45tYN63TPhlGRetFNGzN2tD11e746f8p5lzhjw1AOG0w/gmzxbf9dYZNENItMicaZ3HG4J1U6ljtd+M+aMyObCOiGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761171139; c=relaxed/simple;
	bh=aH8/QoAeZbjuMMtVo6c36UUkYisvUTW8xEVf8iY5XN8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=tTk3tYxxH6vCCpOBXNDuYMEUGskYweJOxPZ2li/f6JBAB01Rd2RYF/LQmtEIcBvMIyX6chWRm+pHKfjveWE3kSjruzMe4/7bZJHAeBiTKoyZdpxRsTr38U6gmKgs75imBUQls0lV+CzWtsDw6pUVf/VXsREzEV5YAi2daL9AEAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+qTnGPB; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-932cf836259so37588241.3
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 15:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761171135; x=1761775935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZUlI5bJOWFbnFWQNSXbU5YHtmetQLgkMBOlFgr9g1w=;
        b=i+qTnGPBtJxRCyXj4hIQUhJgmSXrTSwTJ7ke7qqagrsxN6cyHck8NxIkN+6kiRKSrE
         WTUu/PJAqeHPOA7tJm5DeUJRsK4Tz86j8X2UZOXL5daLqY/e3h+1+PTMGs8FyoOOUcje
         ZDahTMu7ob4RtURoAQzuZq5b4CcR8CQFBBhglBkFm/bCK4sn1UISe91TUDQx5hK0NJ7H
         o3dHCV70k9+Ui/3qBo2JazT2gGV0MyVARc1XvnxmQk7D4y0GlVeHt0evgznTMsc+MnPg
         zkCJrcHlt2AAbw06tbl4pcrUzSCklscj3PDn9ljLc1GdEtbX4yfhomH5e2a8nDjvhvCr
         WSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761171135; x=1761775935;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JZUlI5bJOWFbnFWQNSXbU5YHtmetQLgkMBOlFgr9g1w=;
        b=wkPMchT2pM7KLlCC/etefTh1iZOqEf8CvTPZ5Dorjz42i8Y8yBM8FxQRTxn0z68bSr
         XWztW7JOncoErWOBawqqcAzuWh6ruXLiTxfz5gb56psvFljK76dcrXC6Ob5f2pRXdbgC
         NHY1DdJYlZVwi2bxEC0mQAin2vQVkNQV1olsa0Pm9Rj6p8dkOvA4jX8fHx0mBcAbXSn/
         9PXiwKaiQ3ZrT31LYDrpGO2K8nU71/AjsKFeVHZUEOOWFvNgjPUXLTbKSSW/JYzFmE/V
         Alz7fXc/IrnLR/MM5D5/fut/TzIMGtavEdq0jZHF+fVlHuPZuI3rg/G+6GsOVqssSLqr
         E0vQ==
X-Forwarded-Encrypted: i=1; AJvYcCXavQd2myw5V4x7iud5JH0pcK2oB8+jLB7b8EuUDsYHO5goag3ed9uO+4XkyaGcrGGsEe2FTpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLeWI0UqWIgmckO1yRk2U8lDDDKgXEy+rCIMWKCCqLIk4xfV6z
	/H0yr3SUahIMf9y9VZHTkZkHZ6pMLjaPRSbwcpmu8by9DEMEuJ51YBGd
X-Gm-Gg: ASbGncuYKmP51JnRsSOlF7+LCS4x1XXqtvOw/88F1SwjFzpxnfrMCRjPnI0khq8IAgT
	eOeVRxTLVZE9DjOtbyNVqX4+/TwsB8v20IFWkf0O7oBv8qJYYAADxOPZXUcbR4UD0A28r4gJBxo
	uEB1/OT6IGR5jUF3ENDqP6TK888258fIEuCSvV5j0y44lkZNYf6ll8hJgE1N/Ehpm2BHY+Q9XF4
	3KmgDvGr8lndRbHXnWfu3fe438TDpaAo1f7bvjgqkroDDdzvO29xPKt5PRFWslbUF36FdH2SDUB
	x58ocm/rIzcJVO2Bn0sk56506e/ymdPtThCj8/t4FPkrNxwb4GGhjspKD9oIaq9sPJTzXKdr6dE
	8GVzJs7OwpcCDplFTX1J7904UzVF+j7IddAr92zbgAcs+NjrITNZphQxPUmmMGbOBRj7PnOi7wr
	gqnd1duqqxJIPGKhSo/uRSnzUxfsXeodTr34iOOWYNb+1bSZnsTWEu3vm8loIzHJY=
X-Google-Smtp-Source: AGHT+IE0myS0kH6Rw7P/ZFDClEv2+53/sTIASE10hhWRFySzdgRF/dAvvWemAoOpuGY7nSvwEaVKcA==
X-Received: by 2002:a05:6102:4bca:b0:5a1:8e46:5c92 with SMTP id ada2fe7eead31-5db2e478406mr67135137.14.1761171134792;
        Wed, 22 Oct 2025 15:12:14 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id ada2fe7eead31-5db2cca25a9sm155964137.14.2025.10.22.15.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 15:12:14 -0700 (PDT)
Date: Wed, 22 Oct 2025 18:12:13 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 edumazet@google.com, 
 horms@kernel.org, 
 dsahern@kernel.org, 
 petrm@nvidia.com, 
 willemb@google.com, 
 daniel@iogearbox.net, 
 fw@strlen.de, 
 ishaangandhi@gmail.com, 
 rbonica@juniper.net, 
 tom@herbertland.com, 
 Ido Schimmel <idosch@nvidia.com>
Message-ID: <willemdebruijn.kernel.2a6712077e40c@gmail.com>
In-Reply-To: <20251022065349.434123-4-idosch@nvidia.com>
References: <20251022065349.434123-1-idosch@nvidia.com>
 <20251022065349.434123-4-idosch@nvidia.com>
Subject: Re: [PATCH net-next 3/3] selftests: traceroute: Add ICMP extensions
 tests
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Ido Schimmel wrote:
> Test that ICMP extensions are reported correctly when enabled and not
> reported when disabled. Test both IPv4 and IPv6 and using different
> packet sizes, to make sure trimming / padding works correctly.
> 
> Disable ICMP rate limiting (defaults to 1 per-second per-target) so that
> the kernel will always generate ICMP errors when needed.

This reminds me that when I added SOL_IP/IP_RECVERR_4884, the selftest
was not integrated into kselftests. Commit eba75c587e81 points to

https://github.com/wdebruij/kerneltools/blob/master/tests/recv_icmp_v2.c

It might be useful to verify that the kernel recv path that parses
RFC 4884 compliant ICMP messages correctly handles these RFC 4884
messages.

But traceroute parsing the data is sufficient validation that packet
generation is compliant with the RFCs.

> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  tools/testing/selftests/net/traceroute.sh | 280 ++++++++++++++++++++++
>  1 file changed, 280 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/traceroute.sh b/tools/testing/selftests/net/traceroute.sh
> index dbb34c7e09ce..a57c61bd0b25 100755
> --- a/tools/testing/selftests/net/traceroute.sh
> +++ b/tools/testing/selftests/net/traceroute.sh
> @@ -59,6 +59,8 @@ create_ns()
>  	ip netns exec ${ns} ip -6 ro add unreachable default metric 8192
>  
>  	ip netns exec ${ns} sysctl -qw net.ipv4.ip_forward=1
> +	ip netns exec ${ns} sysctl -qw net.ipv4.icmp_ratelimit=0
> +	ip netns exec ${ns} sysctl -qw net.ipv6.icmp.ratelimit=0
>  	ip netns exec ${ns} sysctl -qw net.ipv6.conf.all.keep_addr_on_down=1
>  	ip netns exec ${ns} sysctl -qw net.ipv6.conf.all.forwarding=1
>  	ip netns exec ${ns} sysctl -qw net.ipv6.conf.default.forwarding=1
> @@ -297,6 +299,142 @@ run_traceroute6_vrf()
>  	cleanup_traceroute6_vrf
>  }
>  
> +################################################################################
> +# traceroute6 with ICMP extensions test
> +#
> +# Verify that in this scenario
> +#
> +# ----                          ----                          ----
> +# |H1|--------------------------|R1|--------------------------|H2|
> +# ----            N1            ----            N2            ----
> +#
> +# ICMP extensions are correctly reported. The loopback interfaces on all the
> +# nodes are assigned global addresses and the interfaces connecting the nodes
> +# are assigned IPv6 link-local addresses.
> +
> +cleanup_traceroute6_ext()
> +{
> +	cleanup_all_ns
> +}
> +
> +setup_traceroute6_ext()
> +{
> +	# Start clean
> +	cleanup_traceroute6_ext
> +
> +	setup_ns h1 r1 h2
> +	create_ns "$h1"
> +	create_ns "$r1"
> +	create_ns "$h2"
> +
> +	# Setup N1
> +	connect_ns "$h1" eth1 - fe80::1/64 "$r1" eth1 - fe80::2/64
> +	# Setup N2
> +	connect_ns "$r1" eth2 - fe80::3/64 "$h2" eth2 - fe80::4/64
> +
> +	# Setup H1
> +	ip -n "$h1" address add 2001:db8:1::1/128 dev lo

nodad or not needed in this lo special case?

> +	ip -n "$h1" route add ::/0 nexthop via fe80::2 dev eth1
> +
> +	# Setup R1
> +	ip -n "$r1" address add 2001:db8:1::2/128 dev lo
> +	ip -n "$r1" route add 2001:db8:1::1/128 nexthop via fe80::1 dev eth1
> +	ip -n "$r1" route add 2001:db8:1::3/128 nexthop via fe80::4 dev eth2
> +
> +	# Setup H2
> +	ip -n "$h2" address add 2001:db8:1::3/128 dev lo
> +	ip -n "$h2" route add ::/0 nexthop via fe80::3 dev eth2
> +
> +	# Prime the network
> +	ip netns exec "$h1" ping6 -c5 2001:db8:1::3 >/dev/null 2>&1
> +}
> +
> +traceroute6_ext_iio_iif_test()
> +{
> +	local r1_ifindex h2_ifindex
> +	local pkt_len=$1; shift
> +
> +	# Test that incoming interface info is not appended by default.
> +	run_cmd "$h1" "traceroute6 -e 2001:db8:1::3 $pkt_len | grep INC"
> +	check_fail $? "Incoming interface info appended by default when should not"
> +
> +	# Test that the extension is appended when enabled.
> +	run_cmd "$r1" "sysctl -w net.ipv6.icmp.errors_extension_mask=0x01"
> +	check_err $? "Failed to enable incoming interface info extension on R1"
> +
> +	run_cmd "$h1" "traceroute6 -e 2001:db8:1::3 $pkt_len | grep INC"
> +	check_err $? "Incoming interface info not appended after enable"
> +
> +	# Test that the extension is not appended when disabled.
> +	run_cmd "$r1" "sysctl -w net.ipv6.icmp.errors_extension_mask=0x00"
> +	check_err $? "Failed to disable incoming interface info extension on R1"
> +
> +	run_cmd "$h1" "traceroute6 -e 2001:db8:1::3 $pkt_len | grep INC"
> +	check_fail $? "Incoming interface info appended after disable"
> +
> +	# Test that the extension is sent correctly from both R1 and H2.
> +	run_cmd "$r1" "sysctl -w net.ipv6.icmp.errors_extension_mask=0x01"
> +	r1_ifindex=$(ip -n "$r1" -j link show dev eth1 | jq '.[]["ifindex"]')
> +	run_cmd "$h1" "traceroute6 -e 2001:db8:1::3 $pkt_len | grep '<INC:$r1_ifindex,\"eth1\",mtu=1500>'"
> +	check_err $? "Wrong incoming interface info reported from R1"
> +
> +	run_cmd "$h2" "sysctl -w net.ipv6.icmp.errors_extension_mask=0x01"
> +	h2_ifindex=$(ip -n "$h2" -j link show dev eth2 | jq '.[]["ifindex"]')
> +	run_cmd "$h1" "traceroute6 -e 2001:db8:1::3 $pkt_len | grep '<INC:$h2_ifindex,\"eth2\",mtu=1500>'"
> +	check_err $? "Wrong incoming interface info reported from H2"
> +
> +	# Add a global address on the incoming interface of R1 and check that
> +	# it is reported.
> +	run_cmd "$r1" "ip address add 2001:db8:100::1/64 dev eth1 nodad"
> +	run_cmd "$h1" "traceroute6 -e 2001:db8:1::3 $pkt_len | grep '<INC:$r1_ifindex,2001:db8:100::1,\"eth1\",mtu=1500>'"
> +	check_err $? "Wrong incoming interface info reported from R1 after address addition"
> +	run_cmd "$r1" "ip address del 2001:db8:100::1/64 dev eth1"
> +
> +	# Change name and MTU and make sure the result is still correct.
> +	run_cmd "$r1" "ip link set dev eth1 name eth1tag mtu 1501"
> +	run_cmd "$h1" "traceroute6 -e 2001:db8:1::3 $pkt_len | grep '<INC:$r1_ifindex,\"eth1tag\",mtu=1501>'"
> +	check_err $? "Wrong incoming interface info reported from R1 after name and MTU change"
> +	run_cmd "$r1" "ip link set dev eth1tag name eth1 mtu 1500"
> +
> +	run_cmd "$r1" "sysctl -w net.ipv6.icmp.errors_extension_mask=0x00"
> +	run_cmd "$h2" "sysctl -w net.ipv6.icmp.errors_extension_mask=0x00"
> +}
> +
> +run_traceroute6_ext()
> +{
> +	if ! traceroute6 --help 2>&1 | grep -q "\--extensions"; then
> +		log_test_skip "traceroute6 too old, missing ICMP extensions support"
> +		return
> +	fi
> +
> +	setup_traceroute6_ext
> +
> +	RET=0
> +
> +	## General ICMP extensions tests
> +
> +	# Test that ICMP extensions are disabled by default.
> +	run_cmd "$h1" "sysctl net.ipv6.icmp.errors_extension_mask | grep \"= 0$\""
> +	check_err $? "ICMP extensions are not disabled by default"
> +
> +	# Test that unsupported values are rejected.
> +	run_cmd "$h1" "sysctl -w net.ipv6.icmp.errors_extension_mask=0x80"
> +	check_fail $? "Unsupported sysctl value was not rejected"
> +
> +	## Extension-specific tests
> +
> +	# Incoming interface info test. Test with various packet sizes,
> +	# including the default one.
> +	traceroute6_ext_iio_iif_test
> +	traceroute6_ext_iio_iif_test 127
> +	traceroute6_ext_iio_iif_test 128
> +	traceroute6_ext_iio_iif_test 129
> +
> +	log_test "IPv6 traceroute with ICMP extensions"
> +
> +	cleanup_traceroute6_ext
> +}
> +
>  ################################################################################
>  # traceroute test
>  #
> @@ -437,6 +575,145 @@ run_traceroute_vrf()
>  	cleanup_traceroute_vrf
>  }
>  
> +################################################################################
> +# traceroute with ICMP extensions test
> +#
> +# Verify that in this scenario
> +#
> +# ----                          ----                          ----
> +# |H1|--------------------------|R1|--------------------------|H2|
> +# ----            N1            ----            N2            ----
> +#
> +# ICMP extensions are correctly reported. The loopback interfaces on all the
> +# nodes are assigned global addresses and the interfaces connecting the nodes
> +# are assigned IPv6 link-local addresses.
> +
> +cleanup_traceroute_ext()
> +{
> +	cleanup_all_ns
> +}
> +
> +setup_traceroute_ext()
> +{
> +	# Start clean
> +	cleanup_traceroute_ext
> +
> +	setup_ns h1 r1 h2
> +	create_ns "$h1"
> +	create_ns "$r1"
> +	create_ns "$h2"
> +
> +	# Setup N1
> +	connect_ns "$h1" eth1 - fe80::1/64 "$r1" eth1 - fe80::2/64
> +	# Setup N2
> +	connect_ns "$r1" eth2 - fe80::3/64 "$h2" eth2 - fe80::4/64

Stray IPv6 addresses in this IPv4 test?

As a matter of fact, is it feasible to merge the IPv4 and IPv6 tests
with some basic variables like $TRACEROUTE, $SYSCTL_PATH and $ADDR?

(I appreciate that you spent more time looking at that, fine to leave
if it is not practical to do so.)

> +
> +	# Setup H1
> +	ip -n "$h1" address add 192.0.2.1/32 dev lo
> +	ip -n "$h1" route add 0.0.0.0/0 nexthop via inet6 fe80::2 dev eth1
> +
> +	# Setup R1
> +	ip -n "$r1" address add 192.0.2.2/32 dev lo
> +	ip -n "$r1" route add 192.0.2.1/32 nexthop via inet6 fe80::1 dev eth1
> +	ip -n "$r1" route add 192.0.2.3/32 nexthop via inet6 fe80::4 dev eth2
> +
> +	# Setup H2
> +	ip -n "$h2" address add 192.0.2.3/32 dev lo
> +	ip -n "$h2" route add 0.0.0.0/0 nexthop via inet6 fe80::3 dev eth2
> +
> +	# Prime the network
> +	ip netns exec "$h1" ping -c5 192.0.2.3 >/dev/null 2>&1
> +}
> +
> +traceroute_ext_iio_iif_test()
> +{
> +	local r1_ifindex h2_ifindex
> +	local pkt_len=$1; shift
> +
> +	# Test that incoming interface info is not appended by default.
> +	run_cmd "$h1" "traceroute -e 192.0.2.3 $pkt_len | grep INC"
> +	check_fail $? "Incoming interface info appended by default when should not"
> +
> +	# Test that the extension is appended when enabled.
> +	run_cmd "$r1" "sysctl -w net.ipv4.icmp_errors_extension_mask=0x01"
> +	check_err $? "Failed to enable incoming interface info extension on R1"
> +
> +	run_cmd "$h1" "traceroute -e 192.0.2.3 $pkt_len | grep INC"
> +	check_err $? "Incoming interface info not appended after enable"
> +
> +	# Test that the extension is not appended when disabled.
> +	run_cmd "$r1" "sysctl -w net.ipv4.icmp_errors_extension_mask=0x00"
> +	check_err $? "Failed to disable incoming interface info extension on R1"
> +
> +	run_cmd "$h1" "traceroute -e 192.0.2.3 $pkt_len | grep INC"
> +	check_fail $? "Incoming interface info appended after disable"
> +
> +	# Test that the extension is sent correctly from both R1 and H2.
> +	run_cmd "$r1" "sysctl -w net.ipv4.icmp_errors_extension_mask=0x01"
> +	r1_ifindex=$(ip -n "$r1" -j link show dev eth1 | jq '.[]["ifindex"]')
> +	run_cmd "$h1" "traceroute -e 192.0.2.3 $pkt_len | grep '<INC:$r1_ifindex,\"eth1\",mtu=1500>'"
> +	check_err $? "Wrong incoming interface info reported from R1"
> +
> +	run_cmd "$h2" "sysctl -w net.ipv4.icmp_errors_extension_mask=0x01"
> +	h2_ifindex=$(ip -n "$h2" -j link show dev eth2 | jq '.[]["ifindex"]')
> +	run_cmd "$h1" "traceroute -e 192.0.2.3 $pkt_len | grep '<INC:$h2_ifindex,\"eth2\",mtu=1500>'"
> +	check_err $? "Wrong incoming interface info reported from H2"
> +
> +	# Add a global address on the incoming interface of R1 and check that
> +	# it is reported.
> +	run_cmd "$r1" "ip address add 198.51.100.1/24 dev eth1"
> +	run_cmd "$h1" "traceroute -e 192.0.2.3 $pkt_len | grep '<INC:$r1_ifindex,198.51.100.1,\"eth1\",mtu=1500>'"
> +	check_err $? "Wrong incoming interface info reported from R1 after address addition"
> +	run_cmd "$r1" "ip address del 198.51.100.1/24 dev eth1"
> +
> +	# Change name and MTU and make sure the result is still correct.
> +	# Re-add the route towards H1 since it was deleted when we removed the
> +	# last IPv4 address from eth1 on R1.
> +	run_cmd "$r1" "ip route add 192.0.2.1/32 nexthop via inet6 fe80::1 dev eth1"
> +	run_cmd "$r1" "ip link set dev eth1 name eth1tag mtu 1501"
> +	run_cmd "$h1" "traceroute -e 192.0.2.3 $pkt_len | grep '<INC:$r1_ifindex,\"eth1tag\",mtu=1501>'"
> +	check_err $? "Wrong incoming interface info reported from R1 after name and MTU change"
> +	run_cmd "$r1" "ip link set dev eth1tag name eth1 mtu 1500"
> +
> +	run_cmd "$r1" "sysctl -w net.ipv4.icmp_errors_extension_mask=0x00"
> +	run_cmd "$h2" "sysctl -w net.ipv4.icmp_errors_extension_mask=0x00"
> +}
> +
> +run_traceroute_ext()
> +{
> +	if ! traceroute --help 2>&1 | grep -q "\--extensions"; then
> +		log_test_skip "traceroute too old, missing ICMP extensions support"
> +		return
> +	fi
> +
> +	setup_traceroute_ext
> +
> +	RET=0
> +
> +	## General ICMP extensions tests
> +
> +	# Test that ICMP extensions are disabled by default.
> +	run_cmd "$h1" "sysctl net.ipv4.icmp_errors_extension_mask | grep \"= 0$\""
> +	check_err $? "ICMP extensions are not disabled by default"
> +
> +	# Test that unsupported values are rejected.
> +	run_cmd "$h1" "sysctl -w net.ipv4.icmp_errors_extension_mask=0x80"
> +	check_fail $? "Unsupported sysctl value was not rejected"
> +
> +	## Extension-specific tests
> +
> +	# Incoming interface info test. Test with various packet sizes,
> +	# including the default one.
> +	traceroute_ext_iio_iif_test
> +	traceroute_ext_iio_iif_test 127
> +	traceroute_ext_iio_iif_test 128
> +	traceroute_ext_iio_iif_test 129
> +
> +	log_test "IPv4 traceroute with ICMP extensions"
> +
> +	cleanup_traceroute_ext
> +}
> +
>  ################################################################################
>  # Run tests
>  
> @@ -444,8 +721,10 @@ run_tests()
>  {
>  	run_traceroute6
>  	run_traceroute6_vrf
> +	run_traceroute6_ext
>  	run_traceroute
>  	run_traceroute_vrf
> +	run_traceroute_ext
>  }
>  
>  ################################################################################
> @@ -462,6 +741,7 @@ done
>  
>  require_command traceroute6
>  require_command traceroute
> +require_command jq
>  
>  run_tests
>  
> -- 
> 2.51.0
> 



