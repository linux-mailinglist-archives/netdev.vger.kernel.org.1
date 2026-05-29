Return-Path: <netdev+bounces-293091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGQ6HfJ3GWrewwgAu9opvQ
	(envelope-from <netdev+bounces-293091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:26:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7846601960
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 13:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B17DE30238ED
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136603BF694;
	Fri, 29 May 2026 11:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="06y/6K51";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rjlNw/QX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GTrv1T6L";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nyueWRl1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A996E30568E
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 11:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053853; cv=none; b=YmY6vyV2E3B+R7RK/HKds2FtCMB9WNzxRvud3fUTUFvUGegfuI1z6vqy50swfMAkQ8qb1DVaMIprhLYDAgrVaI1d9mD5McxE0rynML1/YV3cTu6v/QT/abgw8VeQ+ID+I8AIzSrPChqLuBqCFkYMZ+rZbHoO4BtMCp6qsmUYu0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053853; c=relaxed/simple;
	bh=B1y96rqGwNSiG9tkqeRlG4pFEWX/QUJYaUyiOpBN5nA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uS1VaNwBQaVW5KWT2rLB85WvY2plQ9vaeZxmkwCEDTlK5Wj1Rc/ZNnwveOEJyPlCXGXIJXf70yiwwGqabWsyPExF/k+Oxb6DtUEZnPFgrIJnhdeaW5apV9ASVPTwrBSk4e9jkyrXdOXY+gGUz0SMUwNyzd4ybBpbbjM1knuEeew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=06y/6K51; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rjlNw/QX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GTrv1T6L; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nyueWRl1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DD4B866D88;
	Fri, 29 May 2026 11:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780053850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YTn2G8m1Cj0tWjuCma31TyjVpPXr8sPbadJLHAXAkQc=;
	b=06y/6K51PjLADS2+PB0UNbSj290BsklO5wS6klkGm3aPWpmH7OH6yrZ5yXcEwyh0NB89sA
	tHU3nHZDysdCw+mbL/0MTJoJ7yXZ6KWiPM8ZBTdUj8dCd9tgstZPjXwII0ajt89Fx18cUW
	sh/sgsm260N0+lmbMe5o+01ZMw7067c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780053850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YTn2G8m1Cj0tWjuCma31TyjVpPXr8sPbadJLHAXAkQc=;
	b=rjlNw/QXzLzyiKOOHuuZq853SosZk1ZGcX5wYwetCCdFuOSBE3Dh+vzi3QE8S2YEcDOpmp
	9RnV+XrNG783+nDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780053849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YTn2G8m1Cj0tWjuCma31TyjVpPXr8sPbadJLHAXAkQc=;
	b=GTrv1T6Lby9aBA3hN7+5mkQuQqxrANZM+y1haxskf0srzfynQZqpXiwZ+yrHr/6xfKXoIi
	4j3scFuVqahJRUGQLm2rLG43oZqS0PpxYPUW1kceMigf0vppcl8tmu6mE5RSy+A1kcixUh
	f2T1IYrh/hKAc3ROSGGB1o+svgYj7tU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780053849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YTn2G8m1Cj0tWjuCma31TyjVpPXr8sPbadJLHAXAkQc=;
	b=nyueWRl1bEuOoN52wRm8WFjS0O99hf+c/mRHrhYsPpYIlQ+D5dc2O9yYjwHpHROUHj7t7h
	t5udXbKgNZ3lDfAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21D0C779A7;
	Fri, 29 May 2026 11:24:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FsdABVl3GWo1SAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 29 May 2026 11:24:09 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: yuhuang@redhat.com,
	justin.iurman@gmail.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	idosch@nvidia.com,
	dsahern@kernel.org,
	sbrivio@redhat.com,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Chris Adams <linux@cmadams.net>
Subject: [PATCH net v2] Revert "ipv6: preserve insertion order for same-scope addresses"
Date: Fri, 29 May 2026 13:23:57 +0200
Message-ID: <20260529112357.5079-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.30
X-Spam-Level: 
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,kernel.org,google.com,davemloft.net,nvidia.com,suse.de,cmadams.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293091-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C7846601960
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Chris Adams reported that preserving insertion order for same-scope
addresses is causing SSH connections to be dropped after stopping a VM
while running NetworkManager.

NetworkManager caches the IPv6 address configuration, when a RA arrives,
it determines the list of addresses to configure and checks if the
addresses are already in the right order in the kernel. If they aren't,
NetworkManager removes and re-adds them to achieve the desired order.

As the order changes, NetworkManager is confused and reconfigures the
addresses on every update. In addition, this would also affect to cloud
tooling that relies on IPv6 addresses order to identify primary and
secondaries addresses.

This reverts commit cb3de96eea66f5e4a580086c6a1be46e765f97f4.

Fixes: cb3de96eea66 ("ipv6: preserve insertion order for same-scope addresses")
Reported-by: Chris Adams <linux@cmadams.net>
Closes: https://lore.kernel.org/netdev/20260521135310.GC977@cmadams.net/
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
v2: updated commit description to make it more accurate
---
 net/ipv6/addrconf.c                  | 2 +-
 tools/testing/selftests/net/ioam6.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 5476b6536eb7..bb84a78b80f6 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1013,7 +1013,7 @@ ipv6_link_dev_addr(struct inet6_dev *idev, struct inet6_ifaddr *ifp)
 	list_for_each(p, &idev->addr_list) {
 		struct inet6_ifaddr *ifa
 			= list_entry(p, struct inet6_ifaddr, if_list);
-		if (ifp_scope > ipv6_addr_src_scope(&ifa->addr))
+		if (ifp_scope >= ipv6_addr_src_scope(&ifa->addr))
 			break;
 	}
 
diff --git a/tools/testing/selftests/net/ioam6.sh b/tools/testing/selftests/net/ioam6.sh
index b2b99889942f..845c26dd01a9 100755
--- a/tools/testing/selftests/net/ioam6.sh
+++ b/tools/testing/selftests/net/ioam6.sh
@@ -273,8 +273,8 @@ setup()
   ip -netns $ioam_node_beta link set ioam-veth-betaR name veth1 &>/dev/null
   ip -netns $ioam_node_gamma link set ioam-veth-gamma name veth0 &>/dev/null
 
-  ip -netns $ioam_node_alpha addr add 2001:db8:1::2/64 dev veth0 &>/dev/null
   ip -netns $ioam_node_alpha addr add 2001:db8:1::50/64 dev veth0 &>/dev/null
+  ip -netns $ioam_node_alpha addr add 2001:db8:1::2/64 dev veth0 &>/dev/null
   ip -netns $ioam_node_alpha link set veth0 up &>/dev/null
   ip -netns $ioam_node_alpha link set lo up &>/dev/null
   ip -netns $ioam_node_alpha route add 2001:db8:2::/64 \
-- 
2.54.0


