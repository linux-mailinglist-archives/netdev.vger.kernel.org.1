Return-Path: <netdev+bounces-32483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E7F797CE1
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 21:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 159101C20B24
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 19:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D453114017;
	Thu,  7 Sep 2023 19:40:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C806A125DB
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 19:40:15 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255441BD0
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 12:40:14 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 93CC720860;
	Thu,  7 Sep 2023 12:03:46 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uJcI929LY2R3; Thu,  7 Sep 2023 12:03:45 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id EBDB42085A;
	Thu,  7 Sep 2023 12:03:45 +0200 (CEST)
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id E57D180004A;
	Thu,  7 Sep 2023 12:03:45 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Sep 2023 12:03:45 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 7 Sep
 2023 12:03:45 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 33BD23182CBA; Thu,  7 Sep 2023 12:03:45 +0200 (CEST)
Date: Thu, 7 Sep 2023 12:03:45 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Eric Dumazet <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<eric.dumazet@gmail.com>, syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH net] xfrm: interface: use DEV_STATS_INC()
Message-ID: <ZPmgATtllOhTe2IU@gauss3.secunet.de>
References: <20230905132303.1927206-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230905132303.1927206-1-edumazet@google.com>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 05, 2023 at 01:23:03PM +0000, Eric Dumazet wrote:
> syzbot/KCSAN reported data-races in xfrm whenever dev->stats fields
> are updated.
> 
> It appears all of these updates can happen from multiple cpus.
> 
> Adopt SMP safe DEV_STATS_INC() to update dev->stats fields.
> 
> BUG: KCSAN: data-race in xfrmi_xmit / xfrmi_xmit
> 

...

> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 23987 Comm: syz-executor.5 Not tainted 6.5.0-syzkaller-10885-g0468be89b3fa #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
> 
> Fixes: f203b76d7809 ("xfrm: Add virtual xfrm interfaces")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Steffen Klassert <steffen.klassert@secunet.com>

Applied to the ipsec tree, thanks Eric!

