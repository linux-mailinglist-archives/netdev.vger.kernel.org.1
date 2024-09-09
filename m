Return-Path: <netdev+bounces-126537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1B6971B52
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 15:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1338281AAF
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 13:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD041B9B2B;
	Mon,  9 Sep 2024 13:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DO5LvU4O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207071B6549;
	Mon,  9 Sep 2024 13:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889389; cv=none; b=HBx8BTeUWb6mycUXWpK4/3GbRrCGnORXE8FaPb3nqR0rNiykA/JYrzv2a4pViNlD4XbSnOMcR8OaHTCnXXQbh6zgNC+SXDsc9WJS0z2Gj8m9uQH5svKUADtgSLXbHjl0CuajAiL+OTwgB/KDKUeU+V9BCKcxPS7j3QJJz3wp1wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889389; c=relaxed/simple;
	bh=D5Ia8muRiaPpQ8e+jgPg6Xe7yzcNblDs9TSsBY3XZEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VRYurYXKkKItNH1N/gHmtzS3NYh5K/06ayX2N+cRNXcSGxPgVShWwoqLlF+WXoglO4DYUhV5psOa2khGOav2y36QDR1jC6FBMesJUsssnd2H4V2mWCSQ6nstsE4A+mXMwzQexwchb4Zf5Imqaoj9aQSSX6KvC/g0ntxeGBkV+qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DO5LvU4O; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c2561e8041so4828990a12.2;
        Mon, 09 Sep 2024 06:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725889386; x=1726494186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BKjE0CdLzK8yk1+IP8qL6qC4lR7g2z+JPjfGRhpRJso=;
        b=DO5LvU4OPFySThy8X/baBJjMvVL8N/lhibLg+1lXhqElRVA/6PS44iSNLg2Jnu+BI3
         fAWUnI2gIji04W5jqWv3LV1Rc32gj9dv1FGWNEpbZ+E1rzp9elIgwyo0qpGcDbK51GPD
         YER8FWKJUkK4SAaS5BQHj9kd1iE7LbyrArHPAi+EGgWrsbvoVngfDXRaz411d74HoHk9
         qRl2FwtUSXVsGcYZiT+wEU2HGEakMZSipxYfjxEgnNENzKYeIMN4IigNelGwoKmIMah+
         G7T+LGeSsh3wKPhkksGotz6ei/ySmEMTV5onqolkyPPO4YWWwgs0Ee864IHmZkvr4ZpW
         6T0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725889386; x=1726494186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKjE0CdLzK8yk1+IP8qL6qC4lR7g2z+JPjfGRhpRJso=;
        b=Kn8OLvpScRQM6bfrMVdmvzDxfcOP19Z9Sr7Xe6w2GA66f3zOLqm24BiDlvfCLUqHqc
         AlGklhEFTsPeB2ID+zgBkHcrMM+wE2cTJieUib8YPriwqFdfwWuESUkGU0wLgY9F/XvU
         t2feSOcQd8EJ8ykm6iWRa6iPoAl2b7zU31X6yTe42G1g6TzNM0lbkbdbLERuRxAH/dHM
         iTcNktb7r4zJMrGmKwGwYFeEd1ZxtNkUs9e/ybB10XY3LJIOA6lJOZNkfIYkGEZUsnNS
         AcSy0VYVh1ZsFH/sP9+v0ZQonr5QKTiKu1vSgiZXG1Aa/K85B4vTLT6smoR4EOvYtW1q
         msOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoe2BEA/4y4KJIMeizMyIt4O5NxPwGZXhxlD7MuZ0sv6Z5NVetsJrNlBvA837JF2xjDD6L3Cg2@vger.kernel.org, AJvYcCXarzv7+WnJYVH7SaDWfJINteHoHAWjwmPM+nyfSO6cquqbtdyAMCTAbNa8NnAzVYhUWmSRj8KsP+K0RUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS82lIMpuv/1jUu5el7Bv8DOP97ADOslCQbbCsKb7uq5kahP45
	OsccyWXmw50Onm2KxWNFaawrX1mpKJnRObffClFN4pP1Kpp36apZ
X-Google-Smtp-Source: AGHT+IGMdpPGcLri5B1KmNQ+zRZv5O3O0cmkAAzb+3/olAW9Q5c67MUoyUWN/NQf77L7kddEDuuASg==
X-Received: by 2002:a17:907:970c:b0:a8c:d6a3:d02e with SMTP id a640c23a62f3a-a8cd6a3d364mr687143866b.63.1725889385520;
        Mon, 09 Sep 2024 06:43:05 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25833c90sm344333166b.25.2024.09.09.06.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:43:05 -0700 (PDT)
From: vtpieter@gmail.com
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Pieter Van Trappen <pieter.van.trappen@cern.ch>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/1] net: dsa: microchip: update tag_ksz masks for KSZ9477 family
Date: Mon,  9 Sep 2024 15:42:59 +0200
Message-ID: <20240909134301.75448-1-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

Remove magic number 7 by introducing a GENMASK macro instead.
Remove magic number 0x80 by using the BIT macro instead.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
 net/dsa/tag_ksz.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
index 1f46de394f2e..281bbac5539d 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -178,8 +178,9 @@ MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_KSZ8795, KSZ8795_NAME);
 
 #define KSZ9477_INGRESS_TAG_LEN		2
 #define KSZ9477_PTP_TAG_LEN		4
-#define KSZ9477_PTP_TAG_INDICATION	0x80
+#define KSZ9477_PTP_TAG_INDICATION	BIT(7)
 
+#define KSZ9477_TAIL_TAG_EG_PORT_M	GENMASK(2, 0)
 #define KSZ9477_TAIL_TAG_PRIO		GENMASK(8, 7)
 #define KSZ9477_TAIL_TAG_OVERRIDE	BIT(9)
 #define KSZ9477_TAIL_TAG_LOOKUP		BIT(10)
@@ -312,7 +313,7 @@ static struct sk_buff *ksz9477_rcv(struct sk_buff *skb, struct net_device *dev)
 {
 	/* Tag decoding */
 	u8 *tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
-	unsigned int port = tag[0] & 7;
+	unsigned int port = tag[0] & KSZ9477_TAIL_TAG_EG_PORT_M;
 	unsigned int len = KSZ_EGRESS_TAG_LEN;
 
 	/* Extra 4-bytes PTP timestamp */

base-commit: 52fc70a32573707f70d6b1b5c5fe85cc91457393
-- 
2.43.0


