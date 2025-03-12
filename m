Return-Path: <netdev+bounces-174279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01007A5E1E1
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 17:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F3943A5925
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 16:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3221D5CCC;
	Wed, 12 Mar 2025 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HIfLriYb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88B51D5176
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741797444; cv=none; b=c7FDu3C8GMlTSpmW6zOorPR82XoG8OipkOIpFsKlbt86kgsQk/YI16qGMkAjK2nq7bm5dUfuw0Azp3hTePt6gVaMn0CQGZoTJAwOQoKFO30sGe0zgwoPwFz9lebo+V/+Mfwg5RUKGy7m1L6+xyYO06sYL/zw6NbSki8fcsAQPnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741797444; c=relaxed/simple;
	bh=rxN3Cc4wxvpQIqhjZrJks7Nx/9hBcB5mPu2JMBFeq0U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q0I/RkZFHevv+LOJmnoO5y2d5vDkburM1weywlqEswSHSL92mJDey0TkwPtsekCm0HI5x3ud3VKTw5prIBu45oWo2tneFAuNjqJZgJjfCteMv0qRIczouMqjYXOQLivpbvgCkEee7/KbbxVf87X8PXeyyMtAbCrrvqLJ0fLaa9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HIfLriYb; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741797443; x=1773333443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vYYqiHxAm5zED5GN7fCXLz94FuRDNESO047SLJFc6Ak=;
  b=HIfLriYbVcV/KjsxK5r2LTG0u6mMgnTsu9dYy0lc+T/RRTGXHJ6LyHqA
   hecSVQ6DSK+79Ea9aTR4v5fu0vmdcI28HnBE9JOz68P6LArIWK44fK0RG
   2D8+alBmyyF2Vp2D9tf5/NiPhPEMUz5Dy4N5uTQY+3uoYT8ArSy/xyYvB
   w=;
X-IronPort-AV: E=Sophos;i="6.14,242,1736812800"; 
   d="scan'208";a="704488143"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 16:37:18 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:65505]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.127:2525] with esmtp (Farcaster)
 id fd56a6ab-abb2-4278-8b5e-d7d105877d91; Wed, 12 Mar 2025 16:37:18 +0000 (UTC)
X-Farcaster-Flow-ID: fd56a6ab-abb2-4278-8b5e-d7d105877d91
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 12 Mar 2025 16:37:09 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.160.2) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 12 Mar 2025 16:37:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <nicolas.morey@suse.com>
CC: <edumazet@google.com>, <netdev@vger.kernel.org>, <kuniyu@amazon.com>
Subject: Re: [RFC PATCH] net: enable SO_REUSEPORT for AF_TIPC sockets
Date: Wed, 12 Mar 2025 09:35:16 -0700
Message-ID: <20250312163652.83267-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <dec1f621-a770-4c9a-89e9-e0f26ab470e2@suse.com>
References: <dec1f621-a770-4c9a-89e9-e0f26ab470e2@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA003.ant.amazon.com (10.13.139.31) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Nicolas Morey <nicolas.morey@suse.com>
Date: Wed, 12 Mar 2025 14:48:01 +0100
> Commit 5b0af621c3f6 ("net: restrict SO_REUSEPORT to inet sockets") disabled
> SO_REUSEPORT for all non inet sockets, including AF_TIPC sockets which broke
> one of our customer applications.
> Re-enable SO_REUSEPORT for AF_TIPC to restore the original behaviour.

AFAIU, AF_TIPC does not actually implement SO_REUSEPORT logic, no ?
If so, please tell your customer not to set it on AF_TIPC sockets.

There were similar reports about AF_VSOCK and AF_UNIX, and we told
that the userspace should not set SO_REUSEPORT for such sockets
that do not support the option.

https://lore.kernel.org/stable/CAGxU2F57EgVGbPifRuCvrUVjx06mrOXNdLcPdqhV9bdM0VqGvg@mail.gmail.com/
https://github.com/amazonlinux/amazon-linux-2023/issues/901


> 
> Fixes: 5b0af621c3f6 ("net: restrict SO_REUSEPORT to inet sockets")
> Signed-off-by: Nicolas Morey <nmorey@suse.com>
> ---
>  include/net/sock.h | 5 +++++
>  net/core/sock.c    | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 7ef728324e4e..d14f6ffedcd5 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2755,6 +2755,11 @@ static inline bool sk_is_vsock(const struct sock *sk)
>  	return sk->sk_family == AF_VSOCK;
>  }
>  
> +static inline bool sk_is_tipc(const struct sock *sk)
> +{
> +	return sk->sk_family == AF_TIPC;
> +}
> +
>  /**
>   * sk_eat_skb - Release a skb if it is no longer needed
>   * @sk: socket to eat this skb from
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 6c0e87f97fa4..d4ad4cdff997 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1300,7 +1300,7 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
>  		sk->sk_reuse = (valbool ? SK_CAN_REUSE : SK_NO_REUSE);
>  		break;
>  	case SO_REUSEPORT:
> -		if (valbool && !sk_is_inet(sk))
> +		if (valbool && !sk_is_inet(sk) && !sk_is_tipc(sk))
>  			ret = -EOPNOTSUPP;
>  		else
>  			sk->sk_reuseport = valbool;
> -- 
> 2.45.2

