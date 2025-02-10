Return-Path: <netdev+bounces-164530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1188A2E1CA
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 01:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582B71883860
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 00:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31500AD2C;
	Mon, 10 Feb 2025 00:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KnFFHYBx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ED0AD21
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 00:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739147861; cv=none; b=nuncd0+SlxqgmbqZt5tAPmPp/xGNGRwHHXq0XdBbhPIR1CUI1Nfj+smPv0mQPt4h7zrhUmXZq7u8cYHxdYqpF9WKiNzURTOMelvfgyVo3kCAh6AD6V97blFF1Pc6Xeh8SVb7j9tR1erHiKigVLC8j/53JSm7/CJ3ToZmTh2Qg6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739147861; c=relaxed/simple;
	bh=VVHgYKFrIkTzdz43sDsJLwCSUVnIPkGadD1KiFueRSs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P+0dWJO7HYPccB920yuwJjwROtsqpkyNJlbqjUCj41K/ru8iIRHuQg+F/W4Bpm/Zy1amQcpnKRPHdgdaLX9doqvo5ZkC9+51UZeVqCQM1ewcufcfXGZE9FLFTnp+2mVVqrLVVLwIyGZ+ik4fLRoOomCDeqtnUteToh5Qq5ryoFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KnFFHYBx; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739147860; x=1770683860;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GhZJkVnyYm36oSVjOD1w77j9ETogY/V/4XB9QhTLo+c=;
  b=KnFFHYBxULVWXtM5x9xcHYNUTedHC+hmD1e1x0sCMF7DII6ffKv0LRAU
   oMVx+jUnvl7v/4S+YZGZJngUCEMEwI8Ze0oGIsqCBXkIVGkjrj7RpNukX
   9P/bDMBy6rOf3mLC+/i5fr0/XvtTgVR4DkKdcHM4KYsfsIkdCglBHRXxA
   w=;
X-IronPort-AV: E=Sophos;i="6.13,273,1732579200"; 
   d="scan'208";a="64532612"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 00:37:36 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:54079]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.10:2525] with esmtp (Farcaster)
 id 81b3227c-143e-4cb5-9810-9a364d84ba09; Mon, 10 Feb 2025 00:37:35 +0000 (UTC)
X-Farcaster-Flow-ID: 81b3227c-143e-4cb5-9810-9a364d84ba09
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 10 Feb 2025 00:37:35 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 10 Feb 2025 00:37:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kernelxing@tencent.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<ncardwell@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/5] tcp: use tcp_reset_xmit_timer()
Date: Mon, 10 Feb 2025 09:36:50 +0900
Message-ID: <20250210003650.49879-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250207152830.2527578-4-edumazet@google.com>
References: <20250207152830.2527578-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri,  7 Feb 2025 15:28:28 +0000
> In order to reduce TCP_RTO_MAX occurrences, replace:
> 
>     inet_csk_reset_xmit_timer(sk, what, when, TCP_RTO_MAX)
> 
> With:
> 
>     tcp_reset_xmit_timer(sk, what, when, false);
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

