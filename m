Return-Path: <netdev+bounces-118409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D48D795180F
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 11:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F865B2468D
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 09:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFC219FA65;
	Wed, 14 Aug 2024 09:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="abD175Gq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C22166F3D
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 09:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723629055; cv=none; b=h6SI44wsUZl65LluhWiMOh7sNk5KqmARoNnhdiDbXqjnLa2J5P2nLuYt15iAK+M1qJrB7rRJmIIIUJ12GnO0EsJRaiU/PaicIcHOflFDOJ/EmkAFzFE0F4zUssFak+jim66OBcVUCaFXmMXMV8m8EAsS95P/yDnsAAFdKas1Ulg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723629055; c=relaxed/simple;
	bh=tvP+ymsnDMznZtXYdqtZp4WFdN7ZA4422EzK5EWIjIw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bVO0BOeoN9UivL5AI6QETYDE+QtThzcUgKMz+OKlz3mKq3BbJPM1kDn5YMyt4Z4cBbdEfdnkuGkju2Ju8O394csmGmJN5pdqkcUnL7g19jXvbEWT/g4G+XBMq90Ky9yLBRbnQZxY5NKlsEAb758+vdVljtRd4ZBvnRat8v86GcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=abD175Gq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fee6435a34so48999725ad.0
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 02:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723629053; x=1724233853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B5EPTuGtOAwR22klO2g+2qxnDn7zedpJJVEUqzrIeGY=;
        b=abD175GqyMY0t5QRmLXMLxzDWEYVa+ZKtd3tiq2ZEKf3bAgQ6ZXrcADxQNHiLSN3AZ
         TvoWSCv1KdFXbvBXu7slzOr8yJwl28twFO8/ZRc8MFabibKWzF/S+HYs75rFo22+blbt
         /nF5ePo5OKe74eFewLG6U2Xyx/TDMUa/6Zf0LbpRFGKgopMofzuwP24h+kd00M/gFVF8
         1oN/pmkEWytauuOvlN67dqGTzamEeceYsrSIKVXbEY7cdAXYP/NYcE7bmJTVXC4hhPXT
         Mhp9AzSumgeG1lIbVD9N1qCSgwhqZW+BIXsS5b3mFJYTGqNiT2f/9/lOKAiNV7xNB4Q2
         rRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723629053; x=1724233853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B5EPTuGtOAwR22klO2g+2qxnDn7zedpJJVEUqzrIeGY=;
        b=PWeIzKa41rkQU5eRyqtg4kr7M2rrRpsYR+D8QALUdUJHzFr2h/vNf41kpk7qwjq8EH
         npxKCEBiMWwGl4yRnpneJrw/ZblN3UDxk/RGGj4rb5YMwc8x64xitahzoJ4OIDaZa0h3
         ni+0120RgZXX3DhCbCqUGoHb30GkGrJ++UmpIT0l2aS5lP/UiqFOcghJPZRhexixcdWa
         mACnBZXsWCD4pT4eBzjH41lg2VB4sUL3mAhQfk0ReCe912/zlZmd4/LzvEN7+/z2+t9Z
         bWNH0FZ6B6dfaCOEsuiPx5icKJU7qW8Ul3MZxgiV9YsMYp2asYZfa8WcKetT948xNj7D
         sd/Q==
X-Gm-Message-State: AOJu0YwbKGgAtZSq/4kcy9739tUgwYMCJadj5dLcqTV6zpXSdo/9kSEo
	3Fhe5NajHitl14wX/HPMIHkSq4y+xz71mlIqmu9ip/aWOD4SAfA0x/tdzlFbNE0=
X-Google-Smtp-Source: AGHT+IGdZ9rws4GdM8SkTmW55HmU3KkZji+5J9etE7Vjg5UV/L+knVs1Dc9ulbn1Et86Fu/3Q6RnMA==
X-Received: by 2002:a17:903:234b:b0:201:df0b:2b5d with SMTP id d9443c01a7336-201df0b2f82mr5404845ad.64.1723629052914;
        Wed, 14 Aug 2024 02:50:52 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201e24b6a77sm3487765ad.92.2024.08.14.02.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 02:50:52 -0700 (PDT)
From: Feng zhou <zhoufeng.zf@bytedance.com>
To: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com,
	zhoufeng.zf@bytedance.com
Subject: [PATCH] bpf: cg_skb add get classid helper
Date: Wed, 14 Aug 2024 17:50:38 +0800
Message-Id: <20240814095038.64523-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Feng Zhou <zhoufeng.zf@bytedance.com>

At cg_skb hook point, can get classid for v1 or v2, allowing
users to do more functions such as acl.

Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 net/core/filter.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 78a6f746ea0b..d69ba589882f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8111,6 +8111,12 @@ cg_skb_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_listener_sock_proto;
 	case BPF_FUNC_skb_ecn_set_ce:
 		return &bpf_skb_ecn_set_ce_proto;
+	case BPF_FUNC_get_cgroup_classid:
+		return &bpf_get_cgroup_classid_proto;
+#endif
+#ifdef CONFIG_CGROUP_NET_CLASSID
+	case BPF_FUNC_skb_cgroup_classid:
+		return &bpf_skb_cgroup_classid_proto;
 #endif
 	default:
 		return sk_filter_func_proto(func_id, prog);
-- 
2.30.2


