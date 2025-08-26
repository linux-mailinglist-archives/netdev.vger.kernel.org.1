Return-Path: <netdev+bounces-217050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B66CB372DE
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 21:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 041686811D7
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 19:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C697C350830;
	Tue, 26 Aug 2025 19:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxtd5+Rx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FBE86342
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 19:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756235463; cv=none; b=SNIoign5e+V+C8p8vCAmOIybjzUH5MWHxlEVla7+3TN2UAVRsuDDB/t1Z9hlYGCAhZnjDtJZUkyOhUmVKbjL+IRU9ed4gRuzn+GvTZY3A4HCwpT7GUwT/0qaH6Z03AeJL6l5ixqwoUgV8QKgTRgziWUpdj3508qOMe8LJ3AnJ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756235463; c=relaxed/simple;
	bh=sIZHrRFgtqI3ZFu9ugsMXaIW5AwL7Vjyf7e0Q4tU4lA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=ApN4IHWkFGYQUOXR6+F2YwuxTHyZ1pmIgzFzV9OXkRUjN/46Xq+gXUcXzgn30lYCrdRlYzliCmr3zDgjlwtXRdpyafKCNyd3qEbfpZKrPlhTaHQ79zgX8nDRIXBLh7I0YI3OwEPrE7NZJPs8iLtS/oybQOQVq0ZDUGYU+Dz7lIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxtd5+Rx; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3cc3600e5d1so534112f8f.2
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 12:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756235459; x=1756840259; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K5DMZhgNB4UW/mpUF3ge6ELDbKgycookEAypIzRwROk=;
        b=mxtd5+Rx4ArccBYRU+MEoDjfpOBfxzjIstJK9iUj72fGoPIZ9wcbKPQaTdNH41wr/A
         cUHZZE1UO+sSzAE3fl8EeByNZP5Kr1UECrutPH5IL2+9Ace3jmCmV3jRztNeZVWOXFc3
         r6bbPFHw510J5oQ9ve5tS8Ef1AtiFZ98vgG93dzOFq/0OS4085IEXtD7e1guXahQfAFi
         2y37PjcWCcxt01IhZFrcrYJ+d1jBc0ZIyeB20/pIm2tttUJ3+pnHYpiYgnaFUO5NUJR/
         FRDsXF+Ozps33qGn8HvG3h0C7J2O8nm0cigOfCG6TKPTwVED1iCWfQ1FNN6hf6uKWwSG
         Sxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756235459; x=1756840259;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K5DMZhgNB4UW/mpUF3ge6ELDbKgycookEAypIzRwROk=;
        b=CTAiD4G4pFQCRf8lcnlLL9p9GZuxsZsRhYFncscHE3qIc2BW2YFZdgza3BA5Ek8Sxp
         gVdUO2nFXqicM1emY/frPjxUEAxK6+ZwVz1W1nTRHgazMgpAbxAYEeGHWXPv5VPvA7Uk
         z8sm2GUDfZLZVYe1+hr98kJM6zUtPLXr1dwUu7bhrpgFmVzRCvQ7PkyeI5t6xOykawiK
         mtcBJsFEkDzaNouo3ehcxOBq4za/rCwbOlDy1Va/ElgIeO3HLW6L+4lX8+mP50kjn8o3
         POPweJd24w69L4VAZjWIvSbxFWjUsyfpkXdj/hCqgpSNVpuF6UvH5+TH5rAT7ytDoBzv
         f67A==
X-Gm-Message-State: AOJu0YwLz56pUXQLRosNMt4GhiDf2wVKMV660xibu5UsYw9pYN45lq/y
	AJdRxUzwR5JyTxSVt+oTwGga7kE2ZHGhjwKLj4PfX4/lvn9Q4JNxLAAQ
X-Gm-Gg: ASbGnctgVzN5E/FaJ2+JIOzX7VTfQTo7V0LuJTVK4e+AhWMD2peafeklBJU42P+pTQJ
	b1eYXFYRr+NKGTTSbmKiG2TWNpOJj9V35kUV5uUz6aUwke9fW0f6+MlbAN9VvL6cuqGrWILSPoW
	EwoIZehPP1v0llVj8P1IIvyF92QGaHjtSfh0qR1TweZZLLPY8n6dvbIsYfyd17fb1F9XX2ND5qg
	KlG5s6yuudie9fW1fsG0xohmzqDDNNa+VoRtaRqjI0GPiymmSMeBjHyWPh9yYgenBQNsUDlYgIy
	wwsX+4NXCz0eCXnCmpx67vpyRACyS+tdhOnrLNV9cehJLUsoaoW3I+MOqjNlBiHO0kHcuYV0GMA
	mYCmpa0vHyImBJOCu7CI4NGWxnkxzfCoKlAJrQPvoLbjBObMLp8U2qWx9fT9BwIWVFxoKzsKW7I
	jts4z/3N4JPxcFA3wolQbOs1bWGcS4bZIm6OcR6uu06WoGieePtZ3eVcRhPRFl5w==
X-Google-Smtp-Source: AGHT+IEznpYlW19sbIgiLuyUXGHKlz5E2cXEf0Mc/UadgvGSYPkcWiPreqn0zCYceLPO9I8sxi+Zcg==
X-Received: by 2002:a5d:5d08:0:b0:3ca:734a:a346 with SMTP id ffacd0b85a97d-3ca734aaa0dmr6035153f8f.13.1756235459113;
        Tue, 26 Aug 2025 12:10:59 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f41:5a00:184d:5ae9:a5c3:6bfe? (p200300ea8f415a00184d5ae9a5c36bfe.dip0.t-ipconnect.de. [2003:ea:8f41:5a00:184d:5ae9:a5c3:6bfe])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3c7116e1483sm17169522f8f.50.2025.08.26.12.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 12:10:58 -0700 (PDT)
Message-ID: <e4d58e2b-616c-41b9-a3d3-750518dc23bc@gmail.com>
Date: Tue, 26 Aug 2025 21:11:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 net] net: phy: fixed_phy: fix missing calls to gpiod_put in
 fixed_mdio_bus_exit
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Cleanup in fixed_mdio_bus_exit() misses to call gpiod_put().
Easiest fix is to call fixed_phy_del() for each possible phy address.
This may consume a few cpu cycles more, but is much easier to read.

Fixes: a5597008dbc2 ("phy: fixed_phy: Add gpio to determine link up/down.")
Cc: stable@vger.kernel.org
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- rebase for net
---
 drivers/net/phy/fixed_phy.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index 033656d57..a1db96944 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -352,17 +352,13 @@ module_init(fixed_mdio_bus_init);
 static void __exit fixed_mdio_bus_exit(void)
 {
 	struct fixed_mdio_bus *fmb = &platform_fmb;
-	struct fixed_phy *fp, *tmp;
 
 	mdiobus_unregister(fmb->mii_bus);
 	mdiobus_free(fmb->mii_bus);
 	faux_device_destroy(fdev);
 
-	list_for_each_entry_safe(fp, tmp, &fmb->phys, node) {
-		list_del(&fp->node);
-		kfree(fp);
-	}
-	ida_destroy(&phy_fixed_ida);
+	for (int i = 0; i < PHY_MAX_ADDR; i++)
+		fixed_phy_del(i);
 }
 module_exit(fixed_mdio_bus_exit);
 
-- 
2.50.1




