Return-Path: <netdev+bounces-140699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8C69B7AD8
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 13:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70F1BB24D7C
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 12:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B4119DF99;
	Thu, 31 Oct 2024 12:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccrWNDSA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F22219D89B;
	Thu, 31 Oct 2024 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730378343; cv=none; b=Tf2x8YKOsPnOhI/5U//gg1IlpRboiRR4jPAJ4wiVcmvDdLTLa7+TZI5aol9/xV+I+1NvCTxhzM4pzWr4F2SfhTyi7SuHTTXDO6pTpjy+3tecSvvDZayLPKtHU+skYx+cyZewC+ArbhXLu7hXlhdPR3RYLrIxNAd8eyjiRGsi5MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730378343; c=relaxed/simple;
	bh=unf86eIGY5mtECgKadC7veM6vk/9GNltKKTdlYjFziM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cLvaj+0ich4R8f4HG2f88zbXv0cTWN01fUf+yK85xYcYvPRuWrc33NXWOJjXJoxmnzVmI+YCH2nH1ouJkmcduYGE+ewMPrPQQqdhsviEqkE6id+1Y61A8DSYmnhnlwi7VZK8dSFAqi6HpxhdICsffy8HJX4pthzL9weeh9eqS3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccrWNDSA; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e983487a1so671420b3a.2;
        Thu, 31 Oct 2024 05:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730378340; x=1730983140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWr+UUbXH8lnMLmy8eSvjMvYSmy75x4Or0Lzgqe9VF0=;
        b=ccrWNDSAHWakqKTmSBFYD8L4KzY12eH+lrIwtZsHee7PZ0hQ1umJl3HX5BhIdoMTUn
         zeP/UbJ04H3xcDpRHmtv+q3wHSrEgmgV72TZB86POvI8adVGONK1vfuenkMowF8BQ2fU
         4n/qLPwpLHO6VkZZ27TdnurB+NYFsHLS6nxy9ri07DkGEZMS4waTgThYJQBAF8+NZbAS
         m4N/4eOAtzbCJ4W6KYqu1bfFdrybi2z1A63mmbaB6leRKlHTQe7myj61y5dlniA6k3sU
         oA5n7p6z4OHPfCAVXxufTIb7tdrBJT8PnzSMKTZq6euV6uWxRORwlWKxHZJwZW2i3jbT
         FE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730378340; x=1730983140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWr+UUbXH8lnMLmy8eSvjMvYSmy75x4Or0Lzgqe9VF0=;
        b=kpbYJ6W7CAc6D4el+CopB9QE+85EtIKqU3kPnQKpojkSMFvWbdtTJADq0ngSpPqGNX
         hd4bPoNkv5Qq+IZ20j3OzCPr0DUDJYXtx2M0UHk6fzKQGRpAX+U1RgYqKH+rBDV1tGP5
         5gQ6d1LlNofHQ+beIQbMuD0vUfG/hEY5TzKChJJjOUxIkgOzzQpaBMwTy/BRSdkois06
         jYaGDDHWK4J73h8ayA7wgJd5oURgEOEOwOUiBULpdgM3MDd3TakI1OAjcGVr3EtgQXPP
         +1RhWJPRbKJs0egL2QCFgRdnoTtpbLW6O9rRbB46NPS9kI0tg3UbGkHDYB5VvYsxm97D
         Tptw==
X-Forwarded-Encrypted: i=1; AJvYcCWLDpiUES7XnOVG5VXhmlIaOoBQVBij6PGnn/RWBeLD0vbxdvkdYRrwTfQBvpwFOm/virJXIqwdjVOU5rE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxox+9fdSxOtV+P3WieXZqfR/ovlKBKZlhTEzEBAhd/1ciUle9Q
	V9/8Fn/b6EO5u3+AZEverkGzKCFDkEQgGgFN3srTB0gLYmMv0AzDMnXzMw==
X-Google-Smtp-Source: AGHT+IGBmQcF+qVYl01bmlNc+GnbWq0Wjs3/vOJvZ50iXD5Wd6bwcRVM5avpNRM6Y+vslybR47mm4w==
X-Received: by 2002:a05:6a20:c998:b0:1d9:857a:585c with SMTP id adf61e73a8af0-1db91d89bc3mr3170917637.19.1730378340154;
        Thu, 31 Oct 2024 05:39:00 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-720bc20f50esm1075931b3a.94.2024.10.31.05.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 05:38:59 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v7 5/8] net: stmmac: Get the TC number of net_device by netdev_get_num_tc()
Date: Thu, 31 Oct 2024 20:37:59 +0800
Message-Id: <4c19d46ee5f6d4229e86eb6195295cf8916b4c09.1730376866.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730376866.git.0x1207@gmail.com>
References: <cover.1730376866.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netdev_get_num_tc() is the right method, we should not access
net_device.num_tc directly.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
index fe0877ef5f4f..f07972e47737 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c
@@ -304,7 +304,7 @@ int dwmac5_fpe_map_preemption_class(struct net_device *ndev,
 {
 	u32 val, offset, count, queue_weight, preemptible_txqs = 0;
 	struct stmmac_priv *priv = netdev_priv(ndev);
-	u32 num_tc = ndev->num_tc;
+	int num_tc = netdev_get_num_tc(ndev);
 
 	if (!pclass)
 		goto update_mapping;
-- 
2.34.1


