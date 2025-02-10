Return-Path: <netdev+bounces-164524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A894A2E1BA
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 01:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904551885E92
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 00:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E80F2C9A;
	Mon, 10 Feb 2025 00:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VSqyogIy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2BF186A;
	Mon, 10 Feb 2025 00:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739147211; cv=none; b=YLLf8/3C8h2S1QmYpeOsu2i2nv3DgcPRii+Vq8CaAj42y3XRe+YWBUqOAt2UW/x9Aw0RKcYko041ux0yQzCo2hnoyGVZCelPuyUE2/w1keLh7QmBG2Ng/2DUjlRhGqgZ4OikdtWWsxjPn/iFlAPYfAyeOQGLg6tEtxt5CPtBnPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739147211; c=relaxed/simple;
	bh=4ixP4rHXERZI+Nh/y2rKjcZvz0aVswCEPpsFqH5/RyA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=apXBTqQjG6e3/h/xee7LLpwuwgK4/++OcMaMnlHEsGGGzidvC7wQGUG5/xP/IZiS7kQirUh4t3LFlYq54oE/lpey0jLJ8MKkRFkBcIpJgITVAehiWVqzIbiAwM2xIpaNVfZZz+oNnRpacqNugaS+5kOpdwEh2zsxn3DF5WMBXiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=VSqyogIy; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739147210; x=1770683210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iD3tjeGDoU7JwTHL1VsQbg5J8FMVxUEkRHvXxPnkyjA=;
  b=VSqyogIyNS8fXN+PrU7VhZT3dixka+sEaz6QJhDwIIO4so0DxgG2kRGG
   6BeTUViagIg5Iz0E6DqjaiN+xggqfPm/t4L4SfIEsOIkf7tFs5LrktuuS
   PgroMq/tKplZ1MWMn+3MRSVZk07kudELkPRfCl3A9RDk1nzlTGWV0LO3N
   8=;
X-IronPort-AV: E=Sophos;i="6.13,273,1732579200"; 
   d="scan'208";a="465431182"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 00:26:47 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:39422]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.183:2525] with esmtp (Farcaster)
 id d5f2f18c-39a2-4e94-8a13-f9a474d88df0; Mon, 10 Feb 2025 00:26:45 +0000 (UTC)
X-Farcaster-Flow-ID: d5f2f18c-39a2-4e94-8a13-f9a474d88df0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 10 Feb 2025 00:26:45 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 10 Feb 2025 00:26:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <purvayeshi550@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <skhan@linuxfoundation.org>
Subject: Re: [PATCH] net: unix: Fix undefined 'other' error
Date: Mon, 10 Feb 2025 09:26:32 +0900
Message-ID: <20250210002632.48499-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250209184355.16257-1-purvayeshi550@gmail.com>
References: <20250209184355.16257-1-purvayeshi550@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA001.ant.amazon.com (10.13.139.100) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)


> [PATCH] net: unix: Fix undefined 'other' error

Please add net-next after PATCH and start with af_unix: as with
other commits when you post v2.

[PATCH net-next v2]: af_unix: ...


From: Purva Yeshi <purvayeshi550@gmail.com>
Date: Mon, 10 Feb 2025 00:13:55 +0530
> Fix issue detected by smatch tool:
> An "undefined 'other'" error occur in __releases() annotation.
> 
> The issue occurs because __releases(&unix_sk(other)->lock) is placed
> at the function signature level, where other is not yet in scope.
> 
> Fix this by replacing it with __releases(&u->lock), using u, a local
> variable, which is properly defined inside the function.

Tweaking an annotation with a comment for a static analyzer to fix
a warning for yet another static analyzer is too much.

Please remove sparse annotation instead.

Here's the only place where sparse is used in AF_UNIX code, and we
don't use sparse even for /proc/net/unix.


> 
> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
> ---
>  net/unix/af_unix.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 34945de1f..37b01605a 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1508,7 +1508,10 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
>  }
>  
>  static long unix_wait_for_peer(struct sock *other, long timeo)
> -	__releases(&unix_sk(other)->lock)
> +	/*
> +	 * Use local variable instead of function parameter
> +	 */
> +	__releases(&u->lock)
>  {
>  	struct unix_sock *u = unix_sk(other);
>  	int sched;
> -- 
> 2.34.1

