Return-Path: <netdev+bounces-165843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0736AA33832
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 07:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4A5716560C
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 06:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BB12063E8;
	Thu, 13 Feb 2025 06:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Avqyc1Zz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2C9EADC
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 06:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739429335; cv=none; b=adVIy7X1w0W5/CjQOCSugT33dRTm0c0a5itornqpCryi3nBYsPJl4BN9I0qEbli6hvju0VLdIQzzp/QArSx/BNe9Jqk7FYVtgnmkSXi1HaKjNuKGFnlRzaOJ6k2yV2I88f93I5J9Yrv21+7O7R3HZgWtM7UONJWiWuzHjfXXOHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739429335; c=relaxed/simple;
	bh=WqSRDDj7nKkOQBn6KDHP5G9I83gJmbChi8HBlZ3RCfQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aWJyGHnr71sz9AYlQgbKUGtCStbOXGwQviWuS+VdEk4QtTfELg3KsyO3YkCbS/9ZspPTJL7PnwLVOBUcaeUxV/DHUHVDrGh/Dv7O/mAbjZ+gfJFdgtTVxJjjr363VuaRCD3gDFghd0tVVrDaxb/Zp4xeDBaggKO6WhXDQVRGTEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Avqyc1Zz; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so3211845e9.0
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 22:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739429331; x=1740034131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5GOBmK440jSShtptm2olJKERMbxrhMSZzu1vS9A/f+k=;
        b=Avqyc1ZzpmaZUq/zobSaR8lwnJS4LVr1G3KB6DAsLK2R+w45AIpPPqigPG1XApMTxH
         MH/t8vdw7p2t+MrauZKItC6QLEJ6X3T5LbsO8yVzSRjlPdZi/jdWZmGlYn3XaxVjDE9S
         yweEeqmeUlKtWAbFS6iQSARgnqgr6FFfgsm1/DXrgckYvBg8BiFuzDwkxJCRO2RTiola
         NHTj5F/OR6fL290GXwlaQ8/6KRUUCDxAApv3Y4do8VMsv3nnfvqBjAmt1A/vqVZ5Tefp
         XvqM09tJkEWvVMgLcQ99cuGHSyat/E12hSq2eoz5pF6ydlh6qurOkwBfizgme/7juvfC
         fSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739429331; x=1740034131;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5GOBmK440jSShtptm2olJKERMbxrhMSZzu1vS9A/f+k=;
        b=T4vFrniUdwuWrqNC3DFWR+wZdWfRev2rBntvFOIDPBA2wQhwYmqUk+wzl9zY2O0UKG
         OVy3m3BA2ZF5hv3yu157LS75bBHjj3f1VHdv9Z1clTZ/NTXnSkZI4/maQCzV+NbQyg/0
         Tbx/hazkjjYEMQ+uYjPV5kpYJkj3Oq+3Le1L8Tt6WjJ1Squf/13uOwxf1QWpY6g5Zujd
         KPA/6VBczpWuxda7jdo0IZNLWpAtp/2rAX6D8StwJd4wkv0x2Cc76Zr6BOtdQt2QVj+7
         2IOcP/zYfPe6gZdoq+deLHcO2IwzbJZgzfEZaXqUviKdl/kg3R+yoEshadN4YxQzLMIB
         N5HA==
X-Gm-Message-State: AOJu0Yzpo5W7uyzY1dPk0GfWbm9FXjpq3Dw8ffw/AmRuB/qW8GcliAKH
	AZPOguY8/EuDC+5eGiIP4I7QWl/ji18Ic4R8oM0nzjPAQzsPyvAu
X-Gm-Gg: ASbGnct6xSkundw7jNc6llljBpGaZNl/fH+fi+JpD2nR0Qt3dPeqVR4a3AIISDHekdF
	dM5IPHfZrxqb8VUNf8lO3nUbOZncqKfBZy79eZXS+ub9sxSqASUGNYpb0KVSwDTA+3t/lyTqTd8
	/gEL2WT9suwoHHm5+jcbax7mLvAA+sLI2RMfskiq41vwUyNwxNY3bRsqb/t/DgPJixO0VWU9lmF
	J4WWeVflkBFL3ZbVlpWKAG6TgMb0zIsMcOr4734pywJe/WKZRTuk89Yqwpz/Prj2cPtCis33rdG
	cT9abctIkxqbFi3Ff+gfoyDpkPh5xgFI6Y4NZOhRa36dLRR7/6dHTM6XpRBZXRswA32OM0mwnSD
	TQ8uQ7u2QPUzrf0QZuri4wXUUof2tPDr+EzuOnI6XMl7DidqQutSanQ6BlTiES7BLmMIzcja9OO
	eMV8NO
X-Google-Smtp-Source: AGHT+IF5ZmLM+5HufihAW5hynOvYesdcHN/yzUlOz/QRMKdXlr1FtvQjWJXSrh25M84Y8iwjJC6Eqw==
X-Received: by 2002:a5d:6483:0:b0:38d:df83:7142 with SMTP id ffacd0b85a97d-38dea26f276mr4966981f8f.22.1739429331420;
        Wed, 12 Feb 2025 22:48:51 -0800 (PST)
Received: from ?IPV6:2a02:3100:9dea:b00:8068:750d:197f:b741? (dynamic-2a02-3100-9dea-0b00-8068-750d-197f-b741.310.pool.telefonica.de. [2a02:3100:9dea:b00:8068:750d:197f:b741])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38f259d8e62sm958360f8f.71.2025.02.12.22.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 22:48:50 -0800 (PST)
Message-ID: <fa252e7d-b4de-4734-9224-a0924a17e198@gmail.com>
Date: Thu, 13 Feb 2025 07:49:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/3] r8169: add PHY c45 ops for MDIO_MMD_VEND2
 registers
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <ca05b98a-5830-4637-be72-c11d7418647a@gmail.com>
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
In-Reply-To: <ca05b98a-5830-4637-be72-c11d7418647a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The integrated PHYs on chip versions from RTL8168g allow to address
MDIO_MMD_VEND2 registers. All c22 standard registers are mapped to
MDIO_MMD_VEND2 registers. So far the paging mechanism is used to
address PHY registers. Add support for c45 ops to address MDIO_MMD_VEND2
registers directly, w/o the paging.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 33 +++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 9fe53322d..e7a041bec 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5200,6 +5200,34 @@ static int r8169_mdio_write_reg(struct mii_bus *mii_bus, int phyaddr,
 	return 0;
 }
 
+static int r8169_mdio_read_reg_c45(struct mii_bus *mii_bus, int addr,
+				   int devnum, int regnum)
+{
+	struct rtl8169_private *tp = mii_bus->priv;
+
+	if (addr > 0)
+		return -ENODEV;
+
+	if (devnum == MDIO_MMD_VEND2 && regnum > MDIO_STAT2 )
+		return r8168_phy_ocp_read(tp, regnum);
+
+	return 0;
+}
+
+static int r8169_mdio_write_reg_c45(struct mii_bus *mii_bus, int addr,
+				    int devnum, int regnum, u16 val)
+{
+	struct rtl8169_private *tp = mii_bus->priv;
+
+	if (addr > 0)
+		return -ENODEV;
+
+	if (devnum == MDIO_MMD_VEND2 && regnum > MDIO_STAT2 )
+		r8168_phy_ocp_write(tp, regnum, val);
+
+	return 0;
+}
+
 static int r8169_mdio_register(struct rtl8169_private *tp)
 {
 	struct pci_dev *pdev = tp->pci_dev;
@@ -5230,6 +5258,11 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 	new_bus->read = r8169_mdio_read_reg;
 	new_bus->write = r8169_mdio_write_reg;
 
+	if (tp->mac_version >= RTL_GIGA_MAC_VER_40) {
+		new_bus->read_c45 = r8169_mdio_read_reg_c45;
+		new_bus->write_c45 = r8169_mdio_write_reg_c45;
+	}
+
 	ret = devm_mdiobus_register(&pdev->dev, new_bus);
 	if (ret)
 		return ret;
-- 
2.48.1



