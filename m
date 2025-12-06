Return-Path: <netdev+bounces-243893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3010CAA29D
	for <lists+netdev@lfdr.de>; Sat, 06 Dec 2025 09:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84B6F30EF18F
	for <lists+netdev@lfdr.de>; Sat,  6 Dec 2025 08:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C267281504;
	Sat,  6 Dec 2025 08:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSGr7AMv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FE61487E9
	for <netdev@vger.kernel.org>; Sat,  6 Dec 2025 08:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765008445; cv=none; b=Tu4d3M+ROtmwxiIiqXQAouWxGc3JYtuamIS4ClLGfd4bTUyMZosIN8/kRUAFiw5JwssGiQfMAf0no7d7NR2dbaYQhIWgprnxQO/ZqMHRA2L9e/X9rs5UUfXtwLWDYwZ5Ys4YyTOkT/swVTuAE1RGMFly41Xg2GjRs2yh7nMeuaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765008445; c=relaxed/simple;
	bh=EzK1xSEeoZYFgt+SN23f5jLrjvDUlqWbGJK8L3GexEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IqLExzlYO7Ur4uN0YOIxYcf8HznP0XgI/E6oQuL9wcYj6K0KiUwj6o19ivbqcJISTa2hnssZyihhGM/mChyEw20mamR6sCNHfjLdth+3CCRGWdjQ35L6QQQLM9CngZZjsoH0X9p56UaSeRyQLG1pd+/YGTEpe7zo1DwVAVYcVlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSGr7AMv; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59428d2d975so2998505e87.3
        for <netdev@vger.kernel.org>; Sat, 06 Dec 2025 00:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765008441; x=1765613241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmjX+/74hwVvj05lgvnfrMHTKDHiJRLsWl0Oo8OJzdQ=;
        b=jSGr7AMvMz6TmwWqJQ+bsNeE/iuyqsv+DD6Fz/VIHdlMrVK8xhr3ca7e4ySVXzt7Rf
         ORhAEZEQf6UObgf9wI3hxS4GjIan8ha9aETJbghfX5vMVMcI52mzfULqsdCAI74VFkyr
         TEdSTSyHx8oJ5dnnjnp/oWh1IJDagbzLWx4QXgqoPCVhutmSbmOM4Ep9+y6SCyZpwiR8
         +uXNMMPZtCDaNMr+VLEHH33UqGreyKsRL0P5ufqrGJcZ1M4hvcmUYSiCjG4VoS375yP0
         1XNDloBrmxPg+nskF9jJnch75jBuLI1QU80/y6XsD4mhKE623uZe3sMV0I2BDUyBxaGJ
         JvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765008441; x=1765613241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TmjX+/74hwVvj05lgvnfrMHTKDHiJRLsWl0Oo8OJzdQ=;
        b=wWzTXZYHRXExLiPR5DXp6vdrDt6kF8cY78oOhia42SbRiulIzt7Uqkv1qyTIm6LbQm
         iZ7r2NXCuckwRyRu06Bu/X+BIvhTABX9fBDwMeSxQmpi34XUD+hkic/YMrJkPDSbLiph
         IO8geJpaLt7K4A+wX3ZtRuv9TMpsqCHhziCJRG3HU78rt9Eor9fDsyNdp+lULMj0aH7o
         +oPZmUVNRRfoVVZwDIcR4eEVmstUfUIJoerWUhCqOMcM2i6wqkn0SUrS52TwnQ6r+L0x
         Oql/Xu3L4H54VQ5tRrRsg3BFFlGRR2FWG/OLcOcNy0bXqFJMbMaQFbp8pWcAhx44OU97
         yF1g==
X-Forwarded-Encrypted: i=1; AJvYcCUhw8HZIcs+r0+K/aB5nBjV9oFfpUftrvQ80m2YV113TjtvfubEjv0kEWzy23qnA8LnP8mAwDo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3f5pY62Fat++R8tN46L44JddFH8zg2Avxad31xawIgXcBJfCD
	K8rVqPkGFTDcTnZ3RdW62M5/0PBZ3OJpJYiS5GvYDNB1TvntJ6+rrnUf
X-Gm-Gg: ASbGncu2YOp8TG0nmPRgUJ+wTZUZFhTWv7Sndy6sr52oX1fh2+E+UzoYGsHHCiqLCjQ
	7hkOykwIq0Q+04RyQSJwjzKzT/TIRqdQPomiTIUmbNokYqc2CmBd+nECGax0id8PBmIVwrw6I1X
	igaJ5oGvwvhO0/AJgKgJC5/Sto8YbBdUmHoULC9y9VsQAdHgHdXsqS/GJleq3H4SgFaX9Qsv2rO
	zRsuVE7W9dD/t9Xe5cSx6mATPs7K+G6PE8ksXMwjdzXCaiuMvwigZes8LBuKmqzhE5XJ0KYy7vn
	jWSxOCSmAZlMbzuwZIfiQN/4D64jodsr0PwRSvM2h20M2ew0phqENkw6fXtnebJ0oTrEaEhH/jl
	htbm0KKoiKJ36kroCuujLUeWA3ZzWSb7XiobQ3M5AMQoKiuNgBj06C8uD3GRALalqXpIdfoTRE0
	pD3ARUDTZNJV3bn22aF3guTQ==
X-Google-Smtp-Source: AGHT+IENZwxifIW25l19qn/rrWzvbs7Fu6MxW18X3oSB1XP/Q4gykgCunKuFotwxlBv0BPpftItjqw==
X-Received: by 2002:a05:6512:2351:b0:597:d7a1:aa97 with SMTP id 2adb3069b0e04-598853c2a06mr506880e87.33.1765008441126;
        Sat, 06 Dec 2025 00:07:21 -0800 (PST)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-597d7c1e2efsm2225848e87.56.2025.12.06.00.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 00:07:19 -0800 (PST)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	fweimer@redhat.com,
	andrii.nakryiko@gmail.com,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v3] tools/lib/bpf: fix -Wdiscarded-qualifiers under C23
Date: Sat,  6 Dec 2025 13:05:56 +0500
Message-ID: <20251206080556.685835-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAEf4BzYOhiddakWzVGe1CYt2GZ+a57kT4EyujhoiTQN6Mc6uLg@mail.gmail.com>
References: <CAEf4BzYOhiddakWzVGe1CYt2GZ+a57kT4EyujhoiTQN6Mc6uLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

glibc ≥ 2.42 (GCC 15) defaults to -std=gnu23, which promotes
-Wdiscarded-qualifiers to an error.

In C23, strstr() and strchr() return "const char *".

Declare `res` and `next_path` as const char * — they are never modified.
Keep `sym_sfx` as char * because it is advanced in a loop.

Suggested-by: Florian Weimer <fweimer@redhat.com>
Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
v2: use const char * where possible (Florian, Andrii)
v3: declare res/next_path as const char * (never modified)
    keep cast for sym_sfx (advanced in loop)
---
 tools/lib/bpf/libbpf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 3dc8a8078815..81782471f1d0 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8484,7 +8484,7 @@ static int kallsyms_cb(unsigned long long sym_addr, char sym_type,
 	struct bpf_object *obj = ctx;
 	const struct btf_type *t;
 	struct extern_desc *ext;
-	char *res;
+	const char *res;
 
 	res = strstr(sym_name, ".llvm.");
 	if (sym_type == 'd' && res)
@@ -11820,7 +11820,7 @@ static int avail_kallsyms_cb(unsigned long long sym_addr, char sym_type,
 		 */
 		char sym_trim[256], *psym_trim = sym_trim, *sym_sfx;
 
-		if (!(sym_sfx = strstr(sym_name, ".llvm.")))
+		if (!(sym_sfx = (char *)strstr(sym_name, ".llvm.")))  /* needs mutation */
 			return 0;
 
 		/* psym_trim vs sym_trim dance is done to avoid pointer vs array
@@ -12401,7 +12401,7 @@ static int resolve_full_path(const char *file, char *result, size_t result_sz)
 		if (!search_paths[i])
 			continue;
 		for (s = search_paths[i]; s != NULL; s = strchr(s, ':')) {
-			char *next_path;
+			const char *next_path;
 			int seg_len;
 
 			if (s[0] == ':')
-- 
2.52.0


