Return-Path: <netdev+bounces-14740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4C07438DD
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 12:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1F391C20AEF
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 10:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D1B1079C;
	Fri, 30 Jun 2023 10:02:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD02101D3
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 10:02:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6979C433CB;
	Fri, 30 Jun 2023 10:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688119339;
	bh=nBS5XCoGjhKttjMnDZZoVb+UNrUcjA/yGTyzvvhnVYc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dcFxJqMG3YGVXgkAdX+yWyE4Q2+ccChEAqpEJhsb1E1Y6jijipDPBExb8/m5SO1OU
	 +Qvm63leh4mjcy3GvjqTR1NFssj4EulCdFsESeLhaeB1H89122pRZPUUm6yojQjKtX
	 5/NV+Y7baXxcRymR6fHCvdFrjsZFQt5G64GyCndd19BC7rSgUDPZNn6Qiwo3uhwv1O
	 9tXf7op3UBuiUk9GUWzF4UNoIQg77uVcJV6C0uKY/sBWK1rtwDKhNNCgt14OQrCF4G
	 LBqIYovLRHsHco+CITja8vPtRfPg97+qJxUFciBNIRjIKFvHvGTcTHKC7aDk4i31+U
	 05FMqYYPdQKxQ==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2b69f71a7easo27467281fa.1;
        Fri, 30 Jun 2023 03:02:19 -0700 (PDT)
X-Gm-Message-State: ABy/qLbcbMVVkO69xGZMz2bF0Mr6vs3EdN/ipfkwnDhX+oDL7wWP/BdU
	3xWBpd8j1o6cUWiO47zyAEaTxKyMotGSrEe+eVw=
X-Google-Smtp-Source: APBJJlEhYhH4Zmna81knCIrT5f9hrU1970+5lb1GyQsjgOckbkPqQQig/JJGGCqBoRs3JxeC1b8+dN9lBoqo1riftl8=
X-Received: by 2002:a05:6512:36c9:b0:4f8:4512:c844 with SMTP id
 e9-20020a05651236c900b004f84512c844mr1728469lfs.48.1688119337754; Fri, 30 Jun
 2023 03:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000008a7ae505aef61db1@google.com> <20200911170150.GA889@sol.localdomain>
 <c16e9ab9-13e0-b911-e33a-c9ae81e93a8d@I-love.SAKURA.ne.jp>
 <CAMj1kXFqYozjJ+qPeSApESb0Cb6CUaGXBrs5LP81ERRvb3+TAw@mail.gmail.com> <59e1d5c0-aedb-7b5b-f37f-0c20185d7e9b@I-love.SAKURA.ne.jp>
In-Reply-To: <59e1d5c0-aedb-7b5b-f37f-0c20185d7e9b@I-love.SAKURA.ne.jp>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 30 Jun 2023 12:02:06 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGHRUUFYL09Lm-mO6MfGc19rC=-7mSJ1eDTcbw7QuEkaw@mail.gmail.com>
Message-ID: <CAMj1kXGHRUUFYL09Lm-mO6MfGc19rC=-7mSJ1eDTcbw7QuEkaw@mail.gmail.com>
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

On Fri, 30 Jun 2023 at 11:53, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2023/06/30 18:36, Ard Biesheuvel wrote:
> > Why are you sending this now?
>
> Just because this is currently top crasher and I can reproduce locally.
>
> > Do you have a reproducer for this issue?
>
> Yes. https://syzkaller.appspot.com/text?tag=ReproC&x=12931621900000 works.
>

Could you please share your kernel config and the resulting kernel log
when running the reproducer? I'll try to reproduce locally as well,
and see if I can figure out what is going on in the crypto layer

