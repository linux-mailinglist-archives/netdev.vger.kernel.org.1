Return-Path: <netdev+bounces-142551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E84339BF9B2
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 00:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E87D1F22546
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 23:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88441DE2CD;
	Wed,  6 Nov 2024 23:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HMmsmc4M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144DD1D47B3
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 23:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730934434; cv=none; b=ETtD3+vGz6p1Vq4lvBF5VEhBBDJS0mXSlZBGjtXSNh04XfVbU+KJR/cBeu7JuQBROiYuieutsurlXg1HwNRzg4SwRnjh3i3CVgLT7KUKx6XikDZo+Kg87aW8gy7bzh9OBTqVgdwIMHZQ5H9mNOTCyPawWH+BHiihWHn9PkF5tp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730934434; c=relaxed/simple;
	bh=zTMT/kEaE4XiSOaMNn+JOiE4K1ManQ3vlBLgpjRBokY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fiZlcZvLAk3L+jjsNV/DGoLBqXxtL6LbvXa5UwpjUN9wKt5m7NFdgmfFDlIZJ7AtWu4KV+em7N6aOlmiDi5Wny/zzXR9n/52vP59ukjBKkBfLMcTD++wsLb7Fgq1GM0JIIR+/V30eiK63bFNyF/JmPy4ogvXNNubmeaGvmn7P2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HMmsmc4M; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730934434; x=1762470434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oBSN1684rpiXiZHz0jkCw1k6NUFOB5BKmIcU95ZeMUU=;
  b=HMmsmc4Mir8dcLyvvESLVm6uByIHdh8eOpUlOoibvzxcHq7lNmqN5+yD
   4ShZc1FbZREFkxR8mGg3EGhBQdQH+NWx9ia3gqTRYTb4hHlv/r6wyBsa4
   294CEC9aPvP7nupaF0GBR6Gnr/WrDsRRh4PDi7B1FshDTJWaDxE6k7qZU
   U=;
X-IronPort-AV: E=Sophos;i="6.11,264,1725321600"; 
   d="scan'208";a="440851489"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 23:07:10 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:47168]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.15:2525] with esmtp (Farcaster)
 id 4b089940-86e1-4e6d-a6e4-c788f75e71b1; Wed, 6 Nov 2024 23:07:09 +0000 (UTC)
X-Farcaster-Flow-ID: 4b089940-86e1-4e6d-a6e4-c788f75e71b1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 6 Nov 2024 23:07:09 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 6 Nov 2024 23:07:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gnaaman@drivenets.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v8 4/6] neighbour: Convert iteration to use hlist+macro
Date: Wed, 6 Nov 2024 15:07:03 -0800
Message-ID: <20241106230703.48870-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241104080437.103-5-gnaaman@drivenets.com>
References: <20241104080437.103-5-gnaaman@drivenets.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB002.ant.amazon.com (10.13.138.89) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Gilad Naaman <gnaaman@drivenets.com>
Date: Mon,  4 Nov 2024 08:04:32 +0000
> diff --git a/include/net/neighbour.h b/include/net/neighbour.h
> index 69aaacd1419f..68b1970d9045 100644
> --- a/include/net/neighbour.h
> +++ b/include/net/neighbour.h
> @@ -309,12 +309,9 @@ static inline struct neighbour *___neigh_lookup_noref(
>  	u32 hash_val;
>  
>  	hash_val = hash(pkey, dev, nht->hash_rnd) >> (32 - nht->hash_shift);
> -	for (n = rcu_dereference(nht->hash_buckets[hash_val]);
> -	     n != NULL;
> -	     n = rcu_dereference(n->next)) {
> +	neigh_for_each_in_bucket(n, &nht->hash_heads[hash_val])

Sorry, I missed this part needs to be _rcu version.

You can keep my Reviewed-by tag in v9.


>  		if (n->dev == dev && key_eq(n, pkey))
>  			return n;
> -	}
>  
>  	return NULL;
>  }

