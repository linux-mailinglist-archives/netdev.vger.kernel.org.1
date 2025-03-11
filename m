Return-Path: <netdev+bounces-173961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6AFA5CA37
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 17:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C96B16A61A
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 16:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8234125FA22;
	Tue, 11 Mar 2025 16:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McPQdhP2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2AC25FA1F
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709095; cv=none; b=ZV8D7ZUecHGMk5pz4ULXsVxJ5EVy6a5zzVyEuHr4WuA4VZh0qYLB8t5CsytyKEwwzPlKwvKGhGnWpLMZkHYuOJS7jmEAqi1x2rVbUUZnUny74e0My4e1k6WgvDWeBAkSxnYhA37FiJRoFQXSGPwiUy6o9q7gs1n4jjCtT83oBtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709095; c=relaxed/simple;
	bh=j+IBtNVbhZjOkn9y3Vu5+ry8h6BosT4ih7h/wrT47qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkAjDD/jk+gdTbP+kevMyF4EtkTNQ/ynMbukQuGmPgbNlhCh/i9OM5tBD5bihquGLxG0mgYxHE1wXbFixcVKV2TTf41XgxnPkkSBg45BZh9Yh5WOGxJQ4g6o6ACYwi9OYMppuJ+857loOUTO6V/GM1m3CwG/4e6yl7PKeAi5b1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McPQdhP2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D13EC4CEE9;
	Tue, 11 Mar 2025 16:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741709094;
	bh=j+IBtNVbhZjOkn9y3Vu5+ry8h6BosT4ih7h/wrT47qY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=McPQdhP2QOxqWthw4CQWrAHlH9gvySEFAIGCSxczdJADgYLZCDgbEBBgQKxiNyVg2
	 VVT+NhxFv+Y5XKMiFs73J1Ap0SUAa1wAH9JRZm8FKrCIZA/AxmQ+8JNEg7E0FqNNXw
	 eDSKJ7zKLXeKEs7bus8EOdEeZbq+PRHrLZpRKhiC55wlL4i9IEeJUCpvq2dFFh2SC7
	 P1Wdl6YHZRGCyJ7xeMlOUM5haof+bt74Jv+FRADgZyx6H7L2jIh2ib96aBB2ydkRtv
	 Ij0gN24s1SU7/BjrbLJsJSkC5fuBQZeIg9fmr8WMQHPajv+L1/BZjTObnjdv8kJJ4R
	 8Fg3scMnDMLEw==
Date: Tue, 11 Mar 2025 17:04:49 +0100
From: Simon Horman <horms@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org,
	jhs@mojatatu.com, jiri@resnulli.us, mincho@theori.io
Subject: Re: [Patch net 1/2] net_sched: Prevent creation of classes with
 TC_H_ROOT
Message-ID: <20250311160449.GP4159220@kernel.org>
References: <20250306232355.93864-1-xiyou.wangcong@gmail.com>
 <20250306232355.93864-2-xiyou.wangcong@gmail.com>
 <20250311104835.GJ4159220@kernel.org>
 <17414eab-445d-4669-89a9-855a872f7c16@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17414eab-445d-4669-89a9-855a872f7c16@redhat.com>

On Tue, Mar 11, 2025 at 01:47:32PM +0100, Paolo Abeni wrote:
> 
> 
> On 3/11/25 11:48 AM, Simon Horman wrote:
> > On Thu, Mar 06, 2025 at 03:23:54PM -0800, Cong Wang wrote:
> >> The function qdisc_tree_reduce_backlog() uses TC_H_ROOT as a termination
> >> condition when traversing up the qdisc tree to update parent backlog
> >> counters. However, if a class is created with classid TC_H_ROOT, the
> >> traversal terminates prematurely at this class instead of reaching the
> >> actual root qdisc, causing parent statistics to be incorrectly maintained.
> >> In case of DRR, this could lead to a crash as reported by Mingi Cho.
> >>
> >> Prevent the creation of any Qdisc class with classid TC_H_ROOT
> >> (0xFFFFFFFF) across all qdisc types, as suggested by Jamal.
> >>
> >> Reported-by: Mingi Cho <mincho@theori.io>
> >> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> > 
> > Hi Cong,
> > 
> > This change looks good to me.
> > But could we get a fixes tag?`
> > 
> > ...
> 
> Should be:
> 
> Fixes: 066a3b5b2346 ("[NET_SCHED] sch_api: fix
> qdisc_tree_decrease_qlen() loop")

Thanks.

Looking at that, I might have gone for the following commit,
which is a fix for the above one. But either way is fine by me.

commit 2e95c4384438 ("net/sched: stop qdisc_tree_reduce_backlog on TC_H_ROOT")

Reviewed-by: Simon Horman <horms@kernel.org>


