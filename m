Return-Path: <netdev+bounces-142521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3349BF7EE
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 21:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B88D1F210CD
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 20:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590A620C003;
	Wed,  6 Nov 2024 20:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRJbCMw8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E3A20A5CB
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730924477; cv=none; b=oWPYqEWZkbntbpZnsadiWZ29PP9d5me1MyeMgFSrJ6N33zsqdNDDbRg8zNfiDDNmGh/8eXdtG2mA8JNhwABBOfifb0ScqBGaqozSfK22VHnIe99zsWkcM2uJav3R63hw0Df4g8zJR/NjtF2vSqkGsTq+xupKb/LcPdENLJ0I8KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730924477; c=relaxed/simple;
	bh=Fs1n9gWUTTVqaVqpW+Y1cqqN96hhwJstxSEI++SCnRs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CELZVkezQ/eFAPWAyNqbSA/kqf3hCzUI01ib0HT0uBKX7mfR0FDTtbbwnaZOaKE83zZbgsy6Ws1C7zOLbUZaFAkhFbsFhCQQcAsOqlsasNjUnODf9flhvXjSoUN4OrmDLP7h9cU9hnCOVwaSbJayvd/PLFZa56fe/WfwjGIwksg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRJbCMw8; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso2952071fa.2
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 12:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730924474; x=1731529274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nPvGLhAV71crlXTG4ONozkYMrGf137ylqJ2UaZy4gnQ=;
        b=eRJbCMw8basS4h33iN4GabxBlJjI8hpDYaGgbltNmVi1zCMMKCiLlC0J2L4uRbBsTr
         oAjMWcUbdeFtKsCj1cK07dfn8ICHftHKyY0QLMWVHMcSrBUULwoBWkCF1ks3F/o44XPQ
         qVLz++BejnJCvNl843hOhWqEXSXE6x2GGIM7Jx53wNyDfsJ2p9BeZQtAI5TTBMfy5y/z
         h+lz92IdfAIDHmUhI+gBtFyFTZDBcO6WFrmOVfZnjMepimcfrlu5uFxvUVUzTOVHcp1L
         xa3JfIfkZgx0aMY9r7LqF1DVTsu17kXBHi2rPYDzDEJL0QPBHS6TsBFd3wVcCIxyXft5
         HyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730924474; x=1731529274;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nPvGLhAV71crlXTG4ONozkYMrGf137ylqJ2UaZy4gnQ=;
        b=LXeb4YZMc2N+rZ7w1Cv1CInM2v0vHkIf90kxcKuzBYsQ5Q+QvP+LvdBY/dzHBWR+W2
         KmE7g8KJLpXst3n6y6kF94pSvZnHc3O0RN4D7nvWkmDn4wOD56XZkvuXyuExZmn10snK
         pAJfbmTEMFo0LPRxGqi4Cd68cQWfUGMUaPion8WaPk+f9O/u7Gi/QEOE2jYLwFhnm57M
         yJ3aQbiP0treX8bS8sCoHdLEg5qBZ3Tpnjh/oASnE7oP9PrN1KTrt1aocizaENa1wyaK
         wepjgEDD+gSAC23x710gccGbwIEW6EiAiAl3JumOi3K8BBzkf6YsEAOeGEjjlOh6DtXh
         KUwA==
X-Gm-Message-State: AOJu0YxLTAH8Upf7k8a8sxQiHbto9JXUYiQH7hWdqjgIaCuea3r1BPe5
	l6r/ZV/+AvDTlOoG9sLkaJXLpL198DSP3rx7/lSxCEE1tLx+iOHd
X-Google-Smtp-Source: AGHT+IGSclE64sWk+7Oyv/HvYs2KBmxfpimR9p8BOL53gv2jAN2eIR9vSoXdZY/04GL9fkYmy6UUhQ==
X-Received: by 2002:a2e:a589:0:b0:2fb:3df8:6a8c with SMTP id 38308e7fff4ca-2fedb7c9c38mr157578691fa.23.1730924473564;
        Wed, 06 Nov 2024 12:21:13 -0800 (PST)
Received: from ?IPV6:2a02:3100:a488:4700:cc12:ac39:a3b8:6ff6? (dynamic-2a02-3100-a488-4700-cc12-ac39-a3b8-6ff6.310.pool.telefonica.de. [2a02:3100:a488:4700:cc12:ac39:a3b8:6ff6])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9eb16dbd38sm327739766b.73.2024.11.06.12.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 12:21:12 -0800 (PST)
Message-ID: <02bd7c39-7413-4433-bafc-a276089bd292@gmail.com>
Date: Wed, 6 Nov 2024 21:21:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 2/4] net: phy: export genphy_c45_an_config_eee_aneg
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 David Miller <davem@davemloft.net>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
References: <69d22b31-57d1-4b01-bfde-0c6a1df1e310@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 xsFNBF/0ZFUBEAC0eZyktSE7ZNO1SFXL6cQ4i4g6Ah3mOUIXSB4pCY5kQ6OLKHh0FlOD5/5/
 sY7IoIouzOjyFdFPnz4Bl3927ClT567hUJJ+SNaFEiJ9vadI6vZm2gcY4ExdIevYHWe1msJF
 MVE4yNwdS+UsPeCF/6CQQTzHc+n7DomE7fjJD5J1hOJjqz2XWe71fTvYXzxCFLwXXbBiqDC9
 dNqOe5odPsa4TsWZ09T33g5n2nzTJs4Zw8fCy8rLqix/raVsqr8fw5qM66MVtdmEljFaJ9N8
 /W56qGCp+H8Igk/F7CjlbWXiOlKHA25mPTmbVp7VlFsvsmMokr/imQr+0nXtmvYVaKEUwY2g
 86IU6RAOuA8E0J5bD/BeyZdMyVEtX1kT404UJZekFytJZrDZetwxM/cAH+1fMx4z751WJmxQ
 J7mIXSPuDfeJhRDt9sGM6aRVfXbZt+wBogxyXepmnlv9K4A13z9DVLdKLrYUiu9/5QEl6fgI
 kPaXlAZmJsQfoKbmPqCHVRYj1lpQtDM/2/BO6gHASflWUHzwmBVZbS/XRs64uJO8CB3+V3fa
 cIivllReueGCMsHh6/8wgPAyopXOWOxbLsZ291fmZqIR0L5Y6b2HvdFN1Xhc+YrQ8TKK+Z4R
 mJRDh0wNQ8Gm89g92/YkHji4jIWlp2fwzCcx5+lZCQ1XdqAiHQARAQABzSZIZWluZXIgS2Fs
 bHdlaXQgPGhrYWxsd2VpdDFAZ21haWwuY29tPsLBjgQTAQgAOBYhBGxfqY/yOyXjyjJehXLe
 ig9U8DoMBQJf9GRVAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHLeig9U8DoMSycQ
 AJbfg8HZEK0ljV4M8nvdaiNixWAufrcZ+SD8zhbxl8GispK4F3Yo+20Y3UoZ7FcIidJWUUJL
 axAOkpI/70YNhlqAPMsuudlAieeYZKjIv1WV5ucNZ3VJ7dC+dlVqQdAr1iD869FZXvy91KhJ
 wYulyCf+s4T9YgmLC6jLMBZghKIf1uhSd0NzjyCqYWbk2ZxByZHgunEShOhHPHswu3Am0ftt
 ePaYIHgZs+Vzwfjs8I7EuW/5/f5G9w1vibXxtGY/GXwgGGHRDjFM7RSprGOv4F5eMGh+NFUJ
 TU9N96PQYMwXVxnQfRXl8O6ffSVmFx4H9rovxWPKobLmqQL0WKLLVvA/aOHCcMKgfyKRcLah
 57vGC50Ga8oT2K1g0AhKGkyJo7lGXkMu5yEs0m9O+btqAB261/E3DRxfI1P/tvDZpLJKtq35
 dXsj6sjvhgX7VxXhY1wE54uqLLHY3UZQlmH3QF5t80MS7/KhxB1pO1Cpcmkt9hgyzH8+5org
 +9wWxGUtJWNP7CppY+qvv3SZtKJMKsxqk5coBGwNkMms56z4qfJm2PUtJQGjA65XWdzQACib
 2iaDQoBqGZfXRdPT0tC1H5kUJuOX4ll1hI/HBMEFCcO8++Bl2wcrUsAxLzGvhINVJX2DAQaF
 aNetToazkCnzubKfBOyiTqFJ0b63c5dqziAgzsFNBF/0ZFUBEADF8UEZmKDl1w/UxvjeyAeX
 kghYkY3bkK6gcIYXdLRfJw12GbvMioSguvVzASVHG8h7NbNjk1yur6AONfbUpXKSNZ0skV8V
 fG+ppbaY+zQofsSMoj5gP0amwbwvPzVqZCYJai81VobefTX2MZM2Mg/ThBVtGyzV3NeCpnBa
 8AX3s9rrX2XUoCibYotbbxx9afZYUFyflOc7kEpc9uJXIdaxS2Z6MnYLHsyVjiU6tzKCiVOU
 KJevqvzPXJmy0xaOVf7mhFSNQyJTrZpLa+tvB1DQRS08CqYtIMxRrVtC0t0LFeQGly6bOngr
 ircurWJiJKbSXVstLHgWYiq3/GmCSx/82ObeLO3PftklpRj8d+kFbrvrqBgjWtMH4WtK5uN5
 1WJ71hWJfNchKRlaJ3GWy8KolCAoGsQMovn/ZEXxrGs1ndafu47yXOpuDAozoHTBGvuSXSZo
 ythk/0EAuz5IkwkhYBT1MGIAvNSn9ivE5aRnBazugy0rTRkVggHvt3/7flFHlGVGpBHxFUwb
 /a4UjJBPtIwa4tWR8B1Ma36S8Jk456k2n1id7M0LQ+eqstmp6Y+UB+pt9NX6t0Slw1NCdYTW
 gJezWTVKF7pmTdXszXGxlc9kTrVUz04PqPjnYbv5UWuDd2eyzGjrrFOsJEi8OK2d2j4FfF++
 AzOMdW09JVqejQARAQABwsF2BBgBCAAgFiEEbF+pj/I7JePKMl6Fct6KD1TwOgwFAl/0ZFUC
 GwwACgkQct6KD1TwOgxUfg//eAoYc0Vm4NrxymfcY30UjHVD0LgSvU8kUmXxil3qhFPS7KA+
 y7tgcKLHOkZkXMX5MLFcS9+SmrAjSBBV8omKoHNo+kfFx/dUAtz0lot8wNGmWb+NcHeKM1eb
 nwUMOEa1uDdfZeKef/U/2uHBceY7Gc6zPZPWgXghEyQMTH2UhLgeam8yglyO+A6RXCh+s6ak
 Wje7Vo1wGK4eYxp6pwMPJXLMsI0ii/2k3YPEJPv+yJf90MbYyQSbkTwZhrsokjQEaIfjrIk3
 rQRjTve/J62WIO28IbY/mENuGgWehRlTAbhC4BLTZ5uYS0YMQCR7v9UGMWdNWXFyrOB6PjSu
 Trn9MsPoUc8qI72mVpxEXQDLlrd2ijEWm7Nrf52YMD7hL6rXXuis7R6zY8WnnBhW0uCfhajx
 q+KuARXC0sDLztcjaS3ayXonpoCPZep2Bd5xqE4Ln8/COCslP7E92W1uf1EcdXXIrx1acg21
 H/0Z53okMykVs3a8tECPHIxnre2UxKdTbCEkjkR4V6JyplTS47oWMw3zyI7zkaadfzVFBxk2
 lo/Tny+FX1Azea3Ce7oOnRUEZtWSsUidtIjmL8YUQFZYm+JUIgfRmSpMFq8JP4VH43GXpB/S
 OCrl+/xujzvoUBFV/cHKjEQYBxo+MaiQa1U54ykM2W4DnHb1UiEf5xDkFd4=
In-Reply-To: <69d22b31-57d1-4b01-bfde-0c6a1df1e310@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

We'll use this function in bcm_config_lre_aneg(), therefore export it.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy-c45.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 6e7198794..dabd90a3c 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -951,6 +951,7 @@ int genphy_c45_an_config_eee_aneg(struct phy_device *phydev)
 
 	return genphy_c45_write_eee_adv(phydev, phydev->advertising_eee);
 }
+EXPORT_SYMBOL_GPL(genphy_c45_an_config_eee_aneg);
 
 /**
  * genphy_c45_pma_baset1_read_abilities - read supported baset1 link modes from PMA
-- 
2.47.0



