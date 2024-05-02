Return-Path: <netdev+bounces-92879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4DD8B9359
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 04:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B0D5B2280C
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 02:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21CF17753;
	Thu,  2 May 2024 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzL6NZMd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB37171BB
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714616430; cv=none; b=c4cy/pr1HnKP/TfVx0tTozanjFkNdM4MrItbsc+pl0iDLyJVKZxvz4xhLfwXGnrLWpUaGL4hTxUO9N/I69eXzAJqYQftLgTsG6/4whbEdBR6fscXSddi4FEk1Yi6JpLIOefvkdVFkFLOWRXwW9zkF4sa6snuFZujO/1/ko0BmL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714616430; c=relaxed/simple;
	bh=2wAFmpXKAFPH/BMwFXjICdnG6ZjbrRyipt6biiaf7Ic=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oGxugJO5iFty+g+ZHCxxEiBUDNYcLFZ15rp7eS7G1gXgI+BmDjvZnU1AMNtXaFbEO4Cbi+0XwHnxnPELNeu13jHSkjYh6uMfxZL12ZlVkL1+ZQTo7LJZ8ZTLq1TL8S+XFTDy6nOpmgEml9U/uapzxjEYsqKMdAFhoChavV1ahzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzL6NZMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 564E2C4AF19;
	Thu,  2 May 2024 02:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714616430;
	bh=2wAFmpXKAFPH/BMwFXjICdnG6ZjbrRyipt6biiaf7Ic=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mzL6NZMdDI9YcFd96mC2dCTbyIFxm0q6GseHHZ8yRrrW19VjyPX6wTQhbPzfJfJBF
	 mxpRqyUk5VsHJJr9tDvHZjT0SfpKHG4YYbgcMfVPML4V82W2r4WvLgPy1nbcpPtD2p
	 GEBZC+Q2RAO8qsVRkyyA10yeQskO3uTozUNauoaC43cTf6x70hq4h2d74q8bOgf7c1
	 /fbyYos2lzB7ATsoe0f34JHGlX/VXG8xuNLwF9pXN5yrrEcmctbvppwYr4dkDIafJs
	 SwCUyn7EoExu+w430C0Hts4N82RqY6K+Dup91DXDDPrw7z8sfR/bHz/wDgNkLYM3qb
	 ndNIdkONJzqHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41B50C43446;
	Thu,  2 May 2024 02:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tipc: fix a possible memleak in tipc_buf_append
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171461643026.4262.11748565456729375334.git-patchwork-notify@kernel.org>
Date: Thu, 02 May 2024 02:20:30 +0000
References: <90710748c29a1521efac4f75ea01b3b7e61414cf.1714485818.git.lucien.xin@gmail.com>
In-Reply-To: <90710748c29a1521efac4f75ea01b3b7e61414cf.1714485818.git.lucien.xin@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 davem@davemloft.net, kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
 jmaloy@redhat.com, ying.xue@windriver.com, tung.q.nguyen@dektech.com.au

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Apr 2024 10:03:38 -0400 you wrote:
> __skb_linearize() doesn't free the skb when it fails, so move
> '*buf = NULL' after __skb_linearize(), so that the skb can be
> freed on the err path.
> 
> Fixes: b7df21cf1b79 ("tipc: skb_linearize the head skb when reassembling msgs")
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] tipc: fix a possible memleak in tipc_buf_append
    https://git.kernel.org/netdev/net/c/97bf6f81b29a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



