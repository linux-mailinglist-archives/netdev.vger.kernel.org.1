Return-Path: <netdev+bounces-14734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5850A743873
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 11:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058AB280FBF
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 09:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D36B101D7;
	Fri, 30 Jun 2023 09:37:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A72E1FB8
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 09:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E58C433AB;
	Fri, 30 Jun 2023 09:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688117825;
	bh=NvISiXV+qNhfVjOdFA0oj/36t4SVSoQAe2nCdjSVIMg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dQspoZx13mxkWw3Lj4TBmT6UEUkj+SCv8Lmn23Y2WXcTo7qawU2gZLhMYxLeHyL/F
	 OULv8gwNTiagnBLymK7EMKrKDZEopP41CuIpG2r68c6URM9GKbUnmfoeYf9NVlIYql
	 gkOY6yJVKPA76AieVNAkBmz1Amfq0ge30ZdcZd2f3RnnEbwkjFI2C8jMhRObfOoZUa
	 NFzIL96E8xyd0NjgyyCTFityDy+M41QpYRrqmGucuEMS9L2RCRspPw3aeoYSZ7AGIW
	 7iEGmNvLx8bYw+cDslC1evuby/g5lBAdBt+flwtgeK6/3/N5Z5n/E1E98g5HPMPF+q
	 9ZVrVQ0PZxTrQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-4fb7dc16ff0so2626843e87.2;
        Fri, 30 Jun 2023 02:37:05 -0700 (PDT)
X-Gm-Message-State: ABy/qLaDAhv7g968syhRI69IwNTTUFmIKGKtBhcICZ4QQ4QO1Oy8lz9F
	TwAVHSL6S2U5PdJzwq/N8Ggv6boW/pvNtYgapZk=
X-Google-Smtp-Source: APBJJlGbO447UI8+8twcUUt9AmQN1aCCqPJVZYCruX+uaMq5bRXMYi1QAyHd0C/pXRJJ1RP9glerAKI5vjKUrkxacqE=
X-Received: by 2002:a05:6512:55c:b0:4fb:8603:f6aa with SMTP id
 h28-20020a056512055c00b004fb8603f6aamr1466400lfl.11.1688117823714; Fri, 30
 Jun 2023 02:37:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000008a7ae505aef61db1@google.com> <20200911170150.GA889@sol.localdomain>
 <c16e9ab9-13e0-b911-e33a-c9ae81e93a8d@I-love.SAKURA.ne.jp>
In-Reply-To: <c16e9ab9-13e0-b911-e33a-c9ae81e93a8d@I-love.SAKURA.ne.jp>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 30 Jun 2023 11:36:51 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFqYozjJ+qPeSApESb0Cb6CUaGXBrs5LP81ERRvb3+TAw@mail.gmail.com>
Message-ID: <CAMj1kXFqYozjJ+qPeSApESb0Cb6CUaGXBrs5LP81ERRvb3+TAw@mail.gmail.com>
Subject: Re: [PATCH] net: tls: enable __GFP_ZERO upon tls_init()
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, glider@google.com, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+828dfc12440b4f6f305d@syzkaller.appspotmail.com>, 
	Eric Biggers <ebiggers@kernel.org>, Aviad Yehezkel <aviadye@nvidia.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Jun 2023 at 15:49, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> syzbot is reporting uninit-value at aes_encrypt(), for block cipher assumes
> that bytes to encrypt/decrypt is multiple of block size for that cipher but
> tls_alloc_encrypted_msg() is not initializing padding bytes when
> required_size is not multiple of block cipher's block size.
>
> In order to make sure that padding bytes are automatically initialized,
> enable __GFP_ZERO flag when setsockopt(SOL_TCP, TCP_ULP, "tls") is called.
>
> Reported-by: syzbot <syzbot+828dfc12440b4f6f305d@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=828dfc12440b4f6f305d

Maybe I am missing something, but this syzkaller report appears to b a
huge collection of uninit-value reports, of which only one is related
to bpx_tx_verdict(), and that one has nor reproducer.

So even if this would be the right fix, I don't think closing that
issue makes sense, so? The issue refers to a couple of other
occcurences of uninit-value in aesti_encrypt, which do seem related.

> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> According to C reproducer, this problem happens when bpf_exec_tx_verdict() is
> called with lower 4 bits of required_size being 0001 and does not happen when
> being 0100. Thus, I assumed that this problem is caused by lack of initializing
> padding bytes.
> But I couldn't figure out why KMSAN reports this problem when bpf_exec_tx_verdict()
> is called with lower 4 bits of required_size being 0001 for the second time and
> does not report this problem when bpf_exec_tx_verdict() is called with lower
> 4 bits of required_size being 0001 for the first time. More deeper problem exists?
> KMSAN reporting this problem when accessing u64 relevant?
>

As Eric pointed out as well, zeroing the allocation papers over the problem.

Why are you sending this now? Do you have a reproducer for this issue?

>  net/tls/tls_main.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index f2e7302a4d96..cd5366966864 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c
> @@ -1025,6 +1025,7 @@ static int tls_init(struct sock *sk)
>         struct tls_context *ctx;
>         int rc = 0;
>
> +       sk->sk_allocation |= __GFP_ZERO;
>         tls_build_proto(sk);
>
>  #ifdef CONFIG_TLS_TOE
> --
> 2.34.1
>

