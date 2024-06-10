Return-Path: <netdev+bounces-102376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6D8902BCF
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 00:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DBA6280FDE
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 22:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A7815098F;
	Mon, 10 Jun 2024 22:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mD+kYNc3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E705466B
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 22:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718059097; cv=none; b=tOu6ebs1vxHAen/oQm0/q4EojuguM9TUjmLzkkmCCDcD7WLfocJD6TdMPjMbF3ULBKXb5L83N/2rqW1+ieX15ofcj7Moyyjtlxo3MX1VAmbNYnIme7LTUhkUjZ2Db+USCDfOHQRqwfv2yRVsVvKmeVcJT9S629juzBiCr191jw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718059097; c=relaxed/simple;
	bh=hpttgVn22xQ91PVIDS3S64poe79nU7c+E3uTSpVGVV4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tuadhN5fxRCxHOFz9vwK7di0mhdVEDfCLVdFQyl2272S0KBPUlG9NgzDuEFx7lCl/CRfSCmVJPVU86cZkpCzCpCiRRmYS40CoMEVgZP3akzgRhjSwu0kaYf9HuMQGjkT97MxcWsoCkD0G1zbFNRdWXLaOCm1tmVAR818Fx6Kh4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mD+kYNc3; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718059093; x=1749595093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XJ1d7cz8uWyNJxvjujXTiKLryHOkMgwrTD0sdIHVs+c=;
  b=mD+kYNc31kpbHGsDaVETCymKjYxyPtq9bZElfrOlGghgZLlROEdQZHsb
   1ok8Kkt+jvB0qbKN3Gov2GADkkAME+FP1ZK4E9Y5DVe+8pSrK1ZIgca0Q
   mlJhm35lmn641/NRJrQoNNKuOWXWLUc7P+VmcLyEslmlNDla1jR1qnyrT
   k=;
X-IronPort-AV: E=Sophos;i="6.08,228,1712620800"; 
   d="scan'208";a="732580750"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 22:38:07 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:15183]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.35:2525] with esmtp (Farcaster)
 id 65cd80ca-ed4d-4626-a468-c286203b60ae; Mon, 10 Jun 2024 22:38:06 +0000 (UTC)
X-Farcaster-Flow-ID: 65cd80ca-ed4d-4626-a468-c286203b60ae
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 10 Jun 2024 22:38:06 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 10 Jun 2024 22:38:04 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 07/11] af_unix: Remove U_LOCK_GC_LISTENER.
Date: Mon, 10 Jun 2024 15:34:57 -0700
Message-ID: <20240610223501.73191-8-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240610223501.73191-1-kuniyu@amazon.com>
References: <20240610223501.73191-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA003.ant.amazon.com (10.13.139.31) To
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


