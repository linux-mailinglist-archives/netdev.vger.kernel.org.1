Return-Path: <netdev+bounces-158361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAE1A117C1
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 04:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3BD18896AD
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 03:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56A021C190;
	Wed, 15 Jan 2025 03:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJ7jLJfI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D62829CE6;
	Wed, 15 Jan 2025 03:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736911650; cv=none; b=SfUknSKOAEc4LyJIM7Vr6WfOXalhO2d31wLfwZk+daVMVmmurFDlfVkV6zJLiBCUOtedZTOuaKP46pUvqJ/gMjyLIyylt0vnsjjBmqDqphzaSI21+DtNZGudUcq1K8+wRpJ1QJM+3Vs/b1xni8eNZj0Q+11c2JDJGcNAu8v9sE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736911650; c=relaxed/simple;
	bh=8zriDhM2EbVdV9UDbV4501Qh48c97Vm6oA/ncW2cjnk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qds1dw2dDO6NoL0Fu1ZpGz5kBENxekLiL1tnErPu71YFfTty8hS6yliOFuDdGZd7abvxo7JZOizmTN/971iE7Pzw5HAjqiGETKnjkxuwJRL7s7NhuSPxJ+DE9avOlMiYNpCMgqnma8QxE4ixcAY+RKu4IxaOq1HOeReKeJsAJqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJ7jLJfI; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-216728b1836so108897675ad.0;
        Tue, 14 Jan 2025 19:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736911647; x=1737516447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OA13Zni3URzGAidEIRgBrp/qP4ozxw97b88r2lO+YJs=;
        b=cJ7jLJfI0Hpd58yyufUAycLuTyhuAbd6sT3SfrQ1KyTj2QUhssPon8UIoGAK4Zm5hV
         0XwwCwPMmnvd7hRHxQZ1NC8+mtGZJ7CRuWFXhdaQX2MSnmDoR4ISbG8z22j/PbX/kiTb
         vWShZPDhDWyrLU2mIevOrJjMhQpikPsYd+0Yoals8AHWLZnLXwU22wFEB7VpJfxerJ9I
         yp9vPw2z3LPsTUU4tSij5uaWScctNw1oKbsCYcNqG1nNEsH41LubnqoMM/N9zLRhmWhL
         SoCszqTZbHvVs5eKdnNkA9UwnX8C6CSt+LUoSl2MiF3jAko7H8/O6gU+H1cbOYpve9AE
         HVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736911647; x=1737516447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OA13Zni3URzGAidEIRgBrp/qP4ozxw97b88r2lO+YJs=;
        b=Ot1afqwmIPVihxaPE0UwVZaPH/SBALoBXKrV36KcBaTveXCb1dkDuKnTobZ26MFSMB
         FgMmFu+G7rK4w0LGDwiWUsDk8sFDaIyLG+ZREZP0q1x/VYfXvXIOCxbT7dKqaKsAOp1+
         /G0MK/xSWsNJr8eyc+Yca3iQW+TKpg4Rtw6T+hOm2xJ0JujMumm2k0vtP4pm1YdvyS2F
         rDFlLq/Yt0VUP9L/cxPrKvttm80G/fbvJNA3WRektbs64ZQUut1TY+wHQaklKCUgvmhu
         JMip8HYkzYJ8jUObk397jT31ho9xE7au/LMrN6tqwMzS1xMpWN06BFJEZIMkj8GODP1w
         K7mg==
X-Forwarded-Encrypted: i=1; AJvYcCVpqIfR/bFRyNZeUAhySrhyHxmkaMEa/YCWPEQeXo30hLrr0nJHDSl5ZvHzIArTjo1MJS7qm/faeCkqALo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyd2umn/Jkvg/UfRV6kuSBL2fy2xNDxrdHULL15UTl06GTyaRw
	PUZNQkn2Q7ke1QBT4ajSE0tZaMDIXrOOOz0kOxq7RC+zfSfUmugmV7dmdg==
X-Gm-Gg: ASbGnctYazYUS7ab4NFPLTkoicQxw0fwFYQcB0BZoDbdodusON4sWgQmD2o9oYtnhsy
	guOqorEelxUVYzn14w1FUemkenDTrq8wVZ0pDyh5meF3o1qcgHBK7CfyA1Gb7NYRIpNBGNrN6TO
	MtEBkgppqj8xm5UvO24ZrGe0PZ+7XUTiT4zJtUyywnS0y6q0oSEAElb9vdIWAFGuCEvoLcckAms
	o8vbqDQpSccrcQnnPd8AMM/lQGnryfjRq452YdI3sfa9PqhLliw9oOCon2fwADxt56mMg==
X-Google-Smtp-Source: AGHT+IFlSEMkAXEPqWgqCAfQugdN95Q538mq9KIKYO4zUWWbGb5CTB8WHYGyQSp6aFpnsVw3r4VLzg==
X-Received: by 2002:a05:6a20:6a11:b0:1e1:ad39:cc5c with SMTP id adf61e73a8af0-1e88cfa6a52mr49396788637.14.1736911646648;
        Tue, 14 Jan 2025 19:27:26 -0800 (PST)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72d405493basm8166452b3a.27.2025.01.14.19.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 19:27:26 -0800 (PST)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Joe Damato <jdamato@fastly.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v3 0/4] net: stmmac: RX performance improvement
Date: Wed, 15 Jan 2025 11:27:01 +0800
Message-Id: <cover.1736910454.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series improves RX performance a lot, ~40% TCP RX throughput boost
has been observed with DWXGMAC CORE 3.20a running on Cortex-A65 CPUs:
from 2.18 Gbits/sec increased to 3.06 Gbits/sec.

---
Changes in v3:
  1. Convert prefetch() to net_prefetch() to get better performance (Joe Damato)

  v2: https://patchwork.kernel.org/project/netdevbpf/list/?series=924912&state=%2A&archive=both

Changes in v2:
  1. No cache prefetch for frags (Alexander Lobakin)
  2. Fix code style warning reported by netdev CI on Patchwork

  v1: https://patchwork.kernel.org/project/netdevbpf/list/?series=924103&state=%2A&archive=both
---

Furong Xu (4):
  net: stmmac: Switch to zero-copy in non-XDP RX path
  net: stmmac: Set page_pool_params.max_len to a precise size
  net: stmmac: Optimize cache prefetch in RX path
  net: stmmac: Convert prefetch() to net_prefetch() for received frames

 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 34 +++++++++++--------
 .../net/ethernet/stmicro/stmmac/stmmac_xdp.h  |  1 -
 3 files changed, 21 insertions(+), 15 deletions(-)

-- 
2.34.1


