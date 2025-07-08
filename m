Return-Path: <netdev+bounces-204865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3323AFC53D
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 10:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D973A8716
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 08:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFCF29B79B;
	Tue,  8 Jul 2025 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="vn3k+Hm5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C5118024
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 08:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751962617; cv=none; b=csxcHVG/muR9omRfSek8Bx1IuqKlPLD8MsyAQ6aC8NwmQDCyJOKaftcx2hgTfD4T6Cl0vtLlWn4TW4DHCb59stQkzariRBlDvlarltEOf9xtc6iKsOUICF27uufGlI8cyfHwRDOYDgy340nzmoGDu9ZWZ17fIhRGLWtLjANbJmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751962617; c=relaxed/simple;
	bh=IhXo1js8HygvRtTjq4eoaew20MKa32TCzHzfgvE0JWc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nTNrteaSTdA3RYoMVIzT3pyJjreLwMIItCh1uvbsfIMThiMqdS5onn5b5AZuTL+uBpxzG6AQj1myu77DYp9nzaLB7bH0D2I0Wu9Rl5Jyg1ssxapH3ta2gxwgDPoyBajxAO/IFYJH2dFkxCIyQ4Fms5F6X8QCzD6QuEHRb5QBIJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=vn3k+Hm5; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae0d758c3a2so677172866b.2
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 01:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1751962613; x=1752567413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=alMSpLLyvO2GyiUt4EFYi3zPSYajKqAuQFGQmWDvAF4=;
        b=vn3k+Hm5blS/AdJ7+hWBRV+NwzY+upuXT03WdZ7yFVJ9QR8pJrjGmB8AIv0NAR8Yvc
         OeYwQj1b2RSujyHzKY+ZupPjgLWCCMg6d7BYpiYUQGQh7liwPiv80IpmQ/XkEBeMLOJ1
         0SXg19Hntc1fNEQJTt4DVdSmHv5GxMKplUo0vVtuZpO6WGAHXUHtqjoihnFlWM4UKF2a
         +p2cnekpIWw1tp5tx0tsH0mOaOxrk1bDnT4hXl5MNbpLpKQdZKO9GlJZs3gy1N9wusBm
         96IDTpxEaUfhRfi/MPqNvMt26jA/YFbrl00jHDnXQbs6w3txJUWOEsS2MLkdOC37zzak
         Gn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751962613; x=1752567413;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=alMSpLLyvO2GyiUt4EFYi3zPSYajKqAuQFGQmWDvAF4=;
        b=oHiLiQpjUEzwGqZw6QSq6MOU8THrD60FoiCWFGbpHMXK53IjyR+Kpm74xZWSAShwTL
         i4/eRd68p0kbIG647PVlW0jznM3S3OzpRAO7g7kb9QKx8vBHItuKGt0l1wQFJqkGP1r9
         Ur4ntKkl8bZ9xvHNFSyjhQ8odE8yZuDkRWCYAXactm7hajnSxk28G6QwsnnV4wxse6bj
         ApiDkbFLl71M8DCehIVxXqyQ1zapPbcTVnuKteVdOhZ4lsfGiblX9ahNTJ/OUKhByx9W
         U2bYiY33csoNPXcEoHvKr5umEXkhmP+pBTXM4mHWtnZhJtYhWAgDJzaXguHrTHWb/9uz
         NDmw==
X-Forwarded-Encrypted: i=1; AJvYcCXkLex5I+hLqKNxCXgTf+SNAOgwWAIfhKaKqctyuxJFeasghwGrmhD/EBevepf51G6eognGxqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa73rzXbmLugHaDbqrdLDjgdXnyOkRfZxYbQ7MZXgZ2vd4oIUt
	tokMe0k47U4WX6JeuBdFWIFBpavvfYkIct55TN1hCpTcHLRos36KgG4tV3N1O5ilJg==
X-Gm-Gg: ASbGncvr1xr6VOEqzrgkT7gIorZJroEEyait4uoqsT1ZoqMpWsVsevc7wNaNR1URvko
	IvYzc2JUyc+eYHh74Ti3DCTy2tAyju6ONaDC80i6LAJll9m/qZjs5Jotxx/3VyW7yqJp5q6v7uo
	/qOC6l/HG5FJvQyPS1vDf0axEfSAFYFY+24iWZ82TjsdRQihhRt5F8yCauPfbb2ldcYP5GanBIC
	8EsC7Xg0aDp6uhfGl5vBSC+ceG82WdzD0vmKh6N+p54ICjV4CjlAwj4m/mwGhh/ROFHUS5GCatB
	8dmhrlMngi92pDUKtCdy1s0QN47y5nGK7upya02T188P+ay9h7kU52RozvmyahNZoz9RnEYqD5Y
	=
X-Google-Smtp-Source: AGHT+IGUG5jFVLTQJ4/OOyiECMuv5LIxsil65WhixC0o4oqqqU29Q8wWHBD1+DnpgbskzSK+q5zHsw==
X-Received: by 2002:a17:907:3e20:b0:ad8:96d2:f3a with SMTP id a640c23a62f3a-ae6b0b1f26dmr208544066b.8.1751962613079;
        Tue, 08 Jul 2025 01:16:53 -0700 (PDT)
Received: from [192.168.0.114] ([91.196.212.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae410916ee7sm622992866b.15.2025.07.08.01.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 01:16:52 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <e199da76-00d0-43d3-8f61-f433bc0352ad@jacekk.info>
Date: Tue, 8 Jul 2025 10:16:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH iwl-next v2 1/5] e1000: drop unnecessary constant casts to u16
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <b4ee0893-6e57-471d-90f4-fe2a7c0a2ada@jacekk.info>
Content-Language: en-US
In-Reply-To: <b4ee0893-6e57-471d-90f4-fe2a7c0a2ada@jacekk.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Remove unnecessary casts of constant values to u16.
Let the C type system do it's job.

Signed-off-by: Jacek Kowalski <Jacek@jacekk.info>
Suggested-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 2 +-
 drivers/net/ethernet/intel/e1000/e1000_hw.c      | 4 ++--
 drivers/net/ethernet/intel/e1000/e1000_main.c    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
index d06d29c6c037..d152026a027b 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -806,7 +806,7 @@ static int e1000_eeprom_test(struct e1000_adapter *adapter, u64 *data)
 	}
 
 	/* If Checksum is not Correct return error else test passed */
-	if ((checksum != (u16)EEPROM_SUM) && !(*data))
+	if ((checksum != EEPROM_SUM) && !(*data))
 		*data = 2;
 
 	return *data;
diff --git a/drivers/net/ethernet/intel/e1000/e1000_hw.c b/drivers/net/ethernet/intel/e1000/e1000_hw.c
index f9328f2e669f..0e5de52b1067 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_hw.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_hw.c
@@ -3970,7 +3970,7 @@ s32 e1000_validate_eeprom_checksum(struct e1000_hw *hw)
 		return E1000_SUCCESS;
 
 #endif
-	if (checksum == (u16)EEPROM_SUM)
+	if (checksum == EEPROM_SUM)
 		return E1000_SUCCESS;
 	else {
 		e_dbg("EEPROM Checksum Invalid\n");
@@ -3997,7 +3997,7 @@ s32 e1000_update_eeprom_checksum(struct e1000_hw *hw)
 		}
 		checksum += eeprom_data;
 	}
-	checksum = (u16)EEPROM_SUM - checksum;
+	checksum = EEPROM_SUM - checksum;
 	if (e1000_write_eeprom(hw, EEPROM_CHECKSUM_REG, 1, &checksum) < 0) {
 		e_dbg("EEPROM Write Error\n");
 		return -E1000_ERR_EEPROM;
diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index d8595e84326d..09acba2ed483 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -313,7 +313,7 @@ static void e1000_update_mng_vlan(struct e1000_adapter *adapter)
 		} else {
 			adapter->mng_vlan_id = E1000_MNG_VLAN_NONE;
 		}
-		if ((old_vid != (u16)E1000_MNG_VLAN_NONE) &&
+		if ((old_vid != E1000_MNG_VLAN_NONE) &&
 		    (vid != old_vid) &&
 		    !test_bit(old_vid, adapter->active_vlans))
 			e1000_vlan_rx_kill_vid(netdev, htons(ETH_P_8021Q),
-- 
2.47.2


