Return-Path: <netdev+bounces-145975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8722D9D1785
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 19:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 413571F21FEF
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 18:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDAC1D31A5;
	Mon, 18 Nov 2024 18:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="eZ36jf8e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BC01D3187
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731952901; cv=none; b=O1ChUcWfyMAFLQBUS4Xx9JiwggqerE8jFIHasLrS2Mo56841VW4jqYShB0sxtBi96yB6BhSnsiiVK43XVZ9JQeU1RDgLvkbZE0ucriWXbdb7M260Sm5jvo8hxLSiW7kdmChXHjx422PPiYocjhf38m8ioVOkVQJ8PUqsCRtHqME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731952901; c=relaxed/simple;
	bh=kKXxOvOuMbcn5TvZNLFBzsciOuuohUi9l90aLMesxFI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K9hQ7dEOMABZR4ABDTK+vsbUFs2BEtSHg8VFX4ii+iltLJPQZmabjGehECn3ZYSTPsVHHRleOMPu/RvvBQXCdUqhg7umP8kqjLxmgq+xqV+DHjwf4C7Rt+rydDKoBCQ9EbZX5Z9Xvge0ZOdRHwUPAhSIW4HG697T4McUySXd8aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=eZ36jf8e; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731952901; x=1763488901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zOT7rxVnHSPFhVfeO5OSkM8KkK+Hai5FU+OGXIytGUc=;
  b=eZ36jf8erqWj4kcNYo6HpB5i4RqClc5e4eoSed+JTMjNcFZCDacHEWc2
   w/gksy1Ila/nRqzmRlZXpqNhBqgeMTNecq/zONnJszHlobwWwzyDnJAwl
   UCAtJ38GkTVB+0XfBNfq8++4BrkDWCrZVvH8rBJMLyowwx+yV+oHqyK2U
   s=;
X-IronPort-AV: E=Sophos;i="6.12,164,1728950400"; 
   d="scan'208";a="776665117"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 18:01:40 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:63551]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.223:2525] with esmtp (Farcaster)
 id a9e58ca9-41ea-4e54-9d36-ed7cbae1964f; Mon, 18 Nov 2024 18:01:39 +0000 (UTC)
X-Farcaster-Flow-ID: a9e58ca9-41ea-4e54-9d36-ed7cbae1964f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 18 Nov 2024 18:01:39 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.15) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 18 Nov 2024 18:01:36 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <donald.hunter@gmail.com>
CC: <davem@davemloft.net>, <donald.hunter@redhat.com>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1] net: af_unix: clean up spurious drop reasons
Date: Mon, 18 Nov 2024 10:01:33 -0800
Message-ID: <20241118180133.54735-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241116094236.28786-1-donald.hunter@gmail.com>
References: <20241116094236.28786-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA004.ant.amazon.com (10.13.139.16) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Donald Hunter <donald.hunter@gmail.com>
Date: Sat, 16 Nov 2024 09:42:36 +0000
> Use consume_skb() instead of kfree_skb() in the happy paths to clean up

Both are the unhappy paths and kfree_skb() should be used.

I have some local patches for drop reasons for AF_UNIX and
can post them after net-next is open if needed.


> spurious NOT_SPECIFIED drop reasons.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>  net/unix/af_unix.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 001ccc55ef0f..90bb8556ea04 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1705,7 +1705,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
>  		unix_state_unlock(other);
>  
>  out:
> -	kfree_skb(skb);
> +	consume_skb(skb);
>  	if (newsk)
>  		unix_release_sock(newsk, 0);
>  	if (other)
> @@ -2174,7 +2174,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
>  		unix_state_unlock(sk);
>  	unix_state_unlock(other);
>  out_free:
> -	kfree_skb(skb);
> +	consume_skb(skb);
>  out:
>  	if (other)
>  		sock_put(other);
> -- 
> 2.47.0

