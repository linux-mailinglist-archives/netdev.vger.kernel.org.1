Return-Path: <netdev+bounces-245978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7D0CDC56A
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 14:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A015A30163F0
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 13:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D956342513;
	Wed, 24 Dec 2025 13:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aO3Zi0s3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B96A33C50B
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 13:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766581767; cv=none; b=V5VBgiPWcg3qYQD529baha3n4UVdmO461nn2Xl+c6tDTbeT8KRGqeaXnVDSCKK+1cqF7HzD9WRgfP+xKeoUk3RGlQRqpIB6mzsdIKMF77yMxsomF+7HzXjEYcqMzRkLxG8/pU6iJHXSTkQ6HQDwSTpku0eI3fKfrVSsOHwgwhn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766581767; c=relaxed/simple;
	bh=PCsJiUv8dhKkVEc9Gphzr4Abd9FE3cPci4dMk5dyyfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NtAPv+1gavFJIwUaQ/YEtlak/rs8GmqDCoh0Hbvh/hNqWsV8OfCsfu6uAlIWDWJLlUrg6kwFmZT/K3n4kyPGNLtzdLWccC/TNnE0sk9uqd/hwsr3vlO33DIjmKYizj8+t/dpCsm86QKYUPLRBcHalp4nNz4K0lXPNgC5LXmfaZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aO3Zi0s3; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7e2762ad850so6187137b3a.3
        for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 05:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766581766; x=1767186566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kE5Q7mze/2WJ5b9UVlr1RR/p46+sCrbeQJO2GbpeOw=;
        b=aO3Zi0s33vMT33NPLFFSTa6glR5hvi2n/qtuTc8vezbRhebx97WG9NlZg837Q95RLc
         L/k/7bGA01x+gaEj5e7umjxav9fg5PH61dzab5vlXVD4okWD1mipbVfKAT3XpLbP4khn
         sF0F66ohWG9wShjG9XyU3EZrg+cpkmnvIbfkCQUcNHJYGB2zTL0K2asele5u8dPI6/fT
         6OR4iHsDJEj18t6ZN2fAv8h/wcPv9OYHL4exDFIc61rbYa0f/VTd6ierIuXIVbEXfzT/
         AkEV8h0XCos+YYmGSOt2ND3MAJcQ6f6O+EBlwXHm5JrAnljy1Y4rIvbpJhHc+JNzW9Ou
         1fsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766581766; x=1767186566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0kE5Q7mze/2WJ5b9UVlr1RR/p46+sCrbeQJO2GbpeOw=;
        b=PD75cjv7URLaLLU96dkHR27KutXmK/yTI4p5QPOkToT7PBLYqB2maUJFEaQELG49D2
         1M6bnBENnkzzBiHUVjq+kMTd/fZDEO1kGu1b7ilsl65TKEdgbHJ9u8s4uU8JkuKAowyn
         zLfxiVipFgysv7+w3t6f3JHROEWksl7wqVkMeSX0P/CmmQIIr8ODjsF+0fXIJ/uJ+Lk7
         6SWCIK0H/XlmthNcrC374/Oak4ENwIu2ttpZP4emuTAxDLwl6mZHP7mzXnFq4iXcXPO2
         OxJfA6y3hsqBHfK/748YqMKJcKn6UgrX1suA5Qv/hqIL90Xc4MZbK+TpEzsMPsKRS3n6
         PXpg==
X-Forwarded-Encrypted: i=1; AJvYcCXldHy5rEOTx7hA7BG/SI62IHSOPVl/sgtB6el4R6J2OdaI9i1xf0IKYqW8Qcx0q4IdZWLkuXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmrWEMiYA2jZUVx76p2gwWnGAGngVkleXAhTZVV/vY1HVIc4+w
	Q3DXK99hBHwd3ggrADg3SCe3N0QV+R81wzJ10XvcJp2UbPZpCZU3TXhh
X-Gm-Gg: AY/fxX5gOHdnHLIhD5eR+pHph7qSEunfXMsGYihXMNpHBJTxeS+zo+dMVQ+iwz3r+dB
	U/1xNlZT6RbXOFtmgA+0THpk76SVWzVhF7Xa9EYut6wNN7jUGDXImip/P3jKufM1Kn1q64Le/B7
	rvjh6ai/RaJJ/dAYaMXpuED+KpxfRlBG95vEl5uW+iX3zQjRWu0P+Wjx6krQqI84SDBKXH0YenO
	4bIK9n/APRDoBH3RzaRx5SvYJ3+STjvxtZIwm58VAbgAu2EPsyXAtpzmHxo6GB/FKunXG6t61MQ
	daJ7dIaGjHmNcdheP3SkggjzRNmXYQyqZFEDw83zFx1VQD+8hNgWi4nhKst3BohMv7VPgp4YqDA
	CBLV95G9lcJC9GHhvjRxdk0eV+stG5WCu5AFzGzI4SbFXQqf8+orkG0R6FXNskAYeu7KbXyBw+D
	zKPp+ewAEIE48JrDRVkQ==
X-Google-Smtp-Source: AGHT+IHgHRzAHO1F91ZV8YBf7P6BwsKNZFWVXB/JIdxB+nDTG20q6gRPHy540gxcdU8XsyiAMYLSbg==
X-Received: by 2002:a05:6a00:288f:b0:7f7:13bb:8f20 with SMTP id d2e1a72fcca58-7ff6667c961mr13847071b3a.50.1766581766005;
        Wed, 24 Dec 2025 05:09:26 -0800 (PST)
Received: from 7950hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac28fsm16841173b3a.32.2025.12.24.05.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 05:09:25 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
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
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v5 07/10] libbpf: add fsession support
Date: Wed, 24 Dec 2025 21:07:32 +0800
Message-ID: <20251224130735.201422-8-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224130735.201422-1-dongml2@chinatelecom.cn>
References: <20251224130735.201422-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add BPF_TRACE_FSESSION to libbpf and bpftool.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v5:
- remove the handling of BPF_TRACE_SESSION in legacy fallback path for
  BPF_RAW_TRACEPOINT_OPEN
- use fsession terminology consistently
---
 tools/bpf/bpftool/common.c | 1 +
 tools/lib/bpf/bpf.c        | 1 +
 tools/lib/bpf/libbpf.c     | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index e8daf963ecef..8bfcff9e2f63 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -1191,6 +1191,7 @@ const char *bpf_attach_type_input_str(enum bpf_attach_type t)
 	case BPF_TRACE_FENTRY:			return "fentry";
 	case BPF_TRACE_FEXIT:			return "fexit";
 	case BPF_MODIFY_RETURN:			return "mod_ret";
+	case BPF_TRACE_FSESSION:		return "fsession";
 	case BPF_SK_REUSEPORT_SELECT:		return "sk_skb_reuseport_select";
 	case BPF_SK_REUSEPORT_SELECT_OR_MIGRATE:	return "sk_skb_reuseport_select_or_migrate";
 	default:	return libbpf_bpf_attach_type_str(t);
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 21b57a629916..5846de364209 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -794,6 +794,7 @@ int bpf_link_create(int prog_fd, int target_fd,
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
 	case BPF_MODIFY_RETURN:
+	case BPF_TRACE_FSESSION:
 	case BPF_LSM_MAC:
 		attr.link_create.tracing.cookie = OPTS_GET(opts, tracing.cookie, 0);
 		if (!OPTS_ZEROED(opts, tracing))
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index c7c79014d46c..10f96e8f8ce1 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -115,6 +115,7 @@ static const char * const attach_type_name[] = {
 	[BPF_TRACE_FENTRY]		= "trace_fentry",
 	[BPF_TRACE_FEXIT]		= "trace_fexit",
 	[BPF_MODIFY_RETURN]		= "modify_return",
+	[BPF_TRACE_FSESSION]		= "trace_fsession",
 	[BPF_LSM_MAC]			= "lsm_mac",
 	[BPF_LSM_CGROUP]		= "lsm_cgroup",
 	[BPF_SK_LOOKUP]			= "sk_lookup",
@@ -9853,6 +9854,8 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("fentry.s+",		TRACING, BPF_TRACE_FENTRY, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("fmod_ret.s+",		TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("fexit.s+",		TRACING, BPF_TRACE_FEXIT, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
+	SEC_DEF("fsession+",		TRACING, BPF_TRACE_FSESSION, SEC_ATTACH_BTF, attach_trace),
+	SEC_DEF("fsession.s+",		TRACING, BPF_TRACE_FSESSION, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("freplace+",		EXT, 0, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("lsm+",			LSM, BPF_LSM_MAC, SEC_ATTACH_BTF, attach_lsm),
 	SEC_DEF("lsm.s+",		LSM, BPF_LSM_MAC, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_lsm),
-- 
2.52.0


