Return-Path: <netdev+bounces-118092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD1A950798
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 16:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17CF8B28A3D
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 14:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E750D19FA66;
	Tue, 13 Aug 2024 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvXseIby"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC3619EEBD;
	Tue, 13 Aug 2024 14:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559317; cv=none; b=uJ6bvqGJ1bW8L6xmh690j4Oowisukx+18zj6GJHeg2WS4/H+YxOfvYcvbmOgCLBD2Ts8pILg8902dKpqt4pH9ZNMsYoq9X1XBH7Yrh7TUiBRB5T/jLIdgj0O+4+iXFSrFTwiqFsjOHe6zdAZZP0hq81WINSK+ssVH6b+MXzu6QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559317; c=relaxed/simple;
	bh=MPZXuzZ8WACzat8l11Ii/Qp/mkN47G0iiUtzKBu72R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxSclDjvFwwUgFJOcKyGQBrRYTCOZTUmz4Ymg07hRO5Wdc1iNYM/iq/3ORYSUH/R4J2xAQ2k6Kb8lg53Mz/oJCFR8rdNlm2OL722HzwgoObblf7zv6kBy7lLpkOBsSf9PgqBc+o2LtP8HCU2+zdskDSQiuIYO1Jp5Kmq653626Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvXseIby; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f149845fbaso58773361fa.3;
        Tue, 13 Aug 2024 07:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723559314; x=1724164114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hn6Gg49+0hckXkrCaPpgjvaSHPmWcIMwvpPpEJxp9s8=;
        b=dvXseIbyGl8zeqg0bx2q+277fFe0Eav73EWTUtHEbUK7a4FcAolGGNdjd2+DHZ02PE
         XS+H/Ps8OZY2+Tg9vt/d+uWCTHrV7z6h5Dq8FPW5ceICHpwSlShDADwibqvohekbzmOi
         UIrBQDtfSH+QJi5PwuPbEf9xx3/fOlBC8yprh/J0myycmr2omha/F0bFhfyVzuu/YRQS
         1/4wYWSvXcSKLtVV/wy84/nLu/NQ2RZJiIquNmrJflCcFowNvUc2p5AfwGq67koOUYen
         UIzeaGS36FTgCjtFqcTXDPBLfnBqMqXIn+W6YZeyR48aHi1o+dN54rOFtvoAfcImlIyB
         4R7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723559314; x=1724164114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hn6Gg49+0hckXkrCaPpgjvaSHPmWcIMwvpPpEJxp9s8=;
        b=pUK9gqFUjWZaXwFErSAq/QqgbRV1XTKn6KUG/HSELm6eVonqWVBIAcIv05DMQblARA
         c0Ohqa7dFjWvMJGFSvozP84+DvnjXUVmSdlTnTbPwypS0hY5EcTiB+VSL/Hgd3W8DWpl
         aR4pQnO5b64zkLjRaazfAs3dHk74IgMOX4dKk0ZWtbM0pXzmCDZKJi3npeM/3S5uO2t2
         LpqCa1xEyQi4Xjaukn0YdvS3ZnIf8rCYmTRWXjHF6Ve9D0smAMURQZCFSDQoHlK+oE38
         GWIU3y6GHbJ1bDmwSJB2snrX0Be0TzH1jS7Q1BSrLNrbnis2VkqPtYubPQLYEC4+fqga
         qqHA==
X-Forwarded-Encrypted: i=1; AJvYcCX2d7yUGvzsAXYyxXoRjSNtquCsfJqGStU/fbC8pcEYX+paLVQUVsJ3D35fYTiRhSOCoJfjXclCfIpP6NK8H0nYZGNP4pxQMfRAXhKWf3HLZ2+l3l2fIYdCWvzFkUgcodqawivj6c/hY3g6V9/8ohNV5CxZyUUKHzsMy2qWJ8amGA==
X-Gm-Message-State: AOJu0Yy5Pb/tuqAcPns4fQUTt321cXj6R4LJwOVX50IjY9XD5gAgiOLr
	Ynd7hkAjSiVGD5gu9/lb8N/uJ5gE8sUq0l335/k67y+bW03XlO1E
X-Google-Smtp-Source: AGHT+IF87do1H9InRqDB5Qgg5LpkSpMVtB6L44r6xxw4f65l1fI92ZeQAyrs/Ihk8e7lWJ3t2omBYA==
X-Received: by 2002:a05:651c:19a6:b0:2f0:1a19:f3ec with SMTP id 38308e7fff4ca-2f2b717a379mr30497411fa.33.1723559313735;
        Tue, 13 Aug 2024 07:28:33 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fa7c27sm74345166b.66.2024.08.13.07.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 07:28:33 -0700 (PDT)
From: vtpieter@gmail.com
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	David S Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marek Vasut <marex@denx.de>
Cc: Woojung Huh <Woojung.Huh@microchip.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH net-next v6 6/6] net: dsa: microchip: fix tag_ksz egress mask for KSZ8795 family
Date: Tue, 13 Aug 2024 16:27:40 +0200
Message-ID: <20240813142750.772781-7-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240813142750.772781-1-vtpieter@gmail.com>
References: <20240813142750.772781-1-vtpieter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

Fix the tag_ksz egress mask for DSA_TAG_PROTO_KSZ8795, the port is
encoded in the two and not three LSB. This fix is for completeness,
for example the bug doesn't manifest itself on the KSZ8794 because bit
2 seems to be always zero.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
 net/dsa/tag_ksz.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
index ee7b272ab715..1f46de394f2e 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -111,9 +111,10 @@ static struct sk_buff *ksz_common_rcv(struct sk_buff *skb,
  * DA(6bytes)|SA(6bytes)|....|Data(nbytes)|tag0(1byte)|FCS(4bytes)
  * ---------------------------------------------------------------------------
  * tag0 : zero-based value represents port
- *	  (eg, 0x00=port1, 0x02=port3, 0x06=port7)
+ *	  (eg, 0x0=port1, 0x2=port3, 0x3=port4)
  */
 
+#define KSZ8795_TAIL_TAG_EG_PORT_M	GENMASK(1, 0)
 #define KSZ8795_TAIL_TAG_OVERRIDE	BIT(6)
 #define KSZ8795_TAIL_TAG_LOOKUP		BIT(7)
 
@@ -141,7 +142,8 @@ static struct sk_buff *ksz8795_rcv(struct sk_buff *skb, struct net_device *dev)
 {
 	u8 *tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
 
-	return ksz_common_rcv(skb, dev, tag[0] & 7, KSZ_EGRESS_TAG_LEN);
+	return ksz_common_rcv(skb, dev, tag[0] & KSZ8795_TAIL_TAG_EG_PORT_M,
+			      KSZ_EGRESS_TAG_LEN);
 }
 
 static const struct dsa_device_ops ksz8795_netdev_ops = {
-- 
2.43.0


