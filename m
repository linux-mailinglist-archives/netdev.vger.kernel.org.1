Return-Path: <netdev+bounces-86581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C0E89F3C1
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 15:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D631C2684D
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 13:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C35215E818;
	Wed, 10 Apr 2024 13:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwmNAz6v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A2815ADA2
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754692; cv=none; b=KMuRxwITR9rDtoRSBwi4bXpOIR4p/GkiQ0lkTimV04qhyNlD4wQmipTq0C4pKUGeMMhlUjcJWMDfQ/8NIy/y5/H7LB7K3LZ8VJ2t1jbBonqm///8kp/KWYYG2E2MpdwfMh+ChXGNXdfCa9AMqEK9yAzbxObJi4C8AphY3rrAkVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754692; c=relaxed/simple;
	bh=fkUIJh1JpwKLdk9sDu0RJX8IpTChDbAvbcd7YGRLUp0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=qQBjhKL33e4DRVBn2M9Oq2pVsXUY91bVvS8+gYaniFI0JwNceF9QfSQrzcch4YXOosELJ2JzUkmT2E6r2Cb6m+WUQjZhhvL33EB5VlQKzv7uk+tOhzdFgmjG3H6kwUgK28pNiiiSb0xBv3wcx2LbT0paX5xQxeSMNo+YiMHO5bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwmNAz6v; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a4715991c32so907451666b.1
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 06:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712754689; x=1713359489; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXvLtdzI8BHNLZ3gO7tNbyLnAqyIxFdyIOojc+ssGOU=;
        b=jwmNAz6vNT554h4EL/UzGHmMoP7dtb9nUbd0vE4EY184scafc8hpKkd75htMU+QWW8
         whbCOQlLzLwK9FZm7/2t7FnD+Ic/aYUuTHRi2yQDjQo9JXCpQZ62oTWhRtmnIuEbCqbf
         N3nBpn/S5aubZBbOARycPabI47LfrOq0M2IvW8dSw6592V/26oV6wuPnPhTWRSHra/6y
         o35/dayzvFEoAn9EdgAKs9S2J38te9kfydFULkuqrNB8ZikE7iLb3KgyS0ZyVcqVlNNl
         gd/r9YqR9cfe2F6FyG1qxZSmmu+HVWT9q6js1CSE7XIoCY9HIyM0Swd0AeaTZE1dNZEs
         J0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712754689; x=1713359489;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CXvLtdzI8BHNLZ3gO7tNbyLnAqyIxFdyIOojc+ssGOU=;
        b=J3WMrheAr70dEOgnomD60IKoV3+yNlPcRyfRpBud9VgNJaoOjaMh+CfXXyppOJexUl
         Dv3DeRoqAMY/vpgyB1tBlkLuCljicdQsbZQCeVRn3uJyxmAd1SGCCXkZ6QjUdIItYCqW
         vVVbKZvt2L07nrrHahEyxa5UO5E8bTI02iIqFIh2HdMlgBzOnexhaAFk20hnFn16oEKD
         if6vhr77bVe/APSOY5sHxIsw+I3aVKo/F1lKGNY///Ft3z1hPc7QgU3lDXPtKO05ilJn
         i3XDMv1fbxeOYY6EJlZ5AyOczdvNUaE/aqO08jqmVzTQdOtJIgqNWVMYQG1LwaAfkitC
         5PaA==
X-Forwarded-Encrypted: i=1; AJvYcCU120JirECNMuP18HM9vahBgY33bFezdRx65U27na9RPi0VwRoJafqlmnnTHBdF1Kl62rDki6QIfm/X2S6BW2Jk2zFUHjBT
X-Gm-Message-State: AOJu0YwDYShfaN9dp9Ynx/TZqqWpHtCAtl/xBR85ECAZoP7CoSnbdbkj
	bB87T8w8SOrlDNipqNjU9QpG+vNKGkwyi2Pd04WkEn7wHH4T63uO
X-Google-Smtp-Source: AGHT+IHOFwxoIb3BHpY3xb5z+jSucCQgR4fu6VR0OeH+/c72qgSictSAk74DuI1QjFla4M5QyD5Euw==
X-Received: by 2002:a17:906:f218:b0:a51:b23c:13f8 with SMTP id gt24-20020a170906f21800b00a51b23c13f8mr1585325ejb.1.1712754688679;
        Wed, 10 Apr 2024 06:11:28 -0700 (PDT)
Received: from ?IPV6:2a01:c23:bc0e:8e00:f084:5a91:c3d5:fff9? (dynamic-2a01-0c23-bc0e-8e00-f084-5a91-c3d5-fff9.c23.pool.telefonica.de. [2a01:c23:bc0e:8e00:f084:5a91:c3d5:fff9])
        by smtp.googlemail.com with ESMTPSA id hv6-20020a17090760c600b00a469d3df3c1sm6959636ejc.96.2024.04.10.06.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 06:11:28 -0700 (PDT)
Message-ID: <d080038c-eb6b-45ac-9237-b8c1cdd7870f@gmail.com>
Date: Wed, 10 Apr 2024 15:11:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>
Cc: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net] r8169: add missing conditional compiling for call to
 r8169_remove_leds
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add missing dependency on CONFIG_R8169_LEDS. As-is a link error occurs
if config option CONFIG_R8169_LEDS isn't enabled.

Fixes: 19fa4f2a85d7 ("r8169: fix LED-related deadlock on module removal")
Reported-by: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 06631a0d6..746ef4f34 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5046,7 +5046,8 @@ static void rtl_remove_one(struct pci_dev *pdev)
 
 	cancel_work_sync(&tp->wk.work);
 
-	r8169_remove_leds(tp->leds);
+	if (IS_ENABLED(CONFIG_R8169_LEDS))
+		r8169_remove_leds(tp->leds);
 
 	unregister_netdev(tp->dev);
 
-- 
2.44.0


