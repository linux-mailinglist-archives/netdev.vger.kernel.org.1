Return-Path: <netdev+bounces-297003-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zTBSM7TlJ2o94QIAu9opvQ
	(envelope-from <netdev+bounces-297003-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 12:06:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6910D65EB6C
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 12:06:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Wz5V17dK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297003-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297003-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD453306B488
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 10:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEEA3CEB9D;
	Tue,  9 Jun 2026 10:02:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B122A3ACF1D
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 10:02:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999347; cv=none; b=UM3HP4PgP7uT0ADDDoYTENJwwXzAM0Kn232fGLk8ySAMp8EtehNwlh6dh+01BY/fk/IJnZ8r/5UjYk0ljg5tGfKfXSzV8IwPen639Ft4KIsmAUvo9B13EmyAMhvcaa1enNrmAB5DBu2ql1EJgrV+Wo0MAyVRnaX/IiPgkiF2QFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999347; c=relaxed/simple;
	bh=nzrDL90bsBsB7WBv1krwtYWNciI5KVTJUXqrlhwrMKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oBwKAxFgYudZUQyAymi9N6qWFlDaGNnKHReLFOBAvVdb4Y9ZRK4HwhoY+AkEWKBnBsTjDEYjuUKlTXhOKMk9WNMK35CzeAWx4lrEwKQawLwRmusPZflKqiovVlDjekZpOxI57RPpq6eCe7KdVZfuMB0yReiz730aYH4wyKzjw3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wz5V17dK; arc=none smtp.client-ip=209.85.210.177
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8422524cb38so1783800b3a.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 03:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780999346; x=1781604146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c5QAVN7p+JjAGllf82nuL6xsG4iI4YYCey6nu5LA5pQ=;
        b=Wz5V17dKhlowDP4Ul5hWJA9qKji/zC23EReD2SoZjbpwMOVwEpam9c8URHo8RJAZEJ
         BvYgLIvQaBr7hQISlFPL7UajfM5hQvYD1iEa8t0vKImAHBxKrSmgHQrUfQoNDHVxDv2/
         4YMQVxIITDlBFS3y4MObYz+ZVD6msXfOpsgIYEYgnhyUSj5szUS65RPeRJN55MSzN6Dq
         PGPhY7Xxdo0xwmfkUW9JSUDk/JTxItIlhyvzJ9lnQaC2LTCut6VnFKxirWd5hFCaviJz
         6u8hM+AXXZH9sWdyy9pwADbSS0waopVEpPXhw0cU4wIXDDQM596a0oHNkMC6Lul6xRLC
         MvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780999346; x=1781604146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5QAVN7p+JjAGllf82nuL6xsG4iI4YYCey6nu5LA5pQ=;
        b=HsUPWOhiC8RnjOg53CWeIaPGJODJzfZr82GGvTX31p43zb9MU4xGVSGCZ4dy0TT3fd
         4x2qQqM/KaH5PbRWspY65nHEkfMesJElnY6DR357+4ZIuzCsPYI3yPfeynAmFZxTMIIG
         SOxy7VXFDScoDbSfejKPN6G/8F8wjKciw/00hfJ7xWElk33m6G973jOXUrBK9IQ9J4c9
         S3VkH4yqYU7WvsZzCnmXYop18CXJkCMnII0d67EqwBC3KUIYiYc0fBJHCSDGCIIdGMVz
         hw1J9yvfa/Ygju/sCrdUie5fDrVcdzktrWT4gpDzjUdtauspKl3Z5GbnURx24xMVXZmV
         BIwg==
X-Gm-Message-State: AOJu0YxwZpgPT5522hS9TxqJ/gBwtG9W09SZkXcxVnGPamI452CBDAJ8
	2BmsDiwQZR+5nitOtckhP++9eHYacyngOeg5rcLoaV5BRR0+XWR9OqnQ
X-Gm-Gg: Acq92OHPcvf2pDtlpY7W04ySKiHDwwjxqNCGKk8mO5i1ZEMsrMNY2JWe9bAYI0clNDt
	xxQM85vs8L0Coy2ZooDypE2IF9wTSfUEPS7j6IcQpVqqyouk/gaargDAFg2KTRkZ8Dbjkt0TjYU
	1rsF9mMFo7Nwn2CxOidKVOMExRCmNr00pGYxI0ngG1N+5Uom2+YmgYVMajtxgqqw2heZ/9UhqNf
	4WYhcjEMrxob+hOnfI4+M7j5k4Js6hdHlHCCUxen8uhd4ln8kIPOouReYElTx1nbUQTrMc8Qh7e
	FuzMmd0zf7HnU3MZo00bneGJBD1UvSFEgdRuzc86QI2AUcw6qrYIsXUPMjQgpYOq8wFJt14DAjf
	MUPr67XNkvseSatI9boWyt1q0WpEiVvNsyliBb19idZZLUPCSoLtOhjy+BH20nQO+lIYz6az1ST
	U0vV17SnLrmFPqa030jkGT1BD/W+x2V8yh8YsDBU3/grEzVxsJm11dnvz9awEujKYlFxRDwovt7
	oG7bDTcCEZwFm3wvfGALzvs+WWs
X-Received: by 2002:a05:6a00:4407:b0:837:e9cc:d470 with SMTP id d2e1a72fcca58-842b0e84bbamr20569193b3a.20.1780999345960;
        Tue, 09 Jun 2026 03:02:25 -0700 (PDT)
Received: from u2404-VMware-Virtual-Platform.localdomain ([2a12:a304:100::109f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282378986sm21365151b3a.22.2026.06.09.03.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:02:25 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	shuah@kernel.org,
	liuhangbin@gmail.com,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH] bpf: Unshare cloned skb before devmap egress XDP program
Date: Tue,  9 Jun 2026 18:02:14 +0800
Message-ID: <20260609100214.337538-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-297003-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:shuah@kernel.org,m:liuhangbin@gmail.com,m:sun.jian.kdev@gmail.com,m:johnfastabend@gmail.com,m:sunjiankdev@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,davemloft.net,gmail.com,fomichev.me];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6910D65EB6C

dev_map_redirect_clone() uses skb_clone() when redirecting a generic XDP
skb to multiple devmap destinations. The cloned skb can share packet data
with other clones.

If the destination devmap entry has an egress XDP program, that program
can modify packet data. Such modifications can then be observed by other
clones sharing the same packet data.

This can be reproduced by strengthening xdp_veth_egress to configure a
different source MAC for each egress device and checking that store_mac_1/2
observe the MAC configured for their own egress devices. Without the fix,
the SKB_MODE subtest observes store_mac_1 receiving the MAC configured for
the next egress device.

Fix this by unsharing the cloned skb before running the devmap egress XDP
program. Limit the extra copy to destinations with an attached egress
program.

Tested with:
  ./test_progs -t xdp_veth_egress
  ./test_progs -t xdp_veth
  ./test_progs -t xdp

Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast support")
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 kernel/bpf/devmap.c                                 |  6 ++++++
 .../selftests/bpf/prog_tests/test_xdp_veth.c        | 13 ++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index cc0a43ebab6b..4ae65d44f9d6 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -730,6 +730,12 @@ static int dev_map_redirect_clone(struct bpf_dtab_netdev *dst,
 	if (!nskb)
 		return -ENOMEM;
 
+	if (dst->xdp_prog) {
+		nskb = skb_unshare(nskb, GFP_ATOMIC);
+		if (!nskb)
+			return -ENOMEM;
+	}
+
 	err = dev_map_generic_redirect(dst, nskb, xdp_prog);
 	if (unlikely(err)) {
 		consume_skb(nskb);
diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
index 3e98a1665936..52d79d5c5629 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
@@ -456,7 +456,11 @@ static void xdp_veth_egress(u32 flags)
 			.remote_flags = flags,
 		}
 	};
-	const char magic_mac[6] = { 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF};
+	const unsigned char egress_macs[VETH_PAIRS_COUNT][ETH_ALEN] = {
+		{ 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0x01 },
+		{ 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0x02 },
+		{ 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0x03 },
+	};
 	struct xdp_redirect_multi_kern *xdp_redirect_multi_kern;
 	struct bpf_object *bpf_objs[VETH_EGRESS_SKEL_NB];
 	struct xdp_redirect_map *xdp_redirect_map;
@@ -512,7 +516,7 @@ static void xdp_veth_egress(u32 flags)
 						 &net_config, prog_cfg, i))
 			goto destroy_xdp_redirect_map;
 
-		err = bpf_map_update_elem(mac_map, &ifindex, magic_mac, 0);
+		err = bpf_map_update_elem(mac_map, &ifindex, egress_macs[i], 0);
 		if (!ASSERT_OK(err, "bpf_map_update_elem"))
 			goto destroy_xdp_redirect_map;
 
@@ -531,13 +535,16 @@ static void xdp_veth_egress(u32 flags)
 
 	for (i = 0; i < 2; i++) {
 		u32 key = i;
+		__be64 expected = 0;
 		u64 res;
 
 		err = bpf_map_lookup_elem(res_map, &key, &res);
 		if (!ASSERT_OK(err, "get MAC res"))
 			goto destroy_xdp_redirect_map;
 
-		ASSERT_STRNEQ((const char *)&res, magic_mac, ETH_ALEN, "compare mac");
+		/* store_mac_1/2 run on the second/third remote veths. */
+		memcpy(&expected, egress_macs[i + 1], ETH_ALEN);
+		ASSERT_EQ(res, expected, "compare mac");
 	}
 
 destroy_xdp_redirect_map:
-- 
2.43.0


