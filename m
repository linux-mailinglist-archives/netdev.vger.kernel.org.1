Return-Path: <netdev+bounces-14456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4BD7419FD
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 23:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E544A280CC3
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 21:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AD711181;
	Wed, 28 Jun 2023 21:03:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050162C9D
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 21:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B592C433C0;
	Wed, 28 Jun 2023 21:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687986198;
	bh=taogyxlxQ+1K0qg3OBjrm+rufktyEbtN8eOpF9xqVs4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LFfWFIv7+YiMyacNyyYzut9KsthSQqThgNliTfbLNy4YZ+9+Ol5Ik3KRG5yVNSOGW
	 76Wfao5gzVsy3J4lDOLwd6VHbBSgBiqCmLAgQuKikHqGOqhSxcegMILVA9AFFqGVzg
	 NhyUQzAz4YhEN0OA4tzMM5MKDF/60+8OqpuOJBzCb1Sf0nPe0w8008JW1C7Tg+0uRr
	 c9DTXcNIHuM8L+QyABiMyPjOZTNniK4x9+Rj6Exs6QAKIXxXLR84zwAG2krgiTOWFZ
	 PM54kYMGxDztyH1eB6OeODcSiNUN/JCPvDHnaQIulyl+IXjiKupUlQByQhs+Uwd16j
	 QjOAu8FvPd6fg==
Date: Wed, 28 Jun 2023 14:03:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Boris Pismenny <borisp@nvidia.com>, John Fastabend
 <john.fastabend@gmail.com>, glider@google.com, herbert@gondor.apana.org.au,
 linux-crypto@vger.kernel.org, syzkaller-bugs@googlegroups.com, syzbot
 <syzbot+828dfc12440b4f6f305d@syzkaller.appspotmail.com>, Eric Biggers
 <ebiggers@kernel.org>, Aviad Yehezkel <aviadye@nvidia.com>, Daniel Borkmann
 <daniel@iogearbox.net>, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH] net: tls: enable __GFP_ZERO upon tls_init()
Message-ID: <20230628140317.756e61d3@kernel.org>
In-Reply-To: <c16e9ab9-13e0-b911-e33a-c9ae81e93a8d@I-love.SAKURA.ne.jp>
References: <0000000000008a7ae505aef61db1@google.com>
	<20200911170150.GA889@sol.localdomain>
	<c16e9ab9-13e0-b911-e33a-c9ae81e93a8d@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Jun 2023 22:48:01 +0900 Tetsuo Handa wrote:
> syzbot is reporting uninit-value at aes_encrypt(), for block cipher assumes
> that bytes to encrypt/decrypt is multiple of block size for that cipher but
> tls_alloc_encrypted_msg() is not initializing padding bytes when
> required_size is not multiple of block cipher's block size.

Sounds odd, so crypto layer reads beyond what we submitted as 
the buffer? I don't think the buffer needs to be aligned, so
the missing bits may well fall into a different (unmapped?) page.

This needs more careful investigation. Always zeroing the input 
is just covering up the real issue.

