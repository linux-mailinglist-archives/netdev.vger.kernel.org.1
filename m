Return-Path: <netdev+bounces-216252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A80B32C14
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 23:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D87C7A2E9D
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 21:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB01F238150;
	Sat, 23 Aug 2025 21:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="St4g8ag3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39F3163
	for <netdev@vger.kernel.org>; Sat, 23 Aug 2025 21:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755984270; cv=none; b=Ho/BGO0rGawiwnFfjGBXljwzo1+wUP0nIuxEOSOggR4Gjl4gyetiDN0kr08X2+ch7s21dCTewvByrJ/MY5RvYuuol6BdhDX6UkzoqQTUV+83xk0G16MEmyzpLBDqE7u2kca/r3ZIP2c3TytFM6QThx4MjvTSDt0GG3FOyFjRm6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755984270; c=relaxed/simple;
	bh=OolQhCBbYzIHge1gekw+o6QWFrPV8Jf6vDokvE7RsqE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=HHV1CkjNfh9kyiNyOX2uSk+w+gPPUVKtGlFce1jW/B0t+m6HbxY0Fn+ZLXrw7ENFFHCNlImo9c3qlurTuzsH/qWUBURNFCqgvz4jx5MOC/WCHjMvL8E7evN9a+0JmXMjZhEu0UPQYBhCF5uEEOng1a866WCLW1oKyYQmbDw8bKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=St4g8ag3; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3c607029266so1115752f8f.3
        for <netdev@vger.kernel.org>; Sat, 23 Aug 2025 14:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755984267; x=1756589067; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i39Hwgy6X8n5LrdE8ty+KQK0Z+u31EIGd47XWIyPhy4=;
        b=St4g8ag39Md7lCU0pxx18XngXD1WRGerpV12gt+FByl3P2BnMRvwTDiica498I58rL
         DvMO3pzFIb4MpswmyNlj7bAyr52TkX3ghWrBzFdZwKkIXKIuISX5suEGl8lrK0dbOcHM
         UR2VfFNl5JanReoG6d8scZ3EJQvareOXH7TrcxeLMt1igdMJESaLt+2BvFvTy1CMZmPa
         7gR8UMuMMFKZwYpcMXM9GR9pZ50jQ04mWSavNueLVYIIwsk3g4x7KpzhCezbgb9TPz0W
         P2KY8umOQ7nDDkl5JnMvYxwWqUD9nYhysZDukLLLvl4gd8sR70HmnMk4yosVRLkBkYl9
         mR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755984267; x=1756589067;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i39Hwgy6X8n5LrdE8ty+KQK0Z+u31EIGd47XWIyPhy4=;
        b=QYWkK0XOcRPStinMWw9fuIeBjENkYHZSMoxRjrvsV+ez8aodBoltJZN/Bl00I3cGYW
         CJ+YuEkoCbJqfdWpPHjwhE69TFyM2LzobDPwEO6Td+kI2xvfzQX9B7zNj0jASYYGaAkn
         7bWE7njhbue7Tiobsif3lCwHUeSx+58aA2Uvs8USUw+7BLoEs8mwstf2l34qCKRJr/Ui
         oBE/NTJ5rzEHj/4nxU/vJVXAU8kA9/kUDdkKo2JbQEnfJf83uF87VvAqnX7DJ4iWGf9j
         KOBoV7kgaMHaFTdk+4WEX2fS5dkFTQztUO7gwtXYFYZbwP9mriwiiEDX6uQgczej3ZoP
         4Byg==
X-Gm-Message-State: AOJu0Yzsh2tAZYGsGRqknYUf3wvKHaf42lYvFOe8P+eAg7qayRm9+40l
	EcnXb7mZEArj8RWDl6wD7a1wCazzVuNJKCrfa4XGZa3uZc8uICD+oJu/
X-Gm-Gg: ASbGncuiMOM5xbpCZHwO/k2wh/tPc/49qWSXkI6k9B0I8DW2aadWFq468xnolQriTFL
	Z7eooKmeoPkyPmwf93XdOgIroRe1+GwQSXl/5KrXGLqtM8x67MgIR6FObGzoimz244gxE7drRqp
	zQ7zLsussjcu/oGrm/BJP3SR3JGOu4PzV4Ck9B98q4MQgrb/0Aqj1b6lHI6dn7iVqQTj2jUS9M5
	Acet5igwGeNwr8Wl4uJZXELXM7537q0PjNLxSb3a/JxdX7D1Nsa5tZnPd9xSBIryDxrD3BTb2EZ
	OaxelEufoZtH4NEchrog9EMpmlmFDvtnt2zZhZv3w49m3pDQV+BhXs5mMRGWQti1J1voh+1Ogvr
	eqI2jcUSHTvr7QNAIVy17UJnDimb2zuZeyarXqH8zFLZ4VO/MiqB5VHw19zaNed6ALW+qw2SVfW
	MA+QtAhvl0gNUAbzlH8pshPCqNSPATkgZc5jXZKeCGLHJtGO9JZdgOFYELYfOJMg==
X-Google-Smtp-Source: AGHT+IFzEKFDZpsts7+WPVpduDAU5cRY9kqNnRJRY+JkBQqQNxvwBNldXPtbMfbg1dNDwwbSEOZbAw==
X-Received: by 2002:a05:6000:200e:b0:3c8:5b40:deb0 with SMTP id ffacd0b85a97d-3c85b40e862mr363616f8f.7.1755984267032;
        Sat, 23 Aug 2025 14:24:27 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f4b:8600:38e5:cfba:e2a6:edb9? (p200300ea8f4b860038e5cfbae2a6edb9.dip0.t-ipconnect.de. [2003:ea:8f4b:8600:38e5:cfba:e2a6:edb9])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3c712178161sm4888335f8f.67.2025.08.23.14.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Aug 2025 14:24:26 -0700 (PDT)
Message-ID: <ad8dda9a-10ed-4060-916b-3f13bdbb899d@gmail.com>
Date: Sat, 23 Aug 2025 23:25:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: fixed_phy: let fixed_phy_unregister free
 the phy_device
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

fixed_phy_register() creates and registers the phy_device. To be
symmetric, we should not only unregister, but also free the phy_device
in fixed_phy_unregister(). This allows to simplify code in users.

Note wrt of_phy_deregister_fixed_link():
put_device(&phydev->mdio.dev) and phy_device_free(phydev) are identical.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/dsa/dsa_loop.c  | 9 +++------
 drivers/net/mdio/of_mdio.c  | 1 -
 drivers/net/phy/fixed_phy.c | 1 +
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/dsa_loop.c b/drivers/net/dsa/dsa_loop.c
index d8a35f25a..ad907287a 100644
--- a/drivers/net/dsa/dsa_loop.c
+++ b/drivers/net/dsa/dsa_loop.c
@@ -386,13 +386,10 @@ static struct mdio_driver dsa_loop_drv = {
 
 static void dsa_loop_phydevs_unregister(void)
 {
-	unsigned int i;
-
-	for (i = 0; i < NUM_FIXED_PHYS; i++)
-		if (!IS_ERR(phydevs[i])) {
+	for (int i = 0; i < NUM_FIXED_PHYS; i++) {
+		if (!IS_ERR(phydevs[i]))
 			fixed_phy_unregister(phydevs[i]);
-			phy_device_free(phydevs[i]);
-		}
+	}
 }
 
 static int __init dsa_loop_init(void)
diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
index 98f667b12..d8ca63ed8 100644
--- a/drivers/net/mdio/of_mdio.c
+++ b/drivers/net/mdio/of_mdio.c
@@ -473,6 +473,5 @@ void of_phy_deregister_fixed_link(struct device_node *np)
 	fixed_phy_unregister(phydev);
 
 	put_device(&phydev->mdio.dev);	/* of_phy_find_device() */
-	phy_device_free(phydev);	/* fixed_phy_register() */
 }
 EXPORT_SYMBOL(of_phy_deregister_fixed_link);
diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index 1af05afb0..99621239a 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -304,6 +304,7 @@ void fixed_phy_unregister(struct phy_device *phy)
 	phy_device_remove(phy);
 	of_node_put(phy->mdio.dev.of_node);
 	fixed_phy_del(phy->mdio.addr);
+	phy_device_free(phy);
 }
 EXPORT_SYMBOL_GPL(fixed_phy_unregister);
 
-- 
2.50.1


