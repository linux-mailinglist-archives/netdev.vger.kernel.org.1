Return-Path: <netdev+bounces-64911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F2D8376AA
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 23:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C2A7B22F6E
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 22:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F7A12E69;
	Mon, 22 Jan 2024 22:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="iEPUithz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC0614F6E
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 22:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705964160; cv=none; b=En6emLLBwe4of+LD6XFLpDe7bSopvbpynARW3JwbXq0HaeOVfvIgxxhsHNzskI7XWCx6EP9Be07BCBhNQeV1xG7NH4UBZBabMg5AiPPRjIvPg5iCR8LWx+rPapM0ZGyw94zGGpRpBMFk153IjBlvH7iHCRO1N83Tm16NIkyeJxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705964160; c=relaxed/simple;
	bh=5RzbnriJaZ2EuyBfasq0Qije9dqBZdc4/BviAnAROZI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+ILGrVxw3kcxztyLnJusFNsy8Y2H6o/bAB4NpWNupzPdmCqlRziN1bAqOxSp0+As4K9O3ILDZ4vBSO5DH+8fsblMXWfHcCBkpGbhInSAa25t3lNVt2yCr9brgv8KfJJ2XZd23LcAHMC4gu0ZD7CTvBnhriYJY9dxpL0Xe+142g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=iEPUithz; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705964159; x=1737500159;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oX5jZTpO61gLFsiG77hcPVO8MYYBuXh1MINpi4ULePU=;
  b=iEPUithz3yYuTJePO1qDTD9czSQhQvLXwRQ83ohC3ZCwq0pgSaWzxAZG
   Y83J0XEYjxRR/1NrnspWKT9dKIaot18ae80Mz7WDWe6r0hlpufUAPfRJQ
   0B/Er/cmc9bUuEJZhB7Fx5tdC4c7xcSvxS3bNE5RD3XKT/qJomixXPg+l
   s=;
X-IronPort-AV: E=Sophos;i="6.05,212,1701129600"; 
   d="scan'208";a="381537082"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 22:55:56 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com (Postfix) with ESMTPS id 1198D40D97;
	Mon, 22 Jan 2024 22:55:51 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:5038]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.111:2525] with esmtp (Farcaster)
 id 932587cb-48ac-424d-8060-0fefed4bf634; Mon, 22 Jan 2024 22:55:51 +0000 (UTC)
X-Farcaster-Flow-ID: 932587cb-48ac-424d-8060-0fefed4bf634
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 22:55:45 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 22:55:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <eric.dumazet@gmail.com>,
	<gnault@redhat.com>, <kafai@fb.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 8/9] sock_diag: remove sock_diag_mutex
Date: Mon, 22 Jan 2024 14:55:32 -0800
Message-ID: <20240122225532.21262-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240122112603.3270097-9-edumazet@google.com>
References: <20240122112603.3270097-9-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC002.ant.amazon.com (10.13.139.196) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Jan 2024 11:26:02 +0000
> sock_diag_rcv() is still serializing its operations using
> a mutex, for no good reason.
> 
> This came with commit 0a9c73014415 ("[INET_DIAG]: Fix oops
> in netlink_rcv_skb"), but the root cause has been fixed
> with commit cd40b7d3983c ("[NET]: make netlink user -> kernel
> interface synchronious")
> 
> Remove this mutex to let multiple threads run concurrently.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

