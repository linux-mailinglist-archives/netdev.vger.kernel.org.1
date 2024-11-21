Return-Path: <netdev+bounces-146731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B4B9D5505
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 22:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A381B213E4
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 21:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F611B86CF;
	Thu, 21 Nov 2024 21:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqEskWsc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C51883CDA;
	Thu, 21 Nov 2024 21:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732225817; cv=none; b=jl4zo+NzE5QRkPpd4xARXITeq1vlwRMSf0L73mbrfQDAqXxqXnD1VWlOhFo/0cwEWMKqlCj/OFb1pkiHhKPoRRjBMi579JonLyAVHoBMnDiHQ+UeW3mYrkkTQFI0xW0ufZAW1zlSUeIKplcCGo19FInD9S4OLTAtehgUONMY9E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732225817; c=relaxed/simple;
	bh=DwdlUxpukKZkwXyn+QCfutFIDPcY/3c2VtfjLZ6kMGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UkuISjKMnM0HN4yEz9F4PHZFBoUvdh4gIsiQN3ME6SVZwPQSEyr9ScsEZR8rlZ2zT070/GalBUE2Lh/X+RZmj23DbZd/JLDnB2/5B3KozI6d+I/Ilq3ttbJ4b+aqKU1JLvFrsb3sRJMb2aJg0raS9xCBe8WFENtnsMf427HJOvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqEskWsc; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fbce800ee5so68718a12.2;
        Thu, 21 Nov 2024 13:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732225816; x=1732830616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tng0iyvmtAeQDH4O6wrIeK+ASsO/thRJgM2H3Zm+p88=;
        b=fqEskWscDEdYN/aoKA9d5mRZrL4mMiTsEYDEIresXDwyQDPscL0IhwIoElDFfhJTlg
         elfnBV08pLMly4iQi5mZIaHlxwCtKgrRxIbanREMZvC8QHHhL9eFDCqYx5YMDbFePp8+
         HxY9ee9ns2fcPKZKck4pd9cZBpfKQT5fRe+OBJGQeRdef1vYZIRi4+1OY71sO9ZCf4CV
         qP+wP65AcddZ1y4UafTB1c4Bq4x4uEz1l8Yhanff5dVG0k+Utz7qZ1ZOntTlhzr16HuH
         xhG2MFDH3mAikEAUqKqSftfO6kDc1mFw0zKS/6Iy/cgELVjGkvFI5ECjkIYXrHxb81d5
         xvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732225816; x=1732830616;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tng0iyvmtAeQDH4O6wrIeK+ASsO/thRJgM2H3Zm+p88=;
        b=cSS3nF4ezdBeK8BakgFfx2iw54c0eJLncQm9WLGwFCFN0nXk0H7uVQaT/U0nO7c9kH
         YC/ktP4GzrBStsBSO/m1o+3HVHSPOV8xeCO4phSACvfNbsTqf5onqS/rwQvPnkI29FFm
         zAYqT8//JHbpgntKrpQSI6fbdccKdgQHxefdkhkEWEJIa10VX3Uux120V25DbRkO8SrP
         l7d5/6FIB/gw6AtleW3BxHjg0+u55kl8/31g2Ieo7Y6c0iGPrIu1or8CsgfT44wW9PYj
         1/9FyA+LHu35UbTwnbR7c4pgCjOLG7ozLTBBJgqdh+0oVZ4JgaTNkMk95CPX2OBb7j31
         y4Zw==
X-Forwarded-Encrypted: i=1; AJvYcCU1+uU7/AdEcvmz8kxIOLxS/nVHgipeXXRSBDNeaOhIw/MhLIonS9vp1tNlkAK8frXzlDSHkgeRb14=@vger.kernel.org, AJvYcCX1CcPb/A4BllIUmq3b3wesL6slLaAq31BB90CjMCm0+HQrhx7LwpXg2yqhyWsXoxhigZvw3TQi@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3cOaW2xVyUfWeVvu5yGlvg3UyjOPJ9QOouoclwSafA0oROTX2
	v0F62EnpL12KPu9aOS9JZziPFL7ODJAa0454fncXE8XlMjD46K0=
X-Gm-Gg: ASbGncu0r0ls9kN1AsDivoX7avoxDw9+hzN//E+NGC/KBJ5pXxTs29H8uXz7cL7XAuM
	1Gxo7QL6CHPVDUwc6sGwRNnV+RUHytvT/lfjYcWc7twJ5a1OLzRYzLQ7cd9paC3RewKzCrN2pAl
	6c6ByMzTG2HT++1awoMDEj5XPoJZhnXWHI0YQeSeR/SpmgdRg9+mUW5332p6NUeC2Rc95ZyxGEG
	sHXTpvDhrCLCawy/tICk4sHR8TYLGksDrbTGgpAuGfK1khFfNgyjggFQ7ES2UPK7M8QTF66S9A=
X-Google-Smtp-Source: AGHT+IFrL3LRjMWyNkTLvHSkG1wjmyQiarccPferfkvjFV92RnjBWU69GI/bxyj1j4a0Zc0Tcgd/7A==
X-Received: by 2002:a05:6a21:c20b:b0:1dc:77fc:1cdb with SMTP id adf61e73a8af0-1e09e40a5abmr495782637.13.1732225815616;
        Thu, 21 Nov 2024 13:50:15 -0800 (PST)
Received: from localhost.localdomain ([117.250.157.213])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcbfc0f7dsm210334a12.12.2024.11.21.13.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 13:50:15 -0800 (PST)
From: Vyshnav Ajith <puthen1977@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	Vyshnav Ajith <puthen1977@gmail.com>
Subject: Fix spelling and grammar mistake - bareudp.rst
Date: Fri, 22 Nov 2024 03:19:11 +0530
Message-ID: <20241121214911.9034-1-puthen1977@gmail.com>
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


