Return-Path: <netdev+bounces-134705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 735AA99AE79
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 00:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1BFC1C21CA8
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 22:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D971D1E6C;
	Fri, 11 Oct 2024 22:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ItXV/sr3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4971D1E81
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 22:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728684380; cv=none; b=npb0R1mb9ItkT/3EZ3GBBhbWDZx473NYs+Jb0uOaBzKoDMuxjCCQPja8G85IXthYyKporN9T/Fw3v+aH882b7aPwzjWXeWkK4QO8gw+XugubrXU0Kow/Yq9oFWW8p1PwqQwmBKtizN+tA5eeSK99z2HlJTxVo6BQBAkmwOzocOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728684380; c=relaxed/simple;
	bh=+Y9uCTkMLtmEaqsGilNPtaxWczfErYQcBvAzYo5VYIM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t3xnXGfBsS2ZW6BHGr/DTZLrB+GwhHxfkbo8idLZf0nDpdXYm3xdeH9mv7FaUNaH7BCp2KNElXPTgbmjQj6ZokZtKV5z1w/+X7XbJXWHX0JjEupC5jmvvF5M9mW5pQ8hvNzwC/MKfhbF7H9nbxTNqt4hvqInYHdSVTVcLK5WQzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ItXV/sr3; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728684378; x=1760220378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5eaDIWkJq2yiQK0ZgjineUhdUGe5OmxH1wU4VFozsFA=;
  b=ItXV/sr3RyLAtwU2268DRz0w0Nfd3FP0CsJrdkxAjDeP7gCVnKfCxqcj
   aIfFfzMsqzmoi72KkgNxj9SqeQ7Jpqg/S/A8klNJ6UsY4ASPKCSwv56ny
   WpUyNFjHiK7tDX5tXGOsWmzflrHdfwb3HV+dwes1o+b8NqCSvgqypj9tC
   g=;
X-IronPort-AV: E=Sophos;i="6.11,196,1725321600"; 
   d="scan'208";a="137922787"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 22:06:17 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:26249]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.108:2525] with esmtp (Farcaster)
 id fab9d0b9-ba51-4b06-a894-7104ccffb55c; Fri, 11 Oct 2024 22:06:17 +0000 (UTC)
X-Farcaster-Flow-ID: fab9d0b9-ba51-4b06-a894-7104ccffb55c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 11 Oct 2024 22:06:16 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 11 Oct 2024 22:06:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 01/11] rtnetlink: Panic when __rtnl_register_many() fails for builtin callers.
Date: Fri, 11 Oct 2024 15:05:40 -0700
Message-ID: <20241011220550.46040-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241011220550.46040-1-kuniyu@amazon.com>
References: <20241011220550.46040-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will replace all rtnl_register() and rtnl_register_module() with
rtnl_register_many().

Currently, rtnl_register() returns nothing and prints an error message
when it fails to register a rtnetlink message type and handlers.

The failure happens only when rtnl_register_internal() fails to allocate
rtnl_msg_handlers[protocol][msgtype], but it's unlikely for built-in
callers on boot time.

rtnl_register_many() unwinds the previous successful registrations on
failure and returns an error, but it will be useless for built-in callers,
especially some subsystems that do not have the legacy ioctl() interface
and do not work without rtnetlink.

Instead of booting up without rtnetlink functionality, let's panic on
failure for built-in rtnl_register_many() callers.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/rtnetlink.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index edcb6d43723e..8f2cdb0de4a9 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -464,6 +464,10 @@ int __rtnl_register_many(const struct rtnl_msg_handler *handlers, int n)
 					     handler->msgtype, handler->doit,
 					     handler->dumpit, handler->flags);
 		if (err) {
+			if (!handler->owner)
+				panic("Unable to register rtnetlink message "
+				      "handlers, %pS\n", handlers);
+
 			__rtnl_unregister_many(handlers, i);
 			break;
 		}
-- 
2.39.5 (Apple Git-154)


