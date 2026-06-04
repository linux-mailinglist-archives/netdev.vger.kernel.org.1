Return-Path: <netdev+bounces-295336-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id moC8EQSrIWrBKwEAu9opvQ
	(envelope-from <netdev+bounces-295336-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:42:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA31641F77
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:42:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=GbMA3v86;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295336-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295336-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4513B332EAF1
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 16:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87C43B7741;
	Thu,  4 Jun 2026 16:30:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1EE3B4E95
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 16:30:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590635; cv=none; b=rjSRmapuBrBeuYo7TiSxIEdgQFzb3BMERIvva3XMZ7YeM/91L8DkcWd9C6ql6CPy6ZEMbi6e0IQr4lnU5hSFck/CJ2DXmqm02r/327iEY2mS1HLuf1jvauMq+7Z3RClqq4noDK/JK58nNAqGE6wRdYxkAqL5bh7F2fyz2hquCAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590635; c=relaxed/simple;
	bh=TWQD7Nx2vPdkyw41EjqI2NzyTI0ByqqmHYzzWo5TKSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PJSnA1g6SclxJWh0nh0ZjXOphWAzdy4wRe1rnuaVoQM4ehT8qCFt2/5cbTrgHasZV5xv3KybXMpbUVfCw5Z4i0t3lFhxX0YDDyH9lrTHVi84eycuWvN8KKiX2M1gaZkTSFxAJj9aT8zqivBsYahKbUbSbrxhMl2FlZLEJd0QcAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbMA3v86; arc=none smtp.client-ip=74.125.82.54
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1370417c01cso1296540c88.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 09:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780590631; x=1781195431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MNxWKwtOMlmaCtYDf9JG2uLTPybVcNdh3AmCvSMq9aE=;
        b=GbMA3v8629/Vw/zhLcTgNBQwilapXeXobAMfKogSOiP3rpWTn0UuJ7aSV3zXPaVbWn
         KLQOM+s/cMQvkVfvO9qfywLFtc6WdkyWnxeWXPI6K4+eJ8CYzW8yykih2Ldofp9Y2xlN
         bzGa8FoZkJbXEgj/7UlI4lptTYZoxbM8paAvEAuI9j2bcl++7fnnaKw3MqbdUQwcJjaG
         kszIixA2XWjjc0yjsp/qb+jhthbull701ynkqYR5r8EEE7BAKzCR2Zvk32pWX6Ww8cdC
         T99mekXxIf69XJ1PE5RokhpeQ+Pgm0hObJfdxxCN3VZOswRJyIpwhFPU0CqwZun/YRDW
         3BJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780590631; x=1781195431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNxWKwtOMlmaCtYDf9JG2uLTPybVcNdh3AmCvSMq9aE=;
        b=SJpNN+V2XxcHfP97puB/97p8h0n9SGTUqkBc9QrLaTWgJ9lUnCbddFjym280SQQvMH
         KAVUPDZXYDx/SuqcEV289TBtAahY97B2Vm+M95q9eUmZTyOoYmoBY3fMovsBUmUfJB18
         w66hAdIyN4nQmNSzDhXDFPXPz+3Poe0kvQFbxYfyxseIUySoS+V0c6uaBRSIhpLzJgQM
         mAlIT61aLc+rsDOw+zXCv0rUXyg+iaEqoDFuAIZ0DyOzhe7t8GOLIJg8D6ZIj2BdBlWD
         DJG+Fn0AmtbUZXsz+jmj3skstaOFJTgVP/u6LUb3b+UhHlo3TXZT4FZiVDA/yOOB953a
         oNiQ==
X-Gm-Message-State: AOJu0YzCdg6CQ/eP/j90kyvuyhT8p/NR7XbhYSMTXeRHg1AzfgGIWU/X
	pgNwbzlx5ntFcfGW7vgVOIHMelr3hT5szwIt+q9KvD1r2Cuf7Z7y1rTp7+RiONNxHpY=
X-Gm-Gg: Acq92OHmpBYyEoV09cQYK3x2XjGSjdSUvWAPhS0IiWDWiVBMNZkHKdM4vJEnUXLbQxO
	aQ6+qOBkG5HZhPvNSXjOMSH4UQZY4umFpLjt+rFtzUKJItjEDmHDccTUO7di+ZOr2R4NSFrQuU6
	tSRcz1wUm+JxzIxmuBPgV/jsBpyjuL+H8LdS4tHVX3wH6C0t4Hc8aW1FplMQZ/7AAqTlvb1SsZL
	EkiaYupkPiLvLbbZP3ZCEK4o3WMbv6zwm7vIaUfOpEhH+DidQ5BZdpsNzktKyZChTAJQM5tjnoJ
	jl3dVjdZson81HEKa2vyC0VbyBazeeOj+GNPGT4Bi2Af2HumzKgxX1DY0kQVmg2IzrcC6G08s3d
	42SOeZxWT96qcHuI4ujWpepAs42b5hPSd6WqttUZTFwP1vmaPtvaK/cKFZ3br5EEWzFnowZs/2w
	rUegsOOg2r4JjjlT00FVO845DrLhY=
X-Received: by 2002:a05:7022:2390:b0:134:df4a:2821 with SMTP id a92af1059eb24-137f6c16da7mr3392850c88.40.1780590630843;
        Thu, 04 Jun 2026 09:30:30 -0700 (PDT)
Received: from houminxi ([64.118.153.39])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f549bbefsm4239005c88.4.2026.06.04.09.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 09:30:30 -0700 (PDT)
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
Subject: [PATCH net v4] selftests/net/openvswitch: guard command substitutions against empty output
Date: Fri,  5 Jun 2026 00:30:16 +0800
Message-ID: <20260604163016.3929371-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,ovn.org,openvswitch.org,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-295336-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:aconole@redhat.com,m:davem@davemloft.net,m:echaudro@redhat.com,m:edumazet@google.com,m:horms@kernel.org,m:i.maximets@ovn.org,m:kuba@kernel.org,m:pabeni@redhat.com,m:shuah@kernel.org,m:dev@openvswitch.org,m:linux-kselftest@vger.kernel.org,m:houminxi@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ECA31641F77

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

Changes since v3:
  - Corrected subject prefix to [PATCH net] (hardening fix, not new feature).

Changes since v2:
  - Fixed missing 'net/' in subject path (selftests/net/openvswitch).
  - Removed --base flag (prerequisite-patch-id flood in v2).

Changes since v1:
  - Rebased onto current net-next/main. No code changes.

 .../selftests/net/openvswitch/openvswitch.sh     | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index a415e9dec8cd..82f066a0ceed 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -360,6 +360,8 @@ test_psample() {
 	# sFlow / IPFIX.
 	nlpid=$(grep -E "listening on upcall packet handler" \
             $ovs_dir/s0.out | cut -d ":" -f 2 | tr -d ' ')
+	[ -z "$nlpid" ] && \
+		{ info "failed to get upcall PID"; return 1; }
 
 	ovs_add_flow "test_psample" psample \
             "in_port(2),eth(),eth_type(0x0800),ipv4()" \
@@ -393,6 +395,10 @@ test_drop_reason() {
 	ovs_drop_subsys=$(pahole -C skb_drop_reason_subsys |
 			      awk '/OPENVSWITCH/ { print $3; }' |
 			      tr -d ,)
+	if [ -z "$ovs_drop_subsys" ]; then
+		info "failed to get OVS drop subsys ID"
+		return $ksft_skip
+	fi
 
 	sbx_add "test_drop_reason" || return $?
 
@@ -491,13 +497,19 @@ test_arp_ping () {
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


