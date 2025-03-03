Return-Path: <netdev+bounces-171421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F94A4CF41
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 00:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2BD172387
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 23:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3E41F3D30;
	Mon,  3 Mar 2025 23:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FfPavIcy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8758920EB
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 23:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741044817; cv=none; b=tEubjuGrtiaUZSnQu1zGDyEKFCiD/6JRLIroIuSZdgjHb1lXMVwsLdy4JvPHdDne0ai3pekC2zRSw4BR3fFj/R4dMND3kDYZ6NHP0dExcEAPkesi37c4fBYGLuzj+3XvcVQfr/k6Ea+groXzx3BUuu/idGq7NcIad5E5+TAzNsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741044817; c=relaxed/simple;
	bh=2gKcbhXsLGtGjSxJS8FYOKdDEBAHDueH/AaismOObbo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZM7tJQwjCB1Z8b65XTLd9KzBnApgPhRyf8CPOzwvZpMAqsBLzZrYY1sMWvNYmpD2ycZ8uXJ1q3vTMFk0Jt4zgXJxZuxPdG6B7nxxQyS+AsFS8c7hiG+hMS8HKSpOklzJKRzHzCbdblQ1qHUNL2Sm7lwDunPI6braZw1DeeoW8HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=FfPavIcy; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741044815; x=1772580815;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9gTgR6jKZfcpbAy23XneMlMqqgEGX7t+8mzTWgfqVn0=;
  b=FfPavIcywg5JnPXOU1z7YZWT8OJOc/8s0szhYp9Yt20o3OsssL3LbNuF
   8MTXGJiRa+yqagoW/mkAu5DebOUHeJEtpcyqcsn9fuwI5vmBl+YrgmeMd
   G3YlELa33T2/eEbOv/Z1T+gLN4KEDNDL9CaESFfhL9gHCs7iUXK8lUw+L
   s=;
X-IronPort-AV: E=Sophos;i="6.13,330,1732579200"; 
   d="scan'208";a="477015576"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:33:31 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:12515]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.102:2525] with esmtp (Farcaster)
 id 586600f5-7386-4185-a748-2c59320653b9; Mon, 3 Mar 2025 23:33:30 +0000 (UTC)
X-Farcaster-Flow-ID: 586600f5-7386-4185-a748-2c59320653b9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 3 Mar 2025 23:33:30 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 3 Mar 2025 23:33:26 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <ncardwell@google.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next 6/6] tcp: tcp_set_window_clamp() cleanup
Date: Mon, 3 Mar 2025 15:33:17 -0800
Message-ID: <20250303233317.54752-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250301201424.2046477-7-edumazet@google.com>
References: <20250301201424.2046477-7-edumazet@google.com>
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

From: Eric Dumazet <edumazet@google.com>
Date: Sat,  1 Mar 2025 20:14:24 +0000
> Remove one indentation level.
> 
> Use max_t() and clamp() macros.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

