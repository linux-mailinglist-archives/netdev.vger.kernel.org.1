Return-Path: <netdev+bounces-288204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPKzFwHKBmrynwIAu9opvQ
	(envelope-from <netdev+bounces-288204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 09:23:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB3A54A7F9
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 09:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ABCB30ACB20
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 07:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664A93E51C6;
	Fri, 15 May 2026 07:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S9vPMdI6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39083E5EDD
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 07:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778829322; cv=none; b=jR6nC/t7bZ6ncVVWkvElQroWfw2OCq/K0CAWLiKEuti7cB8BQNG8HntnPP1UfThaACgSLHDtvncpKDzz7cqbSm4Czt5QvH1f/KLQeFMnLPptdoT2S6S4+rtW1ZsC5RTG7wOEVXQkpvD8C8ToyrabPEdDkcmmWmmMfdej7j1n7b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778829322; c=relaxed/simple;
	bh=Mqeo7wSQ9cvujMQ58+fSENQkR7cydw5nHM5UQoNm3Hs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eXRQK3CC8tMyp1IJdEOY3CuxJMDFkL/GQQFr62mMpPEAffskWk65jMIxJtBiDAcA1P5S79esOv+EvgvWfhbx5tbBJ+Lrj+Ytwne2S39NDrkZHyIBpBbSUqRo99GvFQWRIoWcQz+Incf7MjZFwTI89U0H3R/aJdAgtW6iipiYciM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S9vPMdI6; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-369467ab5bfso1158970a91.0
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 00:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778829319; x=1779434119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b3RlI8YNokBP9FYY4cx+xESI8OetO8LQ784NhfGUE9E=;
        b=S9vPMdI6vSCS+K/V4XWlsDip5fbD5OfCPU+ugohnoOo8A6tHTW7kKSxxdoJIK2r8wy
         t0iDOUzqnfNlQh0y3D24hKNnZTKetB41AqGVZFuz+IUlRdcnmK+Geglnv+3JOrWEn+dM
         DetHKi+AG9wq8CfAr4a3xBh1quad7SPnISyG4yr/X8bCFW2mFEMcK2ylvMmUlcw/u37z
         /GJX82SqfMFqtIdm1CZnXydHZbg3uTZArVCultcmCR/296Q0wYw5QqrL9hdfcMehPOZ+
         seT0EqjpZHCSB8G+kloczHfLTMgTcr49LkjSlreTsNeOEXp5ZJwz0XQ82QTNT82RqHvH
         68Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778829319; x=1779434119;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b3RlI8YNokBP9FYY4cx+xESI8OetO8LQ784NhfGUE9E=;
        b=NI8rBNw6IjgQ8r4Wf+8moIo+uD7a44XtDzIIG9fOdONxXVO7JA9QWYEZR5COclMnNc
         rV9zFyBdX3rpqIYKm4W26L2/YGLV8mNdvTdRo0DYk0bNihOE7QtJV17vb9P8RD95HgDR
         hz9i+feY3z7bNQqXDeYB/Z0rs5LNluwSvDC7TbFXwo/3MxWEyO58hxj7RX4n/Zj2hoaN
         +Fou1hCaMdRQg0wbSjSUgbh7yrWqjEvkICGTuP3HUP9onH4XdKkRx8nR07KyjLXjjPxw
         fsj4Nma7MZl9eCr84yPFUz01eG/WToS3N8vf6ZAk65iuMtWcvh5oKy4VRRceTvO6n6V8
         DP9w==
X-Forwarded-Encrypted: i=1; AFNElJ+C0MjtmKbxupESIblq+SmXlEdxMvIZnrlzK2yWpFp4rVhFSncoz6Zp7FxWdZAykexQQagyjzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKjSSwZYQrMc5C+3xiEcdRT8u/8uRvoT6IVXPuK53fGPPklq4Z
	WMQ69/8ooycOistnTi6YNKLdO/yDuMD23qdTlCbosddUA1nnZ76DbA//s+cRTe8RSRrws/5YGzo
	iWRpM8hhpgR0s2GT0LmmoG5Fwng==
X-Received: from pfbdu16.prod.google.com ([2002:a05:6a00:2b50:b0:82f:9778:a429])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:90a9:b0:837:e9cc:d470 with SMTP id d2e1a72fcca58-83f33c9ec67mr3222990b3a.20.1778829318594;
 Fri, 15 May 2026 00:15:18 -0700 (PDT)
Date: Fri, 15 May 2026 16:15:04 +0900
In-Reply-To: <20260515071504.2054786-1-yuyanghuang@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515071504.2054786-1-yuyanghuang@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515071504.2054786-3-yuyanghuang@google.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add verification for
 BPF_PROG_QUERY attr size boundaries
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CAB3A54A7F9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288204-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,lunn.ch,iogearbox.net,gmail.com,google.com,linux.dev,blackwall.org,redhat.com,fomichev.me,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add a new selftest to verify that the BPF syscall (specifically
BPF_PROG_QUERY) correctly respects the caller-declared attribute
size boundaries:
- Optional output fields (like query.revision) are not written if the
  caller-declared size ends before them.
- Calls with a size below the mandatory minimum return -EINVAL.
- Full-size calls still receive the optional fields normally.

Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
Link: https://lore.kernel.org/r/CANP3RGfZTXM_u=3DE_atoomPZXutoQJ02nOMkCCR-Y=
BZbOm2suWA@mail.gmail.com

Tested with virtme-ng:
# ./test_progs -t bpf_attr_size
#17/1    bpf_attr_size/query_size_boundaries:OK
#17/2    bpf_attr_size/query_mandatory_too_short_einval:OK
#17      bpf_attr_size:OK
Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
---
 .../selftests/bpf/prog_tests/bpf_attr_size.c  | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_attr_size.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_attr_size.c b/tools=
/testing/selftests/bpf/prog_tests/bpf_attr_size.c
new file mode 100644
index 000000000000..65fd717782de
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_attr_size.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Google LLC */
+#include <linux/bpf.h>
+#include <unistd.h>
+#include <sys/syscall.h>
+#include <test_progs.h>
+#include "test_tc_link.skel.h"
+#include "tc_helpers.h"
+
+#define OLD_QUERY_SIZE		offsetofend(union bpf_attr, query.prog_cnt)
+#define FULL_QUERY_SIZE		offsetofend(union bpf_attr, query.revision)
+#define SHORT_QUERY_SIZE	offsetofend(union bpf_attr, query.attach_type)
+
+static void test_query_size_boundaries(void)
+{
+	LIBBPF_OPTS(bpf_prog_attach_opts, opta);
+	LIBBPF_OPTS(bpf_prog_detach_opts, optd);
+	struct test_tc_link *skel;
+	union bpf_attr attr;
+	int fd, err;
+
+	skel =3D test_tc_link__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_load"))
+		return;
+
+	fd =3D bpf_program__fd(skel->progs.tc1);
+
+	err =3D bpf_prog_attach_opts(fd, loopback, BPF_TCX_INGRESS, &opta);
+	if (!ASSERT_OK(err, "prog_attach"))
+		goto cleanup;
+
+	/* 1. Old size: revision must not be written */
+	memset(&attr, 0, sizeof(attr));
+	attr.query.target_ifindex =3D loopback;
+	attr.query.attach_type =3D BPF_TCX_INGRESS;
+
+	err =3D syscall(__NR_bpf, BPF_PROG_QUERY, &attr, OLD_QUERY_SIZE);
+	if (!ASSERT_OK(err, "query_old_size"))
+		goto detach;
+
+	ASSERT_EQ(attr.query.prog_cnt, 1, "prog_cnt_written");
+	ASSERT_EQ(attr.query.revision, 0, "revision_not_written");
+
+	/* 2. Full size: revision must be written normally */
+	memset(&attr, 0, sizeof(attr));
+	attr.query.target_ifindex =3D loopback;
+	attr.query.attach_type =3D BPF_TCX_INGRESS;
+
+	err =3D syscall(__NR_bpf, BPF_PROG_QUERY, &attr, FULL_QUERY_SIZE);
+	if (!ASSERT_OK(err, "query_full_size"))
+		goto detach;
+
+	ASSERT_EQ(attr.query.prog_cnt, 1, "prog_cnt_written");
+	ASSERT_GT(attr.query.revision, 0, "revision_written");
+
+detach:
+	err =3D bpf_prog_detach_opts(fd, loopback, BPF_TCX_INGRESS, &optd);
+	ASSERT_OK(err, "prog_detach");
+cleanup:
+	test_tc_link__destroy(skel);
+}
+
+static void test_query_mandatory_too_short_einval(void)
+{
+	union bpf_attr attr;
+	int err;
+
+	/* Below minimum size: must return -EINVAL */
+	memset(&attr, 0, sizeof(attr));
+	attr.query.target_ifindex =3D loopback;
+	attr.query.attach_type =3D BPF_TCX_INGRESS;
+
+	err =3D syscall(__NR_bpf, BPF_PROG_QUERY, &attr, SHORT_QUERY_SIZE);
+	ASSERT_EQ(err, -1, "query_too_short_fails");
+	ASSERT_EQ(errno, EINVAL, "query_too_short_einval");
+}
+
+void test_bpf_attr_size(void)
+{
+	if (test__start_subtest("query_size_boundaries"))
+		test_query_size_boundaries();
+	if (test__start_subtest("query_mandatory_too_short_einval"))
+		test_query_mandatory_too_short_einval();
+}
--=20
2.54.0.563.g4f69b47b94-goog


