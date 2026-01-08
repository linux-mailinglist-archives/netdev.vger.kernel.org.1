Return-Path: <netdev+bounces-247937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFF2D00AB4
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 03:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3C678300CB51
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 02:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C50288CA6;
	Thu,  8 Jan 2026 02:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQu4Cg0s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BF1288C2F
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 02:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767839186; cv=none; b=CPFzzVo6fnEqcH0fUmGsQJ4tB8JGuFRffV4xPPIz5kh7/qKM3+bThIy0XPVFSNX0zGYH1cfazhn8bOA6q3vbpQb+XrlQlqS+4WRdxQM7Qelxdxo3omt/y9r6vLNJHC5Tpeg8bQr+aOdNHf6uKeOY6TmS44HSXPLzmTvkR49ggTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767839186; c=relaxed/simple;
	bh=6BAjC/h/VbSD1F8qLcHMXta1kjnk/yDOcwCuMgQVEJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ch9ySy/K5f3BcbeOI45eohccIzwQw48+c23E/m1RM33T98UU7CQQiOOx/6qKtiOlsfbcfbs9bJ1sFFfePt4ssFp5h0L6nwns9HZCcve1y+pehXrCQrKh2mmRPDQnDnq6Sz8P6mNbD/5xxmLvGA687op5oW5ph2ZDxL6+MS7MqDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQu4Cg0s; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-79045634f45so31902357b3.1
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 18:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767839184; x=1768443984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZvuCmGFnis+CKiifUfzQyTCYKAPuIWEe4J1fR1TapE=;
        b=NQu4Cg0sAzmyeI52aaV/0alld1bo9mJUZDibUjUJuvdrBIbPHd9OdW66w6QgkcJTIT
         4H+vMysIXY03urigOmlpg0gspEev5b16MwThM+qDjjlRCkCCvogtO8jpXaZKLEmVzlJk
         etaylxZsOuIi/v5jfsFiXXQp2l+R70mRKVTyFCvBWG/bn9Vl513dscx562GPLiQ+5WsU
         ifZXkI0D+edaI4zb7MqtA7mXbxQCImTuoh3LjVOaRLRK0obE3hJbpWMG+OXRxgoq4Ewk
         G1coVoblzRztZ3zMZnQ5ftj9m+Bcz4h9rzjmG3fmZBOaP8r4qyAf6eJGYnltudXzqBf6
         a99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767839184; x=1768443984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wZvuCmGFnis+CKiifUfzQyTCYKAPuIWEe4J1fR1TapE=;
        b=rGZlfW2PN6l/gvZWEeyrSLAxfaCmts8L+LIESpxhqKMjFToCz04iIa23AjtApfYO7b
         O+Tg0XOSNzXk4hmzbPjUOHBjYM1e4l1bT7ItDnaDMvfriHVO2YwWaXIAL43rlnqerUdH
         Zw67AM/AEdhf9fvUbO3Lly3HQ6bawu08DBbZ02nTniMldYp0IeV1s1gVw3FSIgVZbxMD
         xxhAqGBMPG7cwop0edOK30qnzG4rC0NpRR7u+BQuIZWokYcpxUQNhFnWoZRP6UPfR7p6
         RwbaCYCjmgUzUdxA1nRPxKReH8/6EW+UMYjgM9WjV0TQ6q7GXxDtOIo6bp2pzvnkniUV
         z7zA==
X-Forwarded-Encrypted: i=1; AJvYcCVdPsW/2j7lt6ApsxfuKofBTb44IFs0eCVxLx9BmjgyoVACCujL8adoZxd77QVO9UdDORPZAww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/fEmKEvraToVPZo4aeQIAo+zUSWwnkhNA1SvuZccqkrbsWIrZ
	iviuBwZnVRzeHhHE8oyYkEhAuYhk0KByqzyVLANiW03l5DB0szU31k/e
X-Gm-Gg: AY/fxX5RDaIJI7etciADZF1kR/sCEXFbklWNpeIC0wQU+1pZeS8TyD9eO+Kcp3ulDvd
	k1z/eSOlcXAGN/hVmHBz2XjB6zc51/M+Xv3Z5Pb3pgpigspBctU8W4uAE3QX5k3oxkNFVXADOf+
	3tz8lMKEb/BNPkYb2GBLOYreOqLmY9iSs2BE/YvasZzF8lnPo95YgMiQ6Vgc9NVm+nTvs90EQFF
	ZzHvaCe5GsJlzmtEeQX3m3SfWOo5F3aGrxguwozMGUn9IBAJBlVGmsFtEBJrazRLilhBtrPaTnF
	LDQpuMjhfwbohuIkL9q0mw0WhcXB7YxNXYrQLUD2uIdP6UPGe/2OO2OG65FWXE8gXiqhiQe7PUI
	eTWdmCBTJFPrp1rA4uz2yhRQbnHuIPcI0Ulyb/M8edITUUaC0HLN+acYmf9wiAPuYaAr4QWsVuM
	0eVgoOw2c=
X-Google-Smtp-Source: AGHT+IFFUkTXq/7pSN80+t865ih2mWirCqzKTDpTj1/OqoorJNS/79kjqGfckfZs/EJueHVA9zaKDA==
X-Received: by 2002:a05:690c:6c08:b0:788:14a2:8bda with SMTP id 00721157ae682-790b580708bmr44723687b3.38.1767839183866;
        Wed, 07 Jan 2026 18:26:23 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa57deacsm24855027b3.20.2026.01.07.18.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 18:26:23 -0800 (PST)
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
Subject: [PATCH bpf-next v8 08/11] libbpf: add fsession support
Date: Thu,  8 Jan 2026 10:24:47 +0800
Message-ID: <20260108022450.88086-9-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108022450.88086-1-dongml2@chinatelecom.cn>
References: <20260108022450.88086-1-dongml2@chinatelecom.cn>
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
index 6ea81701e274..6564b0e02909 100644
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


