Return-Path: <netdev+bounces-276267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAnAMRvQ1WkC+QcAu9opvQ
	(envelope-from <netdev+bounces-276267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 05:48:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE753B6A41
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 05:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C663B301E6F2
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 03:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740442459DD;
	Wed,  8 Apr 2026 03:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpkFwlzz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8B61CAA7D
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 03:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775620027; cv=none; b=RBuaNOODTukv3eVjP+GadI1pVmVCSYlHjJOchkGyseNNx7NqflYrHa2SbNH1xtAxgjPBqYZn1tX3omEI61bEqYH9oSJ0KZAuHuC8ou/6XN7SdrUS2S8ADYgVciMoJQwaQ/hPAgWsnYnftDcmQB9LrPdPad6HtRZFmaS6+rZBlj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775620027; c=relaxed/simple;
	bh=qcV42KYEemU5riSTjc6YXQrEjjsTBdVPiuqNE8v7kl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YN00oFLESn7FKsC+7VFjkoBzFmbBC8UETv7BSWqHoLbzc6r19mLyZZ08bVClQNbEWP7vPvriBy3/3QoujwkC+lGhqGwLAfpAf8CFFEOjH6rV6BfD6c90FcaOLekGpvUBPD2SnIUzP+a9eElZzEvmMkpzrAQAFYR5hkbud3TxJwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpkFwlzz; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7986e538decso61015007b3.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 20:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775620025; x=1776224825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDq9GzdF3GTXYAI+d4YHY/mPxeR+u0QCqSkXrW51+Yo=;
        b=SpkFwlzzQmYfscXIlDaIiVVkmkLrKaVlbQWodbevxZP2Hu0Tfgwg8ogiCeu5ka9VuY
         EIH9XcEGTBOuB61dQkWHDx1rIYVUq0r+wgctui6HCoyvGR9m1AsoWxtcUqQ+BgGZRi3W
         qA7VTsqOtSN2mhn0HD/ugwCF/vsVignSTwvZuQDgpuges/iYF7y2qeAfr+aVuANo1DfQ
         l1+5AucCrldeS9Jq1XCmPcpDuM80jMYXrHBVc15pTYuS6M6CE3WRUzTp8XaAG18XgsIF
         6OZGJlImYj4Ku6bv3JcKfogVgNj8c1oFsSDzTFUaIblMbtY0HNmS8jSIapuOrQ7Czxj/
         dk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775620025; x=1776224825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZDq9GzdF3GTXYAI+d4YHY/mPxeR+u0QCqSkXrW51+Yo=;
        b=Qq17WSAi8FBvakrsc6aKwBAHa/EnAUH8/dCzXkoyuhsir6mBehw5nq54vA26FENtbg
         mLh/DIad99kFyZrTf7lQ0havP7uu2NkUzWSGyr7c3LBeEJRoxc6ay4500el4oHAz/ODC
         QlwRGokecn1hFFrh4OhMw0TrGd8qFeAjDtBkYCtIdIOoSr2DRkdxaHjKNwJsidtnwy5b
         lc6abT7tQrEyVaIXc7D6jl9Wf/P8YdEyzapkNEcgmXxv/9Lo5VvS5SfC959/C033QrV8
         Kzb48yYYpYBU+bD8aNUNsMizakS1yOac3d5CV/kq95brOHltxa0dfDF9GtwPLxH6vWIz
         C4Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVY11mhXWEVRiaIALPk3GQluLjnWu8VArvA8L4gp49i2vYEFEWOxIZlJJyfUw9VRi3quzaov5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgJuoM/aFk4AIdrWw5DaG078tgqeDDNZsdIw0ZOvmhbShaR42L
	LPgWIfZj86x//ndxjCMGEP8fYxxfl1yttmwAZ/GghCOSu3dz+vVAW3c/
X-Gm-Gg: AeBDievA84MTbaeyDm7Qz7yIsgFpHLDf3ghew6a1ObLVxG9QNQlT2rIR3RgSp62wu7r
	3u2G9JR3opZlN3KLIas9wF6+l0YIkBkwwGscYeeMTJQzKnqnYNPVBpporECtfQjsQlE9aDJnzQK
	gsnF+ChhuquPWdVfwBgVN2DfP8wZBPpMz/rzn59aQV2wkOgHw8CkzP48fvmszlk8xUsCpj3V/Cu
	e47cwxEuyGaXlZ0TPg47X1baK6vwhHHjrkwpsPAxhiNRtp6t1mM79nYDuBqQj9HJy1MWl1SShY6
	OwocaBejjUUxRroNpyy5s+3sW5Hqb+niDqKUkeNOvE8DnkXjw61HGW80gUkuE9oWExsjLVO6cWe
	WmzM2aupkGTRPUJCksKkPsnvJrmaMPeCcrHWmmFy+mikB2Y6quQaSB8PQaloyS5a249dVwKx4qx
	y4Q+hyfJ7DNgQlIMkvdHKFdYMsCExX0B+od5igO8N06gOYfYNtiRT4kBD5IPAi8om66UGMaApLY
	uGObktvUohl6Xopdcg2qk7JxMz2ol3vmqDXRvBAMdgXFKYz2hms/xutVmgj0Toa7TxtQuta74Kr
	AQ==
X-Received: by 2002:a05:690c:dc9:b0:79e:9cc1:ede7 with SMTP id 00721157ae682-7a4d62545a3mr195592387b3.10.1775620025220;
        Tue, 07 Apr 2026 20:47:05 -0700 (PDT)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a370df155csm79129167b3.36.2026.04.07.20.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 20:47:04 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	horms@kernel.org,
	syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf v4 2/2] selftests/bpf: cover short IPv4/IPv6 inputs with adjust_room
Date: Wed,  8 Apr 2026 11:46:23 +0800
Message-ID: <20260408034623.180320-3-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408034623.180320-1-sun.jian.kdev@gmail.com>
References: <20260408034623.180320-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,fomichev.me,google.com,syzkaller.appspotmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276267-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,619b9ef527f510a57cfc];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4EE753B6A41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a selftest covering ETH_HLEN-sized IPv4/IPv6 EtherType inputs for
bpf_prog_test_run_skb().

Reuse a single zero-initialized struct ethhdr eth_hlen and set
eth_hlen.h_proto from the per-test h_proto field.

Also add a dedicated tc_adjust_room program and route the short
IPv4/IPv6 cases to it, so the selftest actually exercises the
bpf_skb_adjust_room() path from the report.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 .../selftests/bpf/prog_tests/empty_skb.c      | 40 +++++++++++++++++--
 tools/testing/selftests/bpf/progs/empty_skb.c |  7 ++++
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/empty_skb.c b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
index 438583e1f2d1..c9fcb70cbafb 100644
--- a/tools/testing/selftests/bpf/prog_tests/empty_skb.c
+++ b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
@@ -10,8 +10,8 @@ void test_empty_skb(void)
 	struct empty_skb *bpf_obj = NULL;
 	struct nstoken *tok = NULL;
 	struct bpf_program *prog;
+	struct ethhdr eth_hlen;
 	char eth_hlen_pp[15];
-	char eth_hlen[14];
 	int veth_ifindex;
 	int ipip_ifindex;
 	int err;
@@ -25,7 +25,9 @@ void test_empty_skb(void)
 		int err;
 		int ret;
 		int lwt_egress_ret; /* expected retval at lwt/egress */
+		__be16 h_proto;
 		bool success_on_tc;
+		bool adjust_room;
 	} tests[] = {
 		/* Empty packets are always rejected. */
 
@@ -46,6 +48,28 @@ void test_empty_skb(void)
 			.err = -EINVAL,
 		},
 
+		/* ETH_HLEN-sized packets with IPv4/IPv6 EtherType but
+		 * no L3 header are rejected.
+		 */
+		{
+			.msg = "veth short IPv4 ingress packet",
+			.data_in = &eth_hlen,
+			.data_size_in = sizeof(eth_hlen),
+			.ifindex = &veth_ifindex,
+			.err = -EINVAL,
+			.h_proto = htons(ETH_P_IP),
+			.adjust_room = true,
+		},
+		{
+			.msg = "veth short IPv6 ingress packet",
+			.data_in = &eth_hlen,
+			.data_size_in = sizeof(eth_hlen),
+			.ifindex = &veth_ifindex,
+			.err = -EINVAL,
+			.h_proto = htons(ETH_P_IPV6),
+			.adjust_room = true,
+		},
+
 		/* ETH_HLEN-sized packets:
 		 * - can not be redirected at LWT_XMIT
 		 * - can be redirected at TC to non-tunneling dest
@@ -54,7 +78,7 @@ void test_empty_skb(void)
 		{
 			/* __bpf_redirect_common */
 			.msg = "veth ETH_HLEN packet ingress",
-			.data_in = eth_hlen,
+			.data_in = &eth_hlen,
 			.data_size_in = sizeof(eth_hlen),
 			.ifindex = &veth_ifindex,
 			.ret = -ERANGE,
@@ -68,7 +92,7 @@ void test_empty_skb(void)
 			 * tc: skb->len=14 <= skb_network_offset=14
 			 */
 			.msg = "ipip ETH_HLEN packet ingress",
-			.data_in = eth_hlen,
+			.data_in = &eth_hlen,
 			.data_size_in = sizeof(eth_hlen),
 			.ifindex = &ipip_ifindex,
 			.ret = -ERANGE,
@@ -108,17 +132,27 @@ void test_empty_skb(void)
 	SYS(out, "ip addr add 192.168.1.1/16 dev ipip0");
 	ipip_ifindex = if_nametoindex("ipip0");
 
+	memset(eth_hlen_pp, 0, sizeof(eth_hlen_pp));
+	memset(&eth_hlen, 0, sizeof(eth_hlen));
+
 	bpf_obj = empty_skb__open_and_load();
 	if (!ASSERT_OK_PTR(bpf_obj, "open skeleton"))
 		goto out;
 
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		if (tests[i].data_in == &eth_hlen)
+			eth_hlen.h_proto = tests[i].h_proto;
+
 		bpf_object__for_each_program(prog, bpf_obj->obj) {
 			bool at_egress = strstr(bpf_program__name(prog), "egress") != NULL;
 			bool at_tc = !strncmp(bpf_program__section_name(prog), "tc", 2);
+			bool is_adjust_room = !strcmp(bpf_program__name(prog), "tc_adjust_room");
 			int expected_ret;
 			char buf[128];
 
+			if (tests[i].adjust_room != is_adjust_room)
+				continue;
+
 			expected_ret = at_egress && !at_tc ? tests[i].lwt_egress_ret : tests[i].ret;
 
 			tattr.data_in = tests[i].data_in;
diff --git a/tools/testing/selftests/bpf/progs/empty_skb.c b/tools/testing/selftests/bpf/progs/empty_skb.c
index 4b0cd6753251..44326f5cc8bb 100644
--- a/tools/testing/selftests/bpf/progs/empty_skb.c
+++ b/tools/testing/selftests/bpf/progs/empty_skb.c
@@ -35,3 +35,10 @@ int tc_redirect_egress(struct __sk_buff *skb)
 	ret = bpf_clone_redirect(skb, ifindex, 0);
 	return 0;
 }
+
+SEC("tc")
+int tc_adjust_room(struct __sk_buff *skb)
+{
+	ret = bpf_skb_adjust_room(skb, 4, BPF_ADJ_ROOM_NET, 0);
+	return 0;
+}
-- 
2.43.0


