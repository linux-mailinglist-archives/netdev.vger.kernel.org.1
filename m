Return-Path: <netdev+bounces-213956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D88D4B277B5
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 06:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB8FB7BB255
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 04:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9FA13959D;
	Fri, 15 Aug 2025 04:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVwYTaAf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB96610942;
	Fri, 15 Aug 2025 04:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755231478; cv=none; b=aQAekvSpa+sIPVvcwzWpeMAgmSJlUy4YmVp/bJHvst1VT/J9c2oY24HI9pApBiF4k38et71/wNZsug3Be6Ht42VE0fB9FQutW8A/F8c8oiEth86RMr3wY9DLqzcOalPud2rOKZrU/PvJiyiSxZ0ytsu1h9MbuBFknw0tL+5a5/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755231478; c=relaxed/simple;
	bh=ON/VI9sS7RGOV3O76kXiDfRP61Lq8dzPD29FlV+sPIk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=okCK48k92CHzWViEp0FxGg2K2a5BG2zZOAnc3xB+hllnLjVMcyE3ws8ojWJSXCj+77ahpcv7DRQ/INUt4Qoq3gn9KwSdFz9qrKcHsYn831noNtHa9B2YIHM2Vjhf17znl/dNwTQ8eDNaeO5o9jDrwpyA06N0maEkBzRTQElknQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVwYTaAf; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e2eb09041so1533580b3a.3;
        Thu, 14 Aug 2025 21:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755231475; x=1755836275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wsvcRvEcdLfGUClAtC1aTF/Ij1Uihwu0Sus0rjr3b6g=;
        b=aVwYTaAfRn4i9Zn27VhDsSs4i6VUgKejll3dY+BO5BHTeX9h6ANAyd0fqgyd8kI2B0
         uAueecGF5iUp4VH7tY4R8XGqXHK0YLRDtcsqRCAY4hYLEMBOSlDtGpy6wU2EkqSFpCfo
         1BrJrz5WVKlzP/spl6meNHTV6gVm3xD/wbY/OiVAMcIdNkOxrQ7vDh8FeqSAeuG78/8B
         Uqe43rShJckAcIDkJO3dI8bXin+RKEJDvUm3IvlddQlil8AmfXnxtVgD+Czqq/X9vb2U
         lj8adXyZjMX7LUEc+qLF6D//RFDuzUwmeI6BCm5Q/8INYOzb0Odx4CbBqsSQ28OeWfbq
         +j7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755231475; x=1755836275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wsvcRvEcdLfGUClAtC1aTF/Ij1Uihwu0Sus0rjr3b6g=;
        b=uinG83gxMgn5wrfykO0XigV0oDxh4Oo9MOWaXnrHgVXSuT5gaInGEAA0Zh64+1ZYRQ
         XaWUq/x7rIOMlDfgxLkF13PZO6yajSbfiJEdch4DYQjiHo5TzbhZa1tnjsIH5hOs97HY
         3Mo4x0MLUP8kCug0mQE7v/TqAtQRzmV0XYNlRC21SSF88v1f2FYXgTxG7nN92Z6WSMO5
         Jk3Cbcmn4ZNMDjumxcdALppM0Vuv6XyIIAVOsvH1skSN8Wc8K+0wykJFl2egAJa6j09M
         fbQ54blz7YDpPUSO0WIxs0ZhSXlXLp30KJvOW1hd4c0hbZvm2htks1Kx+BeWYj5acIo6
         eV4g==
X-Forwarded-Encrypted: i=1; AJvYcCUc/e5wl+h6Ozq2Tlf75aO3XhEsR3Ak04qWspscNhfdGVWsvwZplDLXvk/lBOljBeduRMwNN0xy@vger.kernel.org, AJvYcCW7/OQh7+aaYymW0DlaNVfo9qvi9JTkRZ+zdiV1J7/YWoN+sSGX5kR3AeZrI4wculMCN0fAyaQkB9CEVRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxomoLPjXf4FyGU8mrPhSypmcaQMNEP3rYv80eCXXKCkibecn7P
	BiqeMWkzCPLLN0+HTMRkHqE86hG+jj2bf90dy7y+wzjP9V4Tj14hvgzU
X-Gm-Gg: ASbGncs2ST/ROyWliT9JEbWoxoZXhqiIovSXmzaDyPj+DJvHuDme/zsH+6am5UjsslO
	j2y2PmcMxG+sv4QvPRVYmYDTtFAo9qqao56tNA1eQsKsgB4VeDKCRXXdT/3yEFMLijebh47coiH
	LrC6pirEQirJeLn9Ojoh9x/EioMutqVgfeqJrEHHeymTdZI+HKPP5DiGrjEyeGew2yaezVtueR0
	FeejC/SoLuda6ltQWzBE3HeTc2ywdiFZUf2QQZbCNQ+eV9JldQTVUhWDFM9WDYAUn8Xorp5dkLZ
	eYKtj5LH+KH/BGrAYBn+BalrEVZVmXtAyPemSW2FZssE7fO26v7/eu3DkgxXmEFRU4yQI4bfACv
	UZz6Tzu6xP6aMzDprNT5G/KIl+1TTamyUsuWX
X-Google-Smtp-Source: AGHT+IEsSoaev/J0gbFPeDHvmKFIJqlvo409xLgICN89xPMWXVulxdjx5tkjzy/iH/LcJYOXY1luwA==
X-Received: by 2002:a05:6a20:7d8a:b0:240:2473:57b7 with SMTP id adf61e73a8af0-240d2d90e74mr1267117637.8.1755231475258;
        Thu, 14 Aug 2025 21:17:55 -0700 (PDT)
Received: from io.local ([159.196.197.79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32344f112cbsm26778a91.9.2025.08.14.21.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 21:17:54 -0700 (PDT)
From: Jamie Bainbridge <jamie.bainbridge@gmail.com>
To: Manish Chopra <manishc@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ariel Elior <Ariel.Elior@cavium.com>,
	Michal Kalderon <Michal.Kalderon@cavium.com>,
	Manish Rangankar <manish.rangankar@cavium.com>
Cc: Jamie Bainbridge <jamie.bainbridge@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] qed: Don't write past the end of GRC debug buffer
Date: Fri, 15 Aug 2025 14:17:25 +1000
Message-Id: <2bac01100416be1edd9b44a963f872a4c25fda03.1755231426.git.jamie.bainbridge@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the GRC dump path, "len" count of dword-sized registers are read into
the previously-allocated GRC dump buffer.

However, the amount of data written into the GRC dump buffer is never
checked against the length of the dump buffer. This can result in
writing past the end of the dump buffer's kmalloc and a kernel panic.

Resolve this by clamping the amount of data written to the length of the
dump buffer, avoiding the out-of-bounds memory access and panic.

Fixes: d52c89f120de8 ("qed*: Utilize FW 8.37.2.0")
Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
---
 drivers/net/ethernet/qlogic/qed/qed_debug.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_debug.c b/drivers/net/ethernet/qlogic/qed/qed_debug.c
index 9c3d3dd2f84753100d3c639505677bd53e3ca543..2e88fd79a02e220fc05caa8c27bb7d41b4b37c0d 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_debug.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_debug.c
@@ -2085,6 +2085,13 @@ static u32 qed_grc_dump_addr_range(struct qed_hwfn *p_hwfn,
 		dev_data->pretend.split_id = split_id;
 	}
 
+	/* Ensure we don't write past the end of the GRC buffer */
+	u32 buf_size_bytes = p_hwfn->cdev->dbg_features[DBG_FEATURE_GRC].buf_size;
+	u32 len_bytes = len * sizeof(u32);
+
+	if (len_bytes > buf_size_bytes)
+		len = buf_size_bytes / sizeof(u32);
+
 	/* Read registers using GRC */
 	qed_read_regs(p_hwfn, p_ptt, dump_buf, addr, len);
 
-- 
2.39.5


