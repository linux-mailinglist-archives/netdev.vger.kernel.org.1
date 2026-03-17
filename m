Return-Path: <netdev+bounces-268371-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNLoMiSouGkthAEAu9opvQ
	(envelope-from <netdev+bounces-268371-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 02:02:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4B42A26B1
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 02:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 970E73008C23
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D620622A817;
	Tue, 17 Mar 2026 01:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPy8v28/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8927F1CAA78
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 01:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773709345; cv=none; b=nePpKT4DJX5V92Xp5wI7YvBjzDh2TI1Qe/sNJ3mTaIq9JYmoNVFN8DQMJedJ5CxbTQx4oT3CyukYYiTivJHJu9IZX6ok2lc/C3xo5klymOJroIcTOmp+iDY08rrBUfh1ERG1CZFDcsn1zLNjWOK/bAwOr39GeaetVmt0Y7VhFws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773709345; c=relaxed/simple;
	bh=w43A32ElWzUFHVnnYSmGYUdM4Z3ZT7EHYE2wZgx0qf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WEFtT0fkM7DR+YnOLRPz7GquKkOhbsnuLZzYVlp/DI7KkpWhqfwNxtf5UhrJIKrw+ROqMNUfSm1R2cYDpqBWH9WvXv0qaX10t5PZVg4ngO/A9iQEYTk4GD3iXVm6vCgRxsGXtfp+tUP7F+/bNS+Zq3xjRz4YksVNfPB8AFDcAv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPy8v28/; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79a5fb98316so8679207b3.3
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 18:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773709343; x=1774314143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KbolAMX4QbaXf52snOUv/EVQt0h5F1GAcLobkdxUR8=;
        b=NPy8v28/Mx4iyzHi1X7oeZh7A1HfHM20aINasF0hgEdtKE0jXuMEPmtvbTpQuCeVvm
         GqZ+kLmolmAXWRAyT8k5O/5yO7vrqESMQbqUgRKPHQRD7wL6dV3B3l2MCT+Rpfgga8Fq
         e8R+ibIUKrE1nb0at0aSo+4TR4JYmEDUiUH96ypRY/rXNq/r6/bqO1mS87TASy4Cs0vz
         Ipdm8rTsZDCeEN4aSid89a0vrs3d18SJRZ+DybFOEYFkIPA36H157nDbDom3seTheaMM
         /W10tRp4CPtRG2+1YqY2k26GWWx9O9ad0P81yInnSKqxRtEW5/sqo2z7LZOArOs+ysVP
         DzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773709343; x=1774314143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7KbolAMX4QbaXf52snOUv/EVQt0h5F1GAcLobkdxUR8=;
        b=DBHGRbfJVZurc7voLjqrtG0CUyj0B7LT16ugfYXyIaSbMDCjqVk423XVYkPw8kFdeZ
         ToQgZGYtYseQ2NtEMxFz2KWhNZC5bB4pk7E396VMirQx9SB264EYxfHGIO13L3mDCZU6
         vr8XgPKnpNNWqjQEsg+beQsrYvw8Z9P2zdP2JIhSNCVQ29umhK3xhQwEZNvcVsnUSTW5
         bBh9CUPEDavc6lRWwc1jwq+xRh7nqns+v8LAItkh6FdlhepP8/CGSNo5Q3c6lwDfiovY
         tTIkfwiyEOfGLRf9nzbsr51TOJNZG5/Yxu0b/zGfBFWos89csp6sAJ9x7w5uixnUIs/x
         oZOg==
X-Forwarded-Encrypted: i=1; AJvYcCUZLw2jP2pkpOqkSv9qKaQRjAzCKiUHb1wcuTU/NhqD5pXpI+Bf4rNtYchW6RHllCLgxlAGW0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeOjm6cGzPeqqUolnjcYF2c1tTtbZuYtp2MfglrFcPlp6L4qwI
	SORvBKQCB1HBVNzkiCig+URwbhhjRu6DyiL7cGZRi3p8H2yYLbABEMCp
X-Gm-Gg: ATEYQzzmXf0N/zJidrWvhL/QwxMLji6yqxjyYqFy4SWcLeUbjhTgaaYkUoKlbce1S7N
	ncPwPNr+2ThGliGYCNAugPXmW5eYMh4OKCOyB+vqIvvVQrOejD7HMdXJehLgHTc2m1+H9fcXg6R
	U+15yuAB63PH454JH+Mx8n1sMRFn4uutD5Me7LF5LfKgsi2GISyk/gS/rd9WqjfND6JAurxVWHQ
	BJOrwYQd6AJinN6M89mzKvvXHe8fmjgU20GE2E9Ol14FyoYO2MtBUEvPV1XPfChIdv0geHlA0oj
	nysyYvEpFg/b9LWhmg1yjwPJq32ZjgWkjtPAXwwLTKFJmSxAhw94ZovfNfzbRyoIhaR2ES1rCYn
	GloPg0kzmoNpIJnNhHII5qFH5j+2mlH7D6SPXyfW6HLTUb2cso/aW5hJSyUvVbmEThfE7uoQhIa
	Coe5ELYwKB0OGStR2XGd1U4CpO0TNrBAGAIMAPXPyWYKg7olkWtv+EvUClNolTNpvRkvU7LovXx
	oZDEGcFEv65ssRu1GOy48c=
X-Received: by 2002:a05:690c:260c:b0:799:266:83e3 with SMTP id 00721157ae682-79a1c1d2627mr148456747b3.50.1773709343410;
        Mon, 16 Mar 2026 18:02:23 -0700 (PDT)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917f1df91sm99596507b3.44.2026.03.16.18.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 18:02:23 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	paul.chaignon@gmail.com,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH v2] selftests/bpf: trampoline_count: use dedicated target function
Date: Tue, 17 Mar 2026 09:02:09 +0800
Message-ID: <20260317010209.8779-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260315054227.118344-1-sun.jian.kdev@gmail.com>
References: <20260315054227.118344-1-sun.jian.kdev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-268371-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5A4B42A26B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

trampoline_count fills all trampoline attachment slots for a single
target function and verifies that one extra attach fails with -E2BIG.

It currently targets bpf_modify_return_test, which is also used by
modify_return and get_func_ip_test. When those tests run in parallel,
they can contend for the same per-function trampoline quota and
cause unexpected attach failures. This issue is currently masked by
harness serialization.

Add a dedicated bpf_trampoline_count_test target and switch
trampoline_count to use it. This keeps the test semantics unchanged
while isolating it from other modify_return-based selftests, so it no
longer needs to run in serial mode. Remove the TODO comment as
well.

Tested:
  ./test_progs -t trampoline_count -vv
  ./test_progs -t modify_return -vv
  ./test_progs -t get_func_ip_test -vv
  ./test_progs -j$(nproc) -t trampoline_count -vv
  ./test_progs -j$(nproc) -t
    trampoline_count,modify_return,get_func_ip_test -vv

Tested-by: Paul Chaignon <paul.chaignon@gmail.com>
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---

v2:
- add Paul's Tested-by

 net/bpf/test_run.c                                        | 7 +++++++
 tools/testing/selftests/bpf/prog_tests/trampoline_count.c | 3 +--
 tools/testing/selftests/bpf/progs/test_trampoline_count.c | 6 +++---
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 178c4738e63b..b41147a29f16 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -580,6 +580,12 @@ __bpf_kfunc int bpf_modify_return_test2(int a, int *b, short c, int d,
 	return a + *b + c + d + (long)e + f + g;
 }
 
+__bpf_kfunc int bpf_trampoline_count_test(int a, int *b)
+{
+	*b += 1;
+	return a + *b;
+}
+
 __bpf_kfunc int bpf_modify_return_test_tp(int nonce)
 {
 	trace_bpf_trigger_tp(nonce);
@@ -635,6 +641,7 @@ BTF_KFUNCS_START(bpf_test_modify_return_ids)
 BTF_ID_FLAGS(func, bpf_modify_return_test)
 BTF_ID_FLAGS(func, bpf_modify_return_test2)
 BTF_ID_FLAGS(func, bpf_modify_return_test_tp)
+BTF_ID_FLAGS(func, bpf_trampoline_count_test)
 BTF_ID_FLAGS(func, bpf_fentry_test1, KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_test_modify_return_ids)
 
diff --git a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
index 6cd7349d4a2b..b19358aed126 100644
--- a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
+++ b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
@@ -30,8 +30,7 @@ static struct bpf_program *load_prog(char *file, char *name, struct inst *inst)
 	return prog;
 }
 
-/* TODO: use different target function to run in concurrent mode */
-void serial_test_trampoline_count(void)
+void test_trampoline_count(void)
 {
 	char *file = "test_trampoline_count.bpf.o";
 	char *const progs[] = { "fentry_test", "fmod_ret_test", "fexit_test" };
diff --git a/tools/testing/selftests/bpf/progs/test_trampoline_count.c b/tools/testing/selftests/bpf/progs/test_trampoline_count.c
index 7765720da7d5..911d282fd423 100644
--- a/tools/testing/selftests/bpf/progs/test_trampoline_count.c
+++ b/tools/testing/selftests/bpf/progs/test_trampoline_count.c
@@ -3,19 +3,19 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
-SEC("fentry/bpf_modify_return_test")
+SEC("fentry/bpf_trampoline_count_test")
 int BPF_PROG(fentry_test, int a, int *b)
 {
 	return 0;
 }
 
-SEC("fmod_ret/bpf_modify_return_test")
+SEC("fmod_ret/bpf_trampoline_count_test")
 int BPF_PROG(fmod_ret_test, int a, int *b, int ret)
 {
 	return 0;
 }
 
-SEC("fexit/bpf_modify_return_test")
+SEC("fexit/bpf_trampoline_count_test")
 int BPF_PROG(fexit_test, int a, int *b, int ret)
 {
 	return 0;

base-commit: 267594792a71018788af69e836c52e34bb8054af
-- 
2.43.0


