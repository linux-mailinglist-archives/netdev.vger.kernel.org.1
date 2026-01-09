Return-Path: <netdev+bounces-248531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F13E9D0AAAD
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 15:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E89F23002919
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 14:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4413612D5;
	Fri,  9 Jan 2026 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSkJcscE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BCB35FF6C
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767969580; cv=none; b=CNM9zHLqdPDTKVopDkerDybVK/ULhoUAkh9RVr+Bgr0ejiGtdgCJrub8ibf2s0+94QJcOCZyu/gKgOzVNv7KmhIttMb7LZWIbkfg3Y5KN0rPy9kltJbDJgHgppldlTozo9Gnx+WVdMOvTMPDc3wXGDOACWtajUH38XjfnvLO5eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767969580; c=relaxed/simple;
	bh=LrVo4BP9xeUuvTGD8973HC8mbY6GtBEbhQyeZ7AfkM8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ObwdRhKqnZjcTlW3+N8Xy+6/zrRJbM3IsrwBQT2PrXnoaxoCaNGE+7aJ2ZPboArXUIgIax/9HBUnX/Hxk2zhpU5oemiZnI1QT4ueWMjHjdHRAzYEdtzfrJaDx2V05pIykDR8ZNx+ti9FpDafK7FQXezw7mzVLTP9FB3IP0QMF7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSkJcscE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF50C4CEF1;
	Fri,  9 Jan 2026 14:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767969580;
	bh=LrVo4BP9xeUuvTGD8973HC8mbY6GtBEbhQyeZ7AfkM8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HSkJcscEoXWWENU0YdL1q8oSxsRzxckEZtAcMbcOlX6T3aG2YQ0r5gLRTljwTCyyK
	 mMZxDbB2SMKgTSlI2I1Z7G5G7H/q4nKEj97tT0ue2fYCzXHKYrYlXBbWjzxThSsZP1
	 PZCsz7TpuE+I5jn+5ch2zoLL59fUAYeMQnXq08L/NbR+aLkWCQdDR3jrjAtPZOvQ5b
	 L+lqjfLWykEeNmBqzou0Zmx5QOR17AUT+CKHxd4rhcicahVqQsK/tGAOArbQqRJlss
	 VjOXjamBc+MokKM+9VPoV0Mzi1a5jqdUe20le39GnkHjsUvEwisY3hwu+LdqwtcLXa
	 TmRDMAwn6EeGg==
Date: Fri, 9 Jan 2026 06:39:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
 <leitao@debian.org>, <jdamato@fastly.com>
Subject: Re: [PATCH net-next 2/2] selftests: net: py: ensure defer() is only
 used within a test case
Message-ID: <20260109063938.3445c940@kernel.org>
In-Reply-To: <87fr8f5ggb.fsf@nvidia.com>
References: <20260108225257.2684238-1-kuba@kernel.org>
	<20260108225257.2684238-2-kuba@kernel.org>
	<87fr8f5ggb.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Jan 2026 09:23:54 +0100 Petr Machata wrote:
> > I wasted a couple of hours recently after accidentally adding
> > a defer() from within a function which itself was called as
> > part of defer(). This leads to an infinite loop of defer().
> > Make sure this cannot happen and raise a helpful exception.
> >
> > I understand that the pair of _ksft_defer_arm() calls may
> > not be the most Pythonic way to implement this, but it's
> > easy enough to understand.
> >
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>  
> 
> I think we achieve the same without the extra globals though? Just drain
> the queue and walk through a copy of it?
> 
>     defer_queue = utils.GLOBAL_DEFER_QUEUE
>     utils.GLOBAL_DEFER_QUEUE = []
>     for i, entry in enumerate(defer_queue):
>         ...
>     if utils.GLOBAL_DEFER_QUEUE:
>         warning / exception

That's what I had initially (IIUC), I was assigning None to the queue,
and then [] only while inside a test case. It gets slightly hairy
because either we need to pass in the queue into the flush function;
or we have to restore the queue if something raises and exception during
flush (in which case ksft_run() prints a warning and calls
ksft_flush_defer() one more time).

That approach definitely worked, but unless I'm missing a trick it was
higher complexity and LoC.

