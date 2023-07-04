Return-Path: <netdev+bounces-15280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7F8746922
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 07:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDBBA280D8E
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 05:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212B47FC;
	Tue,  4 Jul 2023 05:44:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156617ED
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 05:44:39 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2068CE72
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 22:44:37 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id DFBDF20764;
	Tue,  4 Jul 2023 07:44:35 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q83RvUBXojLu; Tue,  4 Jul 2023 07:44:35 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 6F39120520;
	Tue,  4 Jul 2023 07:44:35 +0200 (CEST)
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 6A13980004A;
	Tue,  4 Jul 2023 07:44:35 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 07:44:35 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 4 Jul
 2023 07:44:34 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 8EAC83182B55; Tue,  4 Jul 2023 07:44:34 +0200 (CEST)
Date: Tue, 4 Jul 2023 07:44:34 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Lin Ma <linma@zju.edu.cn>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <salyzyn@android.com>
Subject: Re: [PATCH v1] net: af_key: fix sadb_x_filter validation
Message-ID: <ZKOxwmDpdA+kx/Cy@gauss3.secunet.de>
References: <20230627033954.1181380-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230627033954.1181380-1-linma@zju.edu.cn>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 27, 2023 at 11:39:54AM +0800, Lin Ma wrote:
> When running xfrm_state_walk_init(), the xfrm_address_filter being used
> is okay to have a splen/dplen that equals to sizeof(xfrm_address_t)<<3.
> This commit replaces >= to > to make sure the boundary checking is
> correct.
> 
> Fixes: 37bd22420f85 ("af_key: pfkey_dump needs parameter validation")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>

Also applied, thanks!

