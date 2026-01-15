Return-Path: <netdev+bounces-250046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E070D23448
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 09:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1AC830C6645
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 08:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A472230C63A;
	Thu, 15 Jan 2026 08:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gq8nLFyC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2306133DEF0
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 08:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768466954; cv=none; b=SeV9uToKXj/bY0l4XY9RN0S2NDYMGDq3aOv8wVou8FvPUpGR88kXcN0UmPh1WwrgXoVavchPSAh3oawRKHCJ/8fo1M0HzQDH7OdrxwbM0HsCSBhe5r3dp4NQMxWki2BKt21bFHnuHLNzO5dqk3AMpgfFy66KEEGu+GsS4Oc/vzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768466954; c=relaxed/simple;
	bh=mcl3xK17r1J/Hcw3rWvyw7z0s1rU1GCdvZrvuwnTmTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VgOp1gAEi0PKTfTMFfNZ/ZaRX/p8mJD+TXirluRtVEBbMpdo3UE8TkyrHJ5P9jYyhW33ggjT30YIs2gJQU0RFv+0i9X07zi5uhfn+M0m+bLPhvX3/Bj2xzeD8B5KB03DHFAD1M+5CnSlZStvAvbGDyKCx62Lbv83WvzIXx+xQEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gq8nLFyC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a0d0788adaso4525885ad.3
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 00:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768466952; x=1769071752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=edU6xkXjAjWZJykGFUAvi4D1HZcCJChoYmvCxl8CEyU=;
        b=gq8nLFyCinZjXkxuFpRnZGfKZoXiU8OciNqHVEASb1zGnbRjoFbn2USsV/+j6Qv9Iu
         K2SWT9c7gC6DS47KJX2evLSwoj6cNn7W3KkiJOKFi+04sbWc+KiyKhPMRa5LGP924eel
         lCxQZqj9dL7e9Az1aoXn16FjibVAp27xjxHq5zoB/YY1rENm2H5/NqbHyXBEvjAcgERE
         jKMsVaYCQbQO4JegBTF/lkfjdSjtd3mJ+HwaZNA3+ciB2TQrzfq2JovnE0NQjvj0ownh
         36kCv333i+Wcw0P7SPGyFPnZ5B3VCalmnOuJd8FgJ30sJFIM74gXru565dmfUSrOocvN
         Ip2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466952; x=1769071752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edU6xkXjAjWZJykGFUAvi4D1HZcCJChoYmvCxl8CEyU=;
        b=V2zfxu78vEMmrvrpJW0rb2nBOhtKPqrIXa0rLGVMwi5gKOZm7Susg9Gkc3Ucc5JHTx
         dMPqfxwHip2c6+SHDP5oKcR/YWgUkrqyJuBQYQUZfdn6Grwkv+3Iv4WAV64pWc51rUj4
         XPCalKdUapRmh/+F3NpC5gmmoIVsB0jQPB9gTWcJUCHngCUyAdrhHYZ2cWQ0cFkJjEP7
         0q+HmYZzq3ImCZ1Jndcy0KvK9Spi0GMy1RMgtdcm5UJpJ5g7D10jed04EKCAXUueDyH6
         M7e/CEJyl7l5CZNzVNuluOgTJUE9X5HCeBzyZTKb+33biegMk5htHfzt3UKRr9MYUWcj
         DVVA==
X-Forwarded-Encrypted: i=1; AJvYcCUOnkpH5nneu5rTvC60iCTdqcbeRVGk3SO4PN1LunkSXa9pud5uDx/8CpMfuGHdUFarzxOCNdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvM/NB3qxypHSpe0AuB+hEJuNuzO/YmwBDA96sgAvCfhJ1IvlN
	l2KFeJclIueR4tVWvH62n/O1t8T5z2cyrV0v3xnWjc+UyXcVT81jQfHq
X-Gm-Gg: AY/fxX5FAfV6mu9bzP+sMNtlOSoGzdnqfLIDQ+1Zs/W3WoJdJpFCv3TqcXCiw6t/855
	zmsCHIcvO8UZtZYnYpA/RpCEoPlhqDv0bzuk4AFI9BXoyrgIB/sPU7J5T6izrffpJuXnzIRx0g5
	E9Ii+SQoYo3tRwG//IBc70eWTxDOMQT4tsnhFqnju/ahmqYQT0kkOd3nsCPxYl5u/J5ZLzW7Ogt
	BZby3MTgWudS48FKDRzHAta1HOSCSABbQNYsRkrByRroM3iR6/IHwVbmFeIT41YSSFwCdYzl7Ty
	KQE/6atPqeM90IMR+r0sW+bgWL2e0Q1a95YQKaUcPssdzmAyfkVLjiwyUeKfMSgbTyH/MjAKpKx
	BO2clBjOavGXDAQJ00IJv9jJ3OrlJerKqmvDWaafGamhp9bti3uWSSMp8LKOJn0ZYrgBlJY3H8h
	bFPoFmsx4fkWGCegQOxsjrV5U=
X-Received: by 2002:a17:902:e551:b0:2a3:1b33:ae30 with SMTP id d9443c01a7336-2a599e3df46mr45989525ad.51.1768466952287;
        Thu, 15 Jan 2026 00:49:12 -0800 (PST)
Received: from nbai25050028.lan ([2409:4090:807d:4601:625b:d547:cf6b:e854])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cd2b3asm243846775ad.88.2026.01.15.00.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:49:11 -0800 (PST)
From: Sayantan Nandy <sayantann11@gmail.com>
To: lorenzo@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	sayantan.nandy@airoha.com,
	bread.hsu@airoha.com,
	kuldeep.malik@airoha.com,
	aniket.negi@airoha.com,
	rajeev.kumar@airoha.com,
	Sayantan Nandy <sayantann11@gmail.com>
Subject: [PATCH] net: airoha_eth: increase max mtu to 9220 for DSA jumbo frames
Date: Thu, 15 Jan 2026 14:18:37 +0530
Message-ID: <20260115084837.52307-1-sayantann11@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Industry standard for jumbo frame MTU is 9216 bytes. When using DSA
sub-system, an extra 4 byte tag is added to each frame. To allow users
to set the standard 9216-byte MTU via ifconfig,increase AIROHA_MAX_MTU
to 9220 bytes (9216+4).

Signed-off-by: Sayantan Nandy <sayantann11@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index fbbc58133364..20e602d61e61 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -21,7 +21,7 @@
 #define AIROHA_MAX_NUM_IRQ_BANKS	4
 #define AIROHA_MAX_DSA_PORTS		7
 #define AIROHA_MAX_NUM_RSTS		3
-#define AIROHA_MAX_MTU			9216
+#define AIROHA_MAX_MTU			9220
 #define AIROHA_MAX_PACKET_SIZE		2048
 #define AIROHA_NUM_QOS_CHANNELS		4
 #define AIROHA_NUM_QOS_QUEUES		8
-- 
2.43.0


