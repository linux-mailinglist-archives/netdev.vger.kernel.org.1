Return-Path: <netdev+bounces-278152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAdDD8gl3WlcaQkAu9opvQ
	(envelope-from <netdev+bounces-278152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:20:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DF53F1319
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 19:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE05A3079E0D
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 17:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581CD351C31;
	Mon, 13 Apr 2026 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/JKrUUF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f65.google.com (mail-oo1-f65.google.com [209.85.161.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E769834E768
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776100309; cv=none; b=A0uwMbb7ToVe7tJb9bxPfHqLX0xDsOvvg9gfY0NfMVEx6Lh70ioDKfapuhynFISu+y7HlYCN1QQ0jXIrsn+rLOloLApEkJFzh5pBS9H5AOFH9bM4bmDptuvaOT5syOzGk3PDtCkZq86pw3jkM6jOAHSCvZfMq/kjZHOnkhCErac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776100309; c=relaxed/simple;
	bh=D9TgHvyJ1dzHoK5rgtgTsaZkUjFvjnDhI5VcoGqCHEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWoM6sjaib80JH2rKwfuSg33F2yVV9AELhlW0NVs94hBR5iDs27UorGikFFRUpyRona/Iutx0yQnED5nARiea1JqAdxInl2bIEuf1toct9JCGrn4CS4dmYFzVC6/pYpP9JutxlimfsDGJg4OidseyaF29J/nqEAm8yVRm2yMCQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/JKrUUF; arc=none smtp.client-ip=209.85.161.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f65.google.com with SMTP id 006d021491bc7-68c048f9c84so2297940eaf.1
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 10:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776100307; x=1776705107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NH626+phNWEcvfzfsc6Pld8dnKTvqn72RWjl5BDTEk=;
        b=N/JKrUUF0Nb9v88Eea8xDyxNDI+WyX8bv6HWQNjj2CjYtqEb+dlpeW4jHB8nxfvfoF
         uhw+VthT3WoBGRuKr6/bi7biiDpbc6gb8HW3jF2OYBmz1z6/+Pdo2BKFY9jjM4HU5opo
         7gepxLElKFVGOU7n3hVlC9DfeL8m1F/rR6IlV83uut/S2VtHaYk8PwjLyYCTWKMRewGr
         zGJeszpDOwQcuzYdxeBb4aYy9dPluJ7FYxgY6g5pLfWFDJAO3q7BjOa+ONmh5plsJLrc
         mLdwhityaoz3ucA3dczyUgWl4ci5PjhR7p6KFMtqLUXQjsJmaYR/McJbXGGCYDIr+3nY
         RXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776100307; x=1776705107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2NH626+phNWEcvfzfsc6Pld8dnKTvqn72RWjl5BDTEk=;
        b=O6SZI8PLT2IrshgYV1P7iBNhhJtRACUV5HWxqZH9MDVRwmehlSjbz2WmS3Pbfmua04
         MS3R8j8DT35yf1dkzfK5tAsHrdE6PoCjCCUybZrzAY0AGHnfpZoV4yz2Y/oSCyc308Gm
         9+19GQR0cAklUPpjK0TcbjtnGXAi59DPezBkv04HgmtW9D2BvHXKrOD6dn+HGXKPATJK
         PzhWtFyHuaWOgUxOMfKs1kiljSPc7AoxxjfwFqwObjyphW6BIdBEfvEZLVFVKevmk3q3
         jZZeXWvxm/pKG0jK/taRygR8Pxy5kO2K4iy4zLp7KoxF3qVB49ttf5OpLlWJgoXwoZtJ
         IoYg==
X-Gm-Message-State: AOJu0YyhYzEbT16L096e4fTL4NClY7NbPPF/gykKvqMHa8RRD0RUYsKU
	Q9XFp4HUgr+HYfFB/IUJdnCZbMXAtcQMzmhDvokUfRLSq/MicWS1HidpfiqZV0mW
X-Gm-Gg: AeBDievlP9Zi+n9cMO+42pKlsTfYgmvKnU6t9YNSYhkMHKNzktepoow0CGZITMls0dp
	Jo4Fh+MAjvDQfo0gaiJdvXeQSJe3qu+UYf14a76+B0/arvRliGqy5csSQAqyemW2411J/3cpRE5
	oqX80XELt6W7oIHer8BxVGkyrsak+sf1hSzWkh/0kWgeBgjK5Jf1RIqaX4yc2MAK/Pc9uOlSi57
	y8k1DGMwRANyeWmDC8pU/Llm2sR2ddaL8ZZZsqC5xr4bTWylXN8FJgP+mFUtq5zGyCNK4KLe8+1
	hV8y7eWVf/cxpZkQ6ncvwMxGt/koLbmsg6Z4gqjFVfEF0fRG7bGTMAO12k9GH3mbxiXZt06Kq7h
	JgpWTVy0fpGtaoquy5zXxmhMTvDvCXMJ6ml2aoi8Go1xNtLQ/GMvVVtGLZ9KpUxCPMkWM//dCA9
	NSMkoqLE6TkQXX3uqbncdf8WqzxBU=
X-Received: by 2002:a05:6820:1792:b0:68a:1c7c:cda9 with SMTP id 006d021491bc7-68be81e1379mr7462759eaf.32.1776100306810;
        Mon, 13 Apr 2026 10:11:46 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:9::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-68bc84e246fsm6210061eaf.6.2026.04.13.10.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 10:11:46 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v7 14/15] selftests: net: add team_bridge_macvlan rx_mode test
Date: Mon, 13 Apr 2026 10:11:30 -0700
Message-ID: <20260413171131.550126-15-sdf@fomichev.me>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413171131.550126-1-sdf@fomichev.me>
References: <20260413171131.550126-1-sdf@fomichev.me>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278152-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fomichev.me:email,fomichev.me:mid]
X-Rspamd-Queue-Id: A5DF53F1319
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a test that exercises the ndo_change_rx_flags path through a
macvlan -> bridge -> team -> dummy stack. This triggers dev_uc_add
under addr_list_lock which flips promiscuity on the lower device.
With the new work queue approach, this must not deadlock.

Link: https://lore.kernel.org/netdev/20260214033859.43857-1-jiayuan.chen@linux.dev/
Cc: Breno Leitao <leitao@debian.org>
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


