Return-Path: <netdev+bounces-66347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BA383E933
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 03:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C4121C23012
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 02:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40EC12B68;
	Sat, 27 Jan 2024 02:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F4KkgIgm"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DB3BE62
	for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 02:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706320887; cv=none; b=aT+rZIYr9OQpRRoc/ZOQWoZurRIje2nNBgafI6r8TueHVwXYMgrFuxA/FBWBP4T3fj/Hx7XuV6rYEHuwGNv+ZUWwCCevFxE2VTSPjKgLTHFZ5rkyl04UP1jPqH14stEVN9RX+22KADzjj2VyM3xhQURW5JuZCD89XtvShuIyg/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706320887; c=relaxed/simple;
	bh=pn08eJXs7OnPxSN3c37dEpPPa01CX6MaTgxVEqfxj/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SGInM277p97RjJLgFDbF2N1i9fqL5v6IidhTM8htrz5s883eI7KoCjNZ5xIpPFFRK5TjsZFY23cRuR+AafCnRz0zMXtVYqs6cdJLa2XHssToCYh69uAO/KmvdvbieVU9eIHnk1oPa0eJnqxeA8LSMfx7tKSAqpH8HAtV2h8PjaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F4KkgIgm; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706320882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n3Eqaf0JpcfE9VphQ2k45PLVkc2qGy56bLUTBAo+DzE=;
	b=F4KkgIgmy9OcwE8R7133eu10UjSiwQ1vtF3lEAuLstprPg8mmQNw459i07XrtJKuoEInSd
	KGODWGEyybcTIMH1FA+OsjO/ieWDxnXaJhcyoe+XjVAVJ0I3CNUQzvkdYv50vlcGnx4t4B
	m87eQSBMwzmxcmk73I7VnSpOFATmdnc=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-fsdevel@vgerkernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	peterz@infradead.org,
	boqun.feng@gmail.com
Subject: [PATCH 3/4] net: Convert sk->sk_peer_lock to lock_set_cmp_fn_ptr_order()
Date: Fri, 26 Jan 2024 21:01:07 -0500
Message-ID: <20240127020111.487218-4-kent.overstreet@linux.dev>
In-Reply-To: <20240127020111.487218-1-kent.overstreet@linux.dev>
References: <20240127020111.487218-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Cc: netdev@vger.kernel.org
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 net/core/sock.c    | 1 +
 net/unix/af_unix.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 158dbdebce6a..da7360c0f454 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3474,6 +3474,7 @@ void sock_init_data_uid(struct socket *sock, struct sock *sk, kuid_t uid)
 	sk->sk_peer_pid 	=	NULL;
 	sk->sk_peer_cred	=	NULL;
 	spin_lock_init(&sk->sk_peer_lock);
+	lock_set_cmp_fn_ptr_order(&sk->sk_peer_lock);
 
 	sk->sk_write_pending	=	0;
 	sk->sk_rcvlowat		=	1;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index ac1f2bc18fc9..d013de3c5490 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -706,10 +706,10 @@ static void copy_peercred(struct sock *sk, struct sock *peersk)
 
 	if (sk < peersk) {
 		spin_lock(&sk->sk_peer_lock);
-		spin_lock_nested(&peersk->sk_peer_lock, SINGLE_DEPTH_NESTING);
+		spin_lock(&peersk->sk_peer_lock);
 	} else {
 		spin_lock(&peersk->sk_peer_lock);
-		spin_lock_nested(&sk->sk_peer_lock, SINGLE_DEPTH_NESTING);
+		spin_lock(&sk->sk_peer_lock);
 	}
 	old_pid = sk->sk_peer_pid;
 	old_cred = sk->sk_peer_cred;
-- 
2.43.0


