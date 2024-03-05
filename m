Return-Path: <netdev+bounces-77673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A6A872964
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 22:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF99280A51
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 21:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5574E5A796;
	Tue,  5 Mar 2024 21:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAhL//2c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13DF26AD0
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 21:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709673975; cv=none; b=e2ZVwe/Gv6A7smN1SD9kIXIgSmj9HsqikuY3qJOLElIT/3T0iak22bTOJhNvlEwYE0sshTtoo8KsUN65hpbFCWNdut8RpBj5Ca1gfE5KTvz9mxbH97ikHENBMZ9dn7mtSa1/v80UQKIEcz/rfBbkoOj6IVifCx693qU/5+HVY+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709673975; c=relaxed/simple;
	bh=6J+M1Vt4/euRyyEeH2CDB5hHZsqmip58I4BeHbYLq8w=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=PsnEhG2HSVPc9RbIEuT3zfDEDJlDtGOospXbPvfDK1bsBmoKJwZyJw33xZ9UtoiADpYSkLPp/Gps2CqkdLTd1zmLENbwXvdKp6uo28au2ipHSyBsqbp/ZjL4CcH4fEpAr9+ei5kl+ikouykB+Fdqzx7LyWMDozTP5i+Ro5rzh/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAhL//2c; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-564fd9eea75so1572092a12.3
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 13:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709673972; x=1710278772; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7fyjoL43XiEDndMp8Vw7cMgdtJXn3czUIO3aRdLu0Q=;
        b=YAhL//2cyesMex/q7IThhoJrl3b2NUWDb2e6LNmHGr4E6h4hHzZZXewuo6JneKtmck
         UjC3XRLoXYzwbbE+4mGoZvr65oLlxDBW0VAkGN8tyEZaA8yA2145NQe1Z4On1OecOmOE
         MRSsKNc+fzwx4CkIa5DZN+C+0+flgaHIzyO7QO0tF+65UOPxk/5ILK9oiFK7oQ6Fxn7k
         QTbXoPOYQN3bkFaARKJppfX0nRXyeEyox5/ajtAwD61QAOZ4+56B8xN/B0k4wP1P/hBo
         077ZffPALpybrN4sokHhsMBBTGtMFhvdQXVhjidpIJXowcIkuxZbu9pT8MfhQhTSYGVU
         pmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709673972; x=1710278772;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7fyjoL43XiEDndMp8Vw7cMgdtJXn3czUIO3aRdLu0Q=;
        b=cP9x9/xCzkcVR4VhZt5atHxoXf7JA+up26TvMkcnqEDwpKxgvs2YjUfCblDYIqy3VA
         YCY6LrbuNl6azuBXOBFb3prigKBviwTpmKSH7jED+JxTaqtnTo4ap73Izev+7icSuVgP
         lVH/nzCrew8NmVStOWwuaaT2QrZgTpvlQKTvCSp0aSN9OUbic8HEM+/6GjchaRQdPSP+
         AJ/fHPfe2OUqYWhJE5YrxdK+ApC2ZSnZamkYm/0sRbPV/o+AgvsvHYhhD+LeiZNo4uis
         tusi93mMyKCRUUXMwfw57ChRpHqS2r10c289LQFMdGSYMDZ7J15KCd2j1NU81363AXxL
         bwRg==
X-Gm-Message-State: AOJu0YzbI5Rato9a6kK7sda2QFwnAfv927ca/XlCIavq2vlrmafZEAY7
	gcJev0xQVV3X/jKiPnaSqgFn/ZXZzowgwCzwd/YeqQdKHf+wfLbj
X-Google-Smtp-Source: AGHT+IERPmB1aM7AgoGT6C3p5bcf0CpvoCpRbTJ+qIayoGnzjrK4HFTTtSHnWi2kE7ETM5s72upsqg==
X-Received: by 2002:a05:6402:510d:b0:567:1b50:559c with SMTP id m13-20020a056402510d00b005671b50559cmr7851550edd.39.1709673971832;
        Tue, 05 Mar 2024 13:26:11 -0800 (PST)
Received: from ?IPV6:2a01:c22:724c:8900:6035:9a03:530d:5671? (dynamic-2a01-0c22-724c-8900-6035-9a03-530d-5671.c22.pool.telefonica.de. [2a01:c22:724c:8900:6035:9a03:530d:5671])
        by smtp.googlemail.com with ESMTPSA id n6-20020aa7c686000000b0056711540692sm3986949edq.79.2024.03.05.13.26.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 13:26:11 -0800 (PST)
Message-ID: <b4ff9b51-092b-4d44-bfce-c95342a05b51@gmail.com>
Date: Tue, 5 Mar 2024 22:26:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] ethtool: remove ethtool_eee_use_linkmodes
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

After 292fac464b01 ("net: ethtool: eee: Remove legacy _u32 from keee")
this function has no user any longer.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 net/ethtool/common.c | 5 -----
 net/ethtool/common.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index ce486cec3..6b2a360dc 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -712,8 +712,3 @@ ethtool_forced_speed_maps_init(struct ethtool_forced_speed_map *maps, u32 size)
 	}
 }
 EXPORT_SYMBOL_GPL(ethtool_forced_speed_maps_init);
-
-bool ethtool_eee_use_linkmodes(const struct ethtool_keee *eee)
-{
-	return !linkmode_empty(eee->supported);
-}
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index 0f2b5f7ea..28b8aaaf9 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -55,6 +55,5 @@ int ethtool_get_module_eeprom_call(struct net_device *dev,
 				   struct ethtool_eeprom *ee, u8 *data);
 
 bool __ethtool_dev_mm_supported(struct net_device *dev);
-bool ethtool_eee_use_linkmodes(const struct ethtool_keee *eee);
 
 #endif /* _ETHTOOL_COMMON_H */
-- 
2.44.0


