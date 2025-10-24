Return-Path: <netdev+bounces-232681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E82C9C08152
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 22:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ACD8400AEB
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 20:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395AA2F6569;
	Fri, 24 Oct 2025 20:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GovVDFzU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5232BE7B2
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 20:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338444; cv=none; b=SBCnqHgBPDPYYohjTyfCzqGLmtSF2WEEoDnGyFZ0FRfexuDRuu+m1YH6OnvHaPaTv19Mx7Dh1+CEYrOHtyU6Y5EEvB3keNzC6A/4m3lPpYn5E6cs8Vz7ESssiQzotKBv7Ym9Pf/h5B/1EXyn71NOdOWIqqbo1YfR9Qr2IGOlKbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338444; c=relaxed/simple;
	bh=YRg5bPLlkHAWnFSsNHexwJI5fe+wCDzV9gdM0vLW624=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AlFJg2zh9/p6VlvCgTNCJHRrGeGIPBjL5gvI/vbOgH46yZ6dsUoG0JBfww27pEjYYg6RMkxozh1A9QfcuG5DI7Gze+/0n+GKMgQtSOtVN21uqbIUAWES2rnIjlWdLOhrgGap1Wd14FOJAfeGJzcrnLXIagdyiJlkMxTfpyPPSgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GovVDFzU; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so1661458a12.1
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 13:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761338442; x=1761943242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kKTFhNaQPf9X6jhCLABNzILjxsmIukFrdSMSYaDvKFY=;
        b=GovVDFzUWzkRmgvrvBAkANuXbxPgCwNJPN6z0bin2FpJpvLLhX1Vbu8vChKpOC+kfC
         QwihsbIUADEJmoBIXQE/xRjjyYiqk+h4U3cq7OSWxmd5JnzXfVmYJ2vB0aiC0dr4qiRV
         dWLDSSfRQ3yuRrOJ0FOBlHi0jpgourCZ9AA9Mcth3FNMHgHpEG3gCvjD8cbpH1Gi0AEJ
         T8zC1DFkD1JSC2vwxiLWdKJASgIbzhMON7NXlumUpS4oggg35fTGyHhORJRFiAkJ79xd
         Qc+9qNallWD648Zcn/AZT4jToy2YsPZYLkS4QZhTbIByTOJCYpnsatRvImzvezl9t7TP
         64aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761338442; x=1761943242;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kKTFhNaQPf9X6jhCLABNzILjxsmIukFrdSMSYaDvKFY=;
        b=PYb21pz+AEZEyPlyGrlAKixVU5mEdsnNkpR8WT2DbIhFPAUNJR2diK92E9qtAWDXjx
         EbTfEraHvumgli/gRV5M92L61FicA/WPe8p+DX6NQT3uTjtZpj0MqzVpQINDDMoAckuR
         5Ld/K9JanZnhI97htfet2/sHiEOjxpuEkdafDBlfP0tLHrSm4PsXS2jI5lhBRiXRrawY
         pYGt5DEnms8Q6u3xYLRYP9Y9VrFYCVxEXOx6ueS+T9SE+1LcC/7FB5C03caYyrQN2U5c
         LoQAmqWc8yFNwtnXuvj/+sYS046O79auHekLneCYvkIfUbspgsZYfagdpheBseqJb8fL
         et+g==
X-Gm-Message-State: AOJu0YxIx1KK/c8y9T5ogg91Uw9QCV7jYcR29DUT50BT8sfiqZafo1aN
	pHPoWYVX9+3+deBHgSoUbeQNiq2k5DFv9qn5aTp003delNM5zIT5ApcY
X-Gm-Gg: ASbGnct73DgpybB3NjMT/lJSc5NufqYQrtNpkU0KeQVCbD9pF87iwSALKxB/nm4DXuD
	Ty0UcrryJ9UMZM9zSPUCKUTQK4s5ivh7tG+ZLYVIbwHf/ZtR3Mtwu9U/tA0FIyKxq1L8lgkHw9s
	oxwaZDkUUxZj14yo/lBiu//u+RRkTozKRc6jj76yXeLgO1EU9ohX4W/X1ZouUGn3mg2aVRAgE7d
	jApuQ63OyTgiN82wGa7lQErX3VNFfOR23lW793NnP6SiPy9oD2NDfPDmXYUDD/fWTomJ/mpTChI
	OdyDrq0pbL4H+PmCjZAYE9/EmNt7WtIbJMQxXK7LJ8oPzVci5PStsDo4dwCdWgSbbnML3MJp5rP
	Ul1stgDR7Z5XoxK16hrMQyaBxznDRYsSjMe0rLRK+LGSTIqZuY0rMKKYMtSMk7HtDMeXsJqjSSi
	M7eZnZCbg3vF+GeDyoruYv6irIT13EL6axdvabABk3jZtf
X-Google-Smtp-Source: AGHT+IF/I5xCkX9O1udHinN9h/mttiS5s0SsSPMLZAo4R6bw7E9V04+KhVpkCSzO92jkwS9Tc4TKdQ==
X-Received: by 2002:a17:902:d4c3:b0:28d:18d3:46cb with SMTP id d9443c01a7336-2946de98899mr122716195ad.20.1761338441856;
        Fri, 24 Oct 2025 13:40:41 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf35a5sm1257895ad.18.2025.10.24.13.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 13:40:41 -0700 (PDT)
Subject: [net-next PATCH 1/8] net: phy: Add support for 25,
 50 and 100Gbps PMA to genphy_c45_read_pma
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Fri, 24 Oct 2025 13:40:40 -0700
Message-ID: 
 <176133844020.2245037.14851736632255812541.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176133835222.2245037.11430728108477849570.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <176133835222.2245037.11430728108477849570.stgit@ahduyck-xeon-server.home.arpa>
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
 include/uapi/linux/mdio.h |    9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 61670be0f095..2b178a789941 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -626,6 +626,15 @@ int genphy_c45_read_pma(struct phy_device *phydev)
 	case MDIO_CTRL1_SPEED10G:
 		phydev->speed = SPEED_10000;
 		break;
+	case MDIO_CTRL1_SPEED25G:
+		phydev->speed = SPEED_25000;
+		break;
+	case MDIO_CTRL1_SPEED50G:
+		phydev->speed = SPEED_50000;
+		break;
+	case MDIO_CTRL1_SPEED100G:
+		phydev->speed = SPEED_100000;
+		break;
 	default:
 		phydev->speed = SPEED_UNKNOWN;
 		break;
diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index 6975f182b22c..ff8b6423bd1e 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -116,6 +116,12 @@
 #define MDIO_CTRL1_SPEED10G		(MDIO_CTRL1_SPEEDSELEXT | 0x00)
 /* 10PASS-TS/2BASE-TL */
 #define MDIO_CTRL1_SPEED10P2B		(MDIO_CTRL1_SPEEDSELEXT | 0x04)
+/* 100 Gb/s */
+#define MDIO_CTRL1_SPEED100G		(MDIO_CTRL1_SPEEDSELEXT | 0x0c)
+/* 25 Gb/s */
+#define MDIO_CTRL1_SPEED25G		(MDIO_CTRL1_SPEEDSELEXT | 0x10)
+/* 50 Gb/s */
+#define MDIO_CTRL1_SPEED50G		(MDIO_CTRL1_SPEEDSELEXT | 0x14)
 /* 2.5 Gb/s */
 #define MDIO_CTRL1_SPEED2_5G		(MDIO_CTRL1_SPEEDSELEXT | 0x18)
 /* 5 Gb/s */
@@ -137,9 +143,12 @@
 #define MDIO_SPEED_10G			0x0001	/* 10G capable */
 #define MDIO_PMA_SPEED_2B		0x0002	/* 2BASE-TL capable */
 #define MDIO_PMA_SPEED_10P		0x0004	/* 10PASS-TS capable */
+#define MDIO_PMA_SPEED_50G		0x0800	/* 50G capable */
 #define MDIO_PMA_SPEED_1000		0x0010	/* 1000M capable */
 #define MDIO_PMA_SPEED_100		0x0020	/* 100M capable */
 #define MDIO_PMA_SPEED_10		0x0040	/* 10M capable */
+#define MDIO_PMA_SPEED_100G		0x0200	/* 100G capable */
+#define MDIO_PMA_SPEED_25G		0x0800	/* 25G capable */
 #define MDIO_PMA_SPEED_2_5G		0x2000	/* 2.5G capable */
 #define MDIO_PMA_SPEED_5G		0x4000	/* 5G capable */
 #define MDIO_PCS_SPEED_10P2B		0x0002	/* 10PASS-TS/2BASE-TL capable */



