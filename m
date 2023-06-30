Return-Path: <netdev+bounces-14844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384F0744113
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 19:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69CB41C20B86
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 17:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336F3171CD;
	Fri, 30 Jun 2023 17:21:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30C210EA
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 17:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FF9C433C0;
	Fri, 30 Jun 2023 17:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688145705;
	bh=nP0fbFeP3uVZ92LQd04sMVwYYQdCsLeYKAqxBMnc/KM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VMz2YVafjxOjYkzjJgtlZ0ImcoEGfC2h8Y1pp2Ut7Yo4A8zniR7S0jieSSjXskEN6
	 aO3xj0+b4me3m52CNWE+I9kWusLZDPyoP96YpJK7fafm5DzEV7/f7zOtBDXqWgLm/F
	 8MBZSuHNDkGDohZUe7A2j5cKHQaaE6QZpCbQdD7scg+dHmIyIoaAFVB1bD5sCSodV1
	 iyl/wFGBKCymdAVaQJ/dAgvSxld6gIwUZtHFmfvc9GQg+USupBIDUuquYOp7XIpus4
	 Xpbn3wGOd/UBqCM8q+oRmexH+TdBQnKLbl8nrNLwviMIBeXoc7lb717DCnDdZr1GM3
	 dILnlyFIaYJvQ==
Date: Fri, 30 Jun 2023 10:21:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, Jeff
 Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>, Chuck
 Lever III <chuck.lever@oracle.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, Boris Pismenny
 <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, Gal
 Pressman <gal@nvidia.com>, ranro@nvidia.com, samiram@nvidia.com,
 drort@nvidia.com, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next v10 08/16] tls: Inline do_tcp_sendpages()
Message-ID: <20230630102143.7deffc30@kernel.org>
In-Reply-To: <7337a904-231d-201d-397a-7bbe7cae929f@gmail.com>
References: <ecbb5d7e-7238-28e2-1a17-686325e2bb50@gmail.com>
	<4c49176f-147a-4283-f1b1-32aac7b4b996@gmail.com>
	<20230522121125.2595254-1-dhowells@redhat.com>
	<20230522121125.2595254-9-dhowells@redhat.com>
	<2267272.1686150217@warthog.procyon.org.uk>
	<5a9d4ffb-a569-3f60-6ac8-070ab5e5f5ad@gmail.com>
	<776549.1687167344@warthog.procyon.org.uk>
	<7337a904-231d-201d-397a-7bbe7cae929f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Jun 2023 19:49:22 +0300 Tariq Toukan wrote:
> Unfortunately, it still happens:
> 
> ------------[ cut here ]------------
> WARNING: CPU: 2 PID: 93427 at net/core/skbuff.c:7013 

I can't repro it on net-next with basic TLS 1.2 sendmsg/stream
test + device offload, let us know if you still see it.

