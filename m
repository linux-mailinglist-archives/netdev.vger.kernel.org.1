Return-Path: <netdev+bounces-163417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EE9A2A377
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 09:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948691676B2
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 08:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BDF224AF1;
	Thu,  6 Feb 2025 08:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gGYyb+W8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FA05B211
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 08:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738831609; cv=none; b=ELAaIPjyM2lNJKP0hNO7KgRDtDZ/hZ1Hb66qNv+ZT2vmUFDtjcaRj8uSrzbLGUs97fgHfb04hVojAqiJYsUowWcqPHnCI808POY3w03pWDdYE2r70MUFZyqAhdNsMOZ+bmITw8abWbcIkY15aRyBiuAoMR7OGBPURJsnUu6Ql30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738831609; c=relaxed/simple;
	bh=4FsCqIa7FYkrN2ipYe0zDZoraCppxpsXiDcSOSdbhVo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XcLUWFxcwOW62FFuy4LZOfzWOzlQ1mzZn86HlSiORJYwJiq2rIoTtgzBZ37hqxgtnOYdb/xMwUNH4dYQWfWX31mDuOyBC7YJWYC6lXliAb8DYaz+Feyl3xVVI+0IUjzHydJixxVIHBMA/3eE4SM/IKWjy3yTLGXHgsx6ncYUpto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gGYyb+W8; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738831608; x=1770367608;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=32rsMvWv6vIzXYptYfxp0uGgzCO0vjGTqLKXyRmwyOQ=;
  b=gGYyb+W8ShDiLGiBr6vvpsnHnmjVNy/R8hstQ4b/mBTxEvISeriuka0H
   J1PmUcHQiIGe1Pjo/a7tCujKR8n2UWZSVdmBSWT3XJmt06MRnShhzmazX
   0NvsV7EQ26rZnKgETbPDEnrgk3dfcBTlmyl22FLOWQEk6GvP0oZGeZYnR
   M=;
X-IronPort-AV: E=Sophos;i="6.13,264,1732579200"; 
   d="scan'208";a="460143398"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 08:46:45 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:29913]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.41:2525] with esmtp (Farcaster)
 id e4ef6b65-886c-496f-a60d-6df65dd54d82; Thu, 6 Feb 2025 08:46:44 +0000 (UTC)
X-Farcaster-Flow-ID: e4ef6b65-886c-496f-a60d-6df65dd54d82
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 6 Feb 2025 08:46:43 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 6 Feb 2025 08:46:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 0/6] fib: rules: Convert RTM_NEWRULE and RTM_DELRULE to per-netns RTNL.
Date: Thu, 6 Feb 2025 17:46:23 +0900
Message-ID: <20250206084629.16602-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Patch 1 & 2 are small cleanup, and patch 3 ~ 6 make fib_nl_newrule()
and fib_nl_delrule() hold per-netns RTNL.


Kuniyuki Iwashima (6):
  fib: rules: Don't check net in rule_exists() and rule_find().
  fib: rules: Pass net to fib_nl2rule() instead of skb.
  fib: rules: Split fib_nl2rule().
  fib: rules: Convert RTM_NEWRULE to per-netns RTNL.
  fib: rules: Add error_free label in fib_nl_delrule().
  fib: rules: Convert RTM_DELRULE to per-netns RTNL.

 net/core/fib_rules.c | 131 ++++++++++++++++++++++++++++---------------
 1 file changed, 85 insertions(+), 46 deletions(-)

-- 
2.39.5 (Apple Git-154)


