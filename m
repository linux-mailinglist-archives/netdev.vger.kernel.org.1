Return-Path: <netdev+bounces-36076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D567ACF88
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 07:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id AB31128136F
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 05:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B18E6FC4;
	Mon, 25 Sep 2023 05:41:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312E46128
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 05:41:31 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49740BF;
	Sun, 24 Sep 2023 22:41:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 85EC6206DF;
	Mon, 25 Sep 2023 07:41:26 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 45rPA5a5YyjI; Mon, 25 Sep 2023 07:41:25 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 9780420547;
	Mon, 25 Sep 2023 07:41:25 +0200 (CEST)
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 8B52180004A;
	Mon, 25 Sep 2023 07:41:25 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 07:41:25 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 25 Sep
 2023 07:41:24 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id ACE343182ABF; Mon, 25 Sep 2023 07:41:24 +0200 (CEST)
Date: Mon, 25 Sep 2023 07:41:24 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Zhang Changzhong <zhangchangzhong@huawei.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Xin Long <lucien.xin@gmail.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] xfrm6: fix inet6_dev refcount underflow problem
Message-ID: <ZREdhN1hl6+6Eic2@gauss3.secunet.de>
References: <1694776841-30837-1-git-send-email-zhangchangzhong@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1694776841-30837-1-git-send-email-zhangchangzhong@huawei.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 07:20:41PM +0800, Zhang Changzhong wrote:
> There are race conditions that may lead to inet6_dev refcount underflow
> in xfrm6_dst_destroy() and rt6_uncached_list_flush_dev().
> 
> One of the refcount underflow bugs is shown below:
> 	(cpu 1)                	|	(cpu 2)
> xfrm6_dst_destroy()             |
>   ...                           |
>   in6_dev_put()                 |
> 				|  rt6_uncached_list_flush_dev()
>   ...				|    ...
> 				|    in6_dev_put()
>   rt6_uncached_list_del()       |    ...
>   ...                           |
> 
> xfrm6_dst_destroy() calls rt6_uncached_list_del() after in6_dev_put(),
> so rt6_uncached_list_flush_dev() has a chance to call in6_dev_put()
> again for the same inet6_dev.
> 
> Fix it by moving in6_dev_put() after rt6_uncached_list_del() in
> xfrm6_dst_destroy().
> 
> Fixes: 510c321b5571 ("xfrm: reuse uncached_list to track xdsts")
> Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>

Applied, thanks a lot!

