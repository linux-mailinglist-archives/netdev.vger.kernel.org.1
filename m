Return-Path: <netdev+bounces-216657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EB0B34C5C
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 22:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3AAE1A87585
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E81C271475;
	Mon, 25 Aug 2025 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjOA1FXR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8389E23E32E
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756154669; cv=none; b=DyqVYFq1TQEHDYi1tgVdOOSuiq43YBEcnSrJ+dJufaViqcwaxuOurYPgUFhkN2ZLEDcfbcvlj0e71iHzHFFy2c2JNVyjktqq4AV86D+dPH9j04KlEmw2DRajexGru7IIVo3zdqcVESN0T8k/XIUfQ/snt69dr1hzo6+n8PFzymU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756154669; c=relaxed/simple;
	bh=GnxObfWfZltUdDz43wzOic2+HOKk/PahjYxZnTFp4HY=;
	h=Message-ID:Date:MIME-Version:From:Subject:Cc:To:Content-Type; b=sel6VjZker2elxjpQn82yc8/EtY/C2UXJNAazyYBpW5M3VItFFlNOkKh0ACHvBCuOIL2nJCZlc+yaffdMLsj6jaYKHyqaBiT9u3nfQZpos5fAMl4uTrEdnDh0V4DGL+l0WCkicYS4CMdFa0cMbTAROTINZPR7HqWzQ0u/4tXoFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjOA1FXR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b05ac1eso26807145e9.1
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 13:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756154666; x=1756759466; darn=vger.kernel.org;
        h=content-transfer-encoding:to:cc:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsELezScWH1i9p5FLlEDoDNvWNsHnNdlkt7LUk7TzI4=;
        b=HjOA1FXRWiBN/stgpaaG0lzpLSTrXR4sbHxigaJBOz2XvpzjDLyxaCqaD4yP5d59DU
         RzK9aCsHvQx7TA3RX0C7S54DeKOMGUKdmQDQnzSdDB1bEqejH9m8ScUX3pD6+PpeJh1d
         GiuEisUbtzvEAyKY83Pb9fOGvLmS67XU0QPPrsBrg5v2yWGMHpit5H+A7G0P9hOzpIgq
         jkhUvBrEKffubQdjiym7ZwxEqDhgV/ZXQ9a6wP3HWNbIOUGYantywsKKche7mn94ffqe
         ca3Ezd8LTmjKXuSI117DSwkqyG70YnLOM9b1t/+4oDkBzTBPNY+YC9pYFQch02PO9iBk
         ru4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756154666; x=1756759466;
        h=content-transfer-encoding:to:cc:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nsELezScWH1i9p5FLlEDoDNvWNsHnNdlkt7LUk7TzI4=;
        b=eFTXPhlbPEutCFQobwldk9inDHQKhBy03+vtmMScyVgiUGgzLGjnbS3fg50lngh647
         WfD3OuZKSH5qfG4siR9qKPb1zpV35NhPyS5jSFCqN5oieCUn3ZeegfyJG3mwC2tnSJzA
         XiajChTWdfJuCd/QvJaScmxOvQPFeY8wngkjcgSd/ApxmL9SR2Ox+saaQotzJJeiQqWQ
         JlnVZNusXP8cKYM8HSbnq4SsbvuJCAJcPMMAKRMY8Xz5NFgIEoxzmf0LKZL1oHBGQgbM
         AA99RgCJvVeG24682RzbFdCMTNtz3xz0OL2biOe4gdJAQxE27ElPIRTvIrsOtI1EbvtE
         Mp5Q==
X-Gm-Message-State: AOJu0Yz+s9KQcOuOxxVaVMVrA5L6SZcyx+6aDc7NwPyL01K0kEfKTalL
	RvyKUQu/73UUXTsgJxymicT8iktm0dVxQmQ+j8D318Qu0b4xwkjEsOW4
X-Gm-Gg: ASbGncvxQsZ9Y0Kw07p+iaoUek+6MJb3xQ1qKoOmr4SAqVfN5M2R4GqwFBSJDzeBmps
	JxGIrj02IKiGz4gYt94MHZ1SbngbHag9Pxi1wAjgrspDRszqZmlm+QgC5+emvZknxCa34zrDgMa
	TMyrphjmihCZERgvkKJjze5dwMgwPnV9CUR2g+LIRMVYQDTV6SJyVQAx8KQ+ujdKoplFx6C2YbD
	FaPyAZaApgfODoOVt1mI6WxgLVAP0TWatbH7E9ZnRwMrz+mn7xPIFlnnK+6CazkTqsf+b68ug3a
	mPD7T4WTL9hwvJbYr79Kjofb7R8yEr3ox9SgyTDFOLLdgkZrSffGT2pEmfAwprMgnBZ9yqVJZiI
	6vDgrxlEXLL5F+BT2ZGMeiwNXiKMWcDo4MsRLwDCxJzSMoy8xhwwpr2FS6PN5ntBhZjLgxRK6jr
	YdzvjbfhDcqY4gMyOOUtmRHQHpQL4GlNbKJ9zXdYoP8IKMLVQumfMOaX2AAwuQSQ==
X-Google-Smtp-Source: AGHT+IGqMkUOdMxWqpSVxqbbBb9qz0s9p4R8gTvK1/kR95DSU4Y+IZwsNpQq3t6RTwv9KWrLiAMzJg==
X-Received: by 2002:a05:600c:1546:b0:458:c094:8ba5 with SMTP id 5b1f17b1804b1-45b517a0664mr116994865e9.12.1756154665628;
        Mon, 25 Aug 2025 13:44:25 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f3e:d400:ad72:1084:ce31:f393? (p200300ea8f3ed400ad721084ce31f393.dip0.t-ipconnect.de. [2003:ea:8f3e:d400:ad72:1084:ce31:f393])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45b5753503esm121228245e9.1.2025.08.25.13.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 13:44:25 -0700 (PDT)
Message-ID: <3396d654-f32a-40bb-ba3b-9f749e5a29d5@gmail.com>
Date: Mon, 25 Aug 2025 22:44:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net] net: phy: fixed_phy: fix missing calls to gpiod_put in
 fixed_mdio_bus_exit
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Cleanup in fixed_mdio_bus_exit() misses to call gpiod_put().
Easiest fix is to call fixed_phy_del() for each possible phy address.
This may consume a few cpu cycles more, but is much easier to read.

Fixes: a5597008dbc2 ("phy: fixed_phy: Add gpio to determine link up/down.")
Cc: stable@vger.kernel.org
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/fixed_phy.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index f0e8a6c52..616dff089 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -342,16 +342,12 @@ module_init(fixed_mdio_bus_init);
 static void __exit fixed_mdio_bus_exit(void)
 {
 	struct fixed_mdio_bus *fmb = &platform_fmb;
-	struct fixed_phy *fp, *tmp;
 
 	mdiobus_unregister(fmb->mii_bus);
 	mdiobus_free(fmb->mii_bus);
 
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


