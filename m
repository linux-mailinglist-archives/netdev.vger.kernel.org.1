Return-Path: <netdev+bounces-189432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF14AB20EA
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 03:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85D609E46A8
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 01:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F22C2676CD;
	Sat, 10 May 2025 01:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="fzVOhU0+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB241DEFE0
	for <netdev@vger.kernel.org>; Sat, 10 May 2025 01:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746842330; cv=none; b=KqoJHRiYPeqq0JTclC+J1TbR79t/Uj1iGSXd5OqnjWMNMc2JJlOJyAsF+pEglwYMmZ/GcEU688NsCtrvWi0+dV0QER8UMB53bQi58h9SgumC0k4I7JOGSHiy4Ntk1vL1p7SEaltZVxhG7ax8+G+vVstghzIx458oQeBwcZztp4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746842330; c=relaxed/simple;
	bh=tFqiZPO51+2KZTxEEPFJPTZ3yo5zhM5IXf0IfrjdQL4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HSe0e5kdQCwD/i6bc4e7VfQAP2IpKhQb382hWP3BxyZqcqCG0p6p4nfqBKHcykbpw0q9wEpvqFbjm2CQNU/Azuc7Udj//ch5/rnOpXfjzdR7beVyQNbVRsmUes/5dt+sf1eMBRfPMnT6/1cPd9slIhedtzcd9dAhpeJBtswphB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=fzVOhU0+; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1746842329; x=1778378329;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K0ziDdpNQcZyXHf0L9GubuUPvwj5NSWrjHqtMVxMoWM=;
  b=fzVOhU0+yLsKHCZuI5i9yxt0VDd8XHgH8nVA5V4ewsx3ZQ4OeGOybDwp
   HEwv3z6dG5fbmj0gT9GdMnUkqMvV03LiC7DV7rLIQ/RvRut47XozmyQMP
   7Ft8/fuJSqkSU3sm4zA6Wg7g627ka1ZBlL7p4IuztIzvZviddg74Nsdqp
   BRVaCisRtDbXsSqSFO/ky+zHjkNWPk1rMsQWU2OGML+SrD1JVnCT9lvJ+
   jEhOLRhICpiQWF7u9QOXZS/pYSp75pHGIvp2ODc1zG1V3D5sqmnRRkY6S
   5yueemgvy7BCvpfwgXXGUV+Ov33ECkef6ejGOCrW7C1CXZW8PsLb2Ckcf
   g==;
X-IronPort-AV: E=Sophos;i="6.15,276,1739836800"; 
   d="scan'208";a="296292670"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2025 01:58:45 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:44979]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.231:2525] with esmtp (Farcaster)
 id d652fc3b-745f-4d97-ae15-2dbdec90c0b0; Sat, 10 May 2025 01:58:44 +0000 (UTC)
X-Farcaster-Flow-ID: d652fc3b-745f-4d97-ae15-2dbdec90c0b0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 10 May 2025 01:58:44 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 10 May 2025 01:58:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 4/9] tcp: Restrict SO_TXREHASH to TCP socket.
Date: Fri, 9 May 2025 18:56:27 -0700
Message-ID: <20250510015652.9931-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250510015652.9931-1-kuniyu@amazon.com>
References: <20250510015652.9931-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

sk->sk_txrehash is only used for TCP.

Let's restrict SO_TXREHASH to TCP to reflect this.

Later, we will make sk_txrehash a part of the union for other
protocol families, so we set 0 explicitly in getsockopt().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/sock.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index b64df2463300..5c84a608ddd7 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1276,6 +1276,8 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		return 0;
 		}
 	case SO_TXREHASH:
+		if (!sk_is_tcp(sk))
+			return -EOPNOTSUPP;
 		if (val < -1 || val > 1)
 			return -EINVAL;
 		if ((u8)val == SOCK_TXREHASH_DEFAULT)
@@ -2102,8 +2104,11 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_TXREHASH:
-		/* Paired with WRITE_ONCE() in sk_setsockopt() */
-		v.val = READ_ONCE(sk->sk_txrehash);
+		if (sk_is_tcp(sk))
+			/* Paired with WRITE_ONCE() in sk_setsockopt() */
+			v.val = READ_ONCE(sk->sk_txrehash);
+		else
+			v.val = 0;
 		break;
 
 	default:
-- 
2.49.0


