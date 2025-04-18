Return-Path: <netdev+bounces-184007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB89A92EDA
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93F3F19E630A
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 00:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCD42C1A2;
	Fri, 18 Apr 2025 00:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CY2HwhlA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A1E2AEE1
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 00:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744936471; cv=none; b=FbwgWy2Xdvuzr9eU4C4u1qkVoiLtyhmLB2UFBVGtPRsU/9TTm0TEdwPAPzSvcSf0DDynvc48RixK9BepmLBBPh/44PyPAY2uF4mK7mzpLw9EZ5Cvf0WIxC7A4GjdytExRMNqPl7tNSguzqMSzT45inlnFBsDyjB56BIFq0NevAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744936471; c=relaxed/simple;
	bh=U3d5NJTg6XeTSYd3ie4i6bfmpuXD1tGAt5Lnyups6zY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pwBUL9UFzg6p+m+/ft2KOHEFTMl3GioVPJS25oCj9U2KvNEwDKk25aaQFfSglYlT+leUIVWqin4tZzW5tkmjoUk19TGv9kAn6C0S0vWQ2sUh6yLLR8iayragfYjUSR5BI1B7FszaaLWFRqG9D9M9O/KlEGfyVITNKfuoZ3Ibn5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CY2HwhlA; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744936468; x=1776472468;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cj6GKE9Ba1jPXaRY0LSeU9oFvmQgBb8X+Tnw3Wau49k=;
  b=CY2HwhlAgE9eQa6BpG6KmSt9jVsQL/kuC2o5e4dTVxkofi/dXUqovk9L
   hb2GSg6TROs0xrMjju3icKxCpsLw572jA+8LccdnixlOsmn3ymT9sgcJK
   pLD+RIAmQYidTZNLng+XuM3uuoKiUl1z696APIaju9L6JVPCrIjJ1sQVp
   o=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="11410336"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2025 00:33:13 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:29184]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.20:2525] with esmtp (Farcaster)
 id 57d9725d-7404-4208-86be-5b2648dc380f; Fri, 18 Apr 2025 00:33:12 +0000 (UTC)
X-Farcaster-Flow-ID: 57d9725d-7404-4208-86be-5b2648dc380f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:33:10 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 18 Apr 2025 00:33:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 0/3] net: Followup series for ->exit_rtnl().
Date: Thu, 17 Apr 2025 17:32:31 -0700
Message-ID: <20250418003259.48017-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Patch 1 drops the hold_rtnl arg in ops_undo_list() as suggested by Jakub.
Patch 2 & 3 apply ->exit_rtnl() to pfcp and ppp.


Changes:
  v2:
    * Patch 3
      * Fix build failure by forward declaration

  v1: https://lore.kernel.org/netdev/20250415022258.11491-1-kuniyu@amazon.com/


Kuniyuki Iwashima (3):
  net: Drop hold_rtnl arg from ops_undo_list().
  pfcp: Convert pfcp_net_exit() to ->exit_rtnl().
  ppp: Split ppp_exit_net() to ->exit_rtnl().

 drivers/net/pfcp.c            | 23 +++++++----------------
 drivers/net/ppp/ppp_generic.c | 25 ++++++++++---------------
 net/core/net_namespace.c      | 14 ++++++++------
 3 files changed, 25 insertions(+), 37 deletions(-)

-- 
2.49.0


