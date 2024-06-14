Return-Path: <netdev+bounces-103722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 520A2909336
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 22:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED78A1F23C00
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 20:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571B71A38F4;
	Fri, 14 Jun 2024 20:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LDMhy9ZL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61B31A2549
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 20:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718395831; cv=none; b=cWp6bVr59s1RAeShNijyAeRP9sZuOy99Ic7anNkL5qo52B0WqqOD9PJKHsIVx7FWeerS3HJKU43jb3fL1pBjlmlwboJBPTR22WREZKdKtGPkx+UGbXtpoYnNQPyzZ9CryXwZHDWcGMsK1Vp7EDPMPIVwjTMfoFPqybMWylZirpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718395831; c=relaxed/simple;
	bh=hpttgVn22xQ91PVIDS3S64poe79nU7c+E3uTSpVGVV4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U2ZlBs6+sk6Y0sFn/BG/OlhGaQwDUDY8h6QJypZ8RyxF4VEGE4jpyGRoxxj/4F0qLm6wqA/7I5cioLK8fbQ+4seS0wXxizDAdmNT+CqgZPd405OMAa6flk71DnmkqXa+iMEtkZfRcsbyOn7Oin+w3VeYAMDiKRhbPjTnnyRTusY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LDMhy9ZL; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718395830; x=1749931830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XJ1d7cz8uWyNJxvjujXTiKLryHOkMgwrTD0sdIHVs+c=;
  b=LDMhy9ZL9TyX9Xrlv3MWLKQps8cfCeRZFWhBAn5bWRNYjz2kRQ/8VLib
   I/koKi8BdAMMsGEpaM9a6zo4nsIQ8PK8C609gF+MxiaPjWY79y0PFtChH
   G0BWEgI42rqfVuIbdjrmHEAb3my9bRycdL916KQawLZq407y5e/R9PzdR
   k=;
X-IronPort-AV: E=Sophos;i="6.08,238,1712620800"; 
   d="scan'208";a="302327437"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 20:10:28 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:63341]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.144:2525] with esmtp (Farcaster)
 id 33fa8833-562a-4880-87e6-b123f6bb3877; Fri, 14 Jun 2024 20:10:27 +0000 (UTC)
X-Farcaster-Flow-ID: 33fa8833-562a-4880-87e6-b123f6bb3877
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 14 Jun 2024 20:10:27 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 14 Jun 2024 20:10:24 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 07/11] af_unix: Remove U_LOCK_GC_LISTENER.
Date: Fri, 14 Jun 2024 13:07:11 -0700
Message-ID: <20240614200715.93150-8-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240614200715.93150-1-kuniyu@amazon.com>
References: <20240614200715.93150-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
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


