Return-Path: <netdev+bounces-136019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB07A99FFB9
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 05:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2958C1C23A74
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 03:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C2A17BEC7;
	Wed, 16 Oct 2024 03:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vAcWlVyk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EF1157494;
	Wed, 16 Oct 2024 03:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729050728; cv=none; b=Ztt3NGMl//8RgmCHrKnbRvQK9AHxwzeP97+xHaTxQn2Q/c0fcP7+9GALzR1MhUnVP/Xw+2TAP/NEcO+yxfGPbnhqn5oFgAuYn45e/LU4e+KdVxPXrfL/ZTvMf6/hb+jHZzHTV5Bsz3ioSCI5qBdzYsVIGRpbQuShrkYdZHhk9JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729050728; c=relaxed/simple;
	bh=ziDJPavYcVsD1cgAGpvgxWlLcnRPyclAPryccHXqWhU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rKr3dswJJs/+mRJePNH+wFRVAyBhYvYP1W7Nu8ngJ5jVWThGvdntVOOUlXbPrH/sKDf/RWzVHAMxhzIY4ydIyDuLWkEEvG33PpemiN6xeEewVN33/jDtds2WUKtGAmlZCcCh/OCflBJfg1V/ZhUgp0UfqnXhJaM4eN0l1FdW+vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=vAcWlVyk; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729050727; x=1760586727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3DstIncm6J0HFT7bC1fzVupVBQQzm9pdIktli+aHGoc=;
  b=vAcWlVyk+wAZtmpHe8v0tP6r7GOpE6twfMxuowcHXuBsX+Lonf5mV+Q7
   Z1JcH4BC6vMu+KdzUluWwiDxG6iEM36+/PQD4QTaqC4PemUaS2ASqHwDP
   AUvyUHcrX3z8IvpPQ9ggL6gjizPdVj029Ynr2Cl9OqD1JrwgOdFUt7N3Z
   k=;
X-IronPort-AV: E=Sophos;i="6.11,207,1725321600"; 
   d="scan'208";a="687905674"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 03:52:03 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:13756]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.250:2525] with esmtp (Farcaster)
 id 1c03cd7e-98db-4ed9-bf6a-a790882ad3a4; Wed, 16 Oct 2024 03:52:02 +0000 (UTC)
X-Farcaster-Flow-ID: 1c03cd7e-98db-4ed9-bf6a-a790882ad3a4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 16 Oct 2024 03:52:02 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 16 Oct 2024 03:51:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gustavoars@kernel.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kees@kernel.org>, <kuba@kernel.org>, <linux-hardening@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH 5/5][next] uapi: net: Avoid -Wflex-array-member-not-at-end warnings
Date: Tue, 15 Oct 2024 20:51:54 -0700
Message-ID: <20241016035154.91327-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <d64af418459145b7d8eb94cd300fb4b7d2659a3c.1729037131.git.gustavoars@kernel.org>
References: <d64af418459145b7d8eb94cd300fb4b7d2659a3c.1729037131.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB003.ant.amazon.com (10.13.139.172) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Date: Tue, 15 Oct 2024 18:33:23 -0600
> diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
> index b068651984fe..aac82a4af36f 100644
> --- a/net/appletalk/ddp.c
> +++ b/net/appletalk/ddp.c
> @@ -1832,7 +1832,7 @@ static int atalk_compat_routing_ioctl(struct sock *sk, unsigned int cmd,
>  	struct rtentry rt;
>  
>  	if (copy_from_user(&rt.rt_dst, &ur->rt_dst,
> -			3 * sizeof(struct sockaddr)) ||
> +			3 * sizeof(struct sockaddr_legacy)) ||

While at it, please fix the indent.


>  	    get_user(rt.rt_flags, &ur->rt_flags) ||
>  	    get_user(rt.rt_metric, &ur->rt_metric) ||
>  	    get_user(rt.rt_mtu, &ur->rt_mtu) ||
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index b24d74616637..75bd15d884e3 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -1021,7 +1021,7 @@ static int inet_compat_routing_ioctl(struct sock *sk, unsigned int cmd,
>  	struct rtentry rt;
>  
>  	if (copy_from_user(&rt.rt_dst, &ur->rt_dst,
> -			3 * sizeof(struct sockaddr)) ||
> +			3 * sizeof(struct sockaddr_legacy)) ||

Same here.

Otherwise looks good to me.

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


>  	    get_user(rt.rt_flags, &ur->rt_flags) ||
>  	    get_user(rt.rt_metric, &ur->rt_metric) ||
>  	    get_user(rt.rt_mtu, &ur->rt_mtu) ||

