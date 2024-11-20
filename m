Return-Path: <netdev+bounces-146499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 099719D3C69
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 14:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 444D1B22D70
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 13:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3B016DEB5;
	Wed, 20 Nov 2024 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ga0G6NEe"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2751E19C542
	for <netdev@vger.kernel.org>; Wed, 20 Nov 2024 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732108253; cv=none; b=mSrrgd2oO1ECDxcleyAO9URxZJX/5AlVhIY3VrRMpHA3hxcy2EFDNw3ZTGOyt6XtVhptO2t0vPBYH4L6H07y8y173KHdoaZ05OgeN2PSnoaQ6acTkj9wh6d+YSz8icQP/8HRYmF8fHmMY9ki4VfUklHJDUKLi93Z1gKWiVclkLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732108253; c=relaxed/simple;
	bh=y42IshI4omGZYw9S7UvDxWoNkfWPqR5LdaZMiHFqVLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqHma7/HmDMaWxHWtTJ4koD3gBAs88jn1A4YnbvSbErm6G6RxUsxzY00f7Q2fP5bcxLiQuiOOeWnnO8qhV6CsFSHCqumNtit66EOhSzrjHEVpQvb4eyoLrYsRGOD7pmkzmnnHNKbdPuKWs9NvzxAz8n0Ih3LLd+9/pJeZB7tdLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ga0G6NEe; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A41B1140216;
	Wed, 20 Nov 2024 08:10:50 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 20 Nov 2024 08:10:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732108250; x=1732194650; bh=Hj/WeJMVTyRtBW58uHExmETxHM5+T6ifniT
	Z0+XNnbg=; b=Ga0G6NEe/Xg03xryrOhhOJPA3fb4lg+9kf7+OiGgifZIEUkQVkE
	KqGcrROcAZGtBqkMI5YTiKwYUz0HvEPNWhncDJ00pBDtePp1oQzgEfiv3vIkplaD
	LPoEG0ddfOAv5bNtXSzeg6wQDW04GKoRmN83do3BlLL9Sw2HrtdqDVZmscIT2jMn
	xAr65wJzLEY0FO802m9Aj7mKkbXPK1hgSE2Qr5QVv4eINzg/1grqaioIGBzielK6
	ozr67dOu1cLPKTiX3FsFtZhGsatoOUsVaMxQ8+19KiKa2SE65ltSe2vr8nme1L2F
	4a8R0Ii+EDToYAPTvjMpFeUDXD+HPFtUbQQ==
X-ME-Sender: <xms:2d89Z5fepTAdrC1l2R64nO691LZgIjo32OWy1Zd-tOjkSZZmdDxuNA>
    <xme:2d89Z3OMxSm0X9astAbEwb-89MkjWwIgZ7z0w7RDDffkGrn5UL401-60WHQY2DZr7
    SDpYcTGRUc1g7c>
X-ME-Received: <xmr:2d89Zyh3sHCmhQqE_j89gddd-LkqX0udJgr1SjIY-ZC1eT40-4L4f0ZmM3Kb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorh
    hgqeenucggtffrrghtthgvrhhnpeevieevgfeuleejgfeghefhuddviefhgeejhfehgeek
    geevfefggefgudefhfelgfenucffohhmrghinhepihhpvhegrdhpihhnghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihgu
    ohhstghhrdhorhhgpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopegrnhhnrggvmhgvshgvnhihihhrihesghhmrghilhdrtghomhdprhgtphht
    thhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehfvg
    hjvghssehinhhfrdgvlhhtvgdrhhhupdhrtghpthhtohepvgguuhhmrgiivghtsehgohho
    ghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeifihhllhgvmhgs
    sehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:2d89Zy8Y9FPkcZfo7z9ZY3GTO0Xqgo_5maObeghBkYddd-C16que4g>
    <xmx:2d89Z1tKQFbZEMdElqcjEB2uw9zed46o7R7zbhZn0lWL2oAPLwyJ3A>
    <xmx:2d89ZxEH-HIqMrzzHCmqN5hS_uzWxFv4SMKZwb3-Xih7ZXD3RVn9_w>
    <xmx:2d89Z8PZPX5Y8Bb5pN3Nkz0rt1ELzmhu_CgNMADfNr8RoPoP6rKqGA>
    <xmx:2t89Z5gXtM2JisXCAYtGmGdn4mWZ3aToqAxTUO-jGzSaQuRfag6jAtsx>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 08:10:48 -0500 (EST)
Date: Wed, 20 Nov 2024 15:10:45 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Anna Emese Nyiri <annaemesenyiri@gmail.com>
Cc: netdev@vger.kernel.org, fejes@inf.elte.hu, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com
Subject: Re: [PATCH net-next v4 3/3] selftests: net: test SO_PRIORITY
 ancillary data with cmsg_sender
Message-ID: <Zz3f1W42IxDm9n0_@shredder>
References: <20241118145147.56236-1-annaemesenyiri@gmail.com>
 <20241118145147.56236-4-annaemesenyiri@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118145147.56236-4-annaemesenyiri@gmail.com>

On Mon, Nov 18, 2024 at 03:51:47PM +0100, Anna Emese Nyiri wrote:
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
>  tools/testing/selftests/net/cmsg_sender.c     |  11 +-
>  .../testing/selftests/net/cmsg_so_priority.sh | 147 ++++++++++++++++++
>  2 files changed, 157 insertions(+), 1 deletion(-)
>  create mode 100755 tools/testing/selftests/net/cmsg_so_priority.sh

Please add cmsg_so_priority.sh to tools/testing/selftests/net/Makefile
so that the test will be exercised as part of the netdev CI.

> 
> diff --git a/tools/testing/selftests/net/cmsg_sender.c b/tools/testing/selftests/net/cmsg_sender.c
> index 876c2db02a63..5267eacc35df 100644
> --- a/tools/testing/selftests/net/cmsg_sender.c
> +++ b/tools/testing/selftests/net/cmsg_sender.c
> @@ -52,6 +52,7 @@ struct options {
>  		unsigned int tclass;
>  		unsigned int hlimit;
>  		unsigned int priority;
> +		unsigned int priority_cmsg;

Why do you need this? Looks like it's unused

>  	} sockopt;
>  	struct {
>  		unsigned int family;
> @@ -59,6 +60,7 @@ struct options {
>  		unsigned int proto;
>  	} sock;
>  	struct option_cmsg_u32 mark;
> +	struct option_cmsg_u32 priority_cmsg;

To be consistent with other cmsg variables I would just name it
'priority' instead of 'priority_cmsg'

>  	struct {
>  		bool ena;
>  		unsigned int delay;
> @@ -97,6 +99,7 @@ static void __attribute__((noreturn)) cs_usage(const char *bin)
>  	       "\n"
>  	       "\t\t-m val  Set SO_MARK with given value\n"
>  	       "\t\t-M val  Set SO_MARK via setsockopt\n"

While at it, please add documentation for "-P" (SO_PRIORITY via
setsockopt). I noticed it is missing.

> +		   "\t\t-Q val  Set SO_PRIORITY via cmsg\n"

The alignment here is off.

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
> +			opt.priority_cmsg.ena = true;
> +			opt.priority_cmsg.val = atoi(optarg);
> +			break;
>  		case 'M':
>  			opt.sockopt.mark = atoi(optarg);
>  			break;
> @@ -252,6 +259,8 @@ cs_write_cmsg(int fd, struct msghdr *msg, char *cbuf, size_t cbuf_sz)
>  
>  	ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
>  			  SOL_SOCKET, SO_MARK, &opt.mark);
> +	ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
> +			SOL_SOCKET, SO_PRIORITY, &opt.priority_cmsg);
>  	ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
>  			  SOL_IPV6, IPV6_DONTFRAG, &opt.v6.dontfrag);
>  	ca_write_cmsg_u32(cbuf, cbuf_sz, &cmsg_len,
> diff --git a/tools/testing/selftests/net/cmsg_so_priority.sh b/tools/testing/selftests/net/cmsg_so_priority.sh
> new file mode 100755
> index 000000000000..e5919c5ed1a4
> --- /dev/null
> +++ b/tools/testing/selftests/net/cmsg_so_priority.sh
> @@ -0,0 +1,147 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +IP4=192.0.2.1/24
> +TGT4=192.0.2.2/24
> +TGT4_NO_MASK=192.0.2.2
> +TGT4_RAW=192.0.2.3/24
> +TGT4_RAW_NO_MASK=192.0.2.3
> +IP6=2001:db8::1/64
> +TGT6=2001:db8::2/64
> +TGT6_NO_MASK=2001:db8::2
> +TGT6_RAW=2001:db8::3/64
> +TGT6_RAW_NO_MASK=2001:db8::3
> +PORT=1234
> +DELAY=4000
> +
> +
> +create_filter() {
> +

Unnecessary blank line

> +    local ns=$1
> +    local dev=$2

These two are always the same so no need to parameterize them

> +    local handle=$3
> +    local vlan_prio=$4
> +    local ip_type=$5
> +    local proto=$6
> +    local dst_ip=$7
> +
> +    local cmd="tc -n $ns filter add dev $dev egress pref 1 handle $handle \
> +    proto 802.1q flower vlan_prio $vlan_prio vlan_ethtype $ip_type"
> +
> +    if [[ "$proto" == "u" ]]; then
> +        ip_proto="udp"
> +    elif [[ "$ip_type" == "ipv4" && "$proto" == "i" ]]; then
> +        ip_proto="icmp"
> +    elif [[ "$ip_type" == "ipv6" && "$proto" == "i" ]]; then
> +        ip_proto="icmpv6"
> +    fi
> +
> +    if [[ "$proto" != "r" ]]; then
> +        cmd="$cmd ip_proto $ip_proto"
> +    fi
> +
> +    cmd="$cmd dst_ip $dst_ip action pass"
> +
> +    eval $cmd
> +}
> +
> +TOTAL_TESTS=0
> +FAILED_TESTS=0
> +
> +check_result() {
> +    ((TOTAL_TESTS++))
> +    if [ "$1" -ne 0 ]; then
> +        ((FAILED_TESTS++))
> +    fi
> +}
> +
> +cleanup() {
> +    ip link del dummy1 2>/dev/null
> +    ip -n ns1 link del dummy1.10 2>/dev/null
> +    ip netns del ns1 2>/dev/null
> +}
> +
> +trap cleanup EXIT
> +
> +
> +
> +ip netns add ns1

Please use cmsg_so_mark.sh as a reference and check how it's creating
the namespace. It's done via the setup_ns() helper in lib.sh:

setup_ns NS

It will generate a random name for the namespace, allowing multiple
tests to be run in parallel without conflicts.

> +
> +ip -n ns1 link set dev lo up
> +ip -n ns1 link add name dummy1 up type dummy
> +
> +ip -n ns1 link add link dummy1 name dummy1.10 up type vlan id 10 \
> +        egress-qos-map 0:0 1:1 2:2 3:3 4:4 5:5 6:6 7:7
> +
> +ip -n ns1 address add $IP4 dev dummy1.10
> +ip -n ns1 address add $IP6 dev dummy1.10
> +
> +ip netns exec ns1 bash -c "
> +sysctl -w net.ipv4.ping_group_range='0 2147483647'
> +exit"

Can be:

ip netns exec ns1 sysctl -wq net.ipv4.ping_group_range='0 2147483647'

Note the '-q' option.

> +
> +
> +ip -n ns1 neigh add $TGT4_NO_MASK lladdr 00:11:22:33:44:55 nud permanent dev \
> +        dummy1.10
> +ip -n ns1 neigh add $TGT6_NO_MASK lladdr 00:11:22:33:44:55 nud permanent dev dummy1.10
> +ip -n ns1 neigh add $TGT4_RAW_NO_MASK lladdr 00:11:22:33:44:66 nud permanent dev dummy1.10
> +ip -n ns1 neigh add $TGT6_RAW_NO_MASK lladdr 00:11:22:33:44:66 nud permanent dev dummy1.10
> +
> +tc -n ns1 qdisc add dev dummy1 clsact
> +
> +FILTER_COUNTER=10
> +
> +for i in 4 6; do
> +    for proto in u i r; do
> +        echo "Test IPV$i, prot: $proto"
> +        for priority in {0..7}; do
> +            if [[ $i == 4 && $proto == "r" ]]; then
> +                TGT=$TGT4_RAW_NO_MASK
> +            elif [[ $i == 6 && $proto == "r" ]]; then
> +                TGT=$TGT6_RAW_NO_MASK
> +            elif [ $i == 4 ]; then
> +                TGT=$TGT4_NO_MASK
> +            else
> +                TGT=$TGT6_NO_MASK
> +            fi
> +
> +            handle="${FILTER_COUNTER}${priority}"
> +
> +            create_filter ns1 dummy1 $handle $priority ipv$i $proto $TGT
> +
> +            pkts=$(tc -n ns1 -j -s filter show dev dummy1 egress \
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
> +            ip netns exec ns1 ./cmsg_sender -$i -Q $priority -d "${DELAY}" -p $proto $TGT $PORT
> +            ip netns exec ns1 ./cmsg_sender -$i -P $priority -d "${DELAY}" -p $proto $TGT $PORT
> +
> +
> +            pkts=$(tc -n ns1 -j -s filter show dev dummy1 egress \
> +                | jq ".[] | select(.options.handle == ${handle}) | \
> +                .options.actions[0].stats.packets")
> +            if [[ $pkts == 2 ]]; then
> +                check_result 0
> +            else
> +                echo "prio $priority: expected 2, got $pkts"
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
> -- 
> 2.43.0
> 

