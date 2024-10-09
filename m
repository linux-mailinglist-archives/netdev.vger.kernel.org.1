Return-Path: <netdev+bounces-133952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A13659978FE
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 01:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5DA1C2197F
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 23:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A1819005B;
	Wed,  9 Oct 2024 23:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Pw7ReulM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B91A189520
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 23:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728515864; cv=none; b=kkJfsyfwhdPyTR44Tc9FvJmu1z07l9wA+2OqPwVu1o6UNBwwOt6DaqwjqRunKBDRJMM8fILtPNKN9t9llnBmY9LgW32cpPTlNZrl0kYaxMoFnPTVzmnj23k4K2XcbXXoDKLEs/M14Qltx19tWr642bNgcKlIB9TGrg9zjTtvPcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728515864; c=relaxed/simple;
	bh=Qlse9dbL0hYGczoL5Xr0KP7DHpmAO3hPHtJ9PTur2D0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KXF1JpcP3yUU2VUwh+HEgvwypDwN7FgIIW86FKHTb6SMRqTdHRmleBYgwsb8k3WNQRTMlVitb/q6fCEo1aC5MKgIgRUEvt2rzR6mNxaujcQdm3p1Pwd8kue9sjqx/6SASioiZ1Lt/8xIEzGh9911gF0zR5BXdo8H3a4T6TQc/NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Pw7ReulM; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728515863; x=1760051863;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FKTrj+y7n1Ht08PsuAvrcxa6R83Gz7nYOd4ebAZaWLo=;
  b=Pw7ReulM8+njN/biv+xd2rBpJEpWG4ZPxe0e64HG1QyTdTuKSNlg0+Bm
   Of7qDk65awYuew5ju0EtYVm/vdAjFChYnuWsIL/WO1Mbe0m4IQTxFNgZ9
   kIypDVHCKmOQVfW7NzhzmCZx69/c9F/AF/Vf/aEGyxspdFTsZURkF+Yof
   g=;
X-IronPort-AV: E=Sophos;i="6.11,191,1725321600"; 
   d="scan'208";a="765253818"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 23:17:42 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:33976]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.26:2525] with esmtp (Farcaster)
 id 5dfbd8ed-7f0c-4cea-a63b-2b48daf0ce4a; Wed, 9 Oct 2024 23:17:42 +0000 (UTC)
X-Farcaster-Flow-ID: 5dfbd8ed-7f0c-4cea-a63b-2b48daf0ce4a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 9 Oct 2024 23:17:41 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 9 Oct 2024 23:17:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 02/13] rtnetlink: Call validate_linkmsg() in do_setlink().
Date: Wed, 9 Oct 2024 16:16:45 -0700
Message-ID: <20241009231656.57830-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241009231656.57830-1-kuniyu@amazon.com>
References: <20241009231656.57830-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

There are 3 paths that finally call do_setlink(), and validate_linkmsg()
is called in each path.

  1. RTM_NEWLINK
    1-1. dev is found in __rtnl_newlink()
    1-2. dev isn't found, but IFLA_GROUP is specified in
          rtnl_group_changelink()
  2. RTM_SETLINK

The next patch factorises 1-1 to a separate function.

As a preparation, let's move validate_linkmsg() calls to do_setlink().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/rtnetlink.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index abc44ee018a0..bb14ddf2901e 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2854,6 +2854,10 @@ static int do_setlink(const struct sk_buff *skb,
 	char ifname[IFNAMSIZ];
 	int err;
 
+	err = validate_linkmsg(dev, tb, extack);
+	if (err < 0)
+		goto errout;
+
 	if (tb[IFLA_IFNAME])
 		nla_strscpy(ifname, tb[IFLA_IFNAME], IFNAMSIZ);
 	else
@@ -3268,10 +3272,6 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto errout;
 	}
 
-	err = validate_linkmsg(dev, tb, extack);
-	if (err < 0)
-		goto errout;
-
 	err = do_setlink(skb, dev, ifm, extack, tb, 0);
 errout:
 	return err;
@@ -3515,9 +3515,6 @@ static int rtnl_group_changelink(const struct sk_buff *skb,
 
 	for_each_netdev_safe(net, dev, aux) {
 		if (dev->group == group) {
-			err = validate_linkmsg(dev, tb, extack);
-			if (err < 0)
-				return err;
 			err = do_setlink(skb, dev, ifm, extack, tb, 0);
 			if (err < 0)
 				return err;
@@ -3743,10 +3740,6 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		if (nlh->nlmsg_flags & NLM_F_REPLACE)
 			return -EOPNOTSUPP;
 
-		err = validate_linkmsg(dev, tb, extack);
-		if (err < 0)
-			return err;
-
 		if (linkinfo[IFLA_INFO_DATA]) {
 			if (!ops || ops != dev->rtnl_link_ops ||
 			    !ops->changelink)
-- 
2.39.5 (Apple Git-154)


