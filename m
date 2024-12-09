Return-Path: <netdev+bounces-150164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7503F9E94B7
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 13:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7640916495E
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 12:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7225921E085;
	Mon,  9 Dec 2024 12:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPvRaTHY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAD0217F46;
	Mon,  9 Dec 2024 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733748494; cv=none; b=OIF97p7lOqlM8X1GH9BBnlNTc56C9/Pu8ziI/XmahKXTxQmFtAiG8fh/qGHmJ64m9z8TRbYDvRcQqVa3mqvWyBH9Q2McnRbJKp7iYx3CBsOn0Igt82ymvdJkXJBDU9HXiZ+bl6b0Cb3pv4NcyiDoxm0znn6VjvccH4z84P77Z9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733748494; c=relaxed/simple;
	bh=q1xTRQ46LJaBS80CzqPQMfMsZUlaQOCKcOqz6+XOwF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G63fV8xwejmKjDgcmKLINPNYJZKhXTDPHUEPsYBayz5XBCMn+qhDWEL/c90cKye6ORFcbGO0w/ZNhlyvnIzQ9xWrrPhz6P00P+qIk09EEYgDS3j0p2b20X4mqRcVkHtvmncJJTEbtC17kEeFCQTHN9XlHVyzySnlPanZwTTVQkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPvRaTHY; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9e44654ae3so691404766b.1;
        Mon, 09 Dec 2024 04:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733748491; x=1734353291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XFvY1CszXik5PYGFZ7Oag5RpbKj77xMmUL6M53TxKLY=;
        b=MPvRaTHYwH1uLh2pfzFJIBz/KGt3QO8Ez529g8S/tLEM6wLpPhfkukAz4ffwiSmKbd
         ASZevZOWTHpjCKzQp72sxEJqmLYm7ZPr5dQwfIq+slyJbKNwrrXaOGtirqSG/rOf1paE
         F/mdwFB9XYC9h84I29Swl2LfWGF3vac2h0+MOCcsIFOtbK9LZ86T3kXUbvnuGADFAtbe
         tzLUsGs9h1uvheD6bxhcNfSJn3nrwc6nMy5E3iCCDMm2dkR5ZcbPS/jiLRt0zFBeV/lj
         /+yz4WeOe50GwFNff/ghLAhbA+tKNP4/x0xXaoER7A/d36sfmjvEJc47lZzcWryQzwwx
         Xiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733748491; x=1734353291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XFvY1CszXik5PYGFZ7Oag5RpbKj77xMmUL6M53TxKLY=;
        b=W4LAyqFrz2lQDBwx2Az85SUHCQum2XQFD4tt0dt12zmtNP2vOxhcorCeYvToTmMw8Q
         UN7Mms3tOjKoGo2L/EOBX06nvvlrICaS9Ndluyz75a+aoi1Lce83ToQnI+ukLR6p8wXc
         W8c96Kgwdpn24Ollbgebu0yLXBqvNMJkWUhxSS5d69uhZKaNMV8LRS1sW46Yp9HIRNFy
         s0mOqHWJ77hafNARmHu8s/RJnW8N/DZk6gE4AmJSYvIWTGcxGut66YuPZsP/W4iOWzur
         h/Oaw18pFklijmCVaSQT7VlluzfEtXGLura6yKBrwRjjoVGnD7gmOEUFfPh1vgNCB3m4
         EZUw==
X-Forwarded-Encrypted: i=1; AJvYcCVcLBiTSUuZbPPF0K2cm9G9JRlDaZKCBq+xycxaayTYWsUtZ6NiVbtw3udESaE2Tj8gKyaqsJN6eHPH17NP@vger.kernel.org, AJvYcCXTl+GZJoDz6WGUdt7eueuVk5w9vQcn49oKMXFZgkgOyLmOnsXY0tbQhrcQs8WbePk4uoDzgndNNf6oXEK73lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPoaMOdtm/5/Fq0ofn3ci/FVwXcPn+DJp1YIN7hO0oQEi3KrAY
	vTL+SQvVILUHkyTt3maojlIr6dk5aFykIMcjlnQwHG61ZMN+3Teb
X-Gm-Gg: ASbGncun1LuLYU4nVlHo87rtMytI0CYcm7x7WhhE+ABUAL8jh5EkMsxHxpUrVuP15Yd
	OP4kxTYtoGfTgbvjJxfDOj7I6Bf1tYpG4CaVMRVMIzoETpvMObdvmfCg6zJJRsNjLIRHMXyfaba
	iJtlXFie++ipAUmbPmsJziEFOpi5pHJIUGh0WkIMJJH6GV1qiGrP+DmFD9nPhQizXozL2dynaX1
	KEH0rdTN1Yk3UE0a1ChE86CXuvkXNZZiIWJLmDQJpCD
X-Google-Smtp-Source: AGHT+IHozJjUridTb/LrfU/IxzW85NPcoz1ea4x14rQgNv7nBiP6X6XfKeAe82PJGU/WVLS3zSteHw==
X-Received: by 2002:a17:906:3d21:b0:aa6:1c6a:30a1 with SMTP id a640c23a62f3a-aa69cd70dd3mr24222166b.32.1733748490724;
        Mon, 09 Dec 2024 04:48:10 -0800 (PST)
Received: from void.void ([141.226.13.92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa685669acesm168941266b.189.2024.12.09.04.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 04:48:10 -0800 (PST)
From: Andrew Kreimer <algonell@gmail.com>
To: Cai Huoqing <cai.huoqing@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH net-next] net: hinic: Fix typo in dev_err message
Date: Mon,  9 Dec 2024 14:47:30 +0200
Message-ID: <20241209124804.9789-1-algonell@gmail.com>
X-Mailer: git-send-email 2.47.1.404.ge66fd72e97
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a typo in dev_err message: fliter -> filter.
Fix it via codespell.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 drivers/net/ethernet/huawei/hinic/hinic_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_port.c b/drivers/net/ethernet/huawei/hinic/hinic_port.c
index f81a43d2cdfc..486fb0e20bef 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_port.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_port.c
@@ -469,7 +469,7 @@ int hinic_set_vlan_fliter(struct hinic_dev *nic_dev, u32 en)
 		err = HINIC_MGMT_CMD_UNSUPPORTED;
 	} else if (err || !out_size || vlan_filter.status) {
 		dev_err(&pdev->dev,
-			"Failed to set vlan fliter, err: %d, status: 0x%x, out size: 0x%x\n",
+			"Failed to set vlan filter, err: %d, status: 0x%x, out size: 0x%x\n",
 			err, vlan_filter.status, out_size);
 		err = -EINVAL;
 	}
-- 
2.47.1.404.ge66fd72e97


