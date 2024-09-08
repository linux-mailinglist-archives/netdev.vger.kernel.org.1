Return-Path: <netdev+bounces-126281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4084970696
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 12:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 704A01F21A87
	for <lists+netdev@lfdr.de>; Sun,  8 Sep 2024 10:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E1F136342;
	Sun,  8 Sep 2024 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfOI+Fl+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C363E71742
	for <netdev@vger.kernel.org>; Sun,  8 Sep 2024 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725791427; cv=none; b=pLeuUYcff7/WmIM0UUObng21UD/I9q3MYCM/tiLyknIr3nz/3ArWfaMnvX0qLRC6QXoACyd0H2FzxocFueSIeSGtawLz3rfUWLy+V6k9oznh/9ab+vdkeYJSb/gO7PCifWbnwkreYTRVOB2NhN+LyrenaGYSgEdGjTSxiblcdL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725791427; c=relaxed/simple;
	bh=FOHPuw5gFgTfIS2yIcMcnuSbgXKQuF/9CIma0f9cr6s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pgtKDT0dozEihYfhe83lUWjPI2OzfGq9ucuyYJcvrgitCkk4q6V4spAFKL6bLcObmd2k4xxqW7hLiawP9ayYpRGacKvxTYfD0Gf9B8xb3cQSVUPcQDqhIplzzV30djv+wsmJladXtVNAyep8l1IrJamFMfrI7ENvzi9AYaz1swQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfOI+Fl+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FC3C4CEC3;
	Sun,  8 Sep 2024 10:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725791427;
	bh=FOHPuw5gFgTfIS2yIcMcnuSbgXKQuF/9CIma0f9cr6s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mfOI+Fl+uPf8bdhMjHUG4iBV2n1qpSRbHX2NYnIAB7zdLSpXMztjXahACBKEJJPCE
	 SfVEtKJnYgOtkj+E3iRADvPbyhNZg5klmRJ9wDZoM7o3v2xHUjCuVCloVHiIFfvBN5
	 Ts1eajIXYOIJwke1NvmuRmyvTX6waB7GXKE8ZCvHR3HWvSnzlDxYpe6gGsReYZqhfS
	 6FF4l2WycVfg6GVqScNo4rJsiKkOM24I0oIO7H+n0sDdbsu51tDXrScvi2DBWN1wsS
	 fy2g04US04tfLIflIncwRBidsqWlhjPXRDxfrFuXJWDsgtiBOX7gJ5/FG9DrESF5xX
	 jz47o4Hs9VYtg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BD33805D82;
	Sun,  8 Sep 2024 10:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5] net: sched: consistently use
 rcu_replace_pointer() in taprio_change()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172579142803.2859599.13909518189580231046.git-patchwork-notify@kernel.org>
Date: Sun, 08 Sep 2024 10:30:28 +0000
References: <20240904115401.3425674-1-dmantipov@yandex.ru>
In-Reply-To: <20240904115401.3425674-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: vinicius.gomes@intel.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  4 Sep 2024 14:54:01 +0300 you wrote:
> According to Vinicius (and carefully looking through the whole
> https://syzkaller.appspot.com/bug?extid=b65e0af58423fc8a73aa
> once again), txtime branch of 'taprio_change()' is not going to
> race against 'advance_sched()'. But using 'rcu_replace_pointer()'
> in the former may be a good idea as well.
> 
> Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> 
> [...]

Here is the summary with links:
  - [net-next,v5] net: sched: consistently use rcu_replace_pointer() in taprio_change()
    https://git.kernel.org/netdev/net-next/c/d5c4546062fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



