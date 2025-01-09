Return-Path: <netdev+bounces-156788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE59A07D57
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0642E3A63A0
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCFF21D5B0;
	Thu,  9 Jan 2025 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="P44MPWJ5"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DFC7FD;
	Thu,  9 Jan 2025 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736439652; cv=none; b=Am09Be1Wwq8TlhYOJ16UcxGxYhhCjfHQs8EzzVNViwZqYsyTrP1KDXgeWP3CFAXOczxHq+XEj3j0rdaGchbuSNDEDfVMhn6+0jbRcuNEK0vJdgvgt+z92SNnVb+/YOBnwkBs1UHRNRmVJK++TFMFahxIxm0ZoJIieTLJh2geocw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736439652; c=relaxed/simple;
	bh=yZiYcWcbWWYqIAe/qJHoWcZE+V8TbhwxvxOGHOOBYHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dpmblfA/KgMn3a931XnQGo8934ISx6Bv5ohR2IedL5h812xI4upKgUNkBCuE4US3vodYu0OoA+NPUV3Jf8hX1aDTvRfSoCYOKO9yE0zPHC8e1gW8hdSiaNW7jA/xzrsq7zYBe45+XGhnleiXYmFEaDk2DJoUx5P4m3zp4d7APfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=P44MPWJ5; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=ylIvY
	0+HP+9mC+jUr9hYJK2bhIBCcYgyn+9ca3sZITw=; b=P44MPWJ5NTWvjCh9d2QHD
	hGPSzU7lQQfiZIp7BSuiTpv41bRykwrmly4w1xcjqEucjJfKs/gJrqfWYCHTvcB9
	nz5vwtSpLnJJXZzDvdGfhNUSgYjo3BYxzDyX5MNEpMWAnklDHLCqwcQKqpAoo5I3
	SSLvfWc4+dBtO7WdtDSYyo=
Received: from lizhe.. (unknown [157.0.89.51])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCn9Mu99n9nBrxVIg--.51946S2;
	Fri, 10 Jan 2025 00:18:18 +0800 (CST)
From: Lizhe <sensor1010@163.com>
To: edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lizhe <sensor1010@163.com>
Subject: [PATCH] tcp: Add an extra check for consecutive failed keepalive probes
Date: Fri, 10 Jan 2025 00:18:02 +0800
Message-ID: <20250109161802.3599-1-sensor1010@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgCn9Mu99n9nBrxVIg--.51946S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw1kuF17Zw18Jr4rtF4fXwb_yoWfXwc_uw
	4kJFWUWr47XFy2ga1UZw43GryFk34xZF1ruFyfKasxJ3WvqF1qkFZ2gF909rn7uFZxWF95
	Aws8try5Ar1a9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNuWl7UUUUU==
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/1tbiKAHPq2d-8RdYmwAAsw

Add an additional check to handle situations where consecutive
keepalive probe packets are sent without receiving a response.

Signed-off-by: Lizhe <sensor1010@163.com>
---
 net/ipv4/tcp_timer.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index b412ed88ccd9..5a5dee8cd6d3 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -828,6 +828,12 @@ static void tcp_keepalive_timer (struct timer_list *t)
 		}
 		if (tcp_write_wakeup(sk, LINUX_MIB_TCPKEEPALIVE) <= 0) {
 			icsk->icsk_probes_out++;
+			if (icsk->icsk_probes_out >= keepalive_probes(tp)) {
+				tcp_send_active_reset(sk, GFP_ATOMIC,
+						SK_RST_REASON_TCP_KEEPALIVE_TIMEOUT);
+				tcp_write_err(sk);
+				goto out;
+			}
 			elapsed = keepalive_intvl_when(tp);
 		} else {
 			/* If keepalive was lost due to local congestion,
-- 
2.43.0


