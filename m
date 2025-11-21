Return-Path: <netdev+bounces-240738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E3DC78DAD
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 12:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 0A75D32AF2
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 11:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524EC34F461;
	Fri, 21 Nov 2025 11:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9HanB4/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B7434C134
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 11:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763724980; cv=none; b=hEYlc6SvKZJVgJLrBiKCeQhiOvGYqDm3dRK1uKND0O3TWEPHafycT+GNGD6uzp6XMaqhFMDibz/DIUH4rLy2tuKoc/tU/qhxiz3w5Tn0Z/sXfXx/Vxhb2HxoV2iRB1Ahg6wjZBpjSfhoXkVLwt3jMzxl0yQSFjGl6V6Erm//c0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763724980; c=relaxed/simple;
	bh=p0Zq4gARic389z5cUOv02yKuHJQNu/nVWEGHNiC33nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FRfExMTiDYwTvFEHU42FMir4zGNqds5pSDH/Vspb8TNODfHSr4EdFWb1NvW/Q4j3I4s/0WGHtMo5AsVdGzof9CdnjmpkJhmYv2xkaQAVMbrBUnmReT0vZsKIsm4edXSa8mUw3Qq+wKQ8IN64BlrYZxA9QAePl2banvtKhKHMN+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9HanB4/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso12981165e9.2
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 03:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763724975; x=1764329775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M398mpeozAislS4NsyHxHxkyx50MVbfvXAZ3uGjRUmM=;
        b=J9HanB4/BlxP5FZaTF8VRM2BjuTjaAj3BZlYLw/Q18MyMyXmaKkETwKRQhi2EgzOY4
         DOerkTXesDmXg4COahSg7Dj32LrMm/35Lx1g4cQT6vnZzufGWgg99aNqJ/x9foShzxOD
         CPCwOFtdl2mB7B7NGsJH6UL/wVQnr0IWSPMGxB5WHA18HjplzsxkIDGr8mvg+V1isbkg
         qIoGsJnE+NRF1x0pHUc9QEf2taVdYyhAYZbgExvo1SSCYacbLgae+B8LcHCkkeZIyO2H
         iVSR/uWBo9lPXwv2w4OWlGVzJ6E8qetfinDyVYMahF5AKvFHnHidRyVyJf0JLliOxfEo
         gsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763724975; x=1764329775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M398mpeozAislS4NsyHxHxkyx50MVbfvXAZ3uGjRUmM=;
        b=TSLkfijpt7YdC7IfcwxJB+QENg4wyL9FOb3vwO4vGc55WwSI9MbVX3eQHCwbYdO5SA
         fwnr4IvDywvvlT2zFpj+SqZWHGioBwE5KlTkyAcHteBbb8aTmQsbpNu2rz0BYthbtQfN
         j3BDRJgr8dirj2a/p/MAoVU++ydqXitQmH9C2tsFe0/UPB8cWXX5RpuxxicxvzrzuBRO
         NTaZ04bh6xt3RGeHAR8wE3SS4lFOPeR5GHzQf75gEWB6yjGDz/cyws4x2q/9bU55AQiM
         PVW4Xa0/jxBLZMOWR3TPOjfpXN5wxmqqSfHyM7+C7kgeO30F+4OC+z8SSYpEAoMV+dtz
         Fohg==
X-Forwarded-Encrypted: i=1; AJvYcCXEc20oHAEo0+YlgieQEZ3GO+iZ+Tz36Dk70TeJQOhka6Ge97jbrsXCBYmxdr5UBXgH+NFPfmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQC2XwX3LoEDpn3TMyyrWm87hg8nKTgcrlegpLR9R1CkG0iCKr
	veifmjwis+0PLJUJaZFM/Y/fGAC1dBiXUHq3/F9c9Wa5mmXlFxwPPx5l
X-Gm-Gg: ASbGnctwO/iy0+y/xWSYmHj0eRfY1IpSezr/yB+Nfr5urV5XyD9gLi7VRUGt/8l6SP7
	SkAcM/rneVRQxrgoWsoMRi1L4jpjf8HQYnt4aEtaroGsiUK7YRcbZKBb99Y9kZ3MzFQK0vXmK2V
	z8jo+4J5XL9HLxMQQ8jLRO6tplnHWCrl/KvZRdsTwChf+xj57AunrNm413JXPCcOONB9+J2HUjM
	IPT/P+fk44o9znnesvh49kpYvblRVkurCgG4NoA23u8IOMYhQ9qvoTB9NcUW7CrW475HEvcVDol
	IWehl++WyP3XprQePjerfFMv2eC6bp1VWcS/eYGl14i5tRmLghbTltzqGdCpPUdf3ap7QoNeM8/
	OV9CZL5BU9PP6YSeXbyWGh0i08SEAmeNYvVD/8G1xBPUzMGWziERpuBLF5fZaYLAQwXCXpjED/g
	R8latSmszt94LERTQLXi1m7lJvkfwfSK6pzd4=
X-Google-Smtp-Source: AGHT+IHGSARKVH87wKwqZXU+BypHZzYVsPLPqyAMU3sI2rXwgt9jOGXsb6RjgLHXNLjhSt8AyQ5uqg==
X-Received: by 2002:a05:600c:c8c:b0:477:73e9:dbe7 with SMTP id 5b1f17b1804b1-477c01f52cdmr22433365e9.35.1763724974873;
        Fri, 21 Nov 2025 03:36:14 -0800 (PST)
Received: from iku.Home ([2a06:5906:61b:2d00:9cce:8ab9:bc72:76cd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf3558d5sm38732465e9.1.2025.11.21.03.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 03:36:14 -0800 (PST)
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
Subject: [PATCH net-next 10/11] net: dsa: rzn1-a5psw: Add support for RZ/T2H Ethernet switch
Date: Fri, 21 Nov 2025 11:35:36 +0000
Message-ID: <20251121113553.2955854-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Add device tree match data and configuration for the Renesas RZ/T2H
SoC Ethernet switch. The RZ/T2H uses the same A5PSW switch IP as RZ/N1
but with four ports, the DSA tagging protocol `DSA_TAG_PROTO_RZT2H_ETHSW`,
and an additional 8-byte management port frame length adjustment.

This prepares the driver to handle RZ/T2H and compatible RZ/N2H
Ethernet switch instances.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/dsa/rzn1_a5psw.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.c
index 82f4236a726e..9f85a4526bd2 100644
--- a/drivers/net/dsa/rzn1_a5psw.c
+++ b/drivers/net/dsa/rzn1_a5psw.c
@@ -1319,6 +1319,13 @@ static void a5psw_shutdown(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 }
 
+static const struct a5psw_of_data rzt2h_of_data = {
+	.nports = 4,
+	.cpu_port = 3,
+	.tag_proto = DSA_TAG_PROTO_RZT2H_ETHSW,
+	.management_port_frame_len_adj = 40,
+};
+
 static const struct a5psw_of_data rzn1_of_data = {
 	.nports = 5,
 	.cpu_port = 4,
@@ -1326,6 +1333,7 @@ static const struct a5psw_of_data rzn1_of_data = {
 };
 
 static const struct of_device_id a5psw_of_mtable[] = {
+	{ .compatible = "renesas,r9a09g077-ethsw", .data = &rzt2h_of_data },
 	{ .compatible = "renesas,rzn1-a5psw", .data = &rzn1_of_data },
 	{ /* sentinel */ },
 };
-- 
2.52.0


