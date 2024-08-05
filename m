Return-Path: <netdev+bounces-115849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3C89480C2
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 19:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A1C028435E
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 17:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2066115ECF2;
	Mon,  5 Aug 2024 17:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FMPrBdgW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FBD15F3E7
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722880520; cv=none; b=LFCU7N2gHogrAYDHWNu5STVnnDJKU83PoKQaGcHjemqYOOjSDDWA4IXiKE9NO9BVP+gWHBD6LuK3YrkBoI8RXAGLVbigRZ3vG+lFC0/9LS9tL8Xrp7me5ukOQADSBDFOzYRz0Br0qNwLiXzKrcJreK41yBfndgic6spCxbzywbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722880520; c=relaxed/simple;
	bh=FSEOA2YFn/I4JX/PrXX5uJ5H/uw/YcwDAXV78/fok+4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mn05M5b3kyBeVsGpuervmX/LRfAUvhVtW2R6JSLfxcTWEz1z3l5VWHv+nNRu02zEn97J+k7RkVbp0t6Z/dvXHtX/yWg85Y5v+jsgtJAX0RTHO0/POudVaCmA+VLL+JkNGhlhyL4KQtYBagZ8pte9JxgNbtuvKmRWOlPXZlwTRf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=FMPrBdgW; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722880518; x=1754416518;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yFu5M4lo9QCiHCf482xzAdwbYSxiiO3wJ3LFMfAxlZQ=;
  b=FMPrBdgWr+sAd4tVJntjhmY9LdL5Vk5hhf3aHlmvvLGU0FHsgRWMCfn3
   4TvNeChvm7VSP5EO2vEXNss1ois4WswNPX/iTmE8ebqsiYiLEB5z9KwYZ
   S/jNXu+w9ovxiIg7iHbrJKYUn8Z5jPb5rWeTTbKr2u3dan/BE6SSi0Kcs
   g=;
X-IronPort-AV: E=Sophos;i="6.09,265,1716249600"; 
   d="scan'208";a="747374628"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 17:55:11 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:48546]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.198:2525] with esmtp (Farcaster)
 id 3878ae3c-9cd6-4575-bad5-22123e09d58f; Mon, 5 Aug 2024 17:55:11 +0000 (UTC)
X-Farcaster-Flow-ID: 3878ae3c-9cd6-4575-bad5-22123e09d58f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 5 Aug 2024 17:55:08 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.23) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 5 Aug 2024 17:55:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <syzkaller@googlegroups.com>,
	<kuniyu@amazon.com>
Subject: Re: [PATCH net] net: linkwatch: use system_unbound_wq
Date: Mon, 5 Aug 2024 10:54:55 -0700
Message-ID: <20240805175455.69545-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240805085821.1616528-1-edumazet@google.com>
References: <20240805085821.1616528-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Mon,  5 Aug 2024 08:58:21 +0000
> linkwatch_event() grabs possibly very contended RTNL mutex.
> 
> system_wq is not suitable for such work.
> 
> Inspired by many noisy syzbot reports.
> 
> 3 locks held by kworker/0:7/5266:
>  #0: ffff888015480948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
>  #0: ffff888015480948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
>  #1: ffffc90003f6fd00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
>  , at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
>  #2: ffffffff8fa6f208 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:276
> 
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> ---
>  net/core/link_watch.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/link_watch.c b/net/core/link_watch.c
> index 8ec35194bfcb8574f53a9fd28f0cb2ebfe9a3f2e..ab150641142aa1545c71fc5d3b11db33c70cf437 100644
> --- a/net/core/link_watch.c
> +++ b/net/core/link_watch.c
> @@ -148,9 +148,9 @@ static void linkwatch_schedule_work(int urgent)
>  	 * override the existing timer.
>  	 */
>  	if (test_bit(LW_URGENT, &linkwatch_flags))
> -		mod_delayed_work(system_wq, &linkwatch_work, 0);
> +		mod_delayed_work(system_unbound_wq, &linkwatch_work, 0);
>  	else
> -		schedule_delayed_work(&linkwatch_work, delay);
> +		queue_delayed_work(system_unbound_wq, &linkwatch_work, delay);
>  }
>  
>  
> -- 
> 2.46.0.rc2.264.g509ed76dc8-goog

