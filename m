Return-Path: <netdev+bounces-71061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E24851D73
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 19:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F9F0285BE8
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 18:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E817345BE8;
	Mon, 12 Feb 2024 18:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDMKsDrV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3AE3FE44
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 18:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707764328; cv=none; b=ZvDt2y7gv6TsAfjYCWsJbasR88TvoBMCXWjni6wMxswJXZdlgkIJrTR1/kelfPZHrXBGQigZuwwqeR7T8bW9uVDFME9vv/vJepOCGNZ3m4g6Y/3nSgjOXUDTFpVeIsKzjEFS0Tbq1Knknm9PYyWRr3maGH14P+9i3mBgupX3d+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707764328; c=relaxed/simple;
	bh=UIsPhL0DhrlfpyGi2TLgwF2tQjVf+mUuI9EnG5Px+aY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=u/4OEJC38o0ewjb1VSSsTAZVqZQi68tIOVmWZQ45X8E26oBHFHoQ0mKv7zNvRWgHmThqzKTKHkXYdYePRa3AHFdrFLh+zABBrrXJfgA/maaz4zcuisFMIwIIsP8XblmMhwlX7Dsrhicj8UnB4iletsIFJVfp/oYECna7dJrjCR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDMKsDrV; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55ff5f6a610so4234675a12.3
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 10:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707764325; x=1708369125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oXcusfGnyVEixyPAP0j+52ZlFg5E2rkKoTXFbsuIV3Y=;
        b=dDMKsDrVDAnhjioW4wu1unOZ0xnRw43+ULsKmPoI3Xp9pQBCG0MJmIMAF6aO4WP5vP
         Zg5S3WuOxxSzl8t5ytBDTfqtZJZXWg5Kht8rximKpi45CMVtLAIMKJCp3xkKPe7mAb1X
         1PYDlwDqlAidB32ZUwqigHeYBr2xINaKiYK235zr8o9EfCG7DHVi3E+kKHf3hs5jFPHB
         b772F+UQrgprPC9ZLiVxtB7e6IMXoSI3o2BQkbzTOmyX2YKgrGmMD/tEPRWoNVuO5xbg
         9cZU5eql4ymWNqBYZ5Zrf72P4F5JZkxtWwsC8/UVuPPnWH/Vw5cQPSXIhajo5D/V8BFu
         utDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707764325; x=1708369125;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXcusfGnyVEixyPAP0j+52ZlFg5E2rkKoTXFbsuIV3Y=;
        b=VEH/GlXEf0TMvdCY5DFLXK+1O3RU13xygGi0+OEbK66LTba0OjWXEaXQCJBHZlIHfh
         ybrRjiE3dNZBNYqgZDXphzSOVMWBZRz/wlB4tymICZ8COv8sdeegT1wT8gPd1VAh0Ghl
         uOZbCvPq1DxlTtz8t+72WKKfiruw8EJUvfY2JEk3D81rAQUVBj5Inno55Oo27YsA8a6M
         l1Vg/PNdKmVovIvO0KJeZz61XYfirepuidLa0ucZdG+VqZIfrFyvGvs/ScE/8HoibYtJ
         yG6RfgoxlBNGlZ6ZdvaYG2HJbVJxqc8SRVD/U9azOxVhxFdvqn65yA7SkCoag06Xkln3
         bGrQ==
X-Gm-Message-State: AOJu0YxZ0cZsiaYTvl7W9Rm5CIUJANu7myMFG0cJ0c64PG1NKAXLMHGk
	WYUAJ8FBAwoSfLF2jovEbWXIfl7MSWzm5SrIlP1gBcqwTsbMIr3i
X-Google-Smtp-Source: AGHT+IFIBf161JaDP9IHOe6Bk6pmjAO4HifujGFXAqs5yPN1uw8zdpjP+qWKEOYstjZipg4RcLqoZQ==
X-Received: by 2002:a05:6402:b78:b0:561:d726:f71 with SMTP id cb24-20020a0564020b7800b00561d7260f71mr1033713edb.4.1707764325274;
        Mon, 12 Feb 2024 10:58:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUjDVKfHljxskW6yCSNVKWgltR5oZLhmuNHCB3EllsQub/1eYxEb/NIM0uFMIPVr0bwE5XvYOeSgajdSv+IyPfrYU1seJIZ1vDQbvtnjsAokk3IK8KIxa9tk3T9ynfF1u9l9O3FoFZkRPqn11X7akqIBJRfa3EEFjAyXQMG
Received: from ?IPV6:2a01:c22:778f:2300:f4de:66ea:cd50:b2c7? (dynamic-2a01-0c22-778f-2300-f4de-66ea-cd50-b2c7.c22.pool.telefonica.de. [2a01:c22:778f:2300:f4de:66ea:cd50:b2c7])
        by smtp.googlemail.com with ESMTPSA id t22-20020a50d716000000b0055fe55441cbsm3154227edi.40.2024.02.12.10.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 10:58:44 -0800 (PST)
Message-ID: <cfb69ec9-24c4-4aad-9909-fdae3088add4@gmail.com>
Date: Mon, 12 Feb 2024 19:58:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 2/3] r8169: support setting the EEE tx idle timer on
 RTL8168h
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <89a5fef5-a4b7-4d5d-9c35-764248be5a19@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <89a5fef5-a4b7-4d5d-9c35-764248be5a19@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Support setting the EEE tx idle timer also on RTL8168h.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index f6ed74073..5244f24a7 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2037,6 +2037,11 @@ static void rtl_set_eee_txidle_timer(struct rtl8169_private *tp)
 	unsigned int timer_val = READ_ONCE(tp->dev->mtu) + ETH_HLEN + 0x20;
 
 	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_46:
+	case RTL_GIGA_MAC_VER_48:
+		tp->tx_lpi_timer = timer_val;
+		r8168_mac_ocp_write(tp, 0xe048, timer_val);
+		break;
 	case RTL_GIGA_MAC_VER_61:
 	case RTL_GIGA_MAC_VER_63:
 	case RTL_GIGA_MAC_VER_65:
-- 
2.43.1



