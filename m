Return-Path: <netdev+bounces-221016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 796C9B49E46
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 02:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271124E00CA
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 00:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDBF258EC2;
	Tue,  9 Sep 2025 00:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/3TWMiv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BC62561A7;
	Tue,  9 Sep 2025 00:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757378657; cv=none; b=jAb7Jxt82Pj2RcHOcXYTy+SwEt4w9b+DYS+S8N5Q+jj7a7Jj3gdbFtvbFYQlqJJHIJY8w9HsSLKkA7eL2maJ1BR2kfSFVZ0K03m6JQR36HbaYVXzNr3GGo09jK9gFLsYl0cbhmVDNuEcgInCclFJmJ0YGxBb8lMEcEmxBAgkh8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757378657; c=relaxed/simple;
	bh=9PfEz4Fv9vbiKjA86FHBPrpc5Qev48VdLD6vnlFqEWY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XW3Ux7Gxq6ctIJlsvj3lmQFyy9OfSyJjEeQ9aJcJfk9h1LBmUbIMHf8lY0RWiN8O62N+yaIsmdLMQJtgcX4twJqnieGx3qsqHlny424aVtR2zIbNFikr38sMkNq2yq2dnnERTIjv7CID9P0VpkuUb+g4/GQRzmatVoGoK9kF5Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/3TWMiv; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3dae49b117bso4371521f8f.1;
        Mon, 08 Sep 2025 17:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757378654; x=1757983454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PuU6T+eoD1QuN+NeWoko591lM5GIskHpuTQRyHxrkMk=;
        b=Y/3TWMivO/appUsW/8AUmP44XYVZ8e/3n8zsPxemfPZfQjawwmmJjk5F37rYa8GWgU
         Y/p8ok3R6lshYmrfLKGkNQKN+cbi4+vBrKmOoxYXodI1kpq8849nlNhdKBWRm2oz1Pia
         kE4x2iYPbmoWnizq5DchjxUmmWePh24S+zmQhoGHpkkRx/hTDhRRbfaTTUmdPuRsNSFu
         GiomMuy1l4ZgJe9u8FUA/GBM1+bdqTLZbdfe/xQXR63l5Emb0tykAaGXQYNDRqrPzr3D
         5V7g96sfwhvtKcJEnDkCSwR68Zr0Vdjcl5APNZ+002DtukMFpHiw+xW18BgCmvU0D9Ae
         r6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757378654; x=1757983454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PuU6T+eoD1QuN+NeWoko591lM5GIskHpuTQRyHxrkMk=;
        b=A6Qi8c3ZgF/5nirog3Zk6ZrYF1ZKXFtnCOFIJvaS5bAPlrxAG/kNi8Vxv4B6LwOdTf
         Fc6Nf6Kfii38agD77yZCsByYlDafdXRxod0iHs6EJAYwIUXqrKSb+KFwx2iugj52W6pB
         05+mm4nIzxL5QykjDMia9nX0ztckc+e9NqpE2LSntWjlCgWBiYL9VPjUCEpGDBtQAnur
         bcjewHbtpLCsBHVsMRssKfvd/E4+yMhOCQImAvi9et28K/snqtZt/rQ0UdgBPGQY818V
         OzAqxx886esP610awdxY6tAIkEoNlZU5X5c363gdryI9Fdu6ZFGcr3poqw3tEX3GrpvJ
         CJgw==
X-Forwarded-Encrypted: i=1; AJvYcCUEgAaJX4aPMOqkP/QbNAZtJsWtaRnuMCjwrzpQPOx7KKj3YG4uLA4phA9abmDaJKx3XRht2frZFaJe@vger.kernel.org, AJvYcCUQBvHwg5pNB4KpJUYa867RTw2nqWoHdvF5IxDz0JtAvWgC9uypJhPFjQtCw7aD9L3QODdI/Qk99tAbLuNN@vger.kernel.org, AJvYcCV6/3aJLCjNbOd3ZYySHiyo+qqTfuvNgmXxvEBD6NuN1vQWfUgVUkg3d7KUZlUuJkv1Fons8gnl@vger.kernel.org
X-Gm-Message-State: AOJu0YwpEdi0a4nG3yp3xi7R0j38LRsCoiEd5tTwnbU/1Z9J9PiJjDPY
	M7Uf26b62ZKffrJv0g1scENu//IMGUrWcFadJjE5aCbILgj2bpj5pPkO
X-Gm-Gg: ASbGncsu1zgEdvi+CoOiC6oNRpEcJFCPPCfGlmaTVmKNTY7RrMVw3y3AdtlAtR4g8jK
	DY0BYbsqR3nyE1ht8xaDWSDituIpdjL9hyQiRDHNWJ4DmC9OjUmWWfC2oRGvLRzqmym+PBO/Dr5
	2Lkq4vgCzjDQ/Vzazhe8VKKuFSyf+iOTPknhRAsXURk0rbvLiPdMFoIHHW6+5u2WEOukEch4ZWN
	zTDVYB2D+4FpdXm2ACkFn97Om8zbUmILyVM6JbGq8O2arKJAQSYJq1pWClNdnwNHH860qDcfHhZ
	zvhMYF9lwbtLYasvtny7OetoOndvRiQfwBmx3fhlLh/jklq7C7sY9Gi3XRIXaEVMfjcvpaluPdd
	LlgjOAyZQVVkxmj0/J/DXcTi7WcPdcdbdeFx4ok7xgvXTW/POVNxHM1LUmwKPwx+T48stjTw=
X-Google-Smtp-Source: AGHT+IEcjcQHjuQxUzlPqCSGlAyA3Eba4g3hsWQufa/B2NEkUpIYPSPr3POj1KKYPpGs4Pe3LVCzHA==
X-Received: by 2002:a05:6000:1a8d:b0:3e4:5717:3684 with SMTP id ffacd0b85a97d-3e6462581a2mr9317938f8f.40.1757378654321;
        Mon, 08 Sep 2025 17:44:14 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45decf8759esm13526385e9.23.2025.09.08.17.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 17:44:13 -0700 (PDT)
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
Subject: [net-next PATCH v16 10/10] net: dsa: tag_mtk: add comments about Airoha usage of this TAG
Date: Tue,  9 Sep 2025 02:43:41 +0200
Message-ID: <20250909004343.18790-11-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909004343.18790-1-ansuelsmth@gmail.com>
References: <20250909004343.18790-1-ansuelsmth@gmail.com>
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
2.51.0


