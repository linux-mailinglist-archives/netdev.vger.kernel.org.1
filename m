Return-Path: <netdev+bounces-278647-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PefBmYg32mJPAAAu9opvQ
	(envelope-from <netdev+bounces-278647-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 07:21:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77905400712
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 07:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B27AE30915C2
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 05:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C15377EC3;
	Wed, 15 Apr 2026 05:20:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lgeamrelo13.lge.com (lgeamrelo13.lge.com [156.147.23.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEBE2580EE
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 05:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.23.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776230416; cv=none; b=oDTXPJqhXR7KDIf0e1d61mobCLWxC5PFtN6SLW+em15QQr6hSyAg0Ez7Ks1qZ79nNiGIbadpIw0B7fbcCRMRtjUDyuYX74qzz1syb87sK+Ky5AbJQOftHGjDF/1eSejF6BO/l1ynU9WuYm7p2iJ/YCxbE1/me6EED9Udh11aNhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776230416; c=relaxed/simple;
	bh=6sbEzBRQFYWtD3OnezTgQrslvGxgH6b50b4pYE0FmQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iBDzrMRPy4auC9wv5kDExxEXmMqwItCt1p1aobnUf9ddptqx3p8XJ4ILDssV1pmt18xxEk2b+bX6RKbGc5sNEqXRWiB33Cf7tIMcUlFll4XRvwCBnnLTB0h/47WG9burw0MBhaA1FAnTp9yPKhE3Z4+wFJny4S1azTmhdHIRCcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.23.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
	by 156.147.23.53 with ESMTP; 15 Apr 2026 14:13:43 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: juno.choi@lge.com
Received: from unknown (HELO ls3..) (10.157.93.226)
	by 156.147.1.126 with ESMTP; 15 Apr 2026 14:13:43 +0900
X-Original-SENDERIP: 10.157.93.226
X-Original-MAILFROM: juno.choi@lge.com
From: Juno Choii <juno.choi@lge.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Juno Choi <juno.choi@lge.com>
Subject: [PATCH] net: ipv4: fix alignment fault in sysctl_fib_multipath_hash_seed on ARM64 with Clang
Date: Wed, 15 Apr 2026 14:13:43 +0900
Message-ID: <20260415051343.1190626-1-juno.choi@lge.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278647-lists,netdev=lfdr.de];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_NEQ_ENVFROM(0.00)[juno.choi@lge.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lge.com:mid,lge.com:email]
X-Rspamd-Queue-Id: 77905400712
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Juno Choi <juno.choi@lge.com>

On ARM64, Clang may generate ldaxr (64-bit exclusive load) for
READ_ONCE() on 8-byte structs. ldaxr requires 8-byte natural
alignment, but sysctl_fib_multipath_hash_seed (two u32 members)
only has 4-byte natural alignment.

When this struct lands at a 4-byte-aligned but not 8-byte-aligned
offset within struct netns_ipv4, the ldaxr triggers an alignment
fault in rt6_multipath_hash(), causing a kernel panic in the IPv6
packet receive path (rtl8168_poll -> ipv6_list_rcv ->
rt6_multipath_hash).

Add __aligned(8) to the struct definition when building for ARM64
with Clang to ensure proper alignment for atomic 8-byte loads.

Signed-off-by: Juno Choi <juno.choi@lge.com>
---
 include/net/netns/ipv4.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 276f622f3516..4366ab26512d 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -41,11 +41,18 @@ struct inet_timewait_death_row {
 struct tcp_fastopen_context;
 
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
+#if defined(CONFIG_ARM64) && defined(CONFIG_CC_IS_CLANG)
+struct sysctl_fib_multipath_hash_seed {
+	u32 user_seed;
+	u32 mp_seed;
+} __aligned(8);
+#else
 struct sysctl_fib_multipath_hash_seed {
 	u32 user_seed;
 	u32 mp_seed;
 };
 #endif
+#endif
 
 struct netns_ipv4 {
 	/* Cacheline organization can be found documented in
-- 
2.43.0


