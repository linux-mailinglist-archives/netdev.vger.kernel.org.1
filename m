Return-Path: <netdev+bounces-151707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7989F0A81
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57BFE160822
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9661CCEF6;
	Fri, 13 Dec 2024 11:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DOjh9PvW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90CB1CDA02
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 11:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088316; cv=none; b=ujALqfPMyaej3PWsZ4zOMxRjpNOsnfrMfjoMTlAtQYF8XeOOqtJuECdIoVpr3Tp83k86in1lWC/swxd8uuFvgTCEcugHiTvHEqFdPsUGLHCb5aEMlvGO1IzrpzZBqgEM+NCh3SZvO0+Ag/alnoNjd4JbjHQPph4QT+DT4VBDWBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088316; c=relaxed/simple;
	bh=LH5Ea3AfyGdky8lFvPrEx8m1QVF3iFeyReRwf8R7BY4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rtrcPrLBcrDQznL5PN8TPtMjBRQpMg4I5yy9kQY41sEfsMtwZo9GjTAkRIwtmy9ms0oVWBtmBBxvdWMO0VrEqOLs7Qg5kJ8UpgQTj+uQbq6023aL/voPHr2OiYU86rODvFBaIoRIWtlO2TZ8uz8TYu71AvvS1WITZiORnri2Lvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=DOjh9PvW; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734088312; x=1765624312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FIqvG3T3uxjlqC/3t1EzUuZ8b4z+6P4WgucNcZjPGCg=;
  b=DOjh9PvW2C94V/PXBIXoTkjRh+ohxBN++gxJz2CdXpxtIbsYZ8SsaubQ
   eexYuMUSp1MbkaBh2g4wYk9Tfo8WjAOsvC+zE8iVqxRW5IeI/TExegBE3
   nDSMvSvQT7+n8jM4jhdtR1ZhuK0r+zmEkwwQhHMrtmeg+XbZi4aErAWEc
   A=;
X-IronPort-AV: E=Sophos;i="6.12,231,1728950400"; 
   d="scan'208";a="455788410"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 11:11:48 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:49406]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.119:2525] with esmtp (Farcaster)
 id 26df468a-90d5-437d-bc0c-d00621ef9475; Fri, 13 Dec 2024 11:11:47 +0000 (UTC)
X-Farcaster-Flow-ID: 26df468a-90d5-437d-bc0c-d00621ef9475
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 11:11:47 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.208) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 11:11:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 08/12] af_unix: Split restart label in unix_dgram_sendmsg().
Date: Fri, 13 Dec 2024 20:08:46 +0900
Message-ID: <20241213110850.25453-9-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241213110850.25453-1-kuniyu@amazon.com>
References: <20241213110850.25453-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

There are two paths jumping to the restart label in unix_dgram_sendmsg().

One requires another lookup and sk_filter(), but the other doesn't.

Let's split the label to make each flow more straightforward.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index ae74fdcf5dcd..513d0fd12e6a 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2042,8 +2042,8 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 
-restart:
 	if (!other) {
+lookup:
 		other = unix_find_other(sock_net(sk), msg->msg_name,
 					msg->msg_namelen, sk->sk_type);
 		if (IS_ERR(other)) {
@@ -2059,6 +2059,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 		goto out_free;
 	}
 
+restart:
 	sk_locked = 0;
 	unix_state_lock(other);
 restart_locked:
@@ -2106,7 +2107,8 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 		other = NULL;
 		if (err)
 			goto out_free;
-		goto restart;
+
+		goto lookup;
 	}
 
 	if (other->sk_shutdown & RCV_SHUTDOWN) {
-- 
2.39.5 (Apple Git-154)


