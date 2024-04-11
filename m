Return-Path: <netdev+bounces-86848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A93C48A06A7
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 05:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D9C02876E4
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 03:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA1213B5B0;
	Thu, 11 Apr 2024 03:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8k+uRwT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C962E13B58D
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 03:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712805904; cv=none; b=JbnO7sjNj7MOrGKpTBP3IwjBquaBPGt+FAM3NASPqGgwjE2Qvek491QXIBMot8xymJNYKTbX38kzcbmtPcUZpuGrKNzuZ+uSYNJwz7dN9r9DG0Q5kljTI+EsfJXcr3HUnfHZyPzzY4V99+r+kxZuEj8/ugAx6fZNPqVLknC0rlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712805904; c=relaxed/simple;
	bh=a2c3mHxOwYYTj5ABhp9GgOQVw6Q+kweNulRGkYlddDs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DH/umZedtMJm2hz7Qz0AHUmr/5TxxgrlaX1poEgpqwSXS1OiGGfpnfK20VQlWvvCzcQIruVteAyVzYrfTrZUFG+6UgjVJoDejNC56RlxyW0JyeGSJ86TtRAg417VpAQaMB/9JGPIsivW7K0PjNBEWSw7/4+jeojd/2fb79KT1Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8k+uRwT; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ed2170d89fso305523b3a.1
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 20:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712805902; x=1713410702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vhf461bAQwHmd8YNl/fNLyCyx+k19WXNVS/1m3J2OR4=;
        b=U8k+uRwTNvjqLK967eywigI0YfOEwAv70P5e75dRtJpyD2i7jLOCcd0SE5hlyKz9Aa
         QCdCHMK8KhCe2ZuF8Kp6gPLBhotYoEfFSdyqEJ7T08477PfjMj6TA6rDTzC79xPRWhZd
         YR7grlHr1Qiq4pIShLh6HndbhbJu+eVhnk4RVVdD0Pg8XdQuWOfOd2S6UbFqLQWC8Xvq
         F8cO23AE6OVKFuWdOj84mbAAMxFrkBvdvAHmnbJw9ObZKMj4egJ/RxtmSjaHbWJcW+pB
         gd4OmvxlniwP95fgnhhjoVTuwkK/FpcYtOUnpzVdeq3TEU61hXAd5o+XrHSo4AZfK6eD
         moOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712805902; x=1713410702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vhf461bAQwHmd8YNl/fNLyCyx+k19WXNVS/1m3J2OR4=;
        b=FLIXeGkFTlf39G4ZDI3IaQAPvraKlHoFM+tMNLljz5XKcaJLH9GVrPf90gFqSWpJc7
         QZmIRT0kE3cZqZ0Xwmkt1JZLR6YLsaztoa6OncBaoN90iIyhf/A+RY0m6p4+1GX5PoiD
         KMV8UpnH8dmCQSUghxXp2yulKGhjp8b4vor4IV4JaRTj/uYRHXl0gJov/CPyWVfm9reF
         W71mYb+ukYxHez61w/q3rmltG0afBDSsbNv9gtgixRNfApsKhPMEI31HWGuYUgqSaMnr
         3M4TigrE45CgblkAomL2Zuuc+9oGlHHx2TzSCh8jRfhuRGHcy8Il8N9vvlDsJKvOuVFe
         EYYg==
X-Gm-Message-State: AOJu0YxurcbPbe4JqQK8u7q6z2AQTdeH4IoJf5nRHRPSajfiWA3ROgZK
	27i6vE9sywfdWo8lP7HKarn00lk4rsqkaBWYLbfr5lvxmJfeZyKx
X-Google-Smtp-Source: AGHT+IESEbbvqIDYd0OqF6E/AGOGeIOYd+sjkynzNNSmoe9DnTfefKf0iZ1l/R4TB+aFfgNKLfN01A==
X-Received: by 2002:a05:6a20:918a:b0:1a7:97dd:d800 with SMTP id v10-20020a056a20918a00b001a797ddd800mr2033452pzd.15.1712805901943;
        Wed, 10 Apr 2024 20:25:01 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id fm23-20020a056a002f9700b006edcbbff2b0sm378572pfb.199.2024.04.10.20.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 20:25:01 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	pablo@netfilter.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	horms@kernel.org,
	aleksander.lobakin@intel.com
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next] net: save some cycles when doing skb_attempt_defer_free()
Date: Thu, 11 Apr 2024 11:24:50 +0800
Message-Id: <20240411032450.51649-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Normally, we don't face these two exceptions very often meanwhile
we have some chance to meet the condition where the current cpu id
is the same as skb->alloc_cpu.

One simple test that can help us see the frequency of this statement
'cpu == raw_smp_processor_id()':
1. running iperf -s and iperf -c [ip] -P [MAX CPU]
2. using BPF to capture skb_attempt_defer_free()

I can see around 4% chance that happens to satisfy the statement.
So moving this statement at the beginning can save some cycles in
most cases.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/core/skbuff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ab970ded8a7b..b4f252dc91fb 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7002,9 +7002,9 @@ void skb_attempt_defer_free(struct sk_buff *skb)
 	unsigned int defer_max;
 	bool kick;
 
-	if (WARN_ON_ONCE(cpu >= nr_cpu_ids) ||
+	if (cpu == raw_smp_processor_id() ||
 	    !cpu_online(cpu) ||
-	    cpu == raw_smp_processor_id()) {
+	    WARN_ON_ONCE(cpu >= nr_cpu_ids)) {
 nodefer:	kfree_skb_napi_cache(skb);
 		return;
 	}
-- 
2.37.3


