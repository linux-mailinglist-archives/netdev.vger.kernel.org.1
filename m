Return-Path: <netdev+bounces-185172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 763C6A98C9D
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 16:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8BB4443454
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 14:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DA923D2AB;
	Wed, 23 Apr 2025 14:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3DTNLJC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEBC25229E
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 14:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745417893; cv=none; b=BwMRa26SWkrhr76jM2qv4q1qVHUxJrr8wn1LxJpykOUcuVrqYzKb/P3Z0q4N4/3ugGvIXQXMjefUhffE0wl8GWZPwfP6c3t8i683bf2D+01acuO3Uw9sDcrGsZfAAh9ySJgRPh6ntwJ/X0pgr/oPjqYK+EPIbb1cKDfVY1OPCjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745417893; c=relaxed/simple;
	bh=WFW+nXVL2wGxtx5+7mdFHABj9NqZDdjXTJzav1pHL80=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=mTGeAb3wW1spVCz/jfR4h3SmdG/xBrESHnOcdsW2+jMHdFuaj0m8Myw48LUXMyOYOeoFuB7D6VYmBEl3l2hoR9Mrjt0PnX6eyVox6HrLNRdWtB7Fb6SHkt0dru+2ox6jShAZ5kh0kSr75/rzycLGo6bfURrndy1bZ/a7G+U+dK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3DTNLJC; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4774ce422easo70110101cf.1
        for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 07:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745417891; x=1746022691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vi6NkGZKPqFR379t/RdwBM9n8qT18BsavZ9QsWAshKs=;
        b=E3DTNLJC7M7USOqe6flIipG/WFrVY0pkSXeYC/E1StgmmoKNDPh0T0TusLtbZpUWIr
         x0clo1EYBWC09LhMVXQFehMTPKCcYswPK/KMwwUqno71wszudIHbi0N0q62X9EynlEwz
         YYul/XjwSdHUa/V0gybZsGl9jjWedGryWjyFAZvqpD17cvCfLjmNmApLxgaHtJuEF8Iv
         NpgIC3aufrxXUOhLfx60qmwwk1OASDuU7tD2jLiJ+QbYpadrr8PopVxmZhedezcyFrmV
         USxAFMaNCyliLuizGaS5E0UgeDEM3t9AYZCx7tD5odNegQgiLizpa3sO5OrImERuh25n
         5ZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745417891; x=1746022691;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vi6NkGZKPqFR379t/RdwBM9n8qT18BsavZ9QsWAshKs=;
        b=mgnwdEHDJ8Vie1Tp9MU85BaGnyC/W8ljyi1eKDo5hmPnrIjH2mZQn98pqlGsXOXuUV
         zdPIskOHyTYYECLabbHahZs8VE3VWSr7H4tvd5fvoyABoEFyWqfSpNp/LypdNO6anvtR
         lpARChZM//sUha0+7GrmJqZtzDUA1A76YSR7kYueNWXHljBb4YCX5GbE7IqVnC8GLu7W
         lIJKHafdgGWSqm8gIl7BPdnRSd4Jvr9CRh8iPiesRAHm6eqQmt3YWm4UoeKUSrEk+3v0
         jD5s8Ey4QZwBj5kilyMEhksrzMq59lGCcshWsmeXauZObe0S3u5V0HVGu5W0pj4f9y+h
         Nwxw==
X-Gm-Message-State: AOJu0Yw0/oaA9pU3iSoNtcqK92bV7BKxW68IxegKHh3X1l6+eMbreXmF
	WDDrXXzq/sf2iNNd72jpzciM2AVQkT6I3A47Wh1qN14i1RqnyWVW
X-Gm-Gg: ASbGncsFcm3TaII4TomZ4uD4nx0tLSHTKMHjfYwM6XAd4orNls/4b6p7ODSi+kghPeP
	KgGikxnSaTmlpkfzgEyXp5RvAtWjOyTKV99ygg5m2syAhkdBNkE4KiFbchd2EuvCqgJXDcZsC+L
	ul7/4CPywRdZbb+3MJv9Kk8J4Nn9fQVh7T831Dt4GNN9DdLe4xgl8fB6WEC57N2TVWeYoDpQRKj
	O1W/Fkan8G3zwftz8LvhwddUK8LZ+n4bpOi7ZGRe/ICorgLALN+yQPBpUW3PycA/eZ2jBxVImGb
	3JsK4bkG36Z0Hfn4cQau5WcWEj9HxDuPzD62t2DjAVtrt5/XtVmtULDKzp1QIgLQhb2zN3i2oY9
	/UuUJa+h4Cba2/5TUcTnO
X-Google-Smtp-Source: AGHT+IGPeQynyWvwe/noz2uD05L6cYnPjIGgFl+dAtR1yfE/HjwI982UTlvkXWK8g15V49eMWuNwJA==
X-Received: by 2002:a05:622a:203:b0:476:b33f:6694 with SMTP id d75a77b69052e-47aec41155fmr377075451cf.28.1745417890422;
        Wed, 23 Apr 2025 07:18:10 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47ae9c16d3csm68336271cf.11.2025.04.23.07.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 07:18:09 -0700 (PDT)
Date: Wed, 23 Apr 2025 10:18:09 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ido Schimmel <idosch@idosch.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 horms@kernel.org, 
 idosch@nvidia.com, 
 kuniyu@amazon.com, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <6808f6a11ba60_20419294d4@willemb.c.googlers.com.notmuch>
In-Reply-To: <aAitarcdcgq9x6uL@shredder>
References: <20250420180537.2973960-1-willemdebruijn.kernel@gmail.com>
 <20250420180537.2973960-4-willemdebruijn.kernel@gmail.com>
 <aAitarcdcgq9x6uL@shredder>
Subject: Re: [PATCH net-next 3/3] selftests/net: test tcp connection load
 balancing
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
> On Sun, Apr 20, 2025 at 02:04:31PM -0400, Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> > 
> > Verify that TCP connections use both routes when connecting multiple
> > times to a remote service over a two nexthop multipath route.
> > 
> > Use netcat to create the connections. Use tc prio + tc filter to
> > count routes taken, counting SYN packets across the two egress
> > devices.
> > 
> > To avoid flaky tests when testing inherently randomized behavior,
> > set a low bar and pass if even a single SYN is observed on both
> > devices.
> > 
> > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > 
> > ---
> > 
> > Integrated into fib_nexthops.sh as it covers multipath nexthop
> > routing and can reuse all of its setup(), but technically the test
> > does not use nexthop *objects* as is, so I can also move into a
> > separate file and move common setup code to lib.sh if preferred.
> 
> No strong preference, but fib_nexthops.sh explicitly tests nexthop
> objects, so including here a test that doesn't use them is a bit weird.
> Did you consider putting this in fib_tests.sh instead?

Ok, that is a more logical location.

The main reason for fib_nexthops.sh was that it can reuse all of its
setup().

But I can probably use route_setup and manually add ns remote and
veth5 and 6. Will take a look.
 
> > ---
> >  tools/testing/selftests/net/fib_nexthops.sh | 83 +++++++++++++++++++++
> >  1 file changed, 83 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
> > index b39f748c2572..93d19e92bd5b 100755
> > --- a/tools/testing/selftests/net/fib_nexthops.sh
> > +++ b/tools/testing/selftests/net/fib_nexthops.sh
> > @@ -31,6 +31,7 @@ IPV4_TESTS="
> >  	ipv4_compat_mode
> >  	ipv4_fdb_grp_fcnal
> >  	ipv4_mpath_select
> > +	ipv4_mpath_balance
> >  	ipv4_torture
> >  	ipv4_res_torture
> >  "
> > @@ -45,6 +46,7 @@ IPV6_TESTS="
> >  	ipv6_compat_mode
> >  	ipv6_fdb_grp_fcnal
> >  	ipv6_mpath_select
> > +	ipv6_mpath_balance
> >  	ipv6_torture
> >  	ipv6_res_torture
> >  "
> > @@ -2110,6 +2112,87 @@ ipv4_res_torture()
> >  	log_test 0 0 "IPv4 resilient nexthop group torture test"
> >  }
> >  
> > +# Install a prio qdisc with separate bands counting IPv4 and IPv6 SYNs
> > +tc_add_syn_counter() {
> > +	local -r dev=$1
> > +
> > +	# qdisc with band 1 for no-match, band 2 for ipv4, band 3 for ipv6
> > +	ip netns exec $me tc qdisc add dev $dev root handle 1: prio bands 3 \
> > +		priomap 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> > +	ip netns exec $me tc qdisc add dev $dev parent 1:1 handle 2: pfifo
> > +	ip netns exec $me tc qdisc add dev $dev parent 1:2 handle 4: pfifo
> > +	ip netns exec $me tc qdisc add dev $dev parent 1:3 handle 6: pfifo
> > +
> > +	# ipv4 filter on SYN flag set: band 2
> > +	ip netns exec $me tc filter add dev $dev parent 1: protocol ip u32 \
> > +		match ip protocol 6 0xff \
> > +		match ip dport 8000 0xffff \
> > +		match u8 0x02 0xff at 33 \
> > +		flowid 1:2
> > +
> > +	# ipv6 filter on SYN flag set: band 3
> > +	ip netns exec $me tc filter add dev $dev parent 1: protocol ipv6 u32 \
> > +		match ip6 protocol 6 0xff \
> > +		match ip6 dport 8000 0xffff \
> > +		match u8 0x02 0xff at 53 \
> > +		flowid 1:3
> > +}
> > +
> > +tc_get_syn_counter() {
> > +	ip netns exec $me tc -j -s qdisc show dev $1 handle $2 | jq .[0].packets
> > +}
> > +
> > +ip_mpath_balance() {
> > +	local -r ipver="-$1"
> > +	local -r daddr=$2
> > +	local -r handle="$1:"
> > +	local -r num_conn=20
> > +
> > +	tc_add_syn_counter veth1
> > +	tc_add_syn_counter veth3
> > +
> > +	for i in $(seq 1 $num_conn); do
> > +		ip netns exec $remote nc $ipver -l -p 8000 >/dev/null &
> > +		echo -n a | ip netns exec $me nc $ipver -q 0 $daddr 8000
> 
> I don't have the '-q' option in Fedora:
> 
> # ./fib_nexthops.sh -t ipv4_mpath_balance
> nc: invalid option -- 'q'
> [...]
> Tests passed:   0
> Tests failed:   1
> Tests skipped:  0
> 
> We had multiple problems in the past with 'nc' because of different
> distributions using different versions. See for example:
> 
> ba6fbd383c12dfe6833968e3555ada422720a76f
> 5e8670610b93158ffacc3241f835454ff26a3469
> 
> Maybe use 'socat' instead?

Ack, will change.

> > +	done
> > +
> > +	local -r syn0="$(tc_get_syn_counter veth1 $handle)"
> > +	local -r syn1="$(tc_get_syn_counter veth3 $handle)"
> > +	local -r syns=$((syn0+syn1))
> > +
> > +	[ "$VERBOSE" = "1" ] && echo "multipath: syns seen: ($syn0,$syn1)"
> > +
> > +	[[ $syns -ge $num_conn ]] && [[ $syn0 -gt 0 ]] && [[ $syn1 -gt 0 ]]
> 
> IIUC, this only tests that connections to the same destination address
> and destination port are load balanced across all the paths (patch #2),
> but it doesn't test that each connection uses the source address of the
> egress interface (patch #1). Any reason not to test both? I'm asking
> because I expect the current test to pass even without both patches.
> 
> I noticed that you are using tc-u32 for the matching, but with tc-flower
> you can easily match on both 'src_ip' and 'tcp_flags'.

Will do. Thanks!

> > +}
> > +
> > +ipv4_mpath_balance()
> > +{
> > +	$IP route add 172.16.101.1 \
> > +		nexthop via 172.16.1.2 \
> > +		nexthop via 172.16.2.2
> > +
> > +	ip netns exec $me \
> > +		sysctl -q -w net.ipv4.fib_multipath_hash_policy=1
> > +
> > +	ip_mpath_balance 4 172.16.101.1
> > +
> > +	log_test $? 0 "Multipath loadbalance"
> > +}
> > +
> > +ipv6_mpath_balance()
> > +{
> > +	$IP route add 2001:db8:101::1\
> > +		nexthop via 2001:db8:91::2 \
> > +		nexthop via 2001:db8:92::2
> > +
> > +	ip netns exec $me \
> > +		sysctl -q -w net.ipv6.fib_multipath_hash_policy=1
> > +
> > +	ip_mpath_balance 6 2001:db8:101::1
> > +
> > +	log_test $? 0 "Multipath loadbalance"
> > +}
> > +
> >  basic()
> >  {
> >  	echo
> > -- 
> > 2.49.0.805.g082f7c87e0-goog
> > 
> > 



