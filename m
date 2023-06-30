Return-Path: <netdev+bounces-14801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C340B743EC4
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 17:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F142810EC
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 15:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA40A16419;
	Fri, 30 Jun 2023 15:27:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957C716415
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 15:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CB6C433C8;
	Fri, 30 Jun 2023 15:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688138855;
	bh=/32iJiR/JK8rPYdrc3L2HvX+BSz7BOGH7Jc+j9XCXqM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JJdkc7/f8p4psfPzcSEu+LXpoACMuF5/v4KU9T+Tih3MP7jpCrTTGCzMnhR6j54a1
	 +1IIYgLYssmBDYLEQEIdU+4Q6v6BFR6E3M3YTyCABm6e/m0bI75lftAyHBwW9L3rF3
	 km48drFOkHQa0p62/RQwHZQ9WsJVfNJjtHwamUQ9dQ19h+BJ80OWrXy60QDniQXUKj
	 V7WhpCvZiD1s+9jQ8txtZ9NEgdbWwC6/Xde2Ga2u26qQyEorfKDMu3FTqdbBIH2elx
	 DHu/wDqXVIZscmkydAz9MiSDO9tXt5+0LlUFXo7KCYe+/1YU2uU5JfPr7jXYVrpspj
	 9es5pG3tDdp3w==
Date: Fri, 30 Jun 2023 08:27:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Alexander Potapenko <glider@google.com>, Tetsuo Handa
 <penguin-kernel@i-love.sakura.ne.jp>, Boris Pismenny <borisp@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>, herbert@gondor.apana.org.au,
 linux-crypto@vger.kernel.org, syzkaller-bugs@googlegroups.com, syzbot
 <syzbot+828dfc12440b4f6f305d@syzkaller.appspotmail.com>, Eric Biggers
 <ebiggers@kernel.org>, Aviad Yehezkel <aviadye@nvidia.com>, Daniel Borkmann
 <daniel@iogearbox.net>, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH] net: tls: enable __GFP_ZERO upon tls_init()
Message-ID: <20230630082733.4250175b@kernel.org>
In-Reply-To: <CAMj1kXE_PjQT6+A9a0Y=ZfbOr_H+umYSqHuRrM6AT_gFJxxP1w@mail.gmail.com>
References: <0000000000008a7ae505aef61db1@google.com>
	<20200911170150.GA889@sol.localdomain>
	<c16e9ab9-13e0-b911-e33a-c9ae81e93a8d@I-love.SAKURA.ne.jp>
	<CAMj1kXFqYozjJ+qPeSApESb0Cb6CUaGXBrs5LP81ERRvb3+TAw@mail.gmail.com>
	<59e1d5c0-aedb-7b5b-f37f-0c20185d7e9b@I-love.SAKURA.ne.jp>
	<CAMj1kXGHRUUFYL09Lm-mO6MfGc19rC=-7mSJ1eDTcbw7QuEkaw@mail.gmail.com>
	<CAG_fn=X+eU=-WLXASidBCHWS3L7RvtN=mx3Bj8GD9GcA=Htf2w@mail.gmail.com>
	<CAMj1kXFrsc7bsjo2i0=9AqVNSCvXEnYAukzoXeaYEH9EpNviBA@mail.gmail.com>
	<CAG_fn=VFa2yeiZmdyuVRmZYtWn6Tkox8UVrOrCv4tEec3BFYbQ@mail.gmail.com>
	<CAMj1kXEdwjN7Q8tKVxHz98zQ4EsWVSdLZ5tQaV-nXxc9hwRYjQ@mail.gmail.com>
	<CAG_fn=UWZWc+FZ_shCr+T9Y3gV9Bue-ZFHKJj78YXBq3JfnUKA@mail.gmail.com>
	<CAMj1kXE_PjQT6+A9a0Y=ZfbOr_H+umYSqHuRrM6AT_gFJxxP1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jun 2023 17:16:06 +0200 Ard Biesheuvel wrote:
> Note that this is the *input* scatterlist containing the AAD
> (additional authenticated data) and the crypto input, and so there is
> definitely a bug here that shouldn't be papered over by zero'ing the
> allocation.

Noob question, it's not the tag / AAD, right? We definitely don't init
that..

