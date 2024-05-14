Return-Path: <netdev+bounces-96368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E310D8C5763
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 15:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21243B21C4D
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 13:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EE81448D9;
	Tue, 14 May 2024 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fo32lb3T"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D021448E4
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 13:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715694749; cv=none; b=h/SE/Ne+OiASlCsOcGyGyV395yuXtAAJlBNtSfsROFT/5SFA/4rJtDpue2BFHo6lh9YvDOWCh8FaZVLAXOHH52O8Dr3Mr+isd8z7PpqFVzDG4X6SQK+u2SfmWMVgeab6XWIJyAsNoYHy4/efchfWNIwyvBPF/ccAFnIJOHg+sF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715694749; c=relaxed/simple;
	bh=r7IiO1Xeb2szjHBIn38qHN9aDTifNIqwfBWyVHFFGkQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Orx3lFWNqKDufGaCXlDt/41NZbxNjvdS3W8CCoe344xv8IV8Op9nb93tLgborxOVsNuPO3SSC0+E4w4Gi1RHJe9SOLDn8CtzngPmt/83K8CG+yNPlIFm8xscueIfyyfiUsWlAguhJYcOUlQshZfHAgs/mwXUD7d+vIiXG/RWv3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fo32lb3T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715694746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/QPVyi6U0s8ueyPqr+U0UHZJyOKip8AC8X/u8ky+kLg=;
	b=Fo32lb3TvIG6oSqQT6VvRM/fVKspH8UBO+2PEniH5HJBy7od6ikfswjB6fb5xYg4mHbtsK
	FTNHXx9pZzIOJruNo/wa0DsXej0kkEvCqy0kouG8PMUMdy14Y6W5ySTaW7e8mKyHg5eyel
	ueJYCjqrlfvOYcQ5caJoc/r0XGWiqMg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-mrJHI_-TP8CxcAzeC9A7fw-1; Tue,
 14 May 2024 09:52:20 -0400
X-MC-Unique: mrJHI_-TP8CxcAzeC9A7fw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C55E280095E;
	Tue, 14 May 2024 13:52:19 +0000 (UTC)
Received: from RHTRH0061144 (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D6E28C15BF3;
	Tue, 14 May 2024 13:52:18 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,  Florian Westphal <fw@strlen.de>,
  Hangbin Liu <liuhangbin@gmail.com>,  Jaehee Park <jhpark1013@gmail.com>,
  Petr Machata <petrm@nvidia.com>,  Nikolay Aleksandrov
 <razor@blackwall.org>,  Ido Schimmel <idosch@nvidia.com>,  Davide Caratti
 <dcaratti@redhat.com>,  Matthieu Baerts <matttbe@kernel.org>,
  netdev@vger.kernel.org
Subject: Re: [TEST] Flake report
In-Reply-To: <20240511132724.GF2347895@kernel.org> (Simon Horman's message of
	"Sat, 11 May 2024 14:27:24 +0100")
References: <20240509160958.2987ef50@kernel.org>
	<20240511132724.GF2347895@kernel.org>
Date: Tue, 14 May 2024 09:52:18 -0400
Message-ID: <f7ta5ks7b71.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Simon Horman <horms@kernel.org> writes:

> + Aaron
>
> On Thu, May 09, 2024 at 04:09:58PM -0700, Jakub Kicinski wrote:
>> Hi!
>> 
>> Feels like the efforts to get rid of flaky tests have slowed down a bit,
>> so I thought I'd poke people..
>> 
>> Here's the full list:
>> https://netdev.bots.linux.dev/flakes.html?min-flip=0&pw-y=0
>> click on test name to get the list of runs and links to outputs.
>> 
>> As a reminder please see these instructions for repro:
>> https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style
>> 
>> I'll try to tag folks who touched the tests most recently, but please
>> don't hesitate to chime in.
>> 
>> 
>> net
>> ---
>> 
>> arp-ndisc-untracked-subnets-sh
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> To: Jaehee Park <jhpark1013@gmail.com>
>> Cc: Hangbin Liu <liuhangbin@gmail.com>
>> 
>> Times out on debug kernels, passes on non-debug.
>> This is a real timeout, eats full 7200 seconds.
>> 
>> xfrm-policy-sh
>> ~~~~~~~~~~~~~~
>> To: Hangbin Liu <liuhangbin@gmail.com>
>> 
>> Times out on debug kernels, passed on non-debug,
>> This is a "inactivity" timeout, test doesn't print anything
>> for 900 seconds so the runner kills it. We can bump the timeout
>> but not printing for 15min is bad..
>> 
>> cmsg-time-sh
>> ~~~~~~~~~~~~
>> To: Jakub Kicinski <kuba@kernel.org> (forgot I wrote this :D)
>> 
>> Fails randomly.
>> 
>> pmtu-sh
>> ~~~~~~~
>> To: Simon Horman <horms@kernel.org>
>> 
>> Skipped because it wants full OVS tooling.
>
> My understanding is that Aaron (CCed) is working on addressing
> this problem by allowing the test to run without full OVS tooling.

Yes.

>> forwarding
>> ----------
>> 
>> sch-tbf-ets-sh, sch-tbf-prio-sh
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> To: Petr Machata <petrm@nvidia.com>
>> 
>> These fail way too often on non-debug kernels :(
>> Perhaps we can extend the lower bound?
>> 
>> bridge-igmp-sh, bridge-mld-sh
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> To: Nikolay Aleksandrov <razor@blackwall.org>
>> Cc: Ido Schimmel <idosch@nvidia.com>
>> 
>> On debug kernels it always fails with:
>> 
>> # TEST: IGMPv3 group 239.10.10.10 exclude timeout                     [FAIL]
>> # Entry 192.0.2.21 has blocked flag failed
>> 
>> For MLD:
>> 
>> # TEST: MLDv2 group ff02::cc exclude timeout                          [FAIL]
>> # Entry 2001:db8:1::21 has blocked flag failed
>> 
>> vxlan-bridge-1d-sh
>> ~~~~~~~~~~~~~~~~~~
>> To: Ido Schimmel <idosch@nvidia.com>
>> Cc: Petr Machata <petrm@nvidia.com>
>> 
>> Flake fails almost always, with some form of "Expected to capture 0
>> packets, got $X"
>> 
>> mirror-gre-lag-lacp-sh
>> ~~~~~~~~~~~~~~~~~~~~~~
>> To: Petr Machata <petrm@nvidia.com>
>> 
>> Often fails on debug with:
>> 
>> # TEST: mirror to gretap: LAG first slave (skip_hw)                   [FAIL]
>> # Expected to capture 10 packets, got 13.
>> 
>> mirror-gre-vlan-bridge-1q-sh, mirror-gre-bridge-1d-vlan-sh
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> To: Petr Machata <petrm@nvidia.com>
>> 
>> Same kind of failure as above but less often and both on debug and non-debug.
>> 
>> tc-actions-sh
>> ~~~~~~~~~~~~~
>> To: Davide Caratti <dcaratti@redhat.com>
>> 
>> It triggers a random unhandled interrupt, somehow (look at stderr).
>> It's the only test that does that.
>> 
>> 
>> mptcp
>> -----
>> To: Matthieu Baerts <matttbe@kernel.org>
>> 
>> simult-flows-sh is still quite flaky :(
>> 
>> 
>> nf
>> --
>> To: Florian Westphal <fw@strlen.de>
>> 
>> These are skipped because of some compatibility issues:
>> 
>>  nft-flowtable-sh, bridge-brouter-sh, nft-audit-sh
>> 
>> Please LMK if I need to update the CLI tooling. 
>> Or is this missing kernel config?
>> 


