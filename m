Return-Path: <netdev+bounces-157534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7A9A0A98D
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 14:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1822166002
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 13:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737981B425A;
	Sun, 12 Jan 2025 13:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDZN8Gml"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3EF175BF
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736688688; cv=none; b=DDLy54x2BZ1VwAu6XcQlY9oATzz/a8InPtw3GA0v1FLLCWo7FCXrwCBxZvP2zV6ZDBB0Fqm0MdRHgtxAyYrirEBr2YrNQSI1njASOVB5X3F/KsUqfTqFT61eEMXEhGE5uPQaRjpP+Fs7EdXojW4631JjTyX4zHOsziqbhM4slRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736688688; c=relaxed/simple;
	bh=dMnqu2NFxklOsSsinY1qryXx9RuGGQCtBaDejSngLQE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qKKZbelCC4gfDSUubq00YOYGjs/IrrOVz1OeSTTrkJ+QAMcKqeP4hew1Kk8vFKnaIIxF1zV2o1ojFWinmJyd2d/43PKewiqsya4aeQduUCkIc0GIGVCKeE4QlJNGRL3+ONF/BBmP6wxwLxh2l9m1+v+Wrq9LQbvCsRwmGbS/9MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDZN8Gml; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38a34e8410bso1746112f8f.2
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 05:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736688685; x=1737293485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wBMddhpX1NI1gq7cSA9OWBGZGHoa2QsJ/OhZHRlrOog=;
        b=eDZN8GmlI2dyOV+yDFC5BJFt69nT3g0Bkg2Fg9PVE+O1LPHJo0EAkwMgHLilFVzsjw
         EPRE99G/blFsLoVwTGs0nbwAzbvYba5XlinDnOPhKDw46UkZj9S2omshVyFiy6ujKQz5
         VP++nfygQBW+A6qxtj14KzHRrtYh6Lp67jTffp7TLz6OXgpZviZb2Bi7B8F4xQFyz8s0
         FIh6DnvLw2Y2jISAYBU+OLPb1CzsR81SCJ1bQ+tbFX59BAFgVkdmCz3NFLuDmgjHj1HD
         CzTLMM9CAn1UDtS2dyUafwNOjy8QEjjKShNAD3aPLXe7GzIbvcs2JB/PC2fOJUwZwrw/
         cl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736688685; x=1737293485;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wBMddhpX1NI1gq7cSA9OWBGZGHoa2QsJ/OhZHRlrOog=;
        b=RVDy/7Ht1oZ7iBLYqv16BQrQemCNLbRb7UFvOLXv8vssTQnGE4Bv27znIc3PJoYVf5
         EgnQqqtCKo4mKh0yAeu2BFMGCwHOt5AeP/6W2bP7LQKZuDrescVsv8LaYox2bN29gD0x
         dIcsZ73qxSXg2hTtW+4NbCCVsLnFfAogNU5XyXaRdvihPk3SaJn/kyF+GUHVqgQupehO
         6QNExXTneKC6AyXAeBKluF5IqdyFy3Ytq2NF9iu2PmCRKtfVzE0PxJYNaDqAXoEYSNMY
         WELTRYB24cZs5LbyrY3SxiUeky0BCZiVCAxgw0pEShA1u31LdvNt5DXRwRHAb2NZjdLv
         kVHQ==
X-Gm-Message-State: AOJu0YxKPUETwHBR/N8XVEigpC3Xv459pB77wdK/JKTmO82MLnl7a0XS
	pbUwH5mcLDQO3pVOKZVOn3EOmu6N5fxEf/3BrPBAicYjF+tx7/9/
X-Gm-Gg: ASbGncul6pHQxSoK/AKMlJklpz0rM9Iwpt+IyJOdMtAQmVdGXSZdG13Z4aAHy61F06G
	yaglAc0csnQVu0XMMgyCtbFDTwGt+vn/OyviQf0pHfN8ttmUrtxZdcpch2jL80sm+AhyN0w0LAb
	KdkPP9VjH+rjnIjZiY0knouo8z2WORmoEcDlSYCK0lzgyJU9QfGQH5+DsjHEwaO9z+2S1guvXDI
	nbAg/rigE4L2k6yPngVvBogMD11kXT4v6KB6gW20+xkdAID14PjBboBmPvlmowdP3q1Aab5oWdY
	P2xCMOMO8UW0clZZzC0pL/qTHK1osyoTUijyLljSvD75vyj+89xAbFUK2HXQU3Mtcuybw9mRPAG
	IQNzSRa+rXg2c4qtG5yHEAMixZtZtIG8HIJ5vLM4C5tpWLyQI
X-Google-Smtp-Source: AGHT+IExd1Drm+zHM7Wfv8iJPW/n3gl69YHDgX9noLIVGcYlyCcP0wAesHdhVLCALvhD3JlH7ilXkA==
X-Received: by 2002:a5d:64cc:0:b0:386:366d:5d0b with SMTP id ffacd0b85a97d-38a8732098dmr14985672f8f.55.1736688684952;
        Sun, 12 Jan 2025 05:31:24 -0800 (PST)
Received: from ?IPV6:2a02:3100:b0d5:ab00:44ab:526d:76d3:604a? (dynamic-2a02-3100-b0d5-ab00-44ab-526d-76d3-604a.310.pool.telefonica.de. [2a02:3100:b0d5:ab00:44ab:526d:76d3:604a])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38a8e3834a6sm9579098f8f.28.2025.01.12.05.31.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2025 05:31:23 -0800 (PST)
Message-ID: <c801b193-37d6-4b18-80f1-919201e04928@gmail.com>
Date: Sun, 12 Jan 2025 14:31:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v3 06/10] net: phy: improve phy_disable_eee_mode
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <5e36223a-ee52-4dff-93d5-84dbf49187b5@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <5e36223a-ee52-4dff-93d5-84dbf49187b5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

If a mode is to be disabled, remove it from advertising_eee.
Disabling EEE modes shall be done before calling phy_start(),
warn if that's not the case.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/phy.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index ad71d3a3b..fce29aaa9 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1333,7 +1333,10 @@ static inline bool phy_is_started(struct phy_device *phydev)
  */
 static inline void phy_disable_eee_mode(struct phy_device *phydev, u32 link_mode)
 {
+	WARN_ON(phy_is_started(phydev));
+
 	linkmode_set_bit(link_mode, phydev->eee_disabled_modes);
+	linkmode_clear_bit(link_mode, phydev->advertising_eee);
 }
 
 void phy_resolve_aneg_pause(struct phy_device *phydev);
-- 
2.47.1



