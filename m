Return-Path: <netdev+bounces-220231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCDBB44D22
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 07:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 957BC1C23546
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 05:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB402737E6;
	Fri,  5 Sep 2025 05:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B/azT2so"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1EE23B618
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 05:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757049516; cv=none; b=Z5Qvj+PUCwke61TVmG802soHNEoVoKJ6qf/VHWfrtb8Qz8CLMhN8ddlp7DbfwIo3XzvfDbFdIilumWMKXqBz5Nru/vbhmvGydYDhLDTzuQDCbXzzt/jLCYdEhsd4oWB493YnaoBYezCnKYvwbAEmRsGqGHveS3RAtpKHW/tDYnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757049516; c=relaxed/simple;
	bh=wpmO0hFfM2VgQGkXIZyViY1aGEMKTjVZYo7QrqzmOes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRekp6bU9pnAxV5YcLNemBVr+dljrgEAHOfi/LTe99mZc7ee1DDGDzSZZpSJPfCovZSxlFYSFGIWdmctdGawupYdo+xXnmTveMLJsyTf+Zdu/ZC5Jc5ckABLw4/4te6muW2qdwQIy9MRa9TBZaGmea+r8oQMf+r0rJHYTWySefs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B/azT2so; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3da9ad0c1f4so1152834f8f.3
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 22:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757049513; x=1757654313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tdc+XgLa8vnzNRXEWxwqJZPODrktrYfG66ZUFTEZ7aE=;
        b=B/azT2soSAh4vS/+k/Q9/CNe1PKZo9oVPUrrjeyQgYQz2uDxXBr1qK2+K6+Tmevs3e
         fRhVIjTtk9+/tnm0o2uAflnvnaIopbqT62VxzzPOBNVq/NmfHsSPfmH+DHV/tBTJ6VJf
         zHIIWHi4TZDKg0V16dp4fllXSpGjcdkzTXxEIDUIrO7hFjFH1WyALRcKUn4ssw1QfP6x
         Q9P3jSKmLPYR1QTi/tjRhIZq/PBsH7RP9cveHv7fQk48BnHfbb0Xaehr/W049wnGwIab
         OYS3EwzJtyTqo4qqR3F2q9OpNJ822PvZV+G8mPOeA+a3UjiWC6y2j7jojYdhXhLLPzVT
         y1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757049513; x=1757654313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdc+XgLa8vnzNRXEWxwqJZPODrktrYfG66ZUFTEZ7aE=;
        b=q2S2QfeYvXoy/jxkhisXyWX8omef9jZaXEuOUWJX/Z5AVznlt4Qgy4aFH5Vaa4EZea
         ff5ZpuhUOY0Jnyrt672F/+HymFWGVFPnmziT/OHdtqZIFKmvS8ofVflUZM9wj1EDV1Rt
         o3z4i50V8O955TficJ5WatRjF/hjLK9k7ooZ7X57+JclSDSod3Qdu3+jsrVsOt9XhBA1
         SnWc1WpZlkhcnZWx5cQKxUQTPgLBNOE5ZO6UnnsaBHNxHeQlX7xmGW5yydPihwApcggf
         jmxu9S/3j9ASHJL/lZhUBGyJgmEonROcR9JccLaN9n/hctn3h104V4+51zpVRIGq5Hwi
         RJ2A==
X-Gm-Message-State: AOJu0YxRPqZGF6x20iArYzWWQVibtjYmlXD5pV3oojVKpjTvkjk+3Dna
	WADl5ceamLqL1wD2sYaM5lW+VkkS0KTS3pcfoDQpujjysjGK8PhUVMfxI1M1Xh2HkwAZAYWsSDV
	SfFUzwxLthQ==
X-Gm-Gg: ASbGncvOg8CAk5odLbWv9DQtqvlbMvwXUb43VYaq6Fkdijrp+aP5ZFo9bZ1dGHiL2c/
	c3XKi2xXtlHJDZTH5oC4d7RXpSONNzPH/rn68PZs5dj077Vfwfgv+3DlOgZa9Msdb3V4jDxKD19
	oa6RX/aB4amdsC4Gn/NnaM7iASU0OIYs1WZZ3QLazNlsEXU1/q7PsaJDOP9TAYWFgZt7y1hOfQ/
	AdSHssAupxTekLHqJlPLY00JjZuRp6ikel68VrUmTOA3k+8qS3nDW5Rhfxv5Prs/QJhKk8eDp5b
	xMOsZbfTz6bOScLdKBuyXA8E0k5aZIgt+k6SUJmQExShR/vmBJqqx122Zg0o1Joz/f924NCe5rJ
	OHmzz+tl34puLtRWEiAUGcLna/BlA6tRi0fV+2g==
X-Google-Smtp-Source: AGHT+IFXhtb15fSGTgJUm/RSgvPU2QTGa/U5u3mZEixb9PxoYwaKSDKGTBYD0NW39LBiENve9cjFMg==
X-Received: by 2002:a05:6000:178c:b0:3d6:4c4d:beff with SMTP id ffacd0b85a97d-3d64c4dc940mr12083056f8f.6.1757049512757;
        Thu, 04 Sep 2025 22:18:32 -0700 (PDT)
Received: from F5.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276fcf04b8sm27410154a91.26.2025.09.04.22.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 22:18:32 -0700 (PDT)
From: Hoyeon Lee <hoyeon.lee@suse.com>
To: 
Cc: netdev@vger.kernel.org,
	Hoyeon Lee <hoyeon.lee@suse.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	bpf@vger.kernel.org (open list:BPF [LIBRARY] (libbpf)),
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [RFC bpf-next v2 1/1] libbpf: add compile-time OOB warning to bpf_tail_call_static
Date: Fri,  5 Sep 2025 14:18:12 +0900
Message-ID: <20250905051814.291254-2-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905051814.291254-1-hoyeon.lee@suse.com>
References: <20250905051814.291254-1-hoyeon.lee@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compile-time check to bpf_tail_call_static() to warn when a
constant slot(index) >= map->max_entries. This uses a small
BPF_MAP_ENTRIES() macro together with Clang's diagnose_if attribute.

Clang front-end keeps the map type with a '(*max_entries)[N]' field,
so the expression

    sizeof(*(m)->max_entries) / sizeof(**(m)->max_entries)

is resolved to N entirely at compile time. This allows diagnose_if()
to emit a warning when a constant slot index is out of range.

Out-of-bounds tail calls are currently silent no-ops at runtime, so
emitting a compile-time warning helps detect logic errors earlier.
This is currently limited to Clang (due to diagnose_if) and only for
constant indices, but should still catch the common cases.

Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
---
Changes in V2:
- add function definition for __bpf_tail_call_warn for compile error

 tools/lib/bpf/bpf_helpers.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 80c028540656..98bc1536c497 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -173,6 +173,27 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
 		     :: [ctx]"r"(ctx), [map]"r"(map), [slot]"i"(slot)
 		     : "r0", "r1", "r2", "r3", "r4", "r5");
 }
+
+#if __has_attribute(diagnose_if)
+static __always_inline void __bpf_tail_call_warn(int oob)
+	__attribute__((diagnose_if(oob, "bpf_tail_call: slot >= max_entries",
+				   "warning"))) {};
+
+#define BPF_MAP_ENTRIES(m) \
+	((__u32)(sizeof(*(m)->max_entries) / sizeof(**(m)->max_entries)))
+
+#ifndef bpf_tail_call_static
+#define bpf_tail_call_static(ctx, map, slot)				      \
+({									      \
+	/* wrapped to avoid double evaluation. */                             \
+	const __u32 __slot = (slot);                                          \
+	__bpf_tail_call_warn(__slot >= BPF_MAP_ENTRIES(map));                 \
+	/* Avoid re-expand & invoke original as (bpf_tail_call_static)(..) */ \
+	(bpf_tail_call_static)(ctx, map, __slot);                             \
+})
+#endif /* bpf_tail_call_static */
+#endif
+
 #endif
 #endif

--
2.51.0

