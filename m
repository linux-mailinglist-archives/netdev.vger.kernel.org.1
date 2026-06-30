Return-Path: <netdev+bounces-303077-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /z2wLxiZQ2rccwoAu9opvQ
	(envelope-from <netdev+bounces-303077-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:23:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F40A6E2C65
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:23:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ilETqyQe;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303077-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303077-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6F60E302A4D6
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 10:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBAC3EF0C8;
	Tue, 30 Jun 2026 10:22:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA6E3EAC89
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 10:22:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814935; cv=none; b=uF1YvEZu8gX+XtExtBEKV8BuqmkuSPseLXx6JkJLw4F2beRI4co2PyWkwUck0zvkUo78h4qWFEg/qgWu/QHwfrUrkhrLmxB4STBEW4UKkZUpP06kCRsoLdTaIM8wtSN7zxh7eo9g9qZynzuXImIVbwSRMNSeENwLs3iyO148BCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814935; c=relaxed/simple;
	bh=3B4mgEkMMg1k+RH7odWpE7epbKwExfi7ZwW6SF4mnhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fP13x6HKCLzL9+kB2BDX8bUm2sVymOdVohHNDnjZHpx/Do5WVMvN18c3PJLIHVfO0is0KrIqqy00IKBc8xvN8cUpm2lgSbJvZfGWD9lVSW6dLYP24qZdmPI8dFdlrMTwzxWweloJy7nfGgMEoJjYetOyEQq+vHVuPG6K6ShvfRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilETqyQe; arc=none smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c95a0c0aa2so29549235ad.3
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 03:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782814933; x=1783419733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/t9kcr2j0sJat9b7E1mstFc45YE/VNCBoHjz8KUyS8Y=;
        b=ilETqyQeYMMc6wd3zO9se+Y8+lxLjXTyQDc6FfgiQnmQR58T+oNy5CBfQL2zaog1mz
         hoxBeb8WdGJANiH9vNAmrUOEBbxtRhe/568qTG4vrwuMK1xOhfAqdUWQ723Cc9K7g7aF
         U3jCufWY/y1nkT6xH5PKyYYAHz0KUikRNRMmbnUXF8rYX6n1jI7Iev21Xfx8BvUhqyEv
         6KMhLT6riQXecUh1P2z8WqLLa5Lk3MUzpTzDqOXN4UsmoRiWofEwzAu81KrVgKV0ErSx
         acYf1gaU4bHCLQaX6xafuxQAGtTKxwi83bejOQuIyakxRzgd7yEazbqZASdRPEtmUhA/
         3hkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782814933; x=1783419733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/t9kcr2j0sJat9b7E1mstFc45YE/VNCBoHjz8KUyS8Y=;
        b=M7uBCJP4ViMSKMtkaPSqF4Nn/MQFyOmmMAx+92IBm2Gom7APi1XaUyZVBujKNZ0JSe
         KJMwWOCl7zr/8gwmzs2YyeXhSEqJVSPQxHLDQI2EzAHBWw105rm2tAhVh1//O9irGhiI
         0RFnPdMH+NH1TkO2ihN5knTGEqWOVDhKjYtm7TVyVLlJ+5gWjs3ZL+hOskNJugvOT2+P
         m0BEY7MYzlsXn3wEj5lYIRIigJF+3fc78fuoSU3wSsmAaVBYSyTZGEXpIfpyaHw4qQgR
         uTqyo61uIQIZbMTo5WLySikd3H2swemcKls6d9gHb7esgaUY51L9EsPy5hqixrmwAUDA
         Fs2A==
X-Gm-Message-State: AOJu0YzTX2/wPvorr82TmSxIE70jCoLzivfMWXTvplhFaPuD00bjWy/q
	5FGYJRIzelxKH/e4g3ct2eThpX3EOyaVG1Exk2u3zNeQCb5zRHgPXM3qsKS67r4uqYvE4A==
X-Gm-Gg: AfdE7cmfShX+v9eCPztL65eVcTIgTVakQXj1+qe8cZZeKpJ4yJeuLw+iaiRiWODWdrn
	wiTiX1uJRnekV3MLbxswXsdh7AfVB8yyxxQCQKSrjYjTKdn/gmf0zzc4TxCmPUNkzT0WWtQ7n6N
	K+YiuBABSG/9KDyKIyQKevcD1CbRSMzrZjfuC/CTBrl75Hktd+8WDfgLDzvHoK+87LRFC34pLcf
	sGxMWykZJ6apQ6NNvqhknskOCEfRRYLSwoAPaW41oCIM/apKT4BUIQwcp4UWo4urVOmkoSBKsm/
	i6h0iQXigBb8rJ6W0rFa/H91Wbe6pdTe1ZSedahIet+l/EoBDz/dnqo9BIlMsgM2DNnEibDKMBp
	a+p7ME0r0oSiilNnnhp4aVQcMp3NOIrURYkMnIwtI4emM3ZU2DZUhMWhjEf/QQlyca/LxMAbwpd
	aC7Reo
X-Received: by 2002:a17:903:234d:b0:2c9:a9c0:80b6 with SMTP id d9443c01a7336-2ca2ea10374mr23824275ad.34.1782814933036;
        Tue, 30 Jun 2026 03:22:13 -0700 (PDT)
Received: from houminxi ([166.0.188.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca37c7456bsm10696285ad.25.2026.06.30.03.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 03:22:12 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Minxi Hou <houminxi@gmail.com>,
	aconole@redhat.com,
	echaudro@redhat.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2] selftests/net/openvswitch: add output truncation test
Date: Tue, 30 Jun 2026 18:22:08 +0800
Message-ID: <20260630102208.29140-1-houminxi@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-303077-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:houminxi@gmail.com,m:aconole@redhat.com,m:echaudro@redhat.com,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F40A6E2C65

Add test_trunc exercising the OVS_ACTION_ATTR_TRUNC action. The test
verifies truncation in three steps: first confirm normal forwarding
works, then apply trunc(14) which truncates packets to the Ethernet
header and verify ping fails, then restore normal forwarding and
verify connectivity recovers.

The trunc action sets OVS_CB(skb)->cutlen, causing pskb_trim at
output time. With trunc(14) the IP payload is stripped, so the
receiver drops the frame and ICMP echo reply is never generated.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 .../selftests/net/openvswitch/openvswitch.sh  | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index 2954245129a2..fef21eb4a129 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -32,6 +32,7 @@ tests="
 	dec_ttl					ttl: dec_ttl decrements IP TTL
 	flow_set				flow-set: Flow modify
 	action_set				set: SET action rewrites fields
+	trunc					trunc: output truncation
 	psample					psample: Sampling packets with psample"
 
 info() {
@@ -443,6 +444,71 @@ test_action_set() {
 	return 0
 }
 
+test_trunc() {
+	sbx_add "test_trunc" || return $?
+	ovs_add_dp "test_trunc" trunctest || return 1
+
+	info "create namespaces"
+	for ns in client server; do
+		ovs_add_netns_and_veths "test_trunc" "trunctest" "$ns" \
+			"${ns:0:1}0" "${ns:0:1}1" || return 1
+	done
+
+	ip netns exec client ip addr add 10.0.0.1/24 dev c1
+	ip netns exec client ip link set c1 up
+	ip netns exec server ip addr add 10.0.0.2/24 dev s1
+	ip netns exec server ip link set s1 up
+
+	ovs_add_flow "test_trunc" trunctest \
+		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
+	ovs_add_flow "test_trunc" trunctest \
+		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
+
+	ovs_add_flow "test_trunc" trunctest \
+		'in_port(1),eth(),eth_type(0x0800),ipv4()' '2' || return 1
+	ovs_add_flow "test_trunc" trunctest \
+		'in_port(2),eth(),eth_type(0x0800),ipv4()' '1' || return 1
+
+	info "verify connectivity without truncation"
+	ovs_sbx "test_trunc" ip netns exec client ping -c 1 -W 2 \
+		10.0.0.2 || return 1
+
+	ovs_del_flows "test_trunc" trunctest
+	ovs_add_flow "test_trunc" trunctest \
+		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
+	ovs_add_flow "test_trunc" trunctest \
+		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
+
+	info "add truncated forwarding flow"
+	ovs_add_flow "test_trunc" trunctest \
+		'in_port(1),eth(),eth_type(0x0800),ipv4()' \
+		'trunc(14),2' || return 1
+	ovs_add_flow "test_trunc" trunctest \
+		'in_port(2),eth(),eth_type(0x0800),ipv4()' '1' || return 1
+
+	info "verify ping fails with truncation"
+	ovs_sbx "test_trunc" ip netns exec client ping -c 1 -W 2 \
+		10.0.0.2 >/dev/null 2>&1 \
+		&& { info "FAIL: ping should fail with trunc(14)"
+		     return 1; }
+
+	ovs_del_flows "test_trunc" trunctest
+	ovs_add_flow "test_trunc" trunctest \
+		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
+	ovs_add_flow "test_trunc" trunctest \
+		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
+	ovs_add_flow "test_trunc" trunctest \
+		'in_port(1),eth(),eth_type(0x0800),ipv4()' '2' || return 1
+	ovs_add_flow "test_trunc" trunctest \
+		'in_port(2),eth(),eth_type(0x0800),ipv4()' '1' || return 1
+
+	info "verify connectivity restored without truncation"
+	ovs_sbx "test_trunc" ip netns exec client ping -c 1 -W 2 \
+		10.0.0.2 || return 1
+
+	return 0
+}
+
 # psample test
 # - use psample to observe packets
 test_psample() {

base-commit: cef9d6804030793cf8b8796fd6936197d065dd3e
-- 
2.54.0


