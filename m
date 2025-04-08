Return-Path: <netdev+bounces-180136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFFDA7FAA5
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 12:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2484F189ACD3
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C912269AFD;
	Tue,  8 Apr 2025 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjgrE89G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376C1269899;
	Tue,  8 Apr 2025 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105960; cv=none; b=CWr+3PEpPsJMYyipn8ryS1JBYuKe/wiJMsYwa7iV9AVtZiDp6UgMGA+vDAdLANVwKG4S5r/jfrCTXOqfdEdXKfCUgoCjnUYHIgtTQSA7Nx3pSzqkDmku5oVE0VQJ7r+Qx0ylhJPp0H+P0oCmLOZAWGA0JVQMulut8fTQMDUZTwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105960; c=relaxed/simple;
	bh=EQzUDFfnxMaPCgzvLAWUznL40gFuxneWacKGexy4pOs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+u8UXC/uiPyu0ZSh+JkXwBiJtaH1Xt/x/oulQgAyeqiL6trh8wx53oK87AUt4Y4m3KjnpDSt/gl9vEY+c33VqG9aYl6CfHU0ux6Or3PukXyDK/2OOBvdlEJ5m3JGq3yuiUXwkZK4Zh+BpQ4S0PtVunIPbZue0GMmNFv3vz1BCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjgrE89G; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4394a823036so49337465e9.0;
        Tue, 08 Apr 2025 02:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744105956; x=1744710756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/W0x52D15NfB+BOP8T/m/ZC7owLNeVqs+BHfnihvT0=;
        b=OjgrE89GLXxP8rYR8Xiuj7UchFL/vpAvP3GWkG6tN5fEkw9jxadNvvySc8GEb8FDym
         F7UwN/visvE8bded9WRJGsMbMhfzRX0xAQL+7dd7YRPvo01hX6lVfiOowOE5Avcxd4A4
         Cej2JVPu4O2bzsl1a0FPaOx6y5alQCepML0DNzYQk6N3vYiVBiNIe6h7M4JPh201oIWh
         +t/vmbMI9ilSGa9qz7+eYWNKHQSuSylp6kvmUQ6LZbz8qm+0B8NIYrNOI2wd3Ry/jDxy
         LAN2QINmIbK1IB2iUiyNBHnyoDkDbvBnkYokFAZWplgLvQ7kmG6ItCO6p6/wH4r9i8N2
         J+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744105956; x=1744710756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/W0x52D15NfB+BOP8T/m/ZC7owLNeVqs+BHfnihvT0=;
        b=sZnu+gSywLyF9Ns+dIWJVoCDOugbWIR4nsuOmf8HfeentGDIeFpeQ5G7QpP425dQGQ
         unwJyNmC1LJeM9nNRgEJYQvhyNW/rRIuJ7wlnilihVgfJH42sUMQyIMluOJZHj01AdM5
         Sx37cILu59iDi/oOffLVB6TdbuOYl0l+dkVbpKa9pO8TnkImiiUMB/7I4sSR2hlOWPES
         UujQR1SiBEEt7Mc3kZArtJAP02ZrFbALoA4BKhj+cl2z9gWwxw7UBj7zeOjdyep6l/J9
         0iIjA7PHNa/Zs5hoGpuncKK4dDHre7m5p/ZgqFlZs3WrQ45JyZwXXZuIYqYihXili8Yb
         QVvg==
X-Forwarded-Encrypted: i=1; AJvYcCU0LAbvQZ1gyIqUKt2EtsJ4UIPS2qerebHYAcq3FfiqOTAeXnC0Z+xoHo/Falu8ktxKPiL1pFcs@vger.kernel.org, AJvYcCURskU/SsH4/ngMdFwbMJlYV+8XOSFkaxhhRKIq/A1wG2N79IOZjIJPnyALvC2SqgtNSMnRKDkjCk3s@vger.kernel.org, AJvYcCW/9XpjBgNI9iu8dzoX9T4bzB48CiscwK/p+d6lPw4QmFq31LpQ1boQa+KgZIQgxTThT6cvMPl35k+QozTy@vger.kernel.org
X-Gm-Message-State: AOJu0YwCt7BSEZA5lJ9m/55DHRGjVRHt6g1ZLnkzr+jRp+wAhX3oY/i9
	NE9STs+WwJM8kgPGRlo32OqueqZF4yOLMWheb+eggWnJUaxNpwYN
X-Gm-Gg: ASbGncvv9WEbEB1LbT1Wsdm4JBkOOm1rzeLTrWwkZAG6juxO+viuM4s166VUZu/xHis
	SIsth/jbW6iTfYGjrwdFJZsSKvJQzLfp7ywi9nixjRJ/Q8kszWrgUWCCyueIDB84VRQL7nTCH97
	J1DqAUlKk1bSeJ7Yrzad7td3EKynKF2jFc5jsEc1CcTvxe+8qFh1kH/iRvFnEcVZO1AclSdtKEB
	/TlPcQ4pDgwdAwEnzxQiL6Njom31/ji6y5jaVG9Qx+c7pGuWhjTNmvOsqZzD8N7gl9vvY/E2sTj
	SmITGFai6dtEZve0ab74uiXL+NRP+dyEEj0S4+SIoErIzaVS4kM++2Lm+1O+aIIrrkB6I/+/WPg
	Sp+Ft0SnfztS3Aw==
X-Google-Smtp-Source: AGHT+IHnIRihboK4mhsVHOwL3IqceZiuQzPsMe0EptmYYIze/kCrhf/3JVkvsqSSB53X5rHEN/sF5A==
X-Received: by 2002:a05:600c:1c17:b0:43c:f64c:44a4 with SMTP id 5b1f17b1804b1-43ee063fbc7mr115902005e9.8.1744105956238;
        Tue, 08 Apr 2025 02:52:36 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39c3020dacfsm14493310f8f.72.2025.04.08.02.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 02:52:35 -0700 (PDT)
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
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v14 16/16] net: dsa: tag_mtk: add comments about Airoha usage of this TAG
Date: Tue,  8 Apr 2025 11:51:23 +0200
Message-ID: <20250408095139.51659-17-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250408095139.51659-1-ansuelsmth@gmail.com>
References: <20250408095139.51659-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add comments about difference between Airoha AN8855 and Mediatek tag
bitmap.

Airoha AN88555 doesn't support controlling SA learning and Leaky VLAN
from tag. Although these bits are not used (and even not defined for
Leaky VLAN), it's worth to add comments for these difference to prevent
any kind of regression in the future if ever these bits will be used.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 net/dsa/tag_mtk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/dsa/tag_mtk.c b/net/dsa/tag_mtk.c
index b670e3c53e91..ac3f956abe39 100644
--- a/net/dsa/tag_mtk.c
+++ b/net/dsa/tag_mtk.c
@@ -18,6 +18,9 @@
 #define MTK_HDR_XMIT_TAGGED_TPID_88A8	2
 #define MTK_HDR_RECV_SOURCE_PORT_MASK	GENMASK(2, 0)
 #define MTK_HDR_XMIT_DP_BIT_MASK	GENMASK(5, 0)
+/* AN8855 doesn't support SA_DIS and Leaky VLAN
+ * control in tag as these bits doesn't exist.
+ */
 #define MTK_HDR_XMIT_SA_DIS		BIT(6)
 
 static struct sk_buff *mtk_tag_xmit(struct sk_buff *skb,
-- 
2.48.1


