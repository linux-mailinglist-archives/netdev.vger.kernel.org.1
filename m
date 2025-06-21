Return-Path: <netdev+bounces-199956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C62AE289C
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 12:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 365FA5A08B8
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 10:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FD91EB1BF;
	Sat, 21 Jun 2025 10:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqBdapiB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4412130E842;
	Sat, 21 Jun 2025 10:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750501949; cv=none; b=L1o4zwaQFUKgiJuYej+86od1HYkgF3zCdWOyU76qVn86sj1Ki3uM1gw/ssTn9Zh3AdG5LJHzh3Sz87VVtJOfeTLwUBJrVewpXPy1uuFh3s+VYhMq4vB9huRh/QKioyyK3/Y5aQU295MI3w0oF1Jw8e3W1/279rQlhVdxZqulc0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750501949; c=relaxed/simple;
	bh=6zdtW4ZsWVEXC+13yFdtzSL8MneybnvekLwrAzlWTow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q0zRRg/DHo2yeHFZ1c1GtPSptirxkYPM3nauoY+3Mz32uiP7AX0kz0Lnhv307SH1d1+piFCDgsCR6or1sBG2XFCNCBrne3v1GbPpe2RDQJ4+gb1bQBe3nqojlj0O/ChlOR1fGq/kI0TO+Zz7mReLNTyep2HqjacxxBuf56MzXps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqBdapiB; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b31c978688dso1458258a12.1;
        Sat, 21 Jun 2025 03:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750501947; x=1751106747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=012KofByWzR1UXs6q6FS6IJCSkgS2EX290wo0slGf5Q=;
        b=iqBdapiBin18QwTSewE52Lxy1xpCoU2op6OXi4eems7Vc2s3ijH3Ly70rBs4a3EoPO
         nDngRhW5EQPI/ZLhLeYxfc6+MQCYwsJ8ofVRMmPnkTAHEx0DiT0621VZaT0mJFUDJD44
         O53VArPrmhqsB5Y4Exxf90Hoi44ibWbkUsL3fZXk69Hjq/wDBagqlOzdTPyAizbCX3l5
         NGr24DQyu7GfD++IsatZfvaunoTnwWiAeyg817NGwGm3HQWS5XD8/JM1urHt0dZxXz7B
         mZ7xjQyhmH22jfQ0RhbXD1F4g6Rf2xg95x6pIs8sNg11kVUX4eu2BPcDZSv9NDv1QgxJ
         aLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750501947; x=1751106747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=012KofByWzR1UXs6q6FS6IJCSkgS2EX290wo0slGf5Q=;
        b=sJjY49keOSbI8qK0Slu97e4jks2t2JdsIRMExiln99DzBxC3krrX/8n61zEsXJShI9
         yBu6o2K9RmVbzuoRO/Zb7ouhPuAN+eJgAmwGPyUpyQ1b3MXZnzxjRooRBDT5KQPTz3Fp
         OZRhmRxU28f9NkunVJhhSpexnVFlky95F6MmFPufEY0HVwlJuILv/xpjG3jmTHzxL0R/
         2h7o6dQLl1cJSanCFMdzKe089kyYM+PTNR+7F5a6pKiRdBl18Lm9rzOmQ683yP2P8IxI
         qmHRhAEXOzTeyNHrx+lc4SsH/AJJEYUK5CCW1CFL8cpDp5dOKyYO+DsQLm73GYlvgG93
         W9dA==
X-Forwarded-Encrypted: i=1; AJvYcCUL7qBXc5LUP0NTzsQW17zik4sRK53FVzGy5LR0Ud2NyCGzwDz7pGftwArGwv+r+k7URSj2FY6+kEo9uC6L@vger.kernel.org, AJvYcCWPFqNAdvwCuKEAE5ZBuitWbzMsiVrC4QEawoj5VWc/ykgv/+x3PpMD/Uht0o/uOBCIJM6ULp2GCoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCnfyEBaZw2Mx7ftMvhbcLXqwTkb0iCi32JYTNE//5RN9OIYLg
	gKhXGuwkpK/7I87A+OBEFFLtsOMs9Al+Rjgbkg7zag96AMGZypliznLw16nnq5eN
X-Gm-Gg: ASbGnctvRdSfk9Paa9R32g2a2nP1N8zHmPcOjMICbJidZ8rgIv83jEblMSfsgyS63wR
	nMLMiesPiizA344o6VdpEnf7BFbFnC2zBLBi1hrc9eVm28rJUiQG9wPKj69fj9zx49kPYQzvkgy
	OElFWiH8s51mDFcZloX3KxOo76IK83lD55fszyZ6GarNC8iylEqflsa7jsbrUTIFy9Gr0OK1FBI
	9MtIzrll1V5XTJ0XES4QAIalJ43EkolQCrgnaoXViErtEi7cnenEOChtdjn17hgdQuFvqp8EUAE
	4uPgSALP/Q5gnkgqJLX7jDlk41wTlJ3Kml2aSJSQpE3Fds7C24PCIcdE75DkTb8cN72iJcRji/U
	K42phLXZeBQ==
X-Google-Smtp-Source: AGHT+IFvir19QObe2nVc1F6Xwx+QcsI5R/E4xY54gUD+iJiKIaJ38TEmYQc1r84maQZfk3j5qrRbZQ==
X-Received: by 2002:a17:90b:3dd0:b0:313:2768:3f6b with SMTP id 98e67ed59e1d1-3159d8daaecmr9171605a91.27.1750501947373;
        Sat, 21 Jun 2025 03:32:27 -0700 (PDT)
Received: from faisal-ThinkPad-T490.. ([49.207.215.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a24c3fbsm6177890a91.21.2025.06.21.03.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 03:32:27 -0700 (PDT)
From: Faisal Bukhari <faisalbukhari523@gmail.com>
To: sgoutham@marvell.com,
	lcherian@marvell.com,
	gakula@marvell.com,
	jerinj@marvell.com,
	hkelam@marvell.com,
	sbhatta@marvell.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Fix typo in marvell octeontx2 documentation
Date: Sat, 21 Jun 2025 16:02:04 +0530
Message-ID: <20250621103204.168461-1-faisalbukhari523@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
Fixes a spelling mistake: "funcionality" → "functionality".

Signed-off-by: Faisal Bukhari <faisalbukhari523@gmail.com>
---
 .../networking/device_drivers/ethernet/marvell/octeontx2.rst    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst b/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
index af7db0e91f6b..a52850602cd8 100644
--- a/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
+++ b/Documentation/networking/device_drivers/ethernet/marvell/octeontx2.rst
@@ -66,7 +66,7 @@ Admin Function driver
 As mentioned above RVU PF0 is called the admin function (AF), this driver
 supports resource provisioning and configuration of functional blocks.
 Doesn't handle any I/O. It sets up few basic stuff but most of the
-funcionality is achieved via configuration requests from PFs and VFs.
+functionality is achieved via configuration requests from PFs and VFs.
 
 PF/VFs communicates with AF via a shared memory region (mailbox). Upon
 receiving requests AF does resource provisioning and other HW configuration.
-- 
2.43.0


