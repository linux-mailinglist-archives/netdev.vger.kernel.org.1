Return-Path: <netdev+bounces-172802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D8AA561BE
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 08:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49410173F02
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 07:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938491A3142;
	Fri,  7 Mar 2025 07:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKBmGi0y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDB719DF8B
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 07:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741332516; cv=none; b=qvXBXpD1sSvrStoKDpzfTgQx2kSwAlthPAMlFj0kwLRa/MXma5y1c4cvqvb+nb8HoJcMHdEMtW4duwLbxPuDPYWqooRcEDHKFcgtUx8nuLF9n6yNjxRmLHO0NE13fYbnbUNMrO5c53Vd8MYNtoZJDyskQqiPWXUOudtpC490cMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741332516; c=relaxed/simple;
	bh=RgUYCaoSNOvlt4iibfrPZ15q1qmWLZiNvjof+hki0YY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=f8Ly6lmTYjUn9Akv4pmmE5aBRtqgBWjSI6HR+GjrpEN1ooKB4rqFWxw9/UtM6fU6uJk24tCVG19WgRdAv0LoAClHI6tlc8HHVzZCx5iQV6ghUVPMdpNrNcWgBiB50Wk+egXRGdrrlsLhjSC+YAUuCkflJgjLKM9F8i8uZkT45OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKBmGi0y; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac25520a289so73003266b.3
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 23:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741332513; x=1741937313; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0v3OOkEsZHh6LD6xCbK21hBRfzgcRC6vWicU8tcM2NM=;
        b=FKBmGi0yWO5/EBCkllXdZB1H/0ovjSJUDNKdonFvM7E9LqBFS/RJfttVUWBD/ydlpL
         nuDF0DP4d7BKDqDiImgD9uSWSLOfq5ISQ+I4683UnPX7PG7aLMi6gu7JLHiFLmLk1qX6
         Ym84i9Y0AT67mGllKH4txCLVPqTBZ9Tcx/fOw8MhjnBgDhURdvUhvEQ3nzsQH00dKfsn
         2vIHFDKGDCas5fRMiE2wWXjAmuT2Rvr1tuBq75Zc4Sb5E/PBIDpkkzgG7rnDWDpsnUSK
         L4AreZ5LYZAVteh22eBXFaRi06qz2Sb6PpZfWLegokjThKsCAlbTNJPaFD0SCvSlwtqB
         iT4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741332513; x=1741937313;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0v3OOkEsZHh6LD6xCbK21hBRfzgcRC6vWicU8tcM2NM=;
        b=EAGB6UwxhNRHj8boXSTWm02aLrNUlG652cbqi6QUqLmtPLGz9qoH9ZUkgaamFyWn5F
         NDXbkXfQ/itTcHFbLk4I6q3ZU8z4VsIB376XcH+v3YjARHYGnqepYbX0+wQ8MWeug407
         SmzwgZG9kTntdvAporrg2Aru9NmwHNwNxhZ0O52cg72OWNUCyfOW5eDIWbXb3S1t1UL7
         4UthGulXnbuTkAjpRmVtdwJAAWnf71NzZZo0Khzzrwy9aQOV85HUZfCljxghlxUvDvfe
         tJCkPuG6LxrHeLM2EISicPFoPaIK0SuKwwmQKYjhaVK0iJY++vxdA/X1dyMGxCEznvA9
         WaHw==
X-Gm-Message-State: AOJu0YzKtbmq12AI1W1WxYLtdQSdIqAEsSb5GUV58+bo7tNKcaBdOEG+
	IxTp02go0dPRyz4hxRBRvCi1xtG62okO27h2HNlQVPTsdb/GWFph
X-Gm-Gg: ASbGncsef6podndibBxpNJaGR5KVyDfDt2/gcx6J2nT9mbBR+Gt4C5/3xrCtBn8Ye0x
	TzmlkfVDn0vQnuz5po7AiLKgDjAXR1gM73CW/xntLUzSc4cbBNul5d5HsA2orsWQU6yC0Vv+/aS
	akPdsT6bTu4VCld6hYMog5RIpN50If5cIZO+VQ23vPifnDXkVwyUhH1M/4yFhat/apP6mdTthNb
	8PXvPihAOo9XIePYCcLuKLqPvhTnunOCjtEkWMYJrgJZovsYcHxrAZ8UqnjOGIYsuGY1G/vFLve
	jVIf17OKGJjbcnqn+SJIPB98vycLZSxfBXsOS6TYcHxqSn8EgA0xy0UZccxiWJg8W6JPmP2KhOs
	difKF8hIMCWsdjPYNC5xHOac8/oaZh41jVR7QtqiVjJq31A9HrFpRORzMdmmU9vGummRk6QnCU4
	Auu4dGWBprPQ/PT1Xp29ey6Ys8a7ex07czaSA9
X-Google-Smtp-Source: AGHT+IEH+vBibLuDz6jF+ig/PgVTliAW2aeO4dlmCVlUmcJT33f0lei3kPH9gF726sObmNXqiwXZQw==
X-Received: by 2002:a17:907:7290:b0:abb:ac56:fcf8 with SMTP id a640c23a62f3a-ac25308b91fmr208073666b.57.1741332512774;
        Thu, 06 Mar 2025 23:28:32 -0800 (PST)
Received: from ?IPV6:2a02:3100:af19:6300:6130:87d0:45d8:3247? (dynamic-2a02-3100-af19-6300-6130-87d0-45d8-3247.310.pool.telefonica.de. [2a02:3100:af19:6300:6130:87d0:45d8:3247])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ac239482f9asm233192366b.51.2025.03.06.23.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 23:28:32 -0800 (PST)
Message-ID: <396762ad-cc65-4e60-b01e-8847db89e98b@gmail.com>
Date: Fri, 7 Mar 2025 08:29:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: increase max jumbo packet size on
 RTL8125/RTL8126
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Rui Salvaterra <rsalvaterra@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Realtek confirmed that all RTL8125/RTL8126 chip versions support up to
16K jumbo packets. Reflect this in the driver.

Tested by Rui on RTL8125B with 12K jumbo packets.

Suggested-by: Rui Salvaterra <rsalvaterra@gmail.com>
Tested-by: Rui Salvaterra <rsalvaterra@gmail.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index fa339bd8c..b18daeeda 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -89,6 +89,7 @@
 #define JUMBO_6K	(6 * SZ_1K - VLAN_ETH_HLEN - ETH_FCS_LEN)
 #define JUMBO_7K	(7 * SZ_1K - VLAN_ETH_HLEN - ETH_FCS_LEN)
 #define JUMBO_9K	(9 * SZ_1K - VLAN_ETH_HLEN - ETH_FCS_LEN)
+#define JUMBO_16K	(SZ_16K - VLAN_ETH_HLEN - ETH_FCS_LEN)
 
 static const struct {
 	const char *name;
@@ -5360,6 +5361,9 @@ static int rtl_jumbo_max(struct rtl8169_private *tp)
 	/* RTL8168c */
 	case RTL_GIGA_MAC_VER_18 ... RTL_GIGA_MAC_VER_24:
 		return JUMBO_6K;
+	/* RTL8125/8126 */
+	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_71:
+		return JUMBO_16K;
 	default:
 		return JUMBO_9K;
 	}
-- 
2.48.1

