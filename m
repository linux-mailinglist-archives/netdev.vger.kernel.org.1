Return-Path: <netdev+bounces-217677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 829E3B39821
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 11:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B673C1B27364
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 09:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846FB2D0C6F;
	Thu, 28 Aug 2025 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOJHxzBZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B06F23C507;
	Thu, 28 Aug 2025 09:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756372960; cv=none; b=gH0dSTula8iCvOTIQM4B3HjjPp1VsXKKNNpDDkBiSZbezg/FwOQqzjmC1cB8L9mOa9r9zH77Gd/F139V1zcBlJbEWxACoO4XmdlQB5fa+4QGuBQyIevS5J0XLCQqIKr2uWv/2azF5eY6EGnMbl4ZSAO88Gf6krsQU+KV8wPjQYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756372960; c=relaxed/simple;
	bh=mIn+psPg+te/6slCAHJUNfrJV0VIj9QGO3tBdKan0tQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lQ/PfxclzOYxXZ7VkrvF2njLeStkZlqx/L5b35SPaYJYjfwPmG9SCXSsp9qEjNFOjujVwohjoTcgQT+UZTWOVFtyjESftQwK74tBtYv68STO+NbqHGzzQPXJj+B2y8X6Oun1J0H14BORtgg245sROfAE93ixMj13YsZhQTOsdAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOJHxzBZ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso703762b3a.1;
        Thu, 28 Aug 2025 02:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756372958; x=1756977758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lesD8z2wx+O5N2t/cx0KspHB4Kx1rcrZq7Ll6eX71O8=;
        b=cOJHxzBZwNSFPiXOp8ZkVRteWqaqnISj5u6s09gSuOeBYt2YQmJesuAa/mnAroo2hz
         tmaIR2IJJVJuhOKaGUhz9bjoCSWjudgPPLwSyeIeQAVSLF1M9GOzMbcsIktSGb6g0P2H
         o/41TKI4PgCu+GPd4bQW2chHIxJnOWEXmrzcjB4xrbZcTS2gC7PuTo1o2BN7jihE3CNK
         zKdrRWxxhNtYqw8sssNNt67p7H73NDe7LFi/Y7N8EJ4L3a+yKbGmLtQ8XAw8r0O1bQ2S
         hKSFs8uMh3JE/nypWlOEWcc+W9cnFlM+0hRhWV52Y303PZcnKREha91UERmEPz0gy0Hw
         uF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756372958; x=1756977758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lesD8z2wx+O5N2t/cx0KspHB4Kx1rcrZq7Ll6eX71O8=;
        b=N+qGWvmgkpqq+cThfvzPUFAXvxLg70YNzXa99sAfijlAGofEue40S24G6KmqwKsti+
         WmPKtRez3Zv57yepKKLPoZXKxxWtGxTNq/HKjYbDCrvq5HFJxmS4vJyvkRNznKJSWI0H
         MmFEcV5FcpB1uAAEq98j+FMztb3pR5So0tus82yLR6sh5e7MxtEntG3v/c396pFJwrMX
         cuoNoL7M55KeVgTp8K28sVam54P1uGQHKQccYifJkbkAA0XEtLuXITSFPSPIjxIQ44Qs
         MaaFmk7W53emSSBoINIDrczcHs834mG64RS2JdE/MxRQ/is1XLPqpxuwotny71jeYDw9
         9tzg==
X-Forwarded-Encrypted: i=1; AJvYcCURE9wpRoIhv8YckDOv0NdDTUX8wvyM3/Yb2IDNxTpA+ooOkKb2pz1cgn9fybBjQpLE82yFcXKo@vger.kernel.org, AJvYcCV64JxSJL5mUzI4146F614JFpTKXiCmL1cQfPWcCFp8eca1p3vFgF4E2aGms195/JsdY0CcGcDZjkgTLLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSikMtzlDh/4Ly2aU/qJMifFP4ETTDqBD/0LxkqQGb5pq8w5OV
	R9A/URtuT7mQm4ATDyYAedl8NKVth89UAK3Ha4UBBk0mdrFFHavRTozX
X-Gm-Gg: ASbGncsIxEmJpZ3Q9cVjbeiINUKVNdPCa+/D/lqRmTasLUrScs67g597Fy6T9MxL6DX
	dlD2ezUqfBs/KvhZ8dfM8iL4uBiWn7DHbrJzd6vcPrGIJHHZGrf5bShXFMcmdtRdPiOyI6rkCnR
	2IVXXXflbjC60+tbio5EI813NnPJHlE4MsfyFeZsGWkDIchvUUp1XYjDDbtyw42ikf3nKQCenCI
	gwnY4tDBj7Rmhd/3mI7AYYUcn7Kh4Ykz/FIRSaIkzVSNUk5ncnsdJnSPeAeGVqW0n4RHDXi86Kw
	BKkgNwhfIlMmyMvpGvrGxH/khYUiifOlCc3kUiuMFDolNbvvNGVMqcVBIzdLQqKAB77IGgmkaDn
	PQP7Jm6v0l4YlVnjAn4+zeQXE4Q6xjwwC8qx0j4IXkaHTtFTIo4NZcWknJSdSBriehSzOhao4io
	cchIZzB+xxqIY=
X-Google-Smtp-Source: AGHT+IHOlatVraMZlLSeU9m3dgM6j9SgQZIUB1pAgZjmoAUeuMyaQSxAzVBiLcT3hSudMG1208JTHA==
X-Received: by 2002:a17:903:2287:b0:246:f14b:31d1 with SMTP id d9443c01a7336-246f14b3365mr158181605ad.32.1756372958246;
        Thu, 28 Aug 2025 02:22:38 -0700 (PDT)
Received: from localhost.localdomain ([112.97.57.188])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-246688801casm144390505ad.126.2025.08.28.02.22.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 28 Aug 2025 02:22:37 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: linmq006@gmail.com
Subject: [PATCH] net: ethernet: ti: Prevent divide-by-zero in cpts_calc_mult_shift()
Date: Thu, 28 Aug 2025 17:22:23 +0800
Message-Id: <20250828092224.46761-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpts_calc_mult_shift() has a potential divide-by-zero in this line:

        do_div(maxsec, freq);

due to the fact that clk_get_rate() can return zero in certain error
conditions.
Add an explicit check to fix this.

Fixes: 88f0f0b0bebf ("net: ethernet: ti: cpts: calc mult and shift from refclk freq")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
This follows the same pattern as the fix in commit 7ca59947b5fc
("pwm: mediatek: Prevent divide-by-zero in pwm_mediatek_config()").
---
 drivers/net/ethernet/ti/cpts.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
index 2ba4c8795d60..e4e3409e7648 100644
--- a/drivers/net/ethernet/ti/cpts.c
+++ b/drivers/net/ethernet/ti/cpts.c
@@ -607,6 +607,8 @@ static void cpts_calc_mult_shift(struct cpts *cpts)
 	u32 freq;
 
 	freq = clk_get_rate(cpts->refclk);
+	if (!freq)
+		return;
 
 	/* Calc the maximum number of seconds which we can run before
 	 * wrapping around.
-- 
2.39.5 (Apple Git-154)


