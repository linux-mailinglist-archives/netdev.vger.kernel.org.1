Return-Path: <netdev+bounces-247690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B377ACFD971
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 13:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DFC8300D666
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 12:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FBD308F3A;
	Wed,  7 Jan 2026 12:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hxx0K4WJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC613112B4
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788265; cv=none; b=VOjl7xxtmSr52X53lYvRGM+GSI79ccP+mTeXWGD+qYTJvfN7MkYUBwv6w02qno9V2PRDL7EI3BcSaYEPsqsS6dInK0rywKi9Ki+xeZazTqq3OKUr4Wifw6Csc/P92xmL62LEnW6vW+/IhDGRBtgXpVR2ZEhqr3KWUwna+7ZHBG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788265; c=relaxed/simple;
	bh=unytFKZ8LCGZbWiIqqle1BjuJ9OKga7Krn0YjNtEcU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=edbgMy+TRF5pzRDpDVijT2vf6dZMcRBhIZQNuvH5VvgtH0KwERNfuwEYJvQXQazWCaMBJWwsXIZJ3xkG5jitML2LfEjYZW5ic1TjCCehqQeF8O24niRq1CEs0eJJ1PxuAhcW5L+25znGID4cI3Xz1Kn8Ww5APypmehMrsT99No0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hxx0K4WJ; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a0a33d0585so15389345ad.1
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 04:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767788263; x=1768393063; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htJmJ2nOl5HS2d4lrmu4G6awIswx3aqJ66sxEqxOU2k=;
        b=Hxx0K4WJfNcevFrkkjD/ig/efMM0d/wmzS6HAN/9pMiWmFQdrKesCCXHHt6aTXvn8Q
         CmLkaNFeeIwY6K2oLmIp2i2osextuFVp8syijGxqt2xKaPP4SblCCx1p3uTeS1ScpxrJ
         lwdZtwUU/CHrE4b6GUpqqmwCbj4tqSLy7kDKVXAwbmcWGbmwTcq7rJSoOtE9hraeML/g
         oYoHDbguPKmwHL/ELAA4+XLP0wOfGfBjiynViELp7Q8iqCnT39lcRBTOJ7fhVMzeTVLv
         wG309TTuxDhULiUKLNhCDOG3gE/baj2uZklxhqI9mp9NUQt3Kvw8oIllAwy1rjDler2v
         E9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767788263; x=1768393063;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=htJmJ2nOl5HS2d4lrmu4G6awIswx3aqJ66sxEqxOU2k=;
        b=hgj0UbYMX0TDHA3mV11zx93jFpVICOhhbO9nnDQBwPwl6RK9XSw4O1SUOo5vhYYFwq
         xtOCzw4HDKQJPFOvxYtvXRaLCb/YuQ+A7VDMk3zfYG+VcP4r56qMw9GdJhmmEeFz8+GK
         /WuzcQoeIyykgrgrSrD+7wdFMUXgB9fjXBWX+LN1ByCyH/Se2HMFtgCrs3+WRUIhpPgy
         eJO0agSD8+9zwYJb30/bhvYntIPtjgpqUPSraRslpCmf1Kw326yFh/O8ic4lS83SaoC0
         Q10Bci0Zsugzunj6tAWjh4WCtwCIphtpKoO3IScdeOlYKLqIc4zOuM96amg7WVBA5Nnt
         0c4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbZpRtWsK6hQlTAFFO2zRfithmXn8zV+sZT866FHECuEERImAwH54y/23HxQ9LolvlRAlcqlU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg04PuSAVOMZIgYZrlGtR6oIHx29fyCKttq8ROli900i3P/1gZ
	D7Bxigin1S8fP3d7iMM8viriikMH2wsmyNepDZLgnUtcfJukT0QCjp24
X-Gm-Gg: AY/fxX5NDanLTWRN5AmetiRoFeA1Mh8ePiBsD1AO/QRPR+IXwxvd1jOnszV4V8J9zXb
	4mY/M58mYAs+43NFtmWSQDBRNePhG5CmPTY4bC+gy5HLrCD8Xo5VsIy3jEDnHAcq+J0WhEqyfBN
	IAhxlcHgALVUMaFKGNb933kvuQrJ7p9UNpFiJlmxhG7tlyXxT5GgTCaA67vN+k8+JCAPbGMAw9m
	ss25L/dDK7EqWOzs58qNAp2hjMKXsRFHvv5J6zkFaveiuKQqa4VwI61iYchsvxSu0WHO30K+Umh
	SY55y+z7t2czuJEX343MhfYT0mSXqk/AZdBlit4W5QcB7dgOpFFNnxR44JbA5GwXV5J6Vob7Dz2
	aArLNy6PGJfJRqa0P56sWIHgXHMNtQyR2YyxjQANI3xIYzKZYv7X0uDRbd9l1igRYZNISgfey7S
	XyHom3mTfbsuw=
X-Google-Smtp-Source: AGHT+IHrxNRxtolUOD4KQenPLaGlanLAT6aJ2E8evm+7qxd+QPmMdAGse+vZ/5sK9FbuhMD3s/dxnw==
X-Received: by 2002:a17:903:40ca:b0:2a0:bb11:9072 with SMTP id d9443c01a7336-2a3ee4bfe1dmr20912635ad.55.1767788263084;
        Wed, 07 Jan 2026 04:17:43 -0800 (PST)
Received: from [127.0.0.1] ([188.253.121.152])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc7856sm51003525ad.68.2026.01.07.04.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 04:17:42 -0800 (PST)
From: Zesen Liu <ftyghome@gmail.com>
Date: Wed, 07 Jan 2026 20:16:48 +0800
Subject: [PATCH bpf 2/2] bpf: Require ARG_PTR_TO_MEM with memory flag
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-helper_proto-v1-2-21fa523fccfd@gmail.com>
References: <20260107-helper_proto-v1-0-21fa523fccfd@gmail.com>
In-Reply-To: <20260107-helper_proto-v1-0-21fa523fccfd@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Shuran Liu <electronlsr@gmail.com>, Peili Gao <gplhust955@gmail.com>, 
 Haoran Ni <haoran.ni.cs@gmail.com>, Zesen Liu <ftyghome@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1786; i=ftyghome@gmail.com;
 h=from:subject:message-id; bh=unytFKZ8LCGZbWiIqqle1BjuJ9OKga7Krn0YjNtEcU4=;
 b=owGbwMvMwCXWI1/u+8bXqJ3xtFoSQ2ac3zmnp5FLy4UX8R2LjTnQbvGNz5/VUua8a9321ZUfz
 N5U5h7qKGVhEONikBVTZOn9YXh3Zaa58TabBQdh5rAygQxh4OIUgImsU2ZkuHfrkQV/keSbs7yi
 rAmrH7ac7wjduNutbtPkV2d33jvtF8PI0M2xIH26qJnV886PrGvehIZc/LniQLPi6f4e1r3mV71
 jOQA=
X-Developer-Key: i=ftyghome@gmail.com; a=openpgp;
 fpr=8DF831DDA9693733B63CA0C18C1F774DEC4D3287

Add check to ensure that ARG_PTR_TO_MEM is used with either MEM_WRITE or
MEM_RDONLY.

Using ARG_PTR_TO_MEM alone without tags does not make sense because:

- If the helper does not change the argument, missing MEM_RDONLY causes the
verifier to incorrectly reject a read-only buffer.
- If the helper does change the argument, missing MEM_WRITE causes the
verifier to incorrectly assume the memory is unchanged, leading to errors
in code optimization.

Co-developed-by: Shuran Liu <electronlsr@gmail.com>
Signed-off-by: Shuran Liu <electronlsr@gmail.com>
Co-developed-by: Peili Gao <gplhust955@gmail.com>
Signed-off-by: Peili Gao <gplhust955@gmail.com>
Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Zesen Liu <ftyghome@gmail.com>
---
 kernel/bpf/verifier.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f0ca69f888fa..c7ebddb66385 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10349,10 +10349,27 @@ static bool check_btf_id_ok(const struct bpf_func_proto *fn)
 	return true;
 }
 
+static bool check_mem_arg_rw_flag_ok(const struct bpf_func_proto *fn)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
+		enum bpf_arg_type arg_type = fn->arg_type[i];
+
+		if (base_type(arg_type) != ARG_PTR_TO_MEM)
+			continue;
+		if (!(arg_type & (MEM_WRITE | MEM_RDONLY)))
+			return false;
+	}
+
+	return true;
+}
+
 static int check_func_proto(const struct bpf_func_proto *fn, int func_id)
 {
 	return check_raw_mode_ok(fn) &&
 	       check_arg_pair_ok(fn) &&
+		   check_mem_arg_rw_flag_ok(fn) &&
 	       check_btf_id_ok(fn) ? 0 : -EINVAL;
 }
 

-- 
2.43.0


