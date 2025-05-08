Return-Path: <netdev+bounces-188873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5716FAAF1CC
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 05:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DBE59C8668
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 03:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B741DF99C;
	Thu,  8 May 2025 03:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PW567t5A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97484B1E7A
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 03:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746675882; cv=none; b=Ue8vhT3lTiXoTGcMoNzih6A8lOcj9rdSHTTZK/8MkYXzlvu60SXk7uME82Kb9zXT/bxTKJAHgb69QmWBGdoR+siPjPPm7XEHl15gpzeQK7F0YEzUnyaOMHdzFi6PjuT9tKRHPHweQhOSjdGewrUT0U3TfnXx5Gl7dpSBMLnuAno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746675882; c=relaxed/simple;
	bh=6G9bEROthNBgarpv1ETaM710bv7/dfeUKzq1RMW3kAI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b5SwhVSDRZ5IOLa+gTe5pV8kFFATOqKGt5s0GTY19n+8ss1V5+uruc/s6wgAWt8W+lB8fBHPv5Tx5iirzf28cTou5+0uXSnCEU29g6CWUlM2ZKF4j5SRYiqWndCXTwF78VPxMND7nqD7xDWpxUiQnO0q5J4GMsmE1Wj7MALS1Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PW567t5A; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso744523b3a.2
        for <netdev@vger.kernel.org>; Wed, 07 May 2025 20:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746675880; x=1747280680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YPjH1uIhopChcoYO7jc2DTuBKII1F75cT+E4xkKCk3E=;
        b=PW567t5AnI6Z+San4SAJ/jT/YEyF2TfSJN+XuBE5oOI+WQ2aB6f/Nk8xaklfIqF1hQ
         DRbN+bkYRZZ1wv33+nbJ44DSWrJ6R1ouTkoyoL+M33hIhPA0g3saAALnKfF4Mm4C7COq
         +t4pVQA8bS+IBOGVcroaDyMH9NvC0z0h9npVCwwlFhBHVDFqYWqY6XrXPToI4pOC3pxp
         EAN1eVVSUKHwQjWYIpkrmUOpup96Df01dEQI36/hCAtRBrGXJYV+fgig9H7A82XfAJjh
         xWvJBwTFNkOyAd0NbJfEntMtzzVS4SzoDM8lM95lT+RDZK/q/l0EFAU/A5yMwV+ZsNY0
         ExTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746675880; x=1747280680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YPjH1uIhopChcoYO7jc2DTuBKII1F75cT+E4xkKCk3E=;
        b=VuYt8BAGwbNZiPpyZTzS2bMHhvRxUN8+bpwbq9Yd7diPnJsAkFcKV9uVr4uwnY2qzT
         ewEQn0U8eM91LE8Pu2GmwH42xktkPm0EYN6OejDtKpfH37ZzUiUYV8NvD1XqWtt313RM
         5PhEmodbOWjYdl/JBxlPsNCDIjxMOa81onuvKpyR7k4PLyanwfv8Gt3DbU+DCVJauhF5
         2i8dOMpZlknFn/ySE8kQeOdy0xm3C60/Y6OtzcJPkAMvgr0lFRS43CuFQmlByMLRt67z
         cBVSW6kqcGNh2Sbm/YT6UpPbMvyKhPobPvZ879cmf+wBtIpBZfn3VfPRyPwvRxXavkKg
         vIlg==
X-Forwarded-Encrypted: i=1; AJvYcCWe4IdFVZBy0a67lI1yabdfudaCmm0kkJAuO957l7/idwN9eSl9eQx/hKRoYN7l8YK8z9hbxnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXyM4OAlRGipdS121dwrmAyhDh6G8OgR+fOenuvoms5JjV5C4r
	p5lD0R8zpSdaBPhtBWQI5ebAjQUU3AgP++HFUeXw5IHq67Fvno1tYf9/q7zOLgE=
X-Gm-Gg: ASbGncufaym92Om+QRpkALir3k4WQ6d25ZA6EC0V0GQi3IBxQZKtFPhvrKnv15/fxLJ
	agyFd/QrCrCKTrgKq/fhCKxQbdCF5CThvtJ/hZr2ZZJ1to5HmoEJooxiQiRuIxN7gsRrRU1KTSp
	3lGC2CfCOEx1HKRVsMjIbe87jLFzgFEZzF37zZAJyYP1y51soJFqNjcEWjblAyNw/i5Pdd/LrNB
	V4gJv5BYHpVoI6UWYbhve1K0qXuaGtmQTeOG+blpf4oKTGQgbWkvTGxR5gNOfKNG/BGoyoyqHG/
	xb+2six50I52UYcfndmZpSm4rMiYMaIqegAq0mrLif0i0khCj8IfuliJEcsPXRL4Fvqg476OYRV
	2ETuA1JmJsChCip3YVbMMDnI=
X-Google-Smtp-Source: AGHT+IFp0O6esA7K6jD1keIhUIbjH1nxmx0VG8UBNNcd8Fa3wvOdZuiRHdY/b56V4j5U8Dx4Ys45/Q==
X-Received: by 2002:a05:6a00:3485:b0:736:34a2:8a18 with SMTP id d2e1a72fcca58-7409cfef821mr8771048b3a.24.1746675879775;
        Wed, 07 May 2025 20:44:39 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74059020dc8sm12188249b3a.86.2025.05.07.20.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 20:44:39 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sgoutham@marvell.com,
	andrew+netdev@lunn.ch,
	willemb@google.com
Cc: linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2] net: thunder: make tx software timestamp independent
Date: Thu,  8 May 2025 11:44:33 +0800
Message-Id: <20250508034433.14408-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

skb_tx_timestamp() is used for tx software timestamp enabled by
SOF_TIMESTAMPING_TX_SOFTWARE while SKBTX_HW_TSTAMP is used for
SOF_TIMESTAMPING_TX_HARDWARE. As it clearly shows they are different
timestamps in two dimensions, it's not appropriate to group these two
together in the if-statement.

This patch completes three things:
1. make the software one standalone. Users are able to set both
timestamps together with SOF_TIMESTAMPING_OPT_TX_SWHW flag.
2. make the software one generated after the hardware timestamp logic to
avoid generating sw and hw timestamps at one time without
SOF_TIMESTAMPING_OPT_TX_SWHW being set.
3. move the software timestamp call as close to the door bell.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
v2
Link: https://lore.kernel.org/all/20250507030804.70273-1-kerneljasonxing@gmail.com/
The main logic of this patch came out of previous discussion with
Willem, just as the content of this patch says.
---
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
index 06397cc8bb36..5211759bfe47 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
@@ -1389,11 +1389,9 @@ nicvf_sq_add_hdr_subdesc(struct nicvf *nic, struct snd_queue *sq, int qentry,
 		this_cpu_inc(nic->pnicvf->drv_stats->tx_tso);
 	}
 
-	/* Check if timestamp is requested */
-	if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
-		skb_tx_timestamp(skb);
+	/* Check if hw timestamp is requested */
+	if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
 		return;
-	}
 
 	/* Tx timestamping not supported along with TSO, so ignore request */
 	if (skb_shinfo(skb)->gso_size)
@@ -1472,6 +1470,8 @@ static inline void nicvf_sq_doorbell(struct nicvf *nic, struct sk_buff *skb,
 
 	netdev_tx_sent_queue(txq, skb->len);
 
+	skb_tx_timestamp(skb);
+
 	/* make sure all memory stores are done before ringing doorbell */
 	smp_wmb();
 
-- 
2.43.5


