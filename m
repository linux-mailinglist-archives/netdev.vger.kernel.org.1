Return-Path: <netdev+bounces-136909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCB69A3970
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 11:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8AC21C21C93
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 09:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAD2190074;
	Fri, 18 Oct 2024 09:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyIw3AhI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D27F190068
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 09:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242499; cv=none; b=Q6QAvCnVGq+9Pn2xgtKBatDTiXZavLjBjCvW3e7AaXQPuIc0UGaNAAHF4Rxp30WcM/29gTMK9HZG9RoNjtEXWqDTDXvj7lwzsbzXOgbsecDxRUOu70MrEX07E87vp4v46SShcwCehYq2hClTJvQ6KfuFK+0xsYENKhUr487muc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242499; c=relaxed/simple;
	bh=LcHAdCybw/fjwzbew5Jw64RnRcRhrc7I7Nf7WZMg/QA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=O6NWncuV9gkHt27kN7SA8sp6o8k0fGHPx7q0zMPh2KkjR1AGCGazldBkQehfAqMFY6RV4PIMBnAu34cmykoceH69C2U0oJzUIZDee9foP2A/gLWMpLtyPlET6rFODP0kL+fzZWDumqWn6naPrunoRkCSo/VR3OiqZ4ExXcxD9nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WyIw3AhI; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f58c68c5so3059058e87.3
        for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 02:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729242495; x=1729847295; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0YviJx7PbBluFkbPiXDoDQhgCb0ejDqVQ4MfY4nmrHs=;
        b=WyIw3AhI5TXp8tViivP3o9hXs5vs2F3DXTNtTfRzhQH0ejp/gvdF+FwFfjHjWt4hBb
         bAhT8zlMQKnKF/kgUYF7HTC4TXQVlSeGmjOWq0JtmtAwY6q1XziCSyEAiCoEjK92rWt+
         TNBsfHCw8gEzGsxoHhA4EyQz0YnCp/1ubHZ842sXRF64sYsSlZY5BSNd4w+iFcqkK/zD
         5frczz3YRJyBnJQIX4WLnL0bR26vimeGX2J5uhIEWE7GFMoxLtxxSisOULjMRRFJcNQd
         0clXd+zG4OzGaCZzFwjKClFPJK6r6u3KqeSh8K9eksk2FOHp6AISJOt9YdVnpJRJALKj
         etdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729242495; x=1729847295;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0YviJx7PbBluFkbPiXDoDQhgCb0ejDqVQ4MfY4nmrHs=;
        b=dpcLZpERzff10u55aV2fVhMwt1KhOcUskPd3PM9a0yYs5Jzp3+e9kXqftrl3ejIGWb
         1RHnEEUVplR+cxN5fAdb2mobUx0qaorcbBrk77MBnA4o/NUrB4O+s4nakE5ECSrOiDu6
         YX8fM2JYqPfACdEVTW/0briDRmsquwnQTXWtRL+ppmC2hJ1ku6VIqe9JfMmHtvZppALs
         nqRHxp6RzmGOXKzuGmlM7RWp5Q+apeVBRpNDc4lk66MBqtVT0BhXT1kUJvr3xvBHtKno
         Oq1SZXyld8D/ZRxFGM6mg5Mgm6Llxm38PN+sQoc+UFcO7j8P9bZvX+twYH3GxoaqlB2e
         AFMg==
X-Gm-Message-State: AOJu0YzcPd/5VfexoAmgOvBcnT1NV3u1aTRrZStIUGwgOaqCcaVdmLgr
	hGnvS8C8H10drbIdZvXHDEEgpHBjSrm+mpPxw0A8TWOk3lKtoZeA
X-Google-Smtp-Source: AGHT+IFSLrAtKfg5sJ+TXJS5hxuM3lomBEn4dmd5zq+5VS7vfxvWN0vX8Wac/b567o31ZI/VmWcbwQ==
X-Received: by 2002:a05:6512:281e:b0:533:4505:5b2a with SMTP id 2adb3069b0e04-53a15469bc3mr1582587e87.28.1729242495073;
        Fri, 18 Oct 2024 02:08:15 -0700 (PDT)
Received: from ?IPV6:2a02:3100:b04f:2200:a42d:40b4:fdfc:821f? (dynamic-2a02-3100-b04f-2200-a42d-40b4-fdfc-821f.310.pool.telefonica.de. [2a02:3100:b04f:2200:a42d:40b4:fdfc:821f])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9a68a92159sm67388366b.25.2024.10.18.02.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 02:08:14 -0700 (PDT)
Message-ID: <78e2f535-438f-4212-ad94-a77637ac6c9c@gmail.com>
Date: Fri, 18 Oct 2024 11:08:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net v2] r8169: avoid unsolicited interrupts
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Francois Romieu <romieu@fr.zoreil.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

It was reported that after resume from suspend a PCI error is logged
and connectivity is broken. Error message is:
PCI error (cmd = 0x0407, status_errs = 0x0000)
The message seems to be a red herring as none of the error bits is set,
and the PCI command register value also is normal. Exception handling
for a PCI error includes a chip reset what apparently brakes connectivity
here. The interrupt status bit triggering the PCI error handling isn't
actually used on PCIe chip versions, so it's not clear why this bit is
set by the chip. Fix this by ignoring this bit on PCIe chip versions.

Fixes: 0e4851502f84 ("r8169: merge with version 8.001.00 of Realtek's r8168 driver")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219388
Tested-by: Atlas Yu <atlas.yu@canonical.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- choose alternative approach because v1 brakes connection under heavy load
---
 drivers/net/ethernet/realtek/r8169_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 4166f1ab8..79e7b223b 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4749,7 +4749,9 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 	if ((status & 0xffff) == 0xffff || !(status & tp->irq_mask))
 		return IRQ_NONE;
 
-	if (unlikely(status & SYSErr)) {
+	/* At least RTL8168fp may unexpectedly set the SYSErr bit */
+	if (unlikely(status & SYSErr &&
+	    tp->mac_version <= RTL_GIGA_MAC_VER_06)) {
 		rtl8169_pcierr_interrupt(tp->dev);
 		goto out;
 	}
-- 
2.47.0


