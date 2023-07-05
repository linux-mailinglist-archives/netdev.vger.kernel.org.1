Return-Path: <netdev+bounces-15573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C73748915
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 18:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A7F1C20919
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 16:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A851125D4;
	Wed,  5 Jul 2023 16:19:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC89D528
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 16:19:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBE6C433C7;
	Wed,  5 Jul 2023 16:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688573956;
	bh=I8//toDlMhKWO+Mg734+y6JMJ5/j+UnHcy3ppTquYdg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Utb3BqMM1rvcZQ24qE374lN6f9/nhrXOlAUV6NEcJ3KA1u03X+DUzxlIxv8eRz+ax
	 +yLMtFgHAC2PF00+O2ojCr6Dv+8ZbOhr8b52jsSiqrTP19d89YIqcHtyzwkrAVOAwh
	 ZJHV6WGYZh60KZ3Kn3uFoPGvJ7msxAcIUsD3Rx1rOD/tH8r+Y1sQW/QttLatjJj7kl
	 6KA9UgUAiAWFRNDMAApinGsDimTTUliNboEk9G2LO1IMHm2VWyNuigD2EYEexD1OMo
	 KBSES+lWxpc5gt6uf8JDtVDUhW5s9OX6meb2Weo2/k2Nr/qzhgevuoCVWenjetr1vJ
	 rMTW9LidH5nhg==
Date: Wed, 5 Jul 2023 09:19:14 -0700
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
Message-ID: <20230705091914.5bee12f8@kernel.org>
In-Reply-To: <f0538006-6641-eaf6-b7b5-b3ef57afc652@gmail.com>
References: <ecbb5d7e-7238-28e2-1a17-686325e2bb50@gmail.com>
	<4c49176f-147a-4283-f1b1-32aac7b4b996@gmail.com>
	<20230522121125.2595254-1-dhowells@redhat.com>
	<20230522121125.2595254-9-dhowells@redhat.com>
	<2267272.1686150217@warthog.procyon.org.uk>
	<5a9d4ffb-a569-3f60-6ac8-070ab5e5f5ad@gmail.com>
	<776549.1687167344@warthog.procyon.org.uk>
	<7337a904-231d-201d-397a-7bbe7cae929f@gmail.com>
	<20230630102143.7deffc30@kernel.org>
	<f0538006-6641-eaf6-b7b5-b3ef57afc652@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Jul 2023 23:06:02 +0300 Tariq Toukan wrote:
> Unfortunately, it still repros for us.
> 
> We are collecting more info on how the repro is affected by the 
> different parameters.

Consider configuring kdump for your test env. Debugging is super easy
if one has the vmcore available.

