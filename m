Return-Path: <netdev+bounces-135044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C0599BF35
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 06:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6DE5B2186F
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 04:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC0C288DB;
	Mon, 14 Oct 2024 04:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rashleigh-ca.20230601.gappssmtp.com header.i=@rashleigh-ca.20230601.gappssmtp.com header.b="cEBI9QAD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D5B4A1C
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 04:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728881479; cv=none; b=ZzU1vWzEESKUyTmX5QlJWH84aU1w465/R+scZKa0j7t7ejllK8mcFdqPqdaNDF27gQ+nNCt16sWsoBxNHN9Ctk4M65fnzzp//MF5poSkGeoy1iaIXHCDPt9WKfQGFgDAfws4pqtFCqkRZ65BvJ4wLDycAsM1YmY+vZ8tO3DgZvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728881479; c=relaxed/simple;
	bh=szngIC35k6CKPbcTAMxtBGDJIKxmU5ECzgawAmP75eI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V6NsORfR3r9Zw15xPA0n7NcQ33as5fAgweuheeYQUnOPIAxcfoLBCJbBzMEqa8aIS3oavOYVKsM0OUHnuHjUNuNyQl0XyffQfNG7QrEgKMlQQ8OZ2aaLz+K6LeV63Jg9CbSeTwoH/uwcqFS7OcjtHc+BcmbwrJHYupkGH8iJtNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rashleigh.ca; spf=none smtp.mailfrom=rashleigh.ca; dkim=pass (2048-bit key) header.d=rashleigh-ca.20230601.gappssmtp.com header.i=@rashleigh-ca.20230601.gappssmtp.com header.b=cEBI9QAD; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rashleigh.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rashleigh.ca
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e2b549799eso2669863a91.3
        for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 21:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rashleigh-ca.20230601.gappssmtp.com; s=20230601; t=1728881476; x=1729486276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RnXyrcF13nH7Fsy/SloXfO7Sw46e4tPjxRhFLLmjMds=;
        b=cEBI9QAD4DRrnyuxM0bfxQKE7FQBzAMoM0YX+0qALla1pMIaSQ6H52nrJaE9f3OVTt
         YBp5x3Ppbmh6pL2R9C5AInSsmxNx3Yum932SdhR4xtDVliIi1rL0giSTVA+xeVqMoe2a
         MgpIma9PDkZlxPnDGXgDeI7gFPpSO/JZXs5lhxgEw9Z69U9YN7pMN8v9VsR+KnMqxOv8
         aLgdbY6QIrbWdi4NOg7akd/d1VkkSoafLi5/ayEbHQlnUyTKi09pbKKl7vl/upXfmOnc
         oLHVJuoZoQuQLfo5w9nhPq52dC77u7ciVYHfsHH2f0GWBsgIUF3z6UAK7mjtLgyQpOVA
         rr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728881476; x=1729486276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RnXyrcF13nH7Fsy/SloXfO7Sw46e4tPjxRhFLLmjMds=;
        b=AmHk8yHF//dzRx6zKRinYaBPEzuSo8BTOuLgbKCuXbn9QWwoGjxKamRKQTDhFYGK3W
         vQAGuskDNnNds77qojvQPs35Aq8tie/U/cp6w2kt80R+ktYE3kCmkGdOBHz45fvMIBwm
         4uc+6WSDPlQ+TaEVyDsgqWksZY38mAUUAsxzRYVRXi4xlMyz0+ZKitRF+gFUoujDj1or
         JNDnmBv1DHF48F8+NJaV4+A0bMteE6H1x7Dpn1XrmM338zHqZ8sTi5roSE3vj0jd++Z6
         hTPrcxCjj4iN1A+OGaGHC2AluQLGU7erj/4ViStss/Omo1iM5hEUEUn/iqNbZLS2u2sy
         T1Bg==
X-Gm-Message-State: AOJu0YyZ53+hf3jqFlpw88kt51HOY61o2TSMjfjEWzZIRSXr1atxEU6r
	6/gu2A5jRzHEmHNSKFZN3zh7ydIz1Riqv4mL8g99VdjWcT4hxIEwYnnyDJ2zjLA=
X-Google-Smtp-Source: AGHT+IHwj2gCcM55X8/QEu6zcXIhaqXCYMJPJUXF9myIe+Q+OnSxstf+86mokI0AHpZ+l+GZuHvwTA==
X-Received: by 2002:a17:90a:17e2:b0:2c8:65cf:e820 with SMTP id 98e67ed59e1d1-2e3151b7869mr8785918a91.2.1728881476052;
        Sun, 13 Oct 2024 21:51:16 -0700 (PDT)
Received: from peter-MacBookAir.. ([2001:569:be2b:2100:90a6:1ab1:2ac8:9cda])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5eeb082sm7738860a91.21.2024.10.13.21.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 21:51:15 -0700 (PDT)
From: Peter Rashleigh <peter@rashleigh.ca>
To: andrew@lunn.ch
Cc: netdev@vger.kernel.org,
	Peter Rashleigh <peter@rashleigh.ca>
Subject: [PATCH net] net: dsa: mv88e6xxx: Fix errors in max_vid and port policy for 88E6361
Date: Sun, 13 Oct 2024 21:50:53 -0700
Message-Id: <20241014045053.9152-1-peter@rashleigh.ca>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 88E6361 has two VTU pages (8192 VIDs), so fix the max_vid definition.

Also fix an error in mv88e6393x_port_set_policy where the register
gets an unexpected value because the ptr is written over the data bits.

Signed-off-by: Peter Rashleigh <peter@rashleigh.ca>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 2 +-
 drivers/net/dsa/mv88e6xxx/port.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 5b4e2ce5470d..284270a4ade1 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -6347,7 +6347,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.invalid_port_mask = BIT(1) | BIT(2) | BIT(8),
 		.num_internal_phys = 5,
 		.internal_phys_offset = 3,
-		.max_vid = 4095,
+		.max_vid = 8191,
 		.max_sid = 63,
 		.port_base_addr = 0x0,
 		.phy_base_addr = 0x0,
diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
index 5394a8cf7bf1..04053fdc6489 100644
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -1713,6 +1713,7 @@ int mv88e6393x_port_set_policy(struct mv88e6xxx_chip *chip, int port,
 	ptr = shift / 8;
 	shift %= 8;
 	mask >>= ptr * 8;
+	ptr <<= 8;
 
 	err = mv88e6393x_port_policy_read(chip, port, ptr, &reg);
 	if (err)

base-commit: d3d1556696c1a993eec54ac585fe5bf677e07474
-- 
2.34.1


