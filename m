Return-Path: <netdev+bounces-248714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B214D0D9BE
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 18:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83546303294A
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 17:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA05299AB4;
	Sat, 10 Jan 2026 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSIrCJpN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BC123EABC
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768065804; cv=none; b=JAPGlQN7vZvDbLublAZmn3VRCJbz4HZwLRkT/tDTqkeQFvDbMw2oUzPgK+L+f1N+6d/CaDuhL1O7v69wuesws0yJtxFB+9CH/aw3gvc9NJqC5orVTIYUSq3b+yq00Mm6fWa1WCdyXnHpmjCWdRy6lcF22RvW1NeH6sYHH5l7a34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768065804; c=relaxed/simple;
	bh=pakMjl6j6GOv4b+iY4CNdvqw95U+lNMsuEAbPeAA9Tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+vNVn3vdRRlioWWO4B/zFJRSIHfOuiicnRgQXtpxlMUWHdddPhrvA91Mzxp5kE74HdxDa6dhtFk59rfnmZW8T947cUmUrIYYLNsqMnM9G3eSkfaUxRTN/P7wdR9a4YJgKfTCS1Z0EZFvSY3SFSfxqL6jfgiu/x0CMydakXIjnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSIrCJpN; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4775ae5684fso24062885e9.1
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 09:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768065789; x=1768670589; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6i+l9OirRP2WP1mwsYu6cExZNaNS29ikPG+ILCNDCAw=;
        b=bSIrCJpNpScrwcrjtYab0YZ7qeifRvVEtiP/9SdXMJb7ErWq4xr8/votC2e/ilSxMU
         7M/ij9JdgNMNwpGyYXD3fAMVCphRGUdpVet9m7/MmpDagMUGCULIQxpwcPMP7pBAdyiH
         GZTnDHMYbi2P0iaKuS6u0ae5vPpPNaC7W1ZK1baK6V3MnlyOQ4DsL5UJjxdvryjltScB
         3XTs0k1aGbIsu0D85oc9bepVk9KidDGZ9/8WzB5mNhjOkT1hUaFpejSTrnNaXkTRsF7E
         EdrAQ40x9G0aDO/mPrpFmX9Zg3p38Cg4pw3R+wP2jS6LFU6xML5r9OUjbUAx4F2wI9Hf
         IMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768065789; x=1768670589;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6i+l9OirRP2WP1mwsYu6cExZNaNS29ikPG+ILCNDCAw=;
        b=MH8sKJ8Mx9TFOziYGQAU8arCwPBLqYQMuizwPfPUXwaOr9uOVWpRLUT+meNnbnCp5Y
         S0GDsDVfeOE44FQri7gL1jGYuVF3ldSePksKMZpps/BecAeVH66903IzzBVpq0MDsrmM
         B8QoTunmniVhkKyqFnLBT7u3vP99S9ndCMocvwkLJRMx+LZYwcppWJ0vBIjqR0Sps/Wm
         Jdmomz9rPrvBgpAT7vsyoNPBhimisK6UTUVZES5V9wnBy9lJWddtvt4uQ2dQPTHXvhFU
         zUJJSec4fyvNk/Lt3zF3wH3VLvu1VDiRRIj4gxYzDiVkAGpkyqXN4B1XWAC9wo6/p6OS
         PCsg==
X-Forwarded-Encrypted: i=1; AJvYcCXzrTtapwU7Xu/MQa5WerW1Nh0vyZBm7jQtqqjjy2WL4UAYCe29xk7o6G8TA0p/UuLdJo0RvxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YySFaLS4OPR1KoPIzeGf0FeFSWoSE3IKpwFoGYq/PiioQ9whEL+
	IZQL6p2su6CjGjuBpySyoLGl4Z2a7OhIyK7YhrthJjwpr/2kvfEKxE5v
X-Gm-Gg: AY/fxX6ypY1HcY3n871iv0eFlzRvrnkOZLxgWmxTboFZUrk5RJh5RgnPZAWXDtcI2QI
	kHDvFSfQIE68mx0vL7sTuDnPNsSNqp8h28cEqkg3kffOAwwZcjHfP4MObMBmQPq1hecPkIQzhc9
	CdpVT/Z5Zwgk+RBD/ZQpz56NO4Nothk5JqwAj0VI+l8VlgmHhILcIg4gkG9Sfy81cXfILEO/jzz
	zys6laejqf2NQAEEKATXUsy2TJ05tP6DX6pBnrOvyJBDkSvMaLHavc+/9NKH9EDSbkHJ8fvj3u2
	xyHh6fRex49roOlFaKSOBx2AH4xYFrKK+25ZAQUFi/6QTiyg6dxXiLVkOLFQHH0I+rYA4QvhHLX
	q+wYkvU0xBLEnbIKNeQ1cFwWEfQtQRs3x8CW3UvExZsDJ2rZBZkSb3VsrnlEvMBYvPZ340P3Jqk
	Yi9WBrLcDxAuBmO+giqeMsBVDuIerBYchsRNQdO7e8bxe2RHo8X0kwG6dVjA10mCKcQS2+rVlrw
	9F7y2DvyXq5HzpWN1bnOK5JcjUaHGLDiTAXEkIVor4oA0V5JBujCQ==
X-Google-Smtp-Source: AGHT+IH5SusDuyYd10wVOARF8vfhuJmkj2Gs3NQGqH2vk32kOtSeaadtC/gGNE4+vdYKyJWnsH8X+g==
X-Received: by 2002:a05:600c:4e13:b0:47d:25ac:3a94 with SMTP id 5b1f17b1804b1-47d84b32f30mr167555215e9.17.1768065789262;
        Sat, 10 Jan 2026 09:23:09 -0800 (PST)
Received: from ?IPV6:2003:ea:8f1c:1800:8cc6:804e:b81b:aa56? (p200300ea8f1c18008cc6804eb81baa56.dip0.t-ipconnect.de. [2003:ea:8f1c:1800:8cc6:804e:b81b:aa56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d86372c92sm99561775e9.0.2026.01.10.09.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jan 2026 09:23:08 -0800 (PST)
Message-ID: <6b1377b6-9664-4ba7-8297-6c0d4ce3d521@gmail.com>
Date: Sat, 10 Jan 2026 18:23:06 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: phy: realtek: add PHY driver for
 RTL8127ATF
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Michael Klein <michael@fossekall.de>,
 Daniel Golle <daniel@makrotopia.org>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Aleksander Jan Bajkowski <olek2@wp.pl>,
 Fabio Baltieri <fabio.baltieri@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <52011433-79d3-4097-a2d3-d1cca1f66acb@gmail.com>
 <492763d9-9ece-41a1-a542-d09d9b77ab4a@gmail.com>
 <20260108172814.5d98954f@kernel.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20260108172814.5d98954f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/9/2026 2:28 AM, Jakub Kicinski wrote:
> On Thu, 8 Jan 2026 21:27:06 +0100 Heiner Kallweit wrote:
>> --- /dev/null
>> +++ b/include/linux/realtek_phy.h
> 
> How would you feel about putting this in include/net ?
> Easy to miss things in linux/, harder to grep, not to
> mention that some of our automation (patchwork etc) has
> its own delegation rules, not using MAINTAINERS.

Just sent a v2 with the new header moved to new include/net/phy/.
patchwork is showing a warning rgd a missing new MAINTAINERS entry.
However this new entry is added with the patch:

--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9416,6 +9416,7 @@ F:	include/linux/phy_link_topology.h
 F:	include/linux/phylib_stubs.h
 F:	include/linux/platform_data/mdio-bcm-unimac.h
 F:	include/linux/platform_data/mdio-gpio.h
+F:	include/net/phy/
 F:	include/trace/events/mdio.h
 F:	include/uapi/linux/mdio.h
 F:	include/uapi/linux/mii.h

Bug in the check?


stdout from the check:

New files:
include/net/phy/realtek_phy.h

Modified files:
drivers/net/phy/realtek/realtek_main.c
MAINTAINERS
drivers/net/ethernet/realtek/r8169_main.c

Checking coverage for a new file: include/net/phy/realtek_phy.h
  Section ETHERNET PHY LIBRARY covers ~225 files
  Section NETWORKING [GENERAL] covers ~3556 files
  Section THE REST covers ~590073 files
 MIN 225

