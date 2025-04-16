Return-Path: <netdev+bounces-183318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F045A90568
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A235E18902F0
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 14:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58D41B4132;
	Wed, 16 Apr 2025 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCT0p4IA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816301598F4
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 13:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811335; cv=none; b=NX85BncznYEY6ql5pKetjgxW4taeg/+SzjIhcIewXv8x1rMapuKSOfD2Gj/77WkQc1MCmYeqEYvEODDeTGWtppZfRF4Ppbb301xji+axsnZVVP6bUXzdnIhVvaEhcnsoDVVGyGvxcrx1xjN+cOOqzNZqcArGg/e0UgYR3GcPhGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811335; c=relaxed/simple;
	bh=fSgnS50n0wAp/FpMmJ8OfCsZHIEtqenXia+MkV04Ttk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n+CigM3iiydF+NNffOCl6d9rR1dLIKaQ005f42Z+JdfegLEC1/02n1SGvtSWHa/FTyetP25IqHe7gKAX80KVpcgoygsKN1OcxJEPby943dp3gEt+gD4q4V1VN4WbtH8QPPkfXTnoeejwwEPsNX9liNqjMkZfW54j7Kk8+aJ2SYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCT0p4IA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99163C4CEE2;
	Wed, 16 Apr 2025 13:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744811334;
	bh=fSgnS50n0wAp/FpMmJ8OfCsZHIEtqenXia+MkV04Ttk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WCT0p4IAWVA73/cdlDpYRp/1K7sljtWEcYQghVQx6eIaMgugfHYFzXAIIuV2yXINx
	 NTuFIyoHx1BsXrGZ1oDjz2YDerUiyj1uhv1dYf/12w5P5rjoUZ9hJS3VaQ2mT7KX8e
	 uU2A9aooBg9of/3dbiveMKODEaCn0OL7DenHZuGkl/QoRbBChuyBcjt6wPG7rUCfX8
	 +GZhDdZagJLc5+sjKms7IbfoOMr6JyQ3uDD0uqcAGyyNROWrXnx+oDZXB6eZRQ8uqj
	 uD29rhwITXInKYyglxPRBwaTKdRIMnx+3amQJSSOIBw2aiurfLTkrrtAzw2aQTxmLK
	 ryIGf9MiDUTew==
Date: Wed, 16 Apr 2025 06:48:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, jdamato@fastly.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Igor Raits <igor@gooddata.com>, Daniel Secik
 <daniel.secik@gooddata.com>, Zdenek Pesek <zdenek.pesek@gooddata.com>, Eric
 Dumazet <edumazet@google.com>, Martin Karsten <mkarsten@uwaterloo.ca>,
 Ahmed Zaki <ahmed.zaki@intel.com>, "Czapnik, Lukasz"
 <lukasz.czapnik@intel.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>
Subject: Re: Increased memory usage on NUMA nodes with ICE driver after
 upgrade to 6.13.y (regression in commit 492a044508ad)
Message-ID: <20250416064852.39fd4b8f@kernel.org>
In-Reply-To: <CAK8fFZ6ML1v8VCjN3F-r+SFT8oF0xNpi3hjA77aRNwr=HcWqNA@mail.gmail.com>
References: <CAK8fFZ4hY6GUJNENz3wY9jaYLZXGfpr7dnZxzGMYoE44caRbgw@mail.gmail.com>
	<4a061a51-8a6c-42b8-9957-66073b4bc65f@intel.com>
	<20250415175359.3c6117c9@kernel.org>
	<CAK8fFZ6ML1v8VCjN3F-r+SFT8oF0xNpi3hjA77aRNwr=HcWqNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 09:13:23 +0200 Jaroslav Pulchart wrote:
> By "traced" I mean using the kernel and checking memory situation on
> numa nodes with and without production load.  Numa nodes, with X810
> NIC, showing a quite less available memory with default queue length
> (num of all cpus) and it needs to be lowered to 1-2 (for unused
> interfaces) and up-to-count of numa node cores on used interfaces to
> make the memory allocation reasonable and server avoiding "kswapd"...
> 
> See "MemFree" on numa 0 + 1 on different/smaller but utilized (running
> VMs + using network) host server with 8 numa nodes (32GB RAM each, 28G
> in Hugepase for VMs and 4GB for host os):

FWIW you can also try the tools/net/ynl/samples/page-pool
application, not sure if Intel NICs init page pools appropriately
but this will show you exactly how much memory is sitting on Rx rings
of the driver (and in net socket buffers).

> 6.13.y vanilla (lot of kswapd0 in background):
>     NUMA nodes:     0       1       2       3       4       5       6       7
>     HPTotalGiB:     28      28      28      28      28      28      28      28
>     HPFreeGiB:      0       0       0       0       0       0       0       0
>     MemTotal:       32220   32701   32701   32686   32701   32701
> 32701   32696
>     MemFree:        274     254     1327    1928    1949    2683    2624    2769
> 6.13.y + Revert (no memory issues at all):
>     NUMA nodes: 0 1 2 3 4 5 6 7
>     HPTotalGiB: 28 28 28 28 28 28 28 28
>     HPFreeGiB: 0 0 0 0 0 0 0 0
>     MemTotal: 32220 32701 32701 32686 32701 32701 32701 32696
>     MemFree: 2213 2438 3402 3108 2846 2672 2592 3063
> 
> We need to lower the queue on all X810 interfaces from default (64 in
> this case), to ensure we have memory available for host OS services.
>     ethtool -L em2 combined 1
>     ethtool -L p3p2 combined 1
>     ethtool -L em1 combined 6
>     ethtool -L p3p1 combined 6
> This trick "does not work" without the revert.

And you're reverting just and exactly 492a044508ad13 ?
The memory for persistent config is allocated in alloc_netdev_mqs()
unconditionally. I'm lost as to how this commit could make any
difference :(

