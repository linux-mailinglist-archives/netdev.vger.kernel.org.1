Return-Path: <netdev+bounces-135299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B93A399D80F
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16D61C230AB
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FA51C303E;
	Mon, 14 Oct 2024 20:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qP9BO3Ic"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D231B14A4E7
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728937141; cv=none; b=uRg53gPV1jaL6EtO6nn+ydbQDkLSqQrkTmbUTBQJb0C8ivZlRO4hW1UNqcAEkoU+mVywulv+VnusECNL64a5IkdvOjXmSiVfYdg1DvZIpwJ+v8BJ5oEB/E8BC5+G0hfs9y9bKUBar0SEQ5SkxUGdxIaSf9iWGu5StJDVNJNmuL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728937141; c=relaxed/simple;
	bh=+Y9uCTkMLtmEaqsGilNPtaxWczfErYQcBvAzYo5VYIM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/oaHrith9V9C5DtqRo20MOhQmyTIk8L/wnA0W6JjrcmEoUE9e9txootrGxMNM1p/1qSRSbpAQh0H4Nw0tYwUKFhqNHICLXUvv3crE3UWguHtbCmjT9MqDoY8qp20oJH1qovTWRvJsIZEUdAK11J7zJoRFx6YV58dhxkwTfPHY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qP9BO3Ic; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728937140; x=1760473140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5eaDIWkJq2yiQK0ZgjineUhdUGe5OmxH1wU4VFozsFA=;
  b=qP9BO3IcvlpHYjiVK8QxTKXagPfizYg5G8r4sgWR8UvJgyPfoKEPpNQ6
   3ZKv2ZVaG8MhmrkEd4NTUyguAtQOFKY/iwsDch8IJsEkZtm7zWWFti/1I
   mtFWh/2FFgvxUYQmZFTfRnAP8+yPjiZ31QTce2nRWXzIei4sioT4LyQ+e
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,203,1725321600"; 
   d="scan'208";a="687516714"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 20:18:57 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:19307]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.23:2525] with esmtp (Farcaster)
 id 18aa3f51-6cd7-457b-95e0-02fe7c4271e3; Mon, 14 Oct 2024 20:18:56 +0000 (UTC)
X-Farcaster-Flow-ID: 18aa3f51-6cd7-457b-95e0-02fe7c4271e3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 14 Oct 2024 20:18:56 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 14 Oct 2024 20:18:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 01/11] rtnetlink: Panic when __rtnl_register_many() fails for builtin callers.
Date: Mon, 14 Oct 2024 13:18:18 -0700
Message-ID: <20241014201828.91221-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241014201828.91221-1-kuniyu@amazon.com>
References: <20241014201828.91221-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
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


