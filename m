Return-Path: <netdev+bounces-241427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D34D7C83CBB
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 02FBF34C0B8
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 07:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20C02DA75B;
	Tue, 25 Nov 2025 07:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJao6vVl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D9A2D8DA9
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057130; cv=none; b=a/3qBTHVVJ/i2mwc06EHTy+9YD7upSpRVtml9hUXzTeAPL/w0qqQ7THnYgalGW15iEP3B6WlEgnx2nBHrKaxzgcDMbAVqnHo0tCY6Uxi3tgx41JJ+mm93Ou2ZHApCPuKUvt+ofCFw8vD1UKfbi4uOkV2dGy1oK0tR9yE7rZBS7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057130; c=relaxed/simple;
	bh=YL8r10q6Cyoc+80jCsccVrd5bdJg66KLlzZhzSjGjiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r6lk4slMLYwn2S6HmPjvmOvwR+KQJDO+bliuKnxwHRwjk5AU45tEtc2czos/cl9yvZwn2AJK+9dTlmteBEx7f3zUfZDKUeSgVO5lQd5rsbRzSpDDrROkr2bCufn5wvIScpWbVg9zroaAfoIP0eWjUKkyCQ+XPFyNwa49iRtqLhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJao6vVl; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7697e8b01aso444465366b.2
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 23:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764057127; x=1764661927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKCxHvyy7SHsk3XOq3AZ73QPflDy850m7NcWBvFdtb8=;
        b=UJao6vVlaBfNWZNGAQBO6PmNveyhvTyf1Y+qCXjuR2aAz5mP7OZTlsqHaaVYWPfWz9
         d0b6hreWSzUDeCT/YzcnJJalKAiVK1z1C25HjEZ2JTPhkm0agwLuUL+nCHWKJQezJ9BE
         ZZkn0D+BjoJe5DcXvwsB3Eo2I6ygaGysnO7dJa7+0sSqlvEKfmqGOwVV+Ye8p5tT+P0K
         8Z/dKM6DoO7uAzV3E+sOnSetpN7CdizcbR8Y8Tml+RzLz8LGGxwMkxHIwsHqqYMo4768
         YmAON2VXcgf2rBIJbVokOt2PJwb+8J+7fH6ULc4/6qMQE4dL94tMyvUf72w9UbOWFLjx
         PfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764057127; x=1764661927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IKCxHvyy7SHsk3XOq3AZ73QPflDy850m7NcWBvFdtb8=;
        b=lSnkKuU7y8jMZyoTKjoYR153guqxqQRWWRA+f5oduFfVYfRyHhBt30Dak/vmFB5gv9
         yIcFSVb+olVPk0eenRTWPWei6uVj9hBuo9KiCXGmGD9ASrIv4cB2HIvvu6CSAMFtw7/e
         +LGNN9sti0z+6/8O1SE/byj54eK4eSqwM8dgxx57HDuhOeS189zKPMs9KwF8ddWetkfP
         3WzpTk+NljwX5e3c+xvce0uaBuVEhW6mHD4KS7aKcvw20/JBP/r1uEuIW4As0/iL5HLd
         daNQTgjKmyeXCJg2Z2eetXHa1yCiAxXUMn500GvmgcPR+H2hxDmqgcHbWgrM1ijgAcPr
         xCPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL+lMrIoMfZxEMNsh/zQ8JmzsiBg7jzRo/gz1HH3xR31V7f0E95+zq5Wcp4B/N5QTfhh9i4n8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfgiKC9bfgD0aeLbQESG8DAzqu+57VxxN2Q73GwV8icTy+OCRl
	4EGOC8aUXkL+7kDBOOWItBv49/IJQ0nBarg+kazmU7KPGOnS6bzhldPL
X-Gm-Gg: ASbGncuff1RgIydR98R46VmYXXSJAiR0SQMRmV5FUE+6QSKrXVurrT4Gr+98J9qQKkp
	v4JBzFY0YfOfL2Fni2nrfeoGx72AiSmHmaIhn6jSGY2v+flT/Il0Kr7/k0er1p43BApwkCXGspp
	rIPUUaLpEUJ6p4p9INmBVMdKFBy7d+txYIcoFm+kBrNKxasVhjFPFVg5NMXrFCYAN5jftXknrQd
	zQgafkIBjcafSKdjip+ZkumimNCr2Rv0Ig9xKPijA1tw3nUZuMzsx4+0VEKUBG8P4GPAcPg/rE5
	LS7qNLreMjt31uydiuaiMVCgEsBrs0Wh6lLi3DoxWYUKjzUkQMr9mRDxhKtAWaeylR82ge+6csd
	MsmtcbPgYXHL9jXmwBzVkoj0dHzd3ELtoi5uhdKL+JfAm4zVpMkRn7ICAfNgYNMXu+NDmtEeCEN
	VkqKrZZQ52kky9IPXbIz2w46CYCSOb6QUZPMqxexfWsWBThw9TMXV1sVwv006k5TJGyy0=
X-Google-Smtp-Source: AGHT+IHc7ADn75HdWsysif3utKXdEjd/ikCNbfsIT1GW6gycIU+WxFJFvgTMUyuNO4Vv8P4JsntrpQ==
X-Received: by 2002:a17:907:1b28:b0:b73:6f8c:612b with SMTP id a640c23a62f3a-b76715653d5mr1537608366b.16.1764057126640;
        Mon, 24 Nov 2025 23:52:06 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d55d7fsm1512575466b.21.2025.11.24.23.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 23:52:06 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/7] net: dsa: b53: fix CPU port unicast ARL entries for BCM5325/65
Date: Tue, 25 Nov 2025 08:51:47 +0100
Message-ID: <20251125075150.13879-5-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125075150.13879-1-jonas.gorski@gmail.com>
References: <20251125075150.13879-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On BCM5325 and BCM5365, unicast ARL entries use 8 as the value for the
CPU port, so we need to translate it to/from 5 as used for the CPU port
at most other places.

Fixes: c45655386e53 ("net: dsa: b53: add support for FDB operations on 5325/5365")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_priv.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index 3b22e817fb28..bd821d60ac90 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -344,12 +344,14 @@ static inline void b53_arl_to_entry_25(struct b53_arl_entry *ent,
 				       u64 mac_vid)
 {
 	memset(ent, 0, sizeof(*ent));
-	ent->port = (mac_vid >> ARLTBL_DATA_PORT_ID_S_25) &
-		     ARLTBL_DATA_PORT_ID_MASK_25;
 	ent->is_valid = !!(mac_vid & ARLTBL_VALID_25);
 	ent->is_age = !!(mac_vid & ARLTBL_AGE_25);
 	ent->is_static = !!(mac_vid & ARLTBL_STATIC_25);
 	u64_to_ether_addr(mac_vid, ent->mac);
+	ent->port = (mac_vid >> ARLTBL_DATA_PORT_ID_S_25) &
+		     ARLTBL_DATA_PORT_ID_MASK_25;
+	if (!is_multicast_ether_addr(ent->mac) && ent->port == B53_CPU_PORT)
+		ent->port = B53_CPU_PORT_25;
 	ent->vid = (mac_vid >> ARLTBL_VID_S_65) & ARLTBL_VID_MASK_25;
 }
 
@@ -383,8 +385,11 @@ static inline void b53_arl_from_entry_25(u64 *mac_vid,
 					 const struct b53_arl_entry *ent)
 {
 	*mac_vid = ether_addr_to_u64(ent->mac);
-	*mac_vid |= (u64)(ent->port & ARLTBL_DATA_PORT_ID_MASK_25) <<
-			  ARLTBL_DATA_PORT_ID_S_25;
+	if (!is_multicast_ether_addr(ent->mac) && ent->port == B53_CPU_PORT_25)
+		*mac_vid |= (u64)B53_CPU_PORT << ARLTBL_DATA_PORT_ID_S_25;
+	else
+		*mac_vid |= (u64)(ent->port & ARLTBL_DATA_PORT_ID_MASK_25) <<
+				  ARLTBL_DATA_PORT_ID_S_25;
 	*mac_vid |= (u64)(ent->vid & ARLTBL_VID_MASK_25) <<
 			  ARLTBL_VID_S_65;
 	if (ent->is_valid)
-- 
2.43.0


