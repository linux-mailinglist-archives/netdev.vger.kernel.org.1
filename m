Return-Path: <netdev+bounces-298612-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tYPvA9jxK2oYIQQAu9opvQ
	(envelope-from <netdev+bounces-298612-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 13:47:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3DB679148
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 13:47:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=oGweB2aj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298612-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298612-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 016EA33C3E77
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36633ECBC7;
	Fri, 12 Jun 2026 11:41:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182E53EB7FF
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 11:41:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264470; cv=none; b=KRfafSGD9w6c+gPOjSvVmS5xI9gdGuK5JGNrvOTjKu4LD24zRk4YRjS+MYWhoZMhMs9dLdKbrWtNNDD4FIIwQkp1bWnQkdobVTMivw0LffACosMpliLXXDn2UmfI2KfQzBt7aW03NgMAHOZsO8abGEklthS+mR0z7ob5H6vRrTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264470; c=relaxed/simple;
	bh=huaKkF4OiakemF/G5xWufP2q3bw29Ry5/D4MKYONanA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dIAann39QPPFAcYr+JBqNOZJl9wFfgeuao5xupG5Dt+g1lERNtjmDORi805xuzM5ECpAMt6m+qMTPiZIuIqtc9o/8DN6y0L4A7BqJkmpPnsu80XqxFVmR3KqTWUeHU52lIze5I+vn9MYIBy0+cFjkDO3mzG+bO2kuVX24wGF/jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oGweB2aj; arc=none smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bf18c30bb2so7323385ad.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 04:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781264468; x=1781869268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WSlICPsYDJ4jrvEuREacBilLreADCVqW54GB3CcEXOQ=;
        b=oGweB2ajY3TcvkPOocH3D3BDZjyqR27g12SU/Zb4eGozEgyTaStJpgZHtEwTHULWZY
         fR34Tv1rfYJR/aa0zKEd4pt+yPRKBHJKNUGm8Hdd29fey3artIt3KRgt5J7/phSpbDkT
         UF9R3GrMVYnLT2RyoXHx3gkoH6k5wMOt2bUvur2mzV2PcwY789YveU5+tXRx66/Df8aY
         mDU4//fE6ZgYaQCfZ0o24dqOCbALaDs6VBLjkabDuCzeEWuOLi4GYnXPLWYyPqavS2TB
         q5tKiaYYV2VHSG8l9IaW0+dYQmdtNkXjhtspkRdc7el2qT6HK6A+qVAhzPLhNhRuf80o
         Rc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781264468; x=1781869268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WSlICPsYDJ4jrvEuREacBilLreADCVqW54GB3CcEXOQ=;
        b=JNI1vLLZBonPZiaqScI6nd1HeqWr3aTXk7zCF1u0xu2GRxyX/BXrReP1HqAsJWdxzz
         TSBPxIDBza9aaGHzN5L0v3Ebg4JsPUnbiPHhGs9QWRo0sRUh23YMsgShfmhgtzAy54IX
         H0K/LpIcmLYD/rdPmpNdjLPpRDrwA+RCUp/02iYgpKhkwED5serCXHD+WCi74decIvYD
         uJaMJhGst8HqK6MZLwUj+/gIfdkyygWsVaWLSgFQmlRHWYTbQEmrVu/r8yxEksfBj3dx
         XQbpMOdLxZd/loXq78+NdhtQS/cBESJfA7XYrJgAVmTr7wVzcRPiZ0OymCwI0ixhAdF1
         7rgQ==
X-Gm-Message-State: AOJu0YxoH098m3RA4krSTbz4bSjec7qXNsvdfPxQsNg3afKWSkF8u0VB
	qmEb1I3aVTG4YWAIfFVHLjxIkQXpRik5aZFNs4h/myWyf7kFMZgsFB0T
X-Gm-Gg: Acq92OEu1OkzNH5HBJH6JaIgMs/5zLjl9wtIIuY+IQnBVQJIPM4acH39/9UUvSoFS0a
	vVD77aquzmh1h80UPRZwF1Z/HFWs1va7HS042mi5PhIPGkxXgKQrYckV+ABGeGyAAlco3DbVcVE
	UaI6CPYIcJaPfSiz5ToGa2ihTlbcY95YsKB7fYH16frd5c8PJXb0QLnXmYnGuLf8xqXcWcJKd1y
	VHVLrMIluoJiGw3/y9YVfpvNVDNclZSZV01zoaVNK0FF4GWyNnuypkS1l0BtT3rjeYTXmZk772D
	5camXoAlkSTfH2lRzDap8Qs0sZMz44zTP1+ZXydG4wfvkpdtE+FWd7oPrlVMrB05m4m7xEvxCFD
	z1gmRc8W8oQdY7g3Ewq57YAkAz59ULWUVS6MiMYuYlxA+XaTVy46UU9e32/QRvTQqVmr0nXWBK5
	NE+Y+27I6X6Ecnn4bcHiqd6xxROFtyJ/loqQ/53TjyQwVH5mPpqwiZLawR0XBlS1hYK70lCeTSG
	E4+9VyHj14S
X-Received: by 2002:a17:903:46cc:b0:2c0:ccdb:e023 with SMTP id d9443c01a7336-2c41255db98mr29606425ad.17.1781264468386;
        Fri, 12 Jun 2026 04:41:08 -0700 (PDT)
Received: from localhost.localdomain ([45.142.165.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac72asm20697455ad.38.2026.06.12.04.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 04:41:08 -0700 (PDT)
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
	jiayuan.chen@linux.dev,
	toke@redhat.com,
	menglong.dong@linux.dev,
	emil@etsalapatis.com,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf v5 2/2] selftests/bpf: Cover generic devmap egress last-dst rewrite
Date: Fri, 12 Jun 2026 19:40:32 +0800
Message-ID: <20260612114032.244616-3-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612114032.244616-1-sun.jian.kdev@gmail.com>
References: <20260612114032.244616-1-sun.jian.kdev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-298612-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:shuah@kernel.org,m:jiayuan.chen@linux.dev,m:toke@redhat.com,m:menglong.dong@linux.dev,m:emil@etsalapatis.com,m:sun.jian.kdev@gmail.com,m:johnfastabend@gmail.com,m:sunjiankdev@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,davemloft.net,gmail.com,fomichev.me,redhat.com,etsalapatis.com];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E3DB679148

Strengthen xdp_veth_egress to check that each destination observes the
MAC selected for its own egress ifindex, instead of only checking that
the observed MAC differs from a single magic value.

Add a generic XDP last-destination test where an earlier destination does
not have a devmap egress program while the final destination does. This
covers the case where the final destination runs on the original skb and
could otherwise rewrite packet data still shared with an earlier cloned
skb.

Use deterministic DEVMAP_HASH keys for the egress map so the intended
last destination is stable. Initialize the result map with a sentinel
value and check that store_mac_1 overwrites it before checking that the
earlier destination did not observe the MAC written by the final
destination.

Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 .../selftests/bpf/prog_tests/test_xdp_veth.c  | 166 +++++++++++++++++-
 1 file changed, 163 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
index 3e98a1665936..1675b32753a8 100644
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
@@ -512,7 +516,13 @@ static void xdp_veth_egress(u32 flags)
 						 &net_config, prog_cfg, i))
 			goto destroy_xdp_redirect_map;
 
-		err = bpf_map_update_elem(mac_map, &ifindex, magic_mac, 0);
+		{
+			__be64 mac = 0;
+
+			memcpy(&mac, egress_macs[i], ETH_ALEN);
+			err = bpf_map_update_elem(mac_map, &ifindex, &mac, 0);
+		}
+
 		if (!ASSERT_OK(err, "bpf_map_update_elem"))
 			goto destroy_xdp_redirect_map;
 
@@ -531,15 +541,162 @@ static void xdp_veth_egress(u32 flags)
 
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
+	}
+
+destroy_xdp_redirect_map:
+	close_netns(nstoken);
+	xdp_redirect_map__destroy(xdp_redirect_map);
+destroy_xdp_redirect_multi_kern:
+	xdp_redirect_multi_kern__destroy(xdp_redirect_multi_kern);
+destroy_xdp_dummy:
+	xdp_dummy__destroy(xdp_dummy);
+
+	cleanup_network(&net_config);
+}
+
+static void xdp_veth_egress_last_dst(u32 flags)
+{
+	struct prog_configuration prog_cfg[VETH_PAIRS_COUNT] = {
+		{
+			.local_name = "xdp_redirect_map_all_prog",
+			.remote_name = "xdp_dummy_prog",
+			.local_flags = flags,
+			.remote_flags = flags,
+		},
+		{
+			.local_name = "xdp_redirect_map_all_prog",
+			.remote_name = "store_mac_1",
+			.local_flags = flags,
+			.remote_flags = flags,
+		},
+		{
+			.local_name = "xdp_redirect_map_all_prog",
+			.remote_name = "xdp_dummy_prog",
+			.local_flags = flags,
+			.remote_flags = flags,
+		}
+	};
+	const unsigned char egress_macs[VETH_PAIRS_COUNT][ETH_ALEN] = {
+		{ 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0x01 },
+		{ 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0x02 },
+		{ 0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0x03 },
+	};
+	struct xdp_redirect_multi_kern *xdp_redirect_multi_kern;
+	struct bpf_object *bpf_objs[VETH_EGRESS_SKEL_NB];
+	struct xdp_redirect_map *xdp_redirect_map;
+	struct net_configuration net_config = {};
+	int mac_map, egress_map, res_map;
+	struct nstoken *nstoken = NULL;
+	struct xdp_dummy *xdp_dummy;
+	__be64 sentinel_mac = 0;
+	__be64 last_mac = 0;
+	__be64 res;
+	u32 key;
+	int err;
+	int i;
+
+	xdp_dummy = xdp_dummy__open_and_load();
+	if (!ASSERT_OK_PTR(xdp_dummy, "xdp_dummy__open_and_load"))
+		return;
+
+	xdp_redirect_multi_kern = xdp_redirect_multi_kern__open_and_load();
+	if (!ASSERT_OK_PTR(xdp_redirect_multi_kern, "xdp_redirect_multi_kern__open_and_load"))
+		goto destroy_xdp_dummy;
+
+	xdp_redirect_map = xdp_redirect_map__open_and_load();
+	if (!ASSERT_OK_PTR(xdp_redirect_map, "xdp_redirect_map__open_and_load"))
+		goto destroy_xdp_redirect_multi_kern;
+
+	if (!ASSERT_OK(create_network(&net_config), "create network"))
+		goto destroy_xdp_redirect_map;
+
+	mac_map = bpf_map__fd(xdp_redirect_multi_kern->maps.mac_map);
+	if (!ASSERT_OK_FD(mac_map, "open mac_map"))
+		goto destroy_xdp_redirect_map;
+
+	egress_map = bpf_map__fd(xdp_redirect_multi_kern->maps.map_egress);
+	if (!ASSERT_OK_FD(egress_map, "open map_egress"))
+		goto destroy_xdp_redirect_map;
+
+	bpf_objs[0] = xdp_dummy->obj;
+	bpf_objs[1] = xdp_redirect_multi_kern->obj;
+	bpf_objs[2] = xdp_redirect_map->obj;
+
+	nstoken = open_netns(net_config.ns0_name);
+	if (!ASSERT_OK_PTR(nstoken, "open NS0"))
+		goto destroy_xdp_redirect_map;
+
+	for (i = 0; i < VETH_PAIRS_COUNT; i++) {
+		struct bpf_devmap_val devmap_val = {};
+		int ifindex = if_nametoindex(net_config.veth_cfg[i].local_veth);
+		u32 key = i;
+
+		SYS(destroy_xdp_redirect_map,
+		    "ip -n %s neigh add %s lladdr 00:00:00:00:00:01 dev %s",
+		    net_config.veth_cfg[i].namespace, IP_NEIGH,
+		    net_config.veth_cfg[i].remote_veth);
+
+		if (attach_programs_to_veth_pair(bpf_objs, VETH_EGRESS_SKEL_NB,
+						 &net_config, prog_cfg, i))
+			goto destroy_xdp_redirect_map;
+
+		{
+			__be64 mac = 0;
+
+			memcpy(&mac, egress_macs[i], ETH_ALEN);
+			err = bpf_map_update_elem(mac_map, &ifindex, &mac, 0);
+		}
+
+		if (!ASSERT_OK(err, "bpf_map_update_elem"))
+			goto destroy_xdp_redirect_map;
+
+		devmap_val.ifindex = ifindex;
+		devmap_val.bpf_prog.fd = -1;
+
+		if (i == VETH_PAIRS_COUNT - 1)
+			devmap_val.bpf_prog.fd =
+				bpf_program__fd(xdp_redirect_multi_kern->progs.xdp_devmap_prog);
+
+		err = bpf_map_update_elem(egress_map, &key, &devmap_val, 0);
+		if (!ASSERT_OK(err, "bpf_map_update_elem"))
+			goto destroy_xdp_redirect_map;
 	}
 
+	res_map = bpf_map__fd(xdp_redirect_map->maps.rx_mac);
+	if (!ASSERT_OK_FD(res_map, "open rx_map"))
+		goto destroy_xdp_redirect_map;
+
+	memcpy(&sentinel_mac, egress_macs[VETH_PAIRS_COUNT - 1], ETH_ALEN);
+	memcpy(&last_mac, egress_macs[VETH_PAIRS_COUNT - 1], ETH_ALEN);
+
+	key = 0;
+	err = bpf_map_update_elem(res_map, &key, &sentinel_mac, 0);
+	if (!ASSERT_OK(err, "init rx mac"))
+		goto destroy_xdp_redirect_map;
+
+	SYS_NOFAIL("ip netns exec %s ping %s -i 0.1 -c 4 -W1 > /dev/null ",
+		   net_config.veth_cfg[0].namespace, IP_NEIGH);
+
+	err = bpf_map_lookup_elem(res_map, &key, &res);
+	if (!ASSERT_OK(err, "get MAC res"))
+		goto destroy_xdp_redirect_map;
+
+	if (!ASSERT_NEQ(res, sentinel_mac, "rx_mac overwritten by store_mac_1"))
+		goto destroy_xdp_redirect_map;
+
+	if (!ASSERT_NEQ(res, last_mac, "earlier dst not rewritten by last dst"))
+		goto destroy_xdp_redirect_map;
+
 destroy_xdp_redirect_map:
 	close_netns(nstoken);
 	xdp_redirect_map__destroy(xdp_redirect_map);
@@ -596,4 +753,7 @@ void test_xdp_veth_egress(void)
 
 	if (test__start_subtest("SKB_MODE/egress"))
 		xdp_veth_egress(XDP_FLAGS_SKB_MODE);
+
+	if (test__start_subtest("SKB_MODE/egress_last_dst"))
+		xdp_veth_egress_last_dst(XDP_FLAGS_SKB_MODE);
 }
-- 
2.43.0


