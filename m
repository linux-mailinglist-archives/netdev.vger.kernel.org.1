Return-Path: <netdev+bounces-177239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE87A6E660
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 23:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A16503BB4B5
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 22:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435231F0E48;
	Mon, 24 Mar 2025 22:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pinnP7xG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176921EEA43;
	Mon, 24 Mar 2025 22:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853874; cv=none; b=BopSqoImm1+lA00lSjlK2Z7fZTiLXPmRLxhRfoJBVbJxqaWiAonCy2YahCQ5fRNLicHJvV9WB3h+JUg9bp4LSboOo8c8lfu4Midu1eTDnseLSx+426Ff4WS9mW8ULIdxbB3lv3iGuRpjldNV4cDNiql3rip4l1/grfoGF+HTNYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853874; c=relaxed/simple;
	bh=K7fipWo5LtfCUYikim7OAAP+eHPPeFYOOSLhj8zHwPE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWQgfDUsnZlZbMTvA5/uGiXIJhZ2EwXZufdqwXmTi7VySO3Iq2U0rBtYESG89p44t2pS7Fc5z71UXCgiCZjNwCg0U+iXyQwFVOIbYW/TRnjROwDICH7suxyTIXBn5wpeT4fx5Hsd8wSUU/yutfcYrn5fyHponok3Jwa242oyvOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pinnP7xG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE3DC4CEDD;
	Mon, 24 Mar 2025 22:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742853873;
	bh=K7fipWo5LtfCUYikim7OAAP+eHPPeFYOOSLhj8zHwPE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pinnP7xGRAyt1MWyhLyDW+tgR9xssYMWltMdWVlQD/NZU//D3ip6TOjVCcjgkk9Lo
	 Prlopa1NMybazsQgJnftoiVSwr45OaJvYi8qD7bVF6iRwwQZjoom2ymZ3aNtJUhfab
	 fAZ566/CLyf6o0BXRVxDedSLjPfcV1mwI21Q0spQT0xLAgU3kBJ0SAsumvvHoKENh9
	 H2e2dz6pqyAMbz3UBSFqcA22vjqgapagFvjWNCNMT26HEWzjNR1a4ZMNEsXPA6OYs0
	 zG5hUnVqXVdJvo1rsQfL8tDSPLBXnHDM63WvV8e9DLi4dAYubsPyUH4CP6ew9y+xIk
	 WPNETVRLFQsIA==
Date: Mon, 24 Mar 2025 15:04:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, horms@kernel.org
Subject: Re: [PATCH net-next v2] net: hold netdev reference during
 qdisc_create request_module
Message-ID: <20250324150425.32b3ec10@kernel.org>
In-Reply-To: <20250320165103.3926946-1-sdf@fomichev.me>
References: <20250320165103.3926946-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Mar 2025 09:51:03 -0700 Stanislav Fomichev wrote:
>  			rtnl_lock();
>  			netdev_lock_ops(dev);
> +			dev_put(dev);
>  			ops = qdisc_lookup_ops(kind);

I'm not sure if this is a correct sequence. Do we guarantee that locks
will be taken before device is freed? I mean we do:

	dev = netdev_wait_allrefs_any()
	free_netdev(dev)
		mutex_destroy(dev->lock)

without explicitly taking rtnl_lock() or netdev_lock(), so the moment
that dev_put() is called the device may get freed from another thread
- while its locked here.

My mental model is that taking the instance lock on a dev for which we
only have a ref requires a dance implemented in __netdev_put_lock().

