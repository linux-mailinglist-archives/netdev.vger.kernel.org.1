Return-Path: <netdev+bounces-248259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C552AD060A0
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 21:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 618F9300F9FB
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 20:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E302E7F25;
	Thu,  8 Jan 2026 20:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGXHZOv1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AAC326926
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 20:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767903961; cv=none; b=V7s/9uAD6ObRGZ2hYai6y9V4g7+sG/fzZCblvJeCZ+lePWiJlbvCZep6YbEuovvxkkKxeXNvVxdF7Gz+o+hZX3CyD9P8OHDNGMfahClcbw40yJtGIVW2W8/3eRb03ZFkFFS24/lso8osFJ1Ivf5E0LzLf2hAOXER6O1Uy6KL5G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767903961; c=relaxed/simple;
	bh=U2BbgQ0nFVc1HOpFZFM+nHHhaqqkY3RvFmlkS6iZbAs=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=K+n13PKGF68GnWSEDT4fp3Go6kiz/kL/QbnUC5G4htyvf8Br0ofx3QTskTX2v5x7yqJ6rSvw7e2Xwe+P97tiuqxH/tJw49iQi/ljgro1LkddBUOzpb8IUc0Mz85mSFWj4YWTXdO4DgLGdK0VD4YYYLBEvRW8vZo4EohLUuINvqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGXHZOv1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47a95efd2ceso32588745e9.2
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 12:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767903958; x=1768508758; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nmIo15Q4Cy4zu51Tdnk894wfDw/sT3KMwraPd5nGDc=;
        b=VGXHZOv1ADcIp5JxhDcj15wfR3RP9BeZ+xTClNenGK4Uwv4HX4elzFK1N4TPdOCdbX
         xpI4f/j/ewrKukAWUXcQWbtimhA8bdivfskvdgkLUcxgFvos8xJ5c9/oWJSqnWdyjd2O
         CwSKezCST51kxNO3qIDEVhXHgZwM7zyO39Jw4tH2AHcZwmd6R5PW6RURB4YoZJkEZpe0
         f046bRlAWMurzH+nCVp84zyj8GboHyUZQvvrSLLOjNtV1R09fmEuKnTT/hAKDQJQDYcl
         0kDsq9/ZFxgjx+2sdyTQ8GxeItlrRlJeFnuHMDG/WQ2Lzagf4Nm45f8NNC08tGiHDUcz
         jfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767903958; x=1768508758;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6nmIo15Q4Cy4zu51Tdnk894wfDw/sT3KMwraPd5nGDc=;
        b=pdzuBlAalyNSca8q6WQ62pImV53L84a0DXkir97N6MDg6hLKuJXn24qQklKROwdMlx
         P0N88Hleo6RLyv671xexzvJ39qzX7o4XrdRp6rvtmcK5kqu9UgQfY06YJuUqSPEaS4oL
         K4GnuB6DICqeEq6+7Cn8nPmpagLuiDvhxiuaa9affuLD0/G7iRI9XCh3iW0HO60k1Tvz
         XOsFLbdvE8GW79JHdcHnJaa6A5WUXXjJdgM0b/jMIEQIwcvwGDJlBzD9UCh1RJ13thrB
         7d/hK4cJQ2Ij9u7E4khhzd82bkzS46QYS/lQiLtrZoDhZweDkq5SqU48rJkDxIKUKvO/
         UQPg==
X-Gm-Message-State: AOJu0YxYiUid2BQdoiXRPbU6C3Nw3MQ4Ff+VmIX2XLVF8ivruVboZF80
	i3hVccSVnLkVCRLM5iCMkLPmCGdi8fdC/7ANMKqbo7Snw2K6y89LzxNd
X-Gm-Gg: AY/fxX5XRsZk7rBIJfeMAqkxwNasCzo2GQqYRXc5pk4CGp9zNwhUP+hZzOEgUggS7MB
	Z0JcLnXaFdDu5NehJtaxHhCk2qxb8ni23QW90fELBzw7r8VbJ9fvjZ6FWRuPelZhQLtBNxLjbrn
	VWAjzg6Fo8GBjaIyVGTKTl/cUpuN7QvE36ojJ/d/Vb+xjf14K+q/bfj1cw2kweRHTBmmDofOysb
	XSF1tQorzk99/ODI1QLbqfU8brIOI9ysYexiu1QyFKHVZyyb2kEawGT0mR3PE18nmKTU6IKAZyv
	HTYv0p/A4ucNLTiT/5KD4le9bIxOmPvwmEA3O2RI+tsYmb6n6qvRIZwYCphFBDSrCoPcXhvmr8p
	GnBi15LSQGZO/P279HuYCMkYYgGx2VGup2scMF06b7rjdCldqUNFgxMMbZVfEgCJtc0+6hysFqo
	e5weKZtbOGVDyzZ9c8qMJ1fCjRfPftnUgw/DwrWlSNmWmY8NHldh6wyU1g/GVujxoJ3Tya72vBI
	y4QE4SVuRDKQvtu0IVdBDWHGmaal2Q50i/fH5ccaNbZS9WySqbq0ABRCYZABz6TKjRIWsFYgsY=
X-Google-Smtp-Source: AGHT+IF6nNwk0LgXTyiQz8JKOV7xzioy5aoqHWsGNX1ikgad/2fNdT28+/UGW1Bakby68ZP8smL5vw==
X-Received: by 2002:a05:600c:4747:b0:47b:da85:b9ef with SMTP id 5b1f17b1804b1-47d84b18a7dmr107319145e9.16.1767903958418;
        Thu, 08 Jan 2026 12:25:58 -0800 (PST)
Received: from ?IPV6:2003:ea:8f14:a400:1d60:60fb:9b76:bf18? (p200300ea8f14a4001d6060fb9b76bf18.dip0.t-ipconnect.de. [2003:ea:8f14:a400:1d60:60fb:9b76:bf18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e175csm18162935f8f.14.2026.01.08.12.25.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 12:25:58 -0800 (PST)
Message-ID: <52011433-79d3-4097-a2d3-d1cca1f66acb@gmail.com>
Date: Thu, 8 Jan 2026 21:25:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Michael Klein <michael@fossekall.de>, Daniel Golle <daniel@makrotopia.org>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Aleksander Jan Bajkowski <olek2@wp.pl>,
 Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [PATCH net-next 0/2] r8169: add support for RTL8127ATF (10G Fiber
 SFP)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

RTL8127ATF supports a SFP+ port for fiber modules (10GBASE-SR/LR/ER/ZR and
DAC). The list of supported modes was provided by Realtek. According to the
r8127 vendor driver also 1G modules are supported, but this needs some more
complexity in the driver, and only 10G mode has been tested so far.
Therefore mainline support will be limited to 10G for now.
The SFP port signals are hidden in the chip IP and driven by firmware.
Therefore mainline SFP support can't be used here.
The PHY driver is used by the RTL8127ATF support in r8169.
RTL8127ATF reports the same PHY ID as the TP version. Therefore use a dummy
PHY ID.

Heiner Kallweit (2):
  net: phy: realtek: add PHY driver for RTL8127ATF
  r8169: add support for RTL8127ATF (Fiber SFP)

 MAINTAINERS                               |  1 +
 drivers/net/ethernet/realtek/r8169_main.c | 89 ++++++++++++++++++++++-
 drivers/net/phy/realtek/realtek_main.c    | 54 ++++++++++++++
 include/linux/realtek_phy.h               |  7 ++
 4 files changed, 147 insertions(+), 4 deletions(-)
 create mode 100644 include/linux/realtek_phy.h

-- 
2.52.0


