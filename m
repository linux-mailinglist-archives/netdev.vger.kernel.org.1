Return-Path: <netdev+bounces-196329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4EBAD4442
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 22:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AA67178392
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 20:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7C4266EF9;
	Tue, 10 Jun 2025 20:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hd/7CRNp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04126228CBE;
	Tue, 10 Jun 2025 20:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749589096; cv=none; b=VEMN6RjUN0DrqB5zKWW2GMfWsuU6XQbRMTgnXYSP63fBm6BCMJ9yOlcyoP3603I5iZpJbH5WfB7r2Djd9r6xKRS/iVUdJUDeeIApkfAO9ghXzMpV8z3ztYKLAPDL51MgzlUmM8zLUnjAvq3w0xb8GOovYVM0y7tYBsDmtQ9+Yy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749589096; c=relaxed/simple;
	bh=BYTIzIB03OdoJPb5gOcU1eiLIP7ekQ7qfJ4rstBUQFo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Iqk0a1cXtaoNDJB/XGVyZqAs5if4UcuZ/RR/NYTrWV+RGYsoQVjRc+HDfJ/ZR9vT560c8uPCeVtxbo4yuJ7sgJXMtit3DoUheici8AczJFcncnZTozdfc84AtvsSZP3lRHwqvkGnPxc9Y7EVjh2PP+9BkEqS8Q81VfnunwOmyr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hd/7CRNp; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a531fcaa05so2459963f8f.3;
        Tue, 10 Jun 2025 13:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749589093; x=1750193893; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xh90KeOklKN2cCix8PT9oL30Q+U6CKK+6+z9LAUwhD8=;
        b=hd/7CRNp1sR6yKDYWxkz44lO9tkkZriFL42GsNrkIrW8Kc6HkK4r5kPAG+KN+ft6+6
         9E/1NCyI8Wfx45IE0LOa85G8QtRr8GpgKa1yEJE2GLKrzzqV8M2pa+7W3XKyPYHtklbU
         GF/eJWbUiw290aKaU0eGgRPtMS/eCmT5pHBIoXCFCZ+eBIb44rAziAfvV6449SUTkWUJ
         3yd/Ba5Kk93S1TeYrRa/QSHfhmf35P2PBs0PsyxBe19K/6MqdPGJ5UcpdzlRTAK4MA5k
         5CNhbU0HxYoRrsaH8s9JajeYbTQOCl0dRejfSLJEp7KB+eciP3UybLZmlHapBB3V0wJd
         9zXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749589093; x=1750193893;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xh90KeOklKN2cCix8PT9oL30Q+U6CKK+6+z9LAUwhD8=;
        b=MxsI7Rp40yDfVjSZYt8FWl26xbycXnqUPx7gOXFktQSs0cjtWt2qaWp5uBc/PO6rIF
         o31T/WT7EyHOixsZBuH2m4NWQ7c1X7TS56cwWdgmrRENusq8272DE04wtmnVCw/K4EgB
         gTJO2DrNNLzJ7eaFaXMS7O+wXaUJ9Q2xw0JnaEMps7i8j768LHiZo49db6zFRpq67ZDQ
         5kbuDnsfwHrgCr8arAqhs4BXZ6q3HZ8Oj5K9KAAMOXK3NDqMORGTNrtA1SRpcQA8ctI2
         sUf22s+0dZOVfsQl//8m9HwWsgbGCVAoWyLZXS79jkaj9OFR0SrKPyaj3S4u50E8yZ92
         f2pA==
X-Forwarded-Encrypted: i=1; AJvYcCUc/BkN/4QF0ls7e50TbrYSoTSSa0HNl4007pVFE0bP2JUhAMCpk1wZWOmHUWnwQa7CNIEOwQMbSgc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3JeHnlu/0aCF5dQIKg5spiTSlXQMawP7I0YS6DYvqJSFjApS/
	mpG27vKSZXY+bEk/kczeeBObhSHrGhuR1V5w3CfoQdSjqNts5GYo9LXM
X-Gm-Gg: ASbGnctIswLrN98RP7zI5Vy+qGTagL9T2NIOUaQB3b/qOxGZK13xK6tUiht1seWpQ2X
	jgnQ2y4yCBLYCNrejp12v+LqOfaNSfCrpIkK/jYceb5zbMt31EE2vkrBRg/NLeqQLocQUypvOZ2
	SY9ioAiKuQnx5WY830TkkNGfG9WK6JnywsICU1CsZKylu3jLiCWuk81++fQ7TbPu9BtjazU6jjh
	I2lCS2etg8eu6XmkFkHLCgwg8LdXM9099tYfOJ7gocJ4P0FwtrU9CTzRlTZXh9Ksie4N9rPpZbJ
	/EZleWU44ZQdR0ZQh2cSIyqAaB9TdLUxGYnEgGe5MeZFTTt3umhYImiyQNDzalneQp1X7sOp/0i
	cJcg8a29MNPL0/tC7bN0cEms6GmHANykKsQrXNljSUNzfQVJFDbLPwWvN6weH5UHO5qpPFnJZ02
	0LaHeczuj751Vzix+gHx2iMzk=
X-Google-Smtp-Source: AGHT+IGazn7mO+/xlE2ImPAXijeAfju4bIKqJ07ky6cdd/P9hf8xlO3A3W441hS6zJP932prlM/g7w==
X-Received: by 2002:a05:6000:26c2:b0:3a4:da87:3a73 with SMTP id ffacd0b85a97d-3a558afe952mr286811f8f.42.1749589092924;
        Tue, 10 Jun 2025 13:58:12 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f1a:8200:61f9:df1:e3eb:5a45? (p200300ea8f1a820061f90df1e3eb5a45.dip0.t-ipconnect.de. [2003:ea:8f1a:8200:61f9:df1:e3eb:5a45])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a5323b5147sm13547862f8f.37.2025.06.10.13.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 13:58:12 -0700 (PDT)
Message-ID: <0890f92e-a03d-4aa7-8bc8-94123d253f22@gmail.com>
Date: Tue, 10 Jun 2025 22:58:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
 Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
 Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Linux USB Mailing List <linux-usb@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 net-next] net: usb: lan78xx: make struct fphy_status static
 const
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Constify variable fphy_status and make it static.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- extend commit message
---
 drivers/net/usb/lan78xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 759dab980..17c23eada 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2630,7 +2630,7 @@ static int lan78xx_configure_flowcontrol(struct lan78xx_net *dev,
  */
 static struct phy_device *lan78xx_register_fixed_phy(struct lan78xx_net *dev)
 {
-	struct fixed_phy_status fphy_status = {
+	static const struct fixed_phy_status fphy_status = {
 		.link = 1,
 		.speed = SPEED_1000,
 		.duplex = DUPLEX_FULL,
-- 
2.49.0


