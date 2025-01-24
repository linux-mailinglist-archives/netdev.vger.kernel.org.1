Return-Path: <netdev+bounces-160701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A0AA1AE73
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 03:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE50188DA8F
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 02:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0E21D5149;
	Fri, 24 Jan 2025 02:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="A52YqBRy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6E4288B1;
	Fri, 24 Jan 2025 02:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737684690; cv=none; b=mnAI/Scft8w78tUPimznfahowVT/edvHMBjd+HHK7jYCrrow0fmc+53vZTw663DP7pFk9/ZjTGdqRlnsxsKMrDBDW4tT91x6ZrOkVnQKfd4eO9XpLqU3G8rZjY34SCyoPlowAuU/EZXZ5Wzb0P9tqORfORvaNrulHB/RJsH+00c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737684690; c=relaxed/simple;
	bh=x0gQVnL4N9GeuR+8n7+KTl0bPAD+unS6R7D8pWQKQCY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cvt9djUdAU9RJqKStR3RJXjLKMGu3+GxlJ1S5l2uyR2r87r6HkC7VE0mKKS/VPMCli1s+19t1/KB5zD/WDQDBMJBxFMdakNXcTj81/RrFxdcNNe0Cf6Sb4ut0FnsTJHoOxDS7BS/lOfPs3hL1it8PAdY/CqXlJuX+cPZ5VathDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=A52YqBRy; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737684689; x=1769220689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=32mukYRENfgBKxOGe1gc6rGiCgwXQF50LrVwQ37R06U=;
  b=A52YqBRyqw1iwm6yooqLqen76QzeFjxK+QvYFfmG2nDdg2YY8M/CBZij
   OYLswYJnRegZ5E4kHXdE/RpQdh3ifITKl6EpbdEp5DK73v0mjwsZYJBLc
   O/2galmMUy9W2emPEhNC8cg9xcHntIt63K+dZez5Cx2IWLLK5gnRd7ARu
   A=;
X-IronPort-AV: E=Sophos;i="6.13,230,1732579200"; 
   d="scan'208";a="456638207"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 02:11:25 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:38870]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.215:2525] with esmtp (Farcaster)
 id a091e6a0-ea6f-4489-8d22-ce36610a777c; Fri, 24 Jan 2025 02:11:24 +0000 (UTC)
X-Farcaster-Flow-ID: a091e6a0-ea6f-4489-8d22-ce36610a777c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 24 Jan 2025 02:11:23 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 24 Jan 2025 02:11:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <buaajxlj@163.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <liangjie@lixiang.com>,
	<linux-kernel@vger.kernel.org>, <mhal@rbox.co>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net] af_unix: Correct comment to reference kfree_skb_reason hook
Date: Thu, 23 Jan 2025 18:11:13 -0800
Message-ID: <20250124021113.63475-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250124015106.2226585-1-buaajxlj@163.com>
References: <20250124015106.2226585-1-buaajxlj@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Liang Jie <buaajxlj@163.com>
Date: Fri, 24 Jan 2025 09:51:06 +0800
> From: Liang Jie <liangjie@lixiang.com>
> 
> The comment in unix_release_sock has been updated to correctly reference
> kfree_skb_reason instead of kfree_skb, for clarity on how passed file
> descriptors are handled during socket closure.
> 
> Fixes: c32f0bd7d483 ("af_unix: Set drop reason in unix_release_sock().")

This is net-next material and Fixes tag is not needed.

I don't think we need to update the comment though..

kfree_skb 'hook' generally means skb->destructor() and _reason is
not relevant here.

kfree_skb
  kfree_skb_reason
    sk_skb_reason_drop
      __kfree_skb
        skb_release_all
          skb_release_head_state
            skb->destructor / unix_destruct_scm <--


> Signed-off-by: Liang Jie <liangjie@lixiang.com>
> ---
>  net/unix/af_unix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 34945de1fb1f..47dd3749ce32 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -717,7 +717,7 @@ static void unix_release_sock(struct sock *sk, int embrion)
>  		if (state == TCP_LISTEN)
>  			unix_release_sock(skb->sk, 1);
>  
> -		/* passed fds are erased in the kfree_skb hook */
> +		/* passed fds are erased in the kfree_skb_reason hook */
>  		kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_CLOSE);
>  	}
>  
> -- 
> 2.25.1

