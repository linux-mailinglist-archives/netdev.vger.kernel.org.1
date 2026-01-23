Return-Path: <netdev+bounces-252665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCIDNh4mc2kAswAAu9opvQ
	(envelope-from <netdev+bounces-252665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:41:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7989F71E54
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25B903015872
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 07:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68093382E4;
	Fri, 23 Jan 2026 07:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQhrHOIK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEE6318B95
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 07:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769153813; cv=none; b=FpYaq8BlV7T407j4QvUsoFv6DsVrt+4qpi1huamnLG+B81NepGM4UZ67I8nwx4rnGvO+8nOOnppUY+HcQI/rbBG9qcATlEXuGRUQ+ddNG+o5SVhA9YH+40Z8p3J8mTR0gFQEYNgGERkbTZm4hnLeiebYfdvGP4b8i1LGSsfXsaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769153813; c=relaxed/simple;
	bh=7cC1ms5ub9SS0bly7QzzdjNJghADRqDQHVSuwXZiOkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IfucARCHR3BiTmYUuyrGew/ffbHD+j99TwC4oCQTp+57M05XVAePL5rBL8/XqvLbaYtbWi9KCmXTh/J81X0QwhG636bnaRUBP55qSJ/jJZPJlVa8H8qWW44i8j1AT0MW1EOg1YNFfXYfXzIh9qcSkS9/zdVxM2pTsM4YyFFtd2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQhrHOIK; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-823210d1d8eso73577b3a.1
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 23:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769153811; x=1769758611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TG3OIJ4OsXGkuiYroAWEp+caX5ZqVGcvi7JJxvZjj6c=;
        b=HQhrHOIKI1HpgGhW1C4/hYqk+pyPGbib312/colf0oNZeKvi2aQrTu4AkNjQIGya5T
         L2pQKJAwNp/ZGzSiKgNUlC0WxQsvUdug/WpuIVLPeOM4rHxUo6WcHGA5x09wTy7/sYCb
         wfA283H6WygQN0YXvlZWrSarIC3XXdnABrlozPgvzzzyJwvHNhhxnzqzLJ6amIoQirza
         yyiTcWRg/5v12paT9ZR4o70CItBrh5qKe8urBxBIf/QeCFGSD4g9ksp1ae2epKMG7wmT
         3K6Mw62EMRq1S3huYMw8turGLvf72GienPWTgplc9pvMiEGdJHBLPsAeNY3/G+ECPCM4
         8wFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769153811; x=1769758611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TG3OIJ4OsXGkuiYroAWEp+caX5ZqVGcvi7JJxvZjj6c=;
        b=SGMCLAZ9/I/aAnyNRbbWlJmLZR0Lr/LMXVfsdUHqSFMhKURaVQdq3lbSToFsmVg/b3
         stv1/5iAg+cjGf9QXMw17AbaTbBRgqCzniSZKHZxyAbo6PnGEwWiKDBh23Ay2mGtXzeh
         H2XtFUJYUQ/HSdsjhnIriuYsVoxlSky8XJAKFEabyIkgX9gCQlusld2Pu6gRSmd2XzH3
         7E8VIRDHHoxgFHVQ2eA3U3Fl9PALEeWFNMM6doyu2IcEwtK/JNDqfqF7M1w4wKZRMTMT
         wQI7DSg0Z+yQ26I0t+q2yvImDanjEIRflXpN48W5O9pCZwFi/cPK+6myN90KcUmhk3wR
         FQqg==
X-Forwarded-Encrypted: i=1; AJvYcCXDwhTSu6rV/cZfKwPLIfSG5MaH9UsB6AvAymBy0txqyR19SbLW+LrE/KnqOCDc1/Tm5BdkN4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHs8NjcQtjY0lSSgy6NMFyClixXD+tUsrZhYM2kfGcGp2dLyMp
	GNyVjHzHC1iph674bhrWNx9R0jT+CVYF8GKOuFRSxtw0UD28HQFxZ+1d
X-Gm-Gg: AZuq6aKwzXiK3L+ZHNROuzwpaBgpLRLvkCaE0Lr23dePSIAYryR2zmy6kbTEnbZFtp3
	UMWmV9Zof2kGD6s6Gaf1PIGz6ZgjwdzYG9koxyni/bHbJXepBI7099O5a2P2iAnjr/JrR6/t2p2
	XKHjbg4GON1Em27ItMkYBEw9IMNUjaYqrzdD9V85+4zbwiV4fXsvEvhOVB80APEgWA/D7FchIQM
	HS/xpUF7T7UOcmPAgZag4xdfgsgndTOcOmXoN+kfJczZfZbpe1WIa0D1vHZIfIO8t3VR+YAeWJa
	lNXsjlSA7Q/tuvxKpSSWSchGrI40pBnMUUvyUlFFu71QpHPZ6DeiIhq3FtXFSZBXIxN5Uu5Nk07
	Kwj1vzN1HJU07XFbxiqlYiqahDMWjDnQjbUQUvmjNYBEKesu0COdtIUPlxizxpGR7UsL1Pn3tIr
	4q3J2rClcD
X-Received: by 2002:a05:6a00:3cd6:b0:823:8a5:297f with SMTP id d2e1a72fcca58-82317da469cmr1995656b3a.16.1769153811409;
        Thu, 22 Jan 2026 23:36:51 -0800 (PST)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231876fd1fsm1334205b3a.69.2026.01.22.23.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 23:36:50 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
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
Subject: [PATCH bpf-next v11 08/12] libbpf: add fsession support
Date: Fri, 23 Jan 2026 15:35:28 +0800
Message-ID: <20260123073532.238985-9-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123073532.238985-1-dongml2@chinatelecom.cn>
References: <20260123073532.238985-1-dongml2@chinatelecom.cn>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252665-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[iogearbox.net,linux.dev,gmail.com,kernel.org,fomichev.me,google.com,davemloft.net,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_NEQ_ENVFROM(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:mid,chinatelecom.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7989F71E54
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


