Return-Path: <netdev+bounces-188867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D66AAF1BB
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 05:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4A81898C11
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 03:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF031EDA16;
	Thu,  8 May 2025 03:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BM9BClko"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EC6155335
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 03:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746675224; cv=none; b=r9rY/OIFSqQkfpxGbK3LXsOIB/qZlFPXmjK24XmSYEuNH0xhC73nX/yUuiyBa7frT5Xvo07UHarFMJsJTv0Nmb1LXYnIK0pPg/D9NEOdZWXkyoTZtsNm5a+ccfXCGbgDg0l2ni/8gFNRZXY9dOnVrDa5tGm5Y0f3lI43ejegvfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746675224; c=relaxed/simple;
	bh=T4Q9uFD3ZLZ7LRpa+cCpaKc16lM/2HTN9yYthC6Fdek=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xs54iHTzYpPXWvksIa4XXfPSJUACUmihi3QtNFfB9IEYJDYzoJiZ3EpuUxkwqLIsiQTKaC/cLWIHGSSsJNQPB9UKXMqPcQEwpT90INnmbjbLCyC7Q0x7ynJz6Ssixx/VR17t+MqeU/hXyh3GBK7siPnRzcd8cp8yifae0rULq3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BM9BClko; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22fa48f7cb2so1541075ad.1
        for <netdev@vger.kernel.org>; Wed, 07 May 2025 20:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746675222; x=1747280022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BDD4yNEsjszfNYx9lT8DUsAY8Oe7hO3jU9PQmGvxdp8=;
        b=BM9BClkob6fcazt75UX/U9/JaGz6H/r98mSS7P9NK8PdwXNbG7z5EUIPniUbqJFKpy
         F1vUI5P3cB6TO/DhNAFNcRWN6En1C86JO4DQrypX2eYouQHt7ZHJ6q+7JqLTDjja6prt
         TWRx4EY4OIkUqXm50Efghz/pI7Zj2SQvSrvNEgzW+6bEkrLRhTLZCwFIWMl0y1k7qftA
         CuCojOBgLrwoDKfhnagQXIQ4VhBTUOEg4R6F1yVuZGA8EC6z+ZN1ot8WhoRzgVPHp8+U
         f08yOTjrBFczuifSq5XMcgaPIPw80PYH5TxBwuCcAZEwjPffy50LO42LD24lwtXUKXWg
         JHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746675222; x=1747280022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BDD4yNEsjszfNYx9lT8DUsAY8Oe7hO3jU9PQmGvxdp8=;
        b=p95+jTzCXYzipXOUu1t1z069XxOSng9qPkTHPGQ1czztDZZWu79iahAk8GTi1kbRhn
         G+LSUcMCegDbMQBQ5iTeAotB+C5giaO4zAyyofOmlfrn5xmNXuB1dXqrRvUduzAVwo+C
         Z+TI18+OASxyi94YJUBFImREBUy5UE3sDMbQmpxFfQW1wHktGwfndRayAmiM08SuvkY/
         cKZmZP6l3zzbmRpEgQOSP7gItcofWnUFSb0LnsGX0cZOUcGvldjYa8+2ATW0P3lRM6Qw
         tkkhufLJ+YyOauz5oLk/5nHjDfX5imYsVkGK/HpR5R2FqTdDhO2WHXp4VlY4XDPxdsSr
         /LfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFM88EtsfJ9Wk3KN3XWqel1jmnf7I3d+6eSmvLmmk63BRRCZUxFttoErt6tBRgeR5Dw5I5CZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF2P/RPwawfVs/vHSRLHBw7DMgpSD7Xm0nx5f/vq/0yrEyWnQ4
	B+oj9YftBF+KSpUxPU83jZY10SlEdMkz52X1jhyzNhlwPGigxPl2
X-Gm-Gg: ASbGncsvFiiCYO+qu3azoByBqYvMUkeRys2JNlRXBoGLfhkJQi0E+SKks8bCwstiO9U
	Zxd0g7Mpl7eDpAo3kQo0M6a+0lm4/uWKp5BtuUyPLkkaNWpKWG3F2B+RjrpUXKhXTkC4oIrlSBd
	T4fa9HwXJupWD73ut3XtrURhKqu0SQfObASEYNd/Ija9tiY8dnqiIjUrA7UGhdxfW6B9NMMoyyP
	CwhETugkvqRNdIl82dVsj/bCau1RpZLeilkyON7Rt3DNBfi17IQz1pYhjF46LGCIyP8gtMdfAWu
	ZR21IseSKIwtM+k8On1586WTuJN0s99z9Kq+sbsLXT/z2W0AVIb/XTFeza3PE0ALZCtuONIRqll
	G1HpM86qp7/xc
X-Google-Smtp-Source: AGHT+IFDlLNJXygEF1m8UuwcdjVPwP+2wnjTRA4umRjmVjJvM/vrOQRs5VsFbED/owDgYFVHwooruw==
X-Received: by 2002:a17:903:19c7:b0:220:eade:d77e with SMTP id d9443c01a7336-22e5eddc7c8mr95430005ad.40.1746675222059;
        Wed, 07 May 2025 20:33:42 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15228ffdsm101685265ad.179.2025.05.07.20.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 20:33:41 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: irusskikh@marvell.com,
	andrew+netdev@lunn.ch,
	bharat@chelsio.com,
	ayush.sawal@chelsio.com,
	horatiu.vultur@microchip.com,
	UNGLinuxDriver@microchip.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	sgoutham@marvell.com,
	willemb@google.com
Cc: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v1 0/4] misc drivers' sw timestamp changes
Date: Thu,  8 May 2025 11:33:24 +0800
Message-Id: <20250508033328.12507-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

I filtered more than 100 drivers and only modified four outstanding
drivers among them because the software timestamp generation is
too early. The idea of this series is derived from the brief talk[1]
with Willem. In conclusion, this series makes the generation of software
timestamp near/before kicking the doorbell for drivers.

[1]: https://lore.kernel.org/all/681b9d2210879_1f6aad294bc@willemb.c.googlers.com.notmuch/

Jason Xing (4):
  net: atlantic: generate software timestamp just before the doorbell
  net: cxgb4: generate software timestamp just before the doorbell
  net: stmmac: generate software timestamp just before the doorbell
  net: lan966x: generate software timestamp just before the doorbell

 drivers/net/ethernet/aquantia/atlantic/aq_main.c            | 1 -
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c             | 2 ++
 drivers/net/ethernet/chelsio/cxgb4/sge.c                    | 5 ++---
 .../net/ethernet/chelsio/inline_crypto/ch_ktls/chcr_ktls.c  | 2 +-
 drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c       | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c           | 6 ++----
 6 files changed, 8 insertions(+), 10 deletions(-)

-- 
2.43.5


