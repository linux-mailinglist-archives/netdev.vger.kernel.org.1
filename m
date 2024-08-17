Return-Path: <netdev+bounces-119428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D42169558FC
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 18:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D2311F21943
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 16:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAB015572F;
	Sat, 17 Aug 2024 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9K87ce4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24B615535A
	for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723912524; cv=none; b=Hi67/A+AVFhYJAOrHJh+uP7iihU9/XG2KaDBmFM9YaEoK92IO5vS1dB8GKBi4Ic160KCCG5qop8kdLejFZATQFGd1dujrIVIhUO0NX1WkTqijPLNL5U9HgnVVz/aqEXkce49tSlgE2guxhcRadEvIyviGoORZ1gQ3FcT/MszIGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723912524; c=relaxed/simple;
	bh=1/9KQ8wnj51hRyT1CcTkFFeJSIPzinRegrHEhCI2kJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OAuwvbxkwUpb4GX72f0efARtfe7VgVYHsBwcojuCtJEnPYAQ9aYhQ6AoFpDeK5aOviRkviy4/IVWFdeVKW2eRo0xQbCQPw11k/TNehxGX/lGu6rXjiN54FhxovT5hrYDTe3Xz39P5+NIu4oXVOpMCWPyYUrC26k2rs02pJIKM/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9K87ce4; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6bf75ed0e0eso14341886d6.1
        for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 09:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723912522; x=1724517322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WS7N6RPOD0Ok7qOs3b3gud2gCuVQz8sQs3a4FSFKrW0=;
        b=O9K87ce4A1yWOpHH9rSfYESBjBbTliilUwuW6esebD91EKRFdmYxKhYjS8NP09yIv9
         dUdXrcz3rXopF7hNUal/w7sLFmWhN/Q+z0RabiEv6rHWowQJ6I77VXUrX/IgwmuZXnbJ
         3kHrtnTTaaCvvE3VytyZW3YOsNoZP0VUOwN98IXjFaIchI88m7OHgV1FQHNHlUWBzODw
         u4pYzCRVoI/2/T6CtooxJuWvAToW//SjL6ugMefadSbzdWCwgW/H5P9hAO4abzsMJz/n
         2RBpEBrnmh1iICPuYghOnRCqqRvrlYeRAMD2PZFFMr7aFnqoYk7WhcHWOwXZ3gyZDF7i
         Rx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723912522; x=1724517322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WS7N6RPOD0Ok7qOs3b3gud2gCuVQz8sQs3a4FSFKrW0=;
        b=L48C5FZauUC3zQXiU94bFIswYngCoLc6AwKg1NPcL9FX25XPtuQ7ACHCK8SeTH7mFI
         xYSRwjGSjCwzIlVuwUZfqRzsYn0e7JpwBL1VKlCfSGl+0/1uKbaXo7qNwz1WFRNqyCtM
         k7Qw+1BzxO1dF5kskXaAvE/qn6nAX+ckVYDP6lGir1bUuSDSf32nhbmUrt78TpknhCMM
         iePLS6aeSaRv0jbV7ryhgNZLo22nwrC3w3XfwhlF7vcP/fS3UCuNajYCH16vOInPSr2O
         u28Xp635/aH+dsPezosmQyBq5yGFnIqQwuBtR77XF8eTPIQdRcDpKC6S8HmhycaBUmEQ
         fRGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeD3jqPXLVqJHIAROLnWYkQPVMZvP6h3gI2kSLmovwK2RVHWMyOf2vf9Xts88AfB5IjgT5XP3N0ykLnbkBydfbBo5IyLit
X-Gm-Message-State: AOJu0Yz0IU6sXZG4td8L+J0aFdTWT4/j8iyWOuJuBeDBRaC9oxT2U/ih
	F2k4mvbq9GaVh+X8EmCOKVrF3dPvRSX0MjXwRrDFLrbMKRIq//mk
X-Google-Smtp-Source: AGHT+IGtR/M5s65KHYKhziebDGt1l4uc0mB3I4muRJHqmFssuuOYCqHPjjHKBuRcrf1y79/PWA7iWg==
X-Received: by 2002:a05:6214:2b87:b0:6bb:ba0a:f4a5 with SMTP id 6a1803df08f44-6bf7ce0fcfdmr70914046d6.33.1723912521640;
        Sat, 17 Aug 2024 09:35:21 -0700 (PDT)
Received: from jshao-Precision-Tower-3620.tail18e7e.ts.net ([129.93.161.236])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fef242esm28319406d6.118.2024.08.17.09.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 09:35:21 -0700 (PDT)
From: Mingrui Zhang <mrzhang97@gmail.com>
To: edumazet@google.com,
	davem@davemloft.net,
	ncardwell@google.com,
	netdev@vger.kernel.org
Cc: Mingrui Zhang <mrzhang97@gmail.com>,
	Lisong Xu <xu@unl.edu>
Subject: [PATCH net v4 3/3] tcp_cubic: fix to use emulated Reno cwnd one RTT in the future
Date: Sat, 17 Aug 2024 11:34:00 -0500
Message-Id: <20240817163400.2616134-4-mrzhang97@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240817163400.2616134-1-mrzhang97@gmail.com>
References: <20240817163400.2616134-1-mrzhang97@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original code estimates RENO snd_cwnd using the estimated 
RENO snd_cwnd at the current time (i.e., tcp_cwnd).

The patched code estimates RENO snd_cwnd using the estimated 
RENO snd_cwnd after one RTT (i.e., tcp_cwnd_next_rtt), 
because ca->cnt is used to increase snd_cwnd for the next RTT.

Fixes: 89b3d9aaf467 ("[TCP] cubic: precompute constants")
Signed-off-by: Mingrui Zhang <mrzhang97@gmail.com>
Signed-off-by: Lisong Xu <xu@unl.edu>
---
v3->v4: Separate declarations and code of tcp_cwnd_next_rtt
v2->v3: Correct the "Fixes:" footer content
v1->v2: Separate patches

 net/ipv4/tcp_cubic.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
index 03cfbad37dab..2d7121ca789e 100644
--- a/net/ipv4/tcp_cubic.c
+++ b/net/ipv4/tcp_cubic.c
@@ -304,7 +304,7 @@ static inline void bictcp_update(struct bictcp *ca, u32 cwnd, u32 acked)
 tcp_friendliness:
 	/* TCP Friendly */
 	if (tcp_friendliness) {
-		u32 scale = beta_scale;
+		u32 scale = beta_scale, tcp_cwnd_next_rtt;
 
 		if (cwnd < ca->cwnd_prior)
 			delta = (cwnd * scale) >> 3;	/* CUBIC additive increment */
@@ -315,8 +315,11 @@ static inline void bictcp_update(struct bictcp *ca, u32 cwnd, u32 acked)
 			ca->tcp_cwnd++;
 		}
 
-		if (ca->tcp_cwnd > cwnd) {	/* if bic is slower than tcp */
-			delta = ca->tcp_cwnd - cwnd;
+		/* Reno cwnd one RTT in the future */
+		tcp_cwnd_next_rtt = ca->tcp_cwnd + (ca->ack_cnt + cwnd) / delta;
+
+		if (tcp_cwnd_next_rtt > cwnd) {  /* if bic is slower than Reno */
+			delta = tcp_cwnd_next_rtt - cwnd;
 			max_cnt = cwnd / delta;
 			if (ca->cnt > max_cnt)
 				ca->cnt = max_cnt;
-- 
2.34.1


