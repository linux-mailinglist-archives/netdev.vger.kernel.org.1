Return-Path: <netdev+bounces-49166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F1F7F0FBC
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 11:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010191F232B1
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 10:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD19125D2;
	Mon, 20 Nov 2023 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsMU4UPH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208111097F
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 10:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D76C433C9;
	Mon, 20 Nov 2023 10:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700474662;
	bh=4H0g9l8qPbZHx0o2tup3kRVj6Ms8Oh/f28F+uFeqY3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dsMU4UPH2z8Z4cHk8L+ybaatostzNMg2W9yOT0EZ5rWlolBqKL8SlsdP7oPRy7gyk
	 wiEJ0YvGuwe29ukqrTIZ8hU+Pc92YarIyAn+C+V5xTiN7g9IatNRO5n/GakfQmR7kW
	 xw6cL1DrAxF7M7Dkv/FlpGDcAqpgFk5Wgi6qp/QIs1OIw3vVa3MDifLdaqOK13CZbc
	 r/z1k/hWrPb5FabghnA6dr4UHtfYByyrySDQU6/O9WqE3RJuAuYBeiBdDF0W3ZaM8w
	 xImHZORtRoyYA8Pb/e0jX4fkqgL/kcZvbJNtGU4mdzmm81a0iJjgX2MFEfbm3rrhSf
	 baMKOAssy6H7A==
Date: Mon, 20 Nov 2023 10:04:17 +0000
From: Simon Horman <horms@kernel.org>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: Kunwu Chan <chentao@kylinos.cn>, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	kunwu.chan@hotmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sched: Fix an endian bug in tcf_proto_create
Message-ID: <20231120100417.GM186930@vergenet.net>
References: <20231117093110.1842011-1-chentao@kylinos.cn>
 <16c758c6-479b-4c54-ad51-88c26a56b4c9@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16c758c6-479b-4c54-ad51-88c26a56b4c9@mojatatu.com>

On Fri, Nov 17, 2023 at 09:06:45AM -0300, Pedro Tammela wrote:
> On 17/11/2023 06:31, Kunwu Chan wrote:
> > net/sched/cls_api.c:390:22: warning: incorrect type in assignment (different base types)
> > net/sched/cls_api.c:390:22:    expected restricted __be16 [usertype] protocol
> > net/sched/cls_api.c:390:22:    got unsigned int [usertype] protocol
> > 
> > Fixes: 33a48927c193 ("sched: push TC filter protocol creation into a separate function")
> > 
> > Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> > ---
> >   net/sched/cls_api.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> > index 1976bd163986..f73f39f61f66 100644
> > --- a/net/sched/cls_api.c
> > +++ b/net/sched/cls_api.c
> > @@ -387,7 +387,7 @@ static struct tcf_proto *tcf_proto_create(const char *kind, u32 protocol,
> >   		goto errout;
> >   	}
> >   	tp->classify = tp->ops->classify;
> > -	tp->protocol = protocol;
> > +	tp->protocol = cpu_to_be16(protocol);
> >   	tp->prio = prio;
> >   	tp->chain = chain;
> >   	spin_lock_init(&tp->lock);
> I don't believe there's something to fix here either

Hi Pedro and Kunwu,

I suspect that updating the byte order of protocol isn't correct
here - else I'd assume we would have seen a user-visible bug on
little-endian systems buy now.

But nonetheless I think there is a problem, which is that the appropriate
types aren't being used, which means the tooling isn't helping us wrt any
bugs that might subsequently be added or already lurking. So I think an
appropriate question is, what is the endien and width of protocol, and how
can we use an appropriate type throughout the call-path?

