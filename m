Return-Path: <netdev+bounces-27659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CE577CAF8
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 12:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7E851C20CA2
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 10:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74635101D6;
	Tue, 15 Aug 2023 10:08:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1374D6FA9
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 10:08:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A8AC433C7;
	Tue, 15 Aug 2023 10:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692094131;
	bh=WXxWFK899KIgLhrs+YGjc/laHsehwNLisxtjpNW6J/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AvgP8muNwp07RnaQ0dcY4SFvNTuZwpyxYcLkIPYOlcP4sK9knXZm1pbF9ta6TxIKY
	 LjY8L7LrO/sXH5Yihk9BVPi15qkVk/U3/Z/xvbS5PJJrVGNMTy9R48nAEiF7G81K0M
	 2ngiHSvzNWnWzklRmrUfbfsSjEIukoqy1YQLvpId/GAVL9yUCcapJPQulBOGbtBq5X
	 cLhb7HOo/Y3W/zv1Kqphn0jFXJl2Ezju10Is/H2qjBzljRAs5ZZaGVt8QbfHH/6bYG
	 kRtDYZgWjuEXfb30hFtYw+U9Qh8CdOw2buRyK65OWhokkwxBpRL1+ndDsq6NyrHgx5
	 lgubSVX4m2bRA==
Date: Tue, 15 Aug 2023 11:08:44 +0100
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
Message-ID: <20230815100844.GA495519@google.com>
References: <20230725030026.1664873-1-zyytlz.wz@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230725030026.1664873-1-zyytlz.wz@163.com>

On Tue, 25 Jul 2023, Zheng Wang wrote:

> In ravb_probe, priv->work was bound with ravb_tx_timeout_work.
> If timeout occurs, it will start the work. And if we call
> ravb_remove without finishing the work, there may be a
> use-after-free bug on ndev.
> 
> Fix it by finishing the job before cleanup in ravb_remove.
> 
> Note that this bug is found by static analysis, it might be
> false positive.
> 
> Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> ---
> v4:
> - add information about the bug was found suggested by Yunsheng Lin
> v3:
> - fix typo in commit message
> v2:
> - stop dev_watchdog so that handle no more timeout work suggested by Yunsheng Lin,
> add an empty line to make code clear suggested by Sergey Shtylyov
> ---
>  drivers/net/ethernet/renesas/ravb_main.c | 3 +++
>  1 file changed, 3 insertions(+)

Trying my best not to sound like a broken record, but ...

What's the latest with this fix?  Is a v5 en route?

-- 
Lee Jones [李琼斯]

