Return-Path: <netdev+bounces-13152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EA373A7FB
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 20:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC511281981
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 18:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF60420688;
	Thu, 22 Jun 2023 18:12:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2D11F182
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 18:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC78C433C0;
	Thu, 22 Jun 2023 18:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687457556;
	bh=3voyAzfGrtM2hCUsVSFe/G6QJ7KTcAlIITK7RFZZfKk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BeSVipOHf6K1iDWyC9PfTd5evoVvNx6BLxGjYl9ESPwCk6pcXDSthl6bbPTZnnL0b
	 VXv0qbINbaiSoX/p+9wOB896WJXAjUn8YjSSpqD7wptnWW4RfiwEb5f6wp3SNt7P57
	 GZlotEkMT8/H74L2psL/S4TBDtoZo2rWPhj03RNDdNqSQP07K82JPXcrPJ+4xJEhNj
	 L/WzvggSLLJXoez5lQ2dWdBCNHdGqCGcGsgq09v9QdJl+LwAU5fLNj6ssJ90V8E8fp
	 VUbbxcWTSXfIk2s9GrHrW5NF7vtjQg0d4iD5LEByGfwOpFh8RaOUY+eObFoJMezyHa
	 RzHjobdhmUiRg==
Date: Thu, 22 Jun 2023 11:12:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexander.duyck@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Menglong Dong
 <imagedong@tencent.com>
Subject: Re: [PATCH net-next v3 01/18] net: Copy slab data for
 sendmsg(MSG_SPLICE_PAGES)
Message-ID: <20230622111234.23aadd87@kernel.org>
In-Reply-To: <20230620145338.1300897-2-dhowells@redhat.com>
References: <20230620145338.1300897-1-dhowells@redhat.com>
	<20230620145338.1300897-2-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jun 2023 15:53:20 +0100 David Howells wrote:
> If sendmsg() is passed MSG_SPLICE_PAGES and is given a buffer that contains
> some data that's resident in the slab, copy it rather than returning EIO.

How did that happen? I thought MSG_SPLICE_PAGES comes from former
sendpage users and sendpage can't operate on slab pages.

> This can be made use of by a number of drivers in the kernel, including:
> iwarp, ceph/rds, dlm, nvme, ocfs2, drdb.  It could also be used by iscsi,
> rxrpc, sunrpc, cifs and probably others.
> 
> skb_splice_from_iter() is given it's own fragment allocator as
> page_frag_alloc_align() can't be used because it does no locking to prevent
> parallel callers from racing.

The locking is to local_bh_disable(). Does the milliont^w new frag
allocator have any additional benefits?

>  alloc_skb_frag() uses a separate folio for
> each cpu and locks to the cpu whilst allocating, reenabling cpu migration
> around folio allocation.

