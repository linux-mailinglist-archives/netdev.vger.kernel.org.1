Return-Path: <netdev+bounces-158432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 578FFA11D0A
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9616718895BB
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ACC246A1A;
	Wed, 15 Jan 2025 09:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DpcKFwiM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383FC246A0A
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 09:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932360; cv=none; b=JDFLmrlAxBu5Z/D6fPTcBiv6RenBu91Nv+hFbR1GfSRS9tJ+RX/gG8HG3QfORSq52LkSJddv3UrT404Iux2x4IxOJZrS5BtvNR4kHsF+rtK1i9fXkP/mt9wLBFqw5Z+KWkpNG+QswdUtV+/6EBpa1bua8pPHr8Ma10CNAAbgdFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932360; c=relaxed/simple;
	bh=7cg2Qh805Z/JB5XBsRNqrhGmOi1s6gwITrAhsMK/UvQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ac7LHwzX2f9Xl3KlBvxGy9OerI80LOZ4sYnMPiSRtC8LO1JjqcL8o34UZ6JMrZqm/4aaq4/TYkrarOQC+gAW4KKbhFjS2QpWsk6/xaI2Hj1sDuPz1TbOaYcSc2bDR96s786cuIakJCp45hVknX677eXzxcmbuCRCASH3M0m+GTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=DpcKFwiM; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736932359; x=1768468359;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EEhj+tHThBlS44t5XVkcBPIhTOF2/PsnYMKAQ59ZA+Y=;
  b=DpcKFwiMJfupI4Rx9yvLvI92Xvr9m8p6OoCYaqB8FAj3gCBZfpIjzFL8
   jO2/YkveNUjt4eDGxqz9gBjEok6MwUaS90Appb/tRfhzns0YS2fkcrRss
   dcTKYmQ4F+BFebQi6+pA9RBpzMHWjOMOgTNDXxM2MCA/03lY10gQJGPdl
   o=;
X-IronPort-AV: E=Sophos;i="6.12,316,1728950400"; 
   d="scan'208";a="464232749"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 09:12:37 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:53817]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.200:2525] with esmtp (Farcaster)
 id 4f785b0c-8d39-46c5-bc67-91cf55a4a95b; Wed, 15 Jan 2025 09:12:36 +0000 (UTC)
X-Farcaster-Flow-ID: 4f785b0c-8d39-46c5-bc67-91cf55a4a95b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 09:12:36 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.248.178) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 09:12:32 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <jdamato@fastly.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH net-next v2 09/11] net: protect napi->irq with netdev_lock()
Date: Wed, 15 Jan 2025 18:12:23 +0900
Message-ID: <20250115091223.46052-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250115035319.559603-10-kuba@kernel.org>
References: <20250115035319.559603-10-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA002.ant.amazon.com (10.13.139.11) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 14 Jan 2025 19:53:17 -0800
> Take netdev_lock() in netif_napi_set_irq(). All NAPI "control fields"
> are now protected by that lock (most of the other ones are set during
> napi add/del). The napi_hash_node is fully protected by the hash
> spin lock, but close enough for the kdoc...
> 
> Reviewed-by: Joe Damato <jdamato@fastly.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

