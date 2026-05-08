Return-Path: <netdev+bounces-285686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMQ+AgCS/WnWfgAAu9opvQ
	(envelope-from <netdev+bounces-285686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 09:34:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5FA4F30C7
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 09:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60DEE3042937
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 07:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4A5347506;
	Fri,  8 May 2026 07:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fkhAYxGp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90441328255
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 07:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778225657; cv=none; b=jLbSx1mIw4AOZkSLIMTvcgmpxmgBob42bAUs3q+rx/xNqD/PsHTWY+qc2uLNDoWmFmsoL5vA+DWSipxKMQnPpCMR5HcWfFHlD69b7BoDgNph2ObXGhPedaqBOMgYttuzie9AIv5SvcDbaqltWTfpavmBFwyAr8mHI/5mto18qBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778225657; c=relaxed/simple;
	bh=x+hbrbyxh8joU7zc8IYkaGrVUNZLZ+DVxD9Vg9WJp2U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=goR9L8MCbeDNvjV2CS/p4ZAvFw1gabWiBlPfuSXTkCWnwXx36MMkWolwNxGNFD3HYbv1hrhct9Kmro7URzW4YDOQ8JS+kzw6VrgSz6QHvyE5vkPow1HP3KVLFTAzXG766EJzTJ2rzf4CyB2zTYCeS+KWlhzbP6QNaMne11eist8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fkhAYxGp; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-365faf6006dso2060537a91.1
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 00:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778225656; x=1778830456; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GXogNOnQ/1dLBNgOdNOlxajjGjfgFFP8vSw38H8BBHg=;
        b=fkhAYxGpZQX1whqRFXcdeKp+5v20Cl5m2F2abokNmcZijArf52aOs0oXWQscyCeAaU
         NoFvC99MpQortJw330wVhUXcwOU9pUYqeY0fXeJ+IPdaFx0ScyVYyq6CJ+B7YQEau1j/
         MF+1wBAFPWF/NDS9m2JNC6C9XmAbx/vTw0qdetIQt7DH1S5oJU0/l22tc52DZDk40YJ1
         6+cx3PVda5IkyGJr+m4Uj5XbuMKjlDo2Sed13K1N8cy8qaox+pnSdizCrt02YabDd7jm
         ysPJZ15hO7hapfqitT2xhbb9Yxn6itmdsrbsd35Lc74PdKKxlyP7vXt+jpVOj5d6HkpR
         jUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778225656; x=1778830456;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GXogNOnQ/1dLBNgOdNOlxajjGjfgFFP8vSw38H8BBHg=;
        b=furwqgm7ZaxUXfmA4XTHUVmq7FOlnRxbRUyUZfmvCZ4m1NGbqysm4FaHXCg7pRQ/t2
         0P5LA2fGP2kMWhGOhJNfmoZoyInJZiitAHXsU9evz860ddMnRUw95m4QJAPulUS7vFFE
         rbhFvp0GAKGjVEGZVZIEwVDh9UgHy5UIb4/dk8IUuDF2QScFGJzT7XhvYn7kQbeXPebR
         LLjEru/qwJpVRGcrf0pN4F06Ci0mH3KArneJRPGpTo+WCdrfSLIZpK9WjcKARvpexGkw
         mEbwwH9a7Tjcmn8R1lZOVR8A3CjbVYymlU6r2JQe7nPzYY8mbv3k8MlFOj0argq1AEXa
         NYKw==
X-Forwarded-Encrypted: i=1; AFNElJ8vySD2miHCzlCPlN1w4qL7vgYQRgdR/VEA2fIIEdoUfS0DyXI6+uxoqST6ysVRfbgOTjEtcAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQBFsEAqbDF5FmBkGZgbjtIBDYFB32+Q4tavJmkwxurB1EmqD6
	gK19PuD/1cDtV6CMgULKCtMq8vYmPI+Z1DSo6fmWJ9qcWQRdyVjiyFODotaIQ+Xf5O662svL4fh
	FiTweyA==
X-Received: from pghp4.prod.google.com ([2002:a63:fe04:0:b0:c79:738f:74ef])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d004:b0:364:edd2:812
 with SMTP id 98e67ed59e1d1-365ac7a440fmr11832911a91.25.1778225655765; Fri, 08
 May 2026 00:34:15 -0700 (PDT)
Date: Fri,  8 May 2026 07:33:22 +0000
In-Reply-To: <20260508073355.3916746-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260508073355.3916746-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508073355.3916746-2-kuniyu@google.com>
Subject: [PATCH v1 bpf-next 1/8] selftest: bpf: Use BPF_SOCK_OPS_ALL_CB_FLAGS
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
X-Rspamd-Queue-Id: 6B5FA4F30C7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285686-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
2.54.0.563.g4f69b47b94-goog


