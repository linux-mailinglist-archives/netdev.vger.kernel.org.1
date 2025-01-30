Return-Path: <netdev+bounces-161701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9BEA237C9
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 00:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F3AF3A56CB
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 23:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C2E185B4C;
	Thu, 30 Jan 2025 23:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rjwVdSXz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45447081F
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 23:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738279499; cv=none; b=hhLJfMD72l/lyQtKvOr4CHMVGVZHvUd01JasXmUIjFfWjnkMCqDfiGTMeSROphuoqhri5rh44h3EX6lQ4GbjlJG3+JUIJfOVV654aTbXISptzlP1/VvlQfUx6k3MlYUWHlwgjrjoEIDHZfn6vKbiWu/bB/RZy4NALW6gq2S6WkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738279499; c=relaxed/simple;
	bh=96k4NZUvynoaNxUWutqhqXQcNgYvgu+UZluOOMj9vnE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JbW9paOgTIy2+/H3CtBUcFhomzI2G5fZf0fswY4Nbm2veoY+mFIioImPVVswFIUHtvNQgPEMjrw4Mxb9BlIJEIrgSYY9rFQmzZop3pdxksVM3Z4o9JLljH6er/hrgpVJnBzZYF/j/MXtz1lKfN1axqSg2OyfXSdOq0x+T0gCPJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rjwVdSXz; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738279498; x=1769815498;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HJ6oZaKkppjzys2Knm6wQcTxDHCq7cjwhuGQkRiYU2s=;
  b=rjwVdSXza2+aFajOQWV/GwLUwZs+Zan7HFJcFwRA2UpSuEX84pIPNcXT
   Oj64HeVK+bs8oxckJd3OPqXhCvdSHZifk1KvSjaxSrXNYvGtWIT59o52x
   LYhsNeYEGfMm5koSJaP5VDzeqn7/deHMqW3uVLcQaeuNCB42XBgiyL7AR
   k=;
X-IronPort-AV: E=Sophos;i="6.13,246,1732579200"; 
   d="scan'208";a="693243698"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2025 23:24:54 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:63505]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.117:2525] with esmtp (Farcaster)
 id b2dca34b-d1b9-4fde-9862-1b9f128c138e; Thu, 30 Jan 2025 23:24:53 +0000 (UTC)
X-Farcaster-Flow-ID: b2dca34b-d1b9-4fde-9862-1b9f128c138e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 30 Jan 2025 23:24:52 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 30 Jan 2025 23:24:50 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 0/2] net: Fix race of rtnl_net_lock(dev_net(dev)).
Date: Thu, 30 Jan 2025 15:24:33 -0800
Message-ID: <20250130232435.43622-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Yael Chemla reported that commit 7fb1073300a2 ("net: Hold rtnl_net_lock()
in (un)?register_netdevice_notifier_dev_net().") started to trigger KASAN's
use-after-free splat.

The problem is that dev_net(dev) fetched before rtnl_net_lock() might be
different after rtnl_net_lock().

The patch 1 fixes the issue by checking dev_net(dev) after rtnl_net_lock(),
and the patch 2 fixes the same potential issue that would emerge once RTNL
is removed.


Kuniyuki Iwashima (2):
  net: Fix dev_net(dev) race in unregister_netdevice_notifier_dev_net().
  dev: Use rtnl_net_dev_lock() in unregister_netdev().

 net/core/dev.c | 65 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 17 deletions(-)

-- 
2.39.5 (Apple Git-154)


