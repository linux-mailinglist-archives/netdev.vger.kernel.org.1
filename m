Return-Path: <netdev+bounces-114934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D3F944B59
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD642845CA
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 12:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E4F1A00FF;
	Thu,  1 Aug 2024 12:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mb5KKYzJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8413A1A01DB;
	Thu,  1 Aug 2024 12:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515520; cv=none; b=DG9lWy+Cz4HZNCMzz1nMwTmRPzAIC1cK2liTzJN5WZxJPfupz6YB6IxtdUZ8a+GzR46w3akKnbaKnGVu+ApfnntTcUgEH2ujb7i/TE0g9cQJzm3c3ff43TrQsUra7GTKzzGyq2IbqiXQ+f5bcVOtPpoTcg69wTLHqOVx1La96kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515520; c=relaxed/simple;
	bh=fIFR2Wwkv1/Bg4JV579kNorqhY/E1mm2dkOQPQn8Qik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FaMrRwTclr5U4pPSkbctSEJ56pr6vdYpoioFs9tp5TlGO0kgDQzDPr/n64C31BBKYXZN2HU8WOWf5DN4nEPdju83Tp4ed1gIrzlaPXe7D4ogOlfCx98zLXl0jh8FZ7iBC5sLGxfpGLlQNMfPQUCBcSKrYzuCAdSBAxDlS267UoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mb5KKYzJ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7d26c2297eso849057266b.2;
        Thu, 01 Aug 2024 05:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722515517; x=1723120317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/z0tUMcrWNfZgRHHRE1i9blUtIB4/m+f+IXDrv3vgPI=;
        b=mb5KKYzJQZZT9n8/qZ3rzcI81CgyRHLCyq0rFJGNkaH91kr/tfwzP3LbqPlWYXfgp9
         +JBctKytLzVVRnzDCFHe4yd+PMj52il/f9+tVutoCXHIpIA9hLH8fQrfvoTuBdTxl7yW
         PBtb/h8eiTcz6V+7gyTU88xaGnLxxFlwMDmpliT6LiIy8cMUQZDXNqCfmPZkQBNqzguA
         rbqraXKe46f5Pk/8NO0GFwSFJ59TGh6iacDfKuZ5eIGZXeDDcSFfD4etVeSDPzpnGPd0
         le95SE1G30ZhdhuGDzHpP2RSmzH8+UI2Tf9pIgXn521aSJFs7suyBtIOe7Bv+P7kjb3q
         fElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722515517; x=1723120317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/z0tUMcrWNfZgRHHRE1i9blUtIB4/m+f+IXDrv3vgPI=;
        b=S0s2a+r8QJZYJ5zDwSwiEoWRReJ627T0BnKlKMq/8EFIPFQDYtyBuD2AxrzZUiqhBU
         +YFDnhVfiReeBT1h9OPcUWO37MwAm2YY7oZRtqo91SJ9xm1FabrIXxDwyt7BUNRFoDW7
         vXM1/PibMlC09yDCWlwFj8VvXLDklYnZ2gfAiedXTBn4nDqszJlxb43TVZ/ODCRvRCV5
         D4SF4JTLZzOGtErWruMkhWKB7sfFPgBtsgPCxkWhQmuhFcFcseZ74GugwIcH0E7hT8dF
         dR1n5SensPFm9OK6kJ9unxh0YVCUm4mBmBdtRwHPRebFp3Mmo8YFXAbhAHRqiDe4Te62
         ep6w==
X-Forwarded-Encrypted: i=1; AJvYcCW3vw0Cts4VIj208gGNL7zh4+lT4p/YV0uGqRlYauTk1INRQOQt9bZCtvG7IY98sU2SJ8ilIIlZr1pxy1Y1/u4favwog+q+
X-Gm-Message-State: AOJu0YxfF6F59TK8UMTdkEe+kyCEdV+Td4SHBwUtcaKmVjRtOUzl4/Z+
	8VzRg0E4REd+rPoQ+XRnqLEs/n6HuYxvBPr7hFW4XtUmw4t2x/+N2xbT5zP7v5U=
X-Google-Smtp-Source: AGHT+IG1iJ63H3XYncLvtZ3G5p6NfAziKZENgBcdG3yjEm8JtO9E3FePwunOdDx1feEQ1Dn37vaCnw==
X-Received: by 2002:a17:906:9c8c:b0:a7a:a138:dbd4 with SMTP id a640c23a62f3a-a7daf7b3edcmr153435166b.64.1722515516296;
        Thu, 01 Aug 2024 05:31:56 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab23125sm896146266b.1.2024.08.01.05.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 05:31:55 -0700 (PDT)
From: vtpieter@gmail.com
To: devicetree@vger.kernel.org,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org
Cc: o.rempel@pengutronix.de,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH net-next 0/2] implement microchip,no-tag-protocol flag
Date: Thu,  1 Aug 2024 14:31:41 +0200
Message-ID: <20240801123143.622037-1-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

Add and implement microchip,no-tag-protocol flag to allow disabling
the switch' tagging protocol. For cases where the CPU MAC does not
support MTU size > 1500 such as the Zynq GEM.

This code was tested with a KSZ8794 chip.

Pieter Van Trappen (2):
  dt-bindings: net: dsa: microchip: add microchip,no-tag-protocol flag
  net: dsa: microchip: implement microchip,no-tag-protocol flag

 .../devicetree/bindings/net/dsa/microchip,ksz.yaml    |  5 +++++
 drivers/net/dsa/microchip/ksz8795.c                   |  2 +-
 drivers/net/dsa/microchip/ksz9477.c                   |  2 +-
 drivers/net/dsa/microchip/ksz_common.c                | 11 ++++++++---
 drivers/net/dsa/microchip/ksz_common.h                |  1 +
 drivers/net/dsa/microchip/lan937x_main.c              |  2 +-
 6 files changed, 17 insertions(+), 6 deletions(-)


base-commit: 0a658d088cc63745528cf0ec8a2c2df0f37742d9
-- 
2.43.0


