Return-Path: <netdev+bounces-45374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D657DC588
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 05:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5030128128B
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 04:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7946D22;
	Tue, 31 Oct 2023 04:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZF9f3a7w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFFD6AB5
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 04:52:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8693CC433C7;
	Tue, 31 Oct 2023 04:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698727919;
	bh=hWmcabTW98wMgnMrYmQkrgraTflXAXmiqmyz9eu26yM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZF9f3a7w+m+cIzd3mKBOegwYHwEeHcugsChYYKQXx1M0RwNnXABrP8dMGGLopmrRe
	 Db6+zQh5EDPYXTQUqbF97k9miBfv1Te1Z0nDeV2HjpfWO7kTG/VTZIcqVESA1SJ9Du
	 wbnATex3FnVht4ERBEy/rV62bS1pmpxCRDDJ6Ua3O0Gp2J+BlVXO7nKxmzjFtz/cSY
	 PS4Eeulv+0pIX1HYYNeDTAjEhFH/hVNzuZZhsZiJTY/+oGjWu6ZtXRDkrL+QNLMjz1
	 4d3opdAGUo6Wah3baJkMBvJu631iajGaLjvXyfwCdZAJUGq8GsSg1gnQdqZi9/R2kp
	 QQbkiPmQ39qyQ==
Date: Mon, 30 Oct 2023 21:51:57 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>,
	Linux Crypto List <linux-crypto@vger.kernel.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Dmitry Safonov <dima@arista.com>,
	Francesco Ruggeri <fruggeri@arista.com>,
	Salam Noureddine <noureddine@arista.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the crypto tree
Message-ID: <20231031045157.GA12981@sol.localdomain>
References: <20231030155809.6b47288c@canb.auug.org.au>
 <20231030160953.28f2df61@canb.auug.org.au>
 <ZT896a2j3hUI1NF+@gondor.apana.org.au>
 <20231030150243.0e66ba73@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030150243.0e66ba73@kernel.org>

On Mon, Oct 30, 2023 at 03:02:43PM -0700, Jakub Kicinski wrote:
> On Mon, 30 Oct 2023 13:23:53 +0800 Herbert Xu wrote:
> > If we simply apply this patch to the netdev tree then everything
> > should work at the next merge window.  But perhaps you could change
> > the patch description to say something like remove the obsolete
> > crypto_hash_alignmask.  It's not important though.
> 
> I'm happy to massage the commit message and apply the fix to net.
> But is it actually 100% correct to do that? IOW is calling
> crypto_ahash_alignmask() already not necessary in net-next or does
> it only become unnecessary after some prep work in crypto-next?
> 
> We can tell Linus to squash this fix into the merge of either
> crypto-next or net-next, I'm pretty sure he'd be okay with that..

It's safe to fold the patch into net-next.  It actually looks like a bug to be
using the alignmask in the way that net/ipv4/tcp_ao.c is using it.  You don't
want to be erroring out just because the algorithm declared an alignmask.

- Eric

