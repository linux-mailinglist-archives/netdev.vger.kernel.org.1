Return-Path: <netdev+bounces-18213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4D0755D2C
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 09:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52FD28137C
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 07:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC11944C;
	Mon, 17 Jul 2023 07:42:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07CA848B
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 07:42:48 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE61E64
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 00:42:47 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E5FEA206F0;
	Mon, 17 Jul 2023 09:42:44 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iLFpdP3gRzHW; Mon, 17 Jul 2023 09:42:44 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 7266E204B4;
	Mon, 17 Jul 2023 09:42:44 +0200 (CEST)
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 6BBA580004A;
	Mon, 17 Jul 2023 09:42:44 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 09:42:44 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 17 Jul
 2023 09:42:43 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 8CB423182AC6; Mon, 17 Jul 2023 09:42:43 +0200 (CEST)
Date: Mon, 17 Jul 2023 09:42:43 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>
Subject: Re: [PATCH net 0/3] fix slab-use-after-free in decode_session6
Message-ID: <ZLTw83sGbWQ+bGMN@gauss3.secunet.de>
References: <20230710094053.3302181-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230710094053.3302181-1-shaozhengchao@huawei.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 05:40:50PM +0800, Zhengchao Shao wrote:
> When net device is configured with the qdisc of the sfb type, the cb
> field of the SKB is used in both enqueue and decode session of packets,
> and the fields overlap. When enqueuing packets, the cb field of skb is
> used as a hash array. Also it is used as the header offset when decoding
> session of skb. Therefore, it will cause slab-use-after-free in
> decode_session6.
> The cb field in the skb should not be used when sending packets. Set the
> cb field of skb to 0 before decoding skb.
> 
> Zhengchao Shao (3):
>   xfrm: fix slab-use-after-free in decode_session6
>   ip6_vti: fix slab-use-after-free in decode_session6
>   ip_vti: fix potential slab-use-after-free in decode_session6

Series applied, thanks a lot!

