Return-Path: <netdev+bounces-119053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 520F3953EFB
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 03:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E972282394
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 01:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D9A8472;
	Fri, 16 Aug 2024 01:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8liNygn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE80C43AAB
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 01:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723772388; cv=none; b=GqgZXGocUP8iKGSQH2DNMY7lWoyP/ztbRZr3pLAxNDXNS5/xb9hG3NE7fDu30XtZwU26VlbGJ9poxUMQOKTwgBbTSnOYcj3uCZlixWsp1menFWxPTPjZzeofH/B+h96X2lA1IyPE1PPiHpPe4s7/484QEK6Lx4b+Z6IeRaxP1yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723772388; c=relaxed/simple;
	bh=f3itZB67XUy555nJ1soXH35vbA4ifRrhOvNHLOocBOE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U9zdIwzRFL3h+lk/Ffl0PjX5+Ay0g9fqfcWYu3dGzkpfp0eUSHKLvZbUXGolso49B3qTSe+jFd+xBjK+YtVQlj5nO4o8J7Rc8CfD8IUnUyWfv3bNVK6EZLL/lShckq/qyLtkUIhnsiARrvSQFGKgPSxHC+jdKOswBef0SSZETWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8liNygn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55B9C32786;
	Fri, 16 Aug 2024 01:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723772388;
	bh=f3itZB67XUy555nJ1soXH35vbA4ifRrhOvNHLOocBOE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r8liNygn9Jh+hqG5Z2yl5fe4ZQlXDV/nzKVgVzG7DSHet0Qp+wwOrWTMmtgkv6EhW
	 57RfS3mIJ9LsCtlXrMCB202AXYvkTaoS+oAOsQ3F1E1nHJ0ygctmnJoyUVkDxKLvJW
	 n+n+wPOuoVL94rONysStz6oJvM/GAH/sTYl3JkyV5u2sOTBDM6i/xllUxR62c4lCOn
	 jKtZ2raTQ3Ahcc4q1zSfqLD7a3AiCtY7t3RtB3n4V23Do4Yh4Z1/kSFJv4xapXQZIL
	 x2Db/r87TqjXm7GfBWD6/HMaZ0/6o6TrfBe3dF66JVAK7jzR773nl9XaQ9oWVrm75V
	 nk7IR71eHZOsA==
Date: Thu, 15 Aug 2024 18:39:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston
 <matt@codeconstruct.com.au>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Kuniyuki
 Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net] mctp: Use __mctp_dev_get() in
 mctp_fill_link_af().
Message-ID: <20240815183946.342e9952@kernel.org>
In-Reply-To: <20240815204254.49813-1-kuniyu@amazon.com>
References: <20240815204254.49813-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 13:42:54 -0700 Kuniyuki Iwashima wrote:
> Since commit 5fa85a09390c ("net: core: rcu-ify rtnl af_ops"),
> af_ops->fill_link_af() is called under RCU.
> 
> mctp_fill_link_af() calls mctp_dev_get_rtnl() that uses
> rtnl_dereference(), so lockdep should complain about it.
> 
> Let's use __mctp_dev_get() instead.

And this is what crashes kunit tests, I reckon.
-- 
pw-bot: cr

