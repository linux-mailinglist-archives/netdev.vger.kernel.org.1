Return-Path: <netdev+bounces-144227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E33B49C6524
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 00:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E79A0B27A54
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 20:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39A0219E2F;
	Tue, 12 Nov 2024 20:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKtt/Pdn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6801FA829
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 20:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731443793; cv=none; b=JGOEePLYqGFlg+X7n4tHaMv5ThkrDzFG4gGtpBqil+IxXw7TPJiGebMmAhsaZ7WxiD2Yk/M4zvtajsdkmXSQUnkWogwBHuM5PamQdfDdKSX1RMuhDcEzGlfyl/tla6qkGFTcwGpv7CZQnzInEH2r47ZTw77IlX+VqL+p2EOwmbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731443793; c=relaxed/simple;
	bh=zXrgHqa7VLgCYetFx5Ck+ugqghnkpEVZ+uN1yggSX7o=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=XMvv/MwBFerixBejG+4v7sc9XO8JRILPJrhJeNd5zFJowMt13/vCXzRdz5szw3YEuUuZa1kb6a24mPU0q3sHnpGuh7U/6cAWRvAz2H/qKxZzkQxluM9kzFVin0BsURfK2lxKs9BntKZczqW8lcSPpMUZOeAHXmWKbHVRzi8OWi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKtt/Pdn; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa1e51ce601so168663066b.3
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 12:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731443790; x=1732048590; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXMFL0ocit/sNIjdZMtsck+gfqPwSFYFRDT8UMIxpNM=;
        b=DKtt/Pdnwm8R+LsQW3dfGdIDSpBPPb6uziBMdIH99pjnTJuCL0VH2NGCGQffIMWpRy
         EKYFwHY+ULwCU2zHSPFYfg51Wn3r2C9qZbLcK+fSSYvE6DWAvV4KwuiTrZ23k7+5/yer
         7bEusuk9Qz5A6O/CrFFs8UyTBQVq8JoyIo6roS55DPvBQxIqZ4ekj/V3l9tmJK1LIq+z
         3k9gnidULdrEyEW/+MHWBikwohfnGFymrbvwdmEh7le0gZ1CrkrQ/z7FbtdZWvKwRcoa
         UygI4z4Pa3bk4bVnFRmWfl5VnvC26STelcSmREZZunbqxEXOSvNgahgjKVTeAW4yxOOi
         Mevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731443790; x=1732048590;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fXMFL0ocit/sNIjdZMtsck+gfqPwSFYFRDT8UMIxpNM=;
        b=eB/6ISu607q2rS3C7uOqj2ecYJcFzq6CRry+kanYFprmYmnONbLIQsBswM51qh+9fh
         o/3gyoRfdzG4kPncCUh4oe9qbXe/jzFjaTnvRmvP7WG2GhoQdhF5NSuKC5eLylHqOTc3
         JTl4yMTUn/JszKU5IWvp/Dn6BDhrP6rd6JUmhPYkszaY7eqApqd/UtC5AQ7WEBhodvo+
         yOle7wFsgkhg6PqKqUUMuRyOQKBMJhTbaDn3/MI/eHWxyo8m74Lgj0vhulgk04eqSTC/
         uD6C3E4sBigMiKIlT1J14D8t2az47qJOC7hmgAlqXO87RujOPansFM/AjxconuHQkywf
         FgIw==
X-Gm-Message-State: AOJu0Yzw8wbsoYIKMppljpWBUtgIToFpFtbhWXSHJe3zvv1OyEWOkZBu
	8pycM3wWCDMnNlET41b4Y/Hzsxrp5GjmU0BeBI0SZLK2/zt4h7of
X-Google-Smtp-Source: AGHT+IEjLQOYUOLH2vZJ5smbuN7qUof5045QCCuyXYFGB0U3ovzqxis4bXyLHN0o3FpWPGZRxddeuw==
X-Received: by 2002:a17:907:3f8a:b0:a9e:c954:6afb with SMTP id a640c23a62f3a-a9ef0018b25mr1814242866b.51.1731443790092;
        Tue, 12 Nov 2024 12:36:30 -0800 (PST)
Received: from ?IPV6:2a02:3100:a46e:ea00:edd9:afd4:7c83:6d14? (dynamic-2a02-3100-a46e-ea00-edd9-afd4-7c83-6d14.310.pool.telefonica.de. [2a02:3100:a46e:ea00:edd9:afd4:7c83:6d14])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9ee0a4a452sm762123066b.51.2024.11.12.12.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 12:36:28 -0800 (PST)
Message-ID: <f9a4623b-b94c-466c-8733-62057c6d9a17@gmail.com>
Date: Tue, 12 Nov 2024 21:36:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: simplify eeecfg_mac_can_tx_lpi
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Simplify the function.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/net/eee.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/net/eee.h b/include/net/eee.h
index 84837aba3..cfab1b8bc 100644
--- a/include/net/eee.h
+++ b/include/net/eee.h
@@ -13,10 +13,7 @@ struct eee_config {
 static inline bool eeecfg_mac_can_tx_lpi(const struct eee_config *eeecfg)
 {
 	/* eee_enabled is the master on/off */
-	if (!eeecfg->eee_enabled || !eeecfg->tx_lpi_enabled)
-		return false;
-
-	return true;
+	return eeecfg->eee_enabled && eeecfg->tx_lpi_enabled;
 }
 
 static inline void eeecfg_to_eee(struct ethtool_keee *eee,
-- 
2.47.0


