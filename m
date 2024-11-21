Return-Path: <netdev+bounces-146739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C8D9D55D1
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 23:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6345EB20CEA
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 22:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7F31DE2B6;
	Thu, 21 Nov 2024 22:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXd/FNxM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391B31DDC26;
	Thu, 21 Nov 2024 22:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732229324; cv=none; b=J33iYlyRy2pnfGSiSzw/RAKZO2Xjn+GsT/zq0jHAOYbN5m6u22LttAk2LUjH0N+g5p0BpCNw5YnRPCH9GMNPgP3/qBItEm9p4CHr0UAoMq4THY/wGed5lDrUl7NBkzNiwDHjvMaQZ53+Pxz9uO+AarxJdTAGV7WuUjAC8xpgHP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732229324; c=relaxed/simple;
	bh=DwdlUxpukKZkwXyn+QCfutFIDPcY/3c2VtfjLZ6kMGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jwGcxjyLk8DWVkbMlLu7Z1qODodycU9pR0rut4wPQvT3vuHs0nJHr+GJ6A6q2MYsm9Njj/fetHLum1r88+FayTlTs9WyhNOqcxRWPUcYzxPMLh1RFMII5LJnc1s1o+LAGUNMrOevnSqVKRyUlrkCpevgN66xQ13cBp944vGe650=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXd/FNxM; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-720d01caa66so1449135b3a.2;
        Thu, 21 Nov 2024 14:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732229322; x=1732834122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tng0iyvmtAeQDH4O6wrIeK+ASsO/thRJgM2H3Zm+p88=;
        b=SXd/FNxMicay09aPMFUnVUp4jJrXftlgMPYOK3VdGt5174NqFDMACARm4P6Q5iaom6
         HQE+cxtnL6v4fYEO5Hh3r3gVG6ZUtLvrGKR57x61E8e4SFzHGqgLU61Fg7SMcstoaSUK
         Ua5eSAEMUR7S7olgK/iPFi2SHGb1O/P5ZWg7Crm+bK6LnG70koa8MCGhFXjqy1XapsUH
         qA6rWJhleW8sBhDGY+i+0jzPxwbYydqaY8zBXdbPsAPG4FceAa+efcVwAaVhlm2XUJjc
         e/+NqqwFqwSK9GMPnR6ARReStW0xx4hIsxDiI/LjShbH6BmzPv/On6ACvzlFSVUOVmcK
         yQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732229322; x=1732834122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tng0iyvmtAeQDH4O6wrIeK+ASsO/thRJgM2H3Zm+p88=;
        b=uv4Uc5KzW6kebdCbhZE6FG9E7nZJUHuR7FQeAAjRwEPK0EoUqRvqQaOs2LWwIgZznn
         b7ncLmFBHQ2mZlHqN5pqnXth57tootRe0iEgoe22sxhW2P7zA+91Xg7fp5a5gT3bsqPA
         5bjlDz8jpgMeo/nzZaebO9NNYmPJM+WBufKOkNL6faKGmgP27IdGwJUzY2yU518vt0B6
         9QfqLoOHg3zzGW2XiapbC5yn19p3xu6O0VeegDf2gR0b6mHOVk63n1J8X8Be4yQ4gfK3
         Z+ieas7dvwcm9tcoorazQ2OeCVf4QnXwAhskEchZXYXphH4ILZhsnQPJseFjmzxWMTV4
         R12A==
X-Forwarded-Encrypted: i=1; AJvYcCW9MsQqoqEESNyO0EUCFw9qFYF0vfK+DD4ufzjKRBWLOtpjMHKd+Uq48EyjWmTgQiYpmshrlkApdUo=@vger.kernel.org, AJvYcCWch3uE3HIN0h+4K2+kZAX4aMecj/v/LpnRPLEUo9jwZ7M5AKNBB29zGjEHW7HE3GXsDRRphuOf@vger.kernel.org
X-Gm-Message-State: AOJu0YyrMcaGZZfcqlLWDgq1ZoRUaHoczXWBMkOoBVpqsUS+jOuDdxGW
	pmZswjluGeLPtFDnXak2vnl4f0sloXDRZWiCUfo8F+X5Q5R46f4=
X-Gm-Gg: ASbGncvK2NSMXVtmrIpsDuPvNSg6sRc9Syj/j74PNXr0k6gArDrIAg92alWxJssFlHc
	VPaZcYVV6dSRNw7M5YJzdk8EIcoSQtiMYdIA9uOs9BSFTjw7rl27Ew5ZOtLK6PUV+tm0ADfmdoS
	mB38QAFeH3Qrm6W8vY84lEEM7pA2CKfDasAvlU7pZ/fZLrGmSOqGKhq52zfT+vGcpTNxqaLgxfO
	ClduIFeSfuBYtW2fLmrSEodiHwkPcQ0xmMaRwE5Q9r0xVixWEYP1bPnn1hKPLRGO/WnP6jP9Fs=
X-Google-Smtp-Source: AGHT+IFQ0B/JiKGabPfJYNbf/Q86LIo1DT+f0On/aEakqwc0UWc3jxR7+ecwcL6C7VQK7xXfgLtVAQ==
X-Received: by 2002:a17:90b:1dc3:b0:2ea:696d:7330 with SMTP id 98e67ed59e1d1-2eb0e234d1bmr713339a91.14.1732229322356;
        Thu, 21 Nov 2024 14:48:42 -0800 (PST)
Received: from localhost.localdomain ([117.250.157.213])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0d048654sm248188a91.39.2024.11.21.14.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 14:48:41 -0800 (PST)
From: Vyshnav Ajith <puthen1977@gmail.com>
To: corbet@lwn.net
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	Vyshnav Ajith <puthen1977@gmail.com>
Subject: Fix spelling and grammar mistake - bareudp.rst
Date: Fri, 22 Nov 2024 04:18:27 +0530
Message-ID: <20241121224827.12293-1-puthen1977@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BareUDP documentation had several grammar and spelling mistakes,
making it harder to read. This patch fixes those errors to improve
clarity and readability for developers.

Signed-off-by: Vyshnav Ajith <puthen1977@gmail.com>
---
 Documentation/networking/bareudp.rst | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/bareudp.rst b/Documentation/networking/bareudp.rst
index b9d04ee6dac1..ce885caf24d3 100644
--- a/Documentation/networking/bareudp.rst
+++ b/Documentation/networking/bareudp.rst
@@ -6,16 +6,17 @@ Bare UDP Tunnelling Module Documentation
 
 There are various L3 encapsulation standards using UDP being discussed to
 leverage the UDP based load balancing capability of different networks.
-MPLSoUDP (__ https://tools.ietf.org/html/rfc7510) is one among them.
+MPLSoUDP (https://tools.ietf.org/html/rfc7510) is one among them.
 
 The Bareudp tunnel module provides a generic L3 encapsulation support for
 tunnelling different L3 protocols like MPLS, IP, NSH etc. inside a UDP tunnel.
 
 Special Handling
 ----------------
+
 The bareudp device supports special handling for MPLS & IP as they can have
 multiple ethertypes.
-MPLS procotcol can have ethertypes ETH_P_MPLS_UC  (unicast) & ETH_P_MPLS_MC (multicast).
+The MPLS protocol can have ethertypes ETH_P_MPLS_UC  (unicast) & ETH_P_MPLS_MC (multicast).
 IP protocol can have ethertypes ETH_P_IP (v4) & ETH_P_IPV6 (v6).
 This special handling can be enabled only for ethertypes ETH_P_IP & ETH_P_MPLS_UC
 with a flag called multiproto mode.
@@ -52,7 +53,7 @@ be enabled explicitly with the "multiproto" flag.
 3) Device Usage
 
 The bareudp device could be used along with OVS or flower filter in TC.
-The OVS or TC flower layer must set the tunnel information in SKB dst field before
-sending packet buffer to the bareudp device for transmission. On reception the
-bareudp device extracts and stores the tunnel information in SKB dst field before
+The OVS or TC flower layer must set the tunnel information in the SKB dst field before
+sending the packet buffer to the bareudp device for transmission. On reception, the
+bareUDP device extracts and stores the tunnel information in the SKB dst field before
 passing the packet buffer to the network stack.
-- 
2.43.0


