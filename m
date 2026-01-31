Return-Path: <netdev+bounces-255360-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGb3Oc6OfWmGSgIAu9opvQ
	(envelope-from <netdev+bounces-255360-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:10:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA15C0AFC
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E31FF30095D2
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 05:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B20D33469C;
	Sat, 31 Jan 2026 05:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRTrQ13y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEB431280F
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 05:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769836184; cv=none; b=eX2b/d96IhMhIrfT5S5o+SaiAhkrp84r80fbBr+ldfkfYj4Qx9wgGlpnI0C1TXJY5etfl5MXD+0TE9aDpj6oy0MCERfTp7VDQ4pGm4/EzVdPtNuNJeizuX3tF6U7flyynDfqoRQ+5S052xXVEcLa3PCPtVQW26QaDKk4boLFD0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769836184; c=relaxed/simple;
	bh=exa/YP9fyICJ77EYEDHbnzjy54eXhqjQuSP7ACG5gVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rijGQx3hfyz8wcVx46G0biWDs9IjqeWouvdy+NYGXeM43DbIv8ZPAntLaCAzU9IqD94QA1a3zney4NSGdor9bPmcjK50Oktjx/vD0Oyub7R10N3/2iogLirKCn6Uoukcathl8XHt4s8WFeyCO4o2b9GViWFmhpcB3QrjEjiTr6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRTrQ13y; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a7786d7895so20060895ad.1
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 21:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769836179; x=1770440979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRf+SRIGQU8su06GPIQHkqNg5txYSi+urlSE/fCNWGY=;
        b=PRTrQ13yvRCvSiQOGZaJBREANeNa/5BW6VJX2WVTAZfWN/Q+RY37RLcS3aYqDc4GnC
         Pt/5lnInWUOkWmn105n+Gr3yhBDJGrCifDskNqU9h3iscODOL/AlpWf6vG2HdZ0cg8oG
         MrYR+zwqg08ojs2PMN5tl2SM2LXnp17Q1RDa5BH0dsgNnBGhZ0ubgFo+qca40b/pl1y4
         0m2hcqIR9QHL5trIhq2bq83+GQWiuCXsqfDDmNw36N0jN//j3wv3IyhRVt4kg61Ezz2K
         jqibL4Ko0zXReousomgzWyIEbBoRD5E+uZwswWRkqaEwGOWTgZvP2mch2xuzMGnU/bhh
         V/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769836179; x=1770440979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uRf+SRIGQU8su06GPIQHkqNg5txYSi+urlSE/fCNWGY=;
        b=a+NChLwnrczv4ItqPoZamfumwB7fofS5Q45KOAfkWpQ8/ZrhUBnprFCaGiu6ukVeJU
         2h12lGCkt0yFP4UQUGRiIkR/6FoseCMuHUdeuPkKhk706ijlBy7Vti+wOQ4wTVFEAhBQ
         u6jPzsZlbeERZUFkRU1kCR3oXY6HsiQ0vL4NAemLSGGkRBk1qLpdUVbh0Hb4ZMtijyzI
         AH3yImwWdi0bUtI8P4lPcpwxFZ0vI8zfWyRYPk6t00nzkjDaERi9YNFGDnq+NwtP6vwl
         mNYCG0mipR5w+GyO3ppYta6RyEXr7d6MYFNnzENSgr6omj+rk6WnsDLwE+KiJhPRzqN2
         Tlxw==
X-Gm-Message-State: AOJu0YyTAbMJpIsFiIa8sfOXwMh1wnGk2Wvf29m+oatLXl68fQ9gUbAp
	qTNwvjOIcW5ziFGaLzLQYwjjaxrV8mDYoSSDJ1iPLkfHzRYlFwlRu0zT
X-Gm-Gg: AZuq6aJAhODlkb5twyVr89pdC7dTcO/zh6XF4JVMGGrFsNzeS8+O97apNTVgnzaqbr1
	cbnz/m2u9WbyMBwOjlSLoxNTDLHn5Zdl9RaQmU9IR2BZlEdUdnn+UTm7IyBMnkbc80hics6lO2i
	TB50qvt1KIvehG763iMFjDmySjybSwlxUmrGw0cCdrT2BluhvEeE2GufR1TeSK+IlNfoICuMkv4
	oWFAOog0JZc7CyHthEyWhha2oerQSSoj1fxXNrCFe65CbCEMT0Q0di+3tWxeChvVKSL5Q8kMFs0
	/cUr7urXKK8i89qu9jJ7Uk8i6oliddjxiePJzfrIjdI3MkGaiF6j2Y5JXS5HReGpylg9Ma1zkJa
	FmARzv0p0HDqMARPrjny9EGo7yOUY9zOFjHb03xVurd2ir33obo/h+TOSMvEPLq5oLXJphKeYfr
	GGWw==
X-Received: by 2002:a17:903:18a:b0:295:9e4e:4090 with SMTP id d9443c01a7336-2a8d993f9bdmr56960285ad.52.1769836179316;
        Fri, 30 Jan 2026 21:09:39 -0800 (PST)
Received: from localhost ([2a03:2880:ff:74::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6e4ac8sm86036635ad.87.2026.01.30.21.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 21:09:38 -0800 (PST)
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
Subject: [PATCH bpf-next v4 16/16] selftests/bpf: Choose another percpu variable in bpf for btf_dump test
Date: Fri, 30 Jan 2026 21:09:19 -0800
Message-ID: <20260131050920.2574084-17-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260131050920.2574084-1-ameryhung@gmail.com>
References: <20260131050920.2574084-1-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255360-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EFA15C0AFC
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


