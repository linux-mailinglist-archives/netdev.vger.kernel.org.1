Return-Path: <netdev+bounces-188534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C059AAD3B4
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 05:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6514C80D6
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 03:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F64218B46E;
	Wed,  7 May 2025 03:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TV2eXFpf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A1D70824
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 03:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746587305; cv=none; b=JLpQKjBhixtN9X7ekCpRL/DFkx12+Tgn9pXuqgttGytwW7icOx7XAY8HaOxLTSwTeIuiHjFyb7cXA1V1izorjwQlt9LecP9at94U9nzgsUxR4pqaYvq/V0h8AK8ejAEsLTcv1noQ/koVNmTijAABrDYSzDCKEckRyYXAnHVmErg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746587305; c=relaxed/simple;
	bh=27a4QIVw5q+PWygKH4bsHdNMq/OHqSGzPJT2igNGZGk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=curM5NkAy0EfpJbFqwHXFPDOe8ZfQOa9+NT1vyYO1lX3lysRQDMxJKzunGOFeMDYbem9Rn+O+qrxiso65D8BHO8GPkwYXWbzKHY+Varse/oal3yT0ZK85dMZC5F3Hb2QnVRGNKHbFmriXvWG+vMieglJSSBbLRWrcK9LG3no6hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TV2eXFpf; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22e16234307so4264365ad.0
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 20:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746587303; x=1747192103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nv9JoAvWs6gTM10vR8jVFYgQgKlyEZzVUAlrgzpixKg=;
        b=TV2eXFpfZpqR286uvupNvq1R3bIgy1959GgVy5BtvGcO4NoCbjVvr4NkeeN4nbAdPZ
         B2GO8rsfL4cTUCpxi37pUz2qXCHdhk9SNSVhF+RwJDN5FrJosnrujuK0xCE0m4C2PPIX
         4Y9CqTigjwW/HTw6s1DlJaWLSca1YldHEublAd35X5dyCtIGCePRbYlIbGryiEcn+16X
         pHsUbS9Dvkbcqj+Fc99CPKZ5MDS/DDIjRruTmUBiXJgsLhK8Ita4COzd301ap+OV4y4J
         5lUWNO2/qRqs5F2kstwXuA2DUHOCljP281XqT7NOsTt1hubpDcdbJrakGbqIIpM5p4fo
         JpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746587303; x=1747192103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nv9JoAvWs6gTM10vR8jVFYgQgKlyEZzVUAlrgzpixKg=;
        b=gLvuinUmQ39RjCIX2gL6rVQutA0svSY+l/LVDc3MfC6kcoCOpUTDtExfqCZGg1keXi
         hMArcUb7UjtZvAheSWmIENj0Em8cs5inVD8jjoOpqQ+AfpwX/g5oxINXgkQdFH7E7cG2
         A0QdiOE72Wq7ImZ27uwn1O17gD4yKxCCv1IW7X4VeMmVVKd7jo4A5VWThV+TIE36eIAJ
         jdbD71oT1wLpJ1lomu+8Iej71GRmI5l8Tmw/9Rm252Kxr/ydIlsR48cdzRbuc+pgrlgg
         ArExElOOZYyMsH1+eVNkSKaxYOmf1uPutfz+Vp99tSL7kuAs7ibRdq0Fsv8tzc6w52Qj
         AyZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVu1vrfNaBolJFgGkwdkeEeJamIRqtFA2HGb/QxP5ZqOfgMhg9QwCusc1LmVkxz8RYhgjBml4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXhdNWQt/1EfKuOtrY4oJrAmZ0wF+490ieVOwppKvjlhURg8Mk
	q0dW1r0rHgjrX/ltlngNkSogJzYDMJrMQS/Rg6tESj2+HJYFRtGl
X-Gm-Gg: ASbGncvAqvSyk+24v2giKesfvjwvsVKrqU7+hdx+l05qyN8LQHph449rgJdnpgSYcUN
	QwY1s7lCrSs22dYzWs/60JplH8YHQwDy/HN4QWt+rC89omX/vjwaVXZtHyUg8uOzzATHMZNpdY8
	hJjwnopu1ay7+05BfK3Z4oby9BlM0lYcKxst9fMLi2Sx26CguXLokSjiCs1qfMyFT4EWFwcq0WV
	5uMEYQ1cQw1lfd8tu7Syg3zqVP8q5Np5kbuVHzyFbp+vE/Q2QV7qgze0gm3Tg3v1l47DvK5aCQf
	FJoSPQ/4GVb3MSyi/Ro3gbDmO5o3DVi6p2PQyWlRronA+DBxRsbkN1dGXwwoZJ662c1geQd709k
	wCLqo+PafZwbM
X-Google-Smtp-Source: AGHT+IFwYs6I2Pfw7TuHODJ37F+9pTjMgxsBR4zPK+jGG6IHXPad4Qe4x81SoqSnB1SFpNl14YmD9Q==
X-Received: by 2002:a17:903:1ab0:b0:215:58be:334e with SMTP id d9443c01a7336-22e61695c71mr22640025ad.10.1746587303170;
        Tue, 06 May 2025 20:08:23 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15231fefsm82496035ad.210.2025.05.06.20.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 20:08:22 -0700 (PDT)
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
Subject: [PATCH net-next] net: thunder: make tx software timestamp independent
Date: Wed,  7 May 2025 11:08:04 +0800
Message-Id: <20250507030804.70273-1-kerneljasonxing@gmail.com>
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
SOF_TIMESTAMPING_TX_SOFTWARE while SKBTX_HW_TSTAMP is controlled by
SOF_TIMESTAMPING_TX_HARDWARE. As it clearly shows they are different
timestamps in two dimensions, this patch makes the software one
standalone.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
index 06397cc8bb36..d368f381b6de 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_queues.c
@@ -1389,11 +1389,11 @@ nicvf_sq_add_hdr_subdesc(struct nicvf *nic, struct snd_queue *sq, int qentry,
 		this_cpu_inc(nic->pnicvf->drv_stats->tx_tso);
 	}
 
+	skb_tx_timestamp(skb);
+
 	/* Check if timestamp is requested */
-	if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)) {
-		skb_tx_timestamp(skb);
+	if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
 		return;
-	}
 
 	/* Tx timestamping not supported along with TSO, so ignore request */
 	if (skb_shinfo(skb)->gso_size)
-- 
2.43.5


