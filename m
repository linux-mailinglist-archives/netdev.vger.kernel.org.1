Return-Path: <netdev+bounces-63184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE71682B8D5
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 02:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D6521F245FA
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 01:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BDF10EE;
	Fri, 12 Jan 2024 01:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7c/eyAl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9C9A51;
	Fri, 12 Jan 2024 01:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F726C43394;
	Fri, 12 Jan 2024 01:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705021228;
	bh=mCuz4mUb8iswJdRh95c1exbaN2Avu0rltafMrkxAoy8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a7c/eyAlzYS/H6ToKYFS24l4CmmanYBJsUyKk9eEDvG1PfrxAWIzM8xcxlEupA7Ya
	 WQNvvJVArMOEV6ktWWuU9Ek1bIAYQ1K3jUtP26zd4vxeNcBdZSMfxrlr1wXK8lPHLi
	 +HdC6bP/nRCmdxgxes+v+GLTE+wgkZYBHM7iy01IQw5wqgtSR6zL3/3le06xEEKqIc
	 qPFrt0nCVCmfRytwT7OyXVas4Tpqrbb91jCLLNbnoe49DJMZHB2NvdnaVrxi29Q9zU
	 mw0DIOulFqzWuylZUFz9UcAOj5WoQr3q+jViQGAWY7enELK0yMEMOFzoZvCkMElWt2
	 ePIrb+eJTOWyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06B61DFC698;
	Fri, 12 Jan 2024 01:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/1] =?utf-8?q?virtio=5Fnet=3A_Fix_=22=E2=80=98=25d?=
	=?utf-8?q?=E2=80=99_directive_writing_between_1_and_11_bytes_into_a_region_?=
	=?utf-8?q?of_size_10=22_warnings?=
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170502122802.27071.3248493142941454113.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jan 2024 01:00:28 +0000
References: <20240104020902.2753599-1-yanjun.zhu@intel.com>
In-Reply-To: <20240104020902.2753599-1-yanjun.zhu@intel.com>
To: Zhu Yanjun <yanjun.zhu@intel.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 virtualization@lists.linux.dev, netdev@vger.kernel.org, yanjun.zhu@linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Jan 2024 10:09:02 +0800 you wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Fix the warnings when building virtio_net driver.
> 
> "
> drivers/net/virtio_net.c: In function ‘init_vqs’:
> drivers/net/virtio_net.c:4551:48: warning: ‘%d’ directive writing between 1 and 11 bytes into a region of size 10 [-Wformat-overflow=]
>  4551 |                 sprintf(vi->rq[i].name, "input.%d", i);
>       |                                                ^~
> In function ‘virtnet_find_vqs’,
>     inlined from ‘init_vqs’ at drivers/net/virtio_net.c:4645:8:
> drivers/net/virtio_net.c:4551:41: note: directive argument in the range [-2147483643, 65534]
>  4551 |                 sprintf(vi->rq[i].name, "input.%d", i);
>       |                                         ^~~~~~~~~~
> drivers/net/virtio_net.c:4551:17: note: ‘sprintf’ output between 8 and 18 bytes into a destination of size 16
>  4551 |                 sprintf(vi->rq[i].name, "input.%d", i);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/virtio_net.c: In function ‘init_vqs’:
> drivers/net/virtio_net.c:4552:49: warning: ‘%d’ directive writing between 1 and 11 bytes into a region of size 9 [-Wformat-overflow=]
>  4552 |                 sprintf(vi->sq[i].name, "output.%d", i);
>       |                                                 ^~
> In function ‘virtnet_find_vqs’,
>     inlined from ‘init_vqs’ at drivers/net/virtio_net.c:4645:8:
> drivers/net/virtio_net.c:4552:41: note: directive argument in the range [-2147483643, 65534]
>  4552 |                 sprintf(vi->sq[i].name, "output.%d", i);
>       |                                         ^~~~~~~~~~~
> drivers/net/virtio_net.c:4552:17: note: ‘sprintf’ output between 9 and 19 bytes into a destination of size 16
>  4552 |                 sprintf(vi->sq[i].name, "output.%d", i);
> 
> [...]

Here is the summary with links:
  - [v3,1/1] virtio_net: Fix "‘%d’ directive writing between 1 and 11 bytes into a region of size 10" warnings
    https://git.kernel.org/netdev/net/c/e3fe8d28c67b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



