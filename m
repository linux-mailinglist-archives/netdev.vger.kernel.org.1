Return-Path: <netdev+bounces-164533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DD6A2E1CF
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 01:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109173A51AD
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 00:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768732C9A;
	Mon, 10 Feb 2025 00:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="oQhl/bti"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2440625
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 00:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739148436; cv=none; b=SmjC8LJjTXvoRKj0IhsxybRnYoA/LRn4nxtxYyLlx2TXGkjpIzK4v38hr1EfeGKdZxKiF9g1/cHFi2uy1pOnGfXGE0Utq7OsfDG2py4ZuO3ZFkiOrsayZVG2cQ+FeufmfVgN09oFLGqo/9mw36Kq9Ckg3ztBChI9Od9CxxhjRuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739148436; c=relaxed/simple;
	bh=7wZvSMNDlWmjgFFPcuwYjdikwjeIWlir4PyHPMOExfk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GVGVDwF0nACUtkrO9iwYG76lnuKpJ9b8Ik4qlUzFnSc5YxTdVj+JgXpqPeZvdDQMEtPDm/6PWUPTIUi24yFI7mLcL1dS976BXTR6F3M0Ouc0ZvMbJ7ybra3GV1NrKvjtfXrEwtthZrH4rKjXzq5aSEjVBxrMTCO1e8VnjR1qR7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=oQhl/bti; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739148435; x=1770684435;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vmQpqLAtal4psHAK3aUlN0T6J5Vh3F3a3ULOCkp96t0=;
  b=oQhl/btiyhy1bP6kDDAhqPrJ2+9typgrrL+qApyUHGcjPvBwYotLF8uy
   jM8yx77ddUXXa2ThGYJawig+sid7SOH735Km25NO0S6pvkeLZhhUy56MA
   GvOjiy+ebyb4HFCodGhdavhDdekHWPgpWBaOyicO8BzTMi3I+fldjjglI
   Y=;
X-IronPort-AV: E=Sophos;i="6.13,273,1732579200"; 
   d="scan'208";a="465434090"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 00:47:13 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:14093]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.45:2525] with esmtp (Farcaster)
 id 2d5566f6-284b-43c6-bebe-a3da7bc42afc; Mon, 10 Feb 2025 00:47:12 +0000 (UTC)
X-Farcaster-Flow-ID: 2d5566f6-284b-43c6-bebe-a3da7bc42afc
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 10 Feb 2025 00:47:11 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 10 Feb 2025 00:47:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kernelxing@tencent.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<ncardwell@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 5/5] tcp: add tcp_rto_max_ms sysctl
Date: Mon, 10 Feb 2025 09:46:57 +0900
Message-ID: <20250210004657.51161-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250207152830.2527578-6-edumazet@google.com>
References: <20250207152830.2527578-6-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri,  7 Feb 2025 15:28:30 +0000
> Previous patch added a TCP_RTO_MAX_MS socket option
> to tune a TCP socket max RTO value.
> 
> Many setups prefer to change a per netns sysctl.
> 
> This patch adds /proc/sys/net/ipv4/tcp_rto_max_ms
> 
> Its initial value is 120000 (120 seconds).
> 
> Keep in mind that a decrease of tcp_rto_max_ms
> means shorter overall timeouts, unless tcp_retries2
> sysctl is increased.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

