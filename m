Return-Path: <netdev+bounces-19090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93501759A03
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 17:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D1431C21075
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 15:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C66C16414;
	Wed, 19 Jul 2023 15:40:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC7E16412
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 15:40:34 +0000 (UTC)
X-Greylist: delayed 1199 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Jul 2023 08:40:30 PDT
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABEA10F1;
	Wed, 19 Jul 2023 08:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple;
 d=nerdbynature.de; i=@nerdbynature.de; q=dns/txt; s=key1;
 t=1689778933; h=date : from : to : cc : subject : in-reply-to :
 message-id : references : mime-version : content-type : from;
 bh=xIYPqanAqkNAcIDfDD9JYV48Ktk2KbeO1AnpEFpuS/I=;
 b=vcdbASREu5aB4xdwGWi8S7mPC8bFlQ0PgNxR0yfMBzxKb9E1vXhqBeg1cVjgtmQSNpU0t
 fFf5m84sO0Mk+HwCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nerdbynature.de;
 i=@nerdbynature.de; q=dns/txt; s=key0; t=1689778933; h=date : from :
 to : cc : subject : in-reply-to : message-id : references :
 mime-version : content-type : from;
 bh=xIYPqanAqkNAcIDfDD9JYV48Ktk2KbeO1AnpEFpuS/I=;
 b=Tk4ambya8ok6FoEYIxOG23sv3Who4TleXFWWJQ1CHPekpI4zK9a0uZCEcd4gzcRXvcgLM
 IteT/7ZVNrzjptE7BrT/fCv/wdO5pjFwDbD/f+7lWB2+nzq9dVaINbYYgaTo95+txHg3nrJ
 lN5mPSKNVz4b1xfN5NQumzzt+nxzj6DUT8cd08rnqZwvOmqj/vUwOW9Co2tAemOs5MUVUbi
 eUkVFOfaG/Kwz/6xsSUVyp9wlwCvM0SKxOlbXH7GrcqG7lQAl797aOeGLhrUqt/UQdF2R0C
 aGsrK4fSAQCYd+wxmenyRR+HTGvo0X0WmOKDdOmlUWoIzV0o/tQK9COYSHuQ==
Received: from localhost (localhost [IPv6:::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by trent.utfs.org (Postfix) with ESMTPS id 3F2345F998;
	Wed, 19 Jul 2023 17:02:13 +0200 (CEST)
Date: Wed, 19 Jul 2023 17:02:13 +0200 (CEST)
From: Christian Kujau <lists@nerdbynature.de>
To: syzbot <syzbot+96eb4e0d727f0ae998a6@syzkaller.appspotmail.com>
cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, 
    jfs-discussion@lists.sourceforge.net, kuninori.morimoto.gx@renesas.com, 
    netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
    linux-kernel@vger.kernel.org, povik+lin@cutebit.org, edumazet@google.com, 
    broonie@kernel.org, linux-fsdevel@vger.kernel.org, kuba@kernel.org, 
    pabeni@redhat.com, davem@davemloft.net, wireguard@lists.zx2c4.com, 
    Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [Jfs-discussion] [syzbot] [wireguard?] [jfs?] KASAN:
 slab-use-after-free Read in wg_noise_keypair_get
In-Reply-To: <97a9c205-2074-07f8-ae9d-9f2b4aebbf9a@oracle.com>
Message-ID: <30f03978-3035-a28e-c097-112036901bcb@nerdbynature.de>
References: <0000000000002bfa570600c477b3@google.com> <CAHmME9reBny-ufJp58uOg+KdMptircBRhLFd-N2KwxNUp6myTA@mail.gmail.com> <97a9c205-2074-07f8-ae9d-9f2b4aebbf9a@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 18 Jul 2023, Dave Kleikamp via Jfs-discussion wrote:
> Maybe not. It could possibly fixed by:
> https://github.com/kleikamp/linux-shaggy/commit/6e2bda2c192d0244b5a78b787ef20aa10cb319b7

Let's try this:

#syz test: https://github.com/kleikamp/linux-shaggy.git 6e2bda2c192d0244b5a78b787ef20aa10cb319b7

-- 
BOFH excuse #371:

Incorrectly configured static routes on the corerouters.

