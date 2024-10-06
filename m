Return-Path: <netdev+bounces-132507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C98E991F83
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 17:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 060421F21677
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 15:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A083189910;
	Sun,  6 Oct 2024 15:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KM1a53S+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F63188CB7
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728230221; cv=none; b=R0fj79qADnIumZo7Ev2ikvqCfK7DuYfzmU5fXUm+fju7mSE9h5QJ/68+fjEBxACztwrHLuZ4dbeejFu6zO/OyC+dm6zhK4z5VpqW0zu5yyzFHv5Qw6VMT+ok+f2hICTJL6QpmJhw4gc7Jy4q9C8Htz8sQme01s3gsN2AOWrqCmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728230221; c=relaxed/simple;
	bh=VdbtwYKX+MmwuEgVpT6sjSFzBCllxTU657of8R1orCI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KjXYTmamW6GQwHZ2AHQRvoVu9dVjEdPlYKlyNxdhexSLxJT0I8bZulHvu0rZEMPYYdiR2fg/OYSy22Qu4+dHjaQwQGvO9u7VuEgKNzFTGUQhTjm8ThYAh04Y9kkxxBBcJCqtlKd2aXeerUx5OYCU+09hKM6AVibcZf5PDZf1y6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KM1a53S+; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728230220; x=1759766220;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+Al6lYJ+p+sTEumSZYgvbLzRqwUfJNVbo3bvNiaksdA=;
  b=KM1a53S+kHO84bnUDCH3Y6x2mNX3qVcUTUMqge0NrSJBeShsqjnZhzu1
   5sOzeCAIBDSbzaTe28p3DA9lUXYsU7d79I7EyYfUazJ9ty0ljC/FSUpwc
   Khk9bOZTSFeb2TLMExzRk+VIgZxh7WdWQQivmhQFhp+BtdEvPMF0IbIpt
   Q=;
X-IronPort-AV: E=Sophos;i="6.11,182,1725321600"; 
   d="scan'208";a="664061733"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2024 15:56:56 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:45124]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.41:2525] with esmtp (Farcaster)
 id dd8c51b5-ffab-49ea-970b-e3d116feae6a; Sun, 6 Oct 2024 15:56:55 +0000 (UTC)
X-Farcaster-Flow-ID: dd8c51b5-ffab-49ea-970b-e3d116feae6a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sun, 6 Oct 2024 15:56:55 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.11) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Sun, 6 Oct 2024 15:56:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gnaaman@drivenets.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 1/2] Convert neighbour-table to use hlist
Date: Sun, 6 Oct 2024 08:56:45 -0700
Message-ID: <20241006155645.58445-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241006064747.201773-2-gnaaman@drivenets.com>
References: <20241006064747.201773-2-gnaaman@drivenets.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB004.ant.amazon.com (10.13.138.84) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Gilad Naaman <gnaaman@drivenets.com>
Date: Sun,  6 Oct 2024 06:47:42 +0000
> @@ -2728,9 +2695,7 @@ static int neigh_dump_table(struct neigh_table *tbl, struct sk_buff *skb,
>  	for (h = s_h; h < (1 << nht->hash_shift); h++) {
>  		if (h > s_h)
>  			s_idx = 0;
> -		for (n = rcu_dereference(nht->hash_buckets[h]), idx = 0;
> -		     n != NULL;
> -		     n = rcu_dereference(n->next)) {
> +		hlist_for_each_entry_rcu(n, &nht->hash_buckets[h], list) {

idx = 0 was accidentally removed.


>  			if (idx < s_idx || !net_eq(dev_net(n->dev), net))
>  				goto next;
>  			if (neigh_ifindex_filtered(n->dev, filter->dev_idx) ||

