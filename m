Return-Path: <netdev+bounces-157758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F996A0B947
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 15:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92E611883156
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 14:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9174422AE7B;
	Mon, 13 Jan 2025 14:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAP7cAvd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2593A1CAA80;
	Mon, 13 Jan 2025 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736778054; cv=none; b=Dd9JEHGDcqsAvlZ3tg/JMtCnpeK3IfrV1Lh3WWsT3YwxNpsH8kt/OfP3VCjLV76B8yPPGa23kpvWazVgwB3wR+INPMe1vRD6JwACt/iDZ+wXLOA6f3mFEu9XUx0O8WAi69Ku18eP9OASu0KQOOEwlJxD/IIkV+68/F8sVsVMWiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736778054; c=relaxed/simple;
	bh=VZOQqvFfIH3zxCowIb6BFNpEQKyR34JN72u7g8qIRVI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zp/NklDZ8FARWbEtCoFAmEcVZFnw+R1Wf4vHJ71CO+l3b6kzjjlPJ8Pv1qvi6SrhW0bHxsD+8/7Za6Vta0MkRxbuV//fDNFNPLls/cbra0kX4/4D3G8aDNLngfT3ClZegE0OIAT7cAncJsdHN4h9LnGDU8iFDb5AfE3vX1QroZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAP7cAvd; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21bc1512a63so11942855ad.1;
        Mon, 13 Jan 2025 06:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736778051; x=1737382851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yjgJEm+zsHpgnh6MvvlrOCLzGs3HMBzj7m6xU9nO/zQ=;
        b=fAP7cAvdrBPYVYHjRK/QFLX65EPVl+pW1jOLQocjxA7i7NO5OQaoGzgxpM/abFyBD1
         QT+nYyEZy+IqwtVfPjGzLbL9twnu5MdZE6cftwn6fidHqTY3PLlxu5XhtKpt6FMgeOQ/
         PXx5ZnmFBiEmWoHIOwzB4+0lwHtCTyce+Z8+nxuTZ/ebhKA2wB9oO7dFxghWLi59YBMR
         o0kVz5OSVwOmoc3PCUVRTdShxRAymJ+aEJrjOgNq76SHqDrRNRrdYc+28dsYXySUKVX+
         MvYVdG62oeZtWMBBdloPPPMU7HRrSDPNH74MBjDCA81RQlTRRktoSQkXQ+vCscsltNZL
         W9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736778051; x=1737382851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yjgJEm+zsHpgnh6MvvlrOCLzGs3HMBzj7m6xU9nO/zQ=;
        b=quRV4NEnXwrvJ+O5Yo7ns0k81zQi3PPCBtBdroO4d2BFwzvHgVeyzROGBp4K3l4hu2
         LcPIbnn5KZWvAJ1cSTaq11/m3aCagy9BPwx+n64oxlDfAdtZnLLSYqgxs6q45k2GJUfE
         VikRRcOvCS/L2GvOYWF5Dtpm/eP2tD/xIJOlT3QNAjMC97ZIP6kLfIPiGUnPbc/WalE4
         k5EJGEPVOMG9enTC7DJ2XDn+6J7Wxd41kF31pgSsgaDHfip7Xh1S6NKHnNn+aLsOgC9b
         qf1Lby+3xsQ9YGiRqFZvmOXgaVFxAtaQxov6s12Z81m50PgzOc9zjyQ4G8oItLMTHrKm
         UY4w==
X-Forwarded-Encrypted: i=1; AJvYcCWPFAwU4LJ89Mb6i9G9ax513qeiGbppLw0E+x/CxhTEuFTYVYscTcedgwFRBFVFob0uRWLxP1opzE2D2F0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3CI2f8iLrTgr3aN3jspWe35+ll9MZ9L4C3aWKPESW+3SUfjoP
	Y0mtVQTf2mKr8B1wbTWUZRsaJeOOIBSimrY8lAn7m4qyC6yXv0J+eWQRxA==
X-Gm-Gg: ASbGncsCpZRoG2crYS5ZRS+KwiTVUp+kySBcCTMohgYOILSUQbn564meItOye/mg9/7
	aQd/BFI1W48wnE7hWu3SOcCRDDETRMkV6LsquFMMs8bksr5VWIn91a1ypQm/XHTFy9OmlsVpBtR
	/U2BD1ZHdoT5bRK6Mg7VHIPmxFAnw20I3n9FP1g+mgubLZlMX8NtysMMQrdpH8JkbuFuBEbU3JC
	N8wCCP4TCyS4RIBTelQvcxSc8Iybyk8EdzmztrCvqxbPp20gFGRXdMqC2qjcg7fL0bZSQ==
X-Google-Smtp-Source: AGHT+IGOgpQygxHN474HH35BO8I0IxWuOevbbQ53X03NN01ieJAvLtEHwfIjUcmb+msVKrMaDxXj3A==
X-Received: by 2002:a05:6a00:3c83:b0:71e:4296:2e with SMTP id d2e1a72fcca58-72d21f4bc9emr28805500b3a.11.1736778051319;
        Mon, 13 Jan 2025 06:20:51 -0800 (PST)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72d4067f0d1sm6089222b3a.136.2025.01.13.06.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:20:50 -0800 (PST)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v2 0/3] net: stmmac: RX performance improvement
Date: Mon, 13 Jan 2025 22:20:28 +0800
Message-Id: <cover.1736777576.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series improves RX performance a lot, ~34% TCP RX throughput boost
has been observed with DWXGMAC CORE 3.20a running on Cortex-A65 CPUs:
from 2.18 Gbits/sec increased to 2.92 Gbits/sec.

---
Changes in v2:
  1. No cache prefetch for frags (Alexander Lobakin)
  2. Fix code style warning reported by netdev CI on Patchwork

  v1: https://patchwork.kernel.org/project/netdevbpf/list/?series=924103&state=%2A&archive=both
---

Furong Xu (3):
  net: stmmac: Switch to zero-copy in non-XDP RX path
  net: stmmac: Set page_pool_params.max_len to a precise size
  net: stmmac: Optimize cache prefetch in RX path

 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 33 +++++++++++--------
 .../net/ethernet/stmicro/stmmac/stmmac_xdp.h  |  1 -
 3 files changed, 20 insertions(+), 15 deletions(-)

-- 
2.34.1


