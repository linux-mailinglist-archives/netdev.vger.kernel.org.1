Return-Path: <netdev+bounces-175442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F13A65F0E
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 21:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4155D17B58E
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 20:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537D01EDA19;
	Mon, 17 Mar 2025 20:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rQm7aeeR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16D017BBF
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 20:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742243138; cv=none; b=kCQfFx7YjlFFZmfj1nCFyD8Z93eUCU7ler3WMPQGsVD6qDsEjl7kxqzyvhL7J+WkAMzs1Mpy7WIw0moee+4aZegCpzjJoMsmq31itigZUAVGZ+DfU2x9d8QHCoB/BEiyC0JbzNYFIxi0ynPLZ3DGR164usfMFKnZIJxACDXUGVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742243138; c=relaxed/simple;
	bh=ARTXzmmiaBQFKNbsikruX7acJktWMlR8EAKKQ7NYqXc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HspBUOb/eN0Tt4+H5yiPy1j6YiZ/Qw/zNZEZ8/IgjeDPgQxSCBC/Tv+ifQrIAgm4F7g5kiwhp2MFZ89yWlsUQ9mhfaoycyhT/E5nLu9QKDT+vQ6/d0jJZW7VyD9R67v/f/qtXeJbbnu3JgrkhD3TyDx+V4MfS7BIkN5RJkiI+Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rQm7aeeR; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742243137; x=1773779137;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wauf9+1ZHmXV8A2+d5t5CBgpRdAsBBZkyQAnF5IeEfo=;
  b=rQm7aeeRQ4wGFJKtaTA7IhPgWTUmZZe0jiYuSdvn2/ThOerGDgEVmXHt
   gXxpOuRb3EBoOcinw5yCxlTp7HxmEyoTCOgZnY2D2mHvnS629Z3p5XBam
   PK3oCdK37afjGyQZL6sYMU1DISDhqMvkApFkzYzcq6WBYjsyxITiK+mM/
   Q=;
X-IronPort-AV: E=Sophos;i="6.14,254,1736812800"; 
   d="scan'208";a="475819171"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 20:25:34 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:49585]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.34:2525] with esmtp (Farcaster)
 id 29df3243-f202-4afe-88dd-755645ac6c78; Mon, 17 Mar 2025 20:25:32 +0000 (UTC)
X-Farcaster-Flow-ID: 29df3243-f202-4afe-88dd-755645ac6c78
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 17 Mar 2025 20:25:32 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.54) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 17 Mar 2025 20:25:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <ncardwell@google.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/2] tcp/dccp: remove icsk->icsk_timeout
Date: Mon, 17 Mar 2025 13:24:52 -0700
Message-ID: <20250317202519.24094-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250317151401.3439637-2-edumazet@google.com>
References: <20250317151401.3439637-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA004.ant.amazon.com (10.13.139.93) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Sorry for the noise, I replied to another thread

From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Mar 2025 15:14:00 +0000
> icsk->icsk_timeout can be replaced by icsk->icsk_retransmit_timer.expires
> 
> This saves 8 bytes in TCP/DCCP sockets and helps for better cache locality.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

We may want to add a paired WRITE_ONCE() in __mod_timer() later.

Btw, DCCP removal series is almost ready and I will post it
in the next cycle as the patch queue is long now.

