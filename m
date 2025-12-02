Return-Path: <netdev+bounces-243261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1339BC9C5C4
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 18:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D65574E01D4
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 17:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC1F2BEC5F;
	Tue,  2 Dec 2025 17:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vjmu1rLz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB161F91E3
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 17:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764695779; cv=none; b=kDct/DwRFz7yrp+aUub2Aj9JIMGYtqknIcYsGtqBULwXgQ1zkuhA37CzNHWsEEUXFS6d5Tr57iXYnBV/6svevKGh4zzcHV4riZGHt25UYmSy+XTurFUrBtnqyEU04WEUZK2qbbM/x00q7spZmWjZ/LKSzvdggPz0LO/Lv362EIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764695779; c=relaxed/simple;
	bh=17Y0XO27mmu/toiuHtUHAQq4bly4uft3m6Xn1TFd0uk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rLvMRnmth6ROTZJsHovYsZ60x/Q+4AIZlyJyMQCjY151YYkdEs0PiVqkdOMjsbu0ac6LX4x4MPnx+YO10ybv6nB5VtyDCM4xKXLk6IY0xcPRAVZ+yh4gGALhxgCR+99wV4z5jSlB3HIdUq7yMnyd7MZTtKPm4mwl1f3gnx6s3GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vjmu1rLz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-297d4a56f97so83060955ad.1
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 09:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764695777; x=1765300577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KX1cJ0mYzITSZGbbk27b8/+sceC0x3Oa5gy+iqIrAiY=;
        b=Vjmu1rLzdmS9MJWUSL5EgiBheJyaCrjLmL/Jg/hLKDaU7c3hFZLchi7P/ReiByTApZ
         mZBbVqUZETrcGbWlKMVhoeyMa/RJZWXSBK90fK4Wfc9n1dEdeGqhBAg3GDhTq4eAi12G
         1AELN6WuZaR10VHPlTAwwnma7hiniGfUNN5MraiEC+v0SYBv+wGmqUevN/EPqsVAyBGe
         8l0OGaNWSSPOde+NQSdMircaUAfTEZF4IcjK10lJADcbITDyrdbfHulJ/YUM3tebw3Q6
         PwfUy+nfAKnSTpLyLWtZmmAM8DlBRr/3Yb56YbRYpSX4L5abhrZBArdA7ZAyQAIcKWU3
         2Yfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764695777; x=1765300577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KX1cJ0mYzITSZGbbk27b8/+sceC0x3Oa5gy+iqIrAiY=;
        b=VMGzii+/KQOwGq2eisbaSL8A6tljtCU36QE9hF9M+yc/VtoEAemfUAMt2q1lJ4VnD0
         8vrQY+Qavj1524xavd3rBBSSTXv7f9XLNPUVjJJMdcCbwhiu+a4Y9wVNVUeyiXfjd/4N
         FRTYWJ+WM7XDpNtrYybidNimD6yFz/9IL7Bb4XerXKCriLO043H7oSgMawU+IJp2Ys2M
         t90yxhBHIliiVDvwOOF2joPAI2tfzG+3y2eX5aaqCD/RJdZHhzo6TPMiNTYTL/wYc0KA
         Jf0SAd3rL+SUWhp3heRcb4EtFn4MwD8wntt9k3Gz1zPcm9ENSxuDY+ZXBRcRLlDjutHd
         KUXg==
X-Gm-Message-State: AOJu0Yy0F4bPDeTNRDW7dhQ+nHpBAzbtldRHw87V9Xxphnj+D175t2XF
	umgSG5Rj9ETBDVNlTTKlPQ1XF4syUNPUioFlbmN3CH7CVdBPN+i9YRAA
X-Gm-Gg: ASbGncsZQVjNMPGdCmuEuxr4DOO8oGlM7AQ+82OH1hkNQ+6DyNS60YWmjEEgxMeIX6Z
	Vl4bddDj1df49hsOwnCN1PM7/ylCDWNg7y9kFIDABDG30msLecXfe94hWyR6/dDqyQh9aqF1+2X
	fKwWlT0rN3SaaxreaaX1SfyiRcBEoR8fu1lrZ9fG+QY2B6r8nC2O70fi4avQQp2519/gQhvLkVT
	FC+VN8voddTbguP8ZkN47XGs+P39a7fIWM/dy/Ljt+FuSxCuaw+cp7b/OYPlFl9/YH/naX/0dmT
	ym66EcM2LEelSe3Xk9hc5s3fqVtMdWapEAECaWktMURrazkrKM7ZH7Uo4wyLkMHTmoN48uNrqNP
	kk4gN4RY+ZPvt6zGRXwmphzNqFBWFFSZ7xINnguVTANKAaXPiwGbL829Vr6hYmOXF/1D7N7sm59
	AagNn3j6ed+0PYZw==
X-Google-Smtp-Source: AGHT+IGQ4S51Vrai9feiSZx3qMe+rSfhtsa7eVXTEMovritIaLvnqt55H9woOkQykXHGkDwIEWy92g==
X-Received: by 2002:a17:902:c94a:b0:295:fe17:83e with SMTP id d9443c01a7336-29d65d0912cmr470515ad.19.1764695776677;
        Tue, 02 Dec 2025 09:16:16 -0800 (PST)
Received: from localhost ([2a03:2880:ff:19::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb276a7sm158074465ad.48.2025.12.02.09.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 09:16:16 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf v2 1/2] bpf: Disallow tail call to programs that use cgroup storage
Date: Tue,  2 Dec 2025 09:16:14 -0800
Message-ID: <20251202171615.1027536-1-ameryhung@gmail.com>
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


