Return-Path: <netdev+bounces-222985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 472AFB576FF
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 12:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B58F0443F4A
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 10:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E7F3002AA;
	Mon, 15 Sep 2025 10:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fM8LvfjK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A6E2FF661
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 10:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933170; cv=none; b=PCOPMS/RChZN3wBH2ru5RjWPNLG9xec/usKVOXpuVeL8jQ6aoKuD2ZxyzDg0b6A2M0FDHpMtWfsq5qk/ZV8dxZDW2R3U/hM9ZD8ijEovr6gEPkkej3qk/qf615GiMt8Eu82/ZUxgy13uDQ8DSCZVzNj9RL1pBOp/MPcjPjRQFuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933170; c=relaxed/simple;
	bh=34II6QSuSwoQzRT0L+HwJfzI+Z0J5m5wN2WhQB82UBI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9W1d+s6p6hJUMEloV3AQFLGxh2mtFu2JK18iMbRrkUgEJqfss0+Xg9hohMp+l/44WrekCu4w4sA0Oa34/KGv6Wrn2cnkC7VUy9/QO83OfYEt9L615ooF9fjQ368UO5QfWxkKe90v3NbQPl8BzMqFI44iTq8eZ/+Vb1l5UDnc3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fM8LvfjK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45df7dc1b98so27511345e9.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 03:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757933165; x=1758537965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iF+wFLzqJgcC4lMJZbTMW9CSMXwTLFbaGRq/VOX71hY=;
        b=fM8LvfjK4lS3b0EZpgZckL+0p47QqILtEQbmsr4u5SR0zYLgfS908WlhubNaZw3Zp/
         5ElxUNL/EOIWDdnt183AuY0OeWVwYZxH3Qkwh5yBtUtoPGqpCXKlv9vfHUEzrab+6JIZ
         YuJgAiddwvZqoChcHUapCb3cHrYg56DpnjWCCn2zHDurzWLB4ugBgmSVPRFOBFfbuwIr
         MMM7mSjrhzfU8rV7MEtjYdC87f6a6UwWtxqSXTEVPYbFfkJ1QArzo3HSe6UqxWv7ujpW
         9Hg/8XMvMcRy0tDe0k4tK1GH+m16CCNUUeiV3p/Ncb1YCYZKCscq9S08LZ2UwbjEPjsC
         WJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933165; x=1758537965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iF+wFLzqJgcC4lMJZbTMW9CSMXwTLFbaGRq/VOX71hY=;
        b=kIXo7p04BUjihVGeGLKwjRDxAuU5MuG9FRFOAs50ulyxUSIKxdhHJ/H1yj5VW4rZ4K
         cCY+saM9DGY42l3+JqhHL3O22Wvvf40va4VND1Lw479VjfZlizwK6TgLjX7LrkjGzvQs
         YTuHn0qnprs7JssGG0Sme7ypMgTfrB1uuizCfFrqcpBpSO2HFQ7y3T6NNixY+WseOGuk
         RmxggOZ4g/rxUYyREECkOlvX8qS68E0dDDd5TxS20BtMCukA9pl66vMCiCNHHXRyOkTd
         8T/2YArGpTNq+qogjzH1dSzYOx+BZefxZPSyv0iEQVehu6JjryV4EwqM7KKnJgjkWTzj
         qWjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQQAVfUxyD4QWeJCDnpzs8Phdibg4eMl2ufAk0HXxNZvoT4eDpDOeswkoOPrGN4HeenVVdJeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHbTGFnRB2YhQA2xyHXp59O8S6rhMsvKVWlQs5bbWt+b6lw6on
	YwP+D4wAfT7hkjMGIkwJ0Os0YbVyIGqTJPz6ce3IrYdSOgGPcO0jt9I8
X-Gm-Gg: ASbGncu8DAlkEk7xKE91uBWjs/BUYUqpbH+nPtx7HahQnHg9euJm4mlPs+SCscixPeQ
	7bcy+5h31wLTgcC3YiIvnYJh8sswxueQ+pAnDP/FQ/dKNj2TvM2dhmUX1h55HdOgQ1sC4O8dn87
	E3+HFD+kYxMulE1IPoX1NPQRNg2lLUXa0JsdOPUIuuCuqY7n7Fni9pDOHdp7UC2Q5GejvYltqly
	Qa2WT76bJALJSM69H8LLKUUrHb8oNwd6lvoAz1AJbU2du69Vre2Ol6U9+rU6+PUfpjW+hFIMhMu
	n1kcL6Q+7be35b4tLuXic/hvdIJEplEfcScC6/LfuNd0otvBICN7CsHPVqFyCT4bC8Am36SML5h
	e+JtFJloSDBuVXohK+khf39S3CKuBnWxVyUtpqUdbJ51l0j94B3rKTzqm6xV97FrMtmMOVOIPNN
	KHJ5ui+xKxNqOde1to
X-Google-Smtp-Source: AGHT+IELDq9C+qaqcHK3qQ1jq6BhDiChpwSKwzWT15EdBPczDHPZKj3STFqLVsQfYL1hX2wJvmW1ig==
X-Received: by 2002:a05:600c:1c9b:b0:45d:dd47:b465 with SMTP id 5b1f17b1804b1-45f211c8395mr96901105e9.7.1757933164393;
        Mon, 15 Sep 2025 03:46:04 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45f2acbeee0sm67163365e9.0.2025.09.15.03.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:46:04 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v18 4/8] net: dsa: tag_mtk: add Airoha variant usage of this TAG
Date: Mon, 15 Sep 2025 12:45:40 +0200
Message-ID: <20250915104545.1742-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915104545.1742-1-ansuelsmth@gmail.com>
References: <20250915104545.1742-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add variant of the MTK TAG for Airoha Switch and comments about difference
between Airoha AN8855 and Mediatek tag bitmap.

Airoha AN8855 doesn't support controlling SA learning and Leaky VLAN
from tag. Although these bits are not used (and even not defined for
Leaky VLAN), it's worth to add comments for these difference to prevent
any kind of regression in the future if ever these bits will be used.

Rework the makefile, config and tag driver to better report to
external tool (like libpcap) the usage of this variant with a dedicated
"Airoha" name.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/net/dsa.h |  2 ++
 net/dsa/Kconfig   | 11 +++++++++++
 net/dsa/Makefile  |  2 +-
 net/dsa/tag_mtk.c | 36 +++++++++++++++++++++++++++++++++---
 4 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index d73ea0880066..bf03493e64ab 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -55,6 +55,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_LAN937X_VALUE		27
 #define DSA_TAG_PROTO_VSC73XX_8021Q_VALUE	28
 #define DSA_TAG_PROTO_BRCM_LEGACY_FCS_VALUE	29
+#define DSA_TAG_PROTO_AIROHA_VALUE		30
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -69,6 +70,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_KSZ9893		= DSA_TAG_PROTO_KSZ9893_VALUE,
 	DSA_TAG_PROTO_LAN9303		= DSA_TAG_PROTO_LAN9303_VALUE,
 	DSA_TAG_PROTO_MTK		= DSA_TAG_PROTO_MTK_VALUE,
+	DSA_TAG_PROTO_AIROHA		= DSA_TAG_PROTO_AIROHA_VALUE,
 	DSA_TAG_PROTO_QCA		= DSA_TAG_PROTO_QCA_VALUE,
 	DSA_TAG_PROTO_TRAILER		= DSA_TAG_PROTO_TRAILER_VALUE,
 	DSA_TAG_PROTO_8021Q		= DSA_TAG_PROTO_8021Q_VALUE,
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index 869cbe57162f..7d63ecda25c8 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -98,12 +98,23 @@ config NET_DSA_TAG_EDSA
 	  Say Y or M if you want to enable support for tagging frames for the
 	  Marvell switches which use EtherType DSA headers.
 
+config NET_DSA_TAG_MTK_COMMON
+	tristate
+
 config NET_DSA_TAG_MTK
 	tristate "Tag driver for Mediatek switches"
+	select NET_DSA_TAG_MTK_COMMON
 	help
 	  Say Y or M if you want to enable support for tagging frames for
 	  Mediatek switches.
 
+config NET_DSA_TAG_AIROHA
+	tristate "Tag driver for Airoha switches"
+	select NET_DSA_TAG_MTK_COMMON
+	help
+	  Say Y or M if you want to enable support for tagging frames for
+	  Airoha switches.
+
 config NET_DSA_TAG_KSZ
 	tristate "Tag driver for Microchip 8795/937x/9477/9893 families of switches"
 	help
diff --git a/net/dsa/Makefile b/net/dsa/Makefile
index 555c07cfeb71..7aba189a715c 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -27,7 +27,7 @@ obj-$(CONFIG_NET_DSA_TAG_GSWIP) += tag_gswip.o
 obj-$(CONFIG_NET_DSA_TAG_HELLCREEK) += tag_hellcreek.o
 obj-$(CONFIG_NET_DSA_TAG_KSZ) += tag_ksz.o
 obj-$(CONFIG_NET_DSA_TAG_LAN9303) += tag_lan9303.o
-obj-$(CONFIG_NET_DSA_TAG_MTK) += tag_mtk.o
+obj-$(CONFIG_NET_DSA_TAG_MTK_COMMON) += tag_mtk.o
 obj-$(CONFIG_NET_DSA_TAG_NONE) += tag_none.o
 obj-$(CONFIG_NET_DSA_TAG_OCELOT) += tag_ocelot.o
 obj-$(CONFIG_NET_DSA_TAG_OCELOT_8021Q) += tag_ocelot_8021q.o
diff --git a/net/dsa/tag_mtk.c b/net/dsa/tag_mtk.c
index b670e3c53e91..32befcbdf4be 100644
--- a/net/dsa/tag_mtk.c
+++ b/net/dsa/tag_mtk.c
@@ -11,6 +11,7 @@
 #include "tag.h"
 
 #define MTK_NAME		"mtk"
+#define AIROHA_NAME		"airoha"
 
 #define MTK_HDR_LEN		4
 #define MTK_HDR_XMIT_UNTAGGED		0
@@ -18,6 +19,9 @@
 #define MTK_HDR_XMIT_TAGGED_TPID_88A8	2
 #define MTK_HDR_RECV_SOURCE_PORT_MASK	GENMASK(2, 0)
 #define MTK_HDR_XMIT_DP_BIT_MASK	GENMASK(5, 0)
+/* AN8855 doesn't support SA_DIS and Leaky VLAN
+ * control in tag as these bits doesn't exist.
+ */
 #define MTK_HDR_XMIT_SA_DIS		BIT(6)
 
 static struct sk_buff *mtk_tag_xmit(struct sk_buff *skb,
@@ -94,6 +98,7 @@ static struct sk_buff *mtk_tag_rcv(struct sk_buff *skb, struct net_device *dev)
 	return skb;
 }
 
+#if IS_ENABLED(CONFIG_NET_DSA_TAG_MTK)
 static const struct dsa_device_ops mtk_netdev_ops = {
 	.name		= MTK_NAME,
 	.proto		= DSA_TAG_PROTO_MTK,
@@ -102,8 +107,33 @@ static const struct dsa_device_ops mtk_netdev_ops = {
 	.needed_headroom = MTK_HDR_LEN,
 };
 
-MODULE_DESCRIPTION("DSA tag driver for Mediatek switches");
-MODULE_LICENSE("GPL");
+DSA_TAG_DRIVER(mtk_netdev_ops);
 MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_MTK, MTK_NAME);
+#endif
 
-module_dsa_tag_driver(mtk_netdev_ops);
+#if IS_ENABLED(CONFIG_NET_DSA_TAG_AIROHA)
+static const struct dsa_device_ops airoha_netdev_ops = {
+	.name		= AIROHA_NAME,
+	.proto		= DSA_TAG_PROTO_AIROHA,
+	.xmit		= mtk_tag_xmit,
+	.rcv		= mtk_tag_rcv,
+	.needed_headroom = MTK_HDR_LEN,
+};
+
+DSA_TAG_DRIVER(airoha_netdev_ops);
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_AIROHA, AIROHA_NAME);
+#endif
+
+static struct dsa_tag_driver *dsa_tag_driver_array[] =	{
+#if IS_ENABLED(CONFIG_NET_DSA_TAG_MTK)
+	&DSA_TAG_DRIVER_NAME(mtk_netdev_ops),
+#endif
+#if IS_ENABLED(CONFIG_NET_DSA_TAG_AIROHA)
+	&DSA_TAG_DRIVER_NAME(airoha_netdev_ops),
+#endif
+};
+
+module_dsa_tag_drivers(dsa_tag_driver_array);
+
+MODULE_DESCRIPTION("DSA tag driver for Mediatek switches");
+MODULE_LICENSE("GPL");
-- 
2.51.0


