Return-Path: <netdev+bounces-138865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FEF9AF410
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 22:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A705528702F
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 20:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1BE1F8184;
	Thu, 24 Oct 2024 20:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTn8t1j6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBAD18A6DF
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 20:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729802944; cv=none; b=T3EPvQAniT3hrsulcNzGyp8HnrNIrE6XHRwDoDbjA8SSRDYyXc192t1hDH4YGFoFNe2pgrSLJwFmt7ECpX4jKMURTN/L3DMB0EEUprnHNSrlvlVMydxck4kliKUq0cO2u1HRHZf1Sdd7NkHlMO9P0dBVzj1d3Ul/GYlCLruBBKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729802944; c=relaxed/simple;
	bh=UG9IJmO1GDDsSsaLkOWa0Ozhofg9D5VI+uEjJM2i26A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=BUtJ4hrHYjsAdpHY6l7zZxo4NhVW2riNF29jBGadDTD05LVsbGCBfyrDuEM5XojC3HBNv0c6fQcbi6A7CvqK/W0fzURpWIfx4BkXYnAMhfOCTwqWABNLXExfgwNq9ZzhPxEiC5EnjXVaC9pSl57Smn9WfTdpLoV8mvPDOP9YKb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTn8t1j6; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9acafdb745so270677766b.0
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 13:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729802941; x=1730407741; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fwvTjpJuzQ+RVwQv8UVyiNxISUnYrNkVGKslq35A8hM=;
        b=TTn8t1j6agad68VNb+DDKulBePQFVAQqUWstEdr8p6GY9Jvp/58v35fQXxDOTdgruJ
         sCY+rp43laa/sZt0jHE9nTgShmjTvuMDqr175yCNAPPKHuLymL97eaObIV8lM/fbgFN6
         U57AwhLTuGG0ScgdQzR6QyR7D9kAqxvW0p3xZDgQwLEH6Zsf32nxRbFzXdpPuew/+LSm
         cohDaXRYSDTvPjvsQC70TiM54iqyk6wi5OYcpYnBqqd14tJZSaq7gFP38TNHKf+b0YXE
         gtpKYJKWloJdRvrpDgeDxAWb8iH0g5R6ZWkYWd25uPHdfMAUCS0UOXOhatuDyZg5MfOY
         /yag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729802941; x=1730407741;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fwvTjpJuzQ+RVwQv8UVyiNxISUnYrNkVGKslq35A8hM=;
        b=NUEEHbI+n9W3XLEMWt+zprrxZemIszsO/kBAROFg1lYOSJEY5GFi/vwR4ZVVz3eDHI
         uQyWYOt7V87zCfaHgNDs1BDibJwFd+2vlV0WZAkZQzwQRafolZBP8azdkXZZqMeQK6gd
         BH+gk1D3ZwGxuqhMCE+hJ/TUTeafb64OKPXXEq/hLb41HRuMn3QwVwWkvNiePylC9eP3
         ml6Nasl3ZGYOATMZRKJsg/j35gKQkDrfwufs8yhXcbx6MIHWcmJS6FQyxJE16XgG3BPl
         cuZjSo2jQP1uZzUnLY8b9qXBQnMpiVInd/NU8HDBiif8GwISRJKfJr5pOFBuYFdv7J+0
         di0w==
X-Gm-Message-State: AOJu0Yz3PkhoTPWGtU9qP4yPPPs+b7IY/RScZhIRPJAVFrP0Y7VwjaVw
	TYI9oN1XRQOVwYZ3J/E534GHbzq6MO2FAWdeHZliTz8gau3+xva9
X-Google-Smtp-Source: AGHT+IGS+zVgQmh4Pu12swtJHRjR4cT6jA+KrygdZ1NTGRd0S9tir8R9DzMqLiDvPl16OuISwnpDHw==
X-Received: by 2002:a17:907:3e9e:b0:a9a:c651:e7c7 with SMTP id a640c23a62f3a-a9ad19a8cd6mr333466966b.12.1729802940578;
        Thu, 24 Oct 2024 13:49:00 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9c7c:7300:4169:9367:99a0:d46c? (dynamic-2a02-3100-9c7c-7300-4169-9367-99a0-d46c.310.pool.telefonica.de. [2a02:3100:9c7c:7300:4169:9367:99a0:d46c])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9acbee153fsm194229266b.207.2024.10.24.13.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 13:49:00 -0700 (PDT)
Message-ID: <20fd6f39-3c1b-4af0-9adc-7d1f49728fad@gmail.com>
Date: Thu, 24 Oct 2024 22:48:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: fix inconsistent indenting in
 rtl8169_get_eth_mac_stats
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This fixes an inconsistent indenting introduced with e3fc5139bd8f
("r8169: implement additional ethtool stats ops").

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410220413.1gAxIJ4t-lkp@intel.com/
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 3da0f6be7..b84587841 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2225,7 +2225,7 @@ static void rtl8169_get_eth_mac_stats(struct net_device *dev,
 		le64_to_cpu(tp->counters->tx_broadcast64);
 	mac_stats->MulticastFramesReceivedOK =
 		le64_to_cpu(tp->counters->rx_multicast64);
-	 mac_stats->FrameTooLongErrors =
+	mac_stats->FrameTooLongErrors =
 		le32_to_cpu(tp->counters->rx_frame_too_long);
 }
 
-- 
2.47.0



