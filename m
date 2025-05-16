Return-Path: <netdev+bounces-191082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E51AB9FC5
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 17:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67E909E8161
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 15:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1471A255C;
	Fri, 16 May 2025 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7QsErVR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B3918DB03
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747408965; cv=none; b=slfzW69hzcMw2dxvm5Mm+bRtY046CKDwdu4BC+cR7sUZoj+vsgbHZwDGtxUU0hqJEKK2LX1zS8tbXtuyfGMZWw6G7PcBzlOgZCf5iOBUUI60fpYEkzsYAchXqRTjE0SUNgEgweXEStNfPU6BkM7n9Bzl4MxWAiwQ8VNxvROEdSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747408965; c=relaxed/simple;
	bh=SorwpczT7rZnyPHu8UoDaQwRHmLrJBq3kaASvXN0ri8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PX1j+qKbR9EH632ZVTJjUNz1OPVTqLFfb+Umx12bK4Huk9kH8Hjd/Jr35TPCe0+60Bx6zy0IjQ+fj0tPUXyZx5Kfd6095OjFyObidCi2zjrr65up/G4zEfzd/3Fk5iJsoyIS8z1eyKQUHu6JulWMhw6B5qU2osMaBqGUTpMaCD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7QsErVR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5AF5C4CEE4;
	Fri, 16 May 2025 15:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747408964;
	bh=SorwpczT7rZnyPHu8UoDaQwRHmLrJBq3kaASvXN0ri8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b7QsErVRkyqIspAN8ZHnJtY8QpmMQVAr/SUc6BMjU1siEf/LpzB/WksK29L64K0WG
	 fc9qxwNhMzXEq4OqOobbeygDUlF/0i5GfVCE9MMdr2PCzhb87oXVwwKJY7KEVrhcwn
	 vTAZIFxaIRULeBuwHLTcL7cvjmgByPyfk0gjhnz45ZzKCraFSixlh0DtavfHLE3IRw
	 UGlgCOXZyLtTrKmixM0mBP0h0FWikO23fndKYxxpSgD8f8ip3pp9rH/qGu4KqaJhd5
	 KuQF2zpUPeKTyCyhfxw/66XuTgkICCzLWTpwaRDk9QqS4dbg2hylrJ05dS7rDQ7C2o
	 g+b1ywkg9jWDg==
Date: Fri, 16 May 2025 08:22:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <horms@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
 <sdf@fomichev.me>
Subject: Re: [PATCH net-next] net: let lockdep compare instance locks
Message-ID: <20250516082243.1befa6f4@kernel.org>
In-Reply-To: <20250516030000.48858-1-kuniyu@amazon.com>
References: <20250515193609.3da84ac3@kernel.org>
	<20250516030000.48858-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 May 2025 19:59:41 -0700 Kuniyuki Iwashima wrote:
> > Is the thinking that once the big rtnl lock disappears in cleanup_net
> > the devices are safe to destroy without any locking because there can't
> > be any live users trying to access them?  
> 
> I hope yes, but removing VF via sysfs and removing netns might
> race and need some locking ?

I think we should take the small lock around default_device_exit_net()
and then we'd be safe? Either a given VF gets moved to init_net first
or the sysfs gets to it and unregisters it safely in the old netns.

