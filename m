Return-Path: <netdev+bounces-244031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5884DCADED6
	for <lists+netdev@lfdr.de>; Mon, 08 Dec 2025 18:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AEF13061EBF
	for <lists+netdev@lfdr.de>; Mon,  8 Dec 2025 17:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3859C19CD06;
	Mon,  8 Dec 2025 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzJ1Rihk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FDE3B8D74;
	Mon,  8 Dec 2025 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765215239; cv=none; b=c6Vjigbj2TL8Q/zqcUVVvajDzAdHu9w5F1AF4iECiL2Z4JwwuJcL9gPO/zcBAVBzcD5nlR71TYNlb6B+mMwD1uEfyv1q1aEPpUkdipjFV83g9grzOyawbuAhRtp41zVsqD19TEWrfLKDAxP1WcKS3+CeRItERQgmzR6L0hRuS+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765215239; c=relaxed/simple;
	bh=eDlFYGx+u3XtO1I0xvY4YJpNfp8rUGZDXmbguhSDwg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZgVPwTK7duFf5cZ+Ju5L27APu4EgdjRRedB5/4cbNFHceIkJfvmti9rMoYu3gW81p9EIc6piSFrCct9LBsZFHiwblmZnFYIJ+Y5YYd/bsZFZk/Pn988NXCxUA9J0/Q2UYWgrMABuY6Kk5vK7gw30V8287CNZ+tR0cm3yFfdad58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzJ1Rihk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B96C4CEF1;
	Mon,  8 Dec 2025 17:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765215238;
	bh=eDlFYGx+u3XtO1I0xvY4YJpNfp8rUGZDXmbguhSDwg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jzJ1RihkLHODbO8HKdyq7vqhVCNkN3Ej9UY+hw0E5qxQ9iJDxK8TA5ELLrlF0E7ex
	 F1ZtdMBSaXYdq262NinE6NQIMzjee691zUgc9v4eN6L+8Jjlq/F3DOQ8KWxZqX3VOX
	 BsADVoXrWRmH5GlrvkDJQaaQcna9A/3gXOnrcC6psiZF+9H9uBqQuTMAgkgZ4JAzX2
	 CMt8y47Am+ex40bU4Z3i/K0TptvN8WQu+scEdDBIJdXqxyPARGj233lWe4rEkmuCJp
	 skb0LuX/JmZK2AHi+R6HBW4O5mQCToadHbNd+E9dtgEu93LhSnJbnyTO0HIPs2aI7T
	 UfgXt5vs96Lsw==
Date: Mon, 8 Dec 2025 17:33:55 +0000
From: Simon Horman <horms@kernel.org>
To: Dharanitharan R <dharanitharan725@gmail.com>
Cc: syzbot+422806e5f4cce722a71f@syzkaller.appspotmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] team: fix qom_list corruption by using
 list_del_init_rcu()
Message-ID: <aTcMA29O_JC5Npdg@horms.kernel.org>
References: <6903e344.050a0220.32483.022d.GAE@google.com>
 <20251207025807.1674-2-dharanitharan725@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251207025807.1674-2-dharanitharan725@gmail.com>

On Sun, Dec 07, 2025 at 02:58:08AM +0000, Dharanitharan R wrote:
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> Reported-by: syzbot+422806e5f4cce722a71f@syzkaller.appspotmail.com
> Signed-off-by: Dharanitharan R <dharanitharan725@gmail.com>

Hi Dharanitharan,

Please slow down!

It is not appropriate to send multiple versions of a patch CCed to
netdev within in quick succession. Rather, 24h should elapse between
versions. And moreover, I'd advise against CCing netdev on patches
targeted at syzbot testing.

When you do post a fix, for a problem flagged by syzbot, to netdev please
include:

* A description of the problem, and
* How the approach taken fixes it

Typically such a patch will be a bug fix for code present in the net tree.
So it should be targeted at the net tree like this:

Subject: [PATCH net] ...

And it should probably include the following tags:

Fixes:
Reported-by:
Closes:

Especially the Fixes tag.

For an example please see:

https://lore.kernel.org/netdev/20251122002027.695151-1-zlatistiv@gmail.com/

For more information on the Netdev development process please see:

https://docs.kernel.org/process/maintainer-netdev.html

Thanks.

-- 
pw-bot: changes-requested

