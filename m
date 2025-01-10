Return-Path: <netdev+bounces-157068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9F8A08D02
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D901884547
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734DC209F24;
	Fri, 10 Jan 2025 09:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byvr5TB5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AF9209F3F;
	Fri, 10 Jan 2025 09:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502852; cv=none; b=X+OA44/wjOGdtiTgFejhh9DCOVXrbgmSXlnDzhaJ+honlRbEnOrNyVRebW8xfegjYYnVJJxmoKAmf2kuRsIGNcXmkqEI5FCXAQsFMLSzJDxX7oYDnvWP3LKQKDGVSRfafzWYMpdNq4EuPb7OPbdyUmFwniGr37OvUMdj9j2mNbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502852; c=relaxed/simple;
	bh=Xl4U1izOmG8HBp/PbyQMbmaeBFubxfAwG1agumbJ6rs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YrilcMuadNMOS4/XAFPST6N1c1jf5cGbGcwH1lWTo4fb7rDqF1wYpX1McrjWwtTGZrwH6LZim4ovYGskaUWo+PiG0o4i4EpkWc7edB6K9tSUTZxQWS0kXmfS5W6s81xSr83nADIZReO3oyr8381wbAClVIuAnIJEGGFGr0g6cvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byvr5TB5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21654fdd5daso29671905ad.1;
        Fri, 10 Jan 2025 01:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736502848; x=1737107648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nFjtc361L1m3WrvhcILanOsHvqG76+wLYkWt5yxv28I=;
        b=byvr5TB5O4n7DVNusiLxgt48iQF+Oe7v+lLac06O709gC4kgsTG38PKuVtD40Ixj8b
         owmnzYR5LaJkwOpuNnAgEs9Edj1dxDCQsVIVvCZwb4Vbc6iUI4vqA9ZRNWn4S8uKT9Ek
         FesIMHtHcHj+rPreolnPxFfmAQSOYfadZWuW0hcgy5zR20JhdLjwbQWKPvFlbo++eFUw
         3f0wMfxG40JS/xAhwXb4B04fKZuvRT3ttkJV+vJWBJ2jFF9AHE8h+0o778lfVz18+mzp
         4MikgCd5T3m5KYdW84n6Kj/DQ4qy6OwUf4MGg45UOJ0xm9Wwf4qXp8OVgyCqL+l9wriE
         ZSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736502848; x=1737107648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nFjtc361L1m3WrvhcILanOsHvqG76+wLYkWt5yxv28I=;
        b=vAiotp0uchdh0b3jT6zF7Y00oBaGWht+PcjTNMLg/gnGY9kkAT8lt3GxZMhUFv0RUl
         pixR/XixPARhuOc7FJJguv+4hUSOykGx8uRj6EP4ufMxQ2h8C3UYhz4DXfVUUMzI5ZE4
         cw5tsb7YuFcSgiSZ6NOj6sy+WIodVVJXSPyPl4qFpucTIMdHMt277I0K+hC6GQL0dCYX
         C+2xdqS4qASQD+QfCeVE5b2UT6H/W+oUkpinkzffwWBXXflyhbpQ69DwbLfdT4Su4Udj
         Zb13QSoz4elKDN/Dj2QBrHYH+YipFatWw/HJZmhxYcYWwhFj715jDEypiwHHn1m2Ie4W
         yDxA==
X-Forwarded-Encrypted: i=1; AJvYcCW3UWd815Z3HkgeV+apjSuMyiyZilGf5/cj+9ep9P0KOCq2l+d8O/zZZpapPkRGfgYwsPV34ZvDvveuljA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdG4RF7BfS/qwf9SQMNc2k/222PCYcQCgjLfp39AfvmTSBZZ0O
	gl52S+6NOi4VBE1hoVex+j1nkpeO/Y+1tSZJlmN8ZRY9itTBYQJbJ851TQ==
X-Gm-Gg: ASbGncuJdrWWuqixauv1qZF9VmsvqB7NscbNyVXGHwI2yHwf65N4tOrvEhE+24i9CSs
	fkVOXed6cvCquxi48ag/idQR5O2zhYCoqYcxS8/uRCkJG5NBKNNldN2iR1YQeQjAADJTczmwNTA
	PzQ0+ns1VWFJ+S2Wl1uffKScQOkzCLc9hNRVePDt7JDm1TBSuOZYc0ogdJ70SfDEMx9mbyOXZEf
	4le1fVL9JM8bOirxnC+la4FqPdirPV2QPj0k3V0cZ0xuaIKMoOuW8TW9kHEZXcV9helIw==
X-Google-Smtp-Source: AGHT+IHidL4NMTe1WTqflVHXmcGk6gO9iCsHE6DEmrgSOMzB5+zgj5qg5pxONnHGy9PfSNiUkL8Uog==
X-Received: by 2002:a05:6a21:4a4b:b0:1e0:cbd1:8046 with SMTP id adf61e73a8af0-1e88cd28733mr15562582637.0.1736502847835;
        Fri, 10 Jan 2025 01:54:07 -0800 (PST)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72d4069217dsm1186183b3a.151.2025.01.10.01.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 01:54:07 -0800 (PST)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v1 0/3] net: stmmac: RX performance improvement
Date: Fri, 10 Jan 2025 17:53:56 +0800
Message-Id: <cover.1736500685.git.0x1207@gmail.com>
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

Furong Xu (3):
  net: stmmac: Switch to zero-copy in non-XDP RX path
  net: stmmac: Set page_pool_params.max_len to a precise size
  net: stmmac: Optimize cache prefetch in RX path

 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 32 +++++++++++--------
 .../net/ethernet/stmicro/stmmac/stmmac_xdp.h  |  1 -
 3 files changed, 19 insertions(+), 15 deletions(-)

-- 
2.34.1


