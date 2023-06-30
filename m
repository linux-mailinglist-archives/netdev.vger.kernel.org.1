Return-Path: <netdev+bounces-14800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0221C743E99
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 17:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3278C280ED3
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 15:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E49A16411;
	Fri, 30 Jun 2023 15:20:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60DD1640D
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 15:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47728C433C0;
	Fri, 30 Jun 2023 15:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688138443;
	bh=ZluSqUFslLafiJuTcIEoLmWmA+UPQOYibxPoks+UiHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uwm5aDBsvF+6RUs4wr6ONC+6dO9Jq6u45mZJK0cLrsc/7SqJbe0wceTjXyE/3R//e
	 b0bMNzr1AIesT5zSch6HtYLgsgKyiHElRhaAFooUcz/oLuOMQFMnD5KbKFMTYfhzaL
	 pz/KsX7OMhnExnK/fuoW93XqYxHG088pZiHvouWdt3uLEy22SsnOX1N8u85+gcX6Zw
	 M4jDZJ3CeK3W/93l0rU+V2iw6MlNv55aBE3fQvw7lsrdztyf7Undbh+oorPW+/PCK1
	 0kKjSo+2wPr5KWREbkSe1vOGJjxCjLqruld1vk49JRi0HD/twYGDfWQ4UP3rNSv8mD
	 31xcBURdrsGQQ==
Date: Fri, 30 Jun 2023 09:20:40 -0600
From: Keith Busch <kbusch@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Aurelien Aptel <aaptel@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH net] nvme-tcp: Fix comma-related oops
Message-ID: <ZJ7yyEiUWBTf8cCp@kbusch-mbp.dhcp.thefacebook.com>
References: <59062.1688075273@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59062.1688075273@warthog.procyon.org.uk>

On Thu, Jun 29, 2023 at 10:47:53PM +0100, David Howells wrote:
> Fix a comma that should be a semicolon.  The comma is at the end of an
> if-body and thus makes the statement after (a bvec_set_page()) conditional
> too, resulting in an oops because we didn't fill out the bio_vec[]:
> 
>     BUG: kernel NULL pointer dereference, address: 0000000000000008
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     ...
>     Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
>     RIP: 0010:skb_splice_from_iter+0xf1/0x370
>     ...
>     Call Trace:
>      tcp_sendmsg_locked+0x3a6/0xdd0
>      tcp_sendmsg+0x31/0x50
>      inet_sendmsg+0x47/0x80
>      sock_sendmsg+0x99/0xb0
>      nvme_tcp_try_send_data+0x149/0x490 [nvme_tcp]
>      nvme_tcp_try_send+0x1b7/0x300 [nvme_tcp]
>      nvme_tcp_io_work+0x40/0xc0 [nvme_tcp]
>      process_one_work+0x21c/0x430
>      worker_thread+0x54/0x3e0
>      kthread+0xf8/0x130
> 
> Fixes: 7769887817c3 ("nvme-tcp: Use sendmsg(MSG_SPLICE_PAGES) rather then sendpage")

We don't have this breaking commit in the nvme tree just yet, so feel
free to take the fix through net if this can't wait for the next nvme
rebase (we're based on the block tree).

