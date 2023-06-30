Return-Path: <netdev+bounces-14815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F7A743F83
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 18:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B2C28114B
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 16:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217CC168AC;
	Fri, 30 Jun 2023 16:14:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35C7168A4;
	Fri, 30 Jun 2023 16:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C914CC433C8;
	Fri, 30 Jun 2023 16:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688141683;
	bh=OQ6W9Mf8SjuyriHv2gHrYTgggbQw7sK3MPN4gMZ87ZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WAwX+Yr1sAkgsIUXUcFV1FByBoFxm26kJ7kIXPDZuGZE6iqLBI4Ji4g8eHF9X4TSf
	 FZtftQgV87fi5h6nmkFhmUYeD4+za+zR5E2WkJqQVxhUmIEQOKUjm75ZQitaGSzk4J
	 0OrJqdu7MlktJKEdYMUYINhOzGyzvwS7S17WgDP1iUbaNYmxxfgBXY3DEyz+shCASI
	 ziTLDz9Y8rHUXBphJJXTXNIwHHHo4meZmPD/qhmizwVEX8m9VH+O/8vzoVL1+RILxf
	 yyLfKRBJM1M/Kl0fMmQn+t8c8s4Z/nZAuv8TJUfSnr1vtWj9rA1ccEucxd/97CeE9d
	 XUagxkK+qJVIQ==
Date: Fri, 30 Jun 2023 09:14:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Aurelien Aptel <aaptel@nvidia.com>,
 netdev@vger.kernel.org, Alexander Duyck <alexander.duyck@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Sagi Grimberg
 <sagi@grimberg.me>, Willem de Bruijn <willemb@google.com>, Keith Busch
 <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig
 <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH net-next v3 10/18] nvme/host: Use
 sendmsg(MSG_SPLICE_PAGES) rather then sendpage
Message-ID: <20230630091442.172ec67f@kernel.org>
In-Reply-To: <20230630161043.GA2902645@dev-arch.thelio-3990X>
References: <253mt0il43o.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
	<20230620145338.1300897-1-dhowells@redhat.com>
	<20230620145338.1300897-11-dhowells@redhat.com>
	<58466.1688074499@warthog.procyon.org.uk>
	<20230629164318.44f45caf@kernel.org>
	<20230630161043.GA2902645@dev-arch.thelio-3990X>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jun 2023 09:10:43 -0700 Nathan Chancellor wrote:
> > Let me CC llvm@ in case someone's there is willing to make 
> > the compiler warn about this.
> 
> Turns out clang already has a warning for this, -Wcomma:
> 
>   drivers/nvme/host/tcp.c:1017:38: error: possible misuse of comma operator here [-Werror,-Wcomma]
>    1017 |                         msg.msg_flags &= ~MSG_SPLICE_PAGES,
>         |                                                           ^
>   drivers/nvme/host/tcp.c:1017:4: note: cast expression to void to silence warning
>    1017 |                         msg.msg_flags &= ~MSG_SPLICE_PAGES,
>         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         |                         (void)(                           )
>   1 error generated.
> 
> Let me do some wider build testing to see if it is viable to turn this
> on for the whole kernel because it seems worth it, at least in this
> case. There are a lot of cases where a warning won't be emitted (see the
> original upstream review for a list: https://reviews.llvm.org/D3976) but
> something is better than nothing, right? :)

Ah, neat. Misleading indentation is another possible angle, I reckon,
but not sure if that's enabled/possible to enable for the entire kernel
either :( We test-build with W=1 in networking, FWIW, so W=1 would be
enough for us.

