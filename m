Return-Path: <netdev+bounces-33050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C2479C91E
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 10:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2291828149D
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 08:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A40D17732;
	Tue, 12 Sep 2023 08:00:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48E817724
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 08:00:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 215EFC433C8;
	Tue, 12 Sep 2023 08:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694505631;
	bh=hgBbcY3l85vVJTgO89HqaRfFBchH/o5hrx846L5WD38=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X/kS5kvCUruN4VGV1hVlbqdAZe7YpNDhisoiovbRaKP0EeQ3qybDPa1SCPjRUPt6u
	 fG0aK+Z/fUp3vHb/QEQyLx7ip+ukXGuGs9BYkba47+nILDn2XroSsn2sY9JyVO0QbR
	 jTErWFqt6Qe906CDecDEFmDmJWhvNY7erirlvOvU+7bn+2OSGuLzVbrDFxuxdr6hxg
	 4QkDft9ASAty1ob2/O3fb67cV+K0ZhZne8YbNoZahtwfmQPvK2815jM4TGiLLspbtB
	 lWpVCCe8CkfWTLmENtb+78SDP2gk6JaqN/ICPmlXTjTQotoz2nsRpy4kI53k9G24Qb
	 1KvNa2JR5EPmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04A02C04DD9;
	Tue, 12 Sep 2023 08:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/tls: do not free tls_rec on async operation in
 bpf_exec_tx_verdict()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169450563101.12574.9112252097999266145.git-patchwork-notify@kernel.org>
Date: Tue, 12 Sep 2023 08:00:31 +0000
References: <20230909081434.2324940-1-liujian56@huawei.com>
In-Reply-To: <20230909081434.2324940-1-liujian56@huawei.com>
To: Liu Jian <liujian56@huawei.com>
Cc: borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 vfedorenko@novek.ru, sd@queasysnail.net, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 9 Sep 2023 16:14:34 +0800 you wrote:
> I got the below warning when do fuzzing test:
> BUG: KASAN: null-ptr-deref in scatterwalk_copychunks+0x320/0x470
> Read of size 4 at addr 0000000000000008 by task kworker/u8:1/9
> 
> CPU: 0 PID: 9 Comm: kworker/u8:1 Tainted: G           OE
> Hardware name: linux,dummy-virt (DT)
> Workqueue: pencrypt_parallel padata_parallel_worker
> Call trace:
>  dump_backtrace+0x0/0x420
>  show_stack+0x34/0x44
>  dump_stack+0x1d0/0x248
>  __kasan_report+0x138/0x140
>  kasan_report+0x44/0x6c
>  __asan_load4+0x94/0xd0
>  scatterwalk_copychunks+0x320/0x470
>  skcipher_next_slow+0x14c/0x290
>  skcipher_walk_next+0x2fc/0x480
>  skcipher_walk_first+0x9c/0x110
>  skcipher_walk_aead_common+0x380/0x440
>  skcipher_walk_aead_encrypt+0x54/0x70
>  ccm_encrypt+0x13c/0x4d0
>  crypto_aead_encrypt+0x7c/0xfc
>  pcrypt_aead_enc+0x28/0x84
>  padata_parallel_worker+0xd0/0x2dc
>  process_one_work+0x49c/0xbdc
>  worker_thread+0x124/0x880
>  kthread+0x210/0x260
>  ret_from_fork+0x10/0x18
> 
> [...]

Here is the summary with links:
  - [net,v2] net/tls: do not free tls_rec on async operation in bpf_exec_tx_verdict()
    https://git.kernel.org/netdev/net/c/cfaa80c91f6f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



