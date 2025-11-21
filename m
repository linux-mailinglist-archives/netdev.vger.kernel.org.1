Return-Path: <netdev+bounces-240730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C84C78DCE
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 12:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6FC44EDA87
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 11:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EB534BA4E;
	Fri, 21 Nov 2025 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afavU62X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC3D26E70E
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 11:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763724970; cv=none; b=kwjlQQjUqZft4VTU4nN0ss6ggPQkbg22/5ZQ3LWESWNGSAqGrLm2AuAio3THObiJQXWdlcNZNUlcwQU3vPWN0jSmPv2Wp3UBMSE35CFa2GYEpSKs7974ncV16VgpFqYIOCqKVdd/snMKPFGFqa+yBVXbpliMD3qt1/Dqcug24LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763724970; c=relaxed/simple;
	bh=yCB3+ezRSYEUQgdD1MGZqHvmALaN2Xqrg4u25F6U+GY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6mk+snvvAT6QlmGZ4pq7t2zQ9yW9qmJ/W7SRCsJ48q6VZSSgAN2u/leEISA8DMFEuLT7LxsRbxcFod3XD3jVNghI5c8jHszonsnpyBvc4f9o1razi4Xh/nNWZtIBeHwFDkximD9oYHei5UAVxPpUrCxvYygqEwGCm488oiLihY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afavU62X; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47789cd2083so11736425e9.2
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 03:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763724966; x=1764329766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNyX5XLD0/DFtoBC+0XRb33jjMogv+sdoEl7ypxAYys=;
        b=afavU62XJ+1Jst0o6endtEU8qKpuJh/kCG9bVUx5284yNjNgvsHT8UgM0c4R1TMlaf
         LvDkftf7Y0dQXVvqU9yB8aNuw+oA4+VUJURzqdRWzc66MB1ggI6Ghr/zdjESyErOUhIC
         zNGd1+KMDgfWWX51iSoPKekDJCTU3mJcnJasbhRydLKYwE9fr86PLZRP9fVbaOYirY7D
         zNbMLZ23aZsztZDaY5vYfadh5osRwAdLnQanFnrgIUNPArT8VcNcV6pkLVV1+L7x80Ol
         Uq5UxrC5fhdrTl6Wb5oEcnJwjK3KoQweVlZSU5C0flPqMYObGVffP3nVMaDWLSOZbzEp
         DzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763724966; x=1764329766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JNyX5XLD0/DFtoBC+0XRb33jjMogv+sdoEl7ypxAYys=;
        b=nADINAZFE4jDNBQb4Vctd9VOOHIN/zAJwnsxsLqwcYOtKItM5g79OwzRkmerRe5NJ6
         4WuqpOok9T/DQ3wu3ZZgcbY8EDz9G1ZnrzMq/OFVQMcAOvl1SfF0Kc7ZCz/R0X/fioRq
         5HFK5iXqo+bVlhq9F0RRGt0L7TfWBeBpfjYmxhTUf7biXqpf+d9y9qViyIJ9Nhthb4/d
         PJWx/Px5oHCWtQYrIHUCtn8/BOErB2VrKwA9B4/dK6ZhjpKJ9wjTy3/e4U21D9OQ/c8A
         0ByFSejOtzjgDmU2QEMRfOLFQZPKIcsaJKlfKbGYAuvBhLgHPth9eKr9v08rR/E6qsWe
         Ayhg==
X-Forwarded-Encrypted: i=1; AJvYcCWNigRqZ2QChWZ5ED0qk5Uu1iD/VcyJF9dhQuhI8X+kr2wUFdIStFfJCvHd3g2eA0FbQTWfxi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdhciH0AZHS6sFdtSpuiierBR+YNYGA865UAn2s2pWlrDl6tlW
	iNTnxVIleCq2wBOv+BFZirBL8GBW8NkoXcIOo1CpTr8ax1NTGe54vcSX
X-Gm-Gg: ASbGncvF8WKw+BDBSO2Ch6Ct9jKKNrX/oJbIAYoYIZdoFhbie1DjR4ulsDoZku8I5m7
	RoOfLh/iz4MImPZMCnAwUhJhn05QX0FZGVFAMOn/ORWXprAE8nStyIPCH5RmbpGNNUeu9Wcxw+i
	tNuEVBmWgla8udqyFC4j3K1mzbaXNhBJogqi56vmoAQACpDKznVnhl1oEJNbgJKPZrS46IiGFA0
	DO2Nj9IdG+guYhVBILLKVoKgkp0vGHEKct9/OTDtKsDc1lBqqfEYtV00ryLjhCrLMcSM+X8uSHW
	s1CAUuaTGJzRoUzElXypBSs4K5pOpm8w72XLpbrd82CdVDjf9JYv6iWb7kc1b606DCjKI0GQlJ7
	gxcCPTHVlitfhHOdBASjwjxRYXVa3xWHj7yIgYBAUCny6AB+HRkH2O303QUZZgFwuqP8PROWhH2
	88U7G8T2SxQio1wPYA7cNYYyCnbx7zhxgnVj4=
X-Google-Smtp-Source: AGHT+IFYrXJyawAYVnBufzc2lSXEab8S9Pyq28aFqYNuy0VZ1V9zJtn/NXRS/Rqd3af0vd+gooHTQQ==
X-Received: by 2002:a05:600c:1f1a:b0:45d:f81d:eae7 with SMTP id 5b1f17b1804b1-477c114f45fmr18432865e9.28.1763724965793;
        Fri, 21 Nov 2025 03:36:05 -0800 (PST)
Received: from iku.Home ([2a06:5906:61b:2d00:9cce:8ab9:bc72:76cd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf3558d5sm38732465e9.1.2025.11.21.03.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 03:36:05 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next 02/11] net: dsa: tag_rzn1_a5psw: Add RZ/T2H ETHSW tag protocol and register ethsw tag driver
Date: Fri, 21 Nov 2025 11:35:28 +0000
Message-ID: <20251121113553.2955854-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251121113553.2955854-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251121113553.2955854-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add an explicit tag protocol for the RZ/T2H ETHSW and register a separate
ethsw tag driver so the existing A5PSW tag implementation can be reused
for RZ/T2H without code duplication.

The ETHSW IP on RZ/T2H shares substantial commonality with the A5PSW IP on
RZ/N1, and the current tag driver does not touch the register fields that
differ between the two blocks. Expose a distinct DSA protocol and a second
dsa_device_ops to let consumers select the RZ/T2H tag format while keeping
the proven A5PSW handling unchanged.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 include/net/dsa.h             |  2 ++
 include/uapi/linux/if_ether.h |  2 +-
 net/dsa/tag_rzn1_a5psw.c      | 21 +++++++++++++++++++--
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 97d5f401cfcf..81302315e493 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -57,6 +57,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_BRCM_LEGACY_FCS_VALUE	29
 #define DSA_TAG_PROTO_YT921X_VALUE		30
 #define DSA_TAG_PROTO_MXL_GSW1XX_VALUE		31
+#define DSA_TAG_PROTO_RZT2H_ETHSW_VALUE		32
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -91,6 +92,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_VSC73XX_8021Q	= DSA_TAG_PROTO_VSC73XX_8021Q_VALUE,
 	DSA_TAG_PROTO_YT921X		= DSA_TAG_PROTO_YT921X_VALUE,
 	DSA_TAG_PROTO_MXL_GSW1XX	= DSA_TAG_PROTO_MXL_GSW1XX_VALUE,
+	DSA_TAG_PROTO_RZT2H_ETHSW	= DSA_TAG_PROTO_RZT2H_ETHSW_VALUE,
 };
 
 struct dsa_switch;
diff --git a/include/uapi/linux/if_ether.h b/include/uapi/linux/if_ether.h
index 2c93b7b731c8..61f64cb38b08 100644
--- a/include/uapi/linux/if_ether.h
+++ b/include/uapi/linux/if_ether.h
@@ -118,7 +118,7 @@
 #define ETH_P_YT921X	0x9988		/* Motorcomm YT921x DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
 #define ETH_P_EDSA	0xDADA		/* Ethertype DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
 #define ETH_P_DSA_8021Q	0xDADB		/* Fake VLAN Header for DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
-#define ETH_P_DSA_A5PSW	0xE001		/* A5PSW Tag Value [ NOT AN OFFICIALLY REGISTERED ID ] */
+#define ETH_P_DSA_A5PSW	0xE001		/* A5PSW/ETHSW Tag Value [ NOT AN OFFICIALLY REGISTERED ID ] */
 #define ETH_P_IFE	0xED3E		/* ForCES inter-FE LFB type */
 #define ETH_P_AF_IUCV   0xFBFB		/* IBM af_iucv [ NOT AN OFFICIALLY REGISTERED ID ] */
 
diff --git a/net/dsa/tag_rzn1_a5psw.c b/net/dsa/tag_rzn1_a5psw.c
index 201782b4f8dc..66619986fa71 100644
--- a/net/dsa/tag_rzn1_a5psw.c
+++ b/net/dsa/tag_rzn1_a5psw.c
@@ -23,6 +23,7 @@
  */
 
 #define A5PSW_NAME			"a5psw"
+#define ETHSW_NAME			"ethsw"
 
 #define A5PSW_TAG_LEN			8
 #define A5PSW_CTRL_DATA_FORCE_FORWARD	BIT(0)
@@ -108,8 +109,24 @@ static const struct dsa_device_ops a5psw_netdev_ops = {
 	.rcv	= a5psw_tag_rcv,
 	.needed_headroom = A5PSW_TAG_LEN,
 };
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_A5PSW, A5PSW_NAME);
+DSA_TAG_DRIVER(a5psw_netdev_ops);
+
+static const struct dsa_device_ops ethsw_netdev_ops = {
+	.name	= ETHSW_NAME,
+	.proto	= DSA_TAG_PROTO_RZT2H_ETHSW,
+	.xmit	= a5psw_tag_xmit,
+	.rcv	= a5psw_tag_rcv,
+	.needed_headroom = A5PSW_TAG_LEN,
+};
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_RZT2H_ETHSW, ETHSW_NAME);
+DSA_TAG_DRIVER(ethsw_netdev_ops);
+
+static struct dsa_tag_driver *dsa_tag_driver_array[] = {
+	&DSA_TAG_DRIVER_NAME(a5psw_netdev_ops),
+	&DSA_TAG_DRIVER_NAME(ethsw_netdev_ops),
+};
+module_dsa_tag_drivers(dsa_tag_driver_array);
 
 MODULE_DESCRIPTION("DSA tag driver for Renesas RZ/N1 A5PSW switch");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_A5PSW, A5PSW_NAME);
-module_dsa_tag_driver(a5psw_netdev_ops);
-- 
2.52.0


