Return-Path: <netdev+bounces-177462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F805A7042E
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A510171646
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 14:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4A625BAAC;
	Tue, 25 Mar 2025 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M0GQ80LD"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2107725A640
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914065; cv=none; b=sL9M57Ew5UJdQBF6wVbIS0CaRhcL+axNCyaxpM7CQt5hWXZSyVBAJC5OAWXBI/Afc7M3rt86JiEzIVfkwaghQ3DDqL+VgdRKa5BsVBRB2+iWY+q8MOU/T8yTXl6/nMkNoSvF5r1T7n45Dfr49x0GHpNKYHPyv3VTLlSpCuP8Vog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914065; c=relaxed/simple;
	bh=6tCgdCxUoslKrQ/ImEbkLjcgZlfYHCZbXA2Xtm38wu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fzMHvp5D9Ioja9nb/XZBMvxjP6nUeqsN8dlVvsqwK+mW0/mdnNnbRooT9fE3mGPGRbKzNcn6GkUtLqiiruK6s6Bmqr2tF6ISjWoPjw/CYdiiyKo/qPRrvcaiej/kah08JRaxNPeCCoQnhjhGY54UwnvgZRbumEflHd+rJxpU774=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M0GQ80LD; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742914062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8xwJEyFiNpZJx3SaGRoYy6EGc/eXAk39jTVoaj7Yj4Y=;
	b=M0GQ80LDJ/lC/A+AKKrvato8INN3kffgFKiNBRLjChpIIGsxc7DiHprLhehJ9EqGT09p0r
	YLB21lNJ+5YNljlYUWPCVbklaEtJ99QzTa/83GKAOWDov5fpwRaecIRPZFu71YMTJ9VtFy
	PH/TIitAGXu1VoNfAMRTRi1BplbRJOc=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org,
	edumazet@google.com
Cc: linux-kernel@vger.kernel.org,
	kuniyu@amazon.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	ncardwell@google.com,
	mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>
Subject: [PATCH net-next v3 2/2] tcp: add LINUX_MIB_PAWS_TW_REJECTED counter
Date: Tue, 25 Mar 2025 22:47:04 +0800
Message-ID: <20250325144704.14363-3-jiayuan.chen@linux.dev>
In-Reply-To: <20250325144704.14363-1-jiayuan.chen@linux.dev>
References: <20250325144704.14363-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When TCP is in TIME_WAIT state, PAWS verification uses
LINUX_PAWSESTABREJECTED, which is ambiguous and cannot be distinguished
from other PAWS verification processes.

Moreover, when PAWS occurs in TIME_WAIT, we typically need to pay special
attention to upstream network devices, so we added a new counter, like the
existing PAWS_OLD_ACK one.

Also we update the doc with previously missing PAWS_OLD_ACK.

usage:
'''
nstat -az | grep PAWSTimewait
TcpExtPAWSTimewait              1                  0.0
'''

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 Documentation/networking/net_cachelines/snmp.rst | 2 ++
 include/net/dropreason-core.h                    | 1 +
 include/uapi/linux/snmp.h                        | 1 +
 net/ipv4/proc.c                                  | 1 +
 net/ipv4/tcp_minisocks.c                         | 2 +-
 5 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/net_cachelines/snmp.rst b/Documentation/networking/net_cachelines/snmp.rst
index bc96efc92cf5..bd44b3eebbef 100644
--- a/Documentation/networking/net_cachelines/snmp.rst
+++ b/Documentation/networking/net_cachelines/snmp.rst
@@ -37,6 +37,8 @@ unsigned_long  LINUX_MIB_TIMEWAITKILLED
 unsigned_long  LINUX_MIB_PAWSACTIVEREJECTED
 unsigned_long  LINUX_MIB_PAWSESTABREJECTED
 unsigned_long  LINUX_MIB_TSECR_REJECTED
+unsigned_long  LINUX_MIB_PAWS_OLD_ACK
+unsigned_long  LINUX_MIB_PAWS_TW_REJECTED
 unsigned_long  LINUX_MIB_DELAYEDACKLOST
 unsigned_long  LINUX_MIB_LISTENOVERFLOWS
 unsigned_long  LINUX_MIB_LISTENDROPS
diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 9701d7f936f6..bea77934a235 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -287,6 +287,7 @@ enum skb_drop_reason {
 	/**
 	 * @SKB_DROP_REASON_TCP_RFC7323_TW_PAWS: PAWS check, socket is in
 	 * TIME_WAIT state.
+	 * Corresponds to LINUX_MIB_PAWS_TW_REJECTED.
 	 */
 	SKB_DROP_REASON_TCP_RFC7323_TW_PAWS,
 	/**
diff --git a/include/uapi/linux/snmp.h b/include/uapi/linux/snmp.h
index eb9fb776fdc3..cca7f7eb6e9c 100644
--- a/include/uapi/linux/snmp.h
+++ b/include/uapi/linux/snmp.h
@@ -188,6 +188,7 @@ enum
 	LINUX_MIB_PAWSESTABREJECTED,		/* PAWSEstabRejected */
 	LINUX_MIB_TSECRREJECTED,		/* TSEcrRejected */
 	LINUX_MIB_PAWS_OLD_ACK,			/* PAWSOldAck */
+	LINUX_MIB_PAWS_TW_REJECTED,		/* PAWSTimewait */
 	LINUX_MIB_DELAYEDACKS,			/* DelayedACKs */
 	LINUX_MIB_DELAYEDACKLOCKED,		/* DelayedACKLocked */
 	LINUX_MIB_DELAYEDACKLOST,		/* DelayedACKLost */
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index 10cbeb76c274..ea2f01584379 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -191,6 +191,7 @@ static const struct snmp_mib snmp4_net_list[] = {
 	SNMP_MIB_ITEM("PAWSEstab", LINUX_MIB_PAWSESTABREJECTED),
 	SNMP_MIB_ITEM("TSEcrRejected", LINUX_MIB_TSECRREJECTED),
 	SNMP_MIB_ITEM("PAWSOldAck", LINUX_MIB_PAWS_OLD_ACK),
+	SNMP_MIB_ITEM("PAWSTimewait", LINUX_MIB_PAWS_TW_REJECTED),
 	SNMP_MIB_ITEM("DelayedACKs", LINUX_MIB_DELAYEDACKS),
 	SNMP_MIB_ITEM("DelayedACKLocked", LINUX_MIB_DELAYEDACKLOCKED),
 	SNMP_MIB_ITEM("DelayedACKLost", LINUX_MIB_DELAYEDACKLOST),
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 27511bf58c0f..43d7852ce07e 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -248,7 +248,7 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 
 	if (paws_reject) {
 		*drop_reason = SKB_DROP_REASON_TCP_RFC7323_TW_PAWS;
-		__NET_INC_STATS(twsk_net(tw), LINUX_MIB_PAWSESTABREJECTED);
+		__NET_INC_STATS(twsk_net(tw), LINUX_MIB_PAWS_TW_REJECTED);
 	}
 
 	if (!th->rst) {
-- 
2.47.1


