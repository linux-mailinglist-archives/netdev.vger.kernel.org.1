Return-Path: <netdev+bounces-64908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5483837678
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 23:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 381D21F27439
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 22:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA31101C5;
	Mon, 22 Jan 2024 22:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EfJ0pFAx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA28C1D6AF
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 22:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705963494; cv=none; b=SpYWeZUZPuGhKrsTMnBjzM/kdpB+BoueyXrHMS6nRoYGHlqQY4tM9P35WrUQCxXuKKpjIRxXnJEc6G8Ag63Fo1Gu1cWCYDHQc4d5engeeXkENG9dDLRhB1Y6dOxsEWRvP4RC9Ch7JcBgC7+5mSgB1g08ElQjr5yblQdi8xRBAfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705963494; c=relaxed/simple;
	bh=lBwuFWoypWkTgnfwibnzqZKGeyp6x7+XR9DMnFmheFY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wy/qIeNum0UfzMu0tAsJMRwIPKJdTYHkvST7ymKHXpgQH341lvBenEKFVB9HE49gb419f4FRc55FR7Vr7qFJlDovFbMvJYCB4U9HMgQrG3nu3FN41dGGOA3NMk9Op3po8bOzu9ySXu1GgU6spw4eHd1bAfqEWQe9w7A2wrOCDn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=EfJ0pFAx; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705963492; x=1737499492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s5a451/FfBUUfwHqSpo58Um6XVjD23dEhkPAB9b6R1Y=;
  b=EfJ0pFAxLDtQxvnCJCXXkAOYX2n2SiFlmbAzWaPb3TS59Iz4LuiqCXWX
   +d3BnNavYrjvlTCCzzf9ht1CdvDsFzfabWg+7NpBD7Qa/sbopEsL5fllK
   2+zamFTF8L7riqWpqBIiP851KZMsxP+Xlb8YyQi4byNY/s362TqkJJxsW
   w=;
X-IronPort-AV: E=Sophos;i="6.05,212,1701129600"; 
   d="scan'208";a="268745096"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-a893d89c.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 22:44:50 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-a893d89c.us-west-2.amazon.com (Postfix) with ESMTPS id BBCC440BD4;
	Mon, 22 Jan 2024 22:44:49 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:54873]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.60:2525] with esmtp (Farcaster)
 id b01cf748-718b-4165-ac49-62a2e8129c2f; Mon, 22 Jan 2024 22:44:49 +0000 (UTC)
X-Farcaster-Flow-ID: b01cf748-718b-4165-ac49-62a2e8129c2f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 22:44:49 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Mon, 22 Jan 2024 22:44:45 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <eric.dumazet@gmail.com>,
	<gnault@redhat.com>, <kafai@fb.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 5/9] sock_diag: add module pointer to "struct sock_diag_handler"
Date: Mon, 22 Jan 2024 14:44:34 -0800
Message-ID: <20240122224434.20458-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240122112603.3270097-6-edumazet@google.com>
References: <20240122112603.3270097-6-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA004.ant.amazon.com (10.13.139.91) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Jan 2024 11:25:59 +0000
> Following patch is going to use RCU instead of
> sock_diag_table_mutex acquisition.
> 
> This patch is a preparation, no change of behavior yet.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

