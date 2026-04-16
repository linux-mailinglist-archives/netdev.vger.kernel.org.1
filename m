Return-Path: <netdev+bounces-279130-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EO/MEEYx4WlGqQAAu9opvQ
	(envelope-from <netdev+bounces-279130-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:58:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4298F413EAF
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA1D1303BAD9
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 18:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304B534BA50;
	Thu, 16 Apr 2026 18:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oiVh+/S9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4DF34B1B4
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 18:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776365856; cv=none; b=ZLSOInBgp06shMDwFJ1mmN/tZ9s8av4QyhES7CaXoSfteAjPpMZ7vf8FTCGxLLT4J88CJGEt2xuJHV9JiRgkMTzMMSEwedw+YRWkyXwiA6CACwsz9Lzj6xHyE3gLqM0ta/3BNCsC7qfgkjfHqf3k2aiddCBVff0rpBUZEvdVSk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776365856; c=relaxed/simple;
	bh=LYvErWUSfRBBnY3NCG9Fg5akGZb3pRfcAuHlM3FU5GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYdhfT1R33jC8pBjkKF0yR8C7nHRDOY4IYi7By6XFBPUXY3LUE3XlYH/xGdd+Lb7y5fAntPYJM4APJpbt2r5NXT/mCU+Egp5Ko51vEh/a9DOEGOuEp4vO3A8erWu2aTFPBqaHgx9rLRf/AIRC6ehy6KLAO7dluqfDdadwV5J5gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oiVh+/S9; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7dbcd92eda5so6046577a34.2
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 11:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776365847; x=1776970647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJHe2LlEDIEncmhqBEcupdpPTOhgj3b45k8NdbW9fgk=;
        b=oiVh+/S96p4iuLLPovi7cwx4PEnBCsXl8cvGx1LprMremmFdvBvXpu1aRoX6rdvJ42
         y+xYKHAV/y0HzLe9flXiLcv4fLk/x5P1rPnc63Gz4KxjVQN8+b/tcyiO0Fbd0caHpuzC
         xMI5YZg+LIowB36JD70MHYC9mQ9cfidVQ5mxqbAV1m4EU+5nGMRsrubP/58Coe/KqaKo
         woUMfCDwn5nDGG710UdWukKAVEAIPLViiV0sTsF0VC18tvjXUWlJQ8FZ/0oTwvyXEz0n
         UXAuXQ+SCqQLmXUvQAatvXEwlYUnH4YCnjc87Zr/aw/BPwPkcnTEdmQeJ0JtVNYkKEn+
         Izng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776365847; x=1776970647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RJHe2LlEDIEncmhqBEcupdpPTOhgj3b45k8NdbW9fgk=;
        b=kX0V69wAkNS3+b8/tpRTFZwNALqTUL3fDDQr2BA0unYeUpnrgrfJZboJkjxHZoIaj/
         dY9lUCt1+Xqwj2LNv52qSbOfvpN5ea9uTyBxHhDxMfir7vrC6l3VYlnKD+ZNQ+z/Te24
         K8+hfA67NBNwt6G0hCiOaxIAXgjnfoXMycppQ/6zgRLCf4OHGEIYL7q7E7p/YxfuYsXV
         ueONXawRETyOSrIgcWn09ID5PXY0EnOm6cRJa1mt2So1XOw1p8uRQmPQ0VVOpNdlPZ4L
         yMLG7711xH8KFLgF9A8rYAkT313FXmOk7SxvnEVc/+KvL9PAHS7whNiJfFpZ7t2GTAch
         wpTw==
X-Gm-Message-State: AOJu0YwBnh+LJtAW6GzsJC00US9L0BUgGhru5LngeRFoeNF2x731fbMU
	4fS4QVqmbFrnZklyw9zFEP+f+0xXgGYCouwedr3MQ5+CuzU7PPq54m2SrSpEBDQg
X-Gm-Gg: AeBDieu5aoCQs0ig+EHQEgWiFr6RyC6rk3dRkdGViTb8XnALWENfKMtEMoNYlWba+fQ
	4bb/cCH3h1/R4eAboI/AwTApXTIIKubPu96nk2aNpryYCiUL70npW4TU7xyNgNCqiOLpQXXtiRZ
	8bvSccE7Fw08+DwTFIKzM2XNWmumOou20BkDdXIEA33LQhye/3Waewi/1a5vx0emC9ykO/TYi5G
	7CuS4ZkYdwFklIiAflDgWLN4EkWnAxM3eMFmy8ghi4Q1BLm57Yud36nzp98WCVIJy9HIZ2foJXK
	dfeDxDH++M5T3Xt6OrlAe/jBgeDIrr+n1zivnL1RgEbBEgfpvifN7y4iiJLuMu7VmauucrDZurE
	SWtjZULf3ryy98lPFt+wycSkao/wso6MBmKv9cvUhyzm1hbBi6ajcocoQqzUg54QZrdBDew3QpV
	tihrMsMSVENuQAlO5wHDGu9NxQecRr
X-Received: by 2002:a05:6830:2b10:b0:7d7:ddc2:540e with SMTP id 46e09a7af769-7dc9230f0b5mr379616a34.6.1776365847603;
        Thu, 16 Apr 2026 11:57:27 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:72::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc90a35c85sm504737a34.3.2026.04.16.11.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 11:57:27 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH net v8 14/15] selftests: net: add team_bridge_macvlan rx_mode test
Date: Thu, 16 Apr 2026 11:57:11 -0700
Message-ID: <20260416185712.2155425-15-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260416185712.2155425-1-sdf@fomichev.me>
References: <20260416185712.2155425-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279130-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,fomichev.me:mid,fomichev.me:email]
X-Rspamd-Queue-Id: 4298F413EAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a test that exercises the ndo_change_rx_flags path through a
macvlan -> bridge -> team -> dummy stack. This triggers dev_uc_add
under addr_list_lock which flips promiscuity on the lower device.
With the new work queue approach, this must not deadlock.

Link: https://lore.kernel.org/netdev/20260214033859.43857-1-jiayuan.chen@linux.dev/
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/config       |  1 +
 tools/testing/selftests/net/rtnetlink.sh | 44 ++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 2a390cae41bf..94d722770420 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -101,6 +101,7 @@ CONFIG_NET_SCH_HTB=m
 CONFIG_NET_SCH_INGRESS=m
 CONFIG_NET_SCH_NETEM=y
 CONFIG_NET_SCH_PRIO=m
+CONFIG_NET_TEAM=y
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


