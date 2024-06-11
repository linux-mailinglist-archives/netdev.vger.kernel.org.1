Return-Path: <netdev+bounces-102742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D239046F5
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 00:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFCEE283020
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 22:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F688153501;
	Tue, 11 Jun 2024 22:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SLcuypgy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CB47711C
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 22:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718145132; cv=none; b=aeGWMDwao5wI9ivkwY/+efRfQVNuQAfeI2KufURaujKQOYUG433igoaSz+ROyeiN7Qf6/dEt1YGuZ0N+v5URafumVofztH0/OmK/aa/Pa2wwdt8ks6gaAzFvfedvXjXOCGZER7navfDTISThQZEAPtnSTH4pe11BeNtqDDcIKco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718145132; c=relaxed/simple;
	bh=hpttgVn22xQ91PVIDS3S64poe79nU7c+E3uTSpVGVV4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NOxJ3Eyb17PXXii/VtOtgNvYYiUju5u2K/j+qZCWrtzYcprsnM7/J1CjJsCKLtOBUhg8ylbi2qvhz/qWXpqMcTMZuAHsKpiH7TByuT4i1TJrsC7WO/BHmahBzKhGVYNBoj1PB6PBjtfpKCDHxmeq50PBshi62A7IJldI81u6H78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=SLcuypgy; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718145130; x=1749681130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XJ1d7cz8uWyNJxvjujXTiKLryHOkMgwrTD0sdIHVs+c=;
  b=SLcuypgyiHdVhrfDdgL3a5qGoc/DHf/W4ipywfNm33z0UQMcoXlRQVYi
   Y4XZDsmM4uPGO/aeeJ2GWt3skqU7gNXv+Mtp0yhjuyfhpzaD4qW+zH/7z
   mueY0smkXds3inEFLQrp2d2eOvLqmaUC6Vypj/8jj2d2Aw4a7P6JshpB9
   0=;
X-IronPort-AV: E=Sophos;i="6.08,231,1712620800"; 
   d="scan'208";a="402691628"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 22:32:09 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:13456]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.144:2525] with esmtp (Farcaster)
 id 08239d95-3de9-4243-a36e-f85c6658e386; Tue, 11 Jun 2024 22:32:08 +0000 (UTC)
X-Farcaster-Flow-ID: 08239d95-3de9-4243-a36e-f85c6658e386
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 11 Jun 2024 22:32:07 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 11 Jun 2024 22:32:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 07/11] af_unix: Remove U_LOCK_GC_LISTENER.
Date: Tue, 11 Jun 2024 15:29:01 -0700
Message-ID: <20240611222905.34695-8-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240611222905.34695-1-kuniyu@amazon.com>
References: <20240611222905.34695-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
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


