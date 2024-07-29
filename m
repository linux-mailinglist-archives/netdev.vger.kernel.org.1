Return-Path: <netdev+bounces-113696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CFF93F99C
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 17:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B7F4B20FE8
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 15:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B65158D6A;
	Mon, 29 Jul 2024 15:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="aztqdyBL"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0319145354
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 15:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267497; cv=none; b=H3IzbehvukTve5D0xLCAlmcrV8GlGNdNLUmVuxD3hh5WCNfldCGeL1oXNqSSizuh1VbCwtZm5xYY7LleTSO4Kzr6hZrVqgapPI/+cb0VAF9/zrVwmzvMBAsouJ1gOU7MNea1M/l/vw6dJVjK63RgMfXEVI5GniuBZkLF97OZo5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267497; c=relaxed/simple;
	bh=yyBzlPTZBApoUoOjHBBI5TZlyTFp2+vVtb0I5ttQVAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tkgbVmYgMS+s91N+jI4pWbfONWaDLKi8TSAZfz29J4p0PC1hfAfcn4ftWytVPXcT0DYGlppc28JzDjKIA/63ziBDyi2SKLE2Sr84ewBde5Th9vVnRimkkIUcjykR0CvPWZZ9G+Kt6HNqS3GuLk0C5hzaUG52VqgwFLUQZDs0SsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=aztqdyBL; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:6c24:bf58:f1fe:91c1])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 30D117DCAE;
	Mon, 29 Jul 2024 16:38:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1722267495; bh=yyBzlPTZBApoUoOjHBBI5TZlyTFp2+vVtb0I5ttQVAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com|Subject:=20[PATCH=20n
	 et-next=2002/15]=20ipv4:=20export=20ip_flush_pending_frames|Date:=
	 20Mon,=2029=20Jul=202024=2016:38:01=20+0100|Message-Id:=20<1ff6ff4
	 9a7f0f84e23e851eb236f0cbefc5a0dd0.1722265212.git.jchapman@katalix.
	 com>|In-Reply-To:=20<cover.1722265212.git.jchapman@katalix.com>|Re
	 ferences:=20<cover.1722265212.git.jchapman@katalix.com>|MIME-Versi
	 on:=201.0;
	b=aztqdyBL6Wihe+nMnwBHWOps4wNNDmX5b1dU81fahY6lff0QTItZgoxkMRKrpviEj
	 zV3XkQGT9b9EckxZPRvLApZXkk5iQFU1r+iiEwM/GemJm5rkY5ENTepiSMtrhXah8h
	 q1lgeYeQQ6odiW9kYEogxc8M6ft+HduDCBcRk4cfIY4VitudcfQSARvy206FP+xxfY
	 Pd8xQiLBMw8wnJfYUX4amYQoAJHUS21rZ6AvMnOaYAyObXBgmCe4Cm1B+Qv3B3Xs/s
	 x3CmgaUEv051DIRpTBS8mHW25orH528QHegScmqixHKCMxR8LqZ0kbh3k6SxK8/neY
	 8htwWLerzulng==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com
Subject: [PATCH net-next 02/15] ipv4: export ip_flush_pending_frames
Date: Mon, 29 Jul 2024 16:38:01 +0100
Message-Id: <1ff6ff49a7f0f84e23e851eb236f0cbefc5a0dd0.1722265212.git.jchapman@katalix.com>
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

To avoid protocol modules implementing their own, export
ip_flush_pending_frames.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
---
 net/ipv4/ip_output.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index b90d0f78ac80..8a10a7c67834 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1534,6 +1534,7 @@ void ip_flush_pending_frames(struct sock *sk)
 {
 	__ip_flush_pending_frames(sk, &sk->sk_write_queue, &inet_sk(sk)->cork.base);
 }
+EXPORT_SYMBOL_GPL(ip_flush_pending_frames);
 
 struct sk_buff *ip_make_skb(struct sock *sk,
 			    struct flowi4 *fl4,
-- 
2.34.1


