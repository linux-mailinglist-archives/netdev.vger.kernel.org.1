Return-Path: <netdev+bounces-165281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DA1A316DC
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 21:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87F927A3450
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 20:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2687D1E500C;
	Tue, 11 Feb 2025 20:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzZKUvni"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5646A1D88CA
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 20:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739306883; cv=none; b=aKqG8tkTuvz1So1OgdTvEXs+k9LshBrlsZOB59T3RHlbcXJ6ouwt81a52ddO82It5okIIw2iJlLBfGzgGCjHoC20B4R024UHYik7Zq5j0BfOR/7QnRQ9U8v88FEJq+UCKaxvrIpmzeOtZtE1zY7MbqkVO19FQZggPsjb2+7DXho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739306883; c=relaxed/simple;
	bh=QTU62o/zENQg3xNxG18PrOj1MnZ3oFKBgOBr32s7gI8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=tdB5N+dsg/Kxj1DJ6ipKZ5nYmQAO/2rOmsWGxd/gqMzzbSSJE/wrhNBY9UrDhIWe9njXfXQ7PCCMYdUKRb35+c1ZjBow1THzPinzuuZHRjwXppPh65hWxeodR1rsWl5/BDGQ8poBoJoYBjhVEaCvhmANJyYoNL3JCXgSNZlncus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzZKUvni; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5deae16ab51so232171a12.1
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 12:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739306880; x=1739911680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAK8K5yoxiXV/qu7tyyE7ZLxu0E5RX/SOEKUCDvQPu8=;
        b=mzZKUvni20ZZiyn5e7dfI0nLSAkiiA8qyAeClvOXmXRn70paG3LzuW0Q9cKIzx86uV
         TEW8Ys51mSqBmY9kK4O1F7nzclg+Gju44y2dnnbZj0UF0qQqUzy6nw14bEdDN9OFg7dv
         e0iyqblDm58eT3cebJIsEvWeaZfo/C5kAdXLH7dQuWE10EXlNU6y87lRVDQaFibEhZG8
         MPVuNkG6Qgp6wM7MakSJhCB+7VTmc5RiWEYxaKw6pdmOdj96rp/Y4qjhEj8l2bMXI0WT
         JlCHt22hNaKkyobBk/FL1Fv751e5Itysrra2xjRk8dlP5OWWSkb3BCKYPOWmfuKqCrRA
         jY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739306880; x=1739911680;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BAK8K5yoxiXV/qu7tyyE7ZLxu0E5RX/SOEKUCDvQPu8=;
        b=uWMNSZDN/titeTDW9E4lgjz+BvBwKPj/p/Epy9Q9Oi0fJg3ME+jNXBUyfBxkOmlSEa
         7brDpiGBJ2e8yoT9MznxRDCdoooP9EvzFM+n+Zc7Jnf5bViunLRwBuAqpO8Da4VvMeuC
         8HeSywCQhh4mxjdWWXQiiK95ZxIXnW1ABC3R5te7FGvhOWYp1Wnr4lBzKI3wTN1ZMjZP
         RLMRYsNw1A1sj7Q0GnZSJ+bq5jbX2WQ6ggPVVPWKuObM9Ann3K3myvQCIhEJu7uVLB4v
         zV8ahRQobHjT6VgT0hkAVBhiaPEZ9KP8WRODUzoIr9vc0gwEXXDuEJtiN1hIudkobeRS
         4etg==
X-Gm-Message-State: AOJu0Yy1aNRMm9J+Em8PgwljLEDuFonjUwpxVHdzwTw51oOPI1g+b0sy
	6IrKH47Qg4fSBUFwaIlRIRZvzVMUWar3KIR5ycj1f5n3dSbtHhZh
X-Gm-Gg: ASbGncuEq+/rATbo2j2PTteR77wBhIUAiWgfvAeZIO8+yz0RxsGKRPdoKGqRbUY/fse
	JHKFxIRmvlIXt3KGDcwg9bPN6IPGIuwwEPRtqGGAmoeCmsnblieL5FvFWZ/migp9yT4h/UmZXq3
	bNnkG66bmBzm6tqwyDw2qQP0c7O9x14JLOeIj74i3DPmiQooiqQLjWZvJMgFh+7NdvrHUPjilcZ
	9Fiev5GB43Az3k568C1fo8xLwKOa4UEvRwoD7UuIBbGPc96ZIYFIvhlSLrJGPeQFv3BedADBhgA
	2Ys5ezJlFUVMueNNKAOKdoBTof+/5DKwX+k3Sl/GmmRPXl6dVjZlR/Cwcn7HL6JdbpIrfZl351a
	bO2/+VFZZICU7NBYnH+VTLqokzhVTJT20eeCBEvsGMWv+/gN/vsoQhuM4fYVBJjbEYYDMXw/xov
	UAew==
X-Google-Smtp-Source: AGHT+IF5XvQ2hecjYiLGkgU4Bv9e5TKhbGvNm2MKMhw9Xma3T0bnaRoh6qOMqANOnf1xbVWLooBtFg==
X-Received: by 2002:a05:6402:50ca:b0:5dc:71f6:9725 with SMTP id 4fb4d7f45d1cf-5deadde6803mr1126599a12.27.1739306879461;
        Tue, 11 Feb 2025 12:47:59 -0800 (PST)
Received: from ?IPV6:2a02:3100:9c22:7900:117:959a:c87:dae7? (dynamic-2a02-3100-9c22-7900-0117-959a-0c87-dae7.310.pool.telefonica.de. [2a02:3100:9c22:7900:117:959a:c87:dae7])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab7cf027239sm335485266b.181.2025.02.11.12.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 12:47:59 -0800 (PST)
Message-ID: <ad4b5c29-abbc-450c-bada-5f671c287325@gmail.com>
Date: Tue, 11 Feb 2025 21:48:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] ixgene-v2: prepare for phylib stop exporting
 phy_10_100_features_array
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
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Iyappan Subramanian <iyappan@os.amperecomputing.com>,
 Keyur Chudgar <keyur@os.amperecomputing.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

As part of phylib cleanup we plan to stop exporting the feature arrays.
So explicitly remove the modes not supported by the MAC. The media type
bits don't have any impact on kernel behavior, so don't touch them.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/apm/xgene-v2/mdio.c   | 24 +++++++++++-----------
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/apm/xgene-v2/mdio.c b/drivers/net/ethernet/apm/xgene-v2/mdio.c
index eba06831a..b41f15501 100644
--- a/drivers/net/ethernet/apm/xgene-v2/mdio.c
+++ b/drivers/net/ethernet/apm/xgene-v2/mdio.c
@@ -97,7 +97,6 @@ void xge_mdio_remove(struct net_device *ndev)
 
 int xge_mdio_config(struct net_device *ndev)
 {
-	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = { 0, };
 	struct xge_pdata *pdata = netdev_priv(ndev);
 	struct device *dev = &pdata->pdev->dev;
 	struct mii_bus *mdio_bus;
@@ -137,17 +136,18 @@ int xge_mdio_config(struct net_device *ndev)
 		goto err;
 	}
 
-	linkmode_set_bit_array(phy_10_100_features_array,
-			       ARRAY_SIZE(phy_10_100_features_array),
-			       mask);
-	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT, mask);
-	linkmode_set_bit(ETHTOOL_LINK_MODE_AUI_BIT, mask);
-	linkmode_set_bit(ETHTOOL_LINK_MODE_MII_BIT, mask);
-	linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, mask);
-	linkmode_set_bit(ETHTOOL_LINK_MODE_BNC_BIT, mask);
-
-	linkmode_andnot(phydev->supported, phydev->supported, mask);
-	linkmode_copy(phydev->advertising, phydev->supported);
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT,
+			   phydev->supported);
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT,
+			   phydev->supported);
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+			   phydev->supported);
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT,
+			   phydev->supported);
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
+			   phydev->supported);
+
+	phy_advertise_supported(phydev);
 	pdata->phy_speed = SPEED_UNKNOWN;
 
 	return 0;
-- 
2.48.1


