Return-Path: <netdev+bounces-220660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAE2B4793C
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 08:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 855FA3BF030
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 06:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A391EF397;
	Sun,  7 Sep 2025 06:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b="knBMPIJx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63C51E0DE8
	for <netdev@vger.kernel.org>; Sun,  7 Sep 2025 06:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757227439; cv=none; b=KnUKH1wA5Af7apim/bS0AIZad7YpeaIBnk64rNeV36JbGxZlGHxTtqpSmQivLYnqKnPqC0Oj4i4moE37JYWqiRZHW9Fy2tS2uVrh890QVRYYhkY+x1lQ59X05Hdbhc9bNv4SeMbizmNFI5T5lOVve0mVoZ8nQKCIkrKJ9/9lSjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757227439; c=relaxed/simple;
	bh=9NhhGR0/6Y/pCwiJcX1MJ7z/ESU7rNop+X3V4zo/jpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=huQLReKuXOHFdI1pfq5chWkBZ1zrg8J0PaggOjXtpvKhgxFjoYBVIYxVnehsao0zr1wCAC74Jz5Cc7X0ba/MxTJZp4gXdHH3LfluXM1U3rgG1U0hkr0OUVfqve6EUUGz79+89nWMPDDq9Hs+a6CC6v1SZyRxMti/nXH+AUg5cr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b=knBMPIJx; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77287fb79d3so2782980b3a.1
        for <netdev@vger.kernel.org>; Sat, 06 Sep 2025 23:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google; t=1757227436; x=1757832236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OpiguXQuP9x2il0xGwUlgilkQSoa0hn0nGj0TEev2ag=;
        b=knBMPIJxxJaN55XGErCTcQTIdmqCGBfs/CYkVXoHbcVOwaSBetLvTJHCsbksp8Hwfx
         ocMZXXU+pC6n/S1/ZxdaTCmHUL3sOlyoqDfYk12+JEuF3UD8CZ4V+2XGxiLOa4YuuEQG
         9mnFul0x8TIz7ago7CNAWfCnVnqYIRWER3JWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757227436; x=1757832236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OpiguXQuP9x2il0xGwUlgilkQSoa0hn0nGj0TEev2ag=;
        b=gXaRxwvnY9ogkkM5apDmstMKlihlPWFkH7iQIvHeZpLNU69a/KnxzfhyYLv2+NNEX3
         /xBeJ/bEUessyrEAExSXvzklS5KL8a2cOSxcmnkVfn7tO6mq/dUgEV30wZ5a6zGQEoYN
         RsLkd1/HBWkD4acORSmwUJZ7DNPReq97gGT+bBcHqGgdkahVRg0EW73OajfLXfV6QVQr
         SXZsR8vkjWBHxqv7QJ3tNTbTGXOlxYYqEHBkQeLS5LF3EmTsSmms4HihfoPL6iYfdKad
         gE7pu0NZNGPJcJqlzedZMKq5Q26ev9UWyqh+A01tD/4SNbbYVT+hrzzZHI3UQBc7yGXm
         jcBw==
X-Forwarded-Encrypted: i=1; AJvYcCXLp7XxDBbteG4jRrmAj57Wod9qIwVFssH2EYL56f1jPiYWNKNFIWPPE0lOAjQAMxnHbYcaInw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFW9Sq2sDhS3D2I2VMEgjEEtmL0YVAbFJrQRlVZb6ur17bTEYe
	4GwoO9nArmAtjHPHq7YzlcguDMmvnTwTYAes3Aup4fZitYRaUn0ElVjvgg4/Y4K9pUI=
X-Gm-Gg: ASbGnctR5xt43uYWOxonNokbn1dNG1oLQo4WbGuj5PjIIruKD0BjdJpoYE3sb9kcwmG
	99U6mGrxW1kMm/6JKVvhV+EF7IgxUjfQ2b/V8ySNaPGHm0ZmtFsnyLODAyYXKx8nqWtobebwMzJ
	q38Mgv9VspIyPEA19fDMSU6C5v1GF/e29D+ydHQqf663PczofXWVrUJO4X6X0F28yo7pv69JP8B
	7WS/9xHh1+OnKWoj+Nh79w5E+aoHV8KOSJ+KOnRWggb2ZpO8UfpWGdpK5tIg6QeoO/0aqmWtm12
	7Fa/4kx6NxQ6ASUjnBhxTvH8NU2YEyy7sAFDJPbqevlq5hzzvovD+2qUAXeYLd6LCv/iVtIYHvg
	tVo/e2GLnmCG8tj5MexQlCSSpR1cRLkObqvZlFdie8tUnMKIuAFFQScHfL0uqWTu0GfTYK1pTRH
	dddeM4RlX+TjRE
X-Google-Smtp-Source: AGHT+IHP5ScV4aY1LkVwEH2zOVhZNoxO1acZqniabJZLZvIYuHyObbl8YIm7jWrIDyiql/dg/ISb+g==
X-Received: by 2002:a05:6a00:2345:b0:772:4319:e803 with SMTP id d2e1a72fcca58-7742de5c53cmr4568348b3a.30.1757227435978;
        Sat, 06 Sep 2025 23:43:55 -0700 (PDT)
Received: from kinako.work.home.arpa (p1553119-ipxg00c01sizuokaden.shizuoka.ocn.ne.jp. [153.226.101.119])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7722a4bd1ccsm25840740b3a.47.2025.09.06.23.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 23:43:55 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH] eth: 8139too: Make 8139TOO_PIO depend on !NO_IOPORT_MAP
Date: Sun,  7 Sep 2025 15:43:49 +0900
Message-ID: <20250907064349.3427600-1-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When 8139too is probing and 8139TOO_PIO=y it will call pci_iomap_range()
and from there __pci_ioport_map() for the PCI IO space.
If HAS_IOPORT_MAP=n and NO_GENERIC_PCI_IOPORT_MAP=n, like it is on my
m68k config, __pci_ioport_map() becomes NULL, pci_iomap_range() will
always fail and the driver will complain it couldn't map the PIO space
and return an error.

NO_IOPORT_MAP seems to cover the case where what 8139too is trying
to do cannot ever work so make 8139TOO_PIO depend on being it false
and avoid creating an unusable driver.

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 drivers/net/ethernet/realtek/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/Kconfig b/drivers/net/ethernet/realtek/Kconfig
index fe136f61586f..272c83bfdc6c 100644
--- a/drivers/net/ethernet/realtek/Kconfig
+++ b/drivers/net/ethernet/realtek/Kconfig
@@ -58,7 +58,7 @@ config 8139TOO
 config 8139TOO_PIO
 	bool "Use PIO instead of MMIO"
 	default y
-	depends on 8139TOO
+	depends on 8139TOO && !NO_IOPORT_MAP
 	help
 	  This instructs the driver to use programmed I/O ports (PIO) instead
 	  of PCI shared memory (MMIO).  This can possibly solve some problems
-- 
2.50.1


