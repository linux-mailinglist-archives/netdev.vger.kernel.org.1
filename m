Return-Path: <netdev+bounces-149600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07BE9E66E0
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 06:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFDCB285032
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 05:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B215198A06;
	Fri,  6 Dec 2024 05:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Qr+T+kek"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC4E194120
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 05:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733462993; cv=none; b=X4avIc0rERbUvLYx7VJET88bCIqK9Stc11D4NbTX2e1slB8tl2IOmuOgeZAgnmx5f2BQVk40fDWUo8feBNDpC1bTvWwlKOiRzA/msFTMyd3Xn1MxXnlo/VBAp7cBNjhKeKBC9IuAdTdUPmxVW5UuZeuGVJLMEP2XSSfJd2T956U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733462993; c=relaxed/simple;
	bh=EJUTPiSkQvXrfWT5iL2UJrfRIQ2ZEaI0LcRlkZQNeCA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OxBUnpV6U37V7y9klPmsQ8P2axTnks6VBNCyr4irIjHAnptwfrHSywMoldG0eoB2yDIpP+SiyoeDubvfH4u/mZ7ahTj5U2KZupr+uD2lw/jY+fAA3iS7AzKC2lhQ73Ud7Jze8o9OzHbjkBuxA5ZbnOFsYGN/6u63HsOGhZc6ZKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Qr+T+kek; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733462991; x=1764998991;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O8sMXWcVnhypWOTo3dDGwAiRiZlLyJlNGgImUWdDLqw=;
  b=Qr+T+kek8PsKDcwURg9VqX3CI2otEYfF49V1Cxnr4zJp1q/oMPmRpqOT
   llaPrd+FQo1vLwOtfkB7hzGYhPTVpAVpDFGQydoOn2dXEMCQNFGR2WXvH
   xCiOzFkNGDLsaC3+nzJO/PHYBj16FvdIUeQwUkkQQ5R4F6iS+A0vXjL5S
   4=;
X-IronPort-AV: E=Sophos;i="6.12,212,1728950400"; 
   d="scan'208";a="391040078"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 05:29:46 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:22044]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.94:2525] with esmtp (Farcaster)
 id 6bfafdfa-c53c-47cd-812c-b45be31c6d83; Fri, 6 Dec 2024 05:29:46 +0000 (UTC)
X-Farcaster-Flow-ID: 6bfafdfa-c53c-47cd-812c-b45be31c6d83
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 6 Dec 2024 05:29:45 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.244.93) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 6 Dec 2024 05:29:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 10/15] af_unix: Split restart label in unix_dgram_sendmsg().
Date: Fri, 6 Dec 2024 14:26:02 +0900
Message-ID: <20241206052607.1197-11-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

There are two paths jumping to the restart label in unix_dgram_sendmsg().

One requires another lookup and sk_filter(), but the other doesn't.

Let's split the label to make each flow more straightforward.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index fdcd33b4e0ce..b23d36b049da 100644
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


