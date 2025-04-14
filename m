Return-Path: <netdev+bounces-182076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCA9A87B14
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 10:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FA631893BB1
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 08:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53865258CE6;
	Mon, 14 Apr 2025 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXgaSmRT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFCE1B4234;
	Mon, 14 Apr 2025 08:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744620860; cv=none; b=Xl9A0aaSHSjCnrZ1/PVnjLnFS2NeKupvNvnCQQHrLIE/VIgWEZlqM2JS0OCe0gLnlmVeQAguBwtGKubgvTLP316jdlSTe7mhX0I26WORvV9CmSq6WWWGwHa73CR/6WHVxaELzE0UyQBaDdMkRd7BOIFdsyP3S0/yKngVn+q4mHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744620860; c=relaxed/simple;
	bh=nw8eVmRqVwF9alcDHpVkbbL/Rtrj2jc+FZjU1k6Gs98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y46YXtxJlSwGy7QXTmFVX/eMXVyQpcNwwiZ0zN4eUzFBliAJ/W+z+EKM0euN1dyw/d0lnSK6UP8I7FFYY/lfF4To6tQs2Sm//a7b+Tkaai/96PdQEJ5vLZmj+FjdqJOAMVU76Q3kkAtNxDgS5B2pLtSAbN7hVf94GXe53Koc8TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXgaSmRT; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so42303595e9.3;
        Mon, 14 Apr 2025 01:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744620857; x=1745225657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V6YosFn/tXjoFJpxYO7loq2FcKuVEdfZqaplaUa/7TI=;
        b=bXgaSmRToecUS+CCkHFiB7ppjKVHDQBLWufmhRMA01vwae6g/93pTDmlSBpem2AQu1
         ECGrjMy7CVhmDOxWybhKDPHWbh6eVGA8uc72qa/FainecKJDLYl4kDclN/g8PR8yHXcL
         cQ+3GQWxbi8azPlCF2WQcKD4Mfw7bue0zNYWdjdClc6bL0bjK+Q77047Tsn9W4Hasg9F
         5ZddeyZ7vk6Mr4cPAsE+Tij/avu/BdiFbkdpYzIMiplDEM43+57ZxX3pOzsKqwqK63Nc
         I4zGbU0qBjEFLlxfQ7yskGUd9x0o3fujwSAPxAc5v+nPwZTHsGtMUeYwMa809D3qO9L9
         3JNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744620857; x=1745225657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V6YosFn/tXjoFJpxYO7loq2FcKuVEdfZqaplaUa/7TI=;
        b=EprXprYK4+uL/n5Kn7Q2UZ+JZ+0p3JpbuTSCcMruwr3aRsBaThqixFRP3vqyklWzlz
         m9Djp1Vsw2mTjqclMtEoooYrQKmnzNBQcQ+dLWPwEBKacV/TRk5hVZSYt064K9IZLp8i
         SJmA7q26UEaZ20AC2+ontEYtPHQgKUvHGBVasPYFp9rpDU0iVGL1BFI6i4tK+GMrGkbc
         zjrkZRjzJ5uOZ1iD+XxRrTDbaSqIJvvEz0f2KmlTwyLTzdXZzGkhzoFOJhdlMFVJHLqc
         /51rDgyxnGrVsUYTKxBmlc9/2uNklokNx3XNpTn6/qOo/DdORgRCQf4TzcXUvOQslvZ7
         f7Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXhd17kfTDt9sYQ7NZXi7Nsr/ug2GMyzhChF8esKs4Gj7zKUjz/gK8/87bJosUJSs5DMp3bAno=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp9fgzALfiiqLRcov6utxxR8yGnRtmfFuxIEsNFbopF9sZz/Or
	9hb32z7tWjSV8f+qYNkXHz9Hd7TzvzKQ5z+1jW0YbPEniXQehABS
X-Gm-Gg: ASbGnctgcZDlGkftoV4jyM2jYvQjeTopGQmZfxJTXyy1CJgWEUZobyIQcZNU5mUHqBU
	hO40jkHJjuwGltK6dWaF9/Sd56WQ0Trt9TrBz9Vt+BQ+Cu9xcfjmb2LBSRnmObMvPA0EMHrtHMW
	mHcQ9h+IWklcn4Cd80iB1eSZHBleVIKkVR2TmTrQ6+D2q/Py0L34siXRMTL+oAh9dm9bs6pHoig
	KTMNZrjpYPnrmtIo0CJlhQ8byma6ZQGx+iLBfh+4ei7vSfKLG/6LfWcNTJk0+0kVGvdGymWd0iT
	Vk7IQbUqZvbIxKVm6CJPdSuw0WTVV7QC5BKE5MtZlFShelB+VlRWuzE/gxly8Kb5/rXNCy9AIYB
	kt0QPqLao9S5N
X-Google-Smtp-Source: AGHT+IGv81mv0E2ZY2JTv11bML10mU1xHuSqraOTLvYxFwFu0n9xeDQ1S00X1ItmrMpz1s4tyMS3rw==
X-Received: by 2002:a05:600c:3b0d:b0:43c:fdbe:43be with SMTP id 5b1f17b1804b1-43f3a9beb77mr107495785e9.27.1744620856564;
        Mon, 14 Apr 2025 01:54:16 -0700 (PDT)
Received: from fedora.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f20625ea4sm172390675e9.12.2025.04.14.01.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 01:54:16 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: jonathan.lemon@gmail.com,
	vadim.fedorenko@linux.dev,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH v1] ptp: ocp: fix NULL deref in _signal_summary_show
Date: Mon, 14 Apr 2025 11:54:12 +0300
Message-ID: <20250414085412.117120-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sysfs signal show operations can invoke _signal_summary_show before
signal_out array elements are initialized, causing a NULL pointer
dereference. Add NULL checks for signal_out elements to prevent kernel
crashes.

Fixes: b325af3cfab9 ("ptp: ocp: Add signal generators and update sysfs nodes")
Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
 drivers/ptp/ptp_ocp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 7945c6be1f7c..4c7893539cec 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -3963,6 +3963,9 @@ _signal_summary_show(struct seq_file *s, struct ptp_ocp *bp, int nr)
 	bool on;
 	u32 val;
 
+	if (!bp->signal_out[nr])
+		return;
+
 	on = signal->running;
 	sprintf(label, "GEN%d", nr + 1);
 	seq_printf(s, "%7s: %s, period:%llu duty:%d%% phase:%llu pol:%d",
-- 
2.47.0


