Return-Path: <netdev+bounces-196352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E38ECAD4595
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 00:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46470189E364
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 22:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00EC2853E7;
	Tue, 10 Jun 2025 22:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jagkgjAL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F328329827C;
	Tue, 10 Jun 2025 22:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749593059; cv=none; b=X7wpnHBv8o8zFP+SY06Drk1FcF+OTIFrf1JppnuD2E/kkNBBD4kvAZxC/IMwTnOAlxQ7Z9WzqFY6Sdr9an3cEuS4k/Lw2N9On0ENejiK1hG+5oXSgT5qPhXodKPIn/hLBOXXyu2Caj7yK2qc9NFO4+I+2BJZrbt8BvdEANzsSPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749593059; c=relaxed/simple;
	bh=zuDTL7cB69EL+PgchjhF1SUAyQ94xhf+ydp3hPzb0kE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JultSG3w2owllnHCB+f7hwHH0M4Ow8TpKbUL8S2ZPQYQ7bkWJOr1+VjACTkuDnFkQsQaB7BDlPkbpsjHt2Zcs9hBaAjcWc+sOunCn34AT2lb6VHai/lYfbKeo4oz1GnA1FmC6hfmtTYdRuqlf8qxwjZd74zgdEqcY7+Uxn6lnb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jagkgjAL; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ad89333d603so1039322166b.2;
        Tue, 10 Jun 2025 15:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749593056; x=1750197856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K/+E654N6VLDLEVmc+jj3F2mGdbgofFxddmyLbhAauw=;
        b=jagkgjALL1MYKm6IiDl6Nq8eZP/sIZ8P6ylXmB+iiTDi6WCAnHVihNkASXD15/Rnue
         1ECzFYTDl8VqVEuG9QmQkH9hC5+1/6GIjvE8O91bVo8Kcupu+RvO+DmbSYlOx3yqYZ4U
         iy5/JMMIfHUSBqeEYzi6BwiSWorHnrTtMgVH9C1cPGbu6iNZGFn1b0N8ga8wA/OMADLY
         k9veINdC+JcvUWecSTBtDl2Fv1FokMYVi0HGGj1fKC+8alzeNInsz1raDZ+X59nmCAZd
         qf8szZS1gGNJiLpjBp3UGLAN8x5GRjUUQ9YO7m6BgIcHIBlTPNmDdaFSYKgeicZy4AWi
         Xsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749593056; x=1750197856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K/+E654N6VLDLEVmc+jj3F2mGdbgofFxddmyLbhAauw=;
        b=iLE4LJOK1AMHSP6jAJV3Oor4jEjd+2uTRRIfQZwKMouEjp49Cw+EqNA2PY/lXZfDkT
         c9qc7sUGQtg9lbLBI4/uYkqf0N8/Fb//PEZhUmk64GSLDqyvQcs2e+AwvA6svEhPVYEf
         D1qkFDDI0EyBbzm42IX8EnBosiNswYE+Sc3SVVdclce3CS8b2YvFQeYCTeM4dCurE26O
         WspVLc5R/l5f9bAjXGpzXyJBeemq9Uvd3zUMaO/iDyhNuAuEx8F++EfqnSqGeBu6USRv
         s4MsQQ8GoSpwxY9MRuytIXBrF51AteJg3ZrBmgRGs2eJ5Hvg4abtDGnrXcOu8g/+81PG
         tciw==
X-Forwarded-Encrypted: i=1; AJvYcCU60gF63qKIHsx9/RQOb3WdyUxqzU/k6zByOrb1FyT70xST/0MwwvvhMeIHLbvFYopyKU19Ozzj@vger.kernel.org, AJvYcCWiYid5GvrGG+AnLEstMzdRD3M1UnxIwBNg7CNXSW6YuzzJX8Dm9MjRyWVRc1NUvLwJKPqooMZuX3RJtiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaYjOyAbKlWXJg+Nq8PBWQjOfsQEcVtMoJrZr8H2uexkT9guOG
	y8tUnDXxm4/BuYxprXYn7HEEUcJYYkuhvoZ2sws8sSgA2QL1eWpk5jI/
X-Gm-Gg: ASbGncvn7aYfGwwxeUjbSJ/f9sjipyr7VsNFJYlxESDEqrJ96MC5ok85wDuz1xeTBfu
	+M5j+BlRLXl9nJJf/wGWvn6I249LHbHZ+TCrvjWH/pSsxQftJErHMRJw4KNIFRjMCCwnnL05Jrs
	SOFwd1wtwV/FHIMnrbnyAM748ZixTb04BhtfZBWbbrBMDHt4sC1soF2LCBuILIOeRo5LlJJ9lZ5
	6+/zx4xepJbhn/8BclEyP11ctHUk3MaHzjzd6SHdld5G3S+0LU8Gy3hIH3iPd3qEuHpnx2rr/TT
	5e9h+PO5NY5TlR4s7mrqoji1HGkPB8P89wYLR9Xemfpcb6mPn1fliF4alW/quhrHQGpqMat3
X-Google-Smtp-Source: AGHT+IF0y9gsafkfdgzOI8WGlKN9xQjK1l1hBzmlJoby0dwZol5QNkbMUMFpeHOKWBP3YSmLR5aQgg==
X-Received: by 2002:a17:907:97c6:b0:add:f2c8:7d3f with SMTP id a640c23a62f3a-ade8971aba2mr91122766b.33.1749593055974;
        Tue, 10 Jun 2025 15:04:15 -0700 (PDT)
Received: from debian-vm.localnet ([2a01:4b00:d20c:cddd:20c:29ff:fe56:c86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc7c92esm785605466b.168.2025.06.10.15.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 15:04:15 -0700 (PDT)
From: Zak Kemble <zakkemble@gmail.com>
To: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Zak Kemble <zakkemble@gmail.com>
Subject: [PATCH net-next 0/2] net: bcmgenet: add support for GRO software interrupt coalescing
Date: Tue, 10 Jun 2025 23:04:01 +0100
Message-Id: <20250610220403.935-1-zakkemble@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reposting as requested here https://lore.kernel.org/all/20250531224853.1339-1-zakkemble@gmail.com

Hey, these patches enable support for software IRQ coalescing and GRO
aggregation and applies conservative defaults which can help improve
system and network performance by reducing the number of hardware
interrupts and improving GRO aggregation ratio.

Zak Kemble (2):
  net: bcmgenet: use napi_complete_done return value
  net: bcmgenet: enable GRO software interrupt coalescing by default

 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.39.5


