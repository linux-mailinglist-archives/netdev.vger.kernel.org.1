Return-Path: <netdev+bounces-135301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA80999D811
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9321C23282
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164EB1CACE0;
	Mon, 14 Oct 2024 20:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YGygIAuN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DD414A4E7
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728937187; cv=none; b=jhNQKcX7MDPpc0TkpgedmUJ9nD3DZFCzKpg6xjoNFX3+J92NQgZfmozTGfbi+7P6Rk4jSbvj3E3gYuBgxv/QdyqcTnSDhTwAzMG7rpDs5/kiDC+PuULAg9JrI1+OJIuzjXRTv/gtqA6CxVmHGYC/YZ1//d296vZXWTprCRpmaQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728937187; c=relaxed/simple;
	bh=JQqCBZkKMNWy0d5HEiF+NcllIv46C5rVwWb8Yv78FFQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gr7n4H3GrC5TObpO5YsqflzaaRV6RsGY6t6efOZCLyeNAgY2pz6hhCcoWDnxFOP6p/nAfIhME8IqMz7BrL6/Zt3aRvvDOF5u+f73o7nojetrTCEnx4Dc/8Xx/RzJnEAfr48yp0b6n24JG/tYxrIFfPxDudnstzihq1zOW2JX8yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=YGygIAuN; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728937186; x=1760473186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=axLHbL6WETRSVjcLpgXLrPyJvv3fS63WznCvaksse+Q=;
  b=YGygIAuNFiiGyZi/b8JdhYSVMHVm93l1CnppmSUUtoU5v/Wy70i6iEAf
   WTVYYeoxLAneGkh2jBu6FFMDIHNzfIpDTUK/DwOhNvvH/yB12PUwtv7iI
   +iq/4EV/o36QS9Ru8BLx5uVIMXlpg7lTW5Sfs0GVrV42xJESDQC8VrXav
   M=;
X-IronPort-AV: E=Sophos;i="6.11,203,1725321600"; 
   d="scan'208";a="33160897"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 20:19:37 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:38377]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.202:2525] with esmtp (Farcaster)
 id 13f503de-f6f9-41d1-8103-38a6d8eaf540; Mon, 14 Oct 2024 20:19:36 +0000 (UTC)
X-Farcaster-Flow-ID: 13f503de-f6f9-41d1-8103-38a6d8eaf540
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 14 Oct 2024 20:19:35 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 14 Oct 2024 20:19:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 03/11] neighbour: Use rtnl_register_many().
Date: Mon, 14 Oct 2024 13:18:20 -0700
Message-ID: <20241014201828.91221-4-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D039UWA003.ant.amazon.com (10.13.139.49) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will remove rtnl_register() in favour of rtnl_register_many().

When it succeeds, rtnl_register_many() guarantees all rtnetlink types
in the passed array are supported, and there is no chance that a part
of message types is not supported.

Let's use rtnl_register_many() instead.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v2:
  * Add __initconst
  * Use C99 initialisation
---
 net/core/neighbour.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 77b819cd995b..395ae1626eef 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3886,17 +3886,18 @@ EXPORT_SYMBOL(neigh_sysctl_unregister);
 
 #endif	/* CONFIG_SYSCTL */
 
+static const struct rtnl_msg_handler neigh_rtnl_msg_handlers[] __initconst = {
+	{.msgtype = RTM_NEWNEIGH, .doit = neigh_add},
+	{.msgtype = RTM_DELNEIGH, .doit = neigh_delete},
+	{.msgtype = RTM_GETNEIGH, .doit = neigh_get, .dumpit = neigh_dump_info,
+	 .flags = RTNL_FLAG_DUMP_UNLOCKED},
+	{.msgtype = RTM_GETNEIGHTBL, .dumpit = neightbl_dump_info},
+	{.msgtype = RTM_SETNEIGHTBL, .doit = neightbl_set},
+};
+
 static int __init neigh_init(void)
 {
-	rtnl_register(PF_UNSPEC, RTM_NEWNEIGH, neigh_add, NULL, 0);
-	rtnl_register(PF_UNSPEC, RTM_DELNEIGH, neigh_delete, NULL, 0);
-	rtnl_register(PF_UNSPEC, RTM_GETNEIGH, neigh_get, neigh_dump_info,
-		      RTNL_FLAG_DUMP_UNLOCKED);
-
-	rtnl_register(PF_UNSPEC, RTM_GETNEIGHTBL, NULL, neightbl_dump_info,
-		      0);
-	rtnl_register(PF_UNSPEC, RTM_SETNEIGHTBL, neightbl_set, NULL, 0);
-
+	rtnl_register_many(neigh_rtnl_msg_handlers);
 	return 0;
 }
 
-- 
2.39.5 (Apple Git-154)


