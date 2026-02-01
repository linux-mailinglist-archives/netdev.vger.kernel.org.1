Return-Path: <netdev+bounces-255662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BxuKKCTf2lotwIAu9opvQ
	(envelope-from <netdev+bounces-255662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 18:55:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D399C6D66
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 18:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 054A6304B5BF
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 17:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6E227EC80;
	Sun,  1 Feb 2026 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGPew7Nr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD799280324
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 17:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769968277; cv=none; b=iQCL4JUqlgqCfawuAAXouDPYTCQ25zYOTyOtTqftMpZ2IxpJ86+R8hhNXp03RuL0RYwVvySiNKxF+nZ2cYt0gtQ7viuT5itHroWOH0G+DyzRg03kBETzPS47j8PC+vDFnOpdUHcJAa3bxGpnqCxfrJTwZ2AG8T/OWoSFHrsUJuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769968277; c=relaxed/simple;
	bh=exa/YP9fyICJ77EYEDHbnzjy54eXhqjQuSP7ACG5gVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNF3ffCjS8GS7vX3a9MfH94oqTCS33MhNYDGyY6SHbyuML69BUfXJ4KtWmOP3IlU56tv5np8s/8lxiOLTV6IBwDPGt2kjPpHtnWOqLICEZGyxxnB1nSiNPWoIz2Uz7H+I9xjA25vf3obI5CCO3bs48gBRDRNIIqGmxJLUyXEftQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGPew7Nr; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-81f47610542so1989351b3a.0
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 09:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769968271; x=1770573071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRf+SRIGQU8su06GPIQHkqNg5txYSi+urlSE/fCNWGY=;
        b=bGPew7NrLebHj9dB9DEE/zsshkLACYQGdPowqtgsISA/yLaheVQQBRlWLZ6hyBDQPf
         tw3KN29xR5M+VlBbO4tmGSuS9MRBIHHhb8h17YlFxPaQXfNNY8c1+9C6ArIh9i9+2ELJ
         NMsFcLqMpnHoWKgJlIJr236lJMv6t9sfLiOhgvko5QD7HycB4w+NnYfZmuCg8lVOPQr/
         6GvAASG6ti7tkWN8O1bwQsY5p0/cnkdXRvyvPG4+JrQc+Cs4url6ZkusZyXmVuJMcogX
         YjynDHHS4Q/KuGuDbtIgVa6ZVHbog6amISPqz51b9c7++LthejbHPimZJzz3PwNvXcB8
         yt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769968271; x=1770573071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uRf+SRIGQU8su06GPIQHkqNg5txYSi+urlSE/fCNWGY=;
        b=hU1L+zqezmOvfOFLhNNMbrojivYuAvQ8pmNbOSbHvFFr+iaL6C9x/4LQghdANUwTei
         hkPYSVsUSYYYjQ38WudYnJvoCQVE1x+oUIJxWDINTbOlEo3VPo8uXn9u8RSLqE5pxQGC
         +q8q8CT0PmrMFhcT4LCEHs06GEeDX+V+154MNylREHpH9lfw4N9oU3dInqv2M+KoTrct
         Pdk7Ye7Zv5/oTOCIIkSDswDFo5ZfvKwoHeoI9BFsLimRnV9Q0DFx/v4k2gPAc3SJapxW
         xCEm8rQIMEhBF8b4QFiqmbZLlHzy3fLsWqBAV5fLbXEm2e5taIAIOyaE5bz2qCIoLEC3
         Zceg==
X-Gm-Message-State: AOJu0Yxo6iGrPgRWUx+7z3pC2w01+Sa9gll+GgIjkEgZIzTzf/FM1bCS
	Kn2aCsu8xsbiPhW48tO6P9j2BlJZkpHT989huZVUnhMTvMCrIydTcXJn
X-Gm-Gg: AZuq6aJwsvSghijp0ImzL+9UyLLn8+PQID7YGAQlrBG99VhlQG0V7LGCdS6hI8sc5rQ
	BnkmAXUHfYiLuHuuEHYeaaE8uYLuf6zRt30ciAJtGQLHGf1bAh5kkzXwl/5XwU0/I6YjgQ9Muhl
	oaAGNzGy2pPOz9w/5M6NGO8mr3rbYknfvXY5i7WuCjYS55PY6sg33TajQjqbPsBJhKtYjjk6jzz
	yZqz4UDWNFmz9M5AtjPt0FBG8ffwTcyNqTzhXNJZn4XH8WUu/wamPeB/Towum5lTSoMJydaAKo9
	rCP7KO+T7qZFFTfnWiNyi+ldznlzN60M9of1NO420dE63JpqSEDyqTUKZmQrlMCyACLYoloa08j
	b9iH0FUVdlAfJm2NcZsSZqWaftIgE89ooEboqYyTxvh7e5mQg0XQeNdSdFfSD1qjLBhGJlB4VZo
	dchA==
X-Received: by 2002:a05:6a00:2316:b0:81f:394a:489e with SMTP id d2e1a72fcca58-823ab65ef08mr8539752b3a.10.1769968271114;
        Sun, 01 Feb 2026 09:51:11 -0800 (PST)
Received: from localhost ([2a03:2880:ff:5e::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b1bc1asm13967537b3a.9.2026.02.01.09.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 09:51:10 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 16/16] selftests/bpf: Choose another percpu variable in bpf for btf_dump test
Date: Sun,  1 Feb 2026 09:50:49 -0800
Message-ID: <20260201175050.468601-17-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260201175050.468601-1-ameryhung@gmail.com>
References: <20260201175050.468601-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255662-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D399C6D66
X-Rspamd-Action: no action

bpf_cgrp_storage_busy has been removed. Use bpf_bprintf_nest_level
instead. This percpu variable is also in the bpf subsystem so that
if it is removed in the future, BPF-CI will catch this type of CI-
breaking change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/btf_dump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index 10cba526d3e6..f1642794f70e 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -875,8 +875,8 @@ static void test_btf_dump_var_data(struct btf *btf, struct btf_dump *d,
 	TEST_BTF_DUMP_VAR(btf, d, NULL, str, "cpu_number", int, BTF_F_COMPACT,
 			  "int cpu_number = (int)100", 100);
 #endif
-	TEST_BTF_DUMP_VAR(btf, d, NULL, str, "bpf_cgrp_storage_busy", int, BTF_F_COMPACT,
-			  "static int bpf_cgrp_storage_busy = (int)2", 2);
+	TEST_BTF_DUMP_VAR(btf, d, NULL, str, "bpf_bprintf_nest_level", int, BTF_F_COMPACT,
+			  "static int bpf_bprintf_nest_level = (int)2", 2);
 }
 
 struct btf_dump_string_ctx {
-- 
2.47.3


