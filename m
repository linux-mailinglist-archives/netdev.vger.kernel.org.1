Return-Path: <netdev+bounces-82249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC00B88CF25
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 21:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7197C1F2BE00
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 20:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6EB13D625;
	Tue, 26 Mar 2024 20:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YX2qOSFh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21EA13D288
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 20:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485414; cv=none; b=cI1HnrM3bj1xBHEYQSe75rD4xkqtMru/z2SsZjRXep2hLSVjWPsY5x1qHSP5WLZC2LRSagcKIVegzo/kU6eSbgN6bnU7WW3jbC95d512EiNTybBNf9hEWVNhH67WVaHReqzJ6MUcUClCtR+XxDFARUqy78SZ1N2RDIpr8fcrIV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485414; c=relaxed/simple;
	bh=hIjmfIxlhluHAXxPJGMSDk0jEKwRX27qsDTjMFV7tkU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hBzswmIlAjH/USP/1KXPlaAmptyPaMY8AYugcsjLyG0cqltoR3PFKnAIO3hmVE9yRQYWkmXX8UFKW+tzEKMKSxLMYvvzm2fqmgGBx/AwpWgEnYrM0XGF5ve+2INCWXRPRpUvQWpWMJUGkE1Q1saGI7D42eLfgsA4PWp8sWhsbYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=YX2qOSFh; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711485413; x=1743021413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x7AenKYxPLEjOsFmHzhTV+WuSCqgfVBWu+5O7Ui7Slk=;
  b=YX2qOSFhaeDPZa6lsR/SWTaPD8cmeEngjBoiRO6ffbEVwNLIsJNvlmeP
   LDRGgdCIRavnwzAG0nzMezYUgK7tzNwyuOCP3Hs1+tY4QrGn0uUduxx5Z
   QtZjh4/6If2H/q9sggKUi23zbSxkVj/U8xeea4NTk4rIKcN9gCfhF1Kn4
   0=;
X-IronPort-AV: E=Sophos;i="6.07,157,1708387200"; 
   d="scan'208";a="284037498"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 20:36:51 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:60649]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.164:2525] with esmtp (Farcaster)
 id 895b6736-bd1d-4afd-9845-b24dd50a93e2; Tue, 26 Mar 2024 20:36:50 +0000 (UTC)
X-Farcaster-Flow-ID: 895b6736-bd1d-4afd-9845-b24dd50a93e2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 26 Mar 2024 20:36:49 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.23) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Tue, 26 Mar 2024 20:36:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <lucien.xin@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <joannelkoong@gmail.com>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<kuniyu@amazon.com>
Subject: Re: [PATCH net] net: fix the any addr conflict check in inet_bhash2_addr_any_conflict
Date: Tue, 26 Mar 2024 13:36:37 -0700
Message-ID: <20240326203637.50709-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20eee0606b06a3e0ec7d90a4cb24a86a1905d4df.1711478269.git.lucien.xin@gmail.com>
References: <20eee0606b06a3e0ec7d90a4cb24a86a1905d4df.1711478269.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA001.ant.amazon.com (10.13.139.101) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 26 Mar 2024 14:37:49 -0400
> Xiumei reported a socket bind issue with this python script:
> 
>   from socket import *
> 
>   s_v41 = socket(AF_INET, SOCK_STREAM)
>   s_v41.bind(('0.0.0.0', 5901))
> 
>   s_v61 = socket(AF_INET6, SOCK_STREAM)
>   s_v61.setsockopt(IPPROTO_IPV6, IPV6_V6ONLY, 1)
>   s_v61.bind(('::', 5901))
> 
>   s_v42 = socket(AF_INET, SOCK_STREAM)
>   s_v42.bind(('localhost', 5901))
> 
> where s_v42.bind() is expected to fail.

Hi,

I posted a similar patch yesterday, which needs another round due to
build error by another patch though.
https://lore.kernel.org/netdev/20240325181923.48769-3-kuniyu@amazon.com/

So, let me repost this series.

Thanks!


> 
> However, in this case s_v41 and s_v61 are linked to different buckets and
> these buckets are linked into the same bhash2 chain where s_v61's buckets
> is ahead of s_v41's. When doing the ANY addr conflict check with s_v42 in
> inet_bhash2_addr_any_conflict(), it breaks the bhash2 chain traverse after
> matching s_v61 by inet_bind2_bucket_match_addr_any(), but never gets a
> chance to match s_v41. Then s_v42.bind() works as ipv6only is set on s_v61
> and inet_bhash2_conflict() returns false.
> 
> This patch fixes the issue by NOT breaking the bhash2 chain traverse until
> both inet_bind2_bucket_match_addr_any() and inet_bhash2_conflict() return
> true.
> 
> Fixes: 28044fc1d495 ("net: Add a bhash2 table hashed by port and address")
> Reported-by: Xiumei Mu <xmu@redhat.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---
>  net/ipv4/inet_connection_sock.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index c038e28e2f1e..a3188f90210b 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -299,14 +299,12 @@ static bool inet_bhash2_addr_any_conflict(const struct sock *sk, int port, int l
>  
>  	spin_lock(&head2->lock);
>  
> -	inet_bind_bucket_for_each(tb2, &head2->chain)
> -		if (inet_bind2_bucket_match_addr_any(tb2, net, port, l3mdev, sk))
> -			break;
> -
> -	if (tb2 && inet_bhash2_conflict(sk, tb2, uid, relax, reuseport_cb_ok,
> -					reuseport_ok)) {
> -		spin_unlock(&head2->lock);
> -		return true;
> +	inet_bind_bucket_for_each(tb2, &head2->chain) {
> +		if (inet_bind2_bucket_match_addr_any(tb2, net, port, l3mdev, sk) &&
> +		    inet_bhash2_conflict(sk, tb2, uid, relax, reuseport_cb_ok, reuseport_ok)) {
> +			spin_unlock(&head2->lock);
> +			return true;
> +		}
>  	}
>  
>  	spin_unlock(&head2->lock);
> -- 
> 2.43.0

