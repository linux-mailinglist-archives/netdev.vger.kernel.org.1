Return-Path: <netdev+bounces-267965-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KnHGxsbt2lGMgEAu9opvQ
	(envelope-from <netdev+bounces-267965-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 21:48:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AC729272B
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 21:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6F1430A3D36
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 20:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A5537C935;
	Sun, 15 Mar 2026 20:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4A4fwmL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D900937C917
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 20:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773607518; cv=none; b=r/U1KGT5y6VpVXzQrUh7bk+HZfjug3JmMThRh8jeYeCXazqNnlMMQFIUzgR4HCSWZwZFrG0RR3NqbL+hNKgOGZmaO8L1l92x7yxeKjREvgRzMf18LgsCTn7v7DI+dcwTrBKWhZkLtuCTErAJK1eZQ7il8mc3YK0ZcU+re9CI4E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773607518; c=relaxed/simple;
	bh=rPpgtG8br7dbeLmqjLEppfzKOI+OoaBXSnHrSGxltFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vh4GwWYHW9zV2HkZxx+CksYSLJRpFrJb8hTQfCpQgU03n5J2WBzjk8BjXqKImqM1COzGdWSqNTHxa/Vq0kVUzzC9xuGp9tmfAxPunXPaokc2u6c0HaR6EWbBWbSPI7xV6foxJmtGxa7kw33vk5qafq3TF95hv3fa1Eg0d/AbNKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4A4fwmL; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48539d21b76so27055385e9.1
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 13:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773607515; x=1774212315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PahM13Z+gyHUBDfHr8IMBngyQQ9TTRxFfOobW8O16HE=;
        b=Y4A4fwmLolCuMzJIuWE8jtjayeiOP8tLQSVqAc4EimyiV5ZggfBfOhB+TSAUA6M2EC
         B5BMth8KQCsfuXSsj8O/qQIK2FCWxKhyD0obXjOXEpK+XywkSr4T6i8OCj8upkbEKIW/
         SzEdRxsox61P9oFLUx7dSV4lElLJe2mEHnNjrfPuQQvMgXF9woxoUUsQXR4vLwzADDbm
         SrvCbYabYUpvfJe1gq3Ce3EyZP/dQOCYDYFc2WonqCcMjjIDes8F6ucJwHgeAuUQh8nF
         vMtlGYyVLROJnGC5iSclyNNwtU+KkFZXyunzRqdwfo8kzZi1S5nhRlYDBRoO+h5dJmLM
         gNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773607515; x=1774212315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PahM13Z+gyHUBDfHr8IMBngyQQ9TTRxFfOobW8O16HE=;
        b=YWXg9Uz9icfQt40EdS/FbErkvtTG4bVNgmhcAOZYzFE4Ocb0MAoNj06bjzyDFPsH4+
         FIqWqQP3FNzAoZ31OevSaFX//ZaRHb3/s+lbkMo0zQz1tVTpnA298XrRxRZNWDAi1uj0
         rk/8xNHMwME/vFK8zqsb3jMHCPKsrLRpzAh2akPnVzhy0xHq/jN1STcDc65k0wgKIlyp
         VEN6QKCtnz6D3FAerQzcmR/mhw2Se7Leq39pAi3gx/Of61oDIfaE+p7poKAkYYelgH0z
         CqvyjxG2QbRCateBOMbltriPK0WeLupAXmgO1+HD2ajRVQPr8Ww8JRaGcJUAEoHYFDGA
         19gA==
X-Gm-Message-State: AOJu0YznFWAtMs5Drul5NDyXfPm4Mgcm7pRWQtPkhdd1U7uGucN8Iuy6
	fuw/re51FAh2V+Y/tgqwicxODU2t2HJ6VMVz1+vDUbEAqcrmgaj2q3d+
X-Gm-Gg: ATEYQzzt4hwVEcywQyHPfFvGvQpLqHmfqQgtd+TVQoB8TusjnLVqEMt8jeHReGHWsZv
	dOxnVp+GhffTwt/hu7BzvDHK2SHvPzlHeRiIsqKCBueC4JBUyBVEB52GCJ7NA/2AL/UUmRGhInG
	9o6JSARAtxU9HB23LMkpxlLeqxg1G3t5abzHhUkWcKc/E4KTeps+2iC3/pvfzQjJ+ZjqeT+P51t
	DUZjOAvs36ZYUf9m5pyyOmVRt74X8w1pvbIL6GqFRShK9YDbZk5sqVB5Z/Bw5kCOkelbCw3kkGe
	gQwNdPoiFwffrU2tgyiS6dqqsr2YG2IdMX758AQeSl1xGMcpP0T92wpIgtYzLH2L9MOAAahI0u6
	CJDQJ8xC+dzg0Qs2B6AA+CJqvhGuQCQxhmXlOAbngGZJXCrndZQzl07ibuM0EfGgS020BlPFs2p
	gsFIXl0C2h0xlfZ7deVc70X75v83fxf3qt1Q==
X-Received: by 2002:a05:600c:8b46:b0:485:557d:9fe with SMTP id 5b1f17b1804b1-485566d6e3emr174688435e9.12.1773607515215;
        Sun, 15 Mar 2026 13:45:15 -0700 (PDT)
Received: from nas.local ([2001:912:1ac0:1e00:c662:37ff:fe09:93df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485563f8c23sm132043885e9.1.2026.03.15.13.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 13:45:14 -0700 (PDT)
From: Damien Dejean <dam.dejean@gmail.com>
To: andrew@lunn.ch,
	krzk+dt@kernel.org,
	robh@kernel.org,
	kuba@kernel.org,
	maxime.chevallier@bootlin.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	hkallweit1@gmail.com,
	Damien Dejean <dam.dejean@gmail.com>
Subject: [PATCH net-next v8 4/4] net: phy: realtek: add RTL8224 polarity support
Date: Sun, 15 Mar 2026 21:44:54 +0100
Message-ID: <20260315204454.124544-5-dam.dejean@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315204454.124544-1-dam.dejean@gmail.com>
References: <20260315204454.124544-1-dam.dejean@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267965-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[damdejean@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05AC729272B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The RTL8224 has a register to configure the polarity of every pair of
each port. It provides device designers more flexbility when wiring the
chip.

Unfortunately, the register is left in an unknown state after a reset.
Thus on devices where the bootloader don't initialize it, the driver has
to do it to detect and use a link.

The MDI polarity swap can be set in the device tree using the property
enet-phy-pair-polarity. The u32 value is a bitfield where bit[0..3]
control the polarity of pairs A..D.

Signed-off-by: Damien Dejean <dam.dejean@gmail.com>
---
 drivers/net/phy/realtek/realtek_main.c | 34 +++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 2feb085f5c9e..a3691f9c19a5 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -172,6 +172,7 @@
 #define RTL8224_SRAM_RTCT_LEN(pair)		(0x8028 + (pair) * 4)
 
 #define RTL8224_VND1_MDI_PAIR_SWAP		0xa90
+#define RTL8224_VND1_MDI_POLARITY_SWAP		0xa94
 
 #define RTL8366RB_POWER_SAVE			0x15
 #define RTL8366RB_POWER_SAVE_ON			BIT(12)
@@ -1870,9 +1871,40 @@ static int rtl8224_mdi_config_order(struct phy_device *phydev)
 					  order ? BIT(port_offset) : 0);
 }
 
+static int rtl8224_mdi_config_polarity(struct phy_device *phydev)
+{
+	struct device_node *np = phydev->mdio.dev.of_node;
+	u8 offset = (phydev->mdio.addr & 3) * 4;
+	u32 polarity = 0;
+	int ret;
+
+	ret = of_property_read_u32(np, "enet-phy-pair-polarity", &polarity);
+
+	/* Do nothing if the property is not present */
+	if (ret == -EINVAL)
+		return 0;
+
+	if (ret)
+		return ret;
+
+	if (polarity & ~0xf)
+		return -EINVAL;
+
+	return rtl8224_package_modify_mmd(phydev, MDIO_MMD_VEND1,
+					  RTL8224_VND1_MDI_POLARITY_SWAP,
+					  0xf << offset,
+					  polarity << offset);
+}
+
 static int rtl8224_config_init(struct phy_device *phydev)
 {
-	return rtl8224_mdi_config_order(phydev);
+	int ret;
+
+	ret = rtl8224_mdi_config_order(phydev);
+	if (ret)
+		return ret;
+
+	return rtl8224_mdi_config_polarity(phydev);
 }
 
 static int rtl8224_probe(struct phy_device *phydev)
-- 
2.47.3


