Return-Path: <netdev+bounces-261225-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJfMKaz/n2n3fAQAu9opvQ
	(envelope-from <netdev+bounces-261225-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:09:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 516AC1A24D7
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4513A30D924C
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 08:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC70392C58;
	Thu, 26 Feb 2026 08:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jf6U3W9b"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCC8392C2F;
	Thu, 26 Feb 2026 08:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772093042; cv=none; b=qxBaM8DiOFdfugHHMkMiTr3mtmBV5oOdAEo66Htkf8xuYz35gN7aHnutnnWR59YkiO7WH2dzELq4AWypq1uZMM2mNtDwfQqetaqQclTVSidWIRt6RkZjRFunXJn627BKBRCEd0FNNOF27rmpio2PYZhvPlZIflcPymKS5egwTHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772093042; c=relaxed/simple;
	bh=+hycExEGWtE0bdhgqOqRMa23UKIfFwblRH3Up5uYKWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpEDCL53TG3Cqan8tSXMKl3L9dGuzSbysZsVCEPXqvDp3rJ/DXCC/Pc5FFo/opRgiXYTgOZRfll0SZZoJpuST5YhBxNWvIQHdLc84DRm6zhXjU0a/pgkAs/MKY5aCnsMaTwA/Ct7yAdsU5/Nq4ubMijrPGoB8OAbbCb2ExOZVZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jf6U3W9b; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772093038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hIDvQi4bdzbhu4OAyfHcd+4UtYB4c2IfZnH8v6PcyJg=;
	b=Jf6U3W9bLn8qRUhhikNDWYnCQFuU2LEpJoXug0DVuZIal5/7LSYQMA1LMFf7SAv7jLXe8T
	8X2d4i/eN4nCqTVoUED4zfr7P5g4zpN509xgfavUzdj2dzjhUE+FGq4625JiEyUoJLDaiX
	2IrVVq522eKtQvNMdS1F8Qw8We5tyG4=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: jiayuan.chen@linux.dev,
	jiayuan.chen@shopee.com,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jussi Maki <joamaki@gmail.com>,
	Jonathan Toppins <jon.toppins+linux@gmail.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v1 2/2] selftests/bpf: add test for xdp_bonding xmit_hash_policy compat
Date: Thu, 26 Feb 2026 16:03:02 +0800
Message-ID: <20260226080306.98766-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260226080306.98766-1-jiayuan.chen@linux.dev>
References: <20260226080306.98766-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,shopee.com,jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[29];
	TAGGED_FROM(0.00)[bounces-261225-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,linux];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,shopee.com:email]
X-Rspamd-Queue-Id: 516AC1A24D7
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@shopee.com>

Add a selftest to verify that changing xmit_hash_policy to vlan+srcmac
is rejected when a native XDP program is loaded on a bond in 802.3ad
mode.  Without the fix in bond_option_xmit_hash_policy_set(), the change
succeeds silently, creating an inconsistent state that triggers a kernel
WARNING in dev_xdp_uninstall() when the bond is torn down.

The test attaches native XDP to a bond0 (802.3ad, layer2+3), then
attempts to switch xmit_hash_policy to vlan+srcmac and asserts the
operation fails.  It also verifies the change succeeds after XDP is
detached, confirming the rejection is specific to the XDP-loaded state.

Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 .../selftests/bpf/prog_tests/xdp_bonding.c    | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
index a5b15e464018..0d4ec1e5b401 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_bonding.c
@@ -704,6 +704,61 @@ static void test_xdp_bonding_features(struct skeletons *skeletons)
 	system("ip link del bond");
 }
 
+/*
+ * Test that changing xmit_hash_policy to vlan+srcmac is rejected when a
+ * native XDP program is loaded on a bond in 802.3ad or balance-xor mode.
+ * These modes support XDP only when xmit_hash_policy != vlan+srcmac; freely
+ * changing the policy creates an inconsistency that triggers a WARNING in
+ * dev_xdp_uninstall() during device teardown.
+ */
+static void test_xdp_bonding_xmit_policy_compat(struct skeletons *skeletons)
+{
+	struct nstoken *nstoken = NULL;
+	int bond_ifindex = -1;
+	int xdp_fd, err;
+
+	SYS(out, "ip netns add ns_xmit_policy");
+	nstoken = open_netns("ns_xmit_policy");
+	if (!ASSERT_OK_PTR(nstoken, "open ns_xmit_policy"))
+		goto out;
+
+	/* 802.3ad with layer2+3 policy: native XDP is supported */
+	SYS(out, "ip link add bond0 type bond mode 802.3ad xmit_hash_policy layer2+3");
+	SYS(out, "ip link add veth0 type veth peer name veth0p");
+	SYS(out, "ip link set veth0 master bond0");
+	SYS(out, "ip link set bond0 up");
+
+	bond_ifindex = if_nametoindex("bond0");
+	if (!ASSERT_GT(bond_ifindex, 0, "bond0 ifindex"))
+		goto out;
+
+	xdp_fd = bpf_program__fd(skeletons->xdp_dummy->progs.xdp_dummy_prog);
+	if (!ASSERT_GE(xdp_fd, 0, "xdp_dummy fd"))
+		goto out;
+
+	err = bpf_xdp_attach(bond_ifindex, xdp_fd, XDP_FLAGS_DRV_MODE, NULL);
+	if (!ASSERT_OK(err, "attach XDP to bond0"))
+		goto out;
+
+	/* With XDP loaded, switching to vlan+srcmac must be rejected */
+	err = system("ip link set bond0 type bond xmit_hash_policy vlan+srcmac 2>/dev/null");
+	ASSERT_NEQ(err, 0, "vlan+srcmac change with XDP loaded should fail");
+
+	/* Detach XDP first, then the same change must succeed */
+	ASSERT_OK(bpf_xdp_detach(bond_ifindex, XDP_FLAGS_DRV_MODE, NULL),
+		  "detach XDP from bond0");
+
+	bond_ifindex = -1;
+	err = system("ip link set bond0 type bond xmit_hash_policy vlan+srcmac 2>/dev/null");
+	ASSERT_OK(err, "vlan+srcmac change without XDP should succeed");
+
+out:
+	if (bond_ifindex > 0)
+		bpf_xdp_detach(bond_ifindex, XDP_FLAGS_DRV_MODE, NULL);
+	close_netns(nstoken);
+	SYS_NOFAIL("ip netns del ns_xmit_policy");
+}
+
 static int libbpf_debug_print(enum libbpf_print_level level,
 			      const char *format, va_list args)
 {
@@ -771,6 +826,9 @@ void serial_test_xdp_bonding(void)
 				test_case->xmit_policy);
 	}
 
+	if (test__start_subtest("xdp_bonding_xmit_policy_compat"))
+		test_xdp_bonding_xmit_policy_compat(&skeletons);
+
 	if (test__start_subtest("xdp_bonding_redirect_multi"))
 		test_xdp_bonding_redirect_multi(&skeletons);
 
-- 
2.43.0


