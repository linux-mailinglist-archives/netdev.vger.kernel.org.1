Return-Path: <netdev+bounces-279029-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOesLMzQ4GkkmQAAu9opvQ
	(envelope-from <netdev+bounces-279029-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 14:06:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAF640DD70
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 14:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EC413040A83
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 12:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6C4389E18;
	Thu, 16 Apr 2026 12:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxv/ey8m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ADD378D78
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 12:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776341193; cv=none; b=SQIWeaQrETSdazlKq6zD9f022v5BozGoC0DHR2QwxBMbEHItB20QaWGEi3G05DpqAvX9Ez24ZYj29IEQfCJUJvkXoUpdsgKjF2118s7krUbcg/w55XvnXO91pfkee6uuqvZVHSNtdrDKmjjDEUTRG5orByo+yqIR6atxHTPneT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776341193; c=relaxed/simple;
	bh=SScKi39bGQs7JQN7L/0fGyp+b7qwIQjm+mE207lwpto=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nnaAnvu5NU124DFni1B/QiM9Sf2oMJnE26cvtd7ScgvkChEJpSYZ73KxEPP64IopwDHCAPrMl7cUH0dRYJw0t/EvZtkz/vZOkTR+qVZhc8ivDZ8JbN4dG5g6vMdJd4BP6cQhzp70/bd+q5Ql06ayMzirxaiqQCj/KbO21R+o/+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qxv/ey8m; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79495b1aaa7so83492647b3.1
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 05:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776341191; x=1776945991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHSnkU+geabj1t5CxJBCppfR6DFqV9simSFaNEo1afo=;
        b=qxv/ey8mSUFtitcebGtBFcV5llNBxhlXGlI28I0PQ2RRPTux6rDRhRCKOJBJ3qkLAs
         +Ksbgpce6CpM92CDIBcxHyarctctIwtQs4dUunRzchG3o/PmA3NXWtV+xRtOOQTu+/0G
         D+cxFO4yRwJvyjekSGSaN2pTv0BPGb/F6V5jq+XM+FoIEhQNSzKvRAlR8m+q7mcEf5J1
         PWox3OziEsFng7fjP5SoGB2jblEDdXOXJultOWK0mfFTwqveD0ig0HsYOyTzHsk/yNcc
         2/dxG9bPalT+inlUVC1X/2pkqIX/CBOsn2Xhje/P3cafTzGwYAsGU0y+dqZqIyjB4fa9
         pPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776341191; x=1776945991;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qHSnkU+geabj1t5CxJBCppfR6DFqV9simSFaNEo1afo=;
        b=kRiZEkCPIQzGj7f4lrhvue5dBauA+zrboZtnSXYyeou1/Ny4Us8JMVJ5yh3WqPgbFE
         WJKiCRzjeKWwEMnjm8Am3XUp9Wrp65dzA5h+4f8hgfm3UkTW84lAVOkTdZaBq6vnPiB1
         gf3beuMh7Nf21/ocjy/iDlGtLts3xm6H5HDGZ0khm03rXMc5axQCzgehud2mRCsTrGPG
         U27+QE4+469PJDAF6l38U5weKuQDyFCBmYrlZWJeAsUQGA2tk4p13RjPdc+VnwIXHkTG
         LBBjEVxTM0Y7szDt6Fz6J90o8Cd2mCAJKYeEvWF4mi2/jCRm931Z2AMqXXY1TgPEalGG
         xVjA==
X-Forwarded-Encrypted: i=1; AFNElJ/NhUwoMYqh/V5ZG+cJ1LoIwv7cVH7KpnS6FV31Ow9cuY4TgCxdMzBUG3E6VczV6C2Y0Zsys+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRvJTeiu0KAl8xytr57Jtxmh7V2u05lUlK2H1AAFe03CrP3x5j
	QuefC+JdKwF4DBXUPLbJsYdnrypJLr3/wOdDLWGmrRBbR4OER2EmDsR0
X-Gm-Gg: AeBDieviyfPDOJra8WI1ZhLzkPWd+/wt04IF+ZLTJOq5cQcWLPGjiVLdsTc8atE/xsu
	vwRpCVK3dawySHmw3tnMhyuMsW4WCqYFG/Tzk37bVWfkj2XQHRjC4exzzua+SNF8aQBMw9ITxNg
	lVl1fY4P/Gxv5wYeNstHZuX1M5EBCCDoncj23+riTlrFOLv/22pM8cZ+TYiZnAS+pfwhpKE6bNI
	h2DFU6io8DevBn1Q3Ffn+kIYCJOONZ/1548mwkgTLPyb1HHvL4GPy+Zcao5p7IwCQLiaNJkgnI/
	NBb1XwSMGXt3vmb+ADyzd8jH8QnpjgVAuF7P9nmE9XlsKan1uop5GYJ16Fwc9Qmn9COiN9EzfFJ
	3qq0hj/M0nIGLPbCIkdwWUFaXWEXy1vKBHqazh0viQrURKKrhE8JmlaVdr2b9UI5O0Ou5zlwIpZ
	H+Bv/Y7Nl3Bj7aT5zXsFO3Ta7G6CVU9NrGu8EYPC9PY842hgv6PD78XFhRxPFyxBEBEO5cekD8T
	u4BkF/0dIsUwwE=
X-Received: by 2002:a05:690c:c4e9:b0:7b8:f152:7545 with SMTP id 00721157ae682-7b8f15279b3mr14640717b3.9.1776341191552;
        Thu, 16 Apr 2026 05:06:31 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b76991b184sm21475387b3.49.2026.04.16.05.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 05:06:29 -0700 (PDT)
Date: Thu, 16 Apr 2026 08:06:29 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alice Mikityanska <alice.kernel@fastmail.im>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Xin Long <lucien.xin@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 David Ahern <dsahern@kernel.org>, 
 Nikolay Aleksandrov <razor@blackwall.org>
Cc: Shuah Khan <shuah@kernel.org>, 
 Stanislav Fomichev <stfomichev@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, 
 Florian Westphal <fw@strlen.de>, 
 netdev@vger.kernel.org, 
 Alice Mikityanska <alice@isovalent.com>
Message-ID: <willemdebruijn.kernel.cb6bcf72d6ec@gmail.com>
In-Reply-To: <20260410150943.993350-13-alice.kernel@fastmail.im>
References: <20260410150943.993350-1-alice.kernel@fastmail.im>
 <20260410150943.993350-13-alice.kernel@fastmail.im>
Subject: Re: [PATCH net-next v3 12/12] selftests: net: Add a test for BIG TCP
 in UDP tunnels
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279029-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,strlen.de,vger.kernel.org,isovalent.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[fastmail.im,iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bareudp.sh:url,isovalent.com:email,big_tcp.sh:url,big_tcp_tunnels.sh:url]
X-Rspamd-Queue-Id: 0BAF640DD70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Alice Mikityanska wrote:
> From: Alice Mikityanska <alice@isovalent.com>
> 
> The test sets up VXLAN and GENEVE tunnels over IPv4 and IPv6 and runs
> IPv4 and IPv6 traffic through them with BIG TCP enabled. It checks that
> a non-negligible amount of big aggregated packets are seen in tcpdump.
> 
> Signed-off-by: Alice Mikityanska <alice@isovalent.com>
> ---
>  tools/testing/selftests/net/Makefile          |   1 +
>  .../testing/selftests/net/big_tcp_tunnels.sh  | 145 ++++++++++++++++++
>  2 files changed, 146 insertions(+)
>  create mode 100755 tools/testing/selftests/net/big_tcp_tunnels.sh
> 
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index cab74ebdaced..c8ea9d4bb94f 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -13,6 +13,7 @@ TEST_PROGS := \
>  	arp_ndisc_untracked_subnets.sh \
>  	bareudp.sh \
>  	big_tcp.sh \
> +	big_tcp_tunnels.sh \
>  	bind_bhash.sh \
>  	bpf_offload.py \
>  	bridge_vlan_dump.sh \
> diff --git a/tools/testing/selftests/net/big_tcp_tunnels.sh b/tools/testing/selftests/net/big_tcp_tunnels.sh
> new file mode 100755
> index 000000000000..b819911519ac
> --- /dev/null
> +++ b/tools/testing/selftests/net/big_tcp_tunnels.sh
> @@ -0,0 +1,145 @@
> +#!/usr/bin/env bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Testing for IPv4 and IPv6 BIG TCP over VXLAN and GENEVE tunnels.
> +
> +SERVER_NS=$(mktemp -u server-XXXXXXXX)
> +SERVER_IP4="192.168.1.1"
> +SERVER_IP6="2001:db8::1:1"
> +SERVER_IP4_TUN="192.168.2.1"
> +SERVER_IP6_TUN="2001:db8::2:1"
> +
> +CLIENT_NS=$(mktemp -u client-XXXXXXXX)
> +CLIENT_IP4="192.168.1.2"
> +CLIENT_IP6="2001:db8::1:2"
> +CLIENT_IP4_TUN="192.168.2.2"
> +CLIENT_IP6_TUN="2001:db8::2:2"
> +
> +PACKETS_THRESHOLD=10000
> +
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +
> +setup() {
> +	ip netns add "$SERVER_NS"
> +	ip netns add "$CLIENT_NS"
> +	ip -netns "$SERVER_NS" link add link1 type veth peer name link0 netns "$CLIENT_NS"
> +
> +	ip -netns "$CLIENT_NS" link set link0 up
> +	ip -netns "$CLIENT_NS" addr replace "$CLIENT_IP4/24" dev link0
> +	ip -netns "$CLIENT_NS" addr replace "$CLIENT_IP6/112" dev link0 nodad
> +	ip -netns "$CLIENT_NS" link set link0 \
> +		gso_max_size 196608 gso_ipv4_max_size 196608 \
> +		gro_max_size 196608 gro_ipv4_max_size 196608
> +	ip -netns "$SERVER_NS" link set link1 up
> +	ip -netns "$SERVER_NS" addr replace "$SERVER_IP4/24" dev link1
> +	ip -netns "$SERVER_NS" addr replace "$SERVER_IP6/112" dev link1 nodad
> +	ip -netns "$SERVER_NS" link set link1 \
> +		gso_max_size 196608 gso_ipv4_max_size 196608 \
> +		gro_max_size 196608 gro_ipv4_max_size 196608
> +
> +	ip netns exec "$SERVER_NS" netserver >/dev/null
> +}
> +
> +setup_tunnel() {
> +	if [ "$2" = 4 ]; then
> +		SERVER_IP="$SERVER_IP4"
> +		CLIENT_IP="$CLIENT_IP4"
> +		echo "Setting up ${1^^} over IPv4"
> +	else
> +		SERVER_IP="$SERVER_IP6"
> +		CLIENT_IP="$CLIENT_IP6"
> +		echo "Setting up ${1^^} over IPv6"
> +	fi
> +
> +	if [ "$1" = vxlan ]; then
> +		ip -netns "$CLIENT_NS" link add tun0 type vxlan \
> +			id 5001 remote "$SERVER_IP" local "$CLIENT_IP" dev link0 dstport 4789
> +	else
> +		ip -netns "$CLIENT_NS" link add tun0 type geneve \
> +			id 5001 remote "$SERVER_IP"
> +	fi
> +	ip -netns "$CLIENT_NS" link set tun0 up
> +	ip -netns "$CLIENT_NS" addr replace "$CLIENT_IP4_TUN/24" dev tun0
> +	ip -netns "$CLIENT_NS" addr replace "$CLIENT_IP6_TUN/112" dev tun0 nodad
> +	ip -netns "$CLIENT_NS" link set tun0 \
> +		gso_max_size 196608 gso_ipv4_max_size 196608 \
> +		gro_max_size 196608 gro_ipv4_max_size 196608
> +	if [ "$1" = vxlan ]; then
> +		ip -netns "$SERVER_NS" link add tun1 type vxlan \
> +			id 5001 remote "$CLIENT_IP" local "$SERVER_IP" dev link1 dstport 4789
> +	else
> +		ip -netns "$SERVER_NS" link add tun1 type geneve \
> +			id 5001 remote "$CLIENT_IP"
> +	fi
> +	ip -netns "$SERVER_NS" link set tun1 up
> +	ip -netns "$SERVER_NS" addr replace "$SERVER_IP4_TUN/24" dev tun1
> +	ip -netns "$SERVER_NS" addr replace "$SERVER_IP6_TUN/112" dev tun1 nodad
> +	ip -netns "$SERVER_NS" link set tun1 \
> +		gso_max_size 196608 gso_ipv4_max_size 196608 \
> +		gro_max_size 196608 gro_ipv4_max_size 196608
> +}
> +
> +cleanup_tunnel() {
> +	ip -netns "$CLIENT_NS" link del tun0
> +	ip -netns "$SERVER_NS" link del tun1
> +}
> +
> +cleanup() {
> +	ip netns exec "$SERVER_NS" killall netserver
> +	ip netns del "$SERVER_NS"
> +	ip netns del "$CLIENT_NS"
> +}
> +
> +do_test() {
> +	exec 3< <(ip netns exec "$SERVER_NS" tcpdump -nn -i link1 greater 65536 2> /dev/null)
> +	TCPDUMP_SERVER_PID="$!"
> +	exec 4< <(wc -l <&3)
> +	exec 5< <(ip netns exec "$CLIENT_NS" tcpdump -nn -i link0 greater 65536 2> /dev/null)
> +	TCPDUMP_CLIENT_PID="$!"
> +	exec 6< <(wc -l <&5)
> +
> +	if [ "$1" = 4 ]; then
> +		SERVER_IP="$SERVER_IP4_TUN"
> +		echo "Running IPv4 traffic in the tunnel"
> +	else
> +		SERVER_IP="$SERVER_IP6_TUN"
> +		echo "Running IPv6 traffic in the tunnel"
> +	fi
> +
> +	ip netns exec "$CLIENT_NS" netperf -t TCP_STREAM -l 5 -H "$SERVER_IP" -- \
> +		-r 80000:80000 > /dev/null

is -r valid for TCP_STREAM

> +	kill "$TCPDUMP_SERVER_PID" "$TCPDUMP_CLIENT_PID"
> +	wait "$TCPDUMP_SERVER_PID" "$TCPDUMP_CLIENT_PID"
> +	PACKETS_SERVER=$(cat <&4)
> +	PACKETS_CLIENT=$(cat <&6)
> +	exec 3>&- 4>&- 5>&- 6>&-
> +
> +	# One line is empty, each packet is two lines (inner and outer).
> +	echo "Captured BIG TCP GRO packets: $(((PACKETS_SERVER - 1) / 2))"
> +	echo "Captured BIG TCP GSO packets: $(((PACKETS_CLIENT - 1) / 2))"
> +	[ "$PACKETS_SERVER" -gt "$(( PACKETS_THRESHOLD * 2 + 1))" ] || return 1
> +	[ "$PACKETS_CLIENT" -gt "$(( PACKETS_THRESHOLD * 2 + 1))" ] || return 1
> +}
> +
> +if ! netperf -V &> /dev/null; then
> +	echo "SKIP: Could not run test without netperf tool"
> +	exit "$ksft_skip"
> +fi
> +
> +if ! ip link help 2>&1 | grep gso_ipv4_max_size &> /dev/null; then
> +	echo "SKIP: Could not run test without gso/gro_ipv4_max_size supported in ip-link"
> +	exit "$ksft_skip"
> +fi
> +
> +trap cleanup EXIT
> +setup
> +for tunnel in vxlan geneve; do
> +	for tun_family in 4 6; do
> +		for traffic_family in 4 6; do
> +			setup_tunnel "$tunnel" "$tun_family" || exit "$?"
> +			do_test "$traffic_family" || exit "$?"
> +			cleanup_tunnel
> +		done
> +	done
> +done
> -- 
> 2.53.0
> 



