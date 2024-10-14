Return-Path: <netdev+bounces-135311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0443999D81B
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1969B1C20A7E
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E306B1D0144;
	Mon, 14 Oct 2024 20:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DrFOamXT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7193F1D0942
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728937296; cv=none; b=gUKUP9S7ZlmnrvISmlHTlEASYNpsGRhH7GZubebyHOMx60WeeaxzUYCPktMe2t92FIRzx7Qz7K4Kq0ZK2H07XrT1Kwy+EDBG4Dx7kyJut14QA3nk/rYk69VJ6GvjIif4USziEtTlFSvs+PMCs7pW88T+8GeiDv/4jpiFSNZnj6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728937296; c=relaxed/simple;
	bh=REtm5n7+1DZ4k0KtNm9WCi5peXxPk/FZEMNthSvKfTQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O1cw/ZwXaqjmaP51PDfGrA4pIU7o2TIzXz8fVPl4IODeStOcuuToyBDqiiFIOVDmN11YwZ9wa8NDKFJHFe9AZR0151p9l2lMVuuUlu4OuaImZnr9E+HMsXMyQ3GpT5i2bjnzYQrlbxwrnw+5PC8ubhBEelSrAHnjFg0GaCEug9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=DrFOamXT; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728937295; x=1760473295;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3bDxMx9hDUc5wn3aOL+B3lBxn+/ttl89v2cRT5uPzNg=;
  b=DrFOamXT/gdxsokQvTnhHHVhnY+gVHnRajswf/2/g5G/1eidK3zvzWZ9
   0ALQ3GVzll2/0Zb62VuFWJViyWdz/VnEDD4Nb9egl8p/JrQyzmCUDesxj
   XwHodYnI8kCB9+3o6CoKSqQWDYstdU+W7O4TL4N78LDEwZE1g/oEmobkJ
   U=;
X-IronPort-AV: E=Sophos;i="6.11,203,1725321600"; 
   d="scan'208";a="138009099"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 20:21:34 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:7512]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.107:2525] with esmtp (Farcaster)
 id cd792d99-86c7-47b8-a056-b7605a942c32; Mon, 14 Oct 2024 20:21:34 +0000 (UTC)
X-Farcaster-Flow-ID: cd792d99-86c7-47b8-a056-b7605a942c32
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 14 Oct 2024 20:21:33 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 14 Oct 2024 20:21:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 09/11] dcb: Use rtnl_register_many().
Date: Mon, 14 Oct 2024 13:18:26 -0700
Message-ID: <20241014201828.91221-10-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D046UWB002.ant.amazon.com (10.13.139.181) To
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
 net/dcb/dcbnl.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/dcb/dcbnl.c b/net/dcb/dcbnl.c
index 2e6b8c8fd2de..03eb1d941fca 100644
--- a/net/dcb/dcbnl.c
+++ b/net/dcb/dcbnl.c
@@ -2408,6 +2408,11 @@ static struct notifier_block dcbnl_nb __read_mostly = {
 	.notifier_call  = dcbnl_netdevice_event,
 };
 
+static const struct rtnl_msg_handler dcbnl_rtnl_msg_handlers[] __initconst = {
+	{.msgtype = RTM_GETDCB, .doit = dcb_doit},
+	{.msgtype = RTM_SETDCB, .doit = dcb_doit},
+};
+
 static int __init dcbnl_init(void)
 {
 	int err;
@@ -2416,8 +2421,7 @@ static int __init dcbnl_init(void)
 	if (err)
 		return err;
 
-	rtnl_register(PF_UNSPEC, RTM_GETDCB, dcb_doit, NULL, 0);
-	rtnl_register(PF_UNSPEC, RTM_SETDCB, dcb_doit, NULL, 0);
+	rtnl_register_many(dcbnl_rtnl_msg_handlers);
 
 	return 0;
 }
-- 
2.39.5 (Apple Git-154)


