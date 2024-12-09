Return-Path: <netdev+bounces-150036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 435EF9E8B35
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 06:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E207E164488
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 05:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6984211466;
	Mon,  9 Dec 2024 05:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XJ0JcE0e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1396820FABD
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 05:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733723575; cv=none; b=PfZYATgTrsr6Y2Sb65Skz5gSggCu4YoVGTBJwYWEMFW32g051RDTYy1X+A6ecgFgn+iyRAXNAmStDRHro0GvrjdMteQkYEiZ2qx85xKFlcHDqfGM5QUDga/FZWw+1NsUzK3jgQp9OLsdlM5GyUyUYohc3g+aT3aMvPmhxW4XVhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733723575; c=relaxed/simple;
	bh=SiO939IOLTrFnhzeaA4scd52E9z7Dt4lbdHfnkEhNpY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L15/Y7Eo28rQHiJCibyAdpihsts8pkUpH2OE5oQJwYBRohMe5zI85fvtp+W2TZ2+3EjbqH7RLVTdxMz4Ihec3gW1N4OT4ACiHKnFmaZ/i1EB6TN0hXLVhQMQaGJA5RH5mfgOde8ZOzNZ6hEZWR5LpOd6OUUeMgTF8xRjRN8Oot4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=XJ0JcE0e; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733723571; x=1765259571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+QX9sBjtk4HpkK7LXMuzR+eo4Q2BA33e15vbSnjZuu4=;
  b=XJ0JcE0eaVZPVGr2PfNL9H/0e8sLsdTW8ZFfxfioKw7pEQ++yHekHnCv
   Q0wYv2jetN/jRbiRO/3ug/l/ZYO8+l6yfvXxa5T6h0fLsguOxa3wxLnmN
   e9FECY4vhdQwtRcFHUA6vy9xVzlQ7gkUNkX1qyqW6Vw/XjojNwSF8aMgg
   w=;
X-IronPort-AV: E=Sophos;i="6.12,218,1728950400"; 
   d="scan'208";a="701359187"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 05:52:48 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:34804]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.241:2525] with esmtp (Farcaster)
 id 103733fe-f220-4b75-92a0-2fdc107f3e85; Mon, 9 Dec 2024 05:52:47 +0000 (UTC)
X-Farcaster-Flow-ID: 103733fe-f220-4b75-92a0-2fdc107f3e85
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 9 Dec 2024 05:52:46 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.254.92) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 9 Dec 2024 05:52:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <roopa@nvidia.com>
Subject: Re: [PATCH net-next 2/3] rtnetlink: switch rtnl_fdb_dump() to for_each_netdev_dump()
Date: Mon, 9 Dec 2024 14:52:39 +0900
Message-ID: <20241209055239.14578-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241207162248.18536-3-edumazet@google.com>
References: <20241207162248.18536-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Sat,  7 Dec 2024 16:22:47 +0000
> This is the last netdev iterator still using net->dev_index_head[].
> 
> Convert to modern for_each_netdev_dump() for better scalability,
> and use common patterns in our stack.
> 
> Following patch in this series removes the pad field
> in struct ndo_fdb_dump_context.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

