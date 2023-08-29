Return-Path: <netdev+bounces-31279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8320F78C666
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 15:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0E9281240
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 13:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5877117741;
	Tue, 29 Aug 2023 13:46:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE92B14F6C
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 13:46:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BDCC433C7;
	Tue, 29 Aug 2023 13:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693316783;
	bh=mxUSGoaiwDu9p3NHVkQW2/eRUPS+fI4b+7+yluZCnZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MTBNFf91Si/pjCRqCKIwNMeD7UY8htfyBKc+B+DV45VggRervqbx3MDnbkEcjeYyb
	 XLX4R2uvdznzl3fy/E4L/E+Xn/FDbd3I4bwAVVi6PKKdXij5MECU4Aa8SbCI9cqzi1
	 M+8vQ+pOR1M2W98JCUamxm28VRWo3iP6iWDWbrCu2nO/lE0Qxl8Ij1nr0b05TyozXf
	 gOZZfT07ge+JLQ0hYzUXtS9JQu1JTo/Y+2QrEtO0xSeloR8S8XpIFWhKahMEpqNQaQ
	 YK2KMYjsZC2/9sk34g6EEC3KIAVg2A3vg3XWD3IDS6GThkag+C+G1Hzy0395IKxN28
	 cve3TJVy1b0aA==
Date: Tue, 29 Aug 2023 14:46:16 +0100
From: Lee Jones <lee@kernel.org>
To: Zheng Wang <zyytlz.wz@163.com>
Cc: s.shtylyov@omp.ru, linyunsheng@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	richardcochran@gmail.com, p.zabel@pengutronix.de,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	yoshihiro.shimoda.uh@renesas.com, biju.das.jz@bp.renesas.com,
	wsa+renesas@sang-engineering.com, netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
	alex000young@gmail.com
Subject: Re: [PATCH v4] net: ravb: Fix possible UAF bug in ravb_remove
Message-ID: <20230829134616.GA215597@google.com>
References: <20230725030026.1664873-1-zyytlz.wz@163.com>
 <20230815100844.GA495519@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230815100844.GA495519@google.com>

On Tue, 15 Aug 2023, Lee Jones wrote:

> On Tue, 25 Jul 2023, Zheng Wang wrote:
> 
> > In ravb_probe, priv->work was bound with ravb_tx_timeout_work.
> > If timeout occurs, it will start the work. And if we call
> > ravb_remove without finishing the work, there may be a
> > use-after-free bug on ndev.
> > 
> > Fix it by finishing the job before cleanup in ravb_remove.
> > 
> > Note that this bug is found by static analysis, it might be
> > false positive.
> > 
> > Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> > ---
> > v4:
> > - add information about the bug was found suggested by Yunsheng Lin
> > v3:
> > - fix typo in commit message
> > v2:
> > - stop dev_watchdog so that handle no more timeout work suggested by Yunsheng Lin,
> > add an empty line to make code clear suggested by Sergey Shtylyov
> > ---
> >  drivers/net/ethernet/renesas/ravb_main.c | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> Trying my best not to sound like a broken record, but ...
> 
> What's the latest with this fix?  Is a v5 en route?

Any update please Zheng Wang?

-- 
Lee Jones [李琼斯]

