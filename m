Return-Path: <netdev+bounces-212054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A083AB1D8BF
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 15:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D19724146
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 13:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950F6252900;
	Thu,  7 Aug 2025 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+NQsCx2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2146191F84;
	Thu,  7 Aug 2025 13:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754572545; cv=none; b=K4zOl+rr9x2TmGHJbt8QO1cgoxjx3Y1DxE0dIywFJIGF1XepYVcW6xI/dHWnAW5vzy5fl2KLy8eAIdccK+zrRs28PIpFa6+s1yzvWIEShN4qoTEcdKy7fGSAE2z31JqWBmyr9fmCaGvlcbc2zdTDDjzAgLL+vIh5RNKdduU0Fcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754572545; c=relaxed/simple;
	bh=PC1Qx3ySQrnwhSPp6gHnIParaisBxDPrG26FiRlnL0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oh7y+s+tmVMB7xfElRJgkRH/OqUMIAfVouLdn4sb9Df/gbaFNGaaEJBfD5c0ziFNB/R8tNLB66TgEAhYXVBCiRVW78Jy6QKIC6EMpOXRR/SMNR6Gf9uXodYOm5fEpFZzx9ZQWJadJhLqZaktEVl7nZdf2rQa1sExfF4V3CARkoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+NQsCx2; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-459d62184c9so6410405e9.1;
        Thu, 07 Aug 2025 06:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754572542; x=1755177342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T/Elo2MUTB6Vn1PUhDPXwkwYqbWpk8OjBvFLAxfq4Wg=;
        b=Q+NQsCx2tpiY8T5Lj8o2CkVDDRLeLjKdixsRgqq3PNc3RVoT7Qe0J54+nvGUGHDkf7
         tp9YqoMNPnxv0qEPsKIzexZmCQ7EhQ8nzh0ZIIecajSB0ErG9DsLmCh6U6Ek7aB0WZPS
         aPau0L92+/Ah5CNavlDQctIk92n8yA6TA4+ie8qy+ejzA0DYZOKCmL1wGyzy4c0FSB4K
         wAz8br5EVxwr6KmPGSW9ypUZN7nbc5cvGvfYw6T/48RVRFEH7EqUT7Dm+46JR6b7x58L
         1niKjjYD38BWBG+XxDFHScYnBwo4eLoevoAnK9bY5WJnMMc8w6b0mNYQE0lfEjz1qZaF
         WqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754572542; x=1755177342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T/Elo2MUTB6Vn1PUhDPXwkwYqbWpk8OjBvFLAxfq4Wg=;
        b=DEWOB0MQ5pP1XGubzqpVYb7Clp7+eI4Rk3V3K10D5idswWxmcvnGyFFyKG34aG/GsM
         I4qjeXz3bt788qQ+nKvD8OPzx+EIjmU36w1NwNAUM4Cyo+6cVTRD0OYPyIcHU6os2xaO
         qwJi35bY3u5sP55+5mXQt4r6DnHyBRMopW72IS6abCxySlLQkK097ax5Y6u07cwmuSid
         FmaeaW5LoQvzMx2t6fONX+BKCa7DGLtfFdSTzF19umWOtTS/NUjGYGcM0BLu5MkaZG1q
         DTiNh2ycQzVhN7Ws4eNCs6L0+Yl+E7VCu9Bozg529iWYTGSNe07EQuhwv/huxPYI9LNc
         bpyw==
X-Forwarded-Encrypted: i=1; AJvYcCViu/CY8C9smQvyafzIT1mRHPOEwOmMhn0qldJ9qyeffh6gAnrOpPJma6cwDOngPMC0Yo08wEbdccXdS5c=@vger.kernel.org, AJvYcCWLbivOBithsbLlsL87p+t+H8913Jsr8AXhMlE5rgZLe/TxmwHs2haTmKW+VLj+AaEvUEz5tD68@vger.kernel.org
X-Gm-Message-State: AOJu0YwO2/4TDZZyWwPd9bxhxYPfK76xbenPh1m2HUafRmoiY835zwV2
	HBprFRJJjATxt9lAx+jRXbiI37DFdph0snc6tfeV8vQttW6uqrW+yh7/bwH3r8ENl0jTyg==
X-Gm-Gg: ASbGncsYQsM79f6iUQx/IKAIZJWFbNOXXg8zwW4S0aunGev4UK8lgSB2ZeIHdWm0hvl
	OboSQrQQ0ej72tJuUDEQsScr+9RdYp2vvMx6C5F12hk3KEZqnPizjdug1JYUzpNKHr1fEyo+Jtu
	TT0L27znsiypezCzOo8fvyZWosafAMl7+t0rIzMAxzWaG6/3Qy+gK6iuTzRR53AU2feDmZyOU4z
	ozdNCM52o0QdCtYoJSCv5rPByikKHF8z4JgF20lO3qjDbT79CgmUo/NQ2bB2ClGobhYfjxW1e+l
	BD4V4hb0HoSXV0pbs1Agzl+8+rR3urJ/xpcJWyBJjkdQ2ipaRvSYxcoXNo9fUEChnWgZSeHop2J
	0r4Y9hTIrZQE8+arf0ZkBq3+qkRYA6hs=
X-Google-Smtp-Source: AGHT+IHBZX8/gLxxU0sgoAYhuaC8Y6Xs0eg1d+9FmJDYjXwojNuHv2mfe+sV59j/bpFM8jIHAiU21w==
X-Received: by 2002:a05:600c:4e8c:b0:459:d709:e5b0 with SMTP id 5b1f17b1804b1-459e707b412mr57851895e9.5.1754572541674;
        Thu, 07 Aug 2025 06:15:41 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c453aeasm27736616f8f.40.2025.08.07.06.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 06:15:41 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Frank <Frank.Sae@motor-comm.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: phy: motorcomm: make const array mac_addr_reg static
Date: Thu,  7 Aug 2025 14:15:04 +0100
Message-ID: <20250807131504.463704-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the const read-only arrays mac_addr_reg on the stack at
run time, instead make them static, this reduces the object code size.

Size before:
   text	   data	    bss	    dec	    hex	filename
  65066	  11352	      0	  76418	  12a82	drivers/net/phy/motorcomm.o

Size after:
   text	   data	    bss	    dec	    hex	filename
  64761	  11512	      0	  76273	  129f1	drivers/net/phy/motorcomm.o

Reducton of 145 bytes (gcc 14.2.0 x86-64)

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/phy/motorcomm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 0e91f5d1a4fd..aeae7ec897c6 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -536,7 +536,7 @@ static void ytphy_get_wol(struct phy_device *phydev,
 static int ytphy_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
 {
 	struct net_device *p_attached_dev;
-	const u16 mac_addr_reg[] = {
+	static const u16 mac_addr_reg[] = {
 		YTPHY_WOL_MACADDR2_REG,
 		YTPHY_WOL_MACADDR1_REG,
 		YTPHY_WOL_MACADDR0_REG,
@@ -608,7 +608,7 @@ static int ytphy_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
 static int yt8531_set_wol(struct phy_device *phydev,
 			  struct ethtool_wolinfo *wol)
 {
-	const u16 mac_addr_reg[] = {
+	static const u16 mac_addr_reg[] = {
 		YTPHY_WOL_MACADDR2_REG,
 		YTPHY_WOL_MACADDR1_REG,
 		YTPHY_WOL_MACADDR0_REG,
-- 
2.50.1


