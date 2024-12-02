Return-Path: <netdev+bounces-148203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E089C9E0CD9
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 21:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A02E52829C7
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 20:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FC91DE4C3;
	Mon,  2 Dec 2024 20:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+hgGlU1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A25A1DE8B9
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 20:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733170481; cv=none; b=LCNwjrYdTGYTT1Nl4aSM/DiIKCUx4tE6VJRW0KofrHUT5nY4b75mCEf4QgS0p0Dyu2fB/8aTcpusCqkJWeURCnl4hOYpdqENX3DfJcuZm3y0JJ6v4kb5aLHOoqxyHVQ3NSbAM7TIC93zypmpOcDlihLOA6nDLev/6F6uceoR+p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733170481; c=relaxed/simple;
	bh=PdTZe8OV9cN6Ub3GUsZIpQJWNj/NzhFmn/7ZfX/ezfc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Kv9Ow77aAWfYdm5Z5QG+bJ1ySlKttOzIj+OGg/0l9XjTMd/HU23W3EXo4ZUwtJuX+OmCEGgjtVU+J2PRECV6xBUU4FgrQRbag8pjYj476p34/rGyfPwllqBHmhvxgihw4Uuow8cfvSwaulpA03PHO6rJHMXOjbBiFLKDSiw5TIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+hgGlU1; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa51b8c5f4dso684715266b.2
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 12:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733170478; x=1733775278; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Lw43y/5CggqMenhKGTSFNqSIF9mYkE7DlGGYGan8s2Q=;
        b=N+hgGlU1U8b1fCTKrTUTZX7NyCrlfOVUj6hHVwO/keBLixRIaDH8pMB9BfCgYcraqY
         lPGlTOThDye/FF7g2Xcb+BjxDH85n1pFRxrHe7wMgUDjIO712zHROS65bnyWnfeE8Bmp
         NYy+RPg+SfgeNMmBTk6cMfrG+9xHiRFRGeOsIEq/ZkwugxW1rnIovoBKpH/nVYainDGd
         FtT50fsQIlMRGVySgopSocWJym6U6oapZjYaq/fIWaT6XvsTURwKWrTyXT/ePGbP6F7Q
         B95RupaZi/8pwOyKBGtcKBpBq7a12ET4pfxKrCYLmT7ExGEuAVAH2FLG/dqdnoFb7ukm
         wHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733170478; x=1733775278;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lw43y/5CggqMenhKGTSFNqSIF9mYkE7DlGGYGan8s2Q=;
        b=Ra2jd/HFfD4TKR+79bOEd/Lyk2iw9ZWZk2yVZFsnOJJtlKsz/HN/Y9ibdBEFHMpzLW
         Cjn3KUuXrleA62+04YDAG7beieDARzDXvjIVbQy7Df4KNBOGnnD4JYK5OfLqvuJg6UHJ
         VX/sOLuu1M2L0ODMuk0ySvNC+0yVzlG8VjVi1E2KigZzWI/mgfL0j4CM2+oFL6Q45nyE
         75QRXny8RIl4k9+5Pg8a2R4KByVEFuJrqPn98qbty9OquD66RdDPLtbQIdK+t2wiNYhT
         MsQV1IYVNgo/keDxFdYvhW1RqL7sOK2ezwN7vLg07THpOhl3ONadJYlgks4CpHEfrQCQ
         ZDAg==
X-Gm-Message-State: AOJu0YwTR+5Gjy/896lMAsbTv4O5N7l8awalnyQBfijk4R1TXN62yAG5
	rBp47Pqe72us43/iapYurz37GQ6CE13GkKgjpaafWRrQsjaozZ9BfaohSw==
X-Gm-Gg: ASbGncuBUwaQFv183Nrnn1dgiKKuuDotLosvJtG8qjbin+kcKjUrlvVS7dAcUBxrySk
	ZH9lg1TTNAY6yJAkKuPxw/FHGBJ3w67dpIS27ZVK6lNJF24ZbyJ79reiEPCBbPnRNQt0fkMkpdN
	y9CH5fQoHniUZZb/GPxnWDSO1c5K5ehmh7VhUlKY1QXFDelswVVlWhwnD/Ul8Ke+PNNP1zNCfGj
	UbbAO7o0DCsJq0Bhk/U/Crol6KHF6svynUTe51RyCzq2RippbFMHComb/cMX6KLz0EcR/r9n++k
	RWX+1WaMjZw7o6tw6Yihg1RZfkoXUteJROGKXaxGffax2+nqNam1RDvpvv6e7KlaeF3vGWEO7+D
	0bu/Dm4athBCAEQFKLLufETtFTX5jZ0X2A4HACzjpkg==
X-Google-Smtp-Source: AGHT+IHtX+fOpdjDL5MuW9gw+rrZClTRmYg4kaWVdER+IheDQLwHj7u1oIYs7GM6A9XmrX6qNlBKBA==
X-Received: by 2002:a17:907:2cd6:b0:aa5:b63e:20f2 with SMTP id a640c23a62f3a-aa5b63e2105mr1261711966b.10.1733170478099;
        Mon, 02 Dec 2024 12:14:38 -0800 (PST)
Received: from ?IPV6:2a02:3100:a4d2:4900:2dc5:1fb9:a62c:2977? (dynamic-2a02-3100-a4d2-4900-2dc5-1fb9-a62c-2977.310.pool.telefonica.de. [2a02:3100:a4d2:4900:2dc5:1fb9:a62c:2977])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa5997d55b1sm542609666b.72.2024.12.02.12.14.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 12:14:36 -0800 (PST)
Message-ID: <d9dd214b-3027-4f60-b0e8-6f34a0c76582@gmail.com>
Date: Mon, 2 Dec 2024 21:14:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: remove unused flag
 RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

After 854d71c555dfc3 ("r8169: remove original workaround for RTL8125
broken rx issue") this flag isn't used any longer. So remove it.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 739707a7b..4b96b4ad8 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -623,7 +623,6 @@ struct rtl8169_tc_offsets {
 
 enum rtl_flag {
 	RTL_FLAG_TASK_RESET_PENDING,
-	RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE,
 	RTL_FLAG_TASK_TX_TIMEOUT,
 	RTL_FLAG_MAX
 };
@@ -4723,8 +4722,6 @@ static void rtl_task(struct work_struct *work)
 reset:
 		rtl_reset_work(tp);
 		netif_wake_queue(tp->dev);
-	} else if (test_and_clear_bit(RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE, tp->wk.flags)) {
-		rtl_reset_work(tp);
 	}
 }
 
-- 
2.47.1




