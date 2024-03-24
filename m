Return-Path: <netdev+bounces-81422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDEC887D4B
	for <lists+netdev@lfdr.de>; Sun, 24 Mar 2024 16:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C09AB20EB0
	for <lists+netdev@lfdr.de>; Sun, 24 Mar 2024 15:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5944A18638;
	Sun, 24 Mar 2024 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="B3U1Sp1d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776281946B
	for <netdev@vger.kernel.org>; Sun, 24 Mar 2024 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711292531; cv=none; b=XKmEMWbxyGuq2ecMia4FNxZc3HOYpe0Th8nDIuhGuTM8/UtYHJQiXjRv9Z8CEv2W9O0/fSlVTupkfER1Ho3LNQQy+gvG13vgpT8EHTVLxlosK2cELhH0cVDSIE6gBjcb59zka2F65xmIxV3hZ9FjBWR0nuZ2RhQybvbpzTJ5HjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711292531; c=relaxed/simple;
	bh=S6qfD0zgm/C1QM9Fjq9ddi/LiYV0zs+lIqLpWZeK7t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0WNYcpKGo5ea9KxPQJu7IoGKJwqf5OT6k9sXrd0h7d/XRIQ/VrloahYq+yYMaJ7Y6TP6hZqB4hbhjgUHLI4mDo+88WpUpZAPTFLAMPmHuWhHtOJvOtJzoP0QyIqWviDZIiKIXFxptyW/+kqIxwQiHQUgqD6OodThdC0zXIFqVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=B3U1Sp1d; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33fd12a06fdso2481510f8f.1
        for <netdev@vger.kernel.org>; Sun, 24 Mar 2024 08:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1711292528; x=1711897328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EwGW9a4Qg8RuP4nfFSPxy3bqmYCTRCuNE09UvfgZEmE=;
        b=B3U1Sp1dPyJNFkgBDmjST2PC5m2HnkAW1/bEUvsaL53/6TKLaG9iq5nB7RmmSDQH+i
         MHjR3CiJN4Eg6HMt3Y8Kgce8HN0yTCl26ZU2Ocd+HjhPy0rxXyk+Aq+Sxqc7rin38036
         X+RpyNfyOTWBrq+KvLUg02uG6S/IBBQLRk0qkqOc8ix/EC+nKQ8CiPV/IQh0UW02zkon
         LfJ9aY/0QBXiqT73OlMsKKGEUwwpHD0gUuGubK3pir14cBaQOFccpQ0BQriwrc03xDY3
         sNytQprQLNCTlUFdgtVvzP7anZ/fdESyiuC05F+NPnqtYbPlNWXQck9AYpuUhSegarsR
         lPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711292528; x=1711897328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwGW9a4Qg8RuP4nfFSPxy3bqmYCTRCuNE09UvfgZEmE=;
        b=nz1xxV9J8geA4nlsA4jsLBy7XZ2/5E7Ncw8hXuaoqRibc7p8QS58LZi82uYByRTMIb
         dPAogAqgloza9vaEA46rCYVq4x96jVtsx1dcN/xSSBLdjiIPpMgZcN+wr+WGPYf/OsXd
         IG3nKQMInZNXOhydI1EM3rLT7XPKlQMSUAQYEI4mC54F7ksgRMoVTZkH8KRSCR1IJ/h+
         qHtmqFUyE19JceFQYihsTeVZXFF5KnqunlS/FEXcivfBN6o6vqgbWThVcQJJ0mIlZtQv
         jEU2D60vqI5ep870bptxTHfiaugxLchlMh7IG1ONsg1BIbnPXcamCzSZhqRxVvhrsXzB
         ysiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCkxQTG69vqnhtcdu6lpnLElBK2oilXCT3zm6+e3Pr/4jqN9r5vwBarzabKIfKMasVBGbbHdqN4GnYw2torNSL3ZlTijHz
X-Gm-Message-State: AOJu0YxnIzH7AJeRH6FEG6arZJm4nRq+S9SM5mMCqP8ug/cAsqwecph7
	aPvQFWcl372fm6mJAW10tbAXY83c1vdwH5IA2ifOP1jS7LO5PuAdD6qxCiSsrY4=
X-Google-Smtp-Source: AGHT+IHI0jRg3J5ZCBnBgPwg4wJJT0IzHTHgGiW+iEnazuNFOaYuYRXy/Bq7C0Ctq/vQ5kY9VEz6gg==
X-Received: by 2002:adf:cd11:0:b0:341:8083:b2a3 with SMTP id w17-20020adfcd11000000b003418083b2a3mr2953087wrm.30.1711292527738;
        Sun, 24 Mar 2024 08:02:07 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id df4-20020a5d5b84000000b0033e7b433498sm6987249wrb.111.2024.03.24.08.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 08:02:07 -0700 (PDT)
Date: Sun, 24 Mar 2024 15:04:09 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Rumen Telbizov <rumen.telbizov@menlosecurity.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	bpf@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 2/2] selftests/bpf: Add BPF_FIB_LOOKUP_MARK
 tests
Message-ID: <ZgBA6X0QgP+TMFd9@zh-lab-node-5>
References: <20240322140244.50971-1-aspsk@isovalent.com>
 <20240322140244.50971-3-aspsk@isovalent.com>
 <e8062ef6-b630-45e2-8009-4d2cdc0970ea@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8062ef6-b630-45e2-8009-4d2cdc0970ea@linux.dev>

On Sat, Mar 23, 2024 at 03:34:10PM -0700, Martin KaFai Lau wrote:
> On 3/22/24 7:02 AM, Anton Protopopov wrote:
> > This patch extends the fib_lookup test suite by adding a few test
> > cases for each IP family to test the new BPF_FIB_LOOKUP_MARK flag
> > to the bpf_fib_lookup:
> > 
> >    * Test destination IP address selection with and without a mark
> >      and/or the BPF_FIB_LOOKUP_MARK flag set
> > 
> > To test this functionality another network namespace and a new veth
> > pair were added to the test.
> > 
> 
> [ ... ]
> 
> >   static const struct fib_lookup_test tests[] = {
> > @@ -90,10 +105,47 @@ static const struct fib_lookup_test tests[] = {
> >   	  .daddr = IPV6_ADDR_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
> >   	  .expected_src = IPV6_IFACE_ADDR_SEC,
> >   	  .lookup_flags = BPF_FIB_LOOKUP_SRC | BPF_FIB_LOOKUP_SKIP_NEIGH, },
> > +	/* policy routing */
> > +	{ .desc = "IPv4 policy routing, default",
> > +	  .daddr = IPV4_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
> > +	  .expected_dst = IPV4_GW1, .ifname = "veth3",
> > +	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH, },
> > +	{ .desc = "IPv4 policy routing, mark doesn't point to a policy",
> > +	  .daddr = IPV4_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
> > +	  .expected_dst = IPV4_GW1, .ifname = "veth3",
> > +	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH,
> > +	  .mark = MARK_NO_POLICY, },
> > +	{ .desc = "IPv4 policy routing, mark points to a policy",
> > +	  .daddr = IPV4_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
> > +	  .expected_dst = IPV4_GW2, .ifname = "veth3",
> > +	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH,
> > +	  .mark = MARK, },
> > +	{ .desc = "IPv4 policy routing, mark points to a policy, but no flag",
> > +	  .daddr = IPV4_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
> > +	  .expected_dst = IPV4_GW1, .ifname = "veth3",
> > +	  .lookup_flags = BPF_FIB_LOOKUP_SKIP_NEIGH,
> > +	  .mark = MARK, },
> > +	{ .desc = "IPv6 policy routing, default",
> > +	  .daddr = IPV6_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
> > +	  .expected_dst = IPV6_GW1, .ifname = "veth3",
> > +	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH, },
> > +	{ .desc = "IPv6 policy routing, mark doesn't point to a policy",
> > +	  .daddr = IPV6_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
> > +	  .expected_dst = IPV6_GW1, .ifname = "veth3",
> > +	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH,
> > +	  .mark = MARK_NO_POLICY, },
> > +	{ .desc = "IPv6 policy routing, mark points to a policy",
> > +	  .daddr = IPV6_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
> > +	  .expected_dst = IPV6_GW2, .ifname = "veth3",
> > +	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH,
> > +	  .mark = MARK, },
> > +	{ .desc = "IPv6 policy routing, mark points to a policy, but no flag",
> > +	  .daddr = IPV6_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
> > +	  .expected_dst = IPV6_GW1, .ifname = "veth3",
> > +	  .lookup_flags = BPF_FIB_LOOKUP_SKIP_NEIGH,
> > +	  .mark = MARK, },
> >   };
> > -static int ifindex;
> > -
> >   static int setup_netns(void)
> >   {
> >   	int err;
> > @@ -144,12 +196,40 @@ static int setup_netns(void)
> >   	if (!ASSERT_OK(err, "write_sysctl(net.ipv6.conf.veth1.forwarding)"))
> >   		goto fail;
> > +	/* Setup for policy routing tests */
> > +	SYS(fail, "ip link add veth3 type veth peer name veth4");
> > +	SYS(fail, "ip link set dev veth3 up");
> > +	SYS(fail, "ip link set dev veth4 netns %s up", NS_REMOTE);
> > +
> > +	SYS(fail, "ip addr add %s/24 dev veth3", IPV4_LOCAL);
> > +	SYS(fail, "ip netns exec %s ip addr add %s/24 dev veth4", NS_REMOTE, IPV4_GW1);
> > +	SYS(fail, "ip netns exec %s ip addr add %s/24 dev veth4", NS_REMOTE, IPV4_GW2);
> > +	SYS(fail, "ip addr add %s/64 dev veth3 nodad", IPV6_LOCAL);
> > +	SYS(fail, "ip netns exec %s ip addr add %s/64 dev veth4 nodad", NS_REMOTE, IPV6_GW1);
> > +	SYS(fail, "ip netns exec %s ip addr add %s/64 dev veth4 nodad", NS_REMOTE, IPV6_GW2);
> 
> Trying to see if the setup can be simplified.
> 
> Does it need to add another netns and setup a reachable IPV[46]_GW[12] gateway?
> 
> The test is not sending any traffic and it is a BPF_FIB_LOOKUP_SKIP_NEIGH test.

I think this will not work without another namespace, as FIB lookup will
return DST="final destination", not DST="gateway", as the gateway is in the
same namespace and can be skipped.

Instead of adding a new namespace I can move the second interface to the
root namespace. This will work, but then we're interfering with the root
namespace.

> > +	SYS(fail, "ip route add %s/32 via %s", IPV4_REMOTE_DST, IPV4_GW1);
> > +	SYS(fail, "ip route add %s/32 via %s table %s", IPV4_REMOTE_DST, IPV4_GW2, MARK_TABLE);
> > +	SYS(fail, "ip -6 route add %s/128 via %s", IPV6_REMOTE_DST, IPV6_GW1);
> > +	SYS(fail, "ip -6 route add %s/128 via %s table %s", IPV6_REMOTE_DST, IPV6_GW2, MARK_TABLE);
> > +	SYS(fail, "ip rule add prio 2 fwmark %d lookup %s", MARK, MARK_TABLE);
> > +	SYS(fail, "ip -6 rule add prio 2 fwmark %d lookup %s", MARK, MARK_TABLE);
> > +
> > +	err = write_sysctl("/proc/sys/net/ipv4/conf/veth3/forwarding", "1");
> > +	if (!ASSERT_OK(err, "write_sysctl(net.ipv4.conf.veth3.forwarding)"))
> > +		goto fail;
> > +
> > +	err = write_sysctl("/proc/sys/net/ipv6/conf/veth3/forwarding", "1");
> > +	if (!ASSERT_OK(err, "write_sysctl(net.ipv6.conf.veth3.forwarding)"))
> > +		goto fail;
> > +
> >   	return 0;
> >   fail:
> >   	return -1;
> >   }
> 
> [ ... ]
> 
> > @@ -248,6 +337,7 @@ void test_fib_lookup(void)
> >   	prog_fd = bpf_program__fd(skel->progs.fib_lookup);
> >   	SYS(fail, "ip netns add %s", NS_TEST);
> > +	SYS(fail, "ip netns add %s", NS_REMOTE);
> 
> 

