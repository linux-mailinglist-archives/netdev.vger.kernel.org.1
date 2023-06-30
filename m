Return-Path: <netdev+bounces-14730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 455287436CD
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 10:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C251C209E3
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 08:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5A5A92A;
	Fri, 30 Jun 2023 08:15:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8698F41
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 08:15:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EBEC433C8;
	Fri, 30 Jun 2023 08:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688112938;
	bh=xFT58AgnoEdvrriMPFKIYVP3VSxYOuXQiVLAb8fkBuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dtNuvpkjstdh+XtSqjulDd69wa1F83pXwB0q02RcGditu6uhdmt4jWh8L4DVV0nLN
	 MYUE16jyGN4yV/7yaeKEi7RHgb4js2iiR2BdmYTcb1w7PjfC0jbiXjJzR/wB5wpRQ8
	 iCaAWw8vbUomvbqr2+c5faJWOgSyq1tkIGGgX3ajb9YRyVBhnyHDcyX77y8YAn3cQc
	 8TlmyC17VOOLkw87V75NOClVFsLwCN1OPZnYrmPFK1681aTbbihHE1FFopbEtpiug2
	 Rh8+w0Y7o5l655cXA4ve29yTDBJ0itchVj1fZvPOYEBblKwYzsBJCOIAFRsVRYm4oa
	 HjzR1iKDhT9SA==
Date: Fri, 30 Jun 2023 01:15:36 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jakub Kicinski <kuba@kernel.org>, Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>, glider@google.com,
	herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot <syzbot+828dfc12440b4f6f305d@syzkaller.appspotmail.com>,
	Aviad Yehezkel <aviadye@nvidia.com>,
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net: tls: enable __GFP_ZERO upon tls_init()
Message-ID: <20230630081536.GD36542@sol.localdomain>
References: <0000000000008a7ae505aef61db1@google.com>
 <20200911170150.GA889@sol.localdomain>
 <c16e9ab9-13e0-b911-e33a-c9ae81e93a8d@I-love.SAKURA.ne.jp>
 <20230628140317.756e61d3@kernel.org>
 <ada9b995-8d67-0375-f153-b434d48bd253@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ada9b995-8d67-0375-f153-b434d48bd253@I-love.SAKURA.ne.jp>

On Thu, Jun 29, 2023 at 07:15:21AM +0900, Tetsuo Handa wrote:
> On 2023/06/29 6:03, Jakub Kicinski wrote:
> > On Wed, 28 Jun 2023 22:48:01 +0900 Tetsuo Handa wrote:
> >> syzbot is reporting uninit-value at aes_encrypt(), for block cipher assumes
> >> that bytes to encrypt/decrypt is multiple of block size for that cipher but
> >> tls_alloc_encrypted_msg() is not initializing padding bytes when
> >> required_size is not multiple of block cipher's block size.
> > 
> > Sounds odd, so crypto layer reads beyond what we submitted as 
> > the buffer? I don't think the buffer needs to be aligned, so
> > the missing bits may well fall into a different (unmapped?) page.
> 
> Since passing __GFP_ZERO to skb_page_frag_refill() hides this problem,
> I think that crypto layer is reading up to block size when requested
> size is not multiple of block size.
> 
> > 
> > This needs more careful investigation. Always zeroing the input 
> > is just covering up the real issue.
> 
> Since block cipher needs to read up to block size, someone has to initialize
> padding bytes. I guess that crypto API caller is responsible for allocating
> and initializing padding bytes, otherwise such crypto API caller will fail to
> encrypt/decrypt last partial bytes which are not multiple of cipher's block
> size.
> 
> Which function in this report is responsible for initializing padding bytes?

According to the sample crash report from
https://syzkaller.appspot.com/bug?extid=828dfc12440b4f6f305d, the uninitialized
memory access happens while the TLS layer is doing an AES-CCM encryption
operation.  CCM supports arbitrarily-aligned additional authenticated data and
plaintext/ciphertext.  Also, an encryption with crypto_aead_encrypt() reads
exactly 'assoclen + cryptlen' bytes from the 'src' scatterlist; it's not
supposed to ever go past that, even if the data isn't "block aligned".

The "aead" API (include/crypto/aead.h) is still confusing and hard to use
correctly, though, mainly because of the weird scatterlist layout it expects
with the AAD and plaintext/ciphertext concatenated to each other.  I wouldn't be
surprised if the TLS layer is making some error.  What is the exact sequence of
crypto_aead_* calls that results in this issue?

- Eric

