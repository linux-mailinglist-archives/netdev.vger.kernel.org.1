Return-Path: <netdev+bounces-200407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F174AE4DF1
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 22:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8FDB3B5140
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 20:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496F22D5402;
	Mon, 23 Jun 2025 20:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4xL35Hn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED721F5617;
	Mon, 23 Jun 2025 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750709504; cv=none; b=I0Fxo/lEFqc8Hn9pQuyWcxghg4Wga0GpYr+QxTHDXMlaTpKMHa7G1cTQ+wwHcknarLcr10pX/xf8VzTvlQLw3PmBvZ6lIgkTaUmADxPvbay6fdjRNQv9fkiaNzNlSifcfzeCH5WKVGODcqsJAkv1qP3I20QohyjrZrme24IYmvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750709504; c=relaxed/simple;
	bh=A1XqJ+2vaQi5a4Q5AMGyPWGAhhw02GHmSiwei2Uqb+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IztSsutrQKXGc4UOWvhOy3VB63I6EqKbdh1BO2HEiaO9yzu9vFGOUhNahOv9L9C+75R83IcAZq5R+nXCP7YdKl/v/Cv05Yq4wTHCjCHtjudFgjZ5uxGOI+rVMOGQWXFYNw2pRanvDUaBotHApw95cOriW2EWLCoXUPMb0HXGGUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4xL35Hn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43CF4C4CEEA;
	Mon, 23 Jun 2025 20:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750709502;
	bh=A1XqJ+2vaQi5a4Q5AMGyPWGAhhw02GHmSiwei2Uqb+U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N4xL35HnLxkjU5qRqufUyGT2PJwtBjzPfCmK4lGrUp5tx/XFprnwoTaFA6pbpC2Fa
	 xfaCkV4XK95ukfu+z+zOOaI9ACnpM8gQJPbjsdBcI9eR/273UBcEdrcACogVb8ysFu
	 Xdd2hgr4JwsfKmPQ398g/eBiDPuHhvSqtMRP4t7RFvfvC1efJJrbTk/olyK9jNlqmb
	 LN204mQiSPQ7ihLDUvI8wD9a7hPz5wfWWbLVma8bBZnZIO2IgxDXkDb6dlDny8zggj
	 uv/GuZqw19dBc9VQebM5x/p6z/IIbXnEenFRZK05DKQmrWvDtyNJCE7TnAPkZoj4e/
	 vXtZeUan9/PSA==
Date: Mon, 23 Jun 2025 13:11:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: louis.peens@corigine.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, chenlinxuan@uniontech.com,
 viro@zeniv.linux.org.uk, oss-drivers@corigine.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, guanwentao@uniontech.com,
 niecheng1@uniontech.com, Jun Zhan <zhanjun@uniontech.com>
Subject: Re: [PATCH] nfp: nfp_alloc_bar: Fix double unlock
Message-ID: <20250623131141.332c631c@kernel.org>
In-Reply-To: <9EE5B02BB2EF6895+20250623041104.61044-1-wangyuli@uniontech.com>
References: <9EE5B02BB2EF6895+20250623041104.61044-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Jun 2025 12:11:04 +0800 WangYuli wrote:
> The lock management in the nfp_alloc_bar function is problematic:
> 
>  *1. The function acquires the lock at the beginning:
> spin_lock_irqsave(&nfp->bar_lock, irqflags).
> 
>   2. When barnum < 0 and in non-blocking mode, the code jumps to
> the err_nobar label. However, in this non-blocking path, if
> barnum < 0, the code releases the lock and calls nfp_wait_for_bar.
> 
>   3. Inside nfp_wait_for_bar, find_unused_bar_and_lock is called,
> which holds the lock upon success (indicated by the __release
> annotation). Consequently, when nfp_wait_for_bar returns
> successfully, the lock is still held.
> 
>   4. But at the err_nobar label, the code always executes
> spin_unlock_irqrestore(&nfp->bar_lock, irqflags).
> 
>   5. The problem arises when nfp_wait_for_bar successfully finds a
> BAR: the lock is still held, but if a subsequent reconfigure_bar
> fails, the code will attempt to unlock it again at err_nobar,
> leading to a double unlock.

I don't understand what you're trying to say.
If you think your analysis is correct please provide a more exact
execution path with a code listing.
-- 
pw-bot: cr

