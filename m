Return-Path: <netdev+bounces-183473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F95A90C6D
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 21:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9A63B2A32
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 19:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611B9224220;
	Wed, 16 Apr 2025 19:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SyR+q4kC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEEC1E1C29;
	Wed, 16 Apr 2025 19:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744832191; cv=none; b=PktyomSdGIwO8AHHLa5RmFEBMjYwnDdZgM81CjQ8O42elYRYS5zVz2sfEPbweMqEYANDnXuK9wE1j8kYp/zWYDCFFKmW0Q9FcJbA3rkrL9RxhLZOyEh5UqnCcfY2XcLmFA5Jy5viV9Q6cHOtzc39uX2mdWypZEpEypeWd5WEXKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744832191; c=relaxed/simple;
	bh=sk6ZmLktKothKrYB9u4OPRZZ9exvwEOGkfDKvVDQXFM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FzwYlJ0Cg/PqWqwMwL0YvCVgDEm6md4mcXF9ACPaG1TtD7u2XqHTUQiN5B/IOYvzjIZ7YFZCb2yqTCNTw2PihIQlc3m1yR/Z+QOAiZZRv6/ijtnuaRPEF6ylEN/q4ptMPAMJIHooXz9pIy2VHpYXdmaceDpuINFmJC+0Km40f9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=SyR+q4kC; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744832190; x=1776368190;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6RBUxFztchZw7glVy76c73uvPI+lQYsfYgGiS/Z1R6E=;
  b=SyR+q4kCZBuo+JbSRBJfIkYhlr3m1JtTYHHZr3m8/5b0gaVk10CMXmWF
   9TgBC3K5pMuUiTHNVXPXNbhwlOGbQqadDrkwvnjJk/k23InIufEZTBtx6
   T0JXmjfZ0iGeYUmOFqwD7sPZ7h9+bkFFND/U/ESKyv4MdjdY5L7RgE56p
   A=;
X-IronPort-AV: E=Sophos;i="6.15,217,1739836800"; 
   d="scan'208";a="736205495"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 19:36:04 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:32778]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.160:2525] with esmtp (Farcaster)
 id b2479079-6d46-40d9-b761-533cc65d24df; Wed, 16 Apr 2025 19:36:03 +0000 (UTC)
X-Farcaster-Flow-ID: b2479079-6d46-40d9-b761-533cc65d24df
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 19:36:02 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 19:35:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kernel-team@meta.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<mathieu.desnoyers@efficios.com>, <mhiramat@kernel.org>,
	<ncardwell@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<rostedt@goodmis.org>
Subject: Re: [PATCH net-next] trace: tcp: Add const qualifier to skb parameter in tcp_probe event
Date: Wed, 16 Apr 2025 12:35:28 -0700
Message-ID: <20250416193542.19206-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416-tcp_probe-v1-1-1edc3c5a1cb8@debian.org>
References: <20250416-tcp_probe-v1-1-1edc3c5a1cb8@debian.org>
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

From: Breno Leitao <leitao@debian.org>
Date: Wed, 16 Apr 2025 10:06:12 -0700
> Change the tcp_probe tracepoint to accept a const struct sk_buff
> parameter instead of a non-const one. This improves type safety and
> better reflects that the skb is not modified within the tracepoint
> implementation.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


