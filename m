Return-Path: <netdev+bounces-239842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA52C6CFF1
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 07:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 4A4462A2E0
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 06:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AD731ED7D;
	Wed, 19 Nov 2025 06:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAsZBcWo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABCB31D759
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 06:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763535347; cv=none; b=gvfCP6Td++2AydkiLEHFUF1dEuALYyqny7e57tbrnTB3bls0qZONQQK1ZLIPfjOLCyVcJACUpMfgMMkEhvkfWYdEqtu2Si0WJfvaxdO1LXTaFw3GjUS2fMVrYCFyu+U5Yl6ioVsbjb9Go2zImpdxnJJqfkHr2/itp7O7l2ls1AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763535347; c=relaxed/simple;
	bh=yr6yjv0EBbCNY70Ku36IhUNwy3lQGNjfSn1Zkto+qpk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=AvJg+3QmurraaVejeyJKf4F8xfLHMKJdjgea12Szwupt2Tzy53uaBMpvGyFj6Q1ZmygpjYcCA4MwbBp+soAu/pNqb+oRQ+Fb9MmOURpN38LVVLezB2yh0v7XTbAZRI2KX2qiRlF0+sisQjo4WTxoNTagk27oH+KmqMEdikG3DYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAsZBcWo; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso31363955e9.3
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 22:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763535344; x=1764140144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBmf9QCMcJAhKCOHn6MhKnTj4luluPsp0aB4Bdv9hx4=;
        b=dAsZBcWomNXB6uQgSmgmJ7E3Hy45JaOpk9mtuY86Pe86qVdiPqctaFdIwqZ5BiKQI2
         aqF5nJjs5uX+bfvIvhsaxejY0V96Lx+lZqUmbfXMSCFXayNkKqlMk9SF+XtRLQ6IIlQb
         MVx/X3nHua4P3QqrNizzh3amIf0xi0c4I+OiSUK94pKbwCTz1lTAnoqhVr1gcr3oj5nE
         u68NkMDR3P/h5OFor4ewq09mUu81P4iFlJbyVLffGzyFRXXXcMZAhrUyS1TNmqdZjHRB
         3Hsq7qMqj4Jde/opfmPm0i5QuIPcjfZZ2Y0H7CzntXtSzJqHdChBEwLmLOBLRk8kZYvC
         pgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763535344; x=1764140144;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VBmf9QCMcJAhKCOHn6MhKnTj4luluPsp0aB4Bdv9hx4=;
        b=wmnLyBPQjhm28tKpBqsoFQR2lDT4nw2MBVZXQ3DiGjPyXy+8XF1KzDPwSne7ssznnX
         QJuQtbzxtewIadkmxJMG1KtEy0txZ09+6DFgmewR3UxZy6fB53AG4AsNu4DUnMHOf5Vk
         0qmztvNtvlL6z15bo5PGx4hqAdjJgGVSWShFyxPR1x7n5aAjY02CHmanfhsLbDj+XALs
         81M3wyaKwb7lFO4e7D778anuvSp0ValVYk0REgRsphDkcPJC97IxVjb2lOEfDmOvFFl3
         CBTHFrBVG9yqA6TBx3Zzo8NjoX6NjL3gJcgT4q7NEqAvJ3e17lm12n8OY15MNGwjqSuO
         w6hg==
X-Gm-Message-State: AOJu0YzKuZ/suGeqCobEodFLWm0bM2mss/kHdnvsVsEvu0narjrBM+N3
	i3Z6WDcug5wn4N1YlYdygdd5O4g9Kp4iFNX11wKjzs4nexk9I0kkJGtX
X-Gm-Gg: ASbGnctzuhuqp/56DwlNpT3UctGtQPLYUwkg4hGKrrvsAdyJpUVz2IZoKXTSBR/Yd8y
	LiY4RtTGVkJxQ+9hrxmqfQm9e/WEPB+n0sgD3wxHZDCrkmdfRb7mWrD+WE1HNE2BINhNmPpebTn
	e8xDFJ/Vq1GIOergMTyWFCd10OelPwGOOeBW8fps7ppTZdHqdQG/MfYuNppjIRljjxTcenkRdxb
	mpXY4eWf0A01vFvkjBOeaH0QuZfBUrmGt9y+EA5g1GdeEFSV2RjSKdg23ZZpxBuxLFLcF91Mq8X
	K73+UQOJ8NpRKFWZ6BGThOAtc4aOgpJQy1gXGO5oVa+nQqYK+DRRBAdIA2ozWXodIMDhM96OmR0
	Hz1brcU6fT+720d/yryQ+3tE+kuebqpIYB1wgtcACaT+Rl3d9btstOlu+5opc5P1VDZwX4mZc+d
	IRnzTPXm2wi8df74/mMTuxBdrTbDuWC4jYUJa6yuo1m4NfhJQysaDQGmTW/sHJG8FFA6HwackLn
	0tXzDfrDyL0u+4FFyRQvNB5VsR/gE8YOIaNv93pWFqdZ2dBbAhKnBR+hTq4Ag==
X-Google-Smtp-Source: AGHT+IFY46zQxvGstHdhnoJ9KUtRpatyDt5whGXq/ztnFb7mLVCAJouqwtKSWMQnxujG6G+Hj+TXDg==
X-Received: by 2002:a05:600c:c4a3:b0:471:131f:85b7 with SMTP id 5b1f17b1804b1-4778fe5e7cdmr180943615e9.15.1763535343694;
        Tue, 18 Nov 2025 22:55:43 -0800 (PST)
Received: from ?IPV6:2003:ea:8f29:4200:d0a:45b2:7909:84c4? (p200300ea8f2942000d0a45b2790984c4.dip0.t-ipconnect.de. [2003:ea:8f29:4200:d0a:45b2:7909:84c4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b0ffef34sm31319835e9.2.2025.11.18.22.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 22:55:43 -0800 (PST)
Message-ID: <bc666a53-5469-4e9c-85a1-dd285aadfe4f@gmail.com>
Date: Wed, 19 Nov 2025 07:55:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: fixed_phy: remove not needed
 initialization of phy_device members
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

All these members are populated by the phylib state machine once the
PHY has been started, based on the fixed autoneg results.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/fixed_phy.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index 1ad77f542..cb548740f 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -172,13 +172,6 @@ struct phy_device *fixed_phy_register(const struct fixed_phy_status *status,
 		return ERR_PTR(-EINVAL);
 	}
 
-	/* propagate the fixed link values to struct phy_device */
-	phy->link = 1;
-	phy->speed = status->speed;
-	phy->duplex = status->duplex;
-	phy->pause = status->pause;
-	phy->asym_pause = status->asym_pause;
-
 	of_node_get(np);
 	phy->mdio.dev.of_node = np;
 	phy->is_pseudo_fixed_link = true;
-- 
2.52.0


