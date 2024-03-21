Return-Path: <netdev+bounces-80942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B93881C0B
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 05:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4791F281C2F
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 04:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63E12B2F2;
	Thu, 21 Mar 2024 04:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ordBNsFD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F0B6FBF
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 04:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710996951; cv=none; b=nO5alfEnoBwaGWhkzUmtM3ORaTXVExe1NupPt1gKgV6rri4aw3dFI/u8SlSfaj9ukxV2MShGTBi7FImUgub3/memUGqE5UZdNawhLDz/Evmdba4zwbKHD5W/wVqJ+MIam0iko6nhsc6fFIzxtiFelmhdqKquFMD3kVQtYu9oTZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710996951; c=relaxed/simple;
	bh=6mACmpXtfdM2gRaP9DlRc9Vx5ZIYiTSdlF4MOWMgE7c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKavGCAa/2Jd7khYcqgXrmgXFJ25+jpDXFOG/5D35J+aLwdw3gGzFqv+AD3xRF7yKr6Jeo8kJRw1rk9ARmFpQ28Blg9i9xAFI5q6s1qN/h2pHG694tzm8CeIsb2z+87632xYdLY9idNXdxM20IOMDtDLcJSBQPGVRyhkvCPHQu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ordBNsFD; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1710996949; x=1742532949;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EfVDoBqvRAn4r0scw3KAXz/i/86/iBNxsty+MfPdbN8=;
  b=ordBNsFDsbN00mThRO31aWMUKRlXSo0bFThD6dDRF1kEuHKxgBF91tNK
   zKLQ4ZvjoWEXeVcfFOusgYlTs3IhMK2vhpqn6nkqN6DYVAQ9MPiUOFwK6
   FnYFfIqdqv7ZMtgGK4/7DEFh+ld7juVEYp9tUv/pyWU1ukNuC8NNIFXdI
   Q=;
X-IronPort-AV: E=Sophos;i="6.07,142,1708387200"; 
   d="scan'208";a="389325371"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 04:55:46 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:5666]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.170:2525] with esmtp (Farcaster)
 id d2a598df-4651-4d4a-a354-aac3f9142741; Thu, 21 Mar 2024 04:55:45 +0000 (UTC)
X-Farcaster-Flow-ID: d2a598df-4651-4d4a-a354-aac3f9142741
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 21 Mar 2024 04:55:44 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 21 Mar 2024 04:55:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <wujianguo106@163.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH] tcp: Fix inet_bind2_bucket_match_addr_any() regression
Date: Wed, 20 Mar 2024 21:55:33 -0700
Message-ID: <20240321045533.8446-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <23b5678b-1e5a-be6c-ea68-b7a20dff4bbc@163.com>
References: <23b5678b-1e5a-be6c-ea68-b7a20dff4bbc@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Hi,

Thanks for the patch.

From: Jianguo Wu <wujianguo106@163.com>
Date: Thu, 21 Mar 2024 11:02:36 +0800
> From: Jianguo Wu <wujianguo@chinatelecom.cn>
> 
> If we bind() a TCPv4 socket to 0.0.0.0:8090, then bind() a TCPv6(ipv6only) socket

Please wrap each line at <75 characters except for logs/output like below.


> to :::8090, both without SO_REUSEPORT, then bind() 127.0.0.1:8090, it should fail

[::]:8090 is easier to read and the recommended way.
https://datatracker.ietf.org/doc/html/rfc5952#section-6

But please keep the netstat output as is.

> but now succeeds. like this:
>   tcp        0      0 127.0.0.1:8090          0.0.0.0:*               LISTEN
>   tcp        0      0 0.0.0.0:8090            0.0.0.0:*               LISTEN
>   tcp6       0      0 :::8090                 :::*                    LISTEN
> 
> bind() 0.0.0.0:8090, :::8090 and ::1:8090 are all fail.

What do you mean by all fail ?
At least, [::1]:8090 would fail with the current code in this case.


> But if we bind() a TCPv6(ipv6only) socket to :::8090 first, then  bind() a TCPv4
> socket to 0.0.0.0:8090, then bind() 127.0.0.1:8090, 0.0.0.0:8090, :::8090 and ::1:8090 are all fail.
> 
> When bind() 127.0.0.1:8090, inet_bind2_bucket_match_addr_any() will return true as tb->addr_type == IPV6_ADDR_ANY,

Let's use tb2 here for inet_bind2_bucket.. yes it's not consistent
in some functions like inet_bind2_bucket_match_addr_any() though.


> and tb is refer to the TCPv6 socket(:::8090), then inet_bhash2_conflict() return false, That is, there is no conflict,

Also make it clear that the TCPv6 socket is ipv6only one.


> so bind() succeeds.
> 
>   inet_bhash2_addr_any_conflict()
>   {
> 	inet_bind_bucket_for_each(tb2, &head2->chain)
> 		// tb2 is IPv6
> 		if (inet_bind2_bucket_match_addr_any(tb2, net, port, l3mdev, sk))
> 			break;
> 
> 	// inet_bhash2_conflict() return false
> 	if (tb2 && inet_bhash2_conflict(sk, tb2, uid, relax, reuseport_cb_ok,
>                                 reuseport_ok)) {
> 		spin_unlock(&head2->lock);
> 		return true;
> 	}
> 
>   }
> 
> Fixes: 5a22bba13d01 ("tcp: Save address type in inet_bind2_bucket.")

This is not the commit that introduced the regression.

Also, you need Signed-off-by tag here.


> ---
>  net/ipv4/inet_hashtables.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index 7498af320164..3eeaca8a113f 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -830,8 +830,8 @@ bool inet_bind2_bucket_match_addr_any(const struct inet_bind2_bucket *tb, const
>  		return false;
> 
>  #if IS_ENABLED(CONFIG_IPV6)
> -	if (tb->addr_type == IPV6_ADDR_ANY)
> -		return true;
> +	if (sk->sk_family == AF_INET6)
> +		return tb->addr_type == IPV6_ADDR_ANY;

This fix is not correct and will break v4-mapped-v6 address cases.
You can run bind_wildcard under the selftest directory.

Probably we need v6_only bit in tb2 and should add some test cases
in the selftest.


> 
>  	if (tb->addr_type != IPV6_ADDR_MAPPED)
>  		return false;

