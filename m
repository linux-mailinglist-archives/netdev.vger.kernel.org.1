Return-Path: <netdev+bounces-21435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2251C7639AF
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 16:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6BCA280A0D
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 14:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC7B1DA44;
	Wed, 26 Jul 2023 14:57:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B181DA20
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 14:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F74EC433C8;
	Wed, 26 Jul 2023 14:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690383449;
	bh=09yaDu2ZHSle3u9MUr1zN0Bdn2NyfbsEWr96pnC5KVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e16fFLOQocOn0hQNv0wqtXk7sZMegNZBpyMN+a29kS2D3GxhDsjeK33HgpkgDSdHh
	 pl2vwJ5vtVJvsygh0JGBrGrnsPAoqEobDzPOg0/XD6xmQuuJFvnsxesifyC8l8s4+Q
	 kYvK3oiE6nOI3VNUTzQKBm8epKX0eOAUHeXYOyH+9zr9B3bGWP8rwVh2iOaPJLb9te
	 9Xg/dJyiqBwdCwRZZqj+6Hn3G1AElNxabZ6jbG3phpoTNRwFM44kwnRQsvPRP6qaR+
	 OFvxGUV0Drp5zxUsOxDCcMT35uazDifx9y4OXft4tg+TeSkrU6SBgMXlisJwkbZaAC
	 NNJpyTzZdjp4w==
Date: Wed, 26 Jul 2023 07:57:27 -0700
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
Message-ID: <20230726075727.3ba654ff@kernel.org>
In-Reply-To: <fed78210-4560-b655-b43a-bc31d1cfe1b8@gmail.com>
References: <bbdce803-0f23-7d3f-f75a-2bc3cfb794af@gmail.com>
	<ecbb5d7e-7238-28e2-1a17-686325e2bb50@gmail.com>
	<4c49176f-147a-4283-f1b1-32aac7b4b996@gmail.com>
	<20230522121125.2595254-1-dhowells@redhat.com>
	<20230522121125.2595254-9-dhowells@redhat.com>
	<2267272.1686150217@warthog.procyon.org.uk>
	<5a9d4ffb-a569-3f60-6ac8-070ab5e5f5ad@gmail.com>
	<776549.1687167344@warthog.procyon.org.uk>
	<7337a904-231d-201d-397a-7bbe7cae929f@gmail.com>
	<20230630102143.7deffc30@kernel.org>
	<f0538006-6641-eaf6-b7b5-b3ef57afc652@gmail.com>
	<20230705091914.5bee12f8@kernel.org>
	<20418.1690368701@warthog.procyon.org.uk>
	<fed78210-4560-b655-b43a-bc31d1cfe1b8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jul 2023 14:43:35 +0300 Tariq Toukan wrote:
> >> We repro the issue on the server side using this client command:
> >> $ wrk -b2.2.2.2 -t4 -c1000 -d5 --timeout 5s https://2.2.2.3:20443/256000b.img  
> > 
> > What's wrk?
> > 
> > David
> >   
> 
> Pretty known and standard client app.
> wrk - a HTTP benchmarking tool
> https://github.com/wg/wrk

Let us know if your build has CONFIG_DEBUG_VM, please.
Because in the old code the warning was gated by this config,
so the bug may be older. We just started reporting it.

