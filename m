Return-Path: <netdev+bounces-161823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A57AFA24320
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 20:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C881882055
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 19:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1C21BBBC0;
	Fri, 31 Jan 2025 19:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XrZUVTyR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8C854782
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 19:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738350326; cv=none; b=gqbiFvRKfzZeMFl1MUWJ3kMrrB/mUUxcmhtuiSk6FHxySFMcLX2NhR5d7t+C7p1BACowiYVjpon/M0dYDoinUBQI0vn4AYP0neemoJqZQrim2zPTEEHKo04iIPLsYEXCuHNCrde521WQrVdFGHh+C7X+eZnFYTaRAM6LVBqoXWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738350326; c=relaxed/simple;
	bh=G9gR4gitY9YDAclKVhbSba9oQxTjRW6Q2M7vuQbLoFQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SHtnh7P3O0Gw0aIcPFz2SnNtyVXwL5dYHyqQwUz9KCCFhhI9WNJdk6iYGz8x07W5NzjCQB/Y8JjOyCD1m9U5HtrcRDBhalALttc+CnJ1rEcKQCcAuAgLxtg3RTkUU1B7218KWZvx2sRhtslk+AGO69606QvNilsJUhwVYd040Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=XrZUVTyR; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738350325; x=1769886325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NMCAHMxJHstL5VwgCoorg304gRJGDCVplekbCPyxxLk=;
  b=XrZUVTyRvbBMUPLTlb6FzAZRbkg5KvaYproz+YvHltKiJgwKuk3ExBLU
   Sw1nNuCsegN2z2T1CTg2E3fvqYWNtldRkIuPtcPq0G7pk3PX6pezS34Cn
   Ejd4HTRCGhy56MU0D/ZzODT6T3pHwEECavu1OeLZ50FI1+wx/Tz7BQd9X
   U=;
X-IronPort-AV: E=Sophos;i="6.13,249,1732579200"; 
   d="scan'208";a="795200522"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 19:05:21 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:61493]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.236:2525] with esmtp (Farcaster)
 id bc5a68b5-b062-4108-87d6-3f6791a1b2b8; Fri, 31 Jan 2025 19:05:20 +0000 (UTC)
X-Farcaster-Flow-ID: bc5a68b5-b062-4108-87d6-3f6791a1b2b8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 19:05:14 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 31 Jan 2025 19:05:11 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net 07/16] net: gro: convert four dev_net() calls
Date: Fri, 31 Jan 2025 11:05:03 -0800
Message-ID: <20250131190503.94246-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250131171334.1172661-8-edumazet@google.com>
References: <20250131171334.1172661-8-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC003.ant.amazon.com (10.13.139.231) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 31 Jan 2025 17:13:25 +0000
> tcp4_check_fraglist_gro(), tcp6_check_fraglist_gro(),
> udp4_gro_lookup_skb() and udp6_gro_lookup_skb()
> assume RCU is held so that the net structure does not disappear.
> 
> Use dev_net_rcu() instead of dev_net() to get LOCKDEP support.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

