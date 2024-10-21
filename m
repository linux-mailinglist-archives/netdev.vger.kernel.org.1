Return-Path: <netdev+bounces-137624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFD09A72FF
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 21:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD09B1C21CC2
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 19:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0568C1CF7A6;
	Mon, 21 Oct 2024 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="wF4paLWM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CB41FBC98
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 19:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537871; cv=none; b=CmnM5VGGnysmS1ts0h0wef5/umAibzyNiQAzYUUaq0WCOYwgaRDfNXLBG2vUStNO7HDgJPgk0S47P1/qVo14togjIF42nw7IqrIKa0wdO08vp+efeaPrChMAdh4fWA8HmXKOHMUnUnI9encBZH8F4CAj5Igesa38PJgCD8P4gbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537871; c=relaxed/simple;
	bh=6TdlblqrYML0RhjaoeU9DRGxcogpDxlOJjjTJEZIVn8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ct+ivvT6359XUushEzPKKDsMpt9y8zOcisfzNMeTqbVX7ZjseKArNDysCTIQgCeEV2CmCUIfNUYcJpS2dXNkAue+o2JP4BvAMmNnIa1zJnIPGA0sx5XtiNTsVRAFCJLMw1VitW9BQg9UQbmGfzbeFK8H49KoBZV4nS+MaFfKLNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=wF4paLWM; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729537870; x=1761073870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gl2vbIuYgFmdDKPf6n0fq/ap9q2AsdJa5z/hIoLsLcw=;
  b=wF4paLWMKh3pP7qYAXRN/6RjD1K8nCIsD8EtxqzGC7d1oOm5rdnuovO9
   q/+2S5T/ejzm6DDGvPsEh/WcubIeuFhtyiggunQRUmfXJEydYxnhVyMxD
   jg+sMGFIbzkd5VZ6tVl/lGN4UatcDiKjL85FCzqbaCliD11PdaTx68XDe
   g=;
X-IronPort-AV: E=Sophos;i="6.11,221,1725321600"; 
   d="scan'208";a="433414138"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 19:11:07 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:15207]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.189:2525] with esmtp (Farcaster)
 id 3d884e42-4bac-4493-87de-69e43de0e672; Mon, 21 Oct 2024 19:11:05 +0000 (UTC)
X-Farcaster-Flow-ID: 3d884e42-4bac-4493-87de-69e43de0e672
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 21 Oct 2024 19:11:05 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.222.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 21 Oct 2024 19:11:03 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gnaaman@drivenets.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v6 1/6] neighbour: Add hlist_node to struct neighbour
Date: Mon, 21 Oct 2024 12:11:00 -0700
Message-ID: <20241021191100.84191-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241021102102.2560279-2-gnaaman@drivenets.com>
References: <20241021102102.2560279-2-gnaaman@drivenets.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB001.ant.amazon.com (10.13.139.133) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Gilad Naaman <gnaaman@drivenets.com>
Date: Mon, 21 Oct 2024 10:20:53 +0000
> @@ -530,27 +532,47 @@ static void neigh_get_hash_rnd(u32 *x)
>  
>  static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
>  {
> +	size_t hash_heads_size = (1 << shift) * sizeof(struct hlist_head);
>  	size_t size = (1 << shift) * sizeof(struct neighbour *);
> -	struct neigh_hash_table *ret;
>  	struct neighbour __rcu **buckets;
> +	struct hlist_head *hash_heads;
> +	struct neigh_hash_table *ret;
>  	int i;
>  
> +	hash_heads = NULL;

nit: This init is not needed.


> @@ -564,6 +586,8 @@ static void neigh_hash_free_rcu(struct rcu_head *head)
>  						    rcu);
>  	size_t size = (1 << nht->hash_shift) * sizeof(struct neighbour *);
>  	struct neighbour __rcu **buckets = nht->hash_buckets;
> +	size_t hash_heads_size = (1 << nht->hash_shift) * sizeof(struct hlist_head);
> +	struct hlist_head *hash_heads = nht->hash_heads;

nit: reverse xmas tree order.

