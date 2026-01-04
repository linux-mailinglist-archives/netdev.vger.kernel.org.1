Return-Path: <netdev+bounces-246749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 761C7CF0EE4
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 13:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3FA7303A0BF
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 12:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCAE2F5A22;
	Sun,  4 Jan 2026 12:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UR56goIp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945742F12BF
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 12:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767529805; cv=none; b=hQaJh8IKpSMsNaiUrO2edjhHCVApRxLSSX95ncoUGhsBg7ybmeZhqjHTOhuFg16TQCjnfPSQzaymQKiHEcQbQr2BiTeUx7o50LJHRSJphsKRTzjvohIMlKsG8vC5rZI9EQdcJeE0k4qj2wEbHaJR4VzuFocEUOdsJ7LPMwfatbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767529805; c=relaxed/simple;
	bh=5FPTTn8VrDMMCi8rzKPPkNm4Tds81/hDdgqt5SuYt/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dO+Ro6eHVspxiSil7EhAuDzV4t23VUIYJXT3HoYiBjP2hMT2UAEhgRa4IwAU4JfzxdA1x8deSAN16V1O0OAO1Y9QqsX8wTl75mUnsj/g85+qyqq8QNYi7yi6HwxB1gHV4TuoZDkNQhmbxd8oVFTtKSTFVUpM84XfRoRVFErlnf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UR56goIp; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-79028cb7f92so42436377b3.2
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 04:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767529802; x=1768134602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKy0X0XlxlcjI1cU8qAHOVK/4C53Fmoj+OMhrX6dTQs=;
        b=UR56goIpoA0XLk1UFsPiGrsvYV1N5KeYERJ6Unhjzp+cHm0NmK2HgBDzCz4TVCtrNE
         ALdVggr6LHR5Cqdn9LRcLXV2zA3+fKLxxUFFBPCmDqP6zas+onUo/EKJ/aRE8kLppTn7
         Y8dmhQxuazBKL5ZD8X94V/+5VWpcMEasTjnIQNgS0jvsdx90sWsRjsbvXaTTc92qmbN2
         gd5lVm74Hh5h+Tq9YEqLBBIImFgzwjYsUYfZvs24jA+kzWHGjjP+DSANPMHIshAyfEu8
         rZiceBa6nPxENOHPxOYiuVXk86XRit4nDz2vcsD178tUBb97z7f6isD7K/sJ7pk2XFZS
         lzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767529802; x=1768134602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MKy0X0XlxlcjI1cU8qAHOVK/4C53Fmoj+OMhrX6dTQs=;
        b=o/dKhUyB9oRvwaVCPIheswkaflzL45IlJR+DPRe+RyLofiFdMJXJ/XVpweAEszjfpH
         xv1tuX4WRviiRIOsPU2xMzfnPnfrhoZnH8mkKHjI1BJq3Nt7inpeas+rAmn5t+TOri/X
         6jNaHDJ0MDaiGPO7sU0aLGOvEMDbND32NQ9ie3bw+PQPmVTv5EqZ0p4iEzqO5ol8gYJR
         q1hvVayEBvCaKpkpKP0RT7f51juqwR9ekWEUQJZgnVOU9TYens02RWaHmdSBYQl10+6h
         4jWMJFp/18wvVyoSVqIf9yBFiNzBR1EATg/di98ZICMOIs5LpZ+Qb2qr4CWq1cRnXJII
         EXQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqXvCoWaZHgLd3XK4XEdS2qzOw/IpAqsrCc5PiBGt4IsY5PXPPmVUiMiaM7sKqe/kT7EATIUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBLn0iL5FGd7NW76QmXWD1CPt7QcfJu12TZYaUKpwgGkDBNKaD
	rY2v0pkGJsthmAa9uJ17uwldXQHVru6gkbkLrGFXhpcixO5H9rRJrW9n
X-Gm-Gg: AY/fxX7h/r+ulaw19YwjSOReNzsIvlGhWanql/hQz9ogjfd3lEIYWzLYgaUi5h8Zuee
	A6eqfmusa0u+SYglMFwOg6KYc0onuOrdkhkogqRzDVMBXSZewMxuw3WYzCjICHOgJMcuznP5KMz
	2c76wDT0LSnTfi79cmBe+NYF9xk3g/cdLm6JR40poe/6gnGYljyHT9yHjvtA0tgwjtvnJOKNGw0
	mFFatVDBXZLT4cZl7KWJyAJOPtuRe7f8YmBi6DoRuXemEHFz7p59/l2etC8TVX3ZccpodhpiisW
	Fb+WNXYwxC/O5P+0fQOl9CKAweIc0dm+haaG/H6HqCDkZdgoTbh77YXjp3tv43cUsI1LAAqm9Ir
	g1BUm4qIWMTxvS4AyRP0W3lsGXeWBmEIDHTeAd2tLmfW4d3Hdo5pLG+YUkeRzyZmGnI7LDWVrdh
	uSMMggjSc=
X-Google-Smtp-Source: AGHT+IF9aWW/XLWaxSzp1Z0Y+8CoeSNf0aI2UoJSmKodmODLwXZzd5seFMY7pe0MwU57/c3Mxk/1Jg==
X-Received: by 2002:a05:690c:3513:b0:78c:7ee5:4434 with SMTP id 00721157ae682-78fb3ed3008mr368580467b3.10.1767529802261;
        Sun, 04 Jan 2026 04:30:02 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb4378372sm175449427b3.12.2026.01.04.04.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 04:30:02 -0800 (PST)
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
Subject: [PATCH bpf-next v6 07/10] libbpf: add fsession support
Date: Sun,  4 Jan 2026 20:28:11 +0800
Message-ID: <20260104122814.183732-8-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260104122814.183732-1-dongml2@chinatelecom.cn>
References: <20260104122814.183732-1-dongml2@chinatelecom.cn>
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
index 1a52d818a76c..89d6f45ef058 100644
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


