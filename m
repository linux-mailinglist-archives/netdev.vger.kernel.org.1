Return-Path: <netdev+bounces-242570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E11EBC92203
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 14:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A568340F46
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 13:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE3232B993;
	Fri, 28 Nov 2025 13:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiq+zvN7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80229211A09
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 13:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764336390; cv=none; b=Fjt0/ZxrL3Ct+ceX9BnQrQF4+IE7UvcrActeldoumHXwh6U5/cYLt2ZqSnAoeCRLvswRR6UUNw+LS5Hb6/jfG4Klu79/2/BV2ChYkDtKVwInDkeVtQ4bvwo8UfraUk/3eO4X3CAtblaVH8sKts7APhqEWjzbRUSxopbsDMAjJ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764336390; c=relaxed/simple;
	bh=tGbtpwQZbYcsBGxCvCJU0NCRNlyFyYC8UngI8Df4fxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rr+nyX4vFnXjIZZJXl71XG0agEGkn6RHKC6IKKsmp+/WOFufFuLXW5JqI5McPktHDt0JMfOcaK4iT1+O3Hrk3UIbIKWAhOnb9rG/JFvGEatrx5HocxVPzQ9bX92DiW58Iw6U/9KVr7UdmWEVl0IrkBbD01d0QudWRcwcOamZwKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiq+zvN7; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5945510fd7aso1543779e87.0
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 05:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764336386; x=1764941186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdFQ1YYHWhhvBUzcmDRED6f3M4xLb6AiLGcDNwc9BAU=;
        b=jiq+zvN7MIlWlwBAg/yduSd7UtPY9Qg1JqJ3r1H1rELedVDkFMeknCKXAXB7gJBuMr
         B+guUmfSAFBN+Jwb9rez3j3l5uRXrX7KUxiHz2+ZHwNo1A87Tj2kCL8/4UsbMvsrZoa5
         r6oaLip3mQcjwLFhOmUCBH3g1E00qVH35RIkAMP0PjFheiQuYfUJ/3CjXQNTtv9EOWrk
         o3d6kSP/+O3LfIe43nSEKHpBUAFwmqIPwfw9wE6lP9M6a3LUXLR1ffBrMe62ExjKhEKo
         vrGckOhvbhkS/e85b+dn+beo29u07w2ZJcO8HMzPE1uLWW1pUpZW3lbKxWCgGgc320ry
         DiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764336386; x=1764941186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AdFQ1YYHWhhvBUzcmDRED6f3M4xLb6AiLGcDNwc9BAU=;
        b=PE0+BxEZkdQ4KQ+z2PBflhI0qLp6t9f8s5tTCofcEnLPgl9H+KALXEf6pjYbwJagob
         gk/yM0dRmfHDbJBUlFkqplsJkeD3S3NxtE5pUw0WIbsFi/IHU/TP9X78/pZBvewqIlAu
         XlahLWCYP659CDwkJZXucJUY3n/IPn2ekll6WWOuawOPnzODFh4EZWJYQ1TTGtYxGie2
         c+QkRP5WP3l3fRhethpyd9C7uCzrwqObLdZMjhsKaBVuEL7lw5//P7qR8m9Dvht9F2S3
         ZC2AqfCg+PvW3UxvD1c462ooyOounftV7fUpYT9ZCTb+Byv7VKQzAC/hConLH0ulN4Yu
         n3EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvav3iQeG8dsmqq/Wss9m99t72qxTBICCFXHePqZg2kWS1KPGjHF18BYLaRgNG9mXLjkH19sI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA8f4w2v9AzCK085631O7NzOu9chIaJtdyRA5iJk9ahFyL7PR6
	LfPyBnLqhigJ4bqFPh6JZXGmfFm+CNiYdk9Ucpi092BmgG0cTl2lVmjXG9KQl+yqcPq+RUNB
X-Gm-Gg: ASbGncufVd951GZRpo11R5U6Nn6w5Dg0ZriWPzY/jbkfNsMeVsbzvDh2PMZ0TUdom4x
	emVR29qOtwmFBaWtmFRX3qhTatz7WtMWKwwXh4xWV0vj6Dn/QsnQ8z/s8Vix8g60txuxG9tFvGg
	c2kibYGH1jMgj+XR987rgWriPhf+1y3Nx7L6bKx45VIr0WN0vIVHpJoeY3WFBxGk2fuFBQ2R29H
	xN/cFi9R0WkEtLnTtYW1rRXS9PxdlfbonJq9wAthSS920HLgmnLVjrEu7SfdRL/Y/8qEemBGJ7f
	6nIOZBSJXQpbWK5v2l5rFtg9Rc63KxwBkWYG/IGRjUH0psWYqQVE/ChegRgY3E7CHJVYh7oktNQ
	BPdaoDKEwjSm9zv3U8es9GZdQN1WZmRPMCoAMZ6I5Z5Fq1r2E4sahof1Ml+4BC11VHQYGZMq1Rw
	4B/xcFrxfYh7+knwF73EXX3g==
X-Google-Smtp-Source: AGHT+IH6iO7df/kBjndp92kih1rmCc6w3PJabzexvI/UfRtgczNpX0VZamDAdZh6FVm8s9haM8nMVg==
X-Received: by 2002:a05:6512:b86:b0:594:1c7c:7d31 with SMTP id 2adb3069b0e04-596b505816cmr5268664e87.12.1764336386240;
        Fri, 28 Nov 2025 05:26:26 -0800 (PST)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-596bf85faeesm1223388e87.0.2025.11.28.05.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 05:26:24 -0800 (PST)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	fweimer@redhat.com,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v2 bpf-next] tools/lib/bpf: fix -Wdiscarded-qualifiers under C23
Date: Fri, 28 Nov 2025 18:26:19 +0500
Message-ID: <1531b195c4cb7af96304341e7cbcaf7aba78e4b3.1764334686.git.mikhail.v.gavrilov@gmail.com>
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
- Use explicit casts instead of changing variable types to const char *,
  because the variables are already declared as char * earlier in the
  functions and used in contexts requiring mutability.
  This is common practice in the kernel when full const-correctness
  cannot be preserved without major refactoring.
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


