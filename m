Return-Path: <netdev+bounces-37292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A987B48EE
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 19:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id E497D1C2074E
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 17:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C1018B17;
	Sun,  1 Oct 2023 17:46:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DCED2E1
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 17:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B0DC433C7;
	Sun,  1 Oct 2023 17:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696182389;
	bh=YiZtbJcNhba/FnrOoweiMtTxQ8gd/lsjKmXTBE+vY+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s/tkNt2PigdOcZY9y6/dEg6esD8e+2u5pg/1Jhss6mXGSAFpZaHCTwf3AkFc7cXCT
	 YzIM94Ut+K9YczwebYxrcIUQNWWR/xaVFtiw/nxJPphO9B3Vz8ru56uRhpRuJ76PTU
	 kdZdge/r+V6WX7p3xIxPGz1xTbEm41NpIQMPqzJMmR+uWAeKfBc27z/V6zEq1rzpYq
	 zBMneWhBVr8a8gA3hk4MEOyA5/XeS/UcRtcmxHmX6+geYf/YlCxrCSt8XvEnoG1QSv
	 k8cQT6p/Hey7pYMih2bQdmUUUKa1Vvyilw/HfFunERZRw1abLtMW4c1QM/ldkeLQ9E
	 uOZ1Ax/tYIaow==
Date: Sun, 1 Oct 2023 19:46:25 +0200
From: Simon Horman <horms@kernel.org>
To: Chengfeng Ye <dg573847474@gmail.com>
Cc: jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tipc: fix a potential deadlock on &tx->lock
Message-ID: <20231001174625.GR92317@kernel.org>
References: <20230927181414.59928-1-dg573847474@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927181414.59928-1-dg573847474@gmail.com>

On Wed, Sep 27, 2023 at 06:14:14PM +0000, Chengfeng Ye wrote:
> It seems that tipc_crypto_key_revoke() could be be invoked by
> wokequeue tipc_crypto_work_rx() under process context and
> timer/rx callback under softirq context, thus the lock acquisition
> on &tx->lock seems better use spin_lock_bh() to prevent possible
> deadlock.
> 
> This flaw was found by an experimental static analysis tool I am
> developing for irq-related deadlock.
> 
> tipc_crypto_work_rx() <workqueue>
> --> tipc_crypto_key_distr()
> --> tipc_bcast_xmit()
> --> tipc_bcbase_xmit()
> --> tipc_bearer_bc_xmit()
> --> tipc_crypto_xmit()
> --> tipc_ehdr_build()
> --> tipc_crypto_key_revoke()
> --> spin_lock(&tx->lock)
> <timer interrupt>
>    --> tipc_disc_timeout()
>    --> tipc_bearer_xmit_skb()
>    --> tipc_crypto_xmit()
>    --> tipc_ehdr_build()
>    --> tipc_crypto_key_revoke()
>    --> spin_lock(&tx->lock) <deadlock here>
> 
> Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>


Hi Chengfeng Ye,

thanks for your patch.

As a fix for Networking this should probably be targeted at the
'net' tree. Which should be denoted in the subject.

        Subject: [PATCH net] ...

And as a fix this patch should probably have a Fixes tag.
This ones seem appropriate to me, but I could be wrong.

Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")

I don't think it is necessary to repost just to address these issues,
but the Networking maintainers may think otherwise.

The code change itself looks good to me.

