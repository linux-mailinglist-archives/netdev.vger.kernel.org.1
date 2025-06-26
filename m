Return-Path: <netdev+bounces-201690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC08EAEA8D6
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 23:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2ADB5682B3
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 21:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC40F28D8DD;
	Thu, 26 Jun 2025 21:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpSZrbtI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9D5260577;
	Thu, 26 Jun 2025 21:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750973054; cv=none; b=QzrrSBoByzAk8F/JYEPwbbz1GEd5caiv8EsLIFmeBxpLrRIg/YiA6Pe/HJlCt00hqx/enD4WP7yOop2R7hIjBeKfpu6FOs+qt/JTaAgYDkiUCIdMANakpdw0tPOsBEaQ8mltxxpzmEbQYc+O1Fy2Lm8W8ocKQ88xWY++nDB505s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750973054; c=relaxed/simple;
	bh=EQzUDFfnxMaPCgzvLAWUznL40gFuxneWacKGexy4pOs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jLP+QidceskUKS7qS9UHQBT5oFMnnMrg4jXigRpwkeg7DXST3UsbJN2bguwaS4Xr12xWDTVV01w9yWlHnYEwcjJF4MIxvzCMpSO3FRy58wm0vZW7H42EG7JvNoqMjUK7zC851A7Ke6gzN13ZH7MkO2wPa3hJoOsLiD7MgjQO8P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpSZrbtI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-453398e90e9so10655805e9.1;
        Thu, 26 Jun 2025 14:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750973051; x=1751577851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/W0x52D15NfB+BOP8T/m/ZC7owLNeVqs+BHfnihvT0=;
        b=PpSZrbtI+glez34OxYMIJQZEuIjC+Fvm40mLVsCuNTe7hI39CwPczCNZzMGqnhiDzG
         sPlPKhBdjh3ZU/MuyC/XfrTfMa2lZCY+4jYI6qkbov33RqrRf2wS7/no7fYf/zPsAAjk
         foB2fYwI6Dov7luXsCC0PvFg4lTosTEWPQ0I5G00JrZMgLfqxDdIget3d4l+lflYt1mt
         xbzj7orABmYq3w49FlyWSBZ6khg8FdkMJ98hAb8pugz1pJnoeKAQos2yfa1Enft0aklY
         gyT7vcPcqD0h5BmREuGLoGkHVbxCnS1+tp7tOGsTJLkJiNyaNU86S1vn2HYV8C0xOyL5
         13Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750973051; x=1751577851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/W0x52D15NfB+BOP8T/m/ZC7owLNeVqs+BHfnihvT0=;
        b=kRyXD1NFiKBCls5GpCVkxq5FEY3rmAQNE/fm6MLjtBGcYsYarAvckgcBNE+LIGT4+u
         JIgPMVux4oFaNiksc4+MenQUZX1FiHnfdExGHNX//DNOKjbgAiEgkEQqOJo4NPIX0ce2
         C6eQ+PM2wU/pFICcvBYx6IXMQVkzFq72yyKwufUBmCRY/D6SCB5DsVFM79JBtxgDfphA
         /Yuew6kJWxfstKBnoJu+KZYfgeDNBo3ItWjt6yGi2sYUKsGMykd8dUxbXBW4I0skqShH
         6XEKzKsUPEIGnODpqCXdNY8k25RKdHcrI7D8ZKItx9FkdV/XVQ2KpLY4BoDBXE5wW0x+
         SOrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX+JvBQ86DjiRGTpJIaNuUT4AJUuRl0b++7P0szyMDCvYySxATtAuk9sBBRE1pb5lUiCBQOmQP@vger.kernel.org, AJvYcCVjeIOkGXLEZgzkD+RgevF9SUOslr2hp0T+fwgZRLPkzwA/xuYUleLK+vxfUymgO1PkgajA9GxCiuVUmzXV@vger.kernel.org, AJvYcCWkP2mB4QMuRlm5IMHfY9zGEBlcq7WGRS1jn654qHI5tDIscfWArOV/c6R5V28JtHfxp3Ky3uJPD+v2@vger.kernel.org
X-Gm-Message-State: AOJu0YzMrgqJnVT4weLFvTmFSaOo2b3HEbHPLA4b1oVB3YJhWwYZF5dt
	cv9k204L7LBXXsrbxElZ2ZWmlTFBePHTp4LDgLzY/fS/YVL171KZaijc
X-Gm-Gg: ASbGncs2ZEeBmCUEC+jkophRoWWMJ4fIKq3iwOuA9mkoZ8bAh7l63SrjJ3f8A73c47p
	5UtXScQY08pd98Oh8xu7M+HCpK1lDpNb2lBruqlVlXVHQIgl3bU7EtxBBDMs1F76S5jvX+YiRH1
	zW4e7q1Jot0Jk5zg1RUizi4EzK7qBASijbZUZW68BK7ckwGg9xSwU5ItqgS05fGtcL/gOS+bsvg
	vTpFxXbnNtAHZlxq0AZXEwWW5lub0ioim3sJW0/gYO3kSsQMbSKxfsS3VxI8fJ1JjOgWYnuKHa9
	IQ+CIfzzYT3OO3dqOjsCHPUXxc5Zj0U36IuIpXXtBPkdCMjWerQUeA263J9h08l6782c7N03Wjt
	RfDFG48+F7t5V606jhZIPr+XcRS9JCgc=
X-Google-Smtp-Source: AGHT+IHVLPfvW6O1oNCC2LT9oj+Qg1mkz0+DDsJBKHwZ+LBvaK0h+vlqLp0ai9AzKkbhD2TEc+EdQA==
X-Received: by 2002:a05:600c:4750:b0:43b:ca39:6c7d with SMTP id 5b1f17b1804b1-4538ee30effmr9653155e9.3.1750973051054;
        Thu, 26 Jun 2025 14:24:11 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-453835798acsm57186475e9.10.2025.06.26.14.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 14:24:10 -0700 (PDT)
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
	Srinivas Kandagatla <srini@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
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
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v15 12/12] net: dsa: tag_mtk: add comments about Airoha usage of this TAG
Date: Thu, 26 Jun 2025 23:23:11 +0200
Message-ID: <20250626212321.28114-13-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250626212321.28114-1-ansuelsmth@gmail.com>
References: <20250626212321.28114-1-ansuelsmth@gmail.com>
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


