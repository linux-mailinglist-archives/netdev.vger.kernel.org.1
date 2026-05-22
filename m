Return-Path: <netdev+bounces-290702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJMSA3YKEGpqSwYAu9opvQ
	(envelope-from <netdev+bounces-290702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:49:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC555B0315
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 313A33003ED3
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 07:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54ADC392825;
	Fri, 22 May 2026 07:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ndcbHXC5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057111A6829
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 07:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435968; cv=none; b=HD5FEkShr3bDVDx6TokZ1JEumjfbPqheFWyzmQVyDrKd4qpy0F/LZHoai1FXOM2/RC1x0AsA4S829xo5k5NCDpwiUR7vDrn0wnfsN4Z5GvHzWbSnmsnCxFWjDYM7dD//AVWLaoofu4upXx4o3c7afi7eOw7kuVWMS+26z3GVDgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435968; c=relaxed/simple;
	bh=FB8BdshNY2JvwdUff0sSUOvQHItNoEdNwVHNGfCfVzY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=swhpUfl/64a9sIRxIz9uIF3q38KZk/O7yqi2iIq1BciRLe8E3l7sA4RB8bKd2GfvQvGVtOwdVO0TypULmEepSw6AExJzjgA6AgcAon1qHcZIezEbbw2rXsUh+HaXxcwzurFt8SHqbWmwwWI1+SGRz+4HSqUNo2GXQX3NH7hSEKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ndcbHXC5; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8271fb43d0so4007829a12.1
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 00:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779435966; x=1780040766; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UFyeIDodzT0E9+qWs37vNutpmSr8SonxGWSSL1/SHpY=;
        b=ndcbHXC50sZ9O82dBqcKJxrqNOnY8xnoflZDaLG2Jr+3RxeCRHs4g1atRSx3T1KJ4s
         FEgUhM7vuVSAUYgId+aUBls2iavDa953FAwd9kNsc7IhQQphFeJaKX+VIGL3O7+LOPIa
         h5elkK3YUDlcEYn1InaQGHU7w5+NVO4YOOz9B3aM7x8Ub42f6DsldWIchoLRCzZx90Yj
         UWe4womiyXcyQROjxgDbiZihWlKHyHo87W8UCFD2+piSRrXepj9rls6C9qwPKAegZfMd
         zNXMoAhji0A3TnjJu+sey8XJMK7BDOBgMFaYBbseJpkM9+o5NhoaywXlX4sISKIYkiGh
         6Krg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779435966; x=1780040766;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UFyeIDodzT0E9+qWs37vNutpmSr8SonxGWSSL1/SHpY=;
        b=JVOYv8GWtMNiK6IYXh7/9lFF0ZoQBO7BxhEgn0mfh/PEbWtjW9iCGxOWRlH9iQWfgp
         JWyydy+CgjHg5tdmgerGzKdKwbnEonyQQveNP5eDJDvK8zgHkYkdP3LqhAB/Zzm7LaRx
         4jd0X0d9ajDnTsCUbL/7EH2LGdJmDlYE5NS/lzra6Qu0cpIHuUPm7LjJkhIT73bnR8SA
         TnMDtYwR41NQTryS0pE0qmKn461dm1uK5epxCJmrpx2za5yS535NI5+yoiU3vpN4SkGj
         l3re+8LEfxV38/PlX79TZL9Yiot6K6SAW7xroX6HiXhj225xldeUU/NOxeKAiAu70zUk
         lAXw==
X-Forwarded-Encrypted: i=1; AFNElJ8vPAXmT1my5c+QvXyHH5Av/mkCLDVk+l6ptONH2owe5CpWChbw/dXl/wRSrhML/2NME4ZoH4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxonLBQuMQf5FD8ab5zqCMjVa6lDeQzXIu/P9+SWh61iVp2hwaQ
	n4msIZQEmu9i126KUQ4P8rf1IsjbLqD4nYmyFoZ4wRIW821v+kaswA/GWAdA4RUmNGL+pJ5/+Rm
	3IVHiBw==
X-Received: from pgdd7.prod.google.com ([2002:a63:1d07:0:b0:c82:283f:132f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:12cd:b0:3b2:8675:47fc
 with SMTP id adf61e73a8af0-3b328e7427dmr2585870637.25.1779435965954; Fri, 22
 May 2026 00:46:05 -0700 (PDT)
Date: Fri, 22 May 2026 07:44:52 +0000
In-Reply-To: <20260522074601.1658705-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522074601.1658705-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260522074601.1658705-2-kuniyu@google.com>
Subject: [PATCH v2 bpf-next 01/11] selftest: bpf: Use BPF_SOCK_OPS_ALL_CB_FLAGS
 + 1 for bad_cb_test_rv.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290702-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.851];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6CC555B0315
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Once bpf_sock_ops_cb_flags_set() supports a new flag,
tcpbpf_user.c fails due to the hard-coded max value, 0x80.

Let's replace 0x80 with BPF_SOCK_OPS_ALL_CB_FLAGS + 1.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c | 3 ++-
 tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c b/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
index 7e8fe1bad03f..e4849d2a2956 100644
--- a/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
+++ b/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
@@ -26,7 +26,8 @@ static void verify_result(struct tcpbpf_globals *result)
 	ASSERT_EQ(result->bytes_acked, 1002, "bytes_acked");
 	ASSERT_EQ(result->data_segs_in, 1, "data_segs_in");
 	ASSERT_EQ(result->data_segs_out, 1, "data_segs_out");
-	ASSERT_EQ(result->bad_cb_test_rv, 0x80, "bad_cb_test_rv");
+	ASSERT_EQ(result->bad_cb_test_rv, BPF_SOCK_OPS_ALL_CB_FLAGS + 1,
+		  "bad_cb_test_rv");
 	ASSERT_EQ(result->good_cb_test_rv, 0, "good_cb_test_rv");
 	ASSERT_EQ(result->num_listen, 1, "num_listen");
 
diff --git a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c b/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
index 6935f32eeb8f..e30cb1fab079 100644
--- a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
@@ -92,7 +92,8 @@ int bpf_testcb(struct bpf_sock_ops *skops)
 		break;
 	case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
 		/* Test failure to set largest cb flag (assumes not defined) */
-		global.bad_cb_test_rv = bpf_sock_ops_cb_flags_set(skops, 0x80);
+		global.bad_cb_test_rv = bpf_sock_ops_cb_flags_set(skops,
+								  BPF_SOCK_OPS_ALL_CB_FLAGS + 1);
 		/* Set callback */
 		global.good_cb_test_rv = bpf_sock_ops_cb_flags_set(skops,
 						 BPF_SOCK_OPS_STATE_CB_FLAG);
-- 
2.54.0.746.g67dd491aae-goog


