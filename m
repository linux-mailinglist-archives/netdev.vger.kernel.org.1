Return-Path: <netdev+bounces-276056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AB+iNNsk1WnK1AcAu9opvQ
	(envelope-from <netdev+bounces-276056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:38:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A833B123E
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A75330918F3
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 15:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BF33C276E;
	Tue,  7 Apr 2026 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDyKODGq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28BD3BE150
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 15:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775575905; cv=none; b=Qs2rMEOvqNaC9W/td/YEeTTFpHS8F4pCsfL76y1WM91WyFu7jqJSkDQY3DZ1coyg0shbaz1l2svXlpBDrT5577Ea20iYbqEW6tk6NxMzjnc1PF7ELeaWDucjoGDnqkZ59KJKLNN5FsFNyTouvMzwtbxSoVwgT1jMSFyBMAPhzAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775575905; c=relaxed/simple;
	bh=yLUmvtRlTEHm6peGxSh1PJDlaEsrEQ5hF8LJa0bbLLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RlVFKLshh5kpZZ5qD9mhbpCuzk65AY+rhCMHVEQjJyEudGrtnhziHKdEaX6/t9OWQfucVg+59B+TU6EFABo3tOUK0KCMm8SFm8QPWA4lrwTMRA2LVfbEcr0457Zq30JRRO94wAGouse2uxvZZmQsOk/3U9iQtnw1UFgXeZCHtps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDyKODGq; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7d556c1a79eso6538994a34.3
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 08:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775575893; x=1776180693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UpNHKY7MPiuc730h1cuZKj/ZyMUO0iRlJs/naEXxLA=;
        b=JDyKODGqJvDPck+xUiHhZotX3+Y6EwtD6OjoTatxMqzHRUWrWjFGYnExtI3ieixcx/
         wyrf0IZgpPV7fS+IM9wxM8ipVeExTcvnYV9GYxY6CV1FpUQqj497vYqxbG0ezkF5bjdc
         /LZoOfpi3xOADWZlC832Z4u10Qvv19upezeIA1ikPh8c6fQd6KVj2cdX40CCneZI3+xI
         njPy8I1/t2dtkLAUI5okBp51fVEDz/slRomCBZfzdOuQvQl3bAqxezWa8XCusy4UsUCS
         O01RRXmpMf4abvm7vOd5CxRlsFUQ9hTBGRvdP7wOm2NkSmBh3fDRKUAmHJxB8+HSR+SU
         Ax3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775575893; x=1776180693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0UpNHKY7MPiuc730h1cuZKj/ZyMUO0iRlJs/naEXxLA=;
        b=cpW2wT/RoE3z1F+PToIxZ7CyVrNSGAd9snuHauojsu/76ILMImLkjGTk7jqPGvvNY+
         invDB0g2aXrSKrSkVN+bxj4vFik9a6HIMb+dDS35qAkvpTw2fp66S0wYbc28ssMBSf46
         RA/Ez/X+3oI718IK04gOhdQuS8WHRi41QKNlXDB3KksyK28A0tU4HjhT1iXM7yiTl5BK
         8Rq1fXp2ZCQIuLz7f1bo8qONODkUE05qD5Bft6LjDP+avDHHFHWYtSSS+mwJ3+LXcYDH
         bw9IgyDd+7jzcrw9KrPnLMbs7OQy+h5C2zRdipj+fmr28xkeuZNM3qOl7zT3ztRUfqUU
         lYwA==
X-Gm-Message-State: AOJu0Yy0gNvO3BHtIsCp1wCV0l4q9k/73kMcw/uuSRcUHPKcDgXZwC9i
	I6VQDp7NuEn4mSnedEBurxuCHhaf+jDKqfk7aJJDbFOTUVTE/KcY+r8xDGkvI4AgPyc=
X-Gm-Gg: AeBDievt8c67/68O1dJM+WAGDG/mJTieJ1Nqe3V3ogMJaILg+IjyxHYcIaKMrhgHogA
	vvjfgGcJzwL8T5+tT+tu4Jt15pC2pR86uoKoGPAESWQ59Oji2JWO/OgXLsc/4pdGr0YxJDJDLVQ
	Vgr9EOtsNE8LSWDac2XP4HL3UNrqllzDNmItJREL1q+uVSTJEigjtYwhzQKck+99vlJQm11aYEa
	C55Y+VbE9da1+mdfFKEg9QNN9XuPV0FKuATryqdL74cnIIj0JZe0eWHLpdxbP48S5ePLk8WGLrH
	vajln5KzK4PFG03KDTUuzfhTrhKYiHeTRTRoiuU4jYd+1hzD31TpvmQMfOeoWfsPahoWsNwpOVy
	vPIYVq3P5+dRX37hThCCNdA/+mQqWoZR5VG2So5sVMPd10X26FHvZZhNfW8OKag8HLDo4uBmExg
	pFsBsfjevGsJbGppF81Q==
X-Received: by 2002:a05:6830:4411:b0:7d7:bf59:16df with SMTP id 46e09a7af769-7dbb751779emr10665858a34.17.1775575892812;
        Tue, 07 Apr 2026 08:31:32 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:49::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dbd3a67487sm6330613a34.26.2026.04.07.08.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 08:31:32 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v6 13/14] selftests: net: add team_bridge_macvlan rx_mode test
Date: Tue,  7 Apr 2026 08:31:00 -0700
Message-ID: <20260407153101.3694714-14-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407153101.3694714-1-sdf@fomichev.me>
References: <20260407153101.3694714-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276056-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,fomichev.me:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 55A833B123E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a test that exercises the ndo_change_rx_flags path through a
macvlan -> bridge -> team -> dummy stack. This triggers dev_uc_add
under addr_list_lock which flips promiscuity on the lower device.
With the new work queue approach, this must not deadlock.

Link: https://lore.kernel.org/netdev/20260214033859.43857-1-jiayuan.chen@linux.dev/
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/config       |  3 ++
 tools/testing/selftests/net/rtnetlink.sh | 44 ++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 2a390cae41bf..38611ea11c6b 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -101,6 +101,9 @@ CONFIG_NET_SCH_HTB=m
 CONFIG_NET_SCH_INGRESS=m
 CONFIG_NET_SCH_NETEM=y
 CONFIG_NET_SCH_PRIO=m
+CONFIG_NET_TEAM=y
+CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=y
+CONFIG_NET_TEAM_MODE_LOADBALANCE=y
 CONFIG_NET_VRF=y
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_OVS=y
diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 5a5ff88321d5..c499953d4885 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -23,6 +23,7 @@ ALL_TESTS="
 	kci_test_encap
 	kci_test_macsec
 	kci_test_macsec_vlan
+	kci_test_team_bridge_macvlan
 	kci_test_ipsec
 	kci_test_ipsec_offload
 	kci_test_fdb_get
@@ -636,6 +637,49 @@ kci_test_macsec_vlan()
 	end_test "PASS: macsec_vlan"
 }
 
+# Test ndo_change_rx_flags call from dev_uc_add under addr_list_lock spinlock.
+# When we are flipping the promisc, make sure it runs on the work queue.
+#
+# https://lore.kernel.org/netdev/20260214033859.43857-1-jiayuan.chen@linux.dev/
+# With (more conventional) macvlan instead of macsec.
+# macvlan -> bridge -> team -> dummy
+kci_test_team_bridge_macvlan()
+{
+	local vlan="test_macv1"
+	local bridge="test_br1"
+	local team="test_team1"
+	local dummy="test_dummy1"
+	local ret=0
+
+	run_cmd ip link add $team type team
+	if [ $ret -ne 0 ]; then
+		end_test "SKIP: team_bridge_macvlan: can't add team interface"
+		return $ksft_skip
+	fi
+
+	run_cmd ip link add $dummy type dummy
+	run_cmd ip link set $dummy master $team
+	run_cmd ip link set $team up
+	run_cmd ip link add $bridge type bridge vlan_filtering 1
+	run_cmd ip link set $bridge up
+	run_cmd ip link set $team master $bridge
+	run_cmd ip link add link $bridge name $vlan \
+		address 00:aa:bb:cc:dd:ee type macvlan mode bridge
+	run_cmd ip link set $vlan up
+
+	run_cmd ip link del $vlan
+	run_cmd ip link del $bridge
+	run_cmd ip link del $team
+	run_cmd ip link del $dummy
+
+	if [ $ret -ne 0 ]; then
+		end_test "FAIL: team_bridge_macvlan"
+		return 1
+	fi
+
+	end_test "PASS: team_bridge_macvlan"
+}
+
 #-------------------------------------------------------------------
 # Example commands
 #   ip x s add proto esp src 14.0.0.52 dst 14.0.0.70 \
-- 
2.52.0


