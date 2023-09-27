Return-Path: <netdev+bounces-36415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B370F7AFA5B
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 07:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 6AD0F281441
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 05:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110AC210A;
	Wed, 27 Sep 2023 05:51:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C162D525B
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 05:50:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB1FC433C7;
	Wed, 27 Sep 2023 05:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695793859;
	bh=1olEBS0dNJLFikr9MRwyw7No2z5aHgh3Ify968bqAoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B3+SQPanwdUIw77Rv10PmtVst5Hh8W/COkIXsiWoBdOFDbRriP5JHe/HKEQxVo+pZ
	 5Nd7hPiL1TlLVTFMqb3Bt1WqQL1Mi1i+GnXmy2aXo82+yiE1snJXr/unPP9CQy0yQp
	 OCLgJebaWFAZCzBCv+ok//wrUDBbEesYZKgQ712sPkCo52hUqkdkQ4CyGTNLWoRrM/
	 qb37IrV2nLegM0Mmc+NoArb2HnzLVPwVFx8OqlBb2quaVEicO9vEguQFyQk7jTTSyA
	 Y3MAmo/2HyL0YEOQOi18uFDJCauaaeMxUo2+82w+vpiTxp6Z0Ye1SbFtU23meN3Ly5
	 3zgyeSRrh1JSg==
Date: Wed, 27 Sep 2023 07:50:51 +0200
From: Simon Horman <horms@kernel.org>
To: Jordan Rife <jrife@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
	netdev@vger.kernel.org, dborkman@kernel.org, pablo@netfilter.org,
	kadlec@netfilter.org, fw@strlen.de, santosh.shilimkar@oracle.com,
	ast@kernel.org, rdna@fb.com, stable@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net v5 2/3] net: prevent rewrite of msg_name in
 sock_sendmsg()
Message-ID: <20230927055051.GC224399@kernel.org>
References: <20230921234642.1111903-1-jrife@google.com>
 <20230921234642.1111903-2-jrife@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921234642.1111903-2-jrife@google.com>

On Thu, Sep 21, 2023 at 06:46:41PM -0500, Jordan Rife wrote:
> Callers of sock_sendmsg(), and similarly kernel_sendmsg(), in kernel
> space may observe their value of msg_name change in cases where BPF
> sendmsg hooks rewrite the send address. This has been confirmed to break
> NFS mounts running in UDP mode and has the potential to break other
> systems.
> 
> This patch:
> 
> 1) Creates a new function called __sock_sendmsg() with same logic as the
>    old sock_sendmsg() function.
> 2) Replaces calls to sock_sendmsg() made by __sys_sendto() and
>    __sys_sendmsg() with __sock_sendmsg() to avoid an unnecessary copy,
>    as these system calls are already protected.
> 3) Modifies sock_sendmsg() so that it makes a copy of msg_name if
>    present before passing it down the stack to insulate callers from
>    changes to the send address.
> 
> Link: https://lore.kernel.org/netdev/20230912013332.2048422-1-jrife@google.com/
> Fixes: 1cedee13d25a ("bpf: Hooks for sys_sendmsg")
> Cc: stable@vger.kernel.org
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Jordan Rife <jrife@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


