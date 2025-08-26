Return-Path: <netdev+bounces-217053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7F2B37303
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 21:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 809601BA5AD7
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 19:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8A8352076;
	Tue, 26 Aug 2025 19:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBqOeCZ3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6480030E83B
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 19:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756236285; cv=none; b=j/jwUcig97PVQTMMS96w+qQS6hhvTW2qnDeSL+cPOU8nD/NAdtdXIEgBf/V9CGlTw3MN3zaMLkskVqCM5D9wzxd5wrcg3Hiymub3LtFkQ4croGdxML4ySliYUpJsIuHKhHeoqqGScx1E2cS8uIxRVomDjCnBGct4XcHFh+XAB78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756236285; c=relaxed/simple;
	bh=jLqgNaHJR6HKTNpYp4jzlBz0iyFjrx8ndmTezSq0jMs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=oBtnVRZc897j2fn/oAjLcg3rokziwbQFUsnAVZ7A8brT5pOa17Jp48t8scVDE+xEO+30QvSUrpNOIvaIMQFy/GoKAgi7yWgyz6+GqgYVur1PjGkMXZHJfCNAD9czTtFIcinIGHAiQ9Pb0l+vSyKuOKjkANRObyxIxFAasIrhRhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBqOeCZ3; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b1258a3d71so67321741cf.2
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 12:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756236283; x=1756841083; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3FkIFzB5P6B8sw4j2rCzPf0SVnf/G8pwjHhJj6GaRk=;
        b=cBqOeCZ3qWL6y675glQ9iOGycWpA6BhB8oWKxiqXEtv1sxoOZtCGQM3ZEW8Eq/mwXM
         Yre794DUt5ojFXyEqmUjeL1f9/L4EaRyBlW4W3FJbXoC1fi60nskk4b1cNTz5TO90kqd
         wvzk8H6TzmF4UuejuFo7vRcLbkdQZTBt6ViK6EuxVy764qPst8PZNtkFaZTTSDm/OIcf
         Aj02gLHpftY3qLWK+seD/rpdc4JLWMCNEeRweEy+z3iuQHmrX8rNusB0/YxNK+vbuDE0
         PNuSzzIzTIXlKmWn8vkDgcIJJY1o0SJGp6GCB0BZV8FmXXwI2au3dHnunr8kIe3NYUFx
         6GPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756236283; x=1756841083;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E3FkIFzB5P6B8sw4j2rCzPf0SVnf/G8pwjHhJj6GaRk=;
        b=hRS6PfoI04/3ejLcdb5yBX4oKJVRCk0sJ0EZmR1vY7OTNrDdi3b2AfudOnFUti+5oG
         AtZCdmGX56Z4A8ZqUk66MsBWWyYXREIsIvk72ygnAM5pPtlTkCPlmRTruT1Z/XzPAVZJ
         UZpoZKHT25wY8/K2GzCxlRK1OQA6BbKDY6mjJbruk8rRTKnAzbGBSSRXgPsosStxDwac
         XLaWtrn7picU+MW5OgjvEDXSv80bFwPQ0fEt6nAAVNPAPykGzIspMOM4QO71ha31Zm5L
         A7HcnVlTx+9iAcRQoyg8TOUMpCtTte4QYbU/Cii7jJydDrLZ2CY4Jaqk62taDsEhacWE
         Pi+w==
X-Gm-Message-State: AOJu0YyR4/20gL7CFGyQj5g6OA0xflreOShlg5KqGeYPE7h4Tey+vSqW
	G5M4yQeRw742VVUhDZZXwszENNPdBEmPdUaD9khRxNoGlYfxsPnVllNZjn99Gg==
X-Gm-Gg: ASbGncusPi+ny7dKF4zk1hiJw8CvEhp+vREkYAdhQ7yN5y+azw0q62vOdsKdu63lXyT
	V8bjyjS8SOSchq6UbGQn+/h+jznxH9gapu6hSq/1iSyl+GAI3lQhJLz6xG41EcLIRSyp79ibqub
	scMa1cEcJIEAaGFpYKtVntQaFMN7qchgrq8qr8PBrbxxF0EAfj+4ptbQdlgO04zX8vF3B4FyJBd
	obFv/1tF3N3PcfudxnaZ38qtu8GRzHi6QcTLGGBNEhhc4Tz1CDn9pML0QzJ7dAjJkXPZyic2Pnr
	SKtov9FKLK9rij0E5mC3HeKYxzDZGlKW9EaDvlvnHdttUQ5Bi1y+dWWp13vn0+nBV2j5EeGj9RL
	tUe9sNQm1yLihDnlQs3+ZUcOnWbkj8JDOPhIP90kd177/pGVDgBV+eLZQiLdgECwAptMn/ABUKL
	fATQMBdTMWwQvKiYtbdkPeB5R6hiZoIkB7+hl7Xz/ZdORpRc6lVxo7dAu1JEO3Cg==
X-Google-Smtp-Source: AGHT+IHN20eZr5jkiz0s7O8Z47uKR+0tgIQ3VBubUbxb14RMgr7iTwVzfw/a3ph9O8OcRNyKWRfVWw==
X-Received: by 2002:a05:622a:11c8:b0:4b2:8ac5:27c0 with SMTP id d75a77b69052e-4b2aab513cdmr186829571cf.75.1756236283045;
        Tue, 26 Aug 2025 12:24:43 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f41:5a00:184d:5ae9:a5c3:6bfe? (p200300ea8f415a00184d5ae9a5c36bfe.dip0.t-ipconnect.de. [2003:ea:8f41:5a00:184d:5ae9:a5c3:6bfe])
        by smtp.googlemail.com with ESMTPSA id d75a77b69052e-4b2b8e493b1sm78106511cf.48.2025.08.26.12.24.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 12:24:42 -0700 (PDT)
Message-ID: <c49195c7-a3a1-485c-baed-9b33740752de@gmail.com>
Date: Tue, 26 Aug 2025 21:24:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: fixed_phy: simplify fixed_mdio_read
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

swphy_read_reg() doesn't change the passed struct fixed_phy_status,
so we can pass &fp->status directly.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/fixed_phy.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index 616dff089..7015c763a 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -75,8 +75,6 @@ static int fixed_mdio_read(struct mii_bus *bus, int phy_addr, int reg_num)
 
 	list_for_each_entry(fp, &fmb->phys, node) {
 		if (fp->addr == phy_addr) {
-			struct fixed_phy_status state;
-
 			fp->status.link = !fp->no_carrier;
 
 			/* Issue callback if user registered it. */
@@ -86,9 +84,8 @@ static int fixed_mdio_read(struct mii_bus *bus, int phy_addr, int reg_num)
 
 			/* Check the GPIO for change in status */
 			fixed_phy_update(fp);
-			state = fp->status;
 
-			return swphy_read_reg(reg_num, &state);
+			return swphy_read_reg(reg_num, &fp->status);
 		}
 	}
 
-- 
2.51.0


