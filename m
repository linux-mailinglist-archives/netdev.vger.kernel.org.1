Return-Path: <netdev+bounces-253042-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKAHD/pkdGnb5AAAu9opvQ
	(envelope-from <netdev+bounces-253042-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 07:21:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D52377CA8E
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 07:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D9B73008243
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 06:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A4F280CC9;
	Sat, 24 Jan 2026 06:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EA1xnhRf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7CA27B359
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 06:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769235694; cv=none; b=UjUuOsKpQl+sU4++fwp4Ex2m7EoO4frwFlPuSK6Wa88klUooXhH3fIKjhn0H10m1yrj1SzPB4GPcGXpEULOJuBafKeVsSiOEotfQ+bCjm7lr7haTbHafyG8sPEA7M8zorb0/QfP3Vzsey5UoMgCvWyTFAY1cH4Q0B+lXMa/4J7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769235694; c=relaxed/simple;
	bh=7cC1ms5ub9SS0bly7QzzdjNJghADRqDQHVSuwXZiOkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oMIF9OSzbi4nRp4rDOc9mhG09r4zxdJOXZ3QxqaVkk+PuVUNjJ0Cvau+ne3R9Svm5mQAySUlLmhuOtzqnKmMJhQzq+AE4mMZBaakXydbZlCS6amA416lvmeAAL09vK06FYuWJlotEPYvpft89cnGyuvd8EebzXzKi6AUSE+Xt6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EA1xnhRf; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-34c21417781so1547440a91.3
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 22:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769235693; x=1769840493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TG3OIJ4OsXGkuiYroAWEp+caX5ZqVGcvi7JJxvZjj6c=;
        b=EA1xnhRfiT0cBVfpQaCqUjWbXq8bjonP/vaoRYMH+D4LDodfJFvTHE9+Mu8aqEMa47
         QxbZft+FAov7cW1OT5cV5IBWmAFEAJiGm+v8MRw2l1ElpQLlwKne4j8aWarCQr5KG47p
         8hRbF0R1xlu98z+v4Jw4BSd2/FuwA9vpwMGS2Y6OjFM1fHKuJEs7YJyw9olgfKcnrj2g
         oqBSaheZMW+D0n5/NR07XlyZjRDHaj2NqTXQh1aywNqCmj9mHGBqR0OJuVkKgzHCz4jP
         kCLJzEPWItGKfass2BmBn7ijHiJ0VzQpEEk5ULADOexeZuwOHcln25OTc8EzzbCNru29
         iAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769235693; x=1769840493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TG3OIJ4OsXGkuiYroAWEp+caX5ZqVGcvi7JJxvZjj6c=;
        b=FBsl3+dNM5UuPrWTV2b2ppRLTKJIe2nEqs6zTfePJq3uTxGitSSlkwibURR8rRBCZv
         vxdz2k+HlDeiFJnWmzdJ0IpaSYn94+vtSP8W4cBrHN2kGd+nggP5i8ZQ8rNmlx3GK611
         KTNMiAxl4SkTCsMZlnvwpflfli+4RWF0q+z+dlHe5ARrRjmJkgg/XPX5KZqpeGON/R1n
         iqzQAPLabO1grAGjNb3VGigK+MLqC/EuU3gzmJaoYBsd2QuG3xxQm+7zGg6OJwjmsOEL
         kfnx9dnK1U8/fclDwQizm3G0KR3vrp2t1WilCFd7Likt3w8MgVUTUiuuQwZ0VYpHsZHP
         YJbg==
X-Forwarded-Encrypted: i=1; AJvYcCVeCl3eEhfmyorO+DDjgX072q9dLywe8wwRtv0HMWrHXaH98FZO3IN4GN8GOIoHU/D7guRZsGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbVWWb0CKg7UgP9rHnNMFF7WIV5TGXV9Ohl9x4jLBT2EfX0NZ0
	tAgcgj2Q83HZXIWtL1TUbCIsGHEuOQPmQMtCmTShuEZaxgkpzPx6b7hD
X-Gm-Gg: AZuq6aKvmOrVP9u1YBTnn1V0bbsCxFfNXUf/HNab3xBuOL7hq0pJtQN2/PAvZsJkibj
	5W4rK0HphFIiT97Xmd+iDAW2e8tlYvy+2/JXPgF0GIS0Us7VlAKvWQHbnQEaH1C8ovEObQgrXLk
	zV9v0+5knhEDGLqbX0PKs4P9vfpS7rbBU3pxVHsbax8evM5rssOk71Ax5H6akp8NiO6TevlhgG6
	1CFFWggcxnPXYwS0C5HW0bO0tWXZmlY6q1R81dr3q06E8DG6blQkjxr2TKWSLayAr3y2VTBsI6u
	rXnIHQ7LQDkzi93H6HVui2MkRDi5aXkNXsGkMAUmI0+hB2ncYQwWVEpY+fDfLFe52Fmp3lo9iHB
	zOHqW6gjj2xrE4rZDd4bo5jgJj4GN+lRaAcmBPpjR9YvyWqlRT1mXNPo/5CqNidhzu+cjiGThMV
	n38/0Ks+l5
X-Received: by 2002:a17:90b:1c06:b0:353:3999:5c04 with SMTP id 98e67ed59e1d1-3536884bb77mr5366911a91.17.1769235692687;
        Fri, 23 Jan 2026 22:21:32 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353354a6b5asm6496537a91.9.2026.01.23.22.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 22:21:32 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
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
Subject: [PATCH bpf-next v13 08/13] libbpf: add fsession support
Date: Sat, 24 Jan 2026 14:20:03 +0800
Message-ID: <20260124062008.8657-9-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124062008.8657-1-dongml2@chinatelecom.cn>
References: <20260124062008.8657-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUSPICIOUS_URL_IN_SUSPICIOUS_MESSAGE(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	URIBL_RED(0.50)[chinatelecom.cn:mid,chinatelecom.cn:email];
	MAILLIST(-0.15)[generic];
	HAS_ANON_DOMAIN(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253042-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20230601];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_HAM(-0.00)[-0.816];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,chinatelecom.cn:mid,chinatelecom.cn:email]
X-Rspamd-Queue-Id: D52377CA8E
X-Rspamd-Action: no action

Add BPF_TRACE_FSESSION to libbpf.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v10:
- split the modification to bpftool to a separate patch

v5:
- remove the handling of BPF_TRACE_SESSION in legacy fallback path for
  BPF_RAW_TRACEPOINT_OPEN
- use fsession terminology consistently
---
 tools/lib/bpf/bpf.c    | 1 +
 tools/lib/bpf/libbpf.c | 3 +++
 2 files changed, 4 insertions(+)

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
index bbcfd72b07d5..0c8bf0b5cce4 100644
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
@@ -9859,6 +9860,8 @@ static const struct bpf_sec_def section_defs[] = {
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


