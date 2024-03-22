Return-Path: <netdev+bounces-81326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A50B88873AB
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 20:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C48E281D1F
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 19:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAAA78280;
	Fri, 22 Mar 2024 19:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vDGswjCD"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0486578273
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 19:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711134887; cv=none; b=ui5nKV5WQsNamc3IUZ6Gch4ruSgcc/dZUgiwnRbnIG1cnhbwC1CG3+fDjTaMDw6HicKKkE6Gcvir98Hq6p3vy6xCCq05/CG/QShsit/3d2NeE6gS7opKzbr1cLpZtq3H5Yt/Bq2n4JQgE4TJPv1+XLnG16CND5W4BGJiaaJ9NvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711134887; c=relaxed/simple;
	bh=j4MqyY4opaxACvoZpzlSKagcWJv98HB/GxiKcTJUGoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hho11b6HPRci1L8iD3+/q6v0P5xxQiNE/0Ts4K22rtXkAieY8fBqgcW/Q7YOW7OcWwou+LcCvNXXcjX0Gvd8qmo4VwvwW8qaFqIEpQH4aXfJ++oh0aP5Ugs1MATejc1V06Hc6nkeBI860R49rAWDLG/YQYddXr6fFUzb6xp6ybg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vDGswjCD; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711134882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ccGQb9LzkQbmFYEYDLXr9fXaDfd5U4DtTze4qNAL+Hk=;
	b=vDGswjCD1VX/s4gmxrLvYkJA9A57dnHbj+Z785aTT4te0znYrO8xtKggYK6pzkD6Oh7DEj
	CcjM73kDupsKxWAlm0s6cog79RbHdEkje3+xGx/5a/hGDfIDmzQ/xZSJrIZDGgqaVcf9bz
	AJkInUJftiCJ6rWMPGBdqq5PNYqchIw=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	kernel-team@meta.com,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH bpf-next 1/2] bpf: Remove CONFIG_X86 and CONFIG_DYNAMIC_FTRACE guard from the tcp-cc kfuncs
Date: Fri, 22 Mar 2024 12:14:32 -0700
Message-ID: <20240322191433.4133280-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

The commit 7aae231ac93b ("bpf: tcp: Limit calling some tcp cc functions to CONFIG_DYNAMIC_FTRACE")
added CONFIG_DYNAMIC_FTRACE guard because pahole was only generating
btf for ftrace-able functions. The ftrace filter had already been
removed from pahole, so the CONFIG_DYNAMIC_FTRACE guard can be
removed.

The commit 569c484f9995 ("bpf: Limit static tcp-cc functions in the .BTF_ids list to x86")
has added CONFIG_X86 guard because it failed the powerpc arch which
prepended a "." to the local static function, so "cubictcp_init" becomes
".cubictcp_init". "__bpf_kfunc" has been added to kfunc
since then and it uses the __unused compiler attribute.
There is an existing
"__bpf_kfunc static u32 bpf_kfunc_call_test_static_unused_arg(u32 arg, u32 unused)"
test in bpf_testmod.c to cover the static kfunc case.

cross compile on ppc64 with CONFIG_DYNAMIC_FTRACE disabled:
> readelf -s vmlinux | grep cubictcp_
56938: c00000000144fd00   184 FUNC    LOCAL  DEFAULT    2 cubictcp_cwnd_event 	    [<localentry>: 8]
56939: c00000000144fdb8   200 FUNC    LOCAL  DEFAULT    2 cubictcp_recalc_[...]   [<localentry>: 8]
56940: c00000000144fe80   296 FUNC    LOCAL  DEFAULT    2 cubictcp_init 	    [<localentry>: 8]
56941: c00000000144ffa8   228 FUNC    LOCAL  DEFAULT    2 cubictcp_state 	    [<localentry>: 8]
56942: c00000000145008c  1908 FUNC    LOCAL  DEFAULT    2 cubictcp_cong_avoid  [<localentry>: 8]
56943: c000000001450800  1644 FUNC    LOCAL  DEFAULT    2 cubictcp_acked 	    [<localentry>: 8]

> bpftool btf dump file vmlinux | grep cubictcp_
[51540] FUNC 'cubictcp_acked' type_id=38137 linkage=static
[51541] FUNC 'cubictcp_cong_avoid' type_id=38122 linkage=static
[51543] FUNC 'cubictcp_cwnd_event' type_id=51542 linkage=static
[51544] FUNC 'cubictcp_init' type_id=9186 linkage=static
[51545] FUNC 'cubictcp_recalc_ssthresh' type_id=35021 linkage=static
[51547] FUNC 'cubictcp_state' type_id=38141 linkage=static

The patch removed both config guards.

Cc: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 net/ipv4/tcp_bbr.c   | 4 ----
 net/ipv4/tcp_cubic.c | 4 ----
 net/ipv4/tcp_dctcp.c | 4 ----
 3 files changed, 12 deletions(-)

diff --git a/net/ipv4/tcp_bbr.c b/net/ipv4/tcp_bbr.c
index 05dc2d05bc7c..7e52ab24e40a 100644
--- a/net/ipv4/tcp_bbr.c
+++ b/net/ipv4/tcp_bbr.c
@@ -1156,8 +1156,6 @@ static struct tcp_congestion_ops tcp_bbr_cong_ops __read_mostly = {
 };
 
 BTF_KFUNCS_START(tcp_bbr_check_kfunc_ids)
-#ifdef CONFIG_X86
-#ifdef CONFIG_DYNAMIC_FTRACE
 BTF_ID_FLAGS(func, bbr_init)
 BTF_ID_FLAGS(func, bbr_main)
 BTF_ID_FLAGS(func, bbr_sndbuf_expand)
@@ -1166,8 +1164,6 @@ BTF_ID_FLAGS(func, bbr_cwnd_event)
 BTF_ID_FLAGS(func, bbr_ssthresh)
 BTF_ID_FLAGS(func, bbr_min_tso_segs)
 BTF_ID_FLAGS(func, bbr_set_state)
-#endif
-#endif
 BTF_KFUNCS_END(tcp_bbr_check_kfunc_ids)
 
 static const struct btf_kfunc_id_set tcp_bbr_kfunc_set = {
diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
index 44869ea089e3..5dbed91c6178 100644
--- a/net/ipv4/tcp_cubic.c
+++ b/net/ipv4/tcp_cubic.c
@@ -486,16 +486,12 @@ static struct tcp_congestion_ops cubictcp __read_mostly = {
 };
 
 BTF_KFUNCS_START(tcp_cubic_check_kfunc_ids)
-#ifdef CONFIG_X86
-#ifdef CONFIG_DYNAMIC_FTRACE
 BTF_ID_FLAGS(func, cubictcp_init)
 BTF_ID_FLAGS(func, cubictcp_recalc_ssthresh)
 BTF_ID_FLAGS(func, cubictcp_cong_avoid)
 BTF_ID_FLAGS(func, cubictcp_state)
 BTF_ID_FLAGS(func, cubictcp_cwnd_event)
 BTF_ID_FLAGS(func, cubictcp_acked)
-#endif
-#endif
 BTF_KFUNCS_END(tcp_cubic_check_kfunc_ids)
 
 static const struct btf_kfunc_id_set tcp_cubic_kfunc_set = {
diff --git a/net/ipv4/tcp_dctcp.c b/net/ipv4/tcp_dctcp.c
index e33fbe4933e4..6b712a33d49f 100644
--- a/net/ipv4/tcp_dctcp.c
+++ b/net/ipv4/tcp_dctcp.c
@@ -261,16 +261,12 @@ static struct tcp_congestion_ops dctcp_reno __read_mostly = {
 };
 
 BTF_KFUNCS_START(tcp_dctcp_check_kfunc_ids)
-#ifdef CONFIG_X86
-#ifdef CONFIG_DYNAMIC_FTRACE
 BTF_ID_FLAGS(func, dctcp_init)
 BTF_ID_FLAGS(func, dctcp_update_alpha)
 BTF_ID_FLAGS(func, dctcp_cwnd_event)
 BTF_ID_FLAGS(func, dctcp_ssthresh)
 BTF_ID_FLAGS(func, dctcp_cwnd_undo)
 BTF_ID_FLAGS(func, dctcp_state)
-#endif
-#endif
 BTF_KFUNCS_END(tcp_dctcp_check_kfunc_ids)
 
 static const struct btf_kfunc_id_set tcp_dctcp_kfunc_set = {
-- 
2.43.0


