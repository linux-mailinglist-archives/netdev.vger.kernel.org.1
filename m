Return-Path: <netdev+bounces-242591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 32512C92600
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 15:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AB0D4E0F65
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 14:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07359309EEE;
	Fri, 28 Nov 2025 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6kVHH+T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E4D149C7B
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 14:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764341993; cv=none; b=O2d2bWnHJc+cUH3+G9erbH24WhXD0hQFk0psXp44p93fX0k8Tr7XfSE1zZAee4qVHMj9ciohxwHZuh6YuI2F6tnm7yCYLueKrWvQ6Q/fi2OztWPUfSwQhn46ePsrtHEAIld3ZTlLJwf9Ub/oGoLXEM45GqedN2W4DJsG2z+/zb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764341993; c=relaxed/simple;
	bh=8dvxLkpsdwPbPVmb69GWY8hAREa1JflLzaFv8IPaxk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRQjEiE8Wwy10iNb83XVIZ/W9ZYkQ5N/Lqqw6YhIvPdPP53aMfUiy0m/yBrwiiUWMqofG0JZ3eYlWz6imuiJZn58mtnOA/Y05S5xbknL++7cNeILezYAfhhg2ZlNcZHInSzZfRroxm3HyvqHE6P4IBbBmE2CeL/wI7K6CPl1GWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6kVHH+T; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-37b996f6b28so20574401fa.3
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 06:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764341990; x=1764946790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LFGDQeGag1fC9xZVRk+2PAZum/iU8RBKWZ4jLuZ+Nk=;
        b=Y6kVHH+TfGr8WVK+zRd1LPXoFRqJUO0NPKMsNF/S2VwekYg6BqwRErrUCahwpbpTNz
         ri2Gzl4Juwm/78Rs7dwfi9ZgNDN/ts6tHXojRW49adtpnI1T6JKk7r6CNyvYGr2/oOMY
         p3wTH7jtdfaIxXX17so7260SDtQvWy69o/tcZF+sH/30yq759C75NLMpHcjgGMToB9bX
         vUPudmtzJGSaohUEkZtfRlj2I+QbwHIlfNiEWUcpPphZ085IYPNSQwkmpikHMIk0jcDV
         V7ttBhWn9tniO/O+w1Yvk/cEcoja3431QKy4YSyMXpENrzuwnEavx9260c9T5pB6qJFn
         0jFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764341990; x=1764946790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8LFGDQeGag1fC9xZVRk+2PAZum/iU8RBKWZ4jLuZ+Nk=;
        b=XaR4Uk/nkrSxmjN8XQuJ+NECR/+eDxdCACeX6M60xGcRrGThB3Gl8Zs5O62Y4kNGui
         7gsgTk2Z+794carXHJ/5rmM64BFwexe70/HZCim7yiUopSpayN2TXCU9TduuNdltTcKR
         l9LYRjWHHuCqQWiKQdr4aLYkUc5acNUFWVjcbBDP59AuFJZgBgB7AG4f1Tr4L7VXE0VU
         gzPYotwchC/0O5GZ5N3FYzMlK2dqjQTHCSDzwVou9BQEdSRmx3YYmSq+1k86JOw3InGT
         sqDbARpp7qM3USxrFy75IwkvyD9PY5Hz2ZsfFNepiW+gRHATM/PCoYii3gvcOn371TLW
         WlzA==
X-Forwarded-Encrypted: i=1; AJvYcCXo//U1AwpA0pZiih6dXgo/E5EVjsQ1gXF2NHnGxlAeCIFzBFhmDhiR8lQUGl9dc852FuN5zvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWEO9guewFlaT5BsUwPv628tLYYVChWjfR7JJiNDMI5RcSplgP
	eZbbGpJXWYjkKSw56I3LIv9QhsCRVHkfhHFswySRHEWMXPGx7PA6G9hn
X-Gm-Gg: ASbGncvo6C0OhWwx0TTLGcwkMznG20sPiM01svPzIDs8tgwo6gRMpKIQ+a0Na+/8MEz
	2CVJ5OMygrm1RDXSoEuHibKoXCWsbIGWkxyIZXW3RDGrQYjWlYQttXlHx+0oJNEuvfMJJW3t6HJ
	y38QXreRZ+frAJnT9hJnIHKrVXh6UgdS645orM/Bk/Zib36mD3NwVFMGN9xjcKPM8YBo1gY9d1m
	BnAe5yifrEYpyNLb5Y3H0uoAi1Qk/BWJECcrGV8VHTpF9cwJVNZOzFeNLWqLFDzxn682mNwSp35
	WhzJD79xws6HQbJ0DQlgb8xfIHdHe8oEKq4u5ck+wcp9LEojelOh/GXsmHQqTep9bKpuW4hLDle
	c+nixiSin9gNqpbiAu1YpQ2C1huNsouiJN/tGeWBCHI//hDTSYzQxGPZE/V/9PZXBgtUO0UOQ7W
	WCuleIrHLJN/tXXmrMvnONJw==
X-Google-Smtp-Source: AGHT+IEVofIfgFsY+VlfcrQEGcurbAwqJgijPppQLMQUo13lcIL6Bol2salv9cHflZ0j8CH4lQdd6Q==
X-Received: by 2002:a05:651c:3043:b0:37b:aa93:613d with SMTP id 38308e7fff4ca-37cd919f5c1mr64634661fa.12.1764341989993;
        Fri, 28 Nov 2025 06:59:49 -0800 (PST)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37d24103d77sm10254641fa.42.2025.11.28.06.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 06:59:49 -0800 (PST)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	fweimer@redhat.com,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v2 bpf-next] tools/lib/bpf: fix -Wdiscarded-qualifiers under C23
Date: Fri, 28 Nov 2025 19:59:45 +0500
Message-ID: <fa4ec6c228a314a9f0995f80225a4c0e4d8ac2c9.1764341791.git.mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251128002205.1167572-1-mikhail.v.gavrilov@gmail.com>
References: <20251128002205.1167572-1-mikhail.v.gavrilov@gmail.com>
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
making previous implicit casts invalid.

This breaks the build of tools/bpf/resolve_btfids on pristine
upstream kernel when using GCC 15 + glibc 2.42+.

Fix the three remaining instances with explicit casts.

No functional changes.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2417601
Suggested-by: Florian Weimer <fweimer@redhat.com>
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

---
v2:
- Declare `res` as `const char *` — never modified.
- Keep `sym_sfx` as `char *` and cast — it is advanced in the loop.
- Cast `next_path` — declared as `char *` earlier in the function.
  Changing it to const would require refactoring the whole function,
  which is not justified for a tools/ file.
---
 tools/lib/bpf/libbpf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index dd3b2f57082d..22ccd50e9978 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8245,7 +8245,7 @@ static int kallsyms_cb(unsigned long long sym_addr, char sym_type,
 	struct bpf_object *obj = ctx;
 	const struct btf_type *t;
 	struct extern_desc *ext;
-	char *res;
+	const char *res;
 
 	res = strstr(sym_name, ".llvm.");
 	if (sym_type == 'd' && res)
@@ -11576,7 +11576,7 @@ static int avail_kallsyms_cb(unsigned long long sym_addr, char sym_type,
 		 */
 		char sym_trim[256], *psym_trim = sym_trim, *sym_sfx;
 
-		if (!(sym_sfx = strstr(sym_name, ".llvm.")))
+		if (!(sym_sfx = (char *)strstr(sym_name, ".llvm.")))  /* needs mutation */
 			return 0;
 
 		/* psym_trim vs sym_trim dance is done to avoid pointer vs array
@@ -12164,7 +12164,7 @@ static int resolve_full_path(const char *file, char *result, size_t result_sz)
 
 			if (s[0] == ':')
 				s++;
-			next_path = strchr(s, ':');
+			next_path = (char *)strchr(s, ':');   /* declared as char * above */
 			seg_len = next_path ? next_path - s : strlen(s);
 			if (!seg_len)
 				continue;
-- 
2.52.0


