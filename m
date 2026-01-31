Return-Path: <netdev+bounces-255356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKDlE3qPfWmGSgIAu9opvQ
	(envelope-from <netdev+bounces-255356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:13:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E95C0B71
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2670E3063749
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 05:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58445334C11;
	Sat, 31 Jan 2026 05:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anzbueIU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9830339872
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 05:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769836177; cv=none; b=PLy1Yb4ImS3akCtliJl50+gk34RBedv1Wx4Pk0JNdjPeMGEmQKa/wqyqgYcU9PGjsVp4mqDhZehssX1E/R6DnRwwsYxnlDDo83y8Rn7S1ZFy8rNmVFXtHLH53Aar8lDQtOD0HEz6/hpU32tN3rzoQE/fk6HqWmGSUMgQmaH7Dls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769836177; c=relaxed/simple;
	bh=3iS/7iavCieY0vGjt3CSw+m+ZHXLXWxjaSalApUkmvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bhJr7WURuL54KVN37zbBuvXl4dNVAmju2uMajNW6duiGdpU/DVsXQO2kWbh4u8d+yEQWfj6j1kqSDDIGCCTqvbvH3zswQIRkCHOcjGQRbXxXB9rVy9Xpe/OrU8gJwkGJel503B6GaGPLCUq0amrWmd7r/gzBZDl9Yf6cm0zdwHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anzbueIU; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-81f4f4d4822so1431484b3a.3
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 21:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769836175; x=1770440975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVecu991SVFveWbBZhAv7g6YYbwLWhpF7kmZTPpREKw=;
        b=anzbueIUVjJy9s0fxs6E6bvkYh0JV6n8Yo34BghbRCIgk3cMquDb/gCLNMdfIwXgij
         oMzrognigpYNB6aar25mIEg/rXyG4jikSDYMGJXwiifNLVhLDbF14b3KW5W2CEm2A/Ls
         /EOwiSmu6TUbrwppu8HzgY9LtV8bE6U3F72PZJDJSMzDlNM7GqNbepZg9GYlOlv1eYjQ
         2PngI6NXdBc2ac3r9E8IfWl89PgiJlR28OH1ogsTUARx20sL5Ui5COHXrYAXNSXEONhx
         tfvXLck/vBq+cZ5YBzSZPxfNC5ZLvY1L4T5ebMFSQ/FftQsEe5t6sr8ZCWZo2KcM3iBQ
         BcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769836175; x=1770440975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QVecu991SVFveWbBZhAv7g6YYbwLWhpF7kmZTPpREKw=;
        b=p6TEvV+hF3hYw0nGWu6AOv2qEl5gHwlmN90DhIyF91EyXLbJeG8toFeRm7/wJhU4Hf
         8CutXgs7+dSFvBdhU6M+GqF1eYgh/Ny1bSrhq04dSmGwBPeJ5mwxehwZvatGjuglmKtR
         tG7jc/I1mhihtPtyRf8nKYzKPVk10ZoZI/nzFbhQQZeLlUlUhtjhew5bwgm538IrgYcd
         yzwrfUbhINLnJ1Wged67/aJibeUbarVwo/qr1B2paYIZEenL4MgFQpGAmALTBblL2Kvr
         /8lJGfuhYRdsDNBvU8jiIfVHbr5L19t4GhSjhBUEGcMCPRMeZE/xrh7PveSzwdsTO85c
         9T4w==
X-Gm-Message-State: AOJu0YyvGubkn4KyqBAUE42218ImQG4YNk44Mjjnwhgd7khd6yCm7CmT
	Z+R9wtmcpBvR61mSTw9Gs2FRKz3urJUfAzolRdM08XZFGiEl7qwhib9Q
X-Gm-Gg: AZuq6aK85MGQETsr1Zb9xZ1z7veTcTUY65ngSxlCBvKXEhJSl1YnI0989MKTTRCwv6N
	XeWova1+mxxyojyUPTNutjC9EXuH0B/OPm/yJjO0zeDNU1juaqpY7g5tJGmLUN2O8ln36A28OFj
	AwIkG51GLq7gredKTeCOW26p7H2HB2PHp1whF+h37mBCh7tUnmSlL8Dv21sMPBqgBNyItHyr5iK
	ynHaFgJ5clH4zJcP+nKuuFdNpUMruMau/37FI8RJcYrRQVANDAbSAod5gS4PJbhPsL4rP8/u7KK
	jZHfM2d4ViOwKWzszYvXLxBuryjjNkgoEZWUlwNW/DoQ/3ZlDNOS2LGeM/chCEmOPCxkt0hcY8j
	Iyq65e3sJQXktz1SPJnAzCG7PZ58LzHM/FGGveHaHCi9Bb9KdnvlpsABKcBkH2xKvt5gBiBT3pz
	+D
X-Received: by 2002:a05:6a20:2d0b:b0:38d:f084:e349 with SMTP id adf61e73a8af0-392e0143724mr4623459637.54.1769836175397;
        Fri, 30 Jan 2026 21:09:35 -0800 (PST)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c64277e4efdsm9123359a12.3.2026.01.30.21.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 21:09:35 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 12/16] selftests/bpf: Update sk_storage_omem_uncharge test
Date: Fri, 30 Jan 2026 21:09:15 -0800
Message-ID: <20260131050920.2574084-13-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260131050920.2574084-1-ameryhung@gmail.com>
References: <20260131050920.2574084-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255356-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E4E95C0B71
X-Rspamd-Action: no action

Check sk_omem_alloc when the caller of bpf_local_storage_destroy()
returns. bpf_local_storage_destroy() now returns the memory to uncharge
to the caller instead of directly uncharge. Therefore, in the
sk_storage_omem_uncharge, check sk_omem_alloc when bpf_sk_storage_free()
returns instead of bpf_local_storage_destroy().

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/progs/sk_storage_omem_uncharge.c   | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c b/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c
index 46d6eb2a3b17..c8f4815c8dfb 100644
--- a/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c
+++ b/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c
@@ -6,7 +6,6 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_core_read.h>
 
-void *local_storage_ptr = NULL;
 void *sk_ptr = NULL;
 int cookie_found = 0;
 __u64 cookie = 0;
@@ -19,21 +18,17 @@ struct {
 	__type(value, int);
 } sk_storage SEC(".maps");
 
-SEC("fexit/bpf_local_storage_destroy")
-int BPF_PROG(bpf_local_storage_destroy, struct bpf_local_storage *local_storage)
+SEC("fexit/bpf_sk_storage_free")
+int BPF_PROG(bpf_sk_storage_free, struct sock *sk)
 {
-	struct sock *sk;
-
-	if (local_storage_ptr != local_storage)
+	if (sk_ptr != sk)
 		return 0;
 
-	sk = bpf_core_cast(sk_ptr, struct sock);
 	if (sk->sk_cookie.counter != cookie)
 		return 0;
 
 	cookie_found++;
 	omem = sk->sk_omem_alloc.counter;
-	local_storage_ptr = NULL;
 
 	return 0;
 }
@@ -50,7 +45,6 @@ int BPF_PROG(inet6_sock_destruct, struct sock *sk)
 	if (value && *value == 0xdeadbeef) {
 		cookie_found++;
 		sk_ptr = sk;
-		local_storage_ptr = sk->sk_bpf_storage;
 	}
 
 	return 0;
-- 
2.47.3


