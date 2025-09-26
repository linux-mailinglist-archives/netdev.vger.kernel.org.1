Return-Path: <netdev+bounces-226569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 116F6BA22D4
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 04:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F941C2637E
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 02:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D03622A7F2;
	Fri, 26 Sep 2025 02:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oonl2xbF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781A517C220
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 02:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758852244; cv=none; b=FMSkITaSrCivKtQ/Knb9V5aGeNgBp4hhyR+KVQARYsZPcJ//jQO/fDnzN/H0x9yc9Q52ygsEj4RwOxzdEcQVac8aXCMoAwdtSTIQKyvAk0PtnyKMd0LAQqC6jWvbRKiDO0+EHcbwPtBV4uJ85qm7Hm9DUIjbPJE7Z40V7E/BMH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758852244; c=relaxed/simple;
	bh=75J+/BCYXqLZXJy2HtE8aY2HcCOpUZrdZ+5TOVwlc+4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GVdLvuHFuH5E62Oyh1kQe4LysjQklDCYk8r5OhCwPCFe75h3GHGbnjtZTysuRpqnsetFXgBomECM8erOs2hA4v2mOePwwKyWUXxh966WaZ/+86N9ni7CY/BVBtpy2lw8CzaxEuBqTO5Q4cAQcxq1glKYxES6VW6kYg8q/VKctOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oonl2xbF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F71EC4CEF0;
	Fri, 26 Sep 2025 02:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758852243;
	bh=75J+/BCYXqLZXJy2HtE8aY2HcCOpUZrdZ+5TOVwlc+4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oonl2xbFc2JomR53IPHS99gyCMvzD4KfqScn+16/n064QsupbA96KDScJitCkMqVB
	 b7D1n3Bf8OiLAzsMELfF//rjFHWV+y+ctQDNwoL2bKSHIltPtXVq9j1gN/A8uyeOFi
	 ZfeX7uhG0lnk/QxU811lQK2sby04xHO94ql55na2676jQX9Nlsm7tOQKCosWgH+Ifc
	 hFXtfUL4ku7qsXDgeNJ7Th1ieEbWT0Mvnbj0WVRwqPPtj+HhCBftRXO6E9OSFFibAT
	 kDljgKIOizXX98T7YIt8ymvz5pSb2iOKirqFIX+8in3Yjmevg2v7swvVYe8S9bPMVt
	 NM+ixF7HxSKqw==
Date: Thu, 25 Sep 2025 19:04:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: <netdev@vger.kernel.org>, "'Andrew Lunn'" <andrew+netdev@lunn.ch>,
 "'David S. Miller'" <davem@davemloft.net>, "'Eric Dumazet'"
 <edumazet@google.com>, "'Paolo Abeni'" <pabeni@redhat.com>, "'Simon
 Horman'" <horms@kernel.org>, "'Alexander Lobakin'"
 <aleksander.lobakin@intel.com>, "'Mengyuan Lou'"
 <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v5 0/4] net: wangxun: support to configure RSS
Message-ID: <20250925190401.70c85ada@kernel.org>
In-Reply-To: <05ab01dc2ded$f2e9a610$d8bcf230$@trustnetic.com>
References: <20250922094327.26092-1-jiawenwu@trustnetic.com>
	<20250924183640.62a1293e@kernel.org>
	<05ab01dc2ded$f2e9a610$d8bcf230$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Sep 2025 15:28:11 +0800 Jiawen Wu wrote:
> On Thu, Sep 25, 2025 9:37 AM, Jakub Kicinski wrote:
> > On Mon, 22 Sep 2025 17:43:23 +0800 Jiawen Wu wrote:  
> > > Implement ethtool ops for RSS configuration, and support multiple RSS
> > > for multiple pools.  
> > 
> > There is a few tests for the RSS API in the tree:
> > 
> > tools/testing/selftests/drivers/net/hw/rss_api.py
> > tools/testing/selftests/drivers/net/hw/rss_ctx.py
> > 
> > Please run these and add the output to the cover letter.
> > 
> > Instructions for running the tests are here:
> > 
> > https://github.com/linux-netdev/nipa/wiki/Running-driver-tests  
> 
> The output shows many fail cases. Is it normal? Or is there some issue
> with my environment?

It's most;u normal, the test don't check capabilities so if you don't
support a feature the test case will fail.

> root@w-MS-7E16:~/net-next# NETIF=enp17s0f0 tools/testing/selftests/drivers/net/hw/rss_api.py
> TAP version 13
> 1..12
> ok 1 rss_api.test_rxfh_nl_set_fail
> ok 2 rss_api.test_rxfh_nl_set_indir
> not ok 3 rss_api.test_rxfh_nl_set_indir_ctx
> ok 4 rss_api.test_rxfh_indir_ntf
> not ok 5 rss_api.test_rxfh_indir_ctx_ntf
> ok 6 rss_api.test_rxfh_nl_set_key
> ok 7 rss_api.test_rxfh_fields
> not ok 9 rss_api.test_rxfh_fields_set_xfrm
> ok 10 rss_api.test_rxfh_fields_ntf
> not ok 11 rss_api.test_rss_ctx_add
> not ok 12 rss_api.test_rss_ctx_ntf
> # Totals: pass:6 fail:6 xfail:0 xpass:0 skip:0 error:0

These all look fine. You don't support RSS contexts (yet) so the
context tests can fail

> root@w-MS-7E16:~/net-next# NETIF=enp17s0f0 LOCAL_V4="10.10.10.1" REMOTE_V4="10.10.10.2" REMOTE_TYPE=ssh
> REMOTE_ARGS="root@192.168.14.104" tools/testing/selftests/drivers/net/hw/rss_ctx.py
> root@192.168.14.104's password:
> TAP version 13
> 1..17
> not ok 1 rss_ctx.test_rss_key_indir
> ok 2 rss_ctx.test_rss_queue_reconfigure # SKIP Not enough queues for the test or qstat not supported
> ok 3 rss_ctx.test_rss_resize
> ok 4 rss_ctx.test_hitless_key_update # SKIP Test requires command: iperf3

Please install iperf3 and retry just this one?

> not ok 5 rss_ctx.test_rss_context

