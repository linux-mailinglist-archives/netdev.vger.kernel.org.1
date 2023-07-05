Return-Path: <netdev+bounces-15483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CAB747EF8
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 10:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41D41C20A64
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 08:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD41F1C33;
	Wed,  5 Jul 2023 08:05:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3318F1C30
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 08:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B03C433C7;
	Wed,  5 Jul 2023 08:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688544351;
	bh=8KCphNAk0TlE+DiBeEL+TuuxFz0PYy0g5YKTvdC+ijI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HuaXkKPi1GzQd5We+Vzc6C0n2FlJjXu+6jw6iKinzD53OAn9L8boQiXhLtvjJCpDY
	 ZWYqzmLA0CuLGf0UDTaHT1KDAMYbOHy5YAyC0ikL1PuqWauZcavKlWMOJ8J/vVn+yK
	 18cQAzyQbDtKsm2qtKsVlSMPaDUZYuLEcEPrXCuskw+TRFU5kKzUzK75OuUfSpLE+t
	 uPqfamCBDs17v5ff6PtnLxgVctp99SfmEIoSEodGUVIYBo3+vV3lPK3jc91ewf6zbA
	 sZTv1aNVdoU6tTlV9OQVYW6RL/gDAGhwERcxAp2ZVCY/iOKfwKlcd/+f2BMQC/2WNa
	 TfJiFMt4IkeXw==
Date: Wed, 5 Jul 2023 09:05:45 +0100
From: Lee Jones <lee@kernel.org>
To: Zheng Wang <zyytlz.wz@163.com>
Cc: s.shtylyov@omp.ru, davem@davemloft.net, linyunsheng@huawei.com,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
	alex000young@gmail.com
Subject: Re: [PATCH net v3] net: ravb: Fix possible UAF bug in ravb_remove
Message-ID: <20230705080545.GA589018@google.com>
References: <20230311180630.4011201-1-zyytlz.wz@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230311180630.4011201-1-zyytlz.wz@163.com>

On Sun, 12 Mar 2023, Zheng Wang wrote:

> In ravb_probe, priv->work was bound with ravb_tx_timeout_work.
> If timeout occurs, it will start the work. And if we call
> ravb_remove without finishing the work, there may be a
> use-after-free bug on ndev.
> 
> Fix it by finishing the job before cleanup in ravb_remove.
> 
> Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> ---
> v3:
> - fix typo in commit message
> v2:
> - stop dev_watchdog so that handle no more timeout work suggested by Yunsheng Lin,
> add an empty line to make code clear suggested by Sergey Shtylyov
> ---
>  drivers/net/ethernet/renesas/ravb_main.c | 4 ++++
>  1 file changed, 4 insertions(+)

Was a follow-up to this ever sent?

-- 
Lee Jones [李琼斯]

