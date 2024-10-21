Return-Path: <netdev+bounces-137335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 390819A5882
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 03:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC93282472
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 01:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8C010A1E;
	Mon, 21 Oct 2024 01:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QGhDscV+"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130A1BE65;
	Mon, 21 Oct 2024 01:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729473912; cv=none; b=cjOxZsZ7iR5TvMMnxDe5RoWFIbjTy+ORhQmCRI0upUezcnavsH59OHcpXNCf7q+xgZxVvoaGGp9U47Tj4oMKtklP4Qzl2hBWsVQYRzfUxpQXYbtmdbHZaVvJPbmw3bNYTKFKxcO4lWGfXK88Vp8EOfackcX91+Djyb7eks8hmc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729473912; c=relaxed/simple;
	bh=bxM0ZLnlcZakhZciREqbmanZ3MijgpsLdgCyFRhr840=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lj8e4Ucdy3wf0J5dyi4e50UjnY7XLn66NLiYINISe6LyTLq52dhRG1xjjCghwEyZp4GmT1in9d53N/xsZKhbLZf+h8eNHHM0LW6lY60VM7QY+qW2pzFU/KpJyyd9GYF/+6d2e3/2Zeg7cxOn2d8XsC+KebxLvanlo2BOEymTTH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QGhDscV+; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=upPl/
	vJF+V+jNENLlbjlbuE9AJVSMOuiWd7sj3jAOxE=; b=QGhDscV+vj963g1cbCiGu
	uXSrELipg7iz94YU5jr7oScPeEyC/mAR0PuLN0mOBuNnPc7cDfHDYsJi0BL+zZDb
	dsFr03iEjAaPHKrvjjlSQFeuPnw3HaHrIO2fAjrGKKBwGR9aoV8USd63gbH/rXpX
	wY63N6y4m2N3uxWqBOZ6rY=
Received: from localhost.localdomain (unknown [47.252.33.72])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wBHz+NDrRVnf9t6CQ--.41457S2;
	Mon, 21 Oct 2024 09:24:24 +0800 (CST)
From: mrpre <mrpre@163.com>
To: edumazet@google.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.orgc,
	linux-kernel@vger.kernel.org
Cc: mrpre <mrpre@163.com>
Subject: [PATCH] bpf: fix filed access without lock
Date: Mon, 21 Oct 2024 09:24:09 +0800
Message-ID: <20241021012409.14084-1-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHz+NDrRVnf9t6CQ--.41457S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr1rCFy7Ar1fKr4rKw48Zwb_yoW8GFyrpF
	y7Cw109a1qyFWDAr4vyFWkJF13W3ySka4Uurn5W3y3Arsrur13tFWkKw4YyF1F9Fs2yF4a
	qrWjgF1jka1DCwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piuyIUUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiDxl-p2cVqsZQ3AAAsc

The tcp_bpf_recvmsg_parser() function, running in user context,
retrieves seq_copied from tcp_sk without holding the socket lock, and
stores it in a local variable seq. However, the softirq context can
modify tcp_sk->seq_copied concurrently, for example, n tcp_read_sock().

As a result, the seq value is stale when it is assigned back to
tcp_sk->copied_seq at the end of tcp_bpf_recvmsg_parser(), leading to
incorrect behavior.

Signed-off-by: mrpre <mrpre@163.com>
---
 net/ipv4/tcp_bpf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index e7658c5d6b79..7b44d4ece8b2 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -221,9 +221,9 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 				  int flags,
 				  int *addr_len)
 {
-	struct tcp_sock *tcp = tcp_sk(sk);
+	struct tcp_sock *tcp;
+	u32 seq;
 	int peek = flags & MSG_PEEK;
-	u32 seq = tcp->copied_seq;
 	struct sk_psock *psock;
 	int copied = 0;
 
@@ -238,7 +238,8 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 		return tcp_recvmsg(sk, msg, len, flags, addr_len);
 
 	lock_sock(sk);
-
+	tcp = tcp_sk(sk);
+	seq = tcp->copied_seq;
 	/* We may have received data on the sk_receive_queue pre-accept and
 	 * then we can not use read_skb in this context because we haven't
 	 * assigned a sk_socket yet so have no link to the ops. The work-around
-- 
2.43.5


