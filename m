Return-Path: <netdev+bounces-81750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E11388B0B9
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 21:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B29C1F61D3F
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 20:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590B037145;
	Mon, 25 Mar 2024 20:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="XWKDKxdZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3916E219E5
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 20:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711396903; cv=none; b=kRR92I+HSHgfsqIL3ypSuSjst2H3324OtHZWMqn50p1pAJv55J6S0L1CRc6+4ew0WZF+8a8vjBEiorMnRjGkUdGplpf4RIIqwGbQ8TfBEKlbseJr+r9BhZGw6G8Z0lSIDza8R7/Y864fa05SzEVv43EdsgCaYdcMWrdTa81N5bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711396903; c=relaxed/simple;
	bh=XZ1A4YTwH5zEO1GPYQ0f5y2SYvysIqvugydOX2x9Tx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDJBE4HXdmvJN1zZMakVwp1MZ6VbSvTHBsOHzYgZ/1rF0nUuOCaSNgxEg6TyODFP3aRcltM6byJgXUrYbnpdroWNtDbGT8NkPYwiTu18LNBrwypPa3KjH+YZP8CjZFzFU7XXEXcP4DdgPwFWYvva9Qpd3riHUmWmirdGJDRPBmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=XWKDKxdZ; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-341cf77b86dso1018957f8f.2
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 13:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1711396899; x=1712001699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tsKNOESdFD0drisVPDLbnpDOi031GKJkcTyWBXm89Js=;
        b=XWKDKxdZKagSKm0+qOGjn6j/ea3OfSQLNE74Cul2RGWTNVYD+OVpaC+zQtcnFVOrPc
         7SAp4YRBxyPo0YapY1CRQxOyzWsfrL5wxpSPGFwpxnAf0tuLTEuEwquV60nnZkE3jKJM
         7Q/xxu39FfN+ObS0SMQyoY7qGdh9V3wfmQP0GkYoaA+j/aJnW3MOC5HiunQCcWubIvq7
         7WVxQfvex0G0jP0/Z+/3ENVm+nsvxQraVH4YfW23tSZ1tsA46UIQvJUwbDvd3AS6368o
         Q92rNh+9KyvdVHBZMsAEv/tQJjwd20lI3Fru9DLRAg3Lj2SB93Er59i2tFAHqtNe/b2W
         otew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711396899; x=1712001699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsKNOESdFD0drisVPDLbnpDOi031GKJkcTyWBXm89Js=;
        b=qjXXN3C9Jjg84Go2a/pbZbTkwo6beqsnCpk4wBsi6Kk2Zpxc/EL63r87TPhf3OokG1
         v1zCuiuUuJKVi1yYs41mQ4FopSRXBYgxMb/IoXlNqSr45GVcXOtDN9hL0Lsggs+wZudz
         Cwos6i7KqEZvHr841sRx62e65M7Htz3xOHcWhJykffKSKGiNQgli1TFx2TCj5WONe+ed
         VuISuAvmnwPW6kvs1GBNGWEAfEggd3CYO3yVT4jWgRZ4/PxqjPZfdDoypyERovPJNJm0
         4srWPabuYwH/xwRA9qCKvLNGyWW+4SLHg6WigVowmLaZOuKlrdUvMbbpuZ/SDeSwvsQj
         AgLg==
X-Forwarded-Encrypted: i=1; AJvYcCU2ET21bx5UUpy+N+Gn5toDhtLWopMa6GQ05xF/Yyrx3niqjTjD5WT2wYfpNEexq018RA7ONPNbHyfeJdQ/CVpj0AgfMmIa
X-Gm-Message-State: AOJu0YxBAzqW9nS6OafkFF+9XM3LifAyQw6KQXcXRCFYXYCyW9NIdUcM
	Je9XX+dnjVUCjwYYrz0O/Mq9xaR3ZYRz/9+0P9W4AtBSbH92SLTJs2UCSlVJlos=
X-Google-Smtp-Source: AGHT+IEyKGMNdnn1O4slE81e1f84CX12aqMvsP0Lw1U4XMM/80xwbysGLhn0GBoJCzJhYR77O2nhRw==
X-Received: by 2002:a5d:4ed1:0:b0:33e:bf34:4af1 with SMTP id s17-20020a5d4ed1000000b0033ebf344af1mr6784987wrv.39.1711396899531;
        Mon, 25 Mar 2024 13:01:39 -0700 (PDT)
Received: from zh-lab-node-5 ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id w17-20020adfcd11000000b0033e786abf84sm10248652wrm.54.2024.03.25.13.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 13:01:38 -0700 (PDT)
Date: Mon, 25 Mar 2024 20:03:38 +0000
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
Message-ID: <ZgHYmrwaHh39pg//@zh-lab-node-5>
References: <20240322140244.50971-1-aspsk@isovalent.com>
 <20240322140244.50971-3-aspsk@isovalent.com>
 <e8062ef6-b630-45e2-8009-4d2cdc0970ea@linux.dev>
 <ZgBA6X0QgP+TMFd9@zh-lab-node-5>
 <20e4ebd6-0f75-4472-88f3-96d07af6f665@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20e4ebd6-0f75-4472-88f3-96d07af6f665@linux.dev>

On Mon, Mar 25, 2024 at 11:12:39AM -0700, Martin KaFai Lau wrote:
> On 3/24/24 8:04 AM, Anton Protopopov wrote:
> > On Sat, Mar 23, 2024 at 03:34:10PM -0700, Martin KaFai Lau wrote:
> > > On 3/22/24 7:02 AM, Anton Protopopov wrote:
> > > > This patch extends the fib_lookup test suite by adding a few test
> > > > cases for each IP family to test the new BPF_FIB_LOOKUP_MARK flag
> > > > to the bpf_fib_lookup:
> > > > 
> > > >     * Test destination IP address selection with and without a mark
> > > >       and/or the BPF_FIB_LOOKUP_MARK flag set
> > > > 
> > > > To test this functionality another network namespace and a new veth
> > > > pair were added to the test.
> > > > 
> > > 
> > > [ ... ]
> > > 
> > > >    static const struct fib_lookup_test tests[] = {
> > > > @@ -90,10 +105,47 @@ static const struct fib_lookup_test tests[] = {
> > > >    	  .daddr = IPV6_ADDR_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
> > > >    	  .expected_src = IPV6_IFACE_ADDR_SEC,
> > > >    	  .lookup_flags = BPF_FIB_LOOKUP_SRC | BPF_FIB_LOOKUP_SKIP_NEIGH, },
> > > > +	/* policy routing */
> > > > +	{ .desc = "IPv4 policy routing, default",
> > > > +	  .daddr = IPV4_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
> > > > +	  .expected_dst = IPV4_GW1, .ifname = "veth3",
> > > > +	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH, },
> > > > +	{ .desc = "IPv4 policy routing, mark doesn't point to a policy",
> > > > +	  .daddr = IPV4_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
> > > > +	  .expected_dst = IPV4_GW1, .ifname = "veth3",
> > > > +	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH,
> > > > +	  .mark = MARK_NO_POLICY, },
> > > > +	{ .desc = "IPv4 policy routing, mark points to a policy",
> > > > +	  .daddr = IPV4_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
> > > > +	  .expected_dst = IPV4_GW2, .ifname = "veth3",
> > > > +	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH,
> > > > +	  .mark = MARK, },
> > > > +	{ .desc = "IPv4 policy routing, mark points to a policy, but no flag",
> > > > +	  .daddr = IPV4_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
> > > > +	  .expected_dst = IPV4_GW1, .ifname = "veth3",
> > > > +	  .lookup_flags = BPF_FIB_LOOKUP_SKIP_NEIGH,
> > > > +	  .mark = MARK, },
> > > > +	{ .desc = "IPv6 policy routing, default",
> > > > +	  .daddr = IPV6_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
> > > > +	  .expected_dst = IPV6_GW1, .ifname = "veth3",
> > > > +	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH, },
> > > > +	{ .desc = "IPv6 policy routing, mark doesn't point to a policy",
> > > > +	  .daddr = IPV6_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
> > > > +	  .expected_dst = IPV6_GW1, .ifname = "veth3",
> > > > +	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH,
> > > > +	  .mark = MARK_NO_POLICY, },
> > > > +	{ .desc = "IPv6 policy routing, mark points to a policy",
> > > > +	  .daddr = IPV6_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
> > > > +	  .expected_dst = IPV6_GW2, .ifname = "veth3",
> > > > +	  .lookup_flags = BPF_FIB_LOOKUP_MARK | BPF_FIB_LOOKUP_SKIP_NEIGH,
> > > > +	  .mark = MARK, },
> > > > +	{ .desc = "IPv6 policy routing, mark points to a policy, but no flag",
> > > > +	  .daddr = IPV6_REMOTE_DST, .expected_ret = BPF_FIB_LKUP_RET_SUCCESS,
> > > > +	  .expected_dst = IPV6_GW1, .ifname = "veth3",
> > > > +	  .lookup_flags = BPF_FIB_LOOKUP_SKIP_NEIGH,
> > > > +	  .mark = MARK, },
> > > >    };
> > > > -static int ifindex;
> > > > -
> > > >    static int setup_netns(void)
> > > >    {
> > > >    	int err;
> > > > @@ -144,12 +196,40 @@ static int setup_netns(void)
> > > >    	if (!ASSERT_OK(err, "write_sysctl(net.ipv6.conf.veth1.forwarding)"))
> > > >    		goto fail;
> > > > +	/* Setup for policy routing tests */
> > > > +	SYS(fail, "ip link add veth3 type veth peer name veth4");
> > > > +	SYS(fail, "ip link set dev veth3 up");
> > > > +	SYS(fail, "ip link set dev veth4 netns %s up", NS_REMOTE);
> > > > +
> > > > +	SYS(fail, "ip addr add %s/24 dev veth3", IPV4_LOCAL);
> > > > +	SYS(fail, "ip netns exec %s ip addr add %s/24 dev veth4", NS_REMOTE, IPV4_GW1);
> > > > +	SYS(fail, "ip netns exec %s ip addr add %s/24 dev veth4", NS_REMOTE, IPV4_GW2);
> > > > +	SYS(fail, "ip addr add %s/64 dev veth3 nodad", IPV6_LOCAL);
> > > > +	SYS(fail, "ip netns exec %s ip addr add %s/64 dev veth4 nodad", NS_REMOTE, IPV6_GW1);
> > > > +	SYS(fail, "ip netns exec %s ip addr add %s/64 dev veth4 nodad", NS_REMOTE, IPV6_GW2);
> > > 
> > > Trying to see if the setup can be simplified.
> > > 
> > > Does it need to add another netns and setup a reachable IPV[46]_GW[12] gateway?
> > > 
> > > The test is not sending any traffic and it is a BPF_FIB_LOOKUP_SKIP_NEIGH test.
> > 
> > I think this will not work without another namespace, as FIB lookup will
> > return DST="final destination", not DST="gateway", as the gateway is in the
> > same namespace and can be skipped.
> 
> hmm... not sure I understand why it would get "final destination". Am I missing something?
> To be specific, there is no need to configure the IPV[46]_GW[12] address:
> 
> -	SYS(fail, "ip link set dev veth4 netns %s up", NS_REMOTE);
> 
> 	SYS(fail, "ip addr add %s/24 dev veth3", IPV4_LOCAL);
> -	SYS(fail, "ip netns exec %s ip addr add %s/24 dev veth4", NS_REMOTE, IPV4_GW1);
> -	SYS(fail, "ip netns exec %s ip addr add %s/24 dev veth4", NS_REMOTE, IPV4_GW2);
> 	SYS(fail, "ip addr add %s/64 dev veth3 nodad", IPV6_LOCAL);
> -	SYS(fail, "ip netns exec %s ip addr add %s/64 dev veth4 nodad", NS_REMOTE, IPV6_GW1);
> -	SYS(fail, "ip netns exec %s ip addr add %s/64 dev veth4 nodad", NS_REMOTE, IPV6_GW2);
> 	SYS(fail, "ip route add %s/32 via %s", IPV4_REMOTE_DST, IPV4_GW1);
> 	SYS(fail, "ip route add %s/32 via %s table %s", IPV4_REMOTE_DST, IPV4_GW2, MARK_TABLE);
> 	SYS(fail, "ip -6 route add %s/128 via %s", IPV6_REMOTE_DST, IPV6_GW1);
> 	SYS(fail, "ip -6 route add %s/128 via %s table %s", IPV6_REMOTE_DST, IPV6_GW2, MARK_TABLE);
> 	SYS(fail, "ip rule add prio 2 fwmark %d lookup %s", MARK, MARK_TABLE);
> 	SYS(fail, "ip -6 rule add prio 2 fwmark %d lookup %s", MARK, MARK_TABLE);
> 
> [root@arch-fb-vm1 ~]# ip netns exec fib_lookup_ns /bin/bash
> 
> [root@arch-fb-vm1 ~]# ip -6 rule
> 0:	from all lookup local
> 2:	from all fwmark 0x2a lookup 200
> 32766:	from all lookup main
> 
> [root@arch-fb-vm1 ~]# ip -6 route show table main
> be:ef::b0:10 via fd01::1 dev veth3 metric 1024 linkdown pref medium
> 
> [root@arch-fb-vm1 ~]# ip -6 route show table 200
> be:ef::b0:10 via fd01::2 dev veth3 metric 1024 linkdown pref medium
> 
> [root@arch-fb-vm1 ~]# ip -6 route get be:ef::b0:10
> be:ef::b0:10 from :: via fd01::1 dev veth3 src fd01::3 metric 1024 pref medium
> 
> [root@arch-fb-vm1 ~]# ip -6 route get be:ef::b0:10 mark 0x2a
> be:ef::b0:10 from :: via fd01::2 dev veth3 table 200 src fd01::3 metric 1024 pref medium

Ok, thanks. I will send a v2 with a simplified test

> > 
> > Instead of adding a new namespace I can move the second interface to the
> > root namespace. This will work, but then we're interfering with the root
> > namespace.
> > 
> > > > +	SYS(fail, "ip route add %s/32 via %s", IPV4_REMOTE_DST, IPV4_GW1);
> > > > +	SYS(fail, "ip route add %s/32 via %s table %s", IPV4_REMOTE_DST, IPV4_GW2, MARK_TABLE);
> > > > +	SYS(fail, "ip -6 route add %s/128 via %s", IPV6_REMOTE_DST, IPV6_GW1);
> > > > +	SYS(fail, "ip -6 route add %s/128 via %s table %s", IPV6_REMOTE_DST, IPV6_GW2, MARK_TABLE);
> > > > +	SYS(fail, "ip rule add prio 2 fwmark %d lookup %s", MARK, MARK_TABLE);
> > > > +	SYS(fail, "ip -6 rule add prio 2 fwmark %d lookup %s", MARK, MARK_TABLE);
> > > > +
> > > > +	err = write_sysctl("/proc/sys/net/ipv4/conf/veth3/forwarding", "1");
> > > > +	if (!ASSERT_OK(err, "write_sysctl(net.ipv4.conf.veth3.forwarding)"))
> > > > +		goto fail;
> > > > +
> > > > +	err = write_sysctl("/proc/sys/net/ipv6/conf/veth3/forwarding", "1");
> > > > +	if (!ASSERT_OK(err, "write_sysctl(net.ipv6.conf.veth3.forwarding)"))
> > > > +		goto fail;
> > > > +
> > > >    	return 0;
> > > >    fail:
> > > >    	return -1;
> > > >    }
> > > 
> > > [ ... ]
> > > 
> > > > @@ -248,6 +337,7 @@ void test_fib_lookup(void)
> > > >    	prog_fd = bpf_program__fd(skel->progs.fib_lookup);
> > > >    	SYS(fail, "ip netns add %s", NS_TEST);
> > > > +	SYS(fail, "ip netns add %s", NS_REMOTE);
> > > 
> > > 
> 

