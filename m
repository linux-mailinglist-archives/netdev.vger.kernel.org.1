Return-Path: <netdev+bounces-293709-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id x9C4BLxyHWp8bAkAu9opvQ
	(envelope-from <netdev+bounces-293709-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 13:53:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A27FD61EA5F
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 13:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32DC3301A42D
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 11:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECD1372680;
	Mon,  1 Jun 2026 11:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+38rvAD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9A03644C6
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 11:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780314809; cv=none; b=Hv+uALtIvH4dmGGJYXXLueOZ2YKzZFjUEYcYa2Cuv3Tyz2X4te+p4jJbqwHIfngWtlzriB4W3YhrXGY1obtWCik+D9AAnWEfKcuoEOW912nuNanlNI4N2eD/NszX3XLw7q2/u45zctmRE544RjbZ8fUdZ5KdmqEMYjQb7dhMfeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780314809; c=relaxed/simple;
	bh=vjcSHu3SEn3zw1F72ieiZBESgN6+HtFjGQ33EPazq4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dFSVEW1RkiiLeABibf2uUc3goyu4klT9cHji2LsI1s7a2YtMoaINqLDYGBooQPIQ8i/YNRExBySQ4/zc69X8SdWGSSxUxa5Zvgd3mYoilGaUEKl+TJ87H/GQlzgVQs3bomjVbAISqUeQlAmVUs8mXxm2KL7ZDxot/5Y5Ufq6r8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+38rvAD; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-304f590dd91so2396528eec.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 04:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780314807; x=1780919607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yvmTG9qbl7v0LMiRxV9jUkuqNSrPO0HlW1meTsVlSmM=;
        b=I+38rvADVD0yWOCdbE3kvfw0xgTmakjc2kOOmRQfVU4nI+p5RbX29Tyu7xBf+fR+Fj
         SXpGEym8Slh1Jk9dEfHOtzRa66Q+rI4/nQIbdaOAHBPz19EQ4euq+rVcrj+Yzq1K1TrH
         NEgDyFluBNhwQPjEeNkhEW5coNLxmkC56blb15yugRhy1o2XZpKlAywPEQcn3USJdx5t
         fm3iIX1QROqzJkzQ2Jzo2T0+5DjCgq3HLNESURDJkBwbTh1CPw0MU08U/f+Bbx85ylSN
         6CCwqlo4oPw0ghmo4Hsr8xKkF5C9i3UCdJVMhwMtsnygQB8CBISBVHSjCxF5FD0sLpy7
         kJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780314807; x=1780919607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvmTG9qbl7v0LMiRxV9jUkuqNSrPO0HlW1meTsVlSmM=;
        b=FG9OCSw5vKqp3uHenf/yuAy8ODYrZwPltWasfSPJjW135aAKph8XVWBhn+XI1893/E
         IM+l5xKDm4nhsmdXyD93fQtA0HWE6NUhhX2ng6RazBZUIFhLhjKErJQVD9F470Wh5xQP
         88fT1TPaiDK1u7JYNJD13g/7GwsFtC8SAQNP01zu6VP3sV8jIIefZ09Hc1gEAYO4G8rY
         fwtFcEgYhVgeDN5Ac/0DQXjKBx+9itpFybhCfwkUDwRLCzCqQvI3NxKtseFePQf+ztq1
         YgKYFduUixjw7ECobbLFch84+AcluvDl5wJ4JlXahX4jSV+siXdbZ2dAUrIac9PjQrxa
         5Oqw==
X-Gm-Message-State: AOJu0Yw/BdjFwwZyFK5/IgB+x9HNZciY3ZklOVK6rXUPY7aZxU0eGrCR
	cUU52lVzZQ3E8E6vPdtgB66tAkBk/rkDJRE+1bMWhmMc5LZ/hBZ83H8XYW4krFil3oA=
X-Gm-Gg: Acq92OFAva8gk15I5f8RW7gl8ub9AitvvhvVapB86jLz545wQHRWPKMNp2AkCyH3Vn6
	9WtIc2OZw8R5R/7pMKypIAa0lCKBHj8bIO4/EgvwrNNzRONsPLyiMujknuKKA7F0fiiROK4dJLy
	PmzEZSsRUGI5PmgIy7sluk89wGR29hUcga/CSbuUM63XDoOoFS3HXkY3228sVrCxEeKMfo58QUt
	SaSA8nJufn6eSGwrhbmZ0X59eNhkLCC4OwsIh0oenUZ5nhl9142JzX9EhEncSLRyb0o90WTaojU
	O4tBPzFcRB1vNdKDYz4Ny7kIjEetek6pyA03MUffnKc+w1hgamVWRbBVKJ1bBEyENKDuTHlhZA1
	EnlTIvvLXjwPMBFOkTUYzOD50EpaViLJLH9Q+AFfWzJNg5abkkoq4Mq9mqchNaIw7Q5oUKIC8z0
	PZnKaNYqlrDbnw34tywUUuxBVtbERdJvFbhfhJ
X-Received: by 2002:a05:7300:cc0e:b0:2f2:c336:7736 with SMTP id 5a478bee46e88-304fa694de5mr4462843eec.29.1780314806950;
        Mon, 01 Jun 2026 04:53:26 -0700 (PDT)
Received: from houminxi ([166.0.188.190])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed53f316sm8335330eec.19.2026.06.01.04.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 04:53:26 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	davem@davemloft.net,
	echaudro@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	i.maximets@ovn.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH] selftests/openvswitch: guard command substitutions against empty output
Date: Mon,  1 Jun 2026 19:53:07 +0800
Message-ID: <20260601115307.1411211-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,ovn.org,openvswitch.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-293709-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A27FD61EA5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When ip-link output is unavailable, when the upcall daemon log has not
been written yet, or when pahole does not know the OVS drop subsystem
ID, the affected command substitutions silently produce empty strings.
The caller then passes empty sha= or pid= arguments to ovs_add_flow,
or matches against wrong drop reason codes, all without a diagnostic.

Add [ -z ] guards immediately after each assignment. For test_arp_ping,
also align the MAC extraction to use awk '/link\/ether/' as in
test_pop_vlan. The drop_reason guard returns ksft_skip because an
absent subsystem ID is an environment issue, not a test failure.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 .../selftests/net/openvswitch/openvswitch.sh     | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index 8cd5b3d894ab..67f508facc91 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -305,6 +305,8 @@ test_psample() {
 	# sFlow / IPFIX.
 	nlpid=$(grep -E "listening on upcall packet handler" \
             $ovs_dir/s0.out | cut -d ":" -f 2 | tr -d ' ')
+	[ -z "$nlpid" ] && \
+		{ info "failed to get upcall PID"; return 1; }
 
 	ovs_add_flow "test_psample" psample \
             "in_port(2),eth(),eth_type(0x0800),ipv4()" \
@@ -338,6 +340,10 @@ test_drop_reason() {
 	ovs_drop_subsys=$(pahole -C skb_drop_reason_subsys |
 			      awk '/OPENVSWITCH/ { print $3; }' |
 			      tr -d ,)
+	if [ -z "$ovs_drop_subsys" ]; then
+		info "failed to get OVS drop subsys ID"
+		return $ksft_skip
+	fi
 
 	sbx_add "test_drop_reason" || return $?
 
@@ -436,13 +442,19 @@ test_arp_ping () {
 	# Setup client namespace
 	ip netns exec client ip addr add 172.31.110.10/24 dev c1
 	ip netns exec client ip link set c1 up
-	HW_CLIENT=`ip netns exec client ip link show dev c1 | grep -E 'link/ether [0-9a-f:]+' | awk '{print $2;}'`
+	HW_CLIENT=$(ip netns exec client ip link show dev c1 \
+		| awk '/link\/ether/ {print $2}')
+	[ -z "$HW_CLIENT" ] && \
+		{ info "failed to get client hwaddr"; return 1; }
 	info "Client hwaddr: $HW_CLIENT"
 
 	# Setup server namespace
 	ip netns exec server ip addr add 172.31.110.20/24 dev s1
 	ip netns exec server ip link set s1 up
-	HW_SERVER=`ip netns exec server ip link show dev s1 | grep -E 'link/ether [0-9a-f:]+' | awk '{print $2;}'`
+	HW_SERVER=$(ip netns exec server ip link show dev s1 \
+		| awk '/link\/ether/ {print $2}')
+	[ -z "$HW_SERVER" ] && \
+		{ info "failed to get server hwaddr"; return 1; }
 	info "Server hwaddr: $HW_SERVER"
 
 	ovs_add_flow "test_arp_ping" arpping \
-- 
2.54.0


