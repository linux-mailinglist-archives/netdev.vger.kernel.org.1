Return-Path: <netdev+bounces-107847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5236891C8E0
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 00:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E1FC285A9D
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 22:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCBD139579;
	Fri, 28 Jun 2024 21:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="J6wRXS0V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB61132137;
	Fri, 28 Jun 2024 21:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719611946; cv=none; b=XnaRDiLISUVH1FTKM9DkWt8rYcQ5DRVBjbqGK6ZNpOBZ+HZxedncfe2lT0ZZm6liyh9ZRhtgAfNUwreOapJIWIl5ki50H9ISfi35wEJdYebSh0sm0ufAbKa6xv0SDsV12zAIWllTtwpPsyZ0AQpeTaOzVhuDhqW8NCpZRl21U9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719611946; c=relaxed/simple;
	bh=WsGctvUmn/NBgviLVXG+Flw3SrMgqjpN1GgtNyuI/1w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a9mSb4i6U48372ng2J/HnRPfKfesE356w8EwgMVYGvwwzDOu0iZLln48YxfXSw0i+WLzalu8VKMPhcgwW6AHLb6aC++0E02jVVK9Cq1zUK+oKYscvF8Nji7Em6PHEKHPomnxz0xB4iVNUp/lZNIwygPNC8/XVlP3fSkfNFPCEd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=J6wRXS0V; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719611945; x=1751147945;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uCjFalF5iAJiliIOKWoazN20JiKQqCNnf5YmbPi7WRk=;
  b=J6wRXS0Vna8sQFf+It5T6jqtYJhDwQseKWQLtI/rnQePFhKaGEQav7pI
   9BA9xflAQDUh2j5Hghk9MZXvLUsYI3vhQO73DkQKKYlqqm5kWR3++6bbD
   dMGXkwuWJPIVDGcU1XyNBetGUd/9MpSTqHt66y1jjAhD/ax/y+4CerpIX
   M=;
X-IronPort-AV: E=Sophos;i="6.09,170,1716249600"; 
   d="scan'208,223";a="410856519"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 21:59:02 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:21200]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.200:2525] with esmtp (Farcaster)
 id 369b8cdd-cf63-406f-bbc9-cf5790991dd6; Fri, 28 Jun 2024 21:59:00 +0000 (UTC)
X-Farcaster-Flow-ID: 369b8cdd-cf63-406f-bbc9-cf5790991dd6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 28 Jun 2024 21:59:00 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 28 Jun 2024 21:58:57 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <cosiekvfj@o2.pl>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH] net/socket: clamp negative backlog value to 0 in listen()
Date: Fri, 28 Jun 2024 14:58:48 -0700
Message-ID: <20240628215848.99285-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240628172836.19213-1-cosiekvfj@o2.pl>
References: <20240628172836.19213-1-cosiekvfj@o2.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D032UWB004.ant.amazon.com (10.13.139.136) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From Kacper Piwiński <cosiekvfj@o2.pl>
Date: Fri, 28 Jun 2024 19:28:36 +0200
> According to manual: https://man7.org/linux/man-pages/man3/listen.3p.html
> If listen() is called with a backlog argument value that is less
> than 0, the function behaves as if it had been called with a
> backlog argument value of 0.

This breaks many applications that assume listen(fd, -1) configures
the backlog with the max value allowed in the netns.

The behaviour is useful especially in a container-like env where app
does not have access to procfs.

The man page should be updated instead.


> 
> Signed-off-by: Kacper Piwiński <cosiekvfj@o2.pl>
> ---
>  net/socket.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/socket.c b/net/socket.c
> index e416920e9..9567223d7 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -1873,8 +1873,7 @@ int __sys_listen(int fd, int backlog)
>  	sock = sockfd_lookup_light(fd, &err, &fput_needed);
>  	if (sock) {
>  		somaxconn = READ_ONCE(sock_net(sock->sk)->core.sysctl_somaxconn);
> -		if ((unsigned int)backlog > somaxconn)
> -			backlog = somaxconn;
> +		backlog = clamp(backlog, 0, somaxconn);
>  
>  		err = security_socket_listen(sock, backlog);
>  		if (!err)
> -- 

