Return-Path: <netdev+bounces-183942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B00A92D17
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 00:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3013A62DF
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 22:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B8D20E71E;
	Thu, 17 Apr 2025 22:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DM/GnyzB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCBE15F41F;
	Thu, 17 Apr 2025 22:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744927304; cv=none; b=bBvkExpE7vJUomI7MeF9iPpcg/WBj1+ZkZQvEX3Muo1lzwVL1GwR05whDx5bk0FSBV7mWRdldr+18U6wQDD/eNr8HNL4xv5mqWFt4ozMBuzDZ3EM2DCtURX20/5b5bYHOls7d35tGunFHKkPnK60AiYyOvX9g9GCPb3lHui6gdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744927304; c=relaxed/simple;
	bh=OaXB4fLPHtrHN4grz6cdFv8ey7snuB80R+wmzvAR9Vs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XqBMj86XaeLGHkpufwNBw6pPzWwKT2JcxoyzrfBn4oH5Ha84cM5bAmlfd7gV8ihEX7IEUZFVE7ISiFhlcGaldujLTuiv08RthiQ/G8a9tSWkudyQs6UY+yAV0Nbb6Hq9Zqi5zg/GnFPm2pc8duZAYi5DtD/EgI9k6ly1VJClxyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=DM/GnyzB; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744927303; x=1776463303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V7XDSMpKqaVHW9HAPkpM4lBrMTUfKs0N4vmQKegdIyQ=;
  b=DM/GnyzBDlHbWc6sNjN+vOdXKAp2LFC9nNBnRh3TgLqQHOSyJO22mpJS
   eYevtnQIcy6fhw2GptwMmWRrWmkCQz2v+3FsK4ovnENhz8oUsFcsiLzxE
   k/fZaigv+pH0WDWcV65OYjZBDBbgvHkJwsN5XVn89DcvmBWPiUk7ZwgXW
   Q=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="41612147"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 22:00:33 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:14380]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.110:2525] with esmtp (Farcaster)
 id bdcd9d70-1547-44c9-8884-e38e937c49bc; Thu, 17 Apr 2025 22:00:32 +0000 (UTC)
X-Farcaster-Flow-ID: bdcd9d70-1547-44c9-8884-e38e937c49bc
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 17 Apr 2025 22:00:32 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 17 Apr 2025 22:00:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <purvayeshi550@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH] net: ipv4: Fix uninitialized pointer warning in fnhe_remove_oldest
Date: Thu, 17 Apr 2025 15:00:07 -0700
Message-ID: <20250417220022.23265-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417094126.34352-1-purvayeshi550@gmail.com>
References: <20250417094126.34352-1-purvayeshi550@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB001.ant.amazon.com (10.13.138.123) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Purva Yeshi <purvayeshi550@gmail.com>
Date: Thu, 17 Apr 2025 15:11:26 +0530
> Fix Smatch-detected issue:
> net/ipv4/route.c:605 fnhe_remove_oldest() error:
> uninitialized symbol 'oldest_p'.
> 
> Initialize oldest_p to NULL to avoid uninitialized pointer warning in
> fnhe_remove_oldest.

How does it remain uninitialised ?

update_or_create_fnhe() ensures the bucket is not empty before
calling fnhe_remove_oldest().


> 
> Check that oldest_p is not NULL after the loop to ensure no dereferencing
> of uninitialized pointers.
> 
> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
> ---
>  net/ipv4/route.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 753704f75b2c..2e5159127cb9 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -587,7 +587,7 @@ static void fnhe_flush_routes(struct fib_nh_exception *fnhe)
>  
>  static void fnhe_remove_oldest(struct fnhe_hash_bucket *hash)
>  {
> -	struct fib_nh_exception __rcu **fnhe_p, **oldest_p;
> +	struct fib_nh_exception __rcu **fnhe_p, **oldest_p = NULL;
>  	struct fib_nh_exception *fnhe, *oldest = NULL;
>  
>  	for (fnhe_p = &hash->chain; ; fnhe_p = &fnhe->fnhe_next) {
> @@ -601,9 +601,12 @@ static void fnhe_remove_oldest(struct fnhe_hash_bucket *hash)
>  			oldest_p = fnhe_p;
>  		}
>  	}
> -	fnhe_flush_routes(oldest);
> -	*oldest_p = oldest->fnhe_next;
> -	kfree_rcu(oldest, rcu);
> +
> +	if (oldest_p) {  /* Ensure to have valid oldest_p element */
> +		fnhe_flush_routes(oldest);
> +		*oldest_p = oldest->fnhe_next;
> +		kfree_rcu(oldest, rcu);
> +	}
>  }
>  
>  static u32 fnhe_hashfun(__be32 daddr)
> -- 

