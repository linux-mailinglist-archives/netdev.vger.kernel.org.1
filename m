Return-Path: <netdev+bounces-279667-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMsNFyPP5WkfoQEAu9opvQ
	(envelope-from <netdev+bounces-279667-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 09:00:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A8D4278DA
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 09:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5086E30068C6
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 07:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5907937FF41;
	Mon, 20 Apr 2026 07:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qiFEi5Pz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34C2299923
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 07:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776668448; cv=none; b=iO6vGqiIluOyM81tjj9mzQKnaX8wCB3XEd2TKBRcHEKuZuycOsD0YObiVDZHQNbXcSV82i67O/sx0UcA7xdgFTF8kMEl2o0cn8ZjLAM1b00b5Lkn6TfxbpvgkfwL+txcOIeuw07LVTv6E6ZdMtxctFxhOL3AIhTHKtMwifqOM1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776668448; c=relaxed/simple;
	bh=3AXjQQJ7wMYfgHrwDp6eT5P6zsbs4480fyFoTgO0UJM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WHoZlHyDGmcoVJ+T5NF0igw+dqVDfrDC1ik7KDp2/lbIY2j8+XqALSAkzZh7J78PZYvi5mCZNK5BAuO+m+88i90DV5+avWe87Gc2OU0PV/RhcicODxDCtom485fwi174O8mzGsbl8SEYz9uD4zlc2WFGJgJOoVomv4JZJ8io1YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qiFEi5Pz; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7947cf097c1so21443157b3.2
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 00:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776668446; x=1777273246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PB/wWoNwrjkeUTZT9spxsYgUgVp+xGBWHAe6W4xj3HM=;
        b=qiFEi5Pz2tfd24ZjZa7fu9GjqyKcnqV6DsKMDhOFuCG8cnlnbRqM7WXv7iwPDXi5Vg
         nlIblH3pEWW02esNsvDgfe4OFy7WUl+u7dWGL5s5lc3LBiKyqagzAYAJmsdXAkalFnqD
         9yVL7wEQp3o1KUqDIrSUjJA+jXNz2udWwvB+0OjIpguFwmC5UN4cAw6j4Bjlzx6UtQjL
         xIUbUineQ2QZ2antrQX03QKQwAftRKoiu80O7VfxrIyetgwNW8hD1VRKzlpxqbaP4+YQ
         AfTihOjs+4w51qpPkHlTNrWaprTx84iDFpKaxcJNWoZ7/kUSJR0cSBeYLPKhOf6hjs3x
         EZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776668446; x=1777273246;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PB/wWoNwrjkeUTZT9spxsYgUgVp+xGBWHAe6W4xj3HM=;
        b=cHCS276dydmzlLi/bVddDUweVRgGa1WzhAK0Gk+ru75uPUMpeKxHfRXh8RwpomzHEv
         pTvq3sXENtfaRXQnEI8UpjFU9euw5CcEpA1EIup6mBaUkbvNvqBNyArbhqNsc50DP4oE
         z79Hr7tloT2GtadU1dkF6N7aiMhxBWGisQI81/73UYa36mOZpLh/nOU/ynDbRJvE2a8F
         NXojmCjYtJCOtcnRJyLcyAHECjtImpmwYXWqD866ciFDWUqOD+uqDiG4b87CUWxfFAtS
         isTtzcIQwRRJ+kXRvf/fuZD0/+EaQOpnMQMcjIpK2VMqsbZ+Yyly1j56Up4CB9iByEe2
         GrGA==
X-Forwarded-Encrypted: i=1; AFNElJ89nCs74Yl67glBQsr4fotBAJ3CHDzg146sQkT8yuivMeIjFJvhVq6RoBd+T6dXszTGU7rxm78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl00XbxRS2cMKXFykzixjYRg6ALfFr1HabXWWBPACqjrEFMiIo
	UUKovDH4MfumGHVQd5TMer11SqymDX8IaSllWAl08AE/Ki5uDXPRVEqM
X-Gm-Gg: AeBDietgHbDzFHP++JKxVNuNPNnfgIidV4bLw/7hOg1FXTzfbABcot0olfxaiBLR4+D
	0GHh4oQ81zgkpnEgOss/AMXJxwkOFWGtR5PXuBp5bJT0ShzpEh1lCtrO7VijBwe36WiUFV4HdEq
	VqWxoa82VSjrqp4YKiVke/CIv67thICa/xtOPfuRe/5oCBEpvF0rwPkvMd5nxk1Bxz0m22wZ8oX
	t/vBe0436wyOSKvOdSDd0ddOEzF/GjGqX1EIQQ+C4/f8TVIzL6SGn0WpnBLMisRd9vZB//FlRBJ
	22k/tbUbv37i7Mx07ABBTa34hucGTbgEd8rKaA1Tp44v7xBKEPYUwmkj4aoqyoocvlzHLnLERAw
	3qutUJUmWte8F9lb83dLVTHfX+qmhNAYiYDaktSF8XaNIqs2zuB6yo4CKTT3ZZCfW7kroU70pbV
	CaJ0XQvcRXlMZPrK95leX0kdripp90UOZGSL4+Zms7Q9f7sxkXQ8g4o71EMlNxlYPXC6kcXbpCr
	pfwNLezSxtJu42ltEkAzrrqGg==
X-Received: by 2002:a05:690c:6505:b0:79a:6d65:c351 with SMTP id 00721157ae682-7b9ecfec422mr132591267b3.36.1776668445677;
        Mon, 20 Apr 2026 00:00:45 -0700 (PDT)
Received: from gmail.com (172.165.85.34.bc.googleusercontent.com. [34.85.165.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee99bb32sm39806607b3.30.2026.04.20.00.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 00:00:44 -0700 (PDT)
Date: Mon, 20 Apr 2026 03:00:43 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alice Mikityanska <alice@isovalent.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Alice Mikityanska <alice.kernel@fastmail.im>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Xin Long <lucien.xin@gmail.com>, 
 David Ahern <dsahern@kernel.org>, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Stanislav Fomichev <stfomichev@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, 
 Florian Westphal <fw@strlen.de>, 
 netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.dd3453355999@gmail.com>
In-Reply-To: <CAD0BsJXyHQADVymJw7L0sA72P-=E8Wz7p3CedyvCbqEHBu17JA@mail.gmail.com>
References: <20260410150943.993350-1-alice.kernel@fastmail.im>
 <20260410150943.993350-13-alice.kernel@fastmail.im>
 <willemdebruijn.kernel.cb6bcf72d6ec@gmail.com>
 <CAD0BsJXyHQADVymJw7L0sA72P-=E8Wz7p3CedyvCbqEHBu17JA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279667-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c04:e001:36c::12fc:5321:from];
	FREEMAIL_CC(0.00)[fastmail.im,iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,blackwall.org,lunn.ch,strlen.de,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[isovalent.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,209.85.128.170:received];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,big_tcp_tunnels.sh:url,bind_bhash.sh:url,bpf_offload.py:url,bareudp.sh:url,big_tcp.sh:url,arp_ndisc_untracked_subnets.sh:url]
X-Rspamd-Queue-Id: C7A8D4278DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Alice Mikityanska wrote:
> On Thu, 16 Apr 2026 at 14:06, Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Alice Mikityanska wrote:
> > > From: Alice Mikityanska <alice@isovalent.com>
> > >
> > > The test sets up VXLAN and GENEVE tunnels over IPv4 and IPv6 and runs
> > > IPv4 and IPv6 traffic through them with BIG TCP enabled. It checks that
> > > a non-negligible amount of big aggregated packets are seen in tcpdump.
> > >
> > > Signed-off-by: Alice Mikityanska <alice@isovalent.com>
> > > ---
> > >  tools/testing/selftests/net/Makefile          |   1 +
> > >  .../testing/selftests/net/big_tcp_tunnels.sh  | 145 ++++++++++++++++++
> > >  2 files changed, 146 insertions(+)
> > >  create mode 100755 tools/testing/selftests/net/big_tcp_tunnels.sh
> > >
> > > diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> > > index cab74ebdaced..c8ea9d4bb94f 100644
> > > --- a/tools/testing/selftests/net/Makefile
> > > +++ b/tools/testing/selftests/net/Makefile
> > > @@ -13,6 +13,7 @@ TEST_PROGS := \
> > >       arp_ndisc_untracked_subnets.sh \
> > >       bareudp.sh \
> > >       big_tcp.sh \
> > > +     big_tcp_tunnels.sh \
> > >       bind_bhash.sh \
> > >       bpf_offload.py \
> > >       bridge_vlan_dump.sh \
> > > diff --git a/tools/testing/selftests/net/big_tcp_tunnels.sh b/tools/testing/selftests/net/big_tcp_tunnels.sh
> > > new file mode 100755
> > > index 000000000000..b819911519ac
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/net/big_tcp_tunnels.sh
> > > @@ -0,0 +1,145 @@
> > > +#!/usr/bin/env bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +#
> > > +# Testing for IPv4 and IPv6 BIG TCP over VXLAN and GENEVE tunnels.
> > > +
> > > +SERVER_NS=$(mktemp -u server-XXXXXXXX)
> > > +SERVER_IP4="192.168.1.1"
> > > +SERVER_IP6="2001:db8::1:1"
> > > +SERVER_IP4_TUN="192.168.2.1"
> > > +SERVER_IP6_TUN="2001:db8::2:1"
> > > +
> > > +CLIENT_NS=$(mktemp -u client-XXXXXXXX)
> > > +CLIENT_IP4="192.168.1.2"
> > > +CLIENT_IP6="2001:db8::1:2"
> > > +CLIENT_IP4_TUN="192.168.2.2"
> > > +CLIENT_IP6_TUN="2001:db8::2:2"
> > > +
> > > +PACKETS_THRESHOLD=10000
> > > +
> > > +# Kselftest framework requirement - SKIP code is 4.
> > > +ksft_skip=4
> > > +
> > > +setup() {
> > > +     ip netns add "$SERVER_NS"
> > > +     ip netns add "$CLIENT_NS"
> > > +     ip -netns "$SERVER_NS" link add link1 type veth peer name link0 netns "$CLIENT_NS"
> > > +
> > > +     ip -netns "$CLIENT_NS" link set link0 up
> > > +     ip -netns "$CLIENT_NS" addr replace "$CLIENT_IP4/24" dev link0
> > > +     ip -netns "$CLIENT_NS" addr replace "$CLIENT_IP6/112" dev link0 nodad
> > > +     ip -netns "$CLIENT_NS" link set link0 \
> > > +             gso_max_size 196608 gso_ipv4_max_size 196608 \
> > > +             gro_max_size 196608 gro_ipv4_max_size 196608
> > > +     ip -netns "$SERVER_NS" link set link1 up
> > > +     ip -netns "$SERVER_NS" addr replace "$SERVER_IP4/24" dev link1
> > > +     ip -netns "$SERVER_NS" addr replace "$SERVER_IP6/112" dev link1 nodad
> > > +     ip -netns "$SERVER_NS" link set link1 \
> > > +             gso_max_size 196608 gso_ipv4_max_size 196608 \
> > > +             gro_max_size 196608 gro_ipv4_max_size 196608
> > > +
> > > +     ip netns exec "$SERVER_NS" netserver >/dev/null
> > > +}
> > > +
> > > +setup_tunnel() {
> > > +     if [ "$2" = 4 ]; then
> > > +             SERVER_IP="$SERVER_IP4"
> > > +             CLIENT_IP="$CLIENT_IP4"
> > > +             echo "Setting up ${1^^} over IPv4"
> > > +     else
> > > +             SERVER_IP="$SERVER_IP6"
> > > +             CLIENT_IP="$CLIENT_IP6"
> > > +             echo "Setting up ${1^^} over IPv6"
> > > +     fi
> > > +
> > > +     if [ "$1" = vxlan ]; then
> > > +             ip -netns "$CLIENT_NS" link add tun0 type vxlan \
> > > +                     id 5001 remote "$SERVER_IP" local "$CLIENT_IP" dev link0 dstport 4789
> > > +     else
> > > +             ip -netns "$CLIENT_NS" link add tun0 type geneve \
> > > +                     id 5001 remote "$SERVER_IP"
> > > +     fi
> > > +     ip -netns "$CLIENT_NS" link set tun0 up
> > > +     ip -netns "$CLIENT_NS" addr replace "$CLIENT_IP4_TUN/24" dev tun0
> > > +     ip -netns "$CLIENT_NS" addr replace "$CLIENT_IP6_TUN/112" dev tun0 nodad
> > > +     ip -netns "$CLIENT_NS" link set tun0 \
> > > +             gso_max_size 196608 gso_ipv4_max_size 196608 \
> > > +             gro_max_size 196608 gro_ipv4_max_size 196608
> > > +     if [ "$1" = vxlan ]; then
> > > +             ip -netns "$SERVER_NS" link add tun1 type vxlan \
> > > +                     id 5001 remote "$CLIENT_IP" local "$SERVER_IP" dev link1 dstport 4789
> > > +     else
> > > +             ip -netns "$SERVER_NS" link add tun1 type geneve \
> > > +                     id 5001 remote "$CLIENT_IP"
> > > +     fi
> > > +     ip -netns "$SERVER_NS" link set tun1 up
> > > +     ip -netns "$SERVER_NS" addr replace "$SERVER_IP4_TUN/24" dev tun1
> > > +     ip -netns "$SERVER_NS" addr replace "$SERVER_IP6_TUN/112" dev tun1 nodad
> > > +     ip -netns "$SERVER_NS" link set tun1 \
> > > +             gso_max_size 196608 gso_ipv4_max_size 196608 \
> > > +             gro_max_size 196608 gro_ipv4_max_size 196608
> > > +}
> > > +
> > > +cleanup_tunnel() {
> > > +     ip -netns "$CLIENT_NS" link del tun0
> > > +     ip -netns "$SERVER_NS" link del tun1
> > > +}
> > > +
> > > +cleanup() {
> > > +     ip netns exec "$SERVER_NS" killall netserver
> > > +     ip netns del "$SERVER_NS"
> > > +     ip netns del "$CLIENT_NS"
> > > +}
> > > +
> > > +do_test() {
> > > +     exec 3< <(ip netns exec "$SERVER_NS" tcpdump -nn -i link1 greater 65536 2> /dev/null)
> > > +     TCPDUMP_SERVER_PID="$!"
> > > +     exec 4< <(wc -l <&3)
> > > +     exec 5< <(ip netns exec "$CLIENT_NS" tcpdump -nn -i link0 greater 65536 2> /dev/null)
> > > +     TCPDUMP_CLIENT_PID="$!"
> > > +     exec 6< <(wc -l <&5)
> > > +
> > > +     if [ "$1" = 4 ]; then
> > > +             SERVER_IP="$SERVER_IP4_TUN"
> > > +             echo "Running IPv4 traffic in the tunnel"
> > > +     else
> > > +             SERVER_IP="$SERVER_IP6_TUN"
> > > +             echo "Running IPv6 traffic in the tunnel"
> > > +     fi
> > > +
> > > +     ip netns exec "$CLIENT_NS" netperf -t TCP_STREAM -l 5 -H "$SERVER_IP" -- \
> > > +             -r 80000:80000 > /dev/null
> >
> > is -r valid for TCP_STREAM
> 
> Yes, it controls how much data is sent in one send() syscall. If I set
> a smaller size, the kernel will still try to aggregate the packets,
> but there will be much fewer BIG TCP packets.

Not according to the care & feeding doc, where it is an RR option.
Maybe it is used in practice. Maybe also depends on whether using
omni or bsd mode. But just a note.

