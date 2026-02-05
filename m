Return-Path: <netdev+bounces-257344-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNwxOfgZhWmx8QMAu9opvQ
	(envelope-from <netdev+bounces-257344-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:30:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8D4F8138
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C131430101C8
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 22:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F2633ADA3;
	Thu,  5 Feb 2026 22:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aiugn2hd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3A6339868
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 22:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770330575; cv=none; b=Nrnx4qLUgK8D/UhHZv1mtm71E4ig4OcFFHpw8O2ezmFCb9db8rvfQB+/D0YKuXViXP38n9Z+iL2fxRy2NJGaCtfe8yDAgbgaddOJOXEnrYRImSOS02/vSp75kKJl8NakK+lGdlyzzSKOyX3lgGw/rG1wVFNh8gFkjatZFi0vhqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770330575; c=relaxed/simple;
	bh=exa/YP9fyICJ77EYEDHbnzjy54eXhqjQuSP7ACG5gVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j807zxewFaqlP6Uu1sF6WK+shwz5rHgWSuwwmVmRsVHAMhNzjVelpFgFMBMCMSYCT7JWjKP6VgXvlHK3l1bhsfIGy0WY3y535yjSjGxDlOzybxuoaFtHbQft7Zk31iFUvzLm/cZQ2p7M911yXEVvV7ac0O6M2trp2DJ8pTXrfkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aiugn2hd; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a76f90872cso203335ad.3
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 14:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770330575; x=1770935375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRf+SRIGQU8su06GPIQHkqNg5txYSi+urlSE/fCNWGY=;
        b=Aiugn2hdiEdSuCb0r72AORurJk6Ksui814gHEHhczvo86IoA3a8PA+3bOvNmcLKRBG
         LKrHvSG00k/SQLND+CtFaFZWWTIdemlHAAcDeFcn3BqPFXmWx3nfSKyL8fffUUoVln2/
         k4Kv6gFOoXEoqNAnmd41G8TrL5WyNKmblwwC6odRpWW7kgySZWojq4mn3CS32YJSmzzP
         +W9uBMxItydX7M/BKKCeev9g2nquCuHdnTKP+zRcyKkWQEyL07t2KPrRCe2d+H0Qzt5j
         CbDsGOvb/TQqGcPsdo1TQID+d+jyynx0VMuse0DB0pM8LeGacVberbEKKfHb8kCGxEXp
         u+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770330575; x=1770935375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uRf+SRIGQU8su06GPIQHkqNg5txYSi+urlSE/fCNWGY=;
        b=mSLsWH8akJLAYzGDeWx8fLHBcd+Y46EDtHF0Z/atKKBMVoBijzcXOuAu71FIAz4/5j
         q5/XPq417W6rcGhUlYZlyU8DMisDLHhWZaedqJZQUOxr2sfMCsOpQnvlJuddVqhBYFvE
         qT20LTVEfvq1X9B1jeH10Il7wiYq95vZbKIMozmRgo4aCz6rHpxXrWQEi2I6UmAMNeRj
         y+++ZeoHKf60Kygz8U1pNeh6qbYXqS0HX2EE5AVlT6MCngpaVtVqtDoeJ2ttCz2aTu3u
         npwNT73JYQ75VZR4ZiRsc4J9BILcIVhTbpBCkrcWwH0Pk+b5muGCbhNnvBjXO005Gjf1
         fUpg==
X-Gm-Message-State: AOJu0YwXu1bN1hcGKiEWa4HPJNtr8QhDCY9TPw4xcsIURi1l4pcJngYx
	0kT/1T9pJcdPiP+sRf+/Qo/z7yQke06TWXYv9l7aitQ/lRD+pr70ofwl
X-Gm-Gg: AZuq6aLwOgmDWa0NNzztCU2u4YI3C4F6WFeU1wxCwryrUOShtygltvLeX+pIkWECAYZ
	QmbfZUTQz0uVOsmlKiyVslMYgJBTGKEM3HCMY9GwMnW+L/3kHkrUTRD/m/YZ15ecNYa1UBOl27k
	p3IJCgtbn1SrdICJ3CubiX7weuZ7Mn65T/5IB0cKDD/9I/3EayNh0UkKTHq34Lo0p0e9Slcu7z3
	wY4wGmboBO4OXsxvFeSwar3AWpmE7IF491sOSFxXFTy7+LmkKh9MRNlIXbz4Dd6/vMuW7SQzON5
	Thl6ftxx9onlGzItwuHpCiZhUsLFC6Trkt8fk18Uj5s60zb7lP6f/+Lx4nQus2n7lfgbMpKDmwn
	7nOASPNTc7HH8RSnThZfmJ6S0wkpYhOohmYJjXdXwiSyutZIEQ8LoFPP6OxwuHrLCaWWSz3uvNE
	IAMA==
X-Received: by 2002:a17:903:191:b0:2a9:9c2:e8e7 with SMTP id d9443c01a7336-2a9519a8081mr6457685ad.60.1770330575247;
        Thu, 05 Feb 2026 14:29:35 -0800 (PST)
Received: from localhost ([2a03:2880:ff:1f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c8b041sm3846305ad.34.2026.02.05.14.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 14:29:34 -0800 (PST)
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
Subject: [PATCH bpf-next v7 16/17] selftests/bpf: Choose another percpu variable in bpf for btf_dump test
Date: Thu,  5 Feb 2026 14:29:14 -0800
Message-ID: <20260205222916.1788211-17-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205222916.1788211-1-ameryhung@gmail.com>
References: <20260205222916.1788211-1-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257344-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA8D4F8138
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


