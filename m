Return-Path: <netdev+bounces-289047-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EmeCzYIC2r4/QQAu9opvQ
	(envelope-from <netdev+bounces-289047-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:38:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC9056CD0B
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2790E303671D
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17AA41C2F3;
	Mon, 18 May 2026 12:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iz/Fkk51"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D6240DFDB
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107345; cv=none; b=i/kzmBU8O87SWH+mIhum8AbQ2yh1i6f/GDr9fFWIiJ3UFRShyS7xQr3Lqzdr8AAiZkvhBPvjM3QGQ63QCzN1Sk4CarvsQ+shgrwqJTHHhHn71BRroQLipR9rD5XCdUUjpcr8cu23x2Mg4k6d6YGXi3dT6MoOMkQSgr9YPdlJSgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107345; c=relaxed/simple;
	bh=eJhmadjCcpjQAr9bsOjNYrpNs8J18d9cXveySIGVjgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=if3dErjzG4EC1HkzKIiEM13OqCZNdolcQSzV4kM7u7QmlVet7bWOsHINRVSYUAj4hFShA/svGCKDgFERlw/n0UI6gTOEyAjVxXNKDpuk3JidspVmmNaOmvCxVBJP25tWdAfYZRAIZHsF2EcastWnhK1S4GND1Bhn4B1Q+CDA5mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iz/Fkk51; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso13018435e9.1
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 05:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779107341; x=1779712141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=casa8DWjIOa9cP+i+8hwt/ggHd+PKlO9cEQzmI4OQZE=;
        b=Iz/Fkk51wmkaiDKzRRVhHgFHf5FnEU5Co8eHab+e2ZrQCeXZLmkciVF/n56mVNaGsn
         pTJJnOQJ0FNnqgmBm11j02pHmG9Zyo6BcdJENJrjYgEG5oAsm85D3budxsU8JAQK9jsq
         N5rFjoVxdyyUInfPnITOzPJ0e7RgVhm/SnsZU9NJwSZtrBQuohnnmNjS1SIlYrf1OSgJ
         LQ0Ac3JQe10lv4spTPjSRjUEYTr6QcMC4LW8ppt1jXwzdQUrMcE8JTNsHPwYf3Ptj9OO
         WaUjd69K+5yoCyHI94X7JZHy703pFpG8qag7YiaO6ibva6FzC+OBg0gRnmADAK2z+wgc
         cLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779107341; x=1779712141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=casa8DWjIOa9cP+i+8hwt/ggHd+PKlO9cEQzmI4OQZE=;
        b=D8wl74Bif5u+OM/0dC9fvCucMQ1HpDX33Ny5ptKhARYBo0HX3jqMy3fotzraWNovH0
         3YTaenKqV2Xf0wfZG0eZBudGJCGOaZkBKOFu5GtvmF6Gxf5MlTpfA7OjfOkRoe5/x9po
         5/u9cI3uYVStQ9VnguguzVpUDGltyv7cj4MQf9Tn97DSZ50pll7pigkWBYalthWXkLZY
         NZ51jxsJTnpT6cuYAyFcAuq316XJ2xpKKHELE5GzRaBJENrBKTa1hkjcYjxDF6Ejscmh
         paEgwHTQHcDPlqMW1Up4C+FUvCRZmFg+FSUBkGPI8J4HmCaeDnNQVCbPTQ9SYSi8fShm
         vMCQ==
X-Forwarded-Encrypted: i=1; AFNElJ+1nuy006fIJh7oKuDTKCxG3anOyB4eL89H2jwdHRhSUGs3aqaATLKNCl4igvj8QBEunsWB33o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtxqzRJ5ga/YSeKGyYa1005Z1FktyFpD6iq6AIYFmv8O6ZHbPO
	/UbVDy88yVfCJWiFx1bsTq1MZgIHycvO9DXZMsSxKgNyGE8V/FL5vUws
X-Gm-Gg: Acq92OGtc2C80Vo7VeFm7kur/lg1EWx9SJ53/9Gf2vD8XnaRQr5Vdf0eYT80IWU4e4g
	rp0C0oOrOUIcbI61A0gcUOy/M4Qq8tsbkpTJ4e8XbWo8M7HBUUYFYpmxSCh+KDBn1czfh5dkict
	DoAqo7eFTCxKsZjFS0w5CoFJfpaveEo6WunmPewY7aDmEosGLKOSZKf6E/xLDrM6GPgCCz7X6sG
	i6cID5bDaEarSNmaVjdDKFefupN7FtjfaSfPMTzKur0NVMWMX3oDWaeRETqKfLhdjx/FP4H8G+0
	/1SA2/Koxl0wDfthG/AqZsXNEgQJb87CqNRZ3qf5apk8uBIQT84M8zsiPhL+2fH6mvWfzh6/4Kt
	9oFZvGzCmP42MX4/1pDMgXldhESYk/Hv0S+SGMTUxSu4PnlnLzi9wh/xKY+2s2bulpmC1EI+iMn
	KFXREfi/Le++VXX3DCHEtZOuCEVZE=
X-Received: by 2002:a05:600d:10:b0:489:e696:8362 with SMTP id 5b1f17b1804b1-48fe60d7882mr187662735e9.13.1779107341004;
        Mon, 18 May 2026 05:29:01 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48ff2cb4ae0sm104304315e9.0.2026.05.18.05.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 05:29:00 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	jordan@jrife.io,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v6 6/6] selftests/bpf: add bpf_icmp_send recursion test
Date: Mon, 18 May 2026 12:28:42 +0000
Message-Id: <20260518122842.218522-7-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518122842.218522-1-mahe.tardy@gmail.com>
References: <20260518122842.218522-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0DC9056CD0B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-289047-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,iogearbox.net,gmail.com,kernel.org,jrife.io,vger.kernel.org,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mahetardy@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

This test is similar to test_icmp_send_unreach but checks that, in case
of recursion, meaning that the BPF program calling the kfunc was
re-triggered by the icmp_send done by the kfunc, the kfunc will stop
early and return -EBUSY.

The test attaches to the root cgroup to ensure the ICMP packet generated
by the kfunc re-triggers the BPF program. Since it's attached only for
this recursion test, it should not disrupt the whole network.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../bpf/prog_tests/icmp_send_kfunc.c          | 40 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/icmp_send.c | 31 ++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
index d0ac0502f6df..a9e9806877cf 100644
--- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
 #include <network_helpers.h>
+#include <cgroup_helpers.h>
 #include <linux/errqueue.h>
 #include <poll.h>
 #include "icmp_send.skel.h"
@@ -10,6 +11,7 @@
 #define ICMP_DEST_UNREACH 3
 #define ICMPV6_DEST_UNREACH 1

+#define ICMP_HOST_UNREACH 1
 #define ICMP_FRAG_NEEDED 4
 #define NR_ICMP_UNREACH 15
 #define ICMPV6_REJECT_ROUTE 6
@@ -176,3 +178,41 @@ void test_icmp_send_unreach(void)
 	icmp_send__destroy(skel);
 	close(cgroup_fd);
 }
+
+void test_icmp_send_unreach_recursion(void)
+{
+	struct icmp_send *skel;
+	int cgroup_fd = -1;
+
+	skel = icmp_send__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	if (setup_cgroup_environment()) {
+		fprintf(stderr, "Failed to setup cgroup environment\n");
+		goto cleanup;
+	}
+
+	cgroup_fd = get_root_cgroup();
+	if (!ASSERT_GE(cgroup_fd, 0, "get_root_cgroup"))
+		goto cleanup;
+
+	skel->links.recursion =
+		bpf_program__attach_cgroup(skel->progs.recursion, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.recursion, "prog_attach_cgroup"))
+		goto cleanup;
+
+	trigger_prog_read_icmp_errqueue(skel, ICMP_HOST_UNREACH, AF_INET, "127.0.0.1");
+
+	/* Because there's recursion involved, the first call will return at
+	 * index 1 since it will return the second, and the second call will
+	 * return at index 0 since it will return the first.
+	 */
+	ASSERT_EQ(skel->data->rec_kfunc_rets[0], -EBUSY, "kfunc_rets[0]");
+	ASSERT_EQ(skel->data->rec_kfunc_rets[1], 0, "kfunc_rets[1]");
+
+cleanup:
+	cleanup_cgroup_environment();
+	icmp_send__destroy(skel);
+	close(cgroup_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/icmp_send.c b/tools/testing/selftests/bpf/progs/icmp_send.c
index 6e1ba539eeb0..7830334b747a 100644
--- a/tools/testing/selftests/bpf/progs/icmp_send.c
+++ b/tools/testing/selftests/bpf/progs/icmp_send.c
@@ -13,6 +13,9 @@ int unreach_type = 0;
 int unreach_code = 0;
 int kfunc_ret = -1;

+unsigned int rec_count = 0;
+int rec_kfunc_rets[] = { -1, -1 };
+
 SEC("cgroup_skb/egress")
 int egress(struct __sk_buff *skb)
 {
@@ -65,4 +68,32 @@ int egress(struct __sk_buff *skb)
 	return SK_DROP;
 }

+SEC("cgroup_skb/egress")
+int recursion(struct __sk_buff *skb)
+{
+	void *data = (void *)(long)skb->data;
+	void *data_end = (void *)(long)skb->data_end;
+	struct iphdr *iph;
+	int ret;
+
+	iph = data;
+	if ((void *)(iph + 1) > data_end || iph->version != 4)
+		return SK_PASS;
+
+	/* This call will provoke a recursion: the ICMP packet generated by the
+	 * kfunc will re-trigger this program since we are in the root cgroup in
+	 * which the kernel ICMP socket belongs. However when re-entering the
+	 * kfunc, it should return EBUSY.
+	 */
+	ret = bpf_icmp_send(skb, unreach_type, unreach_code);
+	rec_kfunc_rets[rec_count & 1] = ret;
+	__sync_fetch_and_add(&rec_count, 1);
+
+	/* Let the first ICMP error message pass */
+	if (iph->protocol == IPPROTO_ICMP)
+		return SK_PASS;
+
+	return SK_DROP;
+}
+
 char LICENSE[] SEC("license") = "Dual BSD/GPL";
--
2.34.1


