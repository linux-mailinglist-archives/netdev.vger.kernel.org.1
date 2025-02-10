Return-Path: <netdev+bounces-164536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D11CFA2E1E6
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 02:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B40193A4BC7
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 01:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784244C6D;
	Mon, 10 Feb 2025 01:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="So2cWDoT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C170335950
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 01:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739149905; cv=none; b=H6RBNCEHrC7VQXYDeVOVsAwrMcf81fTDHdfXZe7RNlpSueaA+PiKxsOQbk9CEMTSnH718RGRstKcT5D7nauFWBZF91/fyIyEChEemHAFQcYmGJy7wFXEzMykU29Azpvq5j/4+mCr2+pHJlWPI/jsG3r5he03tWp6/meogw70cgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739149905; c=relaxed/simple;
	bh=NGijLuACo+x3fp5z7vCYFlVGyRE9dl/QAu47/HzHCe0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g4/tz8ALTDArRRBO/jFxN6wRqakpTO8UIBuj2mnlzsZoTrildME51tseUwqRRJHyUb0YxskdyIFd9GkezfoL+od690UYuNsxnP819QEQeJW1UGmwEbTOiki3TnCOeKTtlBwb8ZeC5NbEUo8CYuQxTY7MDc9q2Gx2IqiUOSKGFqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=So2cWDoT; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739149904; x=1770685904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jHnr/GUgc0/R3WLUSO/e6gS913MeZF91X5N5O1KGxPc=;
  b=So2cWDoTtHCtNqcsurqDOnhJ/AJA2d4KsE9jh1iw/4I+XwhYtTZratSk
   GQZlr60Cm7kn1P3QBfF0HalK5bMz4HuDRjcWMHHyv4hWqLJRYR9zFtRRS
   jEOkUAV/ADCA5lO0ZtnfVjwBt5YzwXkkaBBy2N3CYST8s/eFUlBN42L1K
   o=;
X-IronPort-AV: E=Sophos;i="6.13,273,1732579200"; 
   d="scan'208";a="269748007"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 01:11:41 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:11414]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.27:2525] with esmtp (Farcaster)
 id 696b85cb-3b9e-439e-9c6e-b2e15817ed45; Mon, 10 Feb 2025 01:11:40 +0000 (UTC)
X-Farcaster-Flow-ID: 696b85cb-3b9e-439e-9c6e-b2e15817ed45
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 10 Feb 2025 01:11:39 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 10 Feb 2025 01:11:36 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <eric.dumazet@gmail.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net 2/8] ndisc: use RCU protection in ndisc_alloc_skb()
Date: Mon, 10 Feb 2025 10:11:26 +0900
Message-ID: <20250210011126.54146-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250207135841.1948589-3-edumazet@google.com>
References: <20250207135841.1948589-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri,  7 Feb 2025 13:58:34 +0000
> ndisc_alloc_skb() can be called without RTNL or RCU being held.
> 
> Add RCU protection to avoid possible UAF.
> 
> Fixes: de09334b9326 ("ndisc: Introduce ndisc_alloc_skb() helper.")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

