Return-Path: <netdev+bounces-112604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9B193A207
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 15:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3FD281A21
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 13:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965691552ED;
	Tue, 23 Jul 2024 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="FEhWLIEj"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DA6154429
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721742716; cv=none; b=YfUrj5c0AcfUPos2iPCgjtvtrBOoiiog9+A0poWUlxaXdhblvAPfVaRU8qkBmy//E7nVz54A0AHQVP3U0y9ueSFcZT+YyFbCNZNduy1l3oK52326WDX1dfhE7SSyqNHPEmgbW/ie0zG9C0VqAAF/m0InUdzej2YBHZvi4o9frmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721742716; c=relaxed/simple;
	bh=GdMnyF52RBPzA7i8yG/LLMp4buPCGVahtbKDGe6X0Kg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P37XzIWucxHRXTN3DCoMGNeSGeFFon4rDWErq4jbODCUVSnMNGCwTXml9SIspRxqmqeDxXu8cucPgiQzNZZ2kQFYIthpXv0g3rXmRnpKHPEH/cwJQJhSOToJqwKMXG2rfpPB42UFcmyW+tMd6uVADVXoB74eYB1lqqWzLYupffs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=FEhWLIEj; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:47:b279:6330:ae0d])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id CE9AE7DCF5;
	Tue, 23 Jul 2024 14:51:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1721742706; bh=GdMnyF52RBPzA7i8yG/LLMp4buPCGVahtbKDGe6X0Kg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com|Subject:=20[RFC=20PAT
	 CH=2014/15]=20l2tp:=20cleanup=20eth/ppp=20pseudowire=20setup=20cod
	 e|Date:=20Tue,=2023=20Jul=202024=2014:51:42=20+0100|Message-Id:=20
	 <682bb87ca135fd7de91fecb192b8b5db1087a773.1721733730.git.jchapman@
	 katalix.com>|In-Reply-To:=20<cover.1721733730.git.jchapman@katalix
	 .com>|References:=20<cover.1721733730.git.jchapman@katalix.com>|MI
	 ME-Version:=201.0;
	b=FEhWLIEjli3e6ZHyvQYGat8m+SqUUBTnHRZZABUGEAwwFfoTjHous/WaPyLQTh+AU
	 5hhLIVTbjYMHSgYaXfKMDnL0a9ML/IGezq9KdH3NSWDFo/WUL6NuP2YZCDXXkIlB3C
	 Wl62A3MQGHxxyVEzNY/+cq86G5vXfFbs4oPvsRFh+OpZKxguEEJ0tkb07YRy3vU98f
	 IrHUS4RJTxbZeNipFdivvrpTpWFLFDr+Sqpmu6JryR6222tnV0ZNiXJd0/PX7+JdsK
	 J2U3XV2jZ3Ag530LcPz9A4OtXaYT6uDN5S6hy9fYnn5OKZXIna16cNbQYuSojz6tCR
	 TdHiHCcKR8QOw==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com
Subject: [RFC PATCH 14/15] l2tp: cleanup eth/ppp pseudowire setup code
Date: Tue, 23 Jul 2024 14:51:42 +0100
Message-Id: <682bb87ca135fd7de91fecb192b8b5db1087a773.1721733730.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721733730.git.jchapman@katalix.com>
References: <cover.1721733730.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2tp eth/ppp pseudowire setup/cleanup uses kfree() in some error
paths. Drop the refcount instead such that the session object is
always freed when the refcount reaches 0.
---
 net/l2tp/l2tp_eth.c | 2 +-
 net/l2tp/l2tp_ppp.c | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
index 8ba00ad433c2..cc8a3ce716e9 100644
--- a/net/l2tp/l2tp_eth.c
+++ b/net/l2tp/l2tp_eth.c
@@ -322,7 +322,7 @@ static int l2tp_eth_create(struct net *net, struct l2tp_tunnel *tunnel,
 	l2tp_session_dec_refcount(session);
 	free_netdev(dev);
 err_sess:
-	kfree(session);
+	l2tp_session_dec_refcount(session);
 err:
 	return rc;
 }
diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 1b79a36d5756..90bf3a8ccab6 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -770,6 +770,8 @@ static int pppol2tp_connect(struct socket *sock, struct sockaddr *uservaddr,
 			goto end;
 		}
 
+		drop_refcnt = true;
+
 		pppol2tp_session_init(session);
 		ps = l2tp_session_priv(session);
 		l2tp_session_inc_refcount(session);
@@ -778,10 +780,10 @@ static int pppol2tp_connect(struct socket *sock, struct sockaddr *uservaddr,
 		error = l2tp_session_register(session, tunnel);
 		if (error < 0) {
 			mutex_unlock(&ps->sk_lock);
-			kfree(session);
+			l2tp_session_dec_refcount(session);
 			goto end;
 		}
-		drop_refcnt = true;
+
 		new_session = true;
 	}
 
@@ -875,7 +877,7 @@ static int pppol2tp_session_create(struct net *net, struct l2tp_tunnel *tunnel,
 	return 0;
 
 err_sess:
-	kfree(session);
+	l2tp_session_dec_refcount(session);
 err:
 	return error;
 }
-- 
2.34.1


