Return-Path: <netdev+bounces-177087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F50A6DD04
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 15:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300163AB834
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 14:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7013025FA2D;
	Mon, 24 Mar 2025 14:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NB3TF04q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC8625FA19;
	Mon, 24 Mar 2025 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826541; cv=none; b=AGJWAH5JTbt2Ng2Ja3KD0CiDcmSJ5uvBCHCwB4dXAuIGZAfZhq2T52F2QKZvQ+U06HnKAXom+8d90ebYEDzUbkY3LfhY81p/Mfx4NRib/UiikNuoqQ5gWE7UPM6RNUIhKqHcU9PDEtoAQwI9bAJzT/WluS7BYpc1jhQfuLFnWdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826541; c=relaxed/simple;
	bh=U4fxdp7fkGpc3gIlH2FlKiwelKAw+dKySiCd7cmcnNU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HD72Mo99rZJoM9faumpO1492NeqjpuPu/52JAR6Avu7B/jS5DPuNs5FqacSUwqfHLL3e+goBzHt2t3UwAOVgc+V7jJHYAnZ3mTmRzNV6Z0ZnEvLUliovNrCx+H3E3e2Skn9hlLNmlkDE1U5PduZWfoJa8zKtZqOo0dXgxFZs80s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NB3TF04q; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2264aefc45dso70572195ad.0;
        Mon, 24 Mar 2025 07:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742826539; x=1743431339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J37tNKeei1lAfZGOWmkRB72kDfk/O1Aubeqn9Iov+6s=;
        b=NB3TF04qbkJfB/N+64T3d4OkNJXrSsPPcnFLJDgXW1EhAZyvCT950CbOQGF3VJI6Lp
         1ZsZZ6kMibM5YjPjLDIBWBeUqPE7ALEdLDvBt+vLuKVx3NYr8/CKsUj6c6slCKiZFZyD
         lQsw6Xxkm2zv6JG/1bvfxuONYB/AuJC/irSqVeLHV5bprQTSC3l4oreUkOSNlI7uMsg8
         y8issfM4ZaUWvsfvsctwgtUCV3/1m63c0VDNp3AlFoL40Ie/JPkjpcELmQs6sI4NRzcF
         4QnvWSQo8rlOBum2KHozykZETxZVze4vs6Sb4Xd/n8aV1V6/mCNHtKGQDJ3WQmSunVtP
         UOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742826539; x=1743431339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J37tNKeei1lAfZGOWmkRB72kDfk/O1Aubeqn9Iov+6s=;
        b=B43aP8UHKZm6ulh5f20BuV1m7u5H/cu3Hpf9bjRo1+u4T5zk5ZV72roRJsA3jBA+7M
         jVYoxp8YHYqfzS129prTmNFt+8b9MpjD23x52q3Pm+OcKseRH5ZFjeCZEPTQql+5BPa5
         eGei742CJRUEQePGzfZQhwydF0xGviTuG6Z/Isu04S1vzPrkaHPgi2hz70Db9DZb5UVa
         1jLQpVfzRhKMcVBOKfy7Jmxr9TtVOIzDNtpamYi1Q4/Tb+b7QcdQTzPD6Pw2RPpHvzs+
         77cJ4qJBXc6+EOq3Pwx6ZnxABaGW84LXwt7K0JvsFAjqXniTTlDgqYepKmyVLt2bOc1h
         a6eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNa3AEc43XimSiEbhEKKHPEOhChqOVfmPUmHXRMpzDdGEa8q2QLVT58D8uxv2HPkdNNmHOtwjqS0a0TpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YydJPEReDs7E4A6gyA/Tlj4C+CSyhusiQ1rHE/P2G9eaeyFmMHb
	GWXoww0THQZkPmTEKpB8we89oNdBngUHrs9vz4o5dwpsf0ZGFVcIl2+yJvo=
X-Gm-Gg: ASbGncs2MOsLO8sDebtfZ6x0LtQpDz44Iqvsz08c+jsVA+tI9AU6yDsbqbY8zGzpj2P
	dJfwZlnGiUvs4NhYzyf6ijM93gUleX5T37Vw08OuZq9BgJ+NYLzUfdSsTlLCFp52h0cZ2d08U11
	YUKFv38mbqTdHVg1HL8GRg4mXYUCxILwBTECOb27bQIkD+SpPPMN6Va5FpTz34z8/1LDH5eSbvB
	t83dF2xyxb+ApWswMkaXo2D0G8Bycs7dub2knUdZN+wxRjtGt5qSJsCyp54soG4Vr4VDy7grh9g
	u/DHBMdAT/ogCIiTkTmehfHlkOMSBku5RGylDXOVqzYCLarQJYOCB8hIibGvKhIce17SZiFxR/h
	vPk9NZa2O9bbA1r5ijqUAYsyvkBLz+RFePa1V5A==
X-Google-Smtp-Source: AGHT+IEe75MycBECfIae4/6dHjUL9F5p5LkYV50FC7MSq5/jGwZp4hjjauRFN8gODeMfiJXKuhjviw==
X-Received: by 2002:a17:903:32ca:b0:223:4b88:780f with SMTP id d9443c01a7336-22780c7ceeemr184345305ad.17.1742826538594;
        Mon, 24 Mar 2025 07:28:58 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw. [124.218.201.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811da97esm70978815ad.192.2025.03.24.07.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 07:28:58 -0700 (PDT)
From: "Lucien.Jheng" <lucienx123@gmail.com>
To: linux-clk@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	daniel@makrotopia.org,
	ericwouds@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	joseph.lin@airoha.com,
	wenshin.chung@airoha.com,
	lucien.jheng@airoha.com,
	"Lucien.Jheng" <lucienx123@gmail.com>
Subject: [PATCH v6 net-next PATCH 1/1] net: phy: air_en8811h: Add clk provider for CKO pin
Date: Mon, 24 Mar 2025 22:27:59 +0800
Message-Id: <20250324142759.35141-1-lucienx123@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EN8811H outputs 25MHz or 50MHz clocks on CKO, selected by GPIO3.
CKO clock operates continuously from power-up through md32 loading.
Implement clk provider driver so we can disable the clock output in case
it isn't needed, which also helps to reduce EMF noise

Signed-off-by: Lucien.Jheng <lucienx123@gmail.com>
---
Change in PATCH v6:
air_en8811h.c:
 * Adjust space indentation to tab stops.

 drivers/net/phy/air_en8811h.c | 97 +++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index e9fd24cb7270..de49bb200926 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -16,6 +16,7 @@
 #include <linux/property.h>
 #include <linux/wordpart.h>
 #include <linux/unaligned.h>
+#include <linux/clk-provider.h>

 #define EN8811H_PHY_ID		0x03a2a411

@@ -112,6 +113,11 @@
 #define   EN8811H_POLARITY_TX_NORMAL		BIT(0)
 #define   EN8811H_POLARITY_RX_REVERSE		BIT(1)

+#define EN8811H_CLK_CGM		0xcf958
+#define   EN8811H_CLK_CGM_CKO		BIT(26)
+#define EN8811H_HWTRAP1		0xcf914
+#define   EN8811H_HWTRAP1_CKO		BIT(12)
+
 #define EN8811H_GPIO_OUTPUT		0xcf8b8
 #define   EN8811H_GPIO_OUTPUT_345		(BIT(3) | BIT(4) | BIT(5))

@@ -142,10 +148,15 @@ struct led {
 	unsigned long state;
 };

+#define clk_hw_to_en8811h_priv(_hw)			\
+	container_of(_hw, struct en8811h_priv, hw)
+
 struct en8811h_priv {
 	u32		firmware_version;
 	bool		mcu_needs_restart;
 	struct led	led[EN8811H_LED_COUNT];
+	struct clk_hw		hw;
+	struct phy_device	*phydev;
 };

 enum {
@@ -806,6 +817,86 @@ static int en8811h_led_hw_is_supported(struct phy_device *phydev, u8 index,
 	return 0;
 };

+static unsigned long en8811h_clk_recalc_rate(struct clk_hw *hw,
+					     unsigned long parent)
+{
+	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
+	struct phy_device *phydev = priv->phydev;
+	u32 pbus_value;
+	int ret;
+
+	ret = air_buckpbus_reg_read(phydev, EN8811H_HWTRAP1, &pbus_value);
+	if (ret < 0)
+		return ret;
+
+	return (pbus_value & EN8811H_HWTRAP1_CKO) ? 50000000 : 25000000;
+}
+
+static int en8811h_clk_enable(struct clk_hw *hw)
+{
+	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
+	struct phy_device *phydev = priv->phydev;
+
+	return air_buckpbus_reg_modify(phydev, EN8811H_CLK_CGM,
+				EN8811H_CLK_CGM_CKO, EN8811H_CLK_CGM_CKO);
+}
+
+static void en8811h_clk_disable(struct clk_hw *hw)
+{
+	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
+	struct phy_device *phydev = priv->phydev;
+
+	air_buckpbus_reg_modify(phydev, EN8811H_CLK_CGM,
+				EN8811H_CLK_CGM_CKO, 0);
+}
+
+static int en8811h_clk_is_enabled(struct clk_hw *hw)
+{
+	struct en8811h_priv *priv = clk_hw_to_en8811h_priv(hw);
+	struct phy_device *phydev = priv->phydev;
+	int ret = 0;
+	u32 pbus_value;
+
+	ret = air_buckpbus_reg_read(phydev, EN8811H_CLK_CGM, &pbus_value);
+	if (ret < 0)
+		return ret;
+
+	return (pbus_value & EN8811H_CLK_CGM_CKO);
+}
+
+static const struct clk_ops en8811h_clk_ops = {
+	.recalc_rate = en8811h_clk_recalc_rate,
+	.enable = en8811h_clk_enable,
+	.disable = en8811h_clk_disable,
+	.is_enabled	= en8811h_clk_is_enabled,
+};
+
+static int en8811h_clk_provider_setup(struct device *dev,
+				      struct clk_hw *hw)
+{
+	struct clk_init_data init;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_COMMON_CLK))
+		return 0;
+
+	init.name =  devm_kasprintf(dev, GFP_KERNEL, "%s-cko",
+				    fwnode_get_name(dev_fwnode(dev)));
+	if (!init.name)
+		return -ENOMEM;
+
+	init.ops = &en8811h_clk_ops;
+	init.flags = 0;
+	init.num_parents = 0;
+	hw->init = &init;
+
+	ret = devm_clk_hw_register(dev, hw);
+	if (ret)
+		return ret;
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);
+}
+
 static int en8811h_probe(struct phy_device *phydev)
 {
 	struct en8811h_priv *priv;
@@ -838,6 +929,12 @@ static int en8811h_probe(struct phy_device *phydev)
 		return ret;
 	}

+	priv->phydev = phydev;
+	/* Co-Clock Output */
+	ret = en8811h_clk_provider_setup(&phydev->mdio.dev, &priv->hw);
+	if (ret)
+		return ret;
+
 	/* Configure led gpio pins as output */
 	ret = air_buckpbus_reg_modify(phydev, EN8811H_GPIO_OUTPUT,
 				      EN8811H_GPIO_OUTPUT_345,
--
2.34.1


