Return-Path: <netdev+bounces-70022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F0B84D5C9
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 23:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F23F71C235EE
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 22:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C8A149E02;
	Wed,  7 Feb 2024 22:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="jOIhaJuE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4E1149DF8
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 22:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707344958; cv=none; b=ql1VWyhUmiPu+4lPlcgHKjlvbCEmLBN1te6luAGaX0m4A9CANBCEPKC/ZSakX/aybgR3oQEJnXdnh2wPS4dIp6eqESy4/7bblA9m/TP++1nty5hb8shDem4HFgIVEhEYlGV/+/KBoaN68s/mn6Lo1GJNm7kg0g+HH+J2JnrWSZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707344958; c=relaxed/simple;
	bh=jWrrXFTYA2qlTEJmn4JfEINOepG8t/hJB7oojj+Rsbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jnXEf+kPb2nPVc9A5IG2aOJ9K7OD0q2vRbHzoJszVLUj9mxmyZixb+Nizz8cW5HZ0iQteroaU9bdMTHd2cXAsb5StL8iwPs0uCzj2AmDvb7GaJzbuj972ziod1NR1NGaBerzHS0ijROOeNjk0eRHdn4OIjVt0qHA4uHPDgThwf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=jOIhaJuE; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d93edfa76dso10448925ad.1
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 14:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1707344956; x=1707949756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bNoHxO3QTnEPQU+LEpc9UOx3HYOTjqLa8oFC/zcCbRg=;
        b=jOIhaJuEy4h2LwAEvgtzSz4xE3tFzp21Yj9JhyLRDrIvB0LHIx293ApFDwqrNIha8v
         BtAz22n79xJRbx4Ayw5FGhtJBhOEpkTcmTb9LzYhyI/MTntuSXREjVbWLuv/NSkXLXTA
         wG5M77Xfq8YiSb54II3QZMAcAtzKolDwVe4VLpXREFCB5uwL6yKE9vHtQ8SXy0T1kiS/
         Ps8eQCrbv/WE0paleTV/ulZujr3+5PAz3rtBhmmT+Hzy8jnFOJNX9YEzlBCrSmDIZgPV
         qyVqNyy5iHYpQ8AO8tumCudIOl+HS31tnOU1N8BhaC8RsuHsVmcKvEdCU4UVcI1DMbXX
         YRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707344956; x=1707949756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bNoHxO3QTnEPQU+LEpc9UOx3HYOTjqLa8oFC/zcCbRg=;
        b=VG+8Q0JHMFUvXJyWFjB+i/yS18gARC/hnCDdA1EEvThou9eucLXfkKPBJM+ADseH1t
         ZE5ZlL5f2C4MD7SgwWA9el75QxwNv9jaWaXbOPlkAH8RjU5ASfF718dJZhQz60CbdF4N
         Mk8uGZcIwKGAEYhOOh8CNfLlfmDN/WiuNnDMDw0W+eH4MmHz/uooUm0zfFAtaXveYdGz
         eIP2iPU1UsMuJB4w+lPYYWdkDGsq1B6MCFMTW8zD0qEGO1iI3lpHzmctq6qMZRVrpqjG
         OFiqdaap72VGwnz5FnCUpyz4Zw6VzKe6JH8n4Yq6zA5BNectsdFpM0jDccQF4V7aIcM4
         tgsw==
X-Forwarded-Encrypted: i=1; AJvYcCVOyG+hQ/dGEkZezOFx+kizK8XHNbDfse3fSiaU7XwzleiDsnJjE7MMmXfEJdDh8N9MGqmkmC2AN3YTOIW8Eom1+n72duce
X-Gm-Message-State: AOJu0YxR5uLUHe2bYbpe3IFkMH02rF5zdmTSxMvp7lb4e1tyHlSijN8h
	C6IhELZfLpdmFjHVSEgdth6NVZOHj0bb57fw7c2LLh1V1sDW9aWXsDbN0ak3ag==
X-Google-Smtp-Source: AGHT+IFhuEbcZSY8PvRHNBKegRVjJkokNWcrkRJ9awOQBpXxEp/6lBzybhSIOgZ1J613+PwUEoeZkg==
X-Received: by 2002:a17:902:7842:b0:1d9:a7b9:313c with SMTP id e2-20020a170902784200b001d9a7b9313cmr4793351pln.65.1707344956136;
        Wed, 07 Feb 2024 14:29:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWfcL4IEK6ir+DSPg7bmZx/tQJXBEYmPCk+nEfB/A2aCXwIWn+Wig3XSYwJ7aFwUiNiW8cKHdwGR6jKeDIcOiYF0x/Y8AG7IwRViP2ZaQeV08cX568umP4vuzHK7SqDQf4fkPVAw0enRcNTK2Zp5v+rKSf9v6xnTrm4grueRiMgTxumr9T5twy6ahCVjbP4rsefasi8lZBfkDcz8HOxXxyA8w30d00TbqqX7p6w2/hM/gdLlwvozJCRy+CkdjuQHuALrDowZjzccxhicIFPQhkjt2gPeP5OcG4=
Received: from localhost.localdomain ([2804:7f1:e2c1:c110:4997:fa3c:54c0:a69b])
        by smtp.gmail.com with ESMTPSA id iw10-20020a170903044a00b001d9eef9892asm1914997plb.174.2024.02.07.14.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 14:29:15 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: kernel@mojatatu.com,
	pctammela@mojatatu.com
Subject: [PATCH net v2] net/sched: act_mirred: Don't zero blockid when net device is being deleted
Date: Wed,  7 Feb 2024 19:29:02 -0300
Message-ID: <20240207222902.1469398-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While testing tdc with parallel tests for mirred to block we caught an
intermittent bug. The blockid was being zeroed out when a net device
was deleted and, thus, giving us an incorrect blockid value whenever
we tried to dump the mirred action. Since we don't increment the block
refcount in the control path (and only use the ID), we don't need to
zero the blockid field whenever a net device is going down.

Fixes: 42f39036cda8 ("net/sched: act_mirred: Allow mirred to block")
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
v1 -> v2:
- Reword commit message to emphasise the bug is caused when a net
  device is being deleted
- Reword subject to emphasise the bug is caused when a net device is
  being deleted. Original patch subject was:
  "net/sched: act_mirred: Don't zero blockid when netns is going down"

 net/sched/act_mirred.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 93a96e9d8d90..6f4bb1c8ce7b 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -533,8 +533,6 @@ static int mirred_device_event(struct notifier_block *unused,
 				 * net_device are already rcu protected.
 				 */
 				RCU_INIT_POINTER(m->tcfm_dev, NULL);
-			} else if (m->tcfm_blockid) {
-				m->tcfm_blockid = 0;
 			}
 			spin_unlock_bh(&m->tcf_lock);
 		}
-- 
2.34.1


