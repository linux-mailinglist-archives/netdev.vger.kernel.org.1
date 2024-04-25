Return-Path: <netdev+bounces-91382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 171428B2663
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 18:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61DADB23147
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 16:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8E214D712;
	Thu, 25 Apr 2024 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OaYs1C/Y"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5C22D60A
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 16:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714062365; cv=none; b=moDDiabErb+tVjZ3t0Mc67eHzSwiFtRbWwKj+07fzxvabNixllxHrVo/E+P5+pfuNoeDvykNezsrwRq2FS0zw869fo5A4VA+aKKuBXIJg2TAypt2bP+bgZKPtvLw+OfsUgxrVkxQoyoHV+jV6zY4IAmfshXmzxT1FBUIBt9/UQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714062365; c=relaxed/simple;
	bh=l0SD0qpVLzBtkQ6Lj+cf87U/9fA1FbNQU598BAOYwAM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U4yivMdvTFEfhQRntMrjGdyuRMJ8leb4pVEuEc6o9519TQukIKbq44n8Bnee7SF0OmIlgEtd/Eo20srwvQ5v59ljoAdwSk0CQhELmSxEpco1/L3b072S8YPFeUE54ohfho9Q8x8t78C3gYVwyR+zKaD6OLILE0d8kbuWfyysfmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OaYs1C/Y; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714062358; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=I2vsHgjQXoetQnn7nQdRHqWMSgdoYFHq0PEvf0bZoRY=;
	b=OaYs1C/YH3to1YxSxfeaIhjf2u197zjGc5o73GCUYrDXdlNX/zJSIziZMJAfLTO4i+0TLRGpOB8AXfTzMse+5Xy1rk2b+ewzn1bSsRUg1eeX0yYG9qwhmJeCuZmzFgFm/cEfnhrfhRq6xU8ghj6Rp/yM2VhebBjwmxsraZ4NpeM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014016;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W5FzT.t_1714062356;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0W5FzT.t_1714062356)
          by smtp.aliyun-inc.com;
          Fri, 26 Apr 2024 00:25:57 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	fred.cc@alibaba-inc.com,
	xuanzhuo@linux.alibaba.com
Subject: [PATCH net-next] tcp: add tracepoint for tcp_write_err()
Date: Fri, 26 Apr 2024 00:25:56 +0800
Message-Id: <20240425162556.83456-1-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This tracepoint can be used to trace tcp write error events, e.g.,
retransmit timeout. Though there is a tracepoint in sk_error_report(),
the value of sk->sk_err depends on sk->sk_err_soft, and we cannot easily
recognized errors from tcp_write_err().

Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 include/trace/events/tcp.h | 7 +++++++
 net/ipv4/tcp_timer.c       | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 5c04a61a11c2c..0efb51dcb8a3f 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -195,6 +195,13 @@ DEFINE_EVENT(tcp_event_sk, tcp_rcv_space_adjust,
 	TP_ARGS(sk)
 );
 
+DEFINE_EVENT(tcp_event_sk, tcp_write_err,
+
+	TP_PROTO(struct sock *sk),
+
+	TP_ARGS(sk)
+);
+
 TRACE_EVENT(tcp_retransmit_synack,
 
 	TP_PROTO(const struct sock *sk, const struct request_sock *req),
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 976db57b95d40..ebba7e30d5534 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -19,6 +19,7 @@
  *		Jorge Cwik, <jorge@laser.satlink.net>
  */
 
+#include <trace/events/tcp.h>
 #include <linux/module.h>
 #include <linux/gfp.h>
 #include <net/tcp.h>
@@ -73,6 +74,8 @@ u32 tcp_clamp_probe0_to_user_timeout(const struct sock *sk, u32 when)
 
 static void tcp_write_err(struct sock *sk)
 {
+	trace_tcp_write_err(sk);
+
 	WRITE_ONCE(sk->sk_err, READ_ONCE(sk->sk_err_soft) ? : ETIMEDOUT);
 	sk_error_report(sk);
 
-- 
2.32.0.3.g01195cf9f


