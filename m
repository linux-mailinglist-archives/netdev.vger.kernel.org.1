Return-Path: <netdev+bounces-13489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5463873BD4D
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 19:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8264C1C212F9
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 17:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F44D524;
	Fri, 23 Jun 2023 17:00:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E3DBE48
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 17:00:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033ECC433C9;
	Fri, 23 Jun 2023 17:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687539641;
	bh=8NvdvMOZhkf3ZWHCAYhr6IS/S3CpGzOG5wCKstBXM/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h6/0i8b5U6xV3rDgMIBxRMocLpmNGFZY618h9D1Yg3zKzltu1gljLOo2TTiI43Cvp
	 N8emwr4aIVkqWlvGoDzPntH7XpThaon1gAVIyfSyQYW+hQnAzM2vBCTiuF+u/vBo7R
	 /wZFoJixy4+SS9Ns7Whew+fmlegNGLtSprWupskJDm9BDDW71ijdzXhCUJ/cOh0BuN
	 pAxFt8CgIOBjSdeUegTBRdu6N2sA/iF4ahxUmwJ6BR8s7SQAAgTXBWJxYx2Lr/4j7D
	 8qpPHfWStK1yOUwrtYFucxtWK+BNf3L4N4UydRvXKXSFbiQoQg8TOnI8t637yOZcAu
	 Wwf40LbpxIDDg==
Date: Fri, 23 Jun 2023 10:00:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexander.duyck@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Ilya Dryomov
 <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, Jeff Layton
 <jlayton@kernel.org>, ceph-devel@vger.kernel.org
Subject: Re: [PATCH net-next v4 03/15] ceph: Use sendmsg(MSG_SPLICE_PAGES)
 rather than sendpage
Message-ID: <20230623100040.4ebbeeb2@kernel.org>
In-Reply-To: <20230623114425.2150536-4-dhowells@redhat.com>
References: <20230623114425.2150536-1-dhowells@redhat.com>
	<20230623114425.2150536-4-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Jun 2023 12:44:13 +0100 David Howells wrote:
> @@ -494,9 +466,12 @@ static int write_partial_message_data(struct ceph_connection *con)
>  
>  		page = ceph_msg_data_next(cursor, &page_offset, &length);
>  		if (length == cursor->total_resid)
> -			more = MSG_MORE;
> -		ret = ceph_tcp_sendpage(con->sock, page, page_offset, length,
> -					more);
> +			msghdr.msg_flags |= MSG_MORE;

Should the condition also be flipped here, like you did below?
(can be a follow up if so)

> @@ -534,9 +512,11 @@ static int write_partial_skip(struct ceph_connection *con)
>  		size_t size = min(con->v1.out_skip, (int)PAGE_SIZE);
>  
>  		if (size == con->v1.out_skip)
> -			more = MSG_MORE;
> -		ret = ceph_tcp_sendpage(con->sock, ceph_zero_page, 0, size,
> -					more);
> +			msghdr.msg_flags &= ~MSG_MORE;
> +		bvec_set_page(&bvec, ZERO_PAGE(0), size, 0);
> +		iov_iter_bvec(&msghdr.msg_iter, ITER_SOURCE, &bvec, 1, size);

