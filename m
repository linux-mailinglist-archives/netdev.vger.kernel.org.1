Return-Path: <netdev+bounces-196698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43699AD5FE7
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 22:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F33771BC2501
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 20:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268702BD01E;
	Wed, 11 Jun 2025 20:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeGtX8gD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4432BE7B4
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749672627; cv=none; b=QWjt1eIN9eEz7bRm2xjxjQ97NLJ5+bjKg36ZCWkNChk0+RLY1A2zil62GV9k3d5NO0jTBIbWzzgaO5W7vCYLQdyei2UNea+vAc5O6NvlDNxNNxSXz6ddVjXNSJCPZBIG5rFPXE4yEKRmNP+eGKpYZk19CLfBggGH0cRVNNg77CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749672627; c=relaxed/simple;
	bh=9572XyqwTssUfYqUB5ewpKpN+KxyX1DoG9gt8+q/V8w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IltJ1GfqN7FEu9rU1AWaM5tihviVo7t6axcpCU5r7KggkkCcOqhg6/Md2IHgpvhGtoM/EyKgUtQrwGJ/uJ+oUKzhwLYajvbvFiFoKYoe8NcYpMtTZ6nsZh1ooCUk8GLbZcq5p9WbGlci6l3blPJTdP2Zr03cWQMhatrE05Kzpzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeGtX8gD; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4530921461aso1495085e9.0
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 13:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749672624; x=1750277424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7vJRVuJ8NxfhzvzzrhES1a72Q+DnoRrsQaXjhWkGzX8=;
        b=SeGtX8gDKQour35KzKEs+Eh/CpgJ+5PogaTx+9W8QBOl80PLdmnzXCTclvhKC0EJUi
         WF6NSN0vmX8r8xvjmDfwUYsLbrs5XGeh1vynr4nNDfTc0E4EJtQEwRSlSJv0fgvxjipN
         3Gw8Rq3SJkJ5agBuWUhOy56PrAy18dWxa15g0P7zTzAMRFjHpWix1rx6dBk2FfltiXC1
         kdoN/JxYW8sD1bE4RATmbfHV+YBHSsZCVvzv+TqP9Zd8DQ6e/LcgalSgzS4Yv1JDtsWp
         2q5OXyXWS+0MPp1g8LF1LwKRzAKoJ5SeDx+O+QR4HfP6RGB88+fBcwKkBE6FwjWxLopg
         HkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749672624; x=1750277424;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7vJRVuJ8NxfhzvzzrhES1a72Q+DnoRrsQaXjhWkGzX8=;
        b=Da0+as4TxxDNkEx/vgJsZMiZfm5JNcJYpiphkzE2hJ4z/TiYxvDtLHnJ4E9OcmMx8R
         QdCepVdPUXEzuyBoowwGkGftE4LCyAXX5NmzpWbiJRaBZBL9NBkkbOx1h3H475LXLRNK
         C+pBG6bvNn2Aa9IjvOWLjgCnw9ZYnBTq33Q8FQ2gbpt0ZgLGz8z09q65wSSgzfMVOy6b
         nipQMeRsxSWnGYi4MaYo0/Gk8S8GmdwmeL9PitaG8FSy/6g7BKK5mdn6MkzRiP/3tEn/
         2Lscr4Ds4sH0N2Kjm/9pjZ5kcH5Jj1ZEFbEBFBBfTvVOZja8NG6XXQudPhw13eCVAmRp
         +1dA==
X-Gm-Message-State: AOJu0Yw942DILSfD5qjqCd1JRd28+41TYO2tscz7xIcHHN81LE0QYlG+
	U5VANxcoB4F8iMZut4qpBAEkH2jkN0EOAp37ej7nOf2U9mjRo0H3t9cu
X-Gm-Gg: ASbGnctmyoyPyBJtmi6TLX+q4JZzUkCMc5TfVIzBfGlRxICWIEDlgrDi/rknZbucXuR
	TD+AR4gC96s7lITrZzwj0x2Mhi2zP43vsP81AT1GSEuPt2lU2A7SfkrqMPMTgBIsvVv4ar9EkAu
	EYPYyF5nTBYGGGyAGOzeqBArTmKUIlMIjNOReN1eT0FxpunuHiJhIPq98BPZgAi1aSXhk8fHvi4
	bcjuC6xGAp69i8lYNL3KHfaufqfENX7smQS9fbXAIql3b0FT/cd9mrLSuZtUTW7qcPSoBOQBrVe
	BinHp3hzv86gygwVadvEc9t/JAg6CEkkyx7z7ibo8P5X6Ov8l+/Y6iGax99UaR9ZiTPVn1mizLW
	NEXqvYXTEd2aiOF/IJTNm8VXnDy3USWU/bQFujXnI9nDnmh/Z3kVzCCe0U3KgL0F1zP57+578oC
	LV9O/jiC0ETRzshtEhZW7UmsMAAr/7/E0l8qrh
X-Google-Smtp-Source: AGHT+IHsX5/HaHbp4d+r6TsgcwaNakaaZ0vf9H6rP99EHzfyUnkfjRoa2EC+c+jZxODArEbZoYF8zQ==
X-Received: by 2002:a05:600c:348f:b0:453:7bd:2e30 with SMTP id 5b1f17b1804b1-4532492a793mr40490135e9.29.1749672623403;
        Wed, 11 Jun 2025 13:10:23 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f1d:5400:69f2:2062:82e9:fc02? (p200300ea8f1d540069f2206282e9fc02.dip0.t-ipconnect.de. [2003:ea:8f1d:5400:69f2:2062:82e9:fc02])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a532461211sm16005288f8f.86.2025.06.11.13.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 13:10:23 -0700 (PDT)
Message-ID: <0afe52d0-6fe6-434a-9881-3979661ff7b0@gmail.com>
Date: Wed, 11 Jun 2025 22:10:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 2/4] net: phy: move definition of struct
 mdio_board_entry to mdio-boardinfo.c
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <6ae7bda0-c093-468a-8ac0-50a2afa73c45@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <6ae7bda0-c093-468a-8ac0-50a2afa73c45@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Struct mdio_board_entry isn't used outside mdio-boardinfo.c, so remove
the definition from the header file.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/mdio-boardinfo.c | 5 +++++
 drivers/net/phy/mdio-boardinfo.h | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/mdio-boardinfo.c b/drivers/net/phy/mdio-boardinfo.c
index 0360c0d08..2b2728b68 100644
--- a/drivers/net/phy/mdio-boardinfo.c
+++ b/drivers/net/phy/mdio-boardinfo.c
@@ -14,6 +14,11 @@
 static LIST_HEAD(mdio_board_list);
 static DEFINE_MUTEX(mdio_board_lock);
 
+struct mdio_board_entry {
+	struct list_head	list;
+	struct mdio_board_info	board_info;
+};
+
 /**
  * mdiobus_setup_mdiodev_from_board_info - create and setup MDIO devices
  * from pre-collected board specific MDIO information
diff --git a/drivers/net/phy/mdio-boardinfo.h b/drivers/net/phy/mdio-boardinfo.h
index 773bb5139..765c64713 100644
--- a/drivers/net/phy/mdio-boardinfo.h
+++ b/drivers/net/phy/mdio-boardinfo.h
@@ -10,11 +10,6 @@
 #include <linux/phy.h>
 #include <linux/mutex.h>
 
-struct mdio_board_entry {
-	struct list_head	list;
-	struct mdio_board_info	board_info;
-};
-
 void mdiobus_setup_mdiodev_from_board_info(struct mii_bus *bus,
 					   int (*cb)
 					   (struct mii_bus *bus,
-- 
2.49.0



