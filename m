Return-Path: <netdev+bounces-241217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0CDC81921
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 17:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 155F04E7B39
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 16:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A5731960B;
	Mon, 24 Nov 2025 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="bNfjCNiL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D68A31961F
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001767; cv=none; b=kcHHJV4JwbcgIdgkd8qslCYABEnLpB2gENakZ5tY2se07/DwcAQzAidnWr9sZ+uY/iJ9avg2d57z8NZKMCGm6oNLHaxdn6cKpd9aAGPjEzi5vaUgaNOjkNteeq1r51PxxAn6kULWsjFYGiKHX8F/8RrlZEJH3EmZxO9rAVVk7TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001767; c=relaxed/simple;
	bh=M897/SDpxhoK9zXe71PrNl7kc+Jqcww+nJj/LVgAMpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AO5PiDm2l7s0belQPlQfVX7XWtkuJ0M5lgUlQpD1/vvTSc6cWSgDjv8M6FvkAHQYLsrA7csDjVQ65dvKTiL0jjED9LSW3V9ZsOsewZ1GZKigjmC+49d47Nf2ncQ8XKheH7p+u8ACmtKKoYglhDYsz5gEziRxkIyKRLCy2N17Cdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=bNfjCNiL; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640a0812658so7277661a12.0
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 08:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1764001764; x=1764606564; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x1HORh6gjVh4LdU+FkfxFyRR2cSB+1/UIRPvTLOyuz0=;
        b=bNfjCNiLt5jNHxsL7jyhggub/5hl/Cq6Zp7myr2wagMKy2+hs/0nSQRTOCHHZVFs4w
         MkN2q6sTL28jgP3J1zrZ8p2N3E9fUn9dB0gzwIBgtFEeaQkpECYmHJDM2hH3VWstFcB5
         7NZ8GZ3/hFevDOipWWqP7AiHd0IaitU2j/0P2tll8lOdWFgrjw52jDEwDHw+28gqA/fG
         GYw+GVjb9by0HMczkqtHh5SOtcuffPEM5kt01eWAWOFLjgMSs+54HAey/pqiGbb3ZRwE
         xprHngC1IliCGLuAtD9NlqumZ2ZjEL7qqnhKCSxB4H01DOs1kgxsg8sNZkjvGr+eZmkj
         pW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764001764; x=1764606564;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x1HORh6gjVh4LdU+FkfxFyRR2cSB+1/UIRPvTLOyuz0=;
        b=p/xG8LpvhJGkBRsLRJ531kw0Ez+iQ1G0brSVhhgDwozd2GCeHr2tV8maiOKNKyfceD
         9va2BQfqT1z4FveRX9xBX0w/jn+QE9G5dthSzRwYevTFv9Nb+FtS8dWeGl4ALIjE/6k+
         8/N16gNgc82ItZ25XJ2ZrZbagxVY+2GOe8lzl/Wf5NYgRUYyxW42gLN+ff4HdiqjXBCs
         cPxZYZHhowSPhfSXLXRlNQo6y1xvyKCWljbNFweXNaMORzJIlBqgwN3yonRZ0AypyUYt
         vPOjGtfCNfm4//k2wPfMJmuApoRhfH2scjBBsR7wuQSSdU9iWfLYZSIWUFEReIF9+C5Y
         MwVQ==
X-Gm-Message-State: AOJu0YxNUGIOHwNj0wwGPCOW2vJMxsiJoXyVtfOYA4sG5WIKp8QWT0Yp
	ZliiUBrGi4N5AXRDyFPXM81ctVOOMg+OZL/ZmnRsOOi2DUmJ3GxaBZ74aQ5URRz0knQ=
X-Gm-Gg: ASbGncsixDmIa05xWS2bTsE9Q3Nn3e1/0cCGgGt/Jiy3QT+xhE68OOSE6J9YbU/7h2T
	PpdTAFt+1uIhKWQmfaIeUWLmOUsSr4OtHeWXH9DkIzUXcAq0gwCOHDTpimYHNMPseoJKgKxAJrO
	Fu2IJI4GL0SXlUBsXXI6DMlkE//u0eUsm/z0PmDM0gDevZni6g9mgeKobFjOXDvTcRrHsxAx8bo
	tajP5mtDwFxHodw7vS9Ck7Trfn7yhBkxX68g/YaZT0UaCCMrdI8r907nlc77GN+hFssADV+NCZ+
	13H5Tdp1c2FpLF3vEfAZMl0pcY5mZQ5FEHmPUY/wLijcX7nWjRQAwQt9DPpVSDpRxhm5G4GMbk9
	ZBaM3IIhDHsSJJubnWNBWIk/rcvOS9HqJUh4izxbZstB4hhsKKyulaH0cw6CEwbd6SNimehuwpE
	ByT9RgXot1O2djGrjJF3mxLTvT4zcTKfbRvdWuEpV34PhMUTXLlfOBSDGhF5Agkoooq4g=
X-Google-Smtp-Source: AGHT+IGkiByVCAFR1LcfpdngTyoSGOoyNMrKBgscsFWAnmlwv7a40sc5G2oVFD1QNc82lnEBpj3Y3g==
X-Received: by 2002:a05:6402:1ed1:b0:641:3651:7107 with SMTP id 4fb4d7f45d1cf-6455444a01emr13079842a12.12.1764001763666;
        Mon, 24 Nov 2025 08:29:23 -0800 (PST)
Received: from cloudflare.com (79.184.84.214.ipv4.supernova.orange.pl. [79.184.84.214])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-645363b5a46sm12594968a12.8.2025.11.24.08.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 08:29:23 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 24 Nov 2025 17:28:47 +0100
Subject: [PATCH RFC bpf-next 11/15] bpf, verifier: Remove side effects from
 may_access_direct_pkt_data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-11-8978f5054417@cloudflare.com>
References: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
In-Reply-To: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: b4 0.15-dev-07fe9

The may_access_direct_pkt_data() helper sets env->seen_direct_write as a
side effect, which creates awkward calling patterns:

- check_special_kfunc() has a comment warning readers about the side effect
- specialize_kfunc() must save and restore the flag around the call

Make the helper a pure function by moving the seen_direct_write flag
setting to call sites that need it.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 kernel/bpf/verifier.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ff40e5e65c43..64a04b7dd500 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6085,13 +6085,9 @@ static bool may_access_direct_pkt_data(struct bpf_verifier_env *env,
 		if (meta)
 			return meta->pkt_access;
 
-		env->seen_direct_write = true;
 		return true;
 
 	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
-		if (t == BPF_WRITE)
-			env->seen_direct_write = true;
-
 		return true;
 
 	default:
@@ -7619,15 +7615,17 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 			err = check_stack_write(env, regno, off, size,
 						value_regno, insn_idx);
 	} else if (reg_is_pkt_pointer(reg)) {
-		if (t == BPF_WRITE && !may_access_direct_pkt_data(env, NULL, t)) {
-			verbose(env, "cannot write into packet\n");
-			return -EACCES;
-		}
-		if (t == BPF_WRITE && value_regno >= 0 &&
-		    is_pointer_value(env, value_regno)) {
-			verbose(env, "R%d leaks addr into packet\n",
-				value_regno);
-			return -EACCES;
+		if (t == BPF_WRITE) {
+			if (!may_access_direct_pkt_data(env, NULL, BPF_WRITE)) {
+				verbose(env, "cannot write into packet\n");
+				return -EACCES;
+			}
+			if (value_regno >= 0 && is_pointer_value(env, value_regno)) {
+				verbose(env, "R%d leaks addr into packet\n",
+					value_regno);
+				return -EACCES;
+			}
+			env->seen_direct_write = true;
 		}
 		err = check_packet_access(env, regno, off, size, false);
 		if (!err && t == BPF_READ && value_regno >= 0)
@@ -13766,11 +13764,11 @@ static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_ca
 		if (meta->func_id == special_kfunc_list[KF_bpf_dynptr_slice]) {
 			regs[BPF_REG_0].type |= MEM_RDONLY;
 		} else {
-			/* this will set env->seen_direct_write to true */
 			if (!may_access_direct_pkt_data(env, NULL, BPF_WRITE)) {
 				verbose(env, "the prog does not allow writes to packet data\n");
 				return -EINVAL;
 			}
+			env->seen_direct_write = true;
 		}
 
 		if (!meta->initialized_dynptr.id) {
@@ -21810,7 +21808,6 @@ static void specialize_kfunc(struct bpf_verifier_env *env,
 			     u32 func_id, u16 offset, unsigned long *addr)
 {
 	struct bpf_prog *prog = env->prog;
-	bool seen_direct_write;
 	void *xdp_kfunc;
 	bool is_rdonly;
 
@@ -21827,16 +21824,10 @@ static void specialize_kfunc(struct bpf_verifier_env *env,
 		return;
 
 	if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
-		seen_direct_write = env->seen_direct_write;
 		is_rdonly = !may_access_direct_pkt_data(env, NULL, BPF_WRITE);
 
 		if (is_rdonly)
 			*addr = (unsigned long)bpf_dynptr_from_skb_rdonly;
-
-		/* restore env->seen_direct_write to its original value, since
-		 * may_access_direct_pkt_data mutates it
-		 */
-		env->seen_direct_write = seen_direct_write;
 	}
 
 	if (func_id == special_kfunc_list[KF_bpf_set_dentry_xattr] &&

-- 
2.43.0


