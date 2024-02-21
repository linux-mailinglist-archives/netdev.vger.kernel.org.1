Return-Path: <netdev+bounces-73561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F7785D141
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 08:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD22C284556
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 07:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9713A8C0;
	Wed, 21 Feb 2024 07:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrInaJtm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA8A3B198
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708500284; cv=none; b=L58iV4TSGgzJykHprQr7FYkJLXBM2+oLzZKpXO6iIuC4pItYUMK+RUsKPGsZUonT8ixF+zA2xCSEFzm0DiC8G3kVXlTAJu1QET0ci7NHtlPR00s3LkTIBbSOgQfM87h5jlTDEnanhGXt/j2PceGVUetQ8p4hm+fe7JZyfxVtkH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708500284; c=relaxed/simple;
	bh=2rvZ9bK3Wd7Gd3lXuh2W3Q7Fzxt3brmPKr9PmerRb4g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=ieNBwTd9kIP0AyxGTRfluX1AxjSnQI5/HwyDJuBM4jTUp+vhxvhvSauFgSc8P/YP/R+WbbTl38q5e0fsrApbqZ9H8IyvSHq1Lor/s3uXCyCclKtse4A0Qo39brIbHVQsS2HiN/PRrQlSUw3XN07g8mBbo8/b8HEn6eCH5Wu/nF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrInaJtm; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5645960cd56so4362199a12.1
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 23:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708500281; x=1709105081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQ9eHXWlGoNi3j0u65tomHNslV+AV7EcOE9Vuga/t54=;
        b=mrInaJtmrHSf0yUuic7nH/jcA3xaGdAX51t7gF4YZiuw3P07N9X9doWrTet9Jn6aIF
         i76J2/yW/fyIK2tzsEZY4zFHFAk/1s3goJ7wNS997z+J0N+TVB/b9+7XONO/lpBLrRDI
         l/dx3XYukiBJVU232PzDcDQAs9UIxzz4KcAUdRRbDh4TWt2vTFHAPkgT/UkFev5ttkfH
         NdPDlfMI6FaqhrrjpJM4+fBAwBkrTOud51JuMvBmMZdolyAio8gK+RQyMdqJnrRxVuMS
         iiyIUVGVPQuCX5kAuCzP13xF7Nyjsd2/TUfcX8uYJOqqFAUCy4UymPPlZFGGBrJ+sX9q
         OZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708500281; x=1709105081;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lQ9eHXWlGoNi3j0u65tomHNslV+AV7EcOE9Vuga/t54=;
        b=NTS+4BMADyq9RW8piPtHIow1xhetP91WmdsThpUPJiW7rmG8S0ycz5JjVlu1IKSHcF
         hIVs1YY0sDUuknWD/AzlgzQmRB63tE/9miTz5HN1LLrYAgv2EusidjLB7WabFK8LCYzy
         SurxpWyrxkx+Mu580NWkzW6KtReA2tVgaSn6Kcox4OiyodkpkYnsjA4l+rNn0yZp+je4
         L146yl/ajQjTgWjqpadyJwBUwZ8wHD9EJ1HXVrs8ze+1vuxpj9xtd2IbntKbvQV+qAMQ
         9sZl/sJ+jMCYnsh2TZXz9YoFAEvDcCNhjgo8x9MUQ/T4TNAFDGAbmddWhf6WOzWCIDJZ
         aLWA==
X-Gm-Message-State: AOJu0YyfxNYRLgun1BagZH1Gj6I5/0Ng3RgiEYC+9AJvrT/+F2P4IaVk
	uBeMPIEipuiU1ZMTzuPQKQEG/PhHX8eJG2cckNzzjmTimWeM+EYR
X-Google-Smtp-Source: AGHT+IEBlTJsS8y07ZxYl+8Z630SPzLwoWg8P3LeK9dPaYFFHa8QpNrDv0rKNEU/11b2eq3QJIeZUQ==
X-Received: by 2002:a05:6402:34b:b0:564:639e:47bb with SMTP id r11-20020a056402034b00b00564639e47bbmr5750780edw.29.1708500280901;
        Tue, 20 Feb 2024 23:24:40 -0800 (PST)
Received: from ?IPV6:2a01:c22:6e67:5300:c47f:752b:a08c:d53c? (dynamic-2a01-0c22-6e67-5300-c47f-752b-a08c-d53c.c22.pool.telefonica.de. [2a01:c22:6e67:5300:c47f:752b:a08c:d53c])
        by smtp.googlemail.com with ESMTPSA id r16-20020aa7c150000000b0056447b9799bsm3340085edp.27.2024.02.20.23.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 23:24:40 -0800 (PST)
Message-ID: <4806ef46-a162-4782-8c15-17e12ad88de7@gmail.com>
Date: Wed, 21 Feb 2024 08:24:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] ethtool: ignore unused/unreliable fields in set_eee
 op
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This function is used with the set_eee() ethtool operation. Certain
fields of struct ethtool_keee() are relevant only for the get_eee()
operation. In addition, in case of the ioctl interface, we have no
guarantee that userspace sends sane values in struct ethtool_eee.
Therefore explicitly ignore all fields not needed for set_eee().
This protects from drivers trying to use unchecked and unreliable
data, relying on specific userspace behavior.

Note: Such unsafe driver behavior has been found and fixed in the
tg3 driver.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 net/ethtool/ioctl.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 1763e8b69..ff28c113b 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1513,20 +1513,13 @@ static void eee_to_keee(struct ethtool_keee *keee,
 {
 	memset(keee, 0, sizeof(*keee));
 
-	keee->supported_u32 = eee->supported;
 	keee->advertised_u32 = eee->advertised;
-	keee->lp_advertised_u32 = eee->lp_advertised;
-	keee->eee_active = eee->eee_active;
 	keee->eee_enabled = eee->eee_enabled;
 	keee->tx_lpi_enabled = eee->tx_lpi_enabled;
 	keee->tx_lpi_timer = eee->tx_lpi_timer;
 
-	ethtool_convert_legacy_u32_to_link_mode(keee->supported,
-						eee->supported);
 	ethtool_convert_legacy_u32_to_link_mode(keee->advertised,
 						eee->advertised);
-	ethtool_convert_legacy_u32_to_link_mode(keee->lp_advertised,
-						eee->lp_advertised);
 }
 
 static void keee_to_eee(struct ethtool_eee *eee,
-- 
2.43.2

