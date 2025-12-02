Return-Path: <netdev+bounces-243111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D1BC99A3B
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 01:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF0764E05BA
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 00:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B8F7DA66;
	Tue,  2 Dec 2025 00:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4jH+Rng"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EF11862
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 00:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764634706; cv=none; b=aOn/J0xC9jTQni2d+xo4I+nVkgp3lkTtuor7qYlXlq92hLQPuoqwAxzCQHp9+rYVzxlvcVBByX2W6rmiSLitlZTtOKRFtSFq50VcV3juNcmjdfV1ln3h7eOPWyBF1cIjUYzONdQ1aMwDbdhj8nlqC0EvfkVs9Fi6XsYIKo2MWXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764634706; c=relaxed/simple;
	bh=17Y0XO27mmu/toiuHtUHAQq4bly4uft3m6Xn1TFd0uk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ho27j2SZm7roXhcrmUprRBF+xgswnV5khSmUVpOY0GTAT9lNtUZ3T7PmD/dtPj5F+JpSEiJKkfTgwUfa5WEcOA417fl2vpAg/kc7hUnAswLC2kftkQF8YqBdf7P0cNVX1vHcSw6fN2gvaTca3f9BoKbMy7FeajQFZq5M4ujaIvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4jH+Rng; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-343dfb673a8so4562411a91.0
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 16:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764634704; x=1765239504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KX1cJ0mYzITSZGbbk27b8/+sceC0x3Oa5gy+iqIrAiY=;
        b=A4jH+RngrnoCPbMi0D6r46GjcUKHhhB70f4gRKnwM9Y6YGi3ahDGYCR1HYc6AbM9Ne
         sG1wj/zbOCCFRqUWCFl7qToWJAP1RlK46rmMAYWwPtNvBuaqCcv2EZq+9ckRJd6fV28u
         gqR8xacu39vKglJRUuSC/grPqLYHqCGmwejohIsiGJVZeYsaFakG83Ih+Y/hn2seSx8h
         XzDDczQLq3wZHsoD1VkD+sAeYeANkin0wse01a/++Hdqv8ld3JWOCYMVUncJbS2WB9Hu
         1O6TaIJ+QYfllA8xOuvQU3T/dKK7JyHzjFoyxsF9Rup6FZzWeTaBrYfKbdiw+kqdLBCZ
         bK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764634704; x=1765239504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KX1cJ0mYzITSZGbbk27b8/+sceC0x3Oa5gy+iqIrAiY=;
        b=VCG1KjQ3p98ztM8VuOspAiP4v0ul548yLjKJzkdCAhSkrrtLOK4J1VN15I/1JPMnI/
         XEGzrIPUiyE+/khpYBxi9OLIs7DQOOtQlSjZcdcLzxMxgglwQ6uPFdIFMSh8i5ppwybO
         5g08VKLWEwk4WwEKCMb89OWclXMTKImMW6HtPzcRYaRq6RgijQA7Pagkswnd7QwQIgXU
         2BqP7RA2PSTMBAVMhM6aa1U+xGgU0YpKuIYt9efIDJyv0UPKV8GMoWgLhAvAF2mnElR2
         X2MHH2Gun3GJ+NpCeY/yOsa4hK3wyAyDm6P1uz/KYibUve85ZOg8avJdoPiYZR/px9sw
         rQ5A==
X-Gm-Message-State: AOJu0YyA9CVielkZJqWs2Nd3PQ8OwxqQC+28hrurTzKBq/DTwv16IxjZ
	U/OEIkWKEyuAUvtxNfr2d74oqoNz1Sp1omvZsDaNSkIMtbS7YNKiRUGb
X-Gm-Gg: ASbGncsGcj7ORwKgg2Wlgn5QyS5jcmyyH/h7IUGw9C1uIWEAYXZhDC08XdwoZbo2AGb
	rc9gzCRZliVvCeGbgKyh+EyojeVHSpVpPe+CRVFJAhu3cTZvSDlJe0P97t+UwcpOYQ1XmauvQ+p
	IPOYvodTo+znvBLF6vdO9ynB5YuFSINeX+1hi9GPr2KugbnJMXAZEoP5WoXE3joD8D8cCCdb/4J
	Y/7+QTEEfyUf7RtNf/RWNsbApRZ5DB7KymTCXpXm9tKd1XgkZfOSJ2btw/MjB2XSuf949e2zxcA
	jWFtqfqN2z39Ep1jq6DpeojV7A54cxJ77R/Mz1jp92emEAlO94nCwV2ktcK/I+18ciCgclHl9dK
	NSJ71gyziaDwXT9+IX383EhTHnE7Cq4Nw4hpWS4uU6uVs9N/HvP7r8H6HnGMstxrknhnJdUYrO9
	1udOQsaGgUyfcWrkyYSyGGipg=
X-Google-Smtp-Source: AGHT+IH4dLWtTh4n6BdfJP0hLtpUWMqzqkCsnBXTHIBXy8i7imPPh/miYdB03uTe0kgJz1dUZcfrnw==
X-Received: by 2002:a17:90b:544b:b0:32e:749d:fcb7 with SMTP id 98e67ed59e1d1-34733e786f5mr36537212a91.13.1764634703577;
        Mon, 01 Dec 2025 16:18:23 -0800 (PST)
Received: from localhost ([2a03:2880:ff:e::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3476a55ed00sm18000824a91.5.2025.12.01.16.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 16:18:23 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 1/2] bpf: Disallow tail call to programs that use cgroup storage
Date: Mon,  1 Dec 2025 16:18:21 -0800
Message-ID: <20251202001822.2769330-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mitigate a possible NULL pointer dereference in bpf_get_local_storage()
by disallowing tail call to programs that use cgroup storage. Cgroup
storage is allocated lazily when attaching a cgroup bpf program. With
tail call, it is possible for a callee BPF program to see a NULL
storage pointer if the caller prorgam does not use cgroup storage.

Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
Closes: https://lore.kernel.org/bpf/c9ac63d7-73be-49c5-a4ac-eb07f7521adb@hust.edu.cn/
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/arraymap.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 1eeb31c5b317..9c3f86ef9d16 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -884,8 +884,9 @@ int bpf_fd_array_map_update_elem(struct bpf_map *map, struct file *map_file,
 				 void *key, void *value, u64 map_flags)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
+	u32 i, index = *(u32 *)key, ufd;
 	void *new_ptr, *old_ptr;
-	u32 index = *(u32 *)key, ufd;
+	struct bpf_prog *prog;
 
 	if (map_flags != BPF_ANY)
 		return -EINVAL;
@@ -898,6 +899,14 @@ int bpf_fd_array_map_update_elem(struct bpf_map *map, struct file *map_file,
 	if (IS_ERR(new_ptr))
 		return PTR_ERR(new_ptr);
 
+	if (map->map_type == BPF_MAP_TYPE_PROG_ARRAY) {
+		prog = (struct bpf_prog *)new_ptr;
+
+		for_each_cgroup_storage_type(i)
+			if (prog->aux->cgroup_storage[i])
+				return -EINVAL;
+	}
+
 	if (map->ops->map_poke_run) {
 		mutex_lock(&array->aux->poke_mutex);
 		old_ptr = xchg(array->ptrs + index, new_ptr);
-- 
2.47.3


