Return-Path: <netdev+bounces-137605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9869A7268
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 20:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BD1E1F24FD8
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 18:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FC51F9428;
	Mon, 21 Oct 2024 18:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UF9iofpa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB21E1946CF
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729535612; cv=none; b=XMVYn8q3C/bzovUqAg7nEIkRM3zGHer+EhEfkBBsmU50vjAsRyQRDRzTf789LRsVcaCIIKkFOMduksn8oQCu4CHKYtyNnmHYdHv4k+3zsLaqfb2o+Z9DbpAnrVaHMRaV41rw7wm/jWJmBOjQL6YhSuSfOZqp9LZ1ynEsz+ilVJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729535612; c=relaxed/simple;
	bh=e9eYf8ocJtBN7UmLdnWW+pnQdOWzOpOss5v7KLHJHnc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uShEFzyHJpB93vpXioj1ulkBivYnkwCqF+AdJQeRjhDzTIK1CY/BcVm9xKgXwGRN0r/eZS16bFD/v1fUiBjFeMdtU4Y9C7xXkvGKolQ9q7F0JlCdhccIK85t8B9y9/cVHCiEkVYVBJ2DkVlWZZJk/t4QgFppxAdEiJbVI/lDIpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UF9iofpa; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729535611; x=1761071611;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4jdXphkwekVqPH34JCSUoN6Zjbe0kXRmeYsIE1l8le4=;
  b=UF9iofpaAhm+LADCwqaGKHqlTv6oIxP7dg4WyUpPMMFUR/szVbPSg5Ky
   1ZLdWQQfyjHxlc16dtqt7iawnGIlChKZuhEsnxbWpzJ0PtvGW/M1m+0kn
   OzX0lXba8eq11fOFr8yt4krZp+Qe0w8G8NUqU+UL9HjQb1i+/SdYcPWl1
   I=;
X-IronPort-AV: E=Sophos;i="6.11,221,1725321600"; 
   d="scan'208";a="345303485"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 18:33:26 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:44630]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.202:2525] with esmtp (Farcaster)
 id 998fb92b-3c9f-4911-8b36-42bbcb081d1a; Mon, 21 Oct 2024 18:33:25 +0000 (UTC)
X-Farcaster-Flow-ID: 998fb92b-3c9f-4911-8b36-42bbcb081d1a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 21 Oct 2024 18:33:23 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.222.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 21 Oct 2024 18:33:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 02/12] rtnetlink: Define RTNL_FLAG_DOIT_PERNET for per-netns RTNL doit().
Date: Mon, 21 Oct 2024 11:32:29 -0700
Message-ID: <20241021183239.79741-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241021183239.79741-1-kuniyu@amazon.com>
References: <20241021183239.79741-1-kuniyu@amazon.com>
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

We will push RTNL down to each doit() as rtnl_net_lock().

We can use RTNL_FLAG_DOIT_UNLOCKED to call doit() without RTNL, but doit()
will still hold RTNL.

Let's define RTNL_FLAG_DOIT_PERNET as an alias of RTNL_FLAG_DOIT_UNLOCKED.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/rtnetlink.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index bb49c5708ce7..3fa9da93364b 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -11,6 +11,7 @@ typedef int (*rtnl_dumpit_func)(struct sk_buff *, struct netlink_callback *);
 
 enum rtnl_link_flags {
 	RTNL_FLAG_DOIT_UNLOCKED		= BIT(0),
+#define RTNL_FLAG_DOIT_PERNET		RTNL_FLAG_DOIT_UNLOCKED
 	RTNL_FLAG_BULK_DEL_SUPPORTED	= BIT(1),
 	RTNL_FLAG_DUMP_UNLOCKED		= BIT(2),
 	RTNL_FLAG_DUMP_SPLIT_NLM_DONE	= BIT(3),	/* legacy behavior */
-- 
2.39.5 (Apple Git-154)


