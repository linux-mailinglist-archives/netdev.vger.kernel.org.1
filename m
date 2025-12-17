Return-Path: <netdev+bounces-245108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0076CC6EE9
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 11:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3E9A307DA63
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 09:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E37E337B8B;
	Wed, 17 Dec 2025 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ja87KcUW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BB3341069
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 09:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765965341; cv=none; b=BF3P7dX33iKjhfyS6zvIj2mrXBBHecPfECF7GJ+l9c0ADYR9NJkJ+3NmkN/mhXToZgh2Xh3taZ+1i3b8JAf2rW6n7uB6uHfXsH6ojg83i1kpuoAFZrkvh3mGaThndlLqVPgT0G9TzSQBS7T9m8+j7hBp8qy1lkpUhOYurqwGY5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765965341; c=relaxed/simple;
	bh=UkSmveJpeLu2H0txFtf6NwK9YZmeNSpp7nztFJDWGgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOG/JY8fXP450aQLssVdXJTuydWnjK1B5ga2EPuAxARGZBPVIwCFMUc1JUrnLGYeBpCfkwobfdmDhng5gIYuKbPSGe9G+eVeem9sRtt08FMrW+yqYa8se8AXJBASfkmhwtXq/wJgQ4Fmi6rV+2nGKynPykPw+GGP475SDmUgeho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ja87KcUW; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a137692691so21594845ad.0
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 01:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765965340; x=1766570140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3hISc+qVpfPhZR5W/mBA2uyXZnUeLvA3pjNsPMwako=;
        b=ja87KcUWave+KNJYXe4b3tVV9IHOIVQrvCZ5ZNq1YbQsIBvhG3Vw5W6FqSY3RVRM2H
         dPSlFo2yU4hwjmYNZAvdAuNCRSXjvnu/B/GghU+i8y/COdFND1SG4yG9KqoXUghZRMtG
         J5p+9gvneS4hbS4roRqZFr33gUgUUmz0oz16KW1qQx0YZtmwDr4MyRLVKZgH11kZ//6X
         vxVJ5pwvo/ct+QvbN+cotk98tcgtHkYh0aq8UDJuA9zH9oo3l2x/wMLopymD44alU1yK
         nlcDKG+zH33kgqheI9P1HEIM/QF26+SGiGOiKwaZR9CG18ACaXIcAhgZZieX4szZ1iJU
         y2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765965340; x=1766570140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F3hISc+qVpfPhZR5W/mBA2uyXZnUeLvA3pjNsPMwako=;
        b=agS5OtdmhHRNXy+9lb2xBlib6xn0s4S8a7S+M4stEGwtCbs3MbbJ8JZPAVyLmik3ew
         TfptycRKNTJy5A6Ape14dBu0Bn/afI1h0bm5zZGsoj6OdbUKbyXB0neRoprv+hOg2rLo
         fDcCbPleaO7DbZxD/i0+4hfHevC9gPE69yOhXkpOEa5wffp9gwCGN8qiB6SkVnbWXpcg
         CSc1acIcGdmmCnVcVqVvXw4EkX3bhsoWbl+DFa3Zc9sDH8RY1QjIDU5h5URCcnxbUg7b
         kV1+ZVCaFq3rP9zmGQH3WjHQBpiyO57Lp5S8Khd0kkmixrxl335zLhdUl9hrknRkYtcl
         uvpA==
X-Forwarded-Encrypted: i=1; AJvYcCUkQ8h/+yyw0Q8kHPwzmvmikmK18SecVEpTDjZ0Ei7sySqkWgFjblg+hlsY7e28SpSp2rBnmAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTz99HDrGVq7mFr+FwBElUJV4LaWNguYQjQpMyYOp+FmMO2EnX
	LUA+HxBm6ckxK/2zYDNr3+NS4pZlM/xNeVZAAK4bgEHBH3RpA1W8Qwhf
X-Gm-Gg: AY/fxX5T2hG/WF+5HqZh6WI5qBkbOq643O427pgPRuLXE4xwewzOWtuZmHMJ496hGYX
	/DSle1TZNAHSAGqwXMCenJKUhE3knXHYPID6q0Nbucnb7POXF7v0Dgq9UIThx+6c3I1XsAYBixv
	lk3BdduZtb5dDtKotSoEFfz6wHzSLjlNTJeHFuHn6lhMVL7ku9fFI4dCBKdcG2PW2LX1y5ltKKJ
	que+G1Vc+y30HnOaae94raOtApSIh9I36hIN3iZevI1HyCuKpsKKA8F8t0ujDU/2/8vGXYCpq5o
	ToOmvbLMx6V2vXeCAxGfhJk7LhEbbK5IezTwWM29kuFs9q+PjO/lUGnaSNLfGSi10rp+QdpC4ax
	/NYeyONPYNhykpZtEoftoK9cRVQt/gmsTLHVBVjg2r1ddJSfahrdoMS+dcSozi2K7BkG/SXYM4A
	J9oR+IINA=
X-Google-Smtp-Source: AGHT+IE5C/7U4p2EYr4v4jB/aE1Y+kulMB/uRRmgnAOhqGAxDTc1dap1o8cF6QJMgVNWg3Mc/h9vQQ==
X-Received: by 2002:a17:902:d54d:b0:295:557e:7476 with SMTP id d9443c01a7336-29f23dfddb0mr161739725ad.7.1765965339729;
        Wed, 17 Dec 2025 01:55:39 -0800 (PST)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a07fa0b1aasm140715945ad.3.2025.12.17.01.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 01:55:39 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
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
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 7/9] libbpf: add support for tracing session
Date: Wed, 17 Dec 2025 17:54:43 +0800
Message-ID: <20251217095445.218428-8-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217095445.218428-1-dongml2@chinatelecom.cn>
References: <20251217095445.218428-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add BPF_TRACE_SESSION to libbpf and bpftool.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 tools/bpf/bpftool/common.c | 1 +
 tools/lib/bpf/bpf.c        | 2 ++
 tools/lib/bpf/libbpf.c     | 3 +++
 3 files changed, 6 insertions(+)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index e8daf963ecef..534be6cfa2be 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -1191,6 +1191,7 @@ const char *bpf_attach_type_input_str(enum bpf_attach_type t)
 	case BPF_TRACE_FENTRY:			return "fentry";
 	case BPF_TRACE_FEXIT:			return "fexit";
 	case BPF_MODIFY_RETURN:			return "mod_ret";
+	case BPF_TRACE_SESSION:			return "fsession";
 	case BPF_SK_REUSEPORT_SELECT:		return "sk_skb_reuseport_select";
 	case BPF_SK_REUSEPORT_SELECT_OR_MIGRATE:	return "sk_skb_reuseport_select_or_migrate";
 	default:	return libbpf_bpf_attach_type_str(t);
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 21b57a629916..5042df4a5df7 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -794,6 +794,7 @@ int bpf_link_create(int prog_fd, int target_fd,
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
 	case BPF_MODIFY_RETURN:
+	case BPF_TRACE_SESSION:
 	case BPF_LSM_MAC:
 		attr.link_create.tracing.cookie = OPTS_GET(opts, tracing.cookie, 0);
 		if (!OPTS_ZEROED(opts, tracing))
@@ -917,6 +918,7 @@ int bpf_link_create(int prog_fd, int target_fd,
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
 	case BPF_MODIFY_RETURN:
+	case BPF_TRACE_SESSION:
 		return bpf_raw_tracepoint_open(NULL, prog_fd);
 	default:
 		return libbpf_err(err);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index c7c79014d46c..0c095195df31 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -115,6 +115,7 @@ static const char * const attach_type_name[] = {
 	[BPF_TRACE_FENTRY]		= "trace_fentry",
 	[BPF_TRACE_FEXIT]		= "trace_fexit",
 	[BPF_MODIFY_RETURN]		= "modify_return",
+	[BPF_TRACE_SESSION]		= "trace_session",
 	[BPF_LSM_MAC]			= "lsm_mac",
 	[BPF_LSM_CGROUP]		= "lsm_cgroup",
 	[BPF_SK_LOOKUP]			= "sk_lookup",
@@ -9853,6 +9854,8 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("fentry.s+",		TRACING, BPF_TRACE_FENTRY, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("fmod_ret.s+",		TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("fexit.s+",		TRACING, BPF_TRACE_FEXIT, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
+	SEC_DEF("fsession+",		TRACING, BPF_TRACE_SESSION, SEC_ATTACH_BTF, attach_trace),
+	SEC_DEF("fsession.s+",		TRACING, BPF_TRACE_SESSION, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
 	SEC_DEF("freplace+",		EXT, 0, SEC_ATTACH_BTF, attach_trace),
 	SEC_DEF("lsm+",			LSM, BPF_LSM_MAC, SEC_ATTACH_BTF, attach_lsm),
 	SEC_DEF("lsm.s+",		LSM, BPF_LSM_MAC, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_lsm),
-- 
2.52.0


