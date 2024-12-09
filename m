Return-Path: <netdev+bounces-150037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C589E8B3A
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 06:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B716281208
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 05:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5936F20FABE;
	Mon,  9 Dec 2024 05:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mAM0bzjs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34D020FABF
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 05:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733723709; cv=none; b=fm80bN003iMujM1gmJG0jupgfgd1iy7x6F8qDznMrH0c1OzSp3SjZ5vl+fP8wIphwzZ98tkmQSuPNy2v4dPIBH69x15I/hYCJ5ekdDy5a7j3HB4kToSNaZVWZV4Jr5Spaswz5YoYGf7h2KCNGPm9wwnqlCLIXgl86itoW4UPtwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733723709; c=relaxed/simple;
	bh=q4Eu/03fW+462GSZhx0uquRR1O4GpkHYa72+MaCxzog=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W+nWAgo+HmcV6o14C1kPRjGGREJtpxb8KRCPB9FY5VPYhg6rPvVpRyBYjkw/iUVG8Xfa/XLFv8b27Je0l/ZAP9uX8XFCzvqQMahWfkOz8BflMFQ/w2J1dJgqYrfK1s5Z913bs84sT+RVC15CV6upKC7nldbM9UwE62vUP7ee/Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mAM0bzjs; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733723708; x=1765259708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8/R/0ShpL8hBnQcNBPZiepKqC7AOKoWKThzjnRzBYxM=;
  b=mAM0bzjs7kwcOBZgVabZCMmM/NcoGBrxTjEJxjvrw+Fu14d1L56/7sm+
   8d15P3DGmu6DTn9A/YvQOZIuEJOTiXogItGuNZDCxrmkTTkgN9MQKBc36
   zRv88w/WJYYQTOsj+K6wtN5ZFDKJp70Z0yOBuHNQ6heF0Q7Fkw9YF1Yuf
   s=;
X-IronPort-AV: E=Sophos;i="6.12,218,1728950400"; 
   d="scan'208";a="679773642"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 05:55:03 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:30183]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.92:2525] with esmtp (Farcaster)
 id 0fcb5b36-8951-4561-bc67-53d31afbc967; Mon, 9 Dec 2024 05:55:01 +0000 (UTC)
X-Farcaster-Flow-ID: 0fcb5b36-8951-4561-bc67-53d31afbc967
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 9 Dec 2024 05:55:01 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.254.92) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 9 Dec 2024 05:54:57 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <roopa@nvidia.com>
Subject: Re: [PATCH net-next 3/3] rtnetlink: remove pad field in ndo_fdb_dump_context
Date: Mon, 9 Dec 2024 14:54:53 +0900
Message-ID: <20241209055453.14743-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241207162248.18536-4-edumazet@google.com>
References: <20241207162248.18536-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB002.ant.amazon.com (10.13.139.139) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Sat,  7 Dec 2024 16:22:48 +0000
> I chose to remove this field in a separate patch to ease
> potential bisection, in case one ndo_fdb_dump() is still
> using the old way (cb->args[2] instead of ctx->fdb_idx)
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

