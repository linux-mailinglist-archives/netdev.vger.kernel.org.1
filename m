Return-Path: <netdev+bounces-242435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11920C90645
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 01:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F9CC3A960E
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 00:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9DB1EB9E1;
	Fri, 28 Nov 2025 00:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWY91VvW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755D1149C7B
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 00:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764289336; cv=none; b=OpINeDSd0QFP95E+jAylOha4DWJSsc97GhXIieuRLlVjoEXTD07fVfCOegXoj0a3i7TmTVCWpTL1VQgrnchR05v4le3d3CEnRumLoZaiAL6D+AXNIi4e4AFrLGi6jp2jwGVaU1olb/BjWHoO5qAVUIK/ZHSNp16z+nVlMjv2edk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764289336; c=relaxed/simple;
	bh=uqb/L/q3aY7qhk1wEM4sR3q7k+W+i/F66aMpMLso4Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U9lSeYd08J1FLR1k5nQnhl2QX6Xpp8yfey4+FaV0JKZaITUNdZ/oExv5Zv+bzTSAEeQeSh1TEv8M31BPn9F8w6of87AwmIafaAMgsJXCia+/fNkH8zJL0XFCzrfcDFV6+WLn05NGjGRyrbtMt4eFLYy6kqjXKMnAEOVGAQjq4D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWY91VvW; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-37a2dcc52aeso12786451fa.0
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 16:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764289332; x=1764894132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zf6N60/mMdoTovxxehc7oTOUR+OA9D6npRAoGA+CQCo=;
        b=OWY91VvWaATLp6ISzZv8k3zefRR7LM77xrzVMHk7k9G33mMLkceLm1snG/iK+m0iLD
         xknVfOZOLu/06YSgSB4Go8go5LZ7zPrzk5uE7eNHJevSFhPEerJL7L55Hz2ZeYUSXnB8
         D7CrhwlHRHeIztdBaAxaolpzN0DC8rS37MguRBIPyI4yTno+1+VkOm7mEhLG698vuPGB
         AgauAxdEMUJXFX8qAuwnt1aFD3vJaOxHltVsFMQrtq9ba/cpBnfzVjAtB3lgPx8KQCLs
         ZHZxJjFeeUeU2CMQEzj5ViG8ydLkNlcFsLN+9ZCjBOHuTFXmX5GR7eIaHDme5FMRHSNL
         pPgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764289332; x=1764894132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zf6N60/mMdoTovxxehc7oTOUR+OA9D6npRAoGA+CQCo=;
        b=t1ZhZxHEd1xElLzHBS8j5174U4WrIUPitywdf1MqyBXNWTvEdFTB+quTXs+FD7x8TA
         Hqp0G3UHeprAX9P48s2EIPBN/idKZrkcCGU3LXl+jjn5mtXY0zQ/dnvn9+hv7Cd2RI4b
         ARJ8/z6ZpdpjgIZJ2MVH5e2MCnpRc6IU4e00e05JpP+cKAiO1K7/q44Gki3/rmbTxq7n
         t6j/GMFW5N8eZlLlAMz9UVRT7//YW+yvmBc8MnxHd6sEeVlCD4jSn7fBTTc9dk41Smxu
         QZKwd+s2g5RWa4oiSZxmNxwDfj7JgpH0chNrSGbsloyJCecEHN0I5QWPaQBPtYIiR4v+
         Oiyg==
X-Forwarded-Encrypted: i=1; AJvYcCV4NsIxNck6NkgrUu6GeZTxHzDXDgL9Tbfvga1YnPOmt8QpQ8tdCHBoBegKbB/ZyrCCcCBvOxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5TwDzDdwXM4Jgr40cVTELcQ5D2qqpOnVN0r3IYQfik7DX+6az
	AQBSIdUsK7Uzq0fGDf41w93EzdVwZecf0kfUpDyxvz8rrOQVnyDY9/W0+q2UAWDfkLWfPL/0
X-Gm-Gg: ASbGnctpEeEqh6j4Ixwd4G/cSeTkMtFtuEzyiM6Xl+kJJe5aIAtTKl50JerVU/L+YYC
	XMXOm1uWLHKmCPz+bQbS9Ssce8HUkU3kxg2TIwiHJQWMzmwPrvFVHlRGQHIF+fnmf9zQTKiTsDH
	l4ZOXNLnzxMGPORcnUpThBBcjitjLmiNJH+wxU/CRO8D3Ys400cyY5pIAa2EiJlAmjrnOwHZ8CX
	Fi/etJ2EGzo/EzoolXPaK7nRGcNRLd8AtpGXuViJ37nJPM81m9HCRHn7VGy1bQNnR9BGeBoFf4/
	148l0YgWSGJw/iBOp5N5Ys/+jM7IdcROOTh0hvKa6MRXmkq9fcsz2N8yoIn22222bgKZIXEd6j+
	/SNELZLG1cvpDlovUEIvE36aSwtC6sOUUdoEuEi4WSSUbbKOLBhD/EGsWc3iExltlkVAfnLRJmX
	ggmqhWhra7xBbURVJ7q8EQO1tJZzh1zsal
X-Google-Smtp-Source: AGHT+IG5Lh6pz2F5iqFt6VoinpQe18k4/POJqvOw9W50U6/e5NJ8ro1yH+njl0Uf0CWi3in2pYmOoQ==
X-Received: by 2002:a05:651c:4394:20b0:37b:8bee:87f6 with SMTP id 38308e7fff4ca-37d07985d9amr30935611fa.38.1764289332296;
        Thu, 27 Nov 2025 16:22:12 -0800 (PST)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37d236dd782sm5949731fa.15.2025.11.27.16.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 16:22:11 -0800 (PST)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	quentin@monnetweb.net,
	netdev@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] tools/lib/bpf: fix -Wdiscarded-qualifiers under C23
Date: Fri, 28 Nov 2025 05:22:05 +0500
Message-ID: <20251128002205.1167572-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

glibc ≥ 2.42 (GCC 15) defaults to -std=gnu23, which promotes
-Wdiscarded-qualifiers to an error in the default hardening flags
of Fedora Rawhide, Arch Linux, openSUSE Tumbleweed, Gentoo, etc.

In C23, strstr() and strchr() return "const char *" in most cases,
making implicit casts from const to non-const invalid.

This breaks the build of tools/bpf/resolve_btfids on pristine
upstream kernel when using GCC 15 + glibc 2.42+.

Fix the three remaining instances with explicit casts.

No functional changes.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2417601
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 tools/lib/bpf/libbpf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index dd3b2f57082d..dd11feef3adf 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8247,7 +8247,7 @@ static int kallsyms_cb(unsigned long long sym_addr, char sym_type,
 	struct extern_desc *ext;
 	char *res;
 
-	res = strstr(sym_name, ".llvm.");
+	res = (char *)strstr(sym_name, ".llvm.");
 	if (sym_type == 'd' && res)
 		ext = find_extern_by_name_with_len(obj, sym_name, res - sym_name);
 	else
@@ -11576,7 +11576,7 @@ static int avail_kallsyms_cb(unsigned long long sym_addr, char sym_type,
 		 */
 		char sym_trim[256], *psym_trim = sym_trim, *sym_sfx;
 
-		if (!(sym_sfx = strstr(sym_name, ".llvm.")))
+		if (!(sym_sfx = (char *)strstr(sym_name, ".llvm.")))
 			return 0;
 
 		/* psym_trim vs sym_trim dance is done to avoid pointer vs array
@@ -12164,7 +12164,7 @@ static int resolve_full_path(const char *file, char *result, size_t result_sz)
 
 			if (s[0] == ':')
 				s++;
-			next_path = strchr(s, ':');
+			next_path = (char *)strchr(s, ':');
 			seg_len = next_path ? next_path - s : strlen(s);
 			if (!seg_len)
 				continue;
-- 
2.52.0


