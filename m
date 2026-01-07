Return-Path: <netdev+bounces-247710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B01B7CFDB12
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 13:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29F623089796
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 12:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75507315D23;
	Wed,  7 Jan 2026 12:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPE49rnj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057053168E4
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 12:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788558; cv=none; b=cExNaUxurYt2h0LCVRVpp6Mwu2G+Z2ZBJXKvdXzEfqcvGPlYz2rF/7Zb4VuTGkAON890p9DpZyYrnhIp25iNtzqGzd4vcXYMJoSJLN8crYHYJXZMLFcLcc/a53zR/TsbN060PW083AebM0Q0qABXlXCWZvzZD7Z/9NeCfRrmPy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788558; c=relaxed/simple;
	bh=unytFKZ8LCGZbWiIqqle1BjuJ9OKga7Krn0YjNtEcU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DOp7dRIxumfbLxl7X+lNUr6je9BV+xNvYK7DmrV2LMPYIlUlaSBFb7u5JVF6RMzzQt5u4MVuYjT2wNdiycEZdkQMXhFJxjw4C48H15/exewcf5zG0LdwVCLXyPxgeSu3EOk8ANYvssLjLDh9H8Ld8xGT3NnCLzm0MDWXmcwGkyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPE49rnj; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c84ec3b6eso2234999a91.3
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 04:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767788556; x=1768393356; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htJmJ2nOl5HS2d4lrmu4G6awIswx3aqJ66sxEqxOU2k=;
        b=IPE49rnjTjtHNOBtLnU3aEWDBjoZx5aoL7s059ET3UMOTiQ/nA6pVAcCTiwASBZDZz
         dEPHicB+5eMr95lUShJLydiEOVzS/Pq0ts2IIL8m+lUMVjD0mJj1/JksKgGPqUj38+3Q
         tlbPNWe6NBaxjmO7u4RWTO1+5oo4esLYzm8dMi4RrlApnNkpdXQwNt1dLyYvSKCybrTQ
         sOaJTBT9RzwMbK1EuwKvmHMHkZxFF/QnLpIr/oaxJLVtQ6G2Y5fzKOjK4YAckBZyMn2m
         98RJck2QDqsS1P1iaBBZ8j4enbxg0mUqyZDomxUbMb9/7+VQypljfgi4w07DMF3+Rmh4
         E/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767788556; x=1768393356;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=htJmJ2nOl5HS2d4lrmu4G6awIswx3aqJ66sxEqxOU2k=;
        b=XMfgWnzxHwHsm/fQNl/lW/JXuAXpyYiZYXzM7eT6O81rFV+Q8AtYnS2WtWTAB1uFfY
         FLGsks5T/NQOeBPXpDlqd4tC+548Zf4cqjE+l0Yaa+hQTQK5HHzPyMYdaPpiK6ymOwA8
         9HbNsKwPlcz9+7mAz4AvU5oSKtU5TBZMXGe+FwfgW/xTEAfiU5O1uNEP5fyXge+yqTtQ
         OeIr6E5aqG6nbg0x66AG46IaEDdXuBSuzXVltGxnToWxD6GutkXh/7PewFBY/TFiuUNI
         xMDVdzIFG3mtTu1Tlr+ZeFpDL+p2ZA/lKfbtDEldzI0uUMe+AZ1ilI+URFG4Zt4tNnpD
         7CeQ==
X-Forwarded-Encrypted: i=1; AJvYcCW84EkGUUPc4UhQtZg9UVeYrEhUsiquHM+kaFGX86k+ybtheZRZs9bV1NNTCqy/YStf4aXs8wo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9emFNWeVRMcLT4QxOn+tcrup7BiUgxdAmgitDi5nnhSoJS30+
	aVTywGELcQ7AysFNSkQv5zl3w9hHXi09mULEIWixp8ZtJLL279s3ZlZW
X-Gm-Gg: AY/fxX5J4OUngdEW6CsQog4sd5Q1d8AV1wZPYIOpo8KpJhBmGW3hlTR6uCKiT0PFaSQ
	EP7JCOUK9UocR635WsgT9YqllZJiJPEjWS0uEwMNY6QTcYsRRahcLS4p0MVHygUAQTINtKqJ9UI
	NLCygrBmgJ3r22rl2i3LmIU3k0ozp2SKECFjP2m7LWP6dchMMA2gbXLFJGAE8FUlaAhBOKPkspW
	j0xTesLzEDpxLOM5luagRhjtU+m9IbTR9RoP3BZaru6qP8HzdfPYXR/0YxaAXZvfkK++8QkqZLh
	SzOdy038pssS4+N9SW5HXy1JarSktQm17q/9foTB9UVMSQolB2xzuRv1Bkr1wdvfPK411QScMOV
	sy1oY1eXuztEc3D6qm3H7SLXtUA3gSlKOT2vQbP/N7waLAC/Vp6iM4Eh+zFMCFMoBGL5w7OpB6D
	0D688ZpJFFKBI=
X-Google-Smtp-Source: AGHT+IF4vumQ3UxDP/AczQhAuKSLCFCXdWDt3+3Ac3DseSrY7lK07U9RAIhVR1+386lDOWSI3dLtWg==
X-Received: by 2002:a17:90b:540e:b0:343:5f43:933e with SMTP id 98e67ed59e1d1-34f68cbe0b5mr2124192a91.19.1767788555990;
        Wed, 07 Jan 2026 04:22:35 -0800 (PST)
Received: from [127.0.0.1] ([188.253.121.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f8b1526sm5025946a91.14.2026.01.07.04.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 04:22:35 -0800 (PST)
From: Zesen Liu <ftyghome@gmail.com>
Date: Wed, 07 Jan 2026 20:21:39 +0800
Subject: [PATCH bpf 2/2] bpf: Require ARG_PTR_TO_MEM with memory flag
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-helper_proto-v1-2-e387e08271cc@gmail.com>
References: <20260107-helper_proto-v1-0-e387e08271cc@gmail.com>
In-Reply-To: <20260107-helper_proto-v1-0-e387e08271cc@gmail.com>
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
 b=owGbwMvMwCXWI1/u+8bXqJ3xtFoSQ2ac/xdV2YfeZ4wuCJmHK+jVqLv8r746++XhqI33HeIWb
 12tuTauo5SFQYyLQVZMkaX3h+HdlZnmxttsFhyEmcPKBDKEgYtTACYSPZ3hn9Xf5xONrlr+X8xp
 w3u4MqBS/ZX9+cne2x/Yf3gYWmhZ9YLhf4YZZ/bqW6kPMp8LaE/j6LdmUPfcu6VwpXSdpc3x3sx
 nvAA=
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


