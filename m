Return-Path: <netdev+bounces-134173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0E6998442
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 12:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB205284C4D
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 10:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5D61BF324;
	Thu, 10 Oct 2024 10:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/MXbUR5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26A729AF
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 10:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728557885; cv=none; b=DsUp/CooKGWm85WUnl8laSqlDZGuvtARYMbKmEVQOMKBq+sr1MSvmnungBpEMHf5jhm60S1gOoWBlZoWxKPO75vNEAxZAVej1u6Eq1jt7ryU8grFIOnoKXdRmYt+w6B+y7WkDcEd9/asUY2gH6tN8SAB877VGgPGPQ7uSJUgkJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728557885; c=relaxed/simple;
	bh=9ndun63FZe2W35sk64rpbH8SmlxyRke2tFC4xIiKkVg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=q6nCFMMVrU42r3uhB7REGR9TCM8SS0XRTHo9jN983TH7gPeEAzcqTKMf24zWC8nLAqiuUg6BzCpru+WDdvC62yEXYnqH/bGhg/2tDiKRd64nahdQM9NFOLTGu/xeQEovYmWOg6/OWolHuHMwlCe8S7sPVCEc7A+htxUz+swsKAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/MXbUR5; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c896b9b3e1so994889a12.2
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 03:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728557882; x=1729162682; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PSRsp96rY/fBmBfMonZ4ztnLfuWmgFUVytYXyUFlQ9w=;
        b=j/MXbUR5/nFOxMV2iNcsBuxHr2zq4QrPY8ibOZAFQTxOc/hZIbAnvCYwJWAzuU4EUh
         Z02KdSs6YtLNxiyTLxjKsuQyjIm+njn4Frk892+Zj6ELNDlQ720JgWQGkeZ99YzZjuXn
         MGHqR86ZT2uEVtEnmrfOXwJEwHzKW7flsO+GGbqJ3gu8kQ/t6uJLoTrPa5L+uyfaetKi
         JgebF1+h7pf8NrIjvG7BxpmTQkMx5mgseBLcD8LG9ZTshT9YA+2fVQWgsL+feXKK62em
         9pDhKR1JPtaCnjn0LrK9X/B40Ho66/HODwszVUA0VPBeqk0qN+HeqH07tXiYSQz3DA1U
         VrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728557882; x=1729162682;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PSRsp96rY/fBmBfMonZ4ztnLfuWmgFUVytYXyUFlQ9w=;
        b=AdIMHnfSNPRhaWwwTdBYkm4NfhlsGvg+PRyitl9GAxKxltzrsYMGb//T7Jid8ubBqQ
         HI4agi/Qfxic0OyoKijNuPE3HBQd7cJoKMDfQlgFdQCOdVr0Gs2vXRoSglnNwAPRc9Sj
         y7/LSDB9TxKvOb6g3qCSOHpOzq3B1Avvt+IKP/xRta5gCVohVTMlj7zIE954XgHzrZxm
         JdTzl/0MR5OhuAqn3eSxvgx+mybRCJVcWbOwFy0hExQINXbgT0wZTg//eujRsvX2g2Tr
         ktjfp908A4Xsp25PAbFbiEX15ZZqdwu5xBuXFb8oRywxMNbQcTXwjbugLJWgQFz2eAT1
         uAWQ==
X-Gm-Message-State: AOJu0YylUuoTz4EQfq1aGlyJ8Xqx5+bWv2fQrdV93jkEvcuosOZWf3cK
	6V8PiKGPWvhadrO1xUWrUkaGlleQ14jzvkadjB6JhTf9Bog9F/1P
X-Google-Smtp-Source: AGHT+IFcZeX/uwkx5xWaNTNzeboiJK9hPvP27ZjynFQb5THvADKN0DPJBXkWEM0Q9XRqqUWTKI5wHw==
X-Received: by 2002:a05:6402:518f:b0:5c7:1ed7:8825 with SMTP id 4fb4d7f45d1cf-5c91d5817c6mr4613658a12.12.1728557881929;
        Thu, 10 Oct 2024 03:58:01 -0700 (PDT)
Received: from ?IPV6:2a02:3100:ac3e:8500:3069:9e6c:9f68:56f8? (dynamic-2a02-3100-ac3e-8500-3069-9e6c-9f68-56f8.310.pool.telefonica.de. [2a02:3100:ac3e:8500:3069:9e6c:9f68:56f8])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c9370d218asm622828a12.8.2024.10.10.03.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 03:58:01 -0700 (PDT)
Message-ID: <5daec1ce-1956-4ed2-b2ad-9ac05627ae8f@gmail.com>
Date: Thu, 10 Oct 2024 12:58:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: enable SG/TSO on selected chip versions per
 default
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Due to problem reports in the past SG and TSO/TSO6 are disabled per
default. It's not fully clear which chip versions are affected, so we
may impact also users of unaffected chip versions, unless they know
how to use ethtool for enabling SG/TSO/TSO6.
Vendor drivers r8168/r8125 enable SG/TSO/TSO6 for selected chip
versions per default, I'd interpret this as confirmation that these
chip versions are unaffected. So let's do the same here.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 71339910b..d90c11356 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5567,11 +5567,6 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	dev->features |= dev->hw_features;
 
-	/* There has been a number of reports that using SG/TSO results in
-	 * tx timeouts. However for a lot of people SG/TSO works fine.
-	 * Therefore disable both features by default, but allow users to
-	 * enable them. Use at own risk!
-	 */
 	if (rtl_chip_supports_csum_v2(tp)) {
 		dev->hw_features |= NETIF_F_SG | NETIF_F_TSO | NETIF_F_TSO6;
 		netif_set_tso_max_size(dev, RTL_GSO_MAX_SIZE_V2);
@@ -5582,6 +5577,17 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		netif_set_tso_max_segs(dev, RTL_GSO_MAX_SEGS_V1);
 	}
 
+	/* There has been a number of reports that using SG/TSO results in
+	 * tx timeouts. However for a lot of people SG/TSO works fine.
+	 * It's not fully clear which chip versions are affected. Vendor
+	 * drivers enable SG/TSO for certain chip versions per default,
+	 * let's mimic this here. On other chip versions users can
+	 * use ethtool to enable SG/TSO, use at own risk!
+	 */
+	if (tp->mac_version >= RTL_GIGA_MAC_VER_46 &&
+	    tp->mac_version != RTL_GIGA_MAC_VER_61)
+		dev->features |= dev->hw_features;
+
 	dev->hw_features |= NETIF_F_RXALL;
 	dev->hw_features |= NETIF_F_RXFCS;
 
-- 
2.47.0


