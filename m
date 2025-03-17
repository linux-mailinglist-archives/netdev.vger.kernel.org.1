Return-Path: <netdev+bounces-175441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4AEA65F0C
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 21:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F6AA189D484
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 20:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD1C1DD529;
	Mon, 17 Mar 2025 20:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="THbJCqkm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5231A00F0
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 20:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742242972; cv=none; b=fXr30871Z2TEQPlyQqffG4l2azs8ip82E4xxe3XEVjrK061F/3uSbv1VvjhzfB8yWiLJ7ri1zHx/4ET0+0xe8hqtaSQD2+zsvxPfwNyFwAQMZ/NTwKm3cMclW5sFsVjtatPBBC+ccLdn7y1mjYYMi8EU+45iekOOYE3G1BYlpB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742242972; c=relaxed/simple;
	bh=Mp7AVDMrS/ib2NF/YH9bK2zFL4l/UsQbiIoIfb2AIaQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ICx45mS5LxWwhzEm5I6/IGv/u3EMzNQ0RnTxiV3X9fOeE2NnlSAhc9dWgEsy8Enqpjh9UvCMUXu1oHJFQIo0iUaYwwnL3gaieemlixn4z94Y5nt+hBON5WuC8jamC9pqm1Q19PbLeKwCL1ZSYqiWE0Ng2mQFOeQQeu/lDIrOeIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=THbJCqkm; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742242971; x=1773778971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=820PCY+r4yor30og4vk3YoLgyROldp4iQlCBKyu2L0c=;
  b=THbJCqkm7gIdKA0T4P3vLctVvqX8xSH0xPfh9hRsxYbmVJ6dRDdblTRT
   dDji7zL7kdcbaP9rrSFdwdzfwQUcjd3tYJpVfVP5nZG96yDPm+rtRcyaW
   xou75hgfAEhgfxZeq0oPxtqoDEZvfGgNAKZMK1937/YvHT7NjwjafweZq
   4=;
X-IronPort-AV: E=Sophos;i="6.14,254,1736812800"; 
   d="scan'208";a="471856928"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 20:22:46 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:10468]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.101:2525] with esmtp (Farcaster)
 id 32a216dc-5857-47ef-8500-0bc594ddfe38; Mon, 17 Mar 2025 20:22:45 +0000 (UTC)
X-Farcaster-Flow-ID: 32a216dc-5857-47ef-8500-0bc594ddfe38
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 17 Mar 2025 20:22:45 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.54) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 17 Mar 2025 20:22:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <borisp@nvidia.com>, <davem@davemloft.net>, <eric.dumazet@gmail.com>,
	<horms@kernel.org>, <john.fastabend@gmail.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <ncardwell@google.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/2] tcp/dccp: remove icsk->icsk_timeout
Date: Mon, 17 Mar 2025 13:21:56 -0700
Message-ID: <20250317202232.23864-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250317085313.2023214-1-edumazet@google.com>
References: <20250317085313.2023214-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

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

