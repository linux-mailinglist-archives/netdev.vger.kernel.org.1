Return-Path: <netdev+bounces-188924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B642AAF67A
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 11:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E3511C02613
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 09:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7F22571D7;
	Thu,  8 May 2025 09:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKxoZ3hK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9280425487E;
	Thu,  8 May 2025 09:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746695687; cv=none; b=anZnvRHN1w7lvlnFnjkNCOcQKUHiAH+0TR9n1KGkB0zVAln4g2UxARUalivoxpUjJTWrRQD5M7Lw2XjybdEoKCjFo2rMWMkrY4+GlmtmIKBpjlif9fKJGTCtCecRVKqQXvMMmOP5sIEbVecw2QvjmuYVf8uD5lJf5ETchrrbN6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746695687; c=relaxed/simple;
	bh=T+jXSAbH/GqNVsSlBF05lcxvdMxxOc1vbTvrPAlKPVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OvoSRYzCwiJqlb9+XlnXP8efFluq4GLO/Iedroq0nV/hXhMH/w1MouJ2xpvLWQZsC4atMYp/K4btCfRhc6g1COmQSa1Va1URAAmY3fwVWeAciEadwc7JYx0nOm2ofPlIyjmFYQlAj/hyGygwRfQN8f9uUN25HMAkFu4EejIDbPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKxoZ3hK; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5f6214f189bso1417384a12.2;
        Thu, 08 May 2025 02:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746695684; x=1747300484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VbO8N9v8+uWDAr/gb7hhDveXkdKqwPJVKzFoWlb17IQ=;
        b=JKxoZ3hKqfP1Sg2UUI3M8tZ/J+BBZibTctYaIezMTxRHtj+Rd7Wif6RMIOQ5olf2wI
         OZSMUwVae3Z5NsSAKiMfE/YC9hTridP9Hu2HF2P+2j6/ByCOHNHumBmURpxNGjWzzmVX
         rRMLkc+JGxbK3jV6GIWSxW812ygdW2Ld8xvMfr2wXqOgwA4ANGksglwiCZ5MFHGDKUzn
         1aWizWVFFcFhNmrTVabl03ZTkoqxJRSKEchq+NZiiKz4MHIlpBRRQbmKzS3AK757paS9
         fg43tLe2FBuZAvCbzrGoaVDSPuu8/rjuGQvVPw9rGHDd1B3S5WmS66BLRVIqfOvhkxuG
         kY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746695684; x=1747300484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VbO8N9v8+uWDAr/gb7hhDveXkdKqwPJVKzFoWlb17IQ=;
        b=Ji1bG/tyMFtHZXOC7TGHlxk/SSw0QeEveDbBX40jsudGxYqFFfdE/RDaPL91nKbmTU
         ujeJRoxXWMHkEwvficllrLOXAn9Eri/sn6EzQpQ15dfMSRx0tXu71FnGEMyPd5TDjgww
         LLwTtAefUJliaqeqho7dEECKzamw8YhOSkpgt9Ozhj9s/oysi+tsV7dRb7SEpsCluhgb
         ElSCWMu56az2Y3fIPZdgF+nh7w98lJF7sT5jKYH1lwLI6EUQYfxFQwXiA+bm01eAIi3k
         7KejGxdNsmdm3/FLYJKtlu4VMOLuUz8wxrFuOFkoQizETW5AxS8Ra5HtbGe13+pw94U4
         VAUA==
X-Forwarded-Encrypted: i=1; AJvYcCVjbmJkxNMOoz1ahp/E9kZBtByRAAkj5RzehmfgQvCZBHiFlp+WUdg+/CGOIC0JIlOnkfXX0EvOlXY54ts=@vger.kernel.org, AJvYcCWNyTrzUbqWP+MPHDFf3bscJyZ63E+YYmFD1GUcpZXxXU5rRVtoD1UK6q8HFj9Oz0ge0Vixqq10@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3eD2KsqlIM3wZ06KJ/kkuuimTZzltSOtWOt0Dz2kWxOodaVMm
	LoOtXGQXJus6mRcZzmDYoUDKuv5zZZo9PNAJjumbMK0lqglZSlAW
X-Gm-Gg: ASbGncsl7hv/bgACzQU7gz7lZ575xGzTsPbjVoX7YLP+toSRcNzv4/OsrhideucgrJm
	Z9IPXDu026WesRR/1Ottmkpb9oVaWPfdZOu9j1bZZrACM60L4oISlD/9iyf/lz3mndjBORNxlQR
	H8vSO8LvGuUz79Cz4Xd1h0rVdhOl53Z6THxqW9emYo2bqeU8lJBa0PMxlsWjVtaYicpyUMKlVc8
	M/SGrGK8nz3sdnGDO49ymT9OZb40rQxJM1s3NHHho5MqVdjeGsAcM+etW3OkXbWZ7AX0UemaVtC
	RJg5QmNFZi4iCMYf1pDQP+2TpU2F29RyfUbqaxfnyazYRrcQL5+46Q5ouAdLRYBfp7tv+09Yf3G
	Tq+QfeDvrs/ez9yTjN+Si
X-Google-Smtp-Source: AGHT+IEWnicivsbUjf45Sb0oMH8Pt9n6N1PXd7Ca2IOI8a/bTqlFVwn47A8LlfyTmgi8AVeQd1s0iw==
X-Received: by 2002:a17:907:7e82:b0:ac7:ec31:deb0 with SMTP id a640c23a62f3a-ad1e8b9432emr569849266b.9.1746695683599;
        Thu, 08 May 2025 02:14:43 -0700 (PDT)
Received: from localhost (dslb-002-205-017-193.002.205.pools.vodafone-ip.de. [2.205.17.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1e4a8c3b6sm366932866b.49.2025.05.08.02.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 02:14:42 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dsa: b53: prevent standalone from trying to forward to other ports
Date: Thu,  8 May 2025 11:14:24 +0200
Message-ID: <20250508091424.26870-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When bridged ports and standalone ports share a VLAN, e.g. via VLAN
uppers, or untagged traffic with a vlan unaware bridge, the ASIC will
still try to forward traffic to known FDB entries on standalone ports.
But since the port VLAN masks prevent forwarding to bridged ports, this
traffic will be dropped.

This e.g. can be observed in the bridge_vlan_unaware ping tests, where
this breaks pinging with learning on.

Work around this by enabling the simplified EAP mode on switches
supporting it for standalone ports, which causes the ASIC to redirect
traffic of unknown source MAC addresses to the CPU port.

Since standalone ports do not learn, there are no known source MAC
addresses, so effectively this redirects all incoming traffic to the CPU
port.

Fixes: ff39c2d68679 ("net: dsa: b53: Add bridge support")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 33 ++++++++++++++++++++++++++++++++
 drivers/net/dsa/b53/b53_regs.h   | 14 ++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 9eb39cfa5fb2..7216eb8f9493 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -326,6 +326,26 @@ static void b53_get_vlan_entry(struct b53_device *dev, u16 vid,
 	}
 }
 
+static void b53_set_eap_mode(struct b53_device *dev, int port, int mode)
+{
+	u64 eap_conf;
+
+	if (is5325(dev) || is5365(dev) || dev->chip_id == BCM5389_DEVICE_ID)
+		return;
+
+	b53_read64(dev, B53_EAP_PAGE, B53_PORT_EAP_CONF(port), &eap_conf);
+
+	if (is63xx(dev)) {
+		eap_conf &= ~EAP_MODE_MASK_63XX;
+		eap_conf |= (u64)mode << EAP_MODE_SHIFT_63XX;
+	} else {
+		eap_conf &= ~EAP_MODE_MASK;
+		eap_conf |= (u64)mode << EAP_MODE_SHIFT;
+	}
+
+	b53_write64(dev, B53_EAP_PAGE, B53_PORT_EAP_CONF(port), eap_conf);
+}
+
 static void b53_set_forwarding(struct b53_device *dev, int enable)
 {
 	u8 mgmt;
@@ -586,6 +606,13 @@ int b53_setup_port(struct dsa_switch *ds, int port)
 	b53_port_set_mcast_flood(dev, port, true);
 	b53_port_set_learning(dev, port, false);
 
+	/* Force all traffic to go to the CPU port to prevent the ASIC from
+	 * trying to forward to bridged ports on matching FDB entries, then
+	 * dropping frames because it isn't allowed to forward there.
+	 */
+	if (dsa_is_user_port(ds, port))
+		b53_set_eap_mode(dev, port, EAP_MODE_SIMPLIFIED);
+
 	return 0;
 }
 EXPORT_SYMBOL(b53_setup_port);
@@ -2042,6 +2069,9 @@ int b53_br_join(struct dsa_switch *ds, int port, struct dsa_bridge bridge,
 		pvlan |= BIT(i);
 	}
 
+	/* Disable redirection of unknown SA to the CPU port */
+	b53_set_eap_mode(dev, port, EAP_MODE_BASIC);
+
 	/* Configure the local port VLAN control membership to include
 	 * remote ports and update the local port bitmask
 	 */
@@ -2077,6 +2107,9 @@ void b53_br_leave(struct dsa_switch *ds, int port, struct dsa_bridge bridge)
 			pvlan &= ~BIT(i);
 	}
 
+	/* Enable redirection of unknown SA to the CPU port */
+	b53_set_eap_mode(dev, port, EAP_MODE_SIMPLIFIED);
+
 	b53_write16(dev, B53_PVLAN_PAGE, B53_PVLAN_PORT_MASK(port), pvlan);
 	dev->ports[port].vlan_ctl_mask = pvlan;
 
diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_regs.h
index bfbcb66bef66..5f7a0e5c5709 100644
--- a/drivers/net/dsa/b53/b53_regs.h
+++ b/drivers/net/dsa/b53/b53_regs.h
@@ -50,6 +50,9 @@
 /* Jumbo Frame Registers */
 #define B53_JUMBO_PAGE			0x40
 
+/* EAP Registers */
+#define B53_EAP_PAGE			0x42
+
 /* EEE Control Registers Page */
 #define B53_EEE_PAGE			0x92
 
@@ -480,6 +483,17 @@
 #define   JMS_MIN_SIZE			1518
 #define   JMS_MAX_SIZE			9724
 
+/*************************************************************************
+ * EAP Page Registers
+ *************************************************************************/
+#define B53_PORT_EAP_CONF(i)		(0x20 + 8 * (i))
+#define  EAP_MODE_SHIFT			51
+#define  EAP_MODE_SHIFT_63XX		50
+#define  EAP_MODE_MASK			(0x3ull << EAP_MODE_SHIFT)
+#define  EAP_MODE_MASK_63XX		(0x3ull << EAP_MODE_SHIFT_63XX)
+#define  EAP_MODE_BASIC			0
+#define  EAP_MODE_SIMPLIFIED		3
+
 /*************************************************************************
  * EEE Configuration Page Registers
  *************************************************************************/
-- 
2.43.0


