Return-Path: <netdev+bounces-245423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F28CCD0FB
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 19:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EF843022184
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 17:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373A430F53F;
	Thu, 18 Dec 2025 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRGWT/6b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BE330DECE
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080607; cv=none; b=M3ay7AX3XB+hX9Z4L9cuw1N2A2wXHmIvKyQUwiz3sAOBaw7g59ofyCibxY5dAD1kG70e1T8tPLDe3qNI3ib+4nldrYAV0AF81IWfwHyAqiDEKtXsSg0oAAK3Ebi41yNQgilAH79wQTZcTYKoFX3ThJHXPMsjozJIdu29w8DTCQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080607; c=relaxed/simple;
	bh=3iS/7iavCieY0vGjt3CSw+m+ZHXLXWxjaSalApUkmvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOGu40s7bpvx4uTLRB5jB5xYlE5FGH19W7El6gulam7boFJks7aCgpNIdRZFCkKFB48rP6O9x65RINe2vpuTEcMnWNJ1KsBtMNAvu2SXCQsKvwrMCztmN/ifllWMGjMN/xSbgqjNcrinGa1bmFeBxCzXld5s9CMws/nYe2H4u5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRGWT/6b; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a110548cdeso12203955ad.0
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 09:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766080605; x=1766685405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVecu991SVFveWbBZhAv7g6YYbwLWhpF7kmZTPpREKw=;
        b=iRGWT/6bXVp6BjqwoiKoSdlxjsInf+Si3IVFE6nFLI8JFKMbricklDKdYwHmFhciGa
         B3lCuP6Es1HXBi91+8uPwnpIJ4Ra0/Pa6BsXIC0PIUOaGk0kOXUNaM67vHXp+tu9OEzR
         JQxH7/O6UXzp54YbnEQsSIjUk95o4PhhJI4r24Uh3R6Vhr+t3Djqz/CxUieSXWy8gP7h
         UeZBknLt48vVFu/dSiM4OyqgsZkB/n55kViHQftCA1FDbceeO1VMxzv6D25u3BSd2vfB
         RSoF4ng1rLWJWZd+5c03x1sKtljxatiIql6tj59DaVhQNJCiTrF2/ew/TNcNg+oVpR0h
         2anw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766080605; x=1766685405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QVecu991SVFveWbBZhAv7g6YYbwLWhpF7kmZTPpREKw=;
        b=MhesjuN0rLUEaVdKK3grBows2ITpGN77/qlVtH3OnjsMbEs57CKVSLVmqw3eEh0JnP
         36wG7GfucFemICMHSfvmHnJgkNEph+RlVyLa73ZjgBNevTx86OealUMX3M1z6CPcmfcJ
         t0hdi73e4FVVB9VKTRqunLtvYlVWt3aEom7D1mlAUqQnzIxkkEEX4fCx8A3q5NY+O0dM
         4kFTsfqO3EL7v12FB7e5ry079KcTIVPnU75KZiljA6iHirXDgzW5uIR5ioFg3abkDNAZ
         pDnJ0FLPL6eDyZEFv4O/kZNosA6XUXmg4Sqx8O0lDCbyigPGMHwyXnq56DBpwKWGktT9
         HgDw==
X-Gm-Message-State: AOJu0YwoduK4mGAbKQQipgjZOzWv7GJtFqDFMPh7hhyf3X/lmqxwPGbo
	+RMdoAeUn8bbw303XZLSYSJPaRUUM+G3C+RL5eLVUsJXAjBWFmak0RfmomR58A==
X-Gm-Gg: AY/fxX5w3de016N15KypYjYQfyktQKTOnyXbDxc9oD1PbimtsZ/qQ90vhub1PeWYzK4
	Ke6k+8LB7/k4iKjjLVV3Fi8wCX7V5nUsOQBopYZ5jpC26c479SceQ0WzwB9r0a03/t0uWDXHZOp
	iir80bN192ipBKbtz8wJJkBe4QlgOUk84lhuIPwxtfnkoriEIxvcRRU/H7cFPLv6KPnT8e2dY3s
	UqsS6y6iBk344b+juqT28TerMceZ9zt7rLEG+IWDJEIgAYfsZ5jacqtOYsIP4mO/YHqxwPHQql1
	AFxeERqJkOaj7IshHrhzMVrudex4GCRXHbtmgZOYhZKhZ3TGvCiqQfdgLofq+CVdruD+hmnMA3o
	txQUtvvj3rNgiUDCh7xSap9dDV+Z2TQxiX+l+S1OK2+fpL02G0nbKwUdA69wAD6+WYOlhAOVrjx
	tys5DrX24X5oiIxg==
X-Google-Smtp-Source: AGHT+IHWv5b+Xv8jWvC4vBtqhDAaK0vV8FNZVOWNFs3M/xZtMZzQzkaj6mdLHMOymreZBYpyb8C7mg==
X-Received: by 2002:a17:90b:3852:b0:34c:c866:81ec with SMTP id 98e67ed59e1d1-34e921f0ae7mr142339a91.36.1766080604738;
        Thu, 18 Dec 2025 09:56:44 -0800 (PST)
Received: from localhost ([2a03:2880:ff:48::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70d4f887sm3103197a91.3.2025.12.18.09.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 09:56:44 -0800 (PST)
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
Subject: [PATCH bpf-next v3 12/16] selftests/bpf: Update sk_storage_omem_uncharge test
Date: Thu, 18 Dec 2025 09:56:22 -0800
Message-ID: <20251218175628.1460321-13-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218175628.1460321-1-ameryhung@gmail.com>
References: <20251218175628.1460321-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


