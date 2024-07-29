Return-Path: <netdev+bounces-113709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1887893F9A8
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 17:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5BB01F22649
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 15:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809EA15EFB8;
	Mon, 29 Jul 2024 15:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="UJEDcbQC"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F5715B999
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267500; cv=none; b=n51LLUn8UQ2KvqKqOK2J8uwCeD0nB5CSR2eZLGyj4pPE3jnfp1lpmjv7wLiamrlRu9KwEfLzUCJ0J6F83C+6vgAq3eRKmPLicCclUG62+B1bbdcZHKbtq3KcC6NeSEPOdFi0v2ExpgBfEGTtfIolETRt2BEb8cPWFppTj873CII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267500; c=relaxed/simple;
	bh=iwrAV0Oy+haf8BFZfT0YQGvqarR+1GJIRsKV+hO2FVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ij+jyi9OVTuS4vkiNxp3lnxO/zANao9+ofXnXyfaxhpyedSK0g2FqgV8WnJprAdXNBnk0xdwjAWSI3Bl72OTYHnQHC42QwC2LwoCQkR6DniAdeYCNpYCD9lHWDLW1PuyFlbtY1F/HlzDREEULV1W8o95AL2XvwP+sgH23+O1vIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=UJEDcbQC; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:6c24:bf58:f1fe:91c1])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id B6F5F7DCFE;
	Mon, 29 Jul 2024 16:38:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1722267496; bh=iwrAV0Oy+haf8BFZfT0YQGvqarR+1GJIRsKV+hO2FVY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com|Subject:=20[PATCH=20n
	 et-next=2014/15]=20l2tp:=20cleanup=20eth/ppp=20pseudowire=20setup=
	 20code|Date:=20Mon,=2029=20Jul=202024=2016:38:13=20+0100|Message-I
	 d:=20<89b46dd2057cefe7758af4167b0b6fc327979bf4.1722265212.git.jcha
	 pman@katalix.com>|In-Reply-To:=20<cover.1722265212.git.jchapman@ka
	 talix.com>|References:=20<cover.1722265212.git.jchapman@katalix.co
	 m>|MIME-Version:=201.0;
	b=UJEDcbQCyUUxpMdNRCjXLPVGO7FaMc/4T/purvpYgS5cdUiGzVzBlycCBaIgrYRwJ
	 Sfcceas59+VeD4OzaCAFv+HiUrAbHXdVDar/WFcdn4INipS0c4PCoR6DHP1Qfermk6
	 CTmen1OpezXwSoJkOXOTTG7LHRXCr5dh90jeVDlbMtRUAPG7g4LH7/m8ykZQ6nqZ01
	 bRgBGmxTWgZhjfBCv0wIPIVa0jVQCMq3/+VbHUF5gMv0qFQ3xtgEoNH5iqC4sjEH3A
	 1W0qhaVuEe0yrXaCzXqrSdHtenPUEiK1yoJ+HATQMZxJ0xVWFupNonffGUheZbJW/D
	 mtIF7hS77WMmw==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com
Subject: [PATCH net-next 14/15] l2tp: cleanup eth/ppp pseudowire setup code
Date: Mon, 29 Jul 2024 16:38:13 +0100
Message-Id: <89b46dd2057cefe7758af4167b0b6fc327979bf4.1722265212.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722265212.git.jchapman@katalix.com>
References: <cover.1722265212.git.jchapman@katalix.com>
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

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
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


