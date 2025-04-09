Return-Path: <netdev+bounces-180710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B399A8238C
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 13:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 206B14423F4
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 11:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AF625DD12;
	Wed,  9 Apr 2025 11:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dJTY4Zoo"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A4625C6E3
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744198063; cv=none; b=AjP52P7t+A6c9aIum5wmOGGxaqGsGvLx6tCnbHPjAz7JFjl4e/NJ1Fq/6DK/fcdUMPZpQkbfBMzoYXtjJtDcsa6sx8rT0HMyah8lTwp13gslgQCbz8zne5E4S/vMCKSll5bELXOIKsURDnj3Q7o59SrqTdZJ0SF2vI70SfsxGUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744198063; c=relaxed/simple;
	bh=HVeE+COPPGrNk6VAYW0mohrUVpc18vBtkM7XtNBy+ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LeTgv2O09mb7eQ4qudqPYcw51KGXukjazZfkyZSd+Sn09miGykK0yJlBWK8vcX9YCQIYHBqZL6biORRYExKOM02UaQlQ3I2Xe4CEk69POFR0ydFlzteKP++EXqZ/KooPaikB+HgxVeKgjXYQw0DlSBnxmruurrYT1d8his7JSng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dJTY4Zoo; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744198060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aiPsVK0LkzRJOqwrU5xUDBr/zxLKWQSqjXIEjy0OgOc=;
	b=dJTY4ZoooaZLYwLvqEqa3Q4cEYbyqCwmtK3sU7ljZEacvUIv4X4hvyhQ+bzQc5RfnANxPB
	eVsj/YvE1Y9JzNhOFRUx87mcOx7aPqcDv134i87bwthMH1xvPVSZMd9ZC+L4SjhkYnZtpE
	sVIauf00Vu+0cn3AeppMXOaZ7kqWx0k=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: kuba@kernel.org,
	edumazet@google.com
Cc: mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	David Ahern <dsahern@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Antony Antony <antony.antony@secunet.com>,
	Christian Hopps <chopps@labn.net>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 2/2] tcp: add LINUX_MIB_PAWS_TW_REJECTED counter
Date: Wed,  9 Apr 2025 19:26:05 +0800
Message-ID: <20250409112614.16153-3-jiayuan.chen@linux.dev>
In-Reply-To: <20250409112614.16153-1-jiayuan.chen@linux.dev>
References: <20250409112614.16153-1-jiayuan.chen@linux.dev>
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

We added a new counter, like the existing PAWS_OLD_ACK one.

Also we update the doc with previously missing PAWS_OLD_ACK.

usage:
'''
nstat -az | grep PAWSTimewait
TcpExtPAWSTimewait              1                  0.0
'''

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Reviewed-by: Eric Dumazet <edumazet@google.com>
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
index ec47f9b68a1b..1d234d7e1892 100644
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


