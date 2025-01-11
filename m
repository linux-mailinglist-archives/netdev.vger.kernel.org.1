Return-Path: <netdev+bounces-157458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D7CA0A5EA
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 21:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E3277A1F03
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 20:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1C51B87CE;
	Sat, 11 Jan 2025 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+1kR3Pp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1AE1B87DA
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 20:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736627410; cv=none; b=ehhG/Kr8v1f+8eSuFdfEgWBKeQUvEhfVmtBRB9w6nqXA5iXo1Zj9+sES9s/dshb3YMVwE9LVMWr2L6uJxprVH+kDULj8cHDM655MsS3q2DjGR5VMW/259S1q/11RBiUKNUdPBS8BvqG3S/SpHCP4AvOeSV/QfyUX+lPDgQJMvhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736627410; c=relaxed/simple;
	bh=dMnqu2NFxklOsSsinY1qryXx9RuGGQCtBaDejSngLQE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rorGQj98pQbfRXA4GBIPGAnmYnpVh8FIxWaads4kvdSHIFxw4aPNelFKFYKmGGCxEu0oXQfAmN5nNUDFQ4iFcwYOFF+fKPLLBWySSVIJFmtXa9jr3SUY0obaEXpRxSYtTjHgkt8LHJZwOSfQFiN8w0BEM3ZJN4zxxBlG95tSbCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+1kR3Pp; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aafc9d75f8bso601957866b.2
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 12:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736627406; x=1737232206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wBMddhpX1NI1gq7cSA9OWBGZGHoa2QsJ/OhZHRlrOog=;
        b=T+1kR3Pp0fEKCEwTR3sLTdElgluKa+ofzEYtXN8OlWDDnirGGPtZi2YEQXf/yKnx9G
         k16gXFX4r03Wvc5qY4ZBopiTVrYmloO9YTTCEQLM5XMJuvBmKy2PuOH73CK9iEu9bUQO
         V1k+qyoF/9DwpVtGyttHrxhn+bz9q1MErOjurgxfi4YfKUXvXeP2YMBtTb7jiPHg99ns
         HGkRhJaJ1hsWsTInwvwxgou0c8R0LyXOLyVOMx27vam1DGDA/p9RKNuFuzcsyBTaRlPr
         BbC0VxFGP1tgCnJzzZX8vliRJa2h7y+px/VbvmTh87tedk0oExgGsNupS7jn4yJS7ahE
         JMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736627406; x=1737232206;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wBMddhpX1NI1gq7cSA9OWBGZGHoa2QsJ/OhZHRlrOog=;
        b=lLcLCTTI7SFBqjE9+FgpdDIzqsY2qkTIOMnIkEJBpV0wxPyLqyBZg0Rw1hMDTse58z
         w7lFu4ZxVTYQjO4zEKgYRKriB5dyVsNxlMpmqRCgGqNjTyFkkdgPK1hg5MZwC5BfEtXd
         8Fni1FpQL4elceaT6Rh0iobMZukoCjjfyBI1VzLfaCFaVq8ExBWN1HnT41or597v8Zza
         QOEfifD4qJtGnTxVpj6N8T0NTWsxmRhsqIizhkYhZN/1NBMbb2812kscAbw5M9xKBhrl
         +sLzOASgNvC8QcOxwUv0wrLv1Ms58H/UZCV3zAJxUnUUbu3hpiAYa+pIjrjy3EKTMgtI
         t1+g==
X-Gm-Message-State: AOJu0Ywp3NfyA5InTUHE4WGOqsKm4jG4vbgpt34bFiIcEfwheIRs1Ru9
	Pa12d45IUQeD4HXaHHy35VMgTF5eFCcdXjKXQr4F/WDoZKeuWWxw
X-Gm-Gg: ASbGncu56mX7ZOdYGcQRWTpxAgIUOrL9YF5mZKMBgJ4DCfDs9C1pvIp8cbNudvNyLvp
	yBqD2SnJnnWbHDR4qeoctVzM4nRBHS51EiUuzByTdwA8jlk8aFg51bTAuDanlQcgD7NmILMbBtM
	kJhpxOwsltqKRk+EzZ2TUkbfAu0455IoO5MWpX5Rkl6xmO0evUzcygUt0wKsRdLDCW4TtdWSSNt
	Fk7A3twX3okiW0RNy/DmTfm3cWiNfyoE+GvvAJfq3GcVMCro3IrE/8IM9MCYUu5iQlwqyMIAPAR
	d2DypBnuf5bJnLRTTDIkhq6Cv8r1xHiAhNBOi+vnhJkbH5tZ4bSn3O+1gAkBvS1II+KO4BfvkZv
	okWoBlW4eYN6xej/znYoxK/QcJ+iDmiGbLj5U81hvEQ1sYCyA
X-Google-Smtp-Source: AGHT+IEZqqQU9MT4rQ4dYKMR92uyCfhR5COMcPVT7CRFzt15rsM3bzJ+R8d9suGWjpzPusaLrnFRNw==
X-Received: by 2002:a17:907:720e:b0:aa6:6c08:dc79 with SMTP id a640c23a62f3a-ab2ab741567mr1363572866b.35.1736627405740;
        Sat, 11 Jan 2025 12:30:05 -0800 (PST)
Received: from ?IPV6:2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd? (dynamic-2a02-3100-a90d-e100-d8f1-2ffc-4f48-89fd.310.pool.telefonica.de. [2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab2c9562ea8sm305981966b.93.2025.01.11.12.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 12:30:04 -0800 (PST)
Message-ID: <a9c47664-75e1-41a3-bb54-9027f8ab7c93@gmail.com>
Date: Sat, 11 Jan 2025 21:30:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v2 06/10] net: phy: improve phy_disable_eee_mode
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <90b3fbda-1cb7-4072-912c-b03bf542dcdb@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <90b3fbda-1cb7-4072-912c-b03bf542dcdb@gmail.com>
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



