Return-Path: <netdev+bounces-253014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uB8TH4o9dGnp3gAAu9opvQ
	(envelope-from <netdev+bounces-253014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 04:33:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 237D47C55C
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 04:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87F1A3014F7F
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 03:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FDE263C8C;
	Sat, 24 Jan 2026 03:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVL61iVI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D085C1F91F6
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 03:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769225565; cv=none; b=Dllii4couKw2LC88ObSBqkEg+yQWNFDyxkoRkHJVC9tGmiihF1orBvccZo/goYyCZg6SzRXR/0+Jc0cSnzuxqVR/gWJ3cv6OZkCNEbr3gXS2W269dfA/pP4tApQGBUtssri2xakupQOKnEsAgXXcsYHAzimSyPih6MVqTINdN00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769225565; c=relaxed/simple;
	bh=7cC1ms5ub9SS0bly7QzzdjNJghADRqDQHVSuwXZiOkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EmY0k5gqri021LHCX12sjU+7Y9sjloos3PGMTJMTavU7R9UaH8T7WQ7FXvfd2NZ+vTD2xJFhWY3RxOiSyljP0/w/gCHgmMnrXk6XWdIBLJqzbSqGqY2hNJOA15k42/HLdHM0zmdhd+/f5lqIhWFuru/f1uWUgiEHpycfr7rF9qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVL61iVI; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a79ded11a2so17524555ad.3
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 19:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769225563; x=1769830363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TG3OIJ4OsXGkuiYroAWEp+caX5ZqVGcvi7JJxvZjj6c=;
        b=BVL61iVI88CRHYI7OLo9h9s94Hgiadlsw8Z0PkXAd08S70/8fsnKi+3/R5yqnbt3IC
         QQFVHK9pHRD2JWe2WFBNcomPXRafnHZ45a6VLKKEjW/wt9xV9FYeMR56tli5UZcsKh2w
         A1tVpZgolMpKvqjupMzu8/YPDgcLDSCA4uj/z+dFp1SmVi0MYkMpB3e/yqy5g7Oyt587
         yew/9wWqSf+zFSO+S9KglL/iMhkXr6prN3yGNRJN7P/sqWVTBks3tpf17FW1tgJa/tHT
         Y2YWUg2M5Np9Keu7QMEHvnmLhzsE2Rwlr3fC6tsV+mI5b3J8XeB/a46xL6AVDgZpwxms
         wbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769225563; x=1769830363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TG3OIJ4OsXGkuiYroAWEp+caX5ZqVGcvi7JJxvZjj6c=;
        b=sXzlmTfO2m8lgp5xHKohoz4ePeP1CG6SEdxyFyNI87YFLwYE0SkP1j6ElHkBPoAbFj
         PvGJIqz41jqpqQulJ1awTUvD8uegKHtkCyhsJbDFmABS/q1+7f3Mjnrpas81ekz9ZdAK
         b3KGEHarksa1l7YiTa0dDKs84jK9KkYJ4WHLMM3gMuLUOXeuu2mZBnvAp5ppF4AWhIp1
         ddySdUPwGLSKHih2fKuaifXS/o7eFXNcWOkSptwUVtr3l96cZmueXt+zX2nM5W6xqbIi
         qiLzj/pSGH+0cKCaeIZeCLLty4LZHenM6waEkz4Gd7Viz/2RhsAzf0kA+lS9UsAHIHM/
         OC9w==
X-Forwarded-Encrypted: i=1; AJvYcCUZ2dD7K2iyQvb8BiFo6R5anvEoL/RhQDY5scBo2XbeCHdIFOj/47nzfouB6FXhbPO5vyoJHO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymhm/gSCiXCqhtomgyfPxfOCvevMLJGkMEbw/mWelM29Y7Xa4K
	h3dNN8vyrLJOO0Zz+UoHXVFJ6fc1kvs1K4BznlYrqr0xxRtaRkRaqyHM
X-Gm-Gg: AZuq6aKEmpdKIq9zG1S+tXrg4PwxVlNNIqJ47R2x/araHW/g0VVANAjaIhvItEyTN6y
	m4W6ycTfhXHAOhyhNJitogUncnkV9ecIXSAcwr1R19jkvHNI7ACAOSMMODcKF3GuNGalrw8sdHF
	QSglcGCR99FjvCOFKPBhmmDVN8nMK3Z0oZ2rt7DRCi6UHG8FcL+uEDtTG3koKLfRtD9srqBh+k3
	Qm1rOvpHL1KKAHh7PdXe/rcNbZ2/iND6et70zks7zMnHGK7cZXulvzVPbcZXuKr7+K/pDH/KJ6i
	ymLr8s8WPpebYVTB2n7P0RzCFE8byEznd92/SHpVGWsu5xwQOZk6xXC94SQH7wDnYHWHjG9ek86
	70ENPffrGZjv87cO2RijdxNkOvunvZpLxsiA6XPogCSKiqkglEpO19f73SSCH2gJ2eGUqwfHrmn
	9GUyJNU3KKQgx2z5J2Ygs=
X-Received: by 2002:a17:902:d2c2:b0:2a0:daa7:8a57 with SMTP id d9443c01a7336-2a7fe6260dcmr51787635ad.30.1769225563119;
        Fri, 23 Jan 2026 19:32:43 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802dcddb0sm32539805ad.38.2026.01.23.19.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 19:32:42 -0800 (PST)
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
Subject: [PATCH bpf-next v12 08/13] libbpf: add fsession support
Date: Sat, 24 Jan 2026 11:31:14 +0800
Message-ID: <20260124033119.28682-9-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260124033119.28682-1-dongml2@chinatelecom.cn>
References: <20260124033119.28682-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253014-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_NEQ_ENVFROM(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:mid,chinatelecom.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 237D47C55C
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


