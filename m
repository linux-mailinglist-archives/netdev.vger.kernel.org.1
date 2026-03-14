Return-Path: <netdev+bounces-267783-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGw2ASOdtWl92gAAu9opvQ
	(envelope-from <netdev+bounces-267783-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:38:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F260F28E293
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 13CC8300BC7F
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7222DCC01;
	Sat, 14 Mar 2026 17:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="se8qoNzu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3720F17C203;
	Sat, 14 Mar 2026 17:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773509915; cv=none; b=ChPXct7mKlK72kfc6S3TgUma/n3ysAsq/TUUEy787VOp5+3y65URt8deqYIIfqyWqQojIaWrB42fQlaUOWdQvTpN5jMKYyaoVWZ+4ShthndwUQ4augUpj8RgbKoiAPmJC1rC9fp2OzfPn8Oac901H9a0PW9xNn1/UeMBDTCV8jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773509915; c=relaxed/simple;
	bh=SngmtCX0STPKoLm+RGwl2Lu3zFwL5c8NoAbzNq5GSLg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JZTMB1Ze3m9jLx8p8TbqNG5ZLv83cs2DD7VLrSEFJ8A/BvKzeqCAAQ/tNqCdBNukcWOW8xuhhXWkxhZlm+PRW8c8Itz78E1EFSu3uX+rjE7JXbZwN/zuZTJetxWtNB1dwnhosSFZQl75ISzcUmxYsyxN7oY0hCL3pLrtEEiOGaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=se8qoNzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0BCC116C6;
	Sat, 14 Mar 2026 17:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773509915;
	bh=SngmtCX0STPKoLm+RGwl2Lu3zFwL5c8NoAbzNq5GSLg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=se8qoNzuXWBfLrqyfEsEL0q5iIUhk6qFHDef8/WDG5xzE9qxULHKYBNVeDZl4HItF
	 ubBI3yCFx8/OoMThHScbeWz1IXinaqKilIAJQPOKpBZJ2cXmbfs+m87ae3Pc9qaOaU
	 l7CCpKNgm7GeH+IFnYUaQwLu7Ky/Yb/OF9rBINcfxjwz576TbcpCtFlA+0WQuoSIWN
	 5lIdEQKgeYGBdOuDdaGIgBLi8t3yPiFw8G4WMRNCagKzyWHRFJW8+ZARxOfxmKBZYD
	 Zbl1ObHrvMbTq1rupgBtIfpdqoCiFrDPp6fnpAKi1/eCijIIWkTgQVOuGF1ZojuJZs
	 EwrBPyElACQ5w==
Date: Sat, 14 Mar 2026 10:38:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, edumazet@google.com, Jiayuan Chen
 <jiayuan.chen@shopee.com>, Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v1] selftests: bonding: add test for stacked bond
 header_parse recursion
Message-ID: <20260314103833.36698c29@kernel.org>
In-Reply-To: <20260314134211.33405-1-jiayuan.chen@linux.dev>
References: <20260314134211.33405-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267783-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email,shopee.com:email,bond-arp-interval-causes-panic.sh:url,bond-stacked-header-parse.sh:url,bond_ipsec_offload.sh:url]
X-Rspamd-Queue-Id: F260F28E293
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 14 Mar 2026 21:42:05 +0800 Jiayuan Chen wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> Add a selftest to reproduce the infinite recursion in bond_header_parse()
> when bonds are stacked (bond1 -> bond0 -> gre). When a packet is received
> via AF_PACKET SOCK_DGRAM on the topmost bond, dev_parse_header() calls
> bond_header_parse() which used skb->dev (always the topmost bond) to get
> the bonding struct. This caused it to recurse back into itself
> indefinitely, leading to stack overflow.
> 
> Before Eric's fix [2], the test triggers:
> 
>   ./bond-stacked-header-parse.sh
> 
>   [  71.999481] BUG: MAX_LOCK_DEPTH too low!
>   [  72.000170] turning off the locking correctness validator.
>   [  72.001029] Please attach the output of /proc/lock_stat to the bug report
>   [  72.002079] depth: 48  max: 48!
>   ...
> 
> After Eric's fix [2], everything works fine:
> 
>   ./bond-stacked-header-parse.sh
>   TEST: Stacked bond header_parse does not recurse                  [ OK ]
> 
> Also verified via make run_tests -C drivers/net/bonding:
> 
>   ...
>   ok 3 selftests: drivers/net/bonding: bond-eth-type-change.sh
>   # timeout set to 1200
>   # selftests: drivers/net/bonding: bond-stacked-header-parse.sh
>   # TEST: Stacked bond header_parse does not recurse                [ OK ]
>   ok 4 selftests: drivers/net/bonding: bond-stacked-header-parse.sh
>   # timeout set to 1200
>   # selftests: drivers/net/bonding: bond-lladdr-target.sh
>   # PASS
>   ...
> 
> [1] https://lore.kernel.org/netdev/CANn89iK2EURqsjtd=OVP4awYTJHGcR-UU-V9WovpWR1Z3f03oQ@mail.gmail.com/
> [2] https://lore.kernel.org/netdev/20260314115650.3646361-1-edumazet@google.com/
> 
> Cc: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> ---
>  .../selftests/drivers/net/bonding/Makefile    |   1 +
>  .../net/bonding/bond-stacked-header-parse.sh  | 142 ++++++++++++++++++
>  2 files changed, 143 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/net/bonding/bond-stacked-header-parse.sh
> 
> diff --git a/tools/testing/selftests/drivers/net/bonding/Makefile b/tools/testing/selftests/drivers/net/bonding/Makefile
> index 6c5c60adb5e8..055f6af03b5d 100644
> --- a/tools/testing/selftests/drivers/net/bonding/Makefile
> +++ b/tools/testing/selftests/drivers/net/bonding/Makefile
> @@ -5,6 +5,7 @@ TEST_PROGS := \
>  	bond-arp-interval-causes-panic.sh \
>  	bond-break-lacpdu-tx.sh \
>  	bond-eth-type-change.sh \
> +	bond-stacked-header-parse.sh \

this list is alphabetically sorted

>  	bond-lladdr-target.sh \
>  	bond_ipsec_offload.sh \
>  	bond_lacp_prio.sh \
> diff --git a/tools/testing/selftests/drivers/net/bonding/bond-stacked-header-parse.sh b/tools/testing/selftests/drivers/net/bonding/bond-stacked-header-parse.sh
> new file mode 100755
> index 000000000000..d377bedaef63
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/bonding/bond-stacked-header-parse.sh

please run shellcheck on this file. Most of the reports are probably 
false positive but some are reasonable I think?

> @@ -0,0 +1,142 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Test that bond_header_parse() does not infinitely recurse with stacked bonds.
> +#
> +# When a non-Ethernet device (e.g. GRE) is enslaved to a bond that is itself
> +# enslaved to another bond (bond1 -> bond0 -> gre), receiving a packet via
> +# AF_PACKET SOCK_DGRAM triggers dev_parse_header() -> bond_header_parse().
> +# Since parse() used skb->dev (always the topmost bond) instead of a passed-in
> +# dev pointer, it would recurse back into itself indefinitely.
> +
> +ALL_TESTS="
> +	bond_test_stacked_header_parse
> +"
> +REQUIRE_MZ=no
> +NUM_NETIFS=0
> +lib_dir=$(dirname "$0")
> +source "$lib_dir"/../../../net/forwarding/lib.sh
> +
> +require_command()
> +{
> +	if ! command -v "$1" &>/dev/null; then
> +		echo "SKIP: $1 is not installed"
> +		exit "$ksft_skip"
> +	fi
> +}
> +
> +bond_test_stacked_header_parse()
> +{
> +	local devdummy="test-dummy0"
> +	local devgre="test-gre0"
> +	local devbond0="test-bond0"
> +	local devbond1="test-bond1"
> +
> +	RET=0
> +
> +	# Setup: dummy -> gre -> bond0 -> bond1
> +	modprobe dummy 2>/dev/null
> +	modprobe ip_gre 2>/dev/null
> +	modprobe bonding 2>/dev/null

Doesn't rtnetlink auto-load the link modules?

> +	ip link add name "$devdummy" type dummy
> +	if [ $? -ne 0 ]; then
> +		log_test_skip "could not create dummy device (CONFIG_DUMMY)"
> +		return
> +	fi
> +	ip addr add 10.0.0.1/24 dev "$devdummy"
> +	ip link set "$devdummy" up
> +
> +	ip link add name "$devgre" type gre local 10.0.0.1
> +	if [ $? -ne 0 ]; then
> +		log_test_skip "could not create GRE device (CONFIG_NET_IPGRE)"
> +		ip link del "$devdummy" 2>/dev/null
> +		return
> +	fi

You have to add the dependencies to
tools/testing/selftests/drivers/net/bonding/config

You can keep these checks if you really want to but we don't really
encourage them

> +	ip link add name "$devbond0" type bond mode active-backup
> +	check_err $? "could not create bond0"
> +	ip link add name "$devbond1" type bond mode active-backup
> +	check_err $? "could not create bond1"
> +
> +	ip link set "$devgre" master "$devbond0"
> +	check_err $? "could not enslave $devgre to $devbond0"
> +	ip link set "$devbond0" master "$devbond1"
> +	check_err $? "could not enslave $devbond0 to $devbond1"
> +
> +	ip link set "$devgre" up
> +	ip link set "$devbond0" up
> +	ip link set "$devbond1" up
> +
> +	# Send a GRE-encapsulated packet to 10.0.0.1 while an AF_PACKET
> +	# SOCK_DGRAM socket is listening on bond1. The receive path calls
> +	# dev_parse_header() which invokes bond_header_parse(). With the
> +	# bug, this recurses infinitely and causes a stack overflow.
> +	#
> +	# Use Python to:
> +	# 1. Open AF_PACKET SOCK_DGRAM on bond1
> +	# 2. Send a GRE packet to 10.0.0.1 via raw socket
> +	# 3. Try to receive (triggers parse path)
> +	python3 -c "
> +import socket, struct, time

is this AI-generated?

You can add an extra script in TEST_FILES and just call it.
No need for inline scripts..

> +# AF_PACKET SOCK_DGRAM on bond1
> +ETH_P_ALL = 0x0003
> +pkt_fd = socket.socket(socket.AF_PACKET, socket.SOCK_DGRAM,
> +                       socket.htons(ETH_P_ALL))
> +pkt_fd.settimeout(2)
> +pkt_fd.bind(('$devbond1', ETH_P_ALL))
> +
> +# Build GRE-encapsulated IP packet
> +def build_ip_hdr(proto, saddr, daddr, payload_len):
> +    ihl_ver = 0x45
> +    total_len = 20 + payload_len
> +    hdr = struct.pack('!BBHHHBBH4s4s',
> +        ihl_ver, 0, total_len, 0, 0, 64, proto, 0,
> +        socket.inet_aton(saddr), socket.inet_aton(daddr))
> +    # compute checksum
> +    words = struct.unpack('!10H', hdr)
> +    s = sum(words)
> +    while s >> 16:
> +        s = (s & 0xffff) + (s >> 16)
> +    chksum = ~s & 0xffff
> +    hdr = hdr[:10] + struct.pack('!H', chksum) + hdr[12:]
> +    return hdr
> +
> +inner = build_ip_hdr(17, '192.168.1.1', '192.168.1.2', 8) + b'\x00' * 8
> +gre_hdr = struct.pack('!HH', 0, 0x0800)  # flags=0, proto=IP
> +outer = build_ip_hdr(47, '10.0.0.2', '10.0.0.1', len(gre_hdr) + len(inner))
> +pkt = outer + gre_hdr + inner
> +
> +raw_fd = socket.socket(socket.AF_INET, socket.SOCK_RAW, socket.IPPROTO_RAW)
> +raw_fd.setsockopt(socket.IPPROTO_IP, socket.IP_HDRINCL, 1)
> +raw_fd.sendto(pkt, ('10.0.0.1', 0))
> +raw_fd.close()
> +
> +try:
> +    pkt_fd.recv(2048)
> +except socket.timeout:
> +    pass
> +pkt_fd.close()
> +" 2>/dev/null
> +
> +	# If we get here without a kernel crash/hang, the test passed.
> +	# Also check dmesg for signs of the recursion bug.
> +	if dmesg | tail -20 | grep -q "BUG: MAX_LOCK_DEPTH\|stack-overflow\|stack overflow"; then
> +		check_err 1 "kernel detected recursion in bond_header_parse"
> +	fi
> +
> +	# Cleanup
> +	ip link del "$devbond1" 2>/dev/null
> +	ip link del "$devbond0" 2>/dev/null
> +	ip link del "$devgre" 2>/dev/null
> +	ip link del "$devdummy" 2>/dev/null
> +
> +	log_test "Stacked bond header_parse does not recurse"
> +}
> +
> +require_command python3

No need, we have pure python tests 

> +tests_run
> +
> +exit "$EXIT_STATUS"


