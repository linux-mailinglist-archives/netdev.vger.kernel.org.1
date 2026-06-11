Return-Path: <netdev+bounces-297945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xAVXCLVKKmqkmAMAu9opvQ
	(envelope-from <netdev+bounces-297945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:42:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D51A66EBED
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:42:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=Wh62qles;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297945-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297945-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A831F30285E2
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 05:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DD52D7DCE;
	Thu, 11 Jun 2026 05:41:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3F12D73A6;
	Thu, 11 Jun 2026 05:41:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781156477; cv=none; b=jeSpDuxfQYBTRGPF5YZZ3zNfYWuh1yKpmQNEGE0SdMC0DgbUrmkpL27MbjCPxmIFo0Ow2SxI31G5+ZLcLev1h+vHZVRvmZ/3opoEtU9igAoD/adlxBj6jKPaRO8WiZ6+++dXDSTZe7riGCuvjKAACGcnTqVo/iTh/kwLdRj1n7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781156477; c=relaxed/simple;
	bh=zNhSz9qkj/R/JPKrsHJ/8swefL7yZ533Jy3IcqFSOYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fyys/96uETmQtswDaDH/FR8AguLhl8zRvMqD043hSNCaDFCBPgyOh3mDrf+M5bNxeuha8/uCXnZzd4p0OPNvsbqTm7yrZY132EF+qoSzshW51y2hMBXcR1sZvzDSVE16K8QTmQIJvPmbTWXfxROP7R8wnrgvQY8jATTXk8qRV80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Wh62qles; arc=none smtp.client-ip=101.71.155.101
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 41f34cbf7;
	Thu, 11 Jun 2026 13:35:50 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn
Subject: [PATCH net] kcm: use WRITE_ONCE() when changing lower socket callbacks
Date: Thu, 11 Jun 2026 13:35:43 +0800
Message-Id: <20260611053543.2429462-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9eb52dfb5003a1kunm749f299f151649
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGRlIVh5JSEwaGRgYSRlPS1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Wh62qlestxxamE67cnVsrhQBj2GWm00zwRSEc4ypNOLTGZ3yZLCc0RRrKGQS94xnq5edxVWbG7BrkDkbH4u2z/ZCBDV9mwUCmnrofm2pi66Ywfq/BpeNMjQHI9dcuPtleuvZLEirTEl+01G2FarSHVbib3rTlT0QbpfgKQLAi3w=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=ncKks4DbVhQBQ7h7h5aEf/PTg8Wuk4hMQqO7a7tGI2U=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297945-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:runyu.xiao@seu.edu.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,seu.edu.cn:dkim,seu.edu.cn:email,seu.edu.cn:mid,seu.edu.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D51A66EBED

kcm_attach() replaces a live lower TCP socket's sk_data_ready and
sk_write_space callbacks with KCM handlers, and kcm_unattach() restores
them later. Those callback-pointer updates are still plain stores even
though the same fields can be read and invoked concurrently on other
CPUs.

If another CPU observes an older callback snapshot after the live field
has already been restored, callback execution can run with a mismatched
target and sk_user_data state, leading to stale or misdirected wakeups.

Use WRITE_ONCE() for the callback replacement and restore operations so
these shared callback fields follow the same visibility contract already
established by the earlier 4022 fixes.

Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 net/kcm/kcmsock.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index f6d44481954c..dc126f7f030c 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1304,8 +1304,8 @@ static int kcm_attach(struct socket *sock, struct socket *csock,
 	psock->save_write_space = csk->sk_write_space;
 	psock->save_state_change = csk->sk_state_change;
 	csk->sk_user_data = psock;
-	csk->sk_data_ready = psock_data_ready;
-	csk->sk_write_space = psock_write_space;
+	WRITE_ONCE(csk->sk_data_ready, psock_data_ready);
+	WRITE_ONCE(csk->sk_write_space, psock_write_space);
 	csk->sk_state_change = psock_state_change;
 
 	write_unlock_bh(&csk->sk_callback_lock);
@@ -1381,8 +1381,8 @@ static void kcm_unattach(struct kcm_psock *psock)
 	 */
 	write_lock_bh(&csk->sk_callback_lock);
 	csk->sk_user_data = NULL;
-	csk->sk_data_ready = psock->save_data_ready;
-	csk->sk_write_space = psock->save_write_space;
+	WRITE_ONCE(csk->sk_data_ready, psock->save_data_ready);
+	WRITE_ONCE(csk->sk_write_space, psock->save_write_space);
 	csk->sk_state_change = psock->save_state_change;
 	strp_stop(&psock->strp);
 
-- 
2.34.1

