Return-Path: <netdev+bounces-171433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98765A4CFE4
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 01:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBF141895FAE
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 00:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE438837;
	Tue,  4 Mar 2025 00:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ycql3wVA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C2D23B0
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 00:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741047793; cv=none; b=bdyqwbe+8F3wY3byp6ZxuFcfBZ3weYrlh36AxbijZEB3lI3wrl5kx7rSwjboSHJID2dz/dmfXGQlybalmGDTWFZlki0ODPPaxdLN+Ac9abN81AWGzRbrvOmV8vkn+GzlGcBA2pTmKldOr53hdaWwcN4SWhbuSbdnraMtx4HeN/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741047793; c=relaxed/simple;
	bh=JUZQQXWpTAN6R6rDuzsr+rivaRKTo23WZNcHfEroe04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=istd800HubK0laqpnL15Vzrw0CzldNR+sFdRqes5vhXekWh17uF51k2LW91Z+ljPIfaSX0vFFVFo9cKfVUp/+rUrWPFWuHH5+bDXu5ZfEdY1pPkOs5WZHwoe3dVQ8QZHAjHpbdj1GmLZ2TsvbdywLYT9cZQcu16AbpvwQepxVKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Ycql3wVA; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741047792; x=1772583792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Eh4SiW9WaToWng22Z2loR5z3vyxhi3b2jmd5B8Pv3oU=;
  b=Ycql3wVAVp2HolfxEOf+seh4U1GZYQp+1GBkiw2ERoadPrvVgFMPSOOC
   jfSi/pQtP1uP6VAH3rIfiDjGLH3p172iem20z0GLHYG4QgEKdHBUyOyZb
   W7sK3EeqSrCjMv1PG01l9MC/jRGXbi8mXwa2cbDsQZrTkdJEv3XxdCeGL
   o=;
X-IronPort-AV: E=Sophos;i="6.13,331,1732579200"; 
   d="scan'208";a="467568869"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 00:23:07 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:54481]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.238:2525] with esmtp (Farcaster)
 id 620d72bb-6eb9-4713-909f-ab1d666047a5; Tue, 4 Mar 2025 00:23:06 +0000 (UTC)
X-Farcaster-Flow-ID: 620d72bb-6eb9-4713-909f-ab1d666047a5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 4 Mar 2025 00:23:02 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 4 Mar 2025 00:22:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kerneljasonxing@gmail.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<ncardwell@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/4] tcp: optimize inet_use_bhash2_on_bind()
Date: Mon, 3 Mar 2025 16:22:49 -0800
Message-ID: <20250304002249.60917-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250302124237.3913746-3-edumazet@google.com>
References: <20250302124237.3913746-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC002.ant.amazon.com (10.13.139.222) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Sun,  2 Mar 2025 12:42:35 +0000
> There is no reason to call ipv6_addr_type().
> 
> Instead, use highly optimized ipv6_addr_any() and ipv6_addr_v4mapped().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

