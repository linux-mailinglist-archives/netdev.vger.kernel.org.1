Return-Path: <netdev+bounces-39175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E207BE441
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF9E51C209CE
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D6437151;
	Mon,  9 Oct 2023 15:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7jOXPSY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0D336AF4
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 15:14:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E28C433D9;
	Mon,  9 Oct 2023 15:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696864461;
	bh=dYZyvyjbPzz0Sh38l6AbqWtQEJnCq7Uc5Gq2MBzud8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n7jOXPSY2heYrKBcd03xe+B5ngd4iyYxSo10d7RFg3QdVLaPLWo6MoBCSIJQBNr+W
	 BFoLiqD06Iui/ym2XwgnyAEowuwUd8mohgm1Z7SDjyRzqK/bKm/mKOo0gW5dJg/NBn
	 EPeqDgJAABdaJUpG0KxwwuARGpWyZ7MuZInM7WIRQqtapNxtp8OZ4B3wMcuQK8M3q1
	 WXEvmPqiC99jsmEMom9WcGySgPb46nQdkEsVAoS7gbcLBYddZFf4mAVe/2nUB1lehd
	 wppLeYkz9T6+PW+x/XYhmsxFEJ82YX8axeUi8ExBs2erl1RniSP09+YFHtDb02xrFG
	 k9GlyRnH/ZTHg==
Date: Mon, 9 Oct 2023 17:14:16 +0200
From: Simon Horman <horms@kernel.org>
To: zhailiansen <zhailiansen@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yuwang@kuaishou.com,
	wushukun@kuaishou.com, zhailiansen <zhailiansen@kuaishou.com>
Subject: Re: [PATCH] netclassid: on modifying netclassid, only consider the
 main process.
Message-ID: <ZSQYyO9JW/9HEjPM@kernel.org>
References: <20231008030442.35196-1-zhailiansen@kuaishou.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231008030442.35196-1-zhailiansen@kuaishou.com>

On Sun, Oct 08, 2023 at 11:04:42AM +0800, zhailiansen wrote:

Hi,

thanks for your patch.
Some minor comments from my side.

> When modifying netclassid, the command("echo 0x100001 > net_cls.classid") will
> take more time on muti threads of one process, because the process create many

nit: muti -> multiple ?

> fds.
> for example, one process exists 28000 fds and 60000 threads, echo command will
> task 45 seconds.
> Now, we only consider the main process when exec "iterate_fd", and the time is
> 52 milliseconds.

Please consider line-wrapping the patch description at 75 bytes.

This patch seems best targeted at net-next, this information should be
included in the patch. So if post a v2 please consider using:

	Subject: [PATCH v2] ...

> Signed-off-by: zhailiansen <zhailiansen@kuaishou.com>

Please consider signing off using your real name.

e.g. Signed-off-by: Firstname Lastname <...>

> ---
>  net/core/netclassid_cgroup.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/core/netclassid_cgroup.c b/net/core/netclassid_cgroup.c
> index d6a70ae..78c903c 100644
> --- a/net/core/netclassid_cgroup.c
> +++ b/net/core/netclassid_cgroup.c
> @@ -88,6 +88,12 @@ static void update_classid_task(struct task_struct *p, u32 classid)
>  	};
>  	unsigned int fd = 0;
>  
> +	/* Only update the leader task, when multi threads in this task,
> +	 * so it can avoid the useless traversal.
> +	 */
> +	if (p && p != p->group_leader)
> +		return;

Can p ever be NULL?
It is dereferenced unconditionally by the existing call to task_lock() below.

> +
>  	do {
>  		task_lock(p);
>  		fd = iterate_fd(p->files, fd, update_classid_sock, &ctx);
> -- 
> 1.8.3.1
> 
> 

