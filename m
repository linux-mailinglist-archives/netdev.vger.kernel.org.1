Return-Path: <netdev+bounces-174041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D731A5D267
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 23:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50E01172CC8
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 22:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA4E25D53A;
	Tue, 11 Mar 2025 22:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y10qmHvq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEFA1DA0E1;
	Tue, 11 Mar 2025 22:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741731398; cv=none; b=D4ke6VGHFjhHokqoCNFEB/PVTS7371FYTf1Skh3z6YCxrEf+FbnZuTVYieckVeeC2X5GCEfVir4Sg+7k4FjLnIp+MsdZS9JEnp8HaBCJU7LOX8uRiDW4p/5czfgPysYf7UBmFyQgHtUwPEKGfslYnFvWmIANaxUs/33xeZv/jvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741731398; c=relaxed/simple;
	bh=v+MkfHm04uBqbnkHofAypxOEn8jzjhH61OSXWV3rwdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a85p2ZynbzPa7AaUgrg+N1ahrqnS1RUxizfsfETWKKO58WBtmOKrRsZkBAAZ8vnC0ResuEPOuCjW8mzDrzQaDI1MTqFzarGaQk9poyoxlko5dFpc3dm38NBIBI1A6wb10X0It9TznrlOKeojed+Ed3YGCV/JRspV/X2+uakz+IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y10qmHvq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2255003f4c6so63271005ad.0;
        Tue, 11 Mar 2025 15:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741731397; x=1742336197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69L8F7yqpk7rwlvw7mPhMhu1JuFrmNtGEQUJDN37j4Q=;
        b=Y10qmHvqLFEKlcaeJ4pyRr2a1ca6w2aJ/cnAmjwlr8oVdVdQq5zEkeX3I4G9+h0Go4
         EkcMTGQD2/JpPorlFXDX4tht+aT37l/E7IWE2P3b6cc3s39soe4HukFxD+4uEyL65kNF
         qX7FBuYARVJBdeSN8c4CguBRHtK2rUDqMRu5Z+/9KZvP7rJNSimfTeMTDU08h9pgiu5J
         4pbwBwwDbA0VfzDCo4U/d1vRe06HqQqVy8fBaFVW7hhsedLVHXfRAKkYvIRYmZ2prphV
         x2wbjcUhz7kKPQSIk0Fstinb/oDTzSmW1rYVxjgQYb63gYXEF3+01zDP/Y3sPS+jQtlk
         8IlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741731397; x=1742336197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=69L8F7yqpk7rwlvw7mPhMhu1JuFrmNtGEQUJDN37j4Q=;
        b=CyQeSz8h6NsfgxzJC+Q8gtrcZimQRmiMrBd1Ra4DiV7hz33Eho1Fcq6hKWXdtEhaPG
         eqD+FL9UcvLH3pZXAHa3JSOodvSeQGY/YwO5nSvnJkasbAcWWV+yU5TpEwihKaTr0G/3
         na5aTptiDC2xkBAtJHZRpxae425CMujDXYWT3JVDHwxsgYpb5ZwW5ShzGh75NypwobQP
         k+N1Qgz7FypK+ZEWGg6PUt9xksNwVT7LqOEkRxh82bn6RITwBnMz+XZwDhzykgFjEOoz
         XQboOpDrCnG7kx2t4I0YwR2DPJdEMp0RzWdxKorYlXA3BiiJeoPOJoZv53t0PK0+Kz1H
         iHVw==
X-Forwarded-Encrypted: i=1; AJvYcCUeCtECkiDsdT5w6SFahLYPiNVjpepeaaOa2i0Z4Tlef+zJV0xy7HS8lS7pcU03CA2TJ9gXQL/4nnsDZak=@vger.kernel.org, AJvYcCWSpX3UwyRzRaFcSCFTnaBwGnr+hDJYxjDwAslzY1WYX+n5D9/U2dUkB9QA8rzWhov7h9/FXUX0@vger.kernel.org
X-Gm-Message-State: AOJu0YxVOUrR194CalCRovsZWWBq2+WhxN4P4Szp9u2xjnMYItV62N+8
	fQBhVzopJU8nLKnvw7X2TnIrjcQfw97p+Z4s4ghImGJKa1rfpRny
X-Gm-Gg: ASbGncuwQrcCqQORrYSF+FIpH++ZfP6LDC8b35shpDlcKE83rJaaS16n8QOsco3AHZs
	LYqUZxYxoHu6CaPR02GMmaCLjNimUanZCpVw9t1BR9/X1U/DMu6mPtXJfhpllWm6HTOdwOYcIYt
	6GO3OxnPaoWfO2Vqtt74IATX9i/xDReoByqlmll+ULQck1XZoTJoMtuKqPlgcGRgJWZ1Dcbr/PC
	XvSeMjO8+4WoHNlD/dl/P8AjxOJ9kHb6nPmoLozxm7O3pyKcc1z0BdYNmQh8C8BA7s0f6k6X8FS
	VIW4YZTfffRuyATfYPRbc1OpIW56nNBuKkv7wmLL9F3bnvBdxW2L
X-Google-Smtp-Source: AGHT+IEj4IL2OsFawJQPS6B8xyYS3KS5TDV3xWalj+aTqDAZPL4UYNjLA+s5rGKHCqxO/XDY4RZtCQ==
X-Received: by 2002:a17:902:db06:b0:224:2201:84da with SMTP id d9443c01a7336-22592e20a42mr50505125ad.6.1741731396731;
        Tue, 11 Mar 2025 15:16:36 -0700 (PDT)
Received: from fedora.. ([186.220.38.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301190b98b7sm113364a91.32.2025.03.11.15.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 15:16:36 -0700 (PDT)
From: Joao Bonifacio <joaoboni017@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joao Bonifacio <joaoboni017@gmail.com>
Subject: [PATCH 1/2] net: intel: Remove unnecessary static variable initialization
Date: Tue, 11 Mar 2025 19:15:14 -0300
Message-ID: <20250311221604.92767-2-joaoboni017@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311221604.92767-1-joaoboni017@gmail.com>
References: <20250311221604.92767-1-joaoboni017@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Static variables in C are implicitly initialized to zero,
so there is no need to explicitly set
and  to 0. This change removes the redundant initialization

Signed-off-by: Joao Bonifacio <joaoboni017@gmail.com>
---
 drivers/net/ethernet/intel/e100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 3a5bbda235cb..f5d32663a89a 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -167,8 +167,8 @@ MODULE_FIRMWARE(FIRMWARE_D101S);
 MODULE_FIRMWARE(FIRMWARE_D102E);
 
 static int debug = 3;
-static int eeprom_bad_csum_allow = 0;
-static int use_io = 0;
+static int eeprom_bad_csum_allow;
+static int use_io;
 module_param(debug, int, 0);
 module_param(eeprom_bad_csum_allow, int, 0444);
 module_param(use_io, int, 0444);
-- 
2.48.1


