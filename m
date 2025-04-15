Return-Path: <netdev+bounces-182566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B31A891CF
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 04:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC630189706C
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 02:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928DD1FDE0E;
	Tue, 15 Apr 2025 02:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="edJw5BWI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF821A2632
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 02:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744683828; cv=none; b=ZktPy8++iMb5mRR2wAg3rlLzgg6N0MFI0mxHIZDX2KRDFVRPU1DYAKdtSuypBFFGez49n1EbDGWMNevN7IvUE2p7UmgFXgkHcCVt63KbQgmCgDZYMsv9TCq0jd0F+G/vpmqzdfeqieVRhYV8DM5z17IL/yI99AOS6Dm2tJ64xUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744683828; c=relaxed/simple;
	bh=XWH/MWaqpQv2l5xiQZ0fjASEFVhpz7BFDdAxoZBlUJY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nAKYyN8MsdVjz7vxQCW702d9L58mdFoEcQjyNuRkNLBzsufNZ8idia2kpmzCukkktcHNLDPDyGoCd7VPmVQnNkhWgEt2rCxXGBc3GZBQ4/opWaiw4k5+Wo0PBWZI47yLCIQgnfNBr91w0wKBiBeuPr2RwFryjtYZzEzVWnjqR3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=edJw5BWI; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744683827; x=1776219827;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=31yWK4FrBxWncKPq5xTIcWCDdms9bTpCgTUO3anUYt4=;
  b=edJw5BWIeUFbN/34t9mXWzJYiIuhs8YFU+Lt3S902+fSCs5Qy2F+Clh6
   KGGhCqA8E5AYp2x5oPutAOJv8xQTnK0Yfp96M1aYaQlHWR3S42UoHGDxv
   x9wJpFhqp/oJKPqibRKCFkr0TdJy8vx39ST8OIrjHUixkN/FGUSkxH3oo
   k=;
X-IronPort-AV: E=Sophos;i="6.15,213,1739836800"; 
   d="scan'208";a="483083524"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 02:23:44 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:33182]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.222:2525] with esmtp (Farcaster)
 id ba550c0b-b52a-4986-9f51-7c6fb0be13c5; Tue, 15 Apr 2025 02:23:43 +0000 (UTC)
X-Farcaster-Flow-ID: ba550c0b-b52a-4986-9f51-7c6fb0be13c5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 15 Apr 2025 02:23:42 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 15 Apr 2025 02:23:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 0/3] net: Followup series for ->exit_rtnl().
Date: Mon, 14 Apr 2025 19:21:58 -0700
Message-ID: <20250415022258.11491-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA002.ant.amazon.com (10.13.139.39) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Patch 1 drops the hold_rtnl arg in ops_undo_list() as suggested by Jakub.
Patch 2 & 3 apply ->exit_rtnl() to pfcp and ppp.


Kuniyuki Iwashima (3):
  net: Drop hold_rtnl arg from ops_undo_list().
  pfcp: Convert pfcp_net_exit() to ->exit_rtnl().
  ppp: Split ppp_exit_net() to ->exit_rtnl().

 drivers/net/pfcp.c            | 23 +++++++----------------
 drivers/net/ppp/ppp_generic.c | 23 ++++++++---------------
 net/core/net_namespace.c      | 14 ++++++++------
 3 files changed, 23 insertions(+), 37 deletions(-)

-- 
2.49.0


