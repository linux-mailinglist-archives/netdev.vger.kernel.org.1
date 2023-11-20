Return-Path: <netdev+bounces-49073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D297F09F8
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 01:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135E51F2123B
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 00:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95AA371;
	Mon, 20 Nov 2023 00:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BuiWcaDt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACB87F
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:11:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE900C433CB
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:11:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BuiWcaDt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1700439079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EDEIV/r9CcMTrhnb7jfSFXpHelVCOPTrovqD8XmdmjU=;
	b=BuiWcaDtbYr+ZDTHjRtQVVgUyMUG9onEjQYog/8kgIBy5wbpP+QQ9wCOkrAN6Taczh0DAI
	ue12I/cD7jgpmeClJjEQhLYsnRBk5USk/FANT2p/TMhT4H89p5bw2E2UY3CmIJaUjXnRIC
	zS26xrlBoYGe5v+nU1fTLF4gebCtP0s=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 05688191 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <netdev@vger.kernel.org>;
	Mon, 20 Nov 2023 00:11:19 +0000 (UTC)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-daf26d84100so3760820276.3
        for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 16:11:18 -0800 (PST)
X-Gm-Message-State: AOJu0YxDHh6wrRvkfdRCT5/0EGIDKE3W7XMWF4f61AiUpe0WDMatrgQM
	a43OFuqOzc79D8lUwIRRN2ZUyYterJcdzSZHJdI=
X-Google-Smtp-Source: AGHT+IHEdyRsRRINmmb9nwSn5lf94aoCjTP2PAVkKkn0XL3bnmmIJrlSRCn6BB2C3sHM3vpecIV0m+XGi3zjka7WZYE=
X-Received: by 2002:a25:2558:0:b0:da0:cc14:b66 with SMTP id
 l85-20020a252558000000b00da0cc140b66mr5536388ybl.9.1700439077183; Sun, 19 Nov
 2023 16:11:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231117141733.3344158-1-edumazet@google.com> <170042342319.11006.13933415217196728575.git-patchwork-notify@kernel.org>
In-Reply-To: <170042342319.11006.13933415217196728575.git-patchwork-notify@kernel.org>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Mon, 20 Nov 2023 01:11:04 +0100
X-Gmail-Original-Message-ID: <CAHmME9q4uSKxtEnRmcM2h2GGSBcq9Hu_9tk3EX2_EVGFXr6KnQ@mail.gmail.com>
Message-ID: <CAHmME9q4uSKxtEnRmcM2h2GGSBcq9Hu_9tk3EX2_EVGFXr6KnQ@mail.gmail.com>
Subject: Re: [PATCH v2 net] wireguard: use DEV_STATS_INC()
To: patchwork-bot+netdevbpf@kernel.org
Cc: Eric Dumazet <edumazet@google.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzkaller@googlegroups.com, liuhangbin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Nov 19, 2023 at 8:50=E2=80=AFPM <patchwork-bot+netdevbpf@kernel.org=
> wrote:
>
> Hello:
>
> This patch was applied to netdev/net.git (main)
> by David S. Miller <davem@davemloft.net>:
>
> On Fri, 17 Nov 2023 14:17:33 +0000 you wrote:
> > wg_xmit() can be called concurrently, KCSAN reported [1]
> > some device stats updates can be lost.
> >
> > Use DEV_STATS_INC() for this unlikely case.
> >
> > [1]
> > BUG: KCSAN: data-race in wg_xmit / wg_xmit
> >
> > [...]
>
> Here is the summary with links:
>   - [v2,net] wireguard: use DEV_STATS_INC()
>     https://git.kernel.org/netdev/net/c/93da8d75a665
>
> You are awesome, thank you!

I thought that, given my concerns, if this was to be committed, at
least Eric (or you?) would expand on the rationale in the context of
my concerns while (or before) doing so, rather than just applying this
without further discussion. As I mentioned, this is fine with me if
you feel strongly about it, but I would appreciate some expanded
explanation, just for my own understanding of the matter.

Jason

