Return-Path: <netdev+bounces-240995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3980EC7D2B2
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 15:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDBD43AA3AC
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 14:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE081F5EA;
	Sat, 22 Nov 2025 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qnio5SsT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987411FDD
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763821389; cv=none; b=hjW1VCYnlTEIPeKWQv0+nhjkWRnFKXG5uFc+Tnh/9WZ0lxv04k1s1I1wN9SWj1xZ4YJ662fMrLOi7iFFwt3lJvtAPLMfWVJX1MT8ZrLxIfnaA/sxcxAG2QDbiRLTE6wm+c9CH5kUnS7WJuddPot1zzYKYEpErk/cGaDNjQJM7BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763821389; c=relaxed/simple;
	bh=FKrMNSANrBkQ22Pod7R1j+jhP6J9vZ9e8+oS5B44M1o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=s8QhE/Sfdnl8mAiEEEbSBTJwZG+DblD261lqX4JPFcl89feGzBjz854U69VqBmiBb3sZOhXTdbTnh3vM+yNYaHN9zzgERup6BXPVBl/v/xaPWXG/t1CFce+MQk2ZbgJ3WNOYGE7W9dI3/e9djEkXPmDekTgn1c5u8EfS9hpNjIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qnio5SsT; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so29729385e9.3
        for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 06:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763821385; x=1764426185; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giPYyGhz2pEDYJA5pglbKzcooyNSi+qkZ3uFDmTohXs=;
        b=Qnio5SsTFr+mFC4cLEwzr91/bJR30PHs2a9PMRetVFCMViVVVkcxlETN6x/B8QxlEY
         ndE/GxIg75VoU2N3ctlFtYryGwix80hnyC/zeNzWpN2Lvw344k7F7ZusT4akQ11HaSz5
         sfGxwTASwrlZLGmNKXReD34FoiMnB+DdnqdZtelT03am4X+G1rxxB9I3RVfsitrztYkc
         8La5jkBhLyPLvBcCaEZCNPWCCO2/m8UAE+OMqWg00eK8IOWb1176lKrfqu7oiJolL7eN
         rRF2LVlFX25dOOCBSpPZ2K+70Nz+DoFEIKj3V8Ke0bPlwotAjhH5IwUsqME2wntiDtm3
         s39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763821385; x=1764426185;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=giPYyGhz2pEDYJA5pglbKzcooyNSi+qkZ3uFDmTohXs=;
        b=nFcMBjpjtlPDAnwTZRLf+GWK+pDcm+h8xm1NxWg6T39IaRgkwYtprKZDGOnapb3/b8
         64XmyzM1QsG9SGLWy+pGjP7hAVSBjjAocxOBlLSLA4GHYGh3Y0gBZ7JYB+tOJb2AwPyp
         ViEsAoGzw/l/JcZg2EKqQ5Pnnf+KIOdW0L9S5+WuCOuSzJixavdBRHKW/75xkSDA3FzQ
         jY6XlXTheWThqYan+lrRd2llLMPeYsSsUJlFxB2DIxmKvVUcBU8Aqhop6d1hb2g1ZnUV
         KcRyAnTw3t2ehEiFqdJG/HRU6NzASaC2wUeHeugrkYEl6JYvgtJAqIKZH2oOcIDHlIis
         Y5ag==
X-Forwarded-Encrypted: i=1; AJvYcCWtnNXwaS9Xp2spVN0I3/P1NC7h06jOBSpuO0GsNR6hYFIRC0Vm8ttqkSKKSTqZOG5q2boXT8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Si0P/jTK1tUBroXIXfGt0NBtOapBO7+SEv3RxaVd4UPHHyoq
	1IHLRz0gWiiIbA4obAit0YHIfljw9ewDu3TXKZN9VywdjEy8/EBwxZRW
X-Gm-Gg: ASbGnct0oYcay7aLQ6DzzMFshPPrOYQxNL/A2p5wKUNN6kacRtM6VqUotnAQg4N/McJ
	TODpi8/8YmH24yhamRdx7AvqU5SKsH2qMTzaykeEpyj2PRALqP2rDHfDrLdO7hoNznqQ09ImqNm
	q/HKKBKq6CeyAZmaAjt9VBVy0rg4Wa0Ufx8bU9ritN9rTL+sgzv+iA1cd6+vhZtfQWaFxPCJgiQ
	N3QrkL159wT/pA8wUNqlTZLIHuNhhY6Zl7KFNC9sc8SG/bjUyuPtkbQrgpD7ysACvSjFu8zMXhX
	H9IYTHdgHpq/p0KWRBWOV+AI+0BngRrJfdpTZGDa/POJvidjXRYGn/rTkvGP+p6V6GQIhvIFj/1
	juRiRjmxxIWp5wnBTcpb5XZ7LbCkSVEBDaq/a2YlSD96CLEqYmsL77p9iD8qWuQn6AVWXzRVfUh
	1/WR+KXlh3ZgNloh3DanZycuzdtPuphWk4qmtUSw6N5MREx3Kk9Ni4MLJYNonDGV3VtX6sPLpPK
	wh+tA7pqqsSygzlahpCBURtWO2huMMAbT2Uy7DkjAtfDtBkw+BBvA==
X-Google-Smtp-Source: AGHT+IFWhtD0nk/nnYp6O5FLdSyGm5y5kK8ptUjMSLwBkwHoF6/rE5c1T2vNJLoIWkfSEJ+qC71Y1A==
X-Received: by 2002:a05:600c:1547:b0:477:63db:c718 with SMTP id 5b1f17b1804b1-477c114307emr62289135e9.16.1763821384679;
        Sat, 22 Nov 2025 06:23:04 -0800 (PST)
Received: from ?IPV6:2003:ea:8f33:5200:e1a9:c2ef:2449:e771? (p200300ea8f335200e1a9c2ef2449e771.dip0.t-ipconnect.de. [2003:ea:8f33:5200:e1a9:c2ef:2449:e771])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9df8db3sm104875075e9.11.2025.11.22.06.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Nov 2025 06:23:04 -0800 (PST)
Message-ID: <d7faae7e-66bc-404a-a432-3a496600575f@gmail.com>
Date: Sat, 22 Nov 2025 15:23:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH RESUBMIT net] r8169: fix RTL8127 hang on suspend/shutdown
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>
Cc: Chun-Hao Lin <hau@realtek.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Fabio Baltieri <fabio.baltieri@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

There have been reports that RTL8127 hangs on suspend and shutdown,
partially disappearing from lspci until power-cycling.
According to Realtek disabling PLL's when switching to D3 should be
avoided on that chip version. Fix this by aligning disabling PLL's
with the vendor drivers, what in addition results in PLL's not being
disabled when switching to D3hot on other chip versions.

Fixes: f24f7b2f3af9 ("r8169: add support for RTL8127A")
Tested-by: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index de304d1eb..97dbe8f89 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -1517,11 +1517,20 @@ static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
 
 static void rtl_set_d3_pll_down(struct rtl8169_private *tp, bool enable)
 {
-	if (tp->mac_version >= RTL_GIGA_MAC_VER_25 &&
-	    tp->mac_version != RTL_GIGA_MAC_VER_28 &&
-	    tp->mac_version != RTL_GIGA_MAC_VER_31 &&
-	    tp->mac_version != RTL_GIGA_MAC_VER_38)
-		r8169_mod_reg8_cond(tp, PMCH, D3_NO_PLL_DOWN, !enable);
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_02 ... RTL_GIGA_MAC_VER_24:
+	case RTL_GIGA_MAC_VER_28:
+	case RTL_GIGA_MAC_VER_31:
+	case RTL_GIGA_MAC_VER_38:
+		break;
+	case RTL_GIGA_MAC_VER_80:
+		r8169_mod_reg8_cond(tp, PMCH, D3_NO_PLL_DOWN, true);
+		break;
+	default:
+		r8169_mod_reg8_cond(tp, PMCH, D3HOT_NO_PLL_DOWN, true);
+		r8169_mod_reg8_cond(tp, PMCH, D3COLD_NO_PLL_DOWN, !enable);
+		break;
+	}
 }
 
 static void rtl_reset_packet_filter(struct rtl8169_private *tp)
-- 
2.52.0


