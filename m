Return-Path: <netdev+bounces-145032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEBC9C92A5
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 20:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C955B26AC9
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 19:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF58C1AAE1D;
	Thu, 14 Nov 2024 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amundsen.org header.i=@amundsen.org header.b="K75+XVop"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0EA199FD3
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 19:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731613886; cv=none; b=p+Xj8RiM1Rbmkwliu8rSLiRFtHyVdXqTWsqSP/7YPnwFwCdprmBcfWUn2kpsvRr79iduvEyMWaqcprm3kykyMGInYecmaG+ps6WuHPszG+T+KX5GHqD+HZ0jOJ2MLelJhXsc78Zb8oRgvsNphIuOgtC8szuuezxlcwBkSYlLFC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731613886; c=relaxed/simple;
	bh=EupYCYVmBmtFqE7ERsjzdBvWr8HIJUlJ4UMy0QJfrXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqruwzbNRnaDxLuxLQjqERT4Pq1jSJeoBObAjlMJ+AiEc+k4V63cTCqaQUZ+38+YurXosRn6eNvrXlntM9bkR6fnpCygFqAJntX71SVE6sx18zQnKG/JnKluJy9wTId2BcxfNSCMJDAlIW1pRWddgaWdewZxMYMyGKx/diCJT/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amundsen.org; spf=pass smtp.mailfrom=amundsen.org; dkim=pass (1024-bit key) header.d=amundsen.org header.i=@amundsen.org header.b=K75+XVop; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amundsen.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amundsen.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53a097aa3daso1001788e87.1
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 11:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amundsen.org; s=google; t=1731613883; x=1732218683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUamNRwdHqaneOvXI0azbdJiLRkfCesKErrnB+oq0dg=;
        b=K75+XVoplnx5H0utnU9lMpv3yoV+1maUW0PpRdvVvEb/ekEWAcUcyeV1GkhkRBR+Li
         /ZbrgbipQzW2MymSClcODiyutiXzenhyGsekPevlYABaRXToDy/cDCpRypTQWLsQhvqk
         jsPCIGnPiEjUJwYwWZFP9zqDHK9j9m8aS208w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731613883; x=1732218683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUamNRwdHqaneOvXI0azbdJiLRkfCesKErrnB+oq0dg=;
        b=MWhVeBSessnkWVY3CfbYycAQxAS5890f658gHgako3WaRLw5uXGYZanxtBoV3svgFj
         G5wOXoLWIaYEAG5XiJcYHyRzXUQKKdLNZrhEyVjSfjqPWAsC59B1I3wvSYgyJlK4hOhF
         TVr92eyOJkQ2uDnAclbb4tyw1lTsbMI74WPJ4vyxtO4kYC7VlEQVIU5npTJjutztBumU
         +5M8kjgGGSBzISEK4JcrcqEAi1CnAJLwxNsNUVOtLuDTDv8qbpe+Xn81ofYo/nP+xJXC
         yUa4eQ9+f51L7Gmn2Jk2iVUckjtdQv950bQhbEQyZ7JuEwvkuB/Q4yHvR7t1nwiIkvP4
         VQcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq4vIsH5VSrE0gXjAwHYqayznzWO0EX75wJSp3wzL76fMRox/5l/OalbE+TXz7YPKNdqAqc6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbXFj8WXq6x7Xd10P+ZhUDz5DtpjbBg49haT6+xo8o+hNjwnHq
	Y1OcVupcpiNCzfY1QHuLcverkNs06M3mW1KB6wMgoYhosvWlH/ZzFqwMCjL/I6Q=
X-Google-Smtp-Source: AGHT+IEBEehanLwEneeIOLJnVHbZhhye/fiGYEV3b8jPAjjxCTLWMT5lmYur9Jh3ksL3tfhl2Y/Ltg==
X-Received: by 2002:a05:6512:3981:b0:536:741a:6bad with SMTP id 2adb3069b0e04-53dab289f4fmr3648e87.12.1731613882471;
        Thu, 14 Nov 2024 11:51:22 -0800 (PST)
Received: from localhost.localdomain (77-95-74-246.bb.cust.hknett.no. [77.95.74.246])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da6530d81sm288780e87.160.2024.11.14.11.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 11:51:22 -0800 (PST)
From: Tore Amundsen <tore@amundsen.org>
To: pmenzel@molgen.mpg.de
Cc: andrew+netdev@lunn.ch,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	ernesto@castellotti.net,
	intel-wired-lan@lists.osuosl.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	tore@amundsen.org
Subject: [Intel-wired-lan] [PATCH v2 1/1] ixgbe: Correct BASE-BX10 compliance code
Date: Thu, 14 Nov 2024 19:50:47 +0000
Message-ID: <20241114195047.533083-2-tore@amundsen.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114195047.533083-1-tore@amundsen.org>
References: <ec66b579-90b7-42cc-b4d4-f4c2e906aeb9@molgen.mpg.de>
 <20241114195047.533083-1-tore@amundsen.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SFF-8472 (section 5.4 Transceiver Compliance Codes) defines bit 6 as
BASE-BX10. Bit 6 means a value of 0x40 (decimal 64).

The current value in the source code is 0x64, which appears to be a
mix-up of hex and decimal values. A value of 0x64 (binary 01100100)
incorrectly sets bit 2 (1000BASE-CX) and bit 5 (100BASE-FX) as well.

Fixes: 1b43e0d20f2d (ixgbe: Add 1000BASE-BX support)

Signed-off-by: Tore Amundsen <tore@amundsen.org>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
index 14aa2ca51f70..81179c60af4e 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h
@@ -40,7 +40,7 @@
 #define IXGBE_SFF_1GBASESX_CAPABLE		0x1
 #define IXGBE_SFF_1GBASELX_CAPABLE		0x2
 #define IXGBE_SFF_1GBASET_CAPABLE		0x8
-#define IXGBE_SFF_BASEBX10_CAPABLE		0x64
+#define IXGBE_SFF_BASEBX10_CAPABLE		0x40
 #define IXGBE_SFF_10GBASESR_CAPABLE		0x10
 #define IXGBE_SFF_10GBASELR_CAPABLE		0x20
 #define IXGBE_SFF_SOFT_RS_SELECT_MASK		0x8
-- 
2.43.0


