Return-Path: <netdev+bounces-232193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 694F2C025D9
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 18:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 834B7506CC1
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 16:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25055299957;
	Thu, 23 Oct 2025 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=42.fr header.i=@42.fr header.b="NxBP1aD2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE8A293B75
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235905; cv=none; b=lH/r5gN2CHishKa/uZEx7oOUXqi7he5oxxoatVI4isSHGcT7/g3I/DAGPh3XddakSYyiyZGdeSQI/VZ8FVMKtdICCxr9ZuuA2i3yT03HK2W6evvY2pinrU9o9IqtFHI3eLa7hr4hXQecPitOjLZYGrWemwksEGbzmDzp80FGsD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235905; c=relaxed/simple;
	bh=nUteSuOJ9LX9qDQVOKziBVr0BfsdekpVG7OD+xDvs0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KohapvWUw+N+DqBx5p2e8S+WcycttKpqEwhJxtBzS7+SNBN4aTv1VfxP3pqyD7HwY+obbDGfmp+9nAu7cE+h7RIWv3aNJON+IGpYse0eLkDJ94O03x3d4LpP1JRrrqqP0kmSOdnMNOzU4GrHqeHlvLX7XxRRYV8L3emSeogsf2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=42.fr; spf=pass smtp.mailfrom=42.fr; dkim=pass (2048-bit key) header.d=42.fr header.i=@42.fr header.b=NxBP1aD2; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=42.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=42.fr
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-428564f8d16so565011f8f.1
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 09:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=42.fr; s=gw; t=1761235901; x=1761840701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3m9ah5kbgDLsSRMenHAMj3Q4xRuIZKbPu+Dxwh5kMt0=;
        b=NxBP1aD2f7NUEHt0f46KvaLX0Eu3b2V60gHnF/g/kYm5ue4a/YW7pU2dpLCjt0UZb4
         EgQLSeq7jccy6LALn5pVWVw9rorWCniIssLZPso2JWnSzE+bJZ2gzUWP2+gFg5mtuZ9S
         3mZjbIO4TF1u2mGL/cs3wef1N7MXSiLTMhTP5KIklqJEmae3bcNVDrrzI2sX5hysOe//
         HEpa/ZKahC/FVKQQ7cM7I+/x+rFT0vDNt2Y/2CFsR03H3mLuQz4vlF+TcovrccMoOc9B
         muBc4U332Djsfj2EpbP4Mza0xRTmiPKeZkE8j50hQCaztudS2jZj/l30Y7O4fv71BSBa
         bEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761235901; x=1761840701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3m9ah5kbgDLsSRMenHAMj3Q4xRuIZKbPu+Dxwh5kMt0=;
        b=YcAvG5hgok9b7Zo9b1yUfZMCu4ehgkerH1bWSXpWa1+R6wwDZLstV3/j/622MIHvFj
         inGnFhiX9FMUZBVqdnod0jOgu9NnwRHG2N5n6n8UZqD4R+/nmklajAGJBy6jIu+ZPSVL
         t8M1XOnLBKXSyQV8UD7cLXah/QnKp7eB/s00mq6Ybmact2o4EjLCnJdzVeinoqy5O/kn
         nMcPCwRFMkg28+lZUhpoU23rvuobIZ7Stsgcy62Ml9C5+nGPKq+drsTGq1dGA7MTFklB
         k3ZZuYmuac1OiGzJ8pxBZHbQL6dTq0oQ8y0JxGhvQOxDiw46+MSV8Y8aAZTkOI8AeJGZ
         1K/g==
X-Forwarded-Encrypted: i=1; AJvYcCXA/MhaAsLi9SB6slvVG7tCF4TkSd3WWkbNjXTmN9bLi9RsvUiPU8k1q0NYErwZGUgUKCZakg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEc2vGg71YfFNwHeGQdSBRKwNqpBc/L3por09Jq28+SZB/cg0R
	qIl6jLYN+2ErZTFq4iHfeqwGYpxxWuLUml9a6lIf05KQlSJKqSwiR+ThcCJT/T8cmeI=
X-Gm-Gg: ASbGncsdefd70jliAjFpzV9/BIscIn5BA2n0T3EAlAyUtPjR1ZTuxiRrYG9L5SJI+pe
	FAyH+fSNdZWY/EhOPjlV1Lz6IrkWe6qASBe+FGk402P7vTklL9TrPdVoxoE0xzmBsc0rUdW1VR9
	I2zTf5xMYJbaexlPOjNw20x667X/0AWKDC1IQqeaIGQVbOmzVoJak7uNz2q0Vxku9IFuIGo1/z5
	DHkQgFVPnhikR0GCgZoa3bJGQweBEz5gGpCzCTFRbc3jtfUDG0pgIuo11ExZ3aGghS+qJJLWlUw
	TWcNWNWuqSdqur0/1biLWaA3OLd8PJsNsAyBXQLlJicAA6Tpf4XPH4j7uzuj7DI2Sjm4h3FAgcH
	lqGbOxgL8Cpahv1EEEznOEKxcSNFl8hY4vS/nseKT8DBXjYRIajc+33u4+yyLoNBJm6SYnrMm4g
	==
X-Google-Smtp-Source: AGHT+IH0/HC+MxAgbHtrHb8ogRis9t+C7apRxSN2Uz8hQycBWUjbbsufH11Skh1m0YQyGENnztKy1A==
X-Received: by 2002:a05:6000:984:b0:428:5673:11df with SMTP id ffacd0b85a97d-428567313d7mr4621322f8f.15.1761235901402;
        Thu, 23 Oct 2025 09:11:41 -0700 (PDT)
Received: from wow-42.42.school ([62.210.35.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4298b9963ccsm3017836f8f.7.2025.10.23.09.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 09:11:41 -0700 (PDT)
From: Paul SAGE <paul.sage@42.fr>
To: paul.sage@42.fr,
	vinc@42.fr
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tg3: replace placeholder MAC address with device property
Date: Thu, 23 Oct 2025 18:08:42 +0200
Message-ID: <20251023160946.380127-1-paul.sage@42.fr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some systems (e.g. iMac 20,1 with BCM57766), the tg3 driver reads a default placeholder mac address (00:10:18:00:00:00) from the mailbox.
The correct value on those systems are stored in the 'local-mac-address' property.

This patch, detect the default value and tries to retrieve the correct address from the device_get_mac_address function instead.

The patch has been tested on two different systems:
- iMac 20,1 (BCM57766) model which use the local-mac-address property
- iMac 13,2 (BCM57766) model which can use the mailbox, NVRAM or MAC control registers

Co-developed-by: Vincent MORVAN <vinc@42.fr>
Signed-off-by: Vincent MORVAN <vinc@42.fr>
Signed-off-by: Paul SAGE <paul.sage@42.fr>
---
 drivers/net/ethernet/broadcom/tg3.c | 12 ++++++++++++
 drivers/net/ethernet/broadcom/tg3.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index d78cafdb2094..55c2f2804df5 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -17042,6 +17042,14 @@ static int tg3_get_invariants(struct tg3 *tp, const struct pci_device_id *ent)
 	return err;
 }
 
+static int tg3_is_default_mac_address(u8 *addr)
+{
+	u32 addr_high = (addr[0] << 16) | (addr[1] << 8) | addr[2];
+	u32 addr_low = (addr[3] << 16) | (addr[4] <<  8) | addr[5];
+
+	return addr_high == BROADCOM_OUI && addr_low == 0;
+}
+
 static int tg3_get_device_address(struct tg3 *tp, u8 *addr)
 {
 	u32 hi, lo, mac_offset;
@@ -17115,6 +17123,10 @@ static int tg3_get_device_address(struct tg3 *tp, u8 *addr)
 
 	if (!is_valid_ether_addr(addr))
 		return -EINVAL;
+
+	if (tg3_is_default_mac_address(addr))
+		device_get_mac_address(&tp->pdev->dev, addr);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/broadcom/tg3.h b/drivers/net/ethernet/broadcom/tg3.h
index a9e7f88fa26d..9fb226772e79 100644
--- a/drivers/net/ethernet/broadcom/tg3.h
+++ b/drivers/net/ethernet/broadcom/tg3.h
@@ -14,6 +14,8 @@
 #ifndef _T3_H
 #define _T3_H
 
+#define BROADCOM_OUI			0x00001018
+
 #define TG3_64BIT_REG_HIGH		0x00UL
 #define TG3_64BIT_REG_LOW		0x04UL
 
-- 
2.51.0


