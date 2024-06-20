Return-Path: <netdev+bounces-105460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 720D29113F8
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 22:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12731C20B8F
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 20:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A3B74267;
	Thu, 20 Jun 2024 20:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KeFPUqXm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C87B65D
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 20:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718917171; cv=none; b=OPHDa1VaNhDAddp3RyPFss7+bjp2sByOLpnxKZHFj59xdgKKGEGEvIRXi1QGhlXq7diB86fqi69nTj5FQ5jV3ZTxXmfaaCh5C8B2YPbgdzeIzF1Jwr70d2YygkJHGlUR8jYWkQ1HiGvScnvhdFElGC0uBgw9M1VScRVbbfKPvLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718917171; c=relaxed/simple;
	bh=hpttgVn22xQ91PVIDS3S64poe79nU7c+E3uTSpVGVV4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pFhV2LsnXoUokefrQO4iFxYegEFPV5dd0xEIShVkJLfps2+H0tk+yFJbekSw0EfQwmePPzuRANYWa5dx/Hg0iW51xudYatEXxxPYfuZzbn1tQOGI6V/Tl+7SkH7b+EXDm8xoY2qm3hCF6ERkI6dcc9zIUHluDzEtdFLqPPpIxX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KeFPUqXm; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718917170; x=1750453170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XJ1d7cz8uWyNJxvjujXTiKLryHOkMgwrTD0sdIHVs+c=;
  b=KeFPUqXm6L/MV0gLT+ntHCoF4XUYcXKYVfxsw7+a9SwPoeUx0kWH6VFs
   x2Y3t1F87FrKA55UwtK08aIsKDo9DlefrTZe6RycXgLXPAotU/iJ0IgEe
   AT7YLVgo2wmxT94KVXmrQqkG4SKrmMKPT+o7rF8zXEtX48Jr3sY2jzDW1
   I=;
X-IronPort-AV: E=Sophos;i="6.08,252,1712620800"; 
   d="scan'208";a="409074374"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 20:59:27 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:24788]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.208:2525] with esmtp (Farcaster)
 id 146a4255-7ed5-4053-bfe0-5bdf214737a9; Thu, 20 Jun 2024 20:59:25 +0000 (UTC)
X-Farcaster-Flow-ID: 146a4255-7ed5-4053-bfe0-5bdf214737a9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 20 Jun 2024 20:59:24 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 20 Jun 2024 20:59:22 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v4 net-next 07/11] af_unix: Remove U_LOCK_GC_LISTENER.
Date: Thu, 20 Jun 2024 13:56:19 -0700
Message-ID: <20240620205623.60139-8-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240620205623.60139-1-kuniyu@amazon.com>
References: <20240620205623.60139-1-kuniyu@amazon.com>
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

Commit 1971d13ffa84 ("af_unix: Suppress false-positive lockdep splat for
spin_lock() in __unix_gc().") added U_LOCK_GC_LISTENER for the old GC,
but it's no longer needed for the new GC.

Let's remove U_LOCK_GC_LISTENER and unix_state_lock_nested() as there's
no user.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index c42645199cee..63129c79b8cb 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -96,18 +96,6 @@ struct unix_sock {
 
 #define unix_state_lock(s)	spin_lock(&unix_sk(s)->lock)
 #define unix_state_unlock(s)	spin_unlock(&unix_sk(s)->lock)
-enum unix_socket_lock_class {
-	U_LOCK_NORMAL,
-	U_LOCK_GC_LISTENER, /* used for listening socket while determining gc
-			     * candidates to close a small race window.
-			     */
-};
-
-static inline void unix_state_lock_nested(struct sock *sk,
-				   enum unix_socket_lock_class subclass)
-{
-	spin_lock_nested(&unix_sk(sk)->lock, subclass);
-}
 
 #define peer_wait peer_wq.wait
 
-- 
2.30.2


