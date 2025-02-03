Return-Path: <netdev+bounces-162232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 011C5A2647D
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DA797A372F
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 20:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D029920E302;
	Mon,  3 Feb 2025 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3YD64xi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019A320E310
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 20:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738614808; cv=none; b=hlBS42PmOuMe2rfrAewu5HOXOF9b2yquURvGS7dcRgaDjuQjI9az3nz3hr8PTc6mobXmAmVEuLLKNY5UFbOWUd3G/r6SJcfXNIL1/cDJMFKtwaResUZyqvGrpVFkIW39Tl4tNIQYAWBUo4zHAGZPNUCy8DgwH5g869Bl0obx/P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738614808; c=relaxed/simple;
	bh=qdGSp93PxoMRm5g8+B0EO5DiphfRFSpLcGi77I8FSok=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=B73UooYII5kvDZ+FoD4mQck+8iWGEYluWc5iP2b1wZ18k+e6ImhGy4/pyuyz7AW1dcm8emuAEYr1TyvTHPEori4vxm+Ar5qeP8xUvRUGs6xsMUEK8+93IRgtmJpHTBuQrT/ndnnB7R/oP6r285mdIJ+SNr8YhG4R/kbLDAGlTP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3YD64xi; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab744d5e567so106610766b.1
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 12:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738614805; x=1739219605; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uCZN9Ji/na9rAvqB5PH0wiowJ2M7ukQii0p8pXqVJrc=;
        b=O3YD64xi9rkAZZzhBq01C+8RuUv54ZjmDJ9Mr6ZnhQhqljUCxsd3TWszhC/AYyE6L6
         V4CdiHnPQcoLNN7OOcW7D49ye2+u2GhYpA2w02NsP2BoCahITH8h28pI68L7qI+hInsG
         ssVubJn417jkMOo8g3XdwU8XDy5cDL4yjsMs7qj/K/VXOEUH1z7g8W2cSUQkzpDmXHVy
         FzZ7Yzo7ILQJA9WiqfzA3hhGDCAtTC29F69sGiVRUrpyV2ExLJqc+9pb9AFudfOiSxaD
         ImPeLNKSt7LpLQ3eEvXz2JAjZnkr3gopTdRrfVQeBlMxrVH9PY6WM60M4yJVPzS+g4qO
         qIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738614805; x=1739219605;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uCZN9Ji/na9rAvqB5PH0wiowJ2M7ukQii0p8pXqVJrc=;
        b=hIJU4MrGKW0JD4li1LDTp2iwrOqnu0kgdRSknAXGufiZYK6t4LsP8hFFcI7M6u5Cbu
         GHyCS+BlKM/sAcoCwRFy50ej15TbId6prUIS/LGlIst7V4/JT13PpAXg3nUlaiItQmMB
         fDlsxxZPCx7TAYbjyWv35vk2aVekBzvbKNXgxG++V8qtCuwJyMmkoqIZkNfNww+bHRIK
         egaH7HttLrQRfnWGgRFFXJubUA8PbSPy4ycBmZYCH9LOpgDmtIG6hMFNgmKZTQR+Zoh5
         PJ+4MLXsZol9/waiH4Ut0sHjBkC47BKodVqC9NU8BQU/Hw4kmOVzzoYrVm+MtXvoq9JZ
         W9tA==
X-Gm-Message-State: AOJu0Yzx+ewv0UrMLyRReJEVg39OMQo22SOEjsYc9i8N/xsvZCE3uZh0
	cPrSPXDgSQaHbZWLFSnJVAI2B3TwbcRxvDGbT+lESBcintfF5CBp
X-Gm-Gg: ASbGncuJKxM3dZAC5QcAeyKGBWuXCiMAYaHHiHOHwM8xkcNrzrOrojbWdzos3P/GhvP
	wiU1a1bIqKi9Pu6vJBS4TjCJWjem09z/TygVdOX6xJzmgPBiDjGhDF3snNnBo4nKzknzxxzcrp+
	N9DqoJf/GL7yHJzQHy+I3apAxDGqj15Z/8Vz5OtgnrRYJuQMwXTDRGEMRolgpxQGwP+5cdDCdhx
	R+cXqVJ2M23Or4ax0o927npa2FruCCcF/ruGyjsdG4Nla32NjraWC+9BXnHlcVhd6fQ9SlDItr7
	G7DkKNsYzfV6m60xiSF4nl5HmLkkEKKxznqmp+Em7e+GHxw0Fmf1OCiVTlAkTrPOTqoGIoL97Gy
	uGEd0wTimyGebQcz1hNjZMs+4tRurOHUek8Q6JlQ9oiPp3SfhuquvjCMxaVRl9udv5enyC8A3RF
	XSWjWm/Hk=
X-Google-Smtp-Source: AGHT+IGIzEm2nKCVAnUDNGKtHEMPvmJEchxzEz3zDaITNdmeX1NENJShlHH/A1BmwrzfvGmZchiM0Q==
X-Received: by 2002:a17:907:c13:b0:ab6:726e:b14d with SMTP id a640c23a62f3a-ab74854568cmr81598666b.23.1738614804776;
        Mon, 03 Feb 2025 12:33:24 -0800 (PST)
Received: from ?IPV6:2a02:3100:ac6d:8e00:811e:2e8d:e68f:ec04? (dynamic-2a02-3100-ac6d-8e00-811e-2e8d-e68f-ec04.310.pool.telefonica.de. [2a02:3100:ac6d:8e00:811e:2e8d:e68f:ec04])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab6e49ffd42sm821332266b.95.2025.02.03.12.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 12:33:23 -0800 (PST)
Message-ID: <3466ee92-166a-4b0f-9ae7-42b9e046f333@gmail.com>
Date: Mon, 3 Feb 2025 21:33:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: realtek: make HWMON support a user-visible
 Kconfig symbol
To: Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Simon Horman <horms@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Make config symbol REALTEK_PHY_HWMON user-visible, so that users can
remove support if not needed.

Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/realtek/Kconfig | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/realtek/Kconfig b/drivers/net/phy/realtek/Kconfig
index 31935f147..b05c2a1e9 100644
--- a/drivers/net/phy/realtek/Kconfig
+++ b/drivers/net/phy/realtek/Kconfig
@@ -4,8 +4,12 @@ config REALTEK_PHY
 	help
 	  Currently supports RTL821x/RTL822x and fast ethernet PHYs
 
+if REALTEK_PHY
+
 config REALTEK_PHY_HWMON
-	def_bool REALTEK_PHY && HWMON
-	depends on !(REALTEK_PHY=y && HWMON=m)
+	bool "HWMON support for Realtek PHYs"
+	depends on HWMON && !(REALTEK_PHY=y && HWMON=m)
 	help
 	  Optional hwmon support for the temperature sensor
+
+endif # REALTEK_PHY
-- 
2.48.1




