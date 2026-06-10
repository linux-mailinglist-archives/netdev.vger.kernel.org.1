Return-Path: <netdev+bounces-297523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mAyhCHYeKWrtQwMAu9opvQ
	(envelope-from <netdev+bounces-297523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:21:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A81667176
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:21:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=EhrL1R3h;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297523-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297523-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 201F2321A6FA
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC2D3AC0C8;
	Wed, 10 Jun 2026 08:13:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F3A3A4510
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 08:13:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079184; cv=none; b=ZeySyvQxm0EaS4w8mOr5b8CQYJ43jB4wyvJ9bubhhCbFJ/O3WdZIJu+gpfFb6FMqnDHouf9MO77ys9vNbHJlqpbA0CrWkJoMapEzq8ON/YNjXyc8vssOXzw2ne2VI6pXczZocRWlIzqcdLP/WMnxMX2+3eQnwhxib7WfzJg9o7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079184; c=relaxed/simple;
	bh=1LwNYa0nsMkWi/VTO8ktSvbDoho+LWniLHNV/RoBPe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zt51tGI4H45sR/captep1/MNTu9ghb7UjsyHLl/YW7OoP+6eHam1PrSi/k0oLOVYHqS0G0E0b5FyBuyTDmWjZo1RkZKtic9o2WHCXM56X6SslEQueWvjf5d7lM72a4j7MSt8gO8Lt/JoSVrrq/XfiBtR1dHLqdvPT5mFsbUGkPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhrL1R3h; arc=none smtp.client-ip=209.85.216.51
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36dd65b95f2so4641676a91.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 01:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781079183; x=1781683983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3kEhRN8jP8NPUF2dXs8XkRxqkJ3rS6M1G7akkNNwjA=;
        b=EhrL1R3hdkqryyd3ucapXsWMPROpZzMH4iUhRLjXv8TgLGWeLR/WvY/GPTgo2xu4pW
         79nJRKn3ZOXY41JqoVRUriMH8ZGBP+JfN/HTgDisraMEHRb0XfJTrnn/pjSisn7c24te
         cxuDudj7V/iWuSzI3f9tpTncqFvGyz/PoduaSkBD9gVkAKIW/nHOenGNMRvjNe2dmtbj
         PJkdzQsXbpsECCqhrDlfXX5FvbkvROHNiqjF6whzD3EUYMBAEVcwKm4w16R9yuErdAgC
         TeoEs8jN9xBCxIrWIKObIm5J28ZcuyJKc/BzLyB4cYj4kMfIsHYKQGoiRYnGa+Z3/Im9
         ToVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781079183; x=1781683983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v3kEhRN8jP8NPUF2dXs8XkRxqkJ3rS6M1G7akkNNwjA=;
        b=cJl/2RU4sJT5yktiCOVT7Ne/vO88hNbBTzWnqwk97/i0dImapBYtmdmlvVm87t1rWU
         oGTykJA9UQNkVB4WuwcZwWTWbWZJH+McZJ/AmxCFo/qA2HEDYYZFN724/nBXaolMLmsk
         O4AA+xCZ9bNhzKbl9glxjpCwf8hny1b6d0Z/PCi6v68oqQY+YCx4OAPQcqXK9HdCapc2
         E3Pi03mCS6idJMUmkV60diFfx2skP96l4XgDO00MXnLfer0EE1nkmsfbN1YCfqaKnQZj
         zFt2urxWz6HGpysb9XHax3PJ2XLhVzGwANVSQF9ArQ1hRTW7cp0zjvsjy2j6PBxjv8Rg
         jlCQ==
X-Forwarded-Encrypted: i=1; AFNElJ8NPrWpHBptqFwC3F+8jMwNZnRiseC+jb9e6p893vVFUoApTpB8m/GkG3MbToeiKhb60g6oemE=@vger.kernel.org
X-Gm-Message-State: AOJu0YznA9RHbrrjvwv7OFew/U34YPG+Y/2vQ4nmB95IttZRqSVuUcYM
	5x5Bajo4t5rVBSfn7c4fUcQNrFFUBZ7Npl1FJA9bv7olvcmX/3BsDeFk
X-Gm-Gg: Acq92OHNQDUfLGHF0Uknct7btXOA0328VhyHRiPXjydbLj4JFt+6W3cDMLmo1KrG4Ov
	fLYu+296d7JxlPshm0vSLSECR8tg6y3QWb9xsSROogft0C+O3AM0pBDUljeJnSRiZ5+HT9UXslE
	63hxRsILRQeIfRkkYCCjby4weLtiKA5RjvPZoT0lTb+dfg8MaXihjndFel7B6gHtZTTM9duThWF
	ivSqAP8ems57CtnKMRinvOSi6TsE6vQ8A5w7WoDsU8w0c8Lsbe+vO6ZThNPn6TGu9tTikmqzqck
	iqbENNrjp6QVp5mh4aBbPy/tLQxvVIrnqo6hI+cfnQt8nUaNiPkdjL4E0qWqktshmdehsO0ijMV
	jXBnE+BRdaZr3xiqdZiCJ8G4hQ1N+4/Vf++g+9zgbfoduZfRSqmo8JTyx6sKUJ3u8QUPgP0oh+p
	PfsHSMNNvFx8sMoEUQ/aal0sR4RJfe6AXBUjuwsGborPKymSRp7e1+gWmXy70JU6toEqfr5kVg
X-Received: by 2002:a17:90b:2f0d:b0:368:3830:a8bd with SMTP id 98e67ed59e1d1-37131041514mr18542159a91.7.1781079182633;
        Wed, 10 Jun 2026 01:13:02 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37645c1aeb5sm1241003a91.2.2026.06.10.01.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:13:02 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Cong Wang <cwang@multikernel.io>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v2 2/2] selftests/bpf: add test for bpf_msg_pop_data() overflow
Date: Wed, 10 Jun 2026 08:11:54 +0000
Message-ID: <20260610081218.506709-3-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610081218.506709-1-rhkrqnwk98@gmail.com>
References: <20260610081218.506709-1-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297523-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:sdf@fomichev.me,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:cwang@multikernel.io,m:emil@etsalapatis.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,fomichev.me,kernel.org,linux.dev,davemloft.net,google.com,redhat.com,multikernel.io,etsalapatis.com,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91A81667176

Add a test in sockmap_basic.c that calls bpf_msg_pop_data() with a length
close to U32_MAX, which overflows the start + len bounds check. The sk_msg
program records the return value over a sendmsg and the test checks that
the call is rejected with -EINVAL.

Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 48 +++++++++++++++++++
 .../bpf/progs/test_sockmap_msg_pop_data.c     | 27 +++++++++++
 2 files changed, 75 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_msg_pop_data.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index d2846579285f..cb3229711f93 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -14,6 +14,7 @@
 #include "test_sockmap_pass_prog.skel.h"
 #include "test_sockmap_drop_prog.skel.h"
 #include "test_sockmap_change_tail.skel.h"
+#include "test_sockmap_msg_pop_data.skel.h"
 #include "bpf_iter_sockmap.skel.h"
 
 #include "sockmap_helpers.h"
@@ -666,6 +667,51 @@ static void test_sockmap_skb_verdict_change_tail(void)
 	test_sockmap_change_tail__destroy(skel);
 }
 
+static void test_sockmap_msg_verdict_pop_data(void)
+{
+	struct test_sockmap_msg_pop_data *skel;
+	int err, map, verdict;
+	int c1 = -1, p1 = -1, sent;
+	int zero = 0;
+	char *buf;
+	const size_t len = 32 * 1024;
+
+	skel = test_sockmap_msg_pop_data__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	verdict = bpf_program__fd(skel->progs.prog_msg_pop_data);
+	map = bpf_map__fd(skel->maps.sock_map);
+
+	err = bpf_prog_attach(verdict, map, BPF_SK_MSG_VERDICT, 0);
+	if (!ASSERT_OK(err, "bpf_prog_attach"))
+		goto out;
+
+	err = create_pair(AF_INET, SOCK_STREAM, &c1, &p1);
+	if (!ASSERT_OK(err, "create_pair"))
+		goto out;
+
+	err = bpf_map_update_elem(map, &zero, &c1, BPF_NOEXIST);
+	if (!ASSERT_OK(err, "bpf_map_update_elem"))
+		goto out_close;
+
+	buf = calloc(len, 1);
+	if (!ASSERT_OK_PTR(buf, "calloc"))
+		goto out_close;
+
+	sent = xsend(c1, buf, len, 0);
+	ASSERT_EQ(sent, (ssize_t)len, "xsend");
+	ASSERT_EQ(skel->data->pop_data_ret, -EINVAL, "pop_data_rejects overflow");
+
+	free(buf);
+
+out_close:
+	close(c1);
+	close(p1);
+out:
+	test_sockmap_msg_pop_data__destroy(skel);
+}
+
 static void test_sockmap_skb_verdict_peek_helper(int map)
 {
 	int err, c1, p1, zero = 0, sent, recvd, avail;
@@ -1373,6 +1419,8 @@ void test_sockmap_basic(void)
 		test_sockmap_skb_verdict_fionread(false);
 	if (test__start_subtest("sockmap skb_verdict change tail"))
 		test_sockmap_skb_verdict_change_tail();
+	if (test__start_subtest("sockmap msg_verdict pop_data overflow"))
+		test_sockmap_msg_verdict_pop_data();
 	if (test__start_subtest("sockmap skb_verdict msg_f_peek"))
 		test_sockmap_skb_verdict_peek();
 	if (test__start_subtest("sockmap skb_verdict msg_f_peek with link"))
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_msg_pop_data.c b/tools/testing/selftests/bpf/progs/test_sockmap_msg_pop_data.c
new file mode 100644
index 000000000000..301e65b95256
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_msg_pop_data.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} sock_map SEC(".maps");
+
+#define POP_START 0x48a3
+#define POP_LEN   0xfffffffd
+
+long pop_data_ret = 1;
+
+SEC("sk_msg")
+int prog_msg_pop_data(struct sk_msg_md *msg)
+{
+	if (msg->size <= POP_START)
+		return SK_PASS;
+
+	pop_data_ret = bpf_msg_pop_data(msg, POP_START, POP_LEN, 0);
+	return SK_PASS;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0


