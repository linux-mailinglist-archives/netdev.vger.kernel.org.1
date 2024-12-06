Return-Path: <netdev+bounces-149598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B38D9E66DD
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 06:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 810D2169C40
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 05:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B277B196C67;
	Fri,  6 Dec 2024 05:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XSgG1Ugs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB63E193426
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 05:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733462949; cv=none; b=N47wm0e8VGaAKc7Mz+xeKumnWUH93t7ba0ug4zZ0mL5XjEchhxxR9zdE4mGlqtjeWj/SddyOrkG+ArXNH+nUeBzptPcNxgxx4lI1oQqJjs1fpQX27F8f7TiHuwhOhfQUbti7gFBA33Dyfdqon2N2fe+53mRr/qW3FgLIj5gestI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733462949; c=relaxed/simple;
	bh=kBFW08EmqGbuURevf0DRmkpV1OecBUB+YDE/K8fz7y0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nVoTAvb9mhzS6Kdk+GSxb4wGT6hYBCplEzZjqodfGCYASIoQvEcBeXE39pILEpT7/1LI6qrG5Z4PTxsQbry95RdseGyk5uzIhaq/iyUndAlHBUE35pQnncOtSeUcFNlCguqRoFSJdZ++sY8fVny/NlqzDHjXyn4MZZ8OnWWGlCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=XSgG1Ugs; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733462948; x=1764998948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tquafT2nEkHa/MX4JPEsv+IjU5lhBfZUtbG3xh4TJk4=;
  b=XSgG1UgsC/sDN5SASfdNUGkQGnNaw0N2nb1/RQ/zm/oF9DucWsGAPDmX
   1nYfGM5gnqXluy4x7GRzZedQzQGbd/eQDSRD7IgEm2TLhO9EBv2/QxYvQ
   U0G1DNYgkStnqkWdVcaFHqbIOaGW+rNcQnG42xdej3cK/vXfrSL8on8ko
   U=;
X-IronPort-AV: E=Sophos;i="6.12,212,1728950400"; 
   d="scan'208";a="453862208"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 05:29:07 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:21351]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.223:2525] with esmtp (Farcaster)
 id 272bec68-16bd-4522-a7ad-b84c687da510; Fri, 6 Dec 2024 05:29:05 +0000 (UTC)
X-Farcaster-Flow-ID: 272bec68-16bd-4522-a7ad-b84c687da510
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 6 Dec 2024 05:29:04 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.244.93) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 6 Dec 2024 05:29:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 08/15] af_unix: Move !sunaddr case in unix_dgram_sendmsg().
Date: Fri, 6 Dec 2024 14:26:00 +0900
Message-ID: <20241206052607.1197-9-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241206052607.1197-1-kuniyu@amazon.com>
References: <20241206052607.1197-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When other is NULL in unix_dgram_sendmsg(), we check if sunaddr
is NULL before looking up a receiver socket.

There are three paths going through the check, but it's always
false for 2 out of the 3 paths: the first socket lookup and the
second 'goto restart'.

The condition can be true for the first 'goto restart' only when
SOCK_DEAD is flagged for the socket found with msg->msg_name.

Let's move the check to the single appropriate path.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 6fb1811da4cd..0f39fe3451e0 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2046,11 +2046,6 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 
 restart:
 	if (!other) {
-		if (!sunaddr) {
-			err = -ECONNRESET;
-			goto out_free;
-		}
-
 		other = unix_find_other(sock_net(sk), sunaddr, msg->msg_namelen,
 					sk->sk_type);
 		if (IS_ERR(other)) {
@@ -2105,6 +2100,9 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 			err = -ECONNREFUSED;
 		} else {
 			unix_state_unlock(sk);
+
+			if (!sunaddr)
+				err = -ECONNRESET;
 		}
 
 		other = NULL;
-- 
2.39.5 (Apple Git-154)


