Return-Path: <netdev+bounces-194211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7825AC7E1A
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 14:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F799E79C2
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 12:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AB9224B0C;
	Thu, 29 May 2025 12:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfcfmGIR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73B92248AB;
	Thu, 29 May 2025 12:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748522653; cv=none; b=f7Fiza4bGuLBC9HT4oT1OLwLU6gMIAnpHouJ8dAU0HqBs1MPTCe7+spYtPAQgAcEjqqIGmgF/4V9FZO6AV0GxpD0ZW1pEoRh7iq51U/2Iwa7R/Lc1izALhKL+VHpLKza+sTgdvwPGVxiPIy5ALxA5Ut80mHdsRJCjZRnbin1+Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748522653; c=relaxed/simple;
	bh=DU0IJ0+/nwSm/K9hGP4DcuS6ep/cTHu1pVRhL43vVBs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=YI+S1HnZPekuMvQoape8p63/LKKNIzZ0S2CJ9tufLvBhKMWTbhN85eXxEU2yxktbhq68PPaSdrEmc9ACJqeSoFcsFNgQaYqJDhaeV864kGla9cVyppAJ6Jc1gKJs9FjrMhuhDLkW7G536WhBNEuqW3/oOp5vp+oV3+XNisam3II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfcfmGIR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-450cf214200so7074665e9.1;
        Thu, 29 May 2025 05:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748522650; x=1749127450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xy9+1WxqxPkcvDSbf/PL1XyrGbcJDd9HZLFKhqLgSaA=;
        b=OfcfmGIRaxkKqM63wYjLsLfLiy464mxreNY/d0yOFqNe9IUqWYsQj1FwQXS8Njtvra
         LYbj7R9tUii4jRFpk2gmKdBqcFtwOWnUXJ9TKFptX8cy00foj5oEE/q3afopEuYvZ1vi
         mGEtEzcDBIbR6l4F4JH7uy5ZOOmdJ9mMDkK4c2RkXSw6OgMMqLEQp3xL5cBwO3GgyUq7
         IDAxEDkyjwpeUIfoSp0RkXmXjinGoAe4EL/ApkP6sjcdLb1l54ob2SFrWBOJ8iq8L8W0
         jfs+rp4bBySElS1nagAETKZlRhrZN+5rMD9N1S+31EO65LK/tHXtV6DPTAPwrl+MLgkH
         e8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748522650; x=1749127450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xy9+1WxqxPkcvDSbf/PL1XyrGbcJDd9HZLFKhqLgSaA=;
        b=QIp/RdDb44BawYm05cqNgBBbc6L4Sc/NBn+e7QnmhXv3l2V1v4ASjgKxvuyP2WkpTY
         YfRwvte9D4xVJBXZ+bKWMxh2z4JxNnmlqwf9exgYzzABh0P3rC58acu6aI0HgSEeEIVd
         rBIVuwAOQpg7UEN7xE20oR2X1FPmfXJJysQAR+UGCK4msYsyBhw5iXltkE3mTFhe4Y02
         04WOglgNqcxpIpnZWPEQdQOcH1/eF5IAXKUh6fQjERYUjhKK77fkY7IUxGzJxlTNMRva
         uQr4JDVc5eEn0f6wEC07+P4oJpXVsK5/EvGoEeCV1vmrDZds+X72Y5Wjiprvj6yTz1ZP
         dZLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt3uOowbVtDj2gQu63t8i7SizPWk8QgD4Gy0MPeLs6tHT9Z8w/nPpb/fl/mcEbo+SXk4lxvSrY@vger.kernel.org, AJvYcCWPJxLD249a6MAf8j3AhkSUL+Tl0U01HNFen/+ho/0aoyTiwv265zlYEi49CMY4PL5ftJLOCiZt/PJ0VXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1MqwaJcM9BbIwRZ8DVkP81IUXv/AfVdQfsG2AJ33cpNs5Njcp
	10e12/Opy000+7LzVuFVZ0kEZrADu9/8fkxuqG85QqJ37XCTOz0xGrh6
X-Gm-Gg: ASbGncv2O30L3mClnxYsJFOvdHsAdKTisJ8SIhq9dNMwvzljvx171FJnFKoyt/8ccVB
	5dSuK4N29uGiq0eUQvsv7FGA+QzxTkbfXEETpA0YoSu+gd1G9nOkDP9UOyeu/6qzzDVq+uvk54l
	GCOG4P+ttU4WBXLLICh6I6td6E4NTpCO4C7rpek/s7NIl2kglnqCR/i+TjO2dniwK8jaYqVRj2z
	Djk58nmvhpZp3lSLCNAQpQuzoU63OdwECHIMZGr22v0I9k8XXdOjd2A0Da+ZOLJTA2IGEBHs74+
	v0loO91Y5B2lRewJISPj6XuO48PhSdk/DSWnuaVjTZCgK3vCqEhreqK4xQL+xltYV0eXeFOPUKF
	9Rk6rKcjCC3CsyAn4DY8QqeQ+d6yNpZwSzWRCeAiIgQ/CJiRMn7/W
X-Google-Smtp-Source: AGHT+IFm45df0BWkQmTyGVJH2ytFPDLC0UF5D4hMKR1QOL/2DurqQM0+1Q3vJcgPQRfZYQwJ3uQOng==
X-Received: by 2002:a05:600c:6216:b0:43c:fa52:7d2d with SMTP id 5b1f17b1804b1-44c955dbdddmr159836115e9.20.1748522649482;
        Thu, 29 May 2025 05:44:09 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1200-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1200::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44fcbe5c4edsm55146915e9.2.2025.05.29.05.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 05:44:08 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: florian.fainelli@broadcom.com,
	jonas.gorski@gmail.com,
	dgcbueu@gmail.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH] net: dsa: tag_brcm: legacy: fix pskb_may_pull length
Date: Thu, 29 May 2025 14:44:06 +0200
Message-Id: <20250529124406.2513779-1-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

BRCM_LEG_PORT_ID was incorrectly used for pskb_may_pull length.
The correct check is BRCM_LEG_TAG_LEN + VLAN_HLEN, or 10 bytes.

Fixes: 964dbf186eaa ("net: dsa: tag_brcm: add support for legacy tags")
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 net/dsa/tag_brcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dsa/tag_brcm.c b/net/dsa/tag_brcm.c
index 8c3c068728e5..fe75821623a4 100644
--- a/net/dsa/tag_brcm.c
+++ b/net/dsa/tag_brcm.c
@@ -257,7 +257,7 @@ static struct sk_buff *brcm_leg_tag_rcv(struct sk_buff *skb,
 	int source_port;
 	u8 *brcm_tag;
 
-	if (unlikely(!pskb_may_pull(skb, BRCM_LEG_PORT_ID)))
+	if (unlikely(!pskb_may_pull(skb, BRCM_LEG_TAG_LEN + VLAN_HLEN)))
 		return NULL;
 
 	brcm_tag = dsa_etype_header_pos_rx(skb);
-- 
2.39.5


