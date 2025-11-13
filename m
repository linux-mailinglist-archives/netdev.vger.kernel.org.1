Return-Path: <netdev+bounces-238441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D76C593BC
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 18:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 131BB561C56
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 16:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA1835B15E;
	Thu, 13 Nov 2025 16:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPLS8P+j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFE935BDA9
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 16:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051593; cv=none; b=JVbqiC26ArYPwFmnHmLiJPZgoRPXO3yqykBl0HZwueiuCgQRHnU30nmRVsXLlbyf28sg6yt7RcQMkmjmbN++V7TvGHGpi3m/lV2DEdVSC1dVHIQhKe+mbnis07HUBfYk749esIpGAHkW+ZuCspL575tZw1fQLUmU0l2R8aR/DgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051593; c=relaxed/simple;
	bh=zEWuOk6Cahvg101MiDUZeGIYgl44y1xv6EwZJnX6THE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QIgzdmF9JU7NL3fwSTvMaOcXBeD6yB5JL5WL/1hiYe2HSH/GX/ZIiAJNhIsLkslDcbtZ76TaGb0oa3zHJjJDqzN4qHj/S+Jt89nxn4Z0D13h4anBP/nFUF57R4qAelKwJ28aBCfp1eDqCEz9ZRZP098bL3jQzF30r4MGQVlhTLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPLS8P+j; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-297ec50477aso7371345ad.1
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 08:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763051591; x=1763656391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tfPwngs/3fFupqsZjREFGxo0BssV5yxfy/aEtAPrGS8=;
        b=XPLS8P+jLnyJ2/LFa+EWmYDTCPwmgKx7G+8Mc0KBltv+zZJUVEZy7zzJJ3dU+IZDg3
         wVnYal6UAMkiCVPdUUUhwWqM6870wFiQSklvM95RW8XencziG58jLCUlwC5Ef6r+UTN+
         9bGhwZCgnvVO3OpePSxuO/MDW2C+m2z9D6TyE1EoZiLKqpKtFOYSHm+i7VEzyTlO1ei8
         ZI9qw3YZqXgXt0q7XL3A8fuAqGH1hu7aOmYr5fT8kmGtSWhYs/2GrkSTHyNziZaegRU9
         yxow10z3uoXOMEAYdrjA81qIMSxNT9xGJBNXj48fpRJNW22H2sN2RKlODiRcAiSVtpwZ
         iByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763051591; x=1763656391;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tfPwngs/3fFupqsZjREFGxo0BssV5yxfy/aEtAPrGS8=;
        b=tzTLSa9QAZBB5j3KSZpSAPJzilMMf3WxcUObjWFRi3j704p/u1ijRoLfgFAJsplAKA
         KsjijE0qyNRH8s+oJUEF6II27D9IzVc7YLGFVuZ0VtJYSL/NRvUpW0dUsOfEcFHVflC6
         7WdpakFoZ27bTmsHS7clmvnGkgBGm5Zq6X7hP/HILHgp7/ybfjD/Bcbq+fS2kwW2V7pD
         4ZMY4vjEX+On54bUsUmfSB64ptDOI9fbhnkqJz7NO2oIz+JNMEnH+e4LnMmXZAVCCgah
         Lx6qkftPQpVrFL+V461ZwWTb3ySCxG/nE4IUTo0exiTafcFilVS2XtdVFtFk8D8ZYUgd
         wxeQ==
X-Gm-Message-State: AOJu0YyxIC8TFAbAf4MQalj0Mb+q7zjX9U9zZftcsIUzmLtzBJQ7qKUc
	PN0+9Ses30STL2UnADUwVu/C8FRtXb9q+Bh6tH0idEv6ykXymvoS4NYq
X-Gm-Gg: ASbGncs/2aqeCeeT5slfBejddllbAZ1ukehQcKThS82eG9gLTnriLctFaWVbRlWHK1L
	gv0o0vIig9ToB8DpKpsXHeAV6u5Bds3ODep0zL4frLabJK/klf7neXlzYFdDy6oJi4e2jNbIlcC
	NGprfZTiBz3Mfw3naWTffNFT3iAFfrFMOWxiUVqUfEW34fitJpurKCqaGr2qSvPDWS8MdqoJIWm
	kmlRQPgjdnLqUCtKibFJOMeKTuiaNDJ6geicfURCL1zCSymTJPKuaGcifbHmHhV+nEbUCIxG7+/
	dWdyW/Nw9LcFQE27/FNpkMAfs1vYIINSqwLenskJfFVC9Y9bhLpKeFuL4fAqdOFHIoyD5Ik5rVw
	8STz6hvWLBD8RcWvy9xAg1hy/8x4Yol38GVmU5bBq+IKuXNoweUX0R2MVvUeeBk2lVF/K6zvYa8
	JU7r6NkrU4r7q8M5Z6r3Af/Hm6HviMhiLop+sQ6M0rodw4
X-Google-Smtp-Source: AGHT+IF6baLSlA+K3ZMqDCfDjkAN/Ho2/aHOlio5k5faACm38kH1Mu4e/P9/rJsv/MzX9tHst46kxw==
X-Received: by 2002:a17:902:e952:b0:295:5898:ff5c with SMTP id d9443c01a7336-29867f9b41bmr2461375ad.16.1763051590899;
        Thu, 13 Nov 2025 08:33:10 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c249806sm30599875ad.44.2025.11.13.08.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:33:10 -0800 (PST)
Subject: [net-next PATCH v4 02/10] net: phy: Add support for 25,
 50 and 100Gbps PMA to genphy_c45_read_pma
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Thu, 13 Nov 2025 08:33:09 -0800
Message-ID: 
 <176305158956.3573217.15523423369598547315.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176305128544.3573217.7529629511881918177.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <176305128544.3573217.7529629511881918177.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

Add support for reading 25, 50, and 100G from the PMA interface for a C45
device. By doing this we enable support for future devices that support
higher speeds than the current limit of 10G.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/phy/phy-c45.c |    9 +++++++++
 include/uapi/linux/mdio.h |    6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index f5e23b53994f..d161fe3fee75 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -627,6 +627,15 @@ int genphy_c45_read_pma(struct phy_device *phydev)
 	case MDIO_CTRL1_SPEED10G:
 		phydev->speed = SPEED_10000;
 		break;
+	case MDIO_PMA_CTRL1_SPEED25G:
+		phydev->speed = SPEED_25000;
+		break;
+	case MDIO_PMA_CTRL1_SPEED50G:
+		phydev->speed = SPEED_50000;
+		break;
+	case MDIO_PMA_CTRL1_SPEED100G:
+		phydev->speed = SPEED_100000;
+		break;
 	default:
 		phydev->speed = SPEED_UNKNOWN;
 		break;
diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index 9ee6eeae64b8..c32333e1156c 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -123,6 +123,12 @@
  */
 #define MDIO_CTRL1_SPEED2_5G		MDIO_PMA_CTRL1_SPEED2_5G
 #define MDIO_CTRL1_SPEED5G		MDIO_PMA_CTRL1_SPEED5G
+/* 100 Gb/s */
+#define MDIO_PMA_CTRL1_SPEED100G	(MDIO_CTRL1_SPEEDSELEXT | 0x0c)
+/* 25 Gb/s */
+#define MDIO_PMA_CTRL1_SPEED25G		(MDIO_CTRL1_SPEEDSELEXT | 0x10)
+/* 50 Gb/s */
+#define MDIO_PMA_CTRL1_SPEED50G		(MDIO_CTRL1_SPEEDSELEXT | 0x14)
 /* 2.5 Gb/s */
 #define MDIO_PMA_CTRL1_SPEED2_5G	(MDIO_CTRL1_SPEEDSELEXT | 0x18)
 /* 5 Gb/s */



