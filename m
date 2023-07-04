Return-Path: <netdev+bounces-15279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECF074691C
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 07:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D6A81C20947
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 05:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486857F8;
	Tue,  4 Jul 2023 05:43:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D267ED
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 05:43:53 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205C8AB;
	Mon,  3 Jul 2023 22:43:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id B884320764;
	Tue,  4 Jul 2023 07:43:49 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vXqqGLlnvmHh; Tue,  4 Jul 2023 07:43:48 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id C32DB20520;
	Tue,  4 Jul 2023 07:43:48 +0200 (CEST)
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id BA62280004A;
	Tue,  4 Jul 2023 07:43:48 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 07:43:48 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 4 Jul
 2023 07:43:48 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id CD3163182AE1; Tue,  4 Jul 2023 07:43:47 +0200 (CEST)
Date: Tue, 4 Jul 2023 07:43:47 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Lin Ma <linma@zju.edu.cn>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<simon.horman@corigine.com>, <adobriyan@gmail.com>
Subject: Re: [PATCH v3] net: xfrm: Fix xfrm_address_filter OOB read
Message-ID: <ZKOxk0Ff5r9MRBHW@gauss3.secunet.de>
References: <20230627033138.1177437-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230627033138.1177437-1-linma@zju.edu.cn>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 27, 2023 at 11:31:38AM +0800, Lin Ma wrote:
> We found below OOB crash:
> 
> [   44.211730] ==================================================================
> [   44.212045] BUG: KASAN: slab-out-of-bounds in memcmp+0x8b/0xb0
> [   44.212045] Read of size 8 at addr ffff88800870f320 by task poc.xfrm/97
> [   44.212045]
> [   44.212045] CPU: 0 PID: 97 Comm: poc.xfrm Not tainted 6.4.0-rc7-00072-gdad9774deaf1-dirty #4
> [   44.212045] Call Trace:
> [   44.212045]  <TASK>
> [   44.212045]  dump_stack_lvl+0x37/0x50
> [   44.212045]  print_report+0xcc/0x620
> [   44.212045]  ? __virt_addr_valid+0xf3/0x170
> [   44.212045]  ? memcmp+0x8b/0xb0
> [   44.212045]  kasan_report+0xb2/0xe0
> [   44.212045]  ? memcmp+0x8b/0xb0
> [   44.212045]  kasan_check_range+0x39/0x1c0
> [   44.212045]  memcmp+0x8b/0xb0
> [   44.212045]  xfrm_state_walk+0x21c/0x420

...

> 
> By investigating the code, we find the root cause of this OOB is the lack
> of checks in xfrm_dump_sa(). The buggy code allows a malicious user to pass
> arbitrary value of filter->splen/dplen. Hence, with crafted xfrm states,
> the attacker can achieve 8 bytes heap OOB read, which causes info leak.
> 
>   if (attrs[XFRMA_ADDRESS_FILTER]) {
>     filter = kmemdup(nla_data(attrs[XFRMA_ADDRESS_FILTER]),
>         sizeof(*filter), GFP_KERNEL);
>     if (filter == NULL)
>       return -ENOMEM;
>     // NO MORE CHECKS HERE !!!
>   }
> 
> This patch fixes the OOB by adding necessary boundary checks, just like
> the code in pfkey_dump() function.
> 
> Fixes: d3623099d350 ("ipsec: add support of limited SA dump")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>

Applied, thanks a lot!

