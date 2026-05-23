Return-Path: <netdev+bounces-291056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uO2AFaZlEWoelgYAu9opvQ
	(envelope-from <netdev+bounces-291056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:30:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8B95BDDE3
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 10:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54FA2301BF63
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 08:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ADD357CFC;
	Sat, 23 May 2026 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KnzM8RUk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C895B352F87
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779525007; cv=none; b=FI7ZvOCNWpw5AyvltWaf3xsteF67/wyU4unJD5RFS3gfNeyVoYdlV8GEwG2OpFQGHOL+Mk/M7XxOgBSy/bVZ9j3CZgIoMBQiiz8jP45PamMEPm8q1sMCDKbL1FbJJS3VtCCyQrAH05LJjNmjlBUCxiZ9OPHvWGvUC6PdPm6Zy/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779525007; c=relaxed/simple;
	bh=FB8BdshNY2JvwdUff0sSUOvQHItNoEdNwVHNGfCfVzY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L+DnAcH8bBdTVmdsIQnVDhLteYYNfSi6KPxMtrNOlxuyQ/7tm/+C4oA1ndDAqhf9MWpy6hKDgBmI6KWQTPeT5HI/VhjmAlkCHxsg/9GVC7uuIJP7DfbAmYRl8b/0OUaTKv1VI52+83WVwIxdHMlqS2naSbnTp5KNvBiL+qfvGb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KnzM8RUk; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c828f0f5c23so3927178a12.1
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 01:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779525005; x=1780129805; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UFyeIDodzT0E9+qWs37vNutpmSr8SonxGWSSL1/SHpY=;
        b=KnzM8RUk6007DmSamaU/QZCq2G3jfBfWpmOvZDHJheYZT9wLsaaLPW+tt0FMvtobxb
         bd4MvcQ9QW9uLYIfu7wnqBobC9U4JTKYLTfC8qS2X7LJK1gFky3PsL3pQZH2f0CssDgn
         RVD3d9Z/Vl9ZRnLkSNdsBYHmTdL+SedxyCWHqJJQ+srB+k1ghgbrmAM+Jb3ZkekUILi4
         ZyiV5HbiXQMnNCZLIy8/0xcpSJrJFRnfA3JpMW/GcDFF6FX8uv22ayW8KlHlhhWO9HKU
         g25ZEt/2VYfYHR5Kgky0Z5gEL+DGqOaBrXpGcXGWLMSp9hyR1aRCU9iEU73e5go9wkPH
         lW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779525005; x=1780129805;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UFyeIDodzT0E9+qWs37vNutpmSr8SonxGWSSL1/SHpY=;
        b=IhS87ZH9JzlCpgzf25S7e7XUD0RalX0d6yxogsXkBfby36wccO9XEq/32Pkm6QgMn/
         UqHPQmFdyLSvw3ZgrWx1dEuQ6jbuP2zq2wB91vr5Go5Mz9K941gEjO0BcV12EJXeUq07
         lQA92yl7R8ypCfT3D4vGlwEhJN/Q5u3mEbbmJPejXyJYVJly95kYfq9qEvjzIRokRiwE
         u4BVZmr7B598xLyfF63hmQPwSXLgRsUy8bWR6xPhIcfSUHtK6WC020wKGzf9C/OpCypE
         iU6PGRP83dBKbEDmHE4V7Mq/WRRtgbnBZHkY/olvxqXY7Ku88EavJxvXYvLdD16J3P7g
         4sbg==
X-Forwarded-Encrypted: i=1; AFNElJ/ZccZPt8adgXAhsQr2cUvMQGmK0bR0HmQdXxvw0dwmT3wQI7ZZjBBW3Oil3WHJedpYFywbWpA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl/hTTE1wxL86BksTOoyoj+evf1Sfv5UByaiZewH6c2mSQW22j
	8cGaYN6bgI9sZJnfiaN60S8Ylbb3OELfnyWFnamUAXtvon2tQejV9P07FXgc2Bk5fOoRpCY7DZD
	WAlsriw==
X-Received: from pgwg15.prod.google.com ([2002:a65:6ccf:0:b0:c79:81df:117c])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a123:b0:3a0:bc61:62e6
 with SMTP id adf61e73a8af0-3b328caba1bmr7745952637.8.1779525004866; Sat, 23
 May 2026 01:30:04 -0700 (PDT)
Date: Sat, 23 May 2026 08:29:30 +0000
In-Reply-To: <20260523083001.2911931-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260523083001.2911931-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260523083001.2911931-2-kuniyu@google.com>
Subject: [PATCH v3 bpf-next 01/11] selftest: bpf: Use BPF_SOCK_OPS_ALL_CB_FLAGS
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291056-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.851];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BC8B95BDDE3
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


