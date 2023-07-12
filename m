Return-Path: <netdev+bounces-17031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B9C74FDC4
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 05:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40B01C20F02
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 03:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DFC3FED;
	Wed, 12 Jul 2023 03:30:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F06620F5
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 03:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD4FCC43395;
	Wed, 12 Jul 2023 03:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689132623;
	bh=J+ZFL0ZRv0nFgtlQnK7I2paSKhB8TC4oBGTUZbhnst4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=efNy3nQ/RlHoa5XJx7HjGS5af+OkimFH8dz/4E0AzeD4f4vOIOfnxD0CWowVWndP1
	 UEq1gJ4bqJ/KCEAMJtgAS4SAt9TEIxZYJfwUTFqmIMMc0JOTWJiyKi9b+rYq2TBl+x
	 wwcuoJg97KYK+yooVyApAJSOFqo/w0Jw7scY1Q3w73ZLwWxGrE9XKlef4E5zT7Q0eQ
	 9OJAP14U0cC5HQ5kK1xlNMIVWGj278o7+fI7L9qC82wrvaUWpapfFBi3EcIg5XV2wg
	 +nzagpl06+/sLU24nMqvNVCJeMLh9EmIs8FK++EMQaQVRg1dOreF8o8dJpbZ+9Atuv
	 Be3KNi9mFoxpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE0B8E29F44;
	Wed, 12 Jul 2023 03:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] bnxt_en: use dev_consume_skb_any() in bnxt_tx_int
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168913262370.27250.6393079802068929185.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jul 2023 03:30:23 +0000
References: <20230711110743.39067-1-imagedong@tencent.com>
In-Reply-To: <20230711110743.39067-1-imagedong@tencent.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: michael.chan@broadcom.com, leon@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, imagedong@tencent.com,
 leonro@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Jul 2023 19:07:43 +0800 you wrote:
> From: Menglong Dong <imagedong@tencent.com>
> 
> In bnxt_tx_int(), the skb in the tx ring buffer will be freed after the
> transmission completes with dev_kfree_skb_any(), which will produce
> the noise on the tracepoint "skb:kfree_skb":
> 
> $ perf script record -e skb:kfree_skb -a
> $ perf script
>   swapper     0 [014] 12814.337522: skb:kfree_skb: skbaddr=0xffff88818f145ce0 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
>   swapper     0 [003] 12814.338318: skb:kfree_skb: skbaddr=0xffff888108380600 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
>   swapper     0 [014] 12814.375258: skb:kfree_skb: skbaddr=0xffff88818f147ce0 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
>   swapper     0 [014] 12814.451960: skb:kfree_skb: skbaddr=0xffff88818f145ce0 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
>   swapper     0 [008] 12814.562166: skb:kfree_skb: skbaddr=0xffff888112664600 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
>   swapper     0 [014] 12814.732517: skb:kfree_skb: skbaddr=0xffff88818f145ce0 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
>   swapper     0 [014] 12814.800608: skb:kfree_skb: skbaddr=0xffff88810025d100 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
>   swapper     0 [014] 12814.861501: skb:kfree_skb: skbaddr=0xffff888108295a00 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
>   swapper     0 [014] 12815.377038: skb:kfree_skb: skbaddr=0xffff88818f147ce0 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
>   swapper     0 [014] 12815.395530: skb:kfree_skb: skbaddr=0xffff88818f145ee0 protocol=2048 location=dev_kfree_skb_any_reason+0x2e reason: NOT_SPECIFIED
> 
> [...]

Here is the summary with links:
  - [net-next,v2] bnxt_en: use dev_consume_skb_any() in bnxt_tx_int
    https://git.kernel.org/netdev/net-next/c/47b7acfb016b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



