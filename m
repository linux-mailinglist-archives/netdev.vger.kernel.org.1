Return-Path: <netdev+bounces-237352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5525FC49631
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 22:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D6AA43457C7
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 21:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C8C30216A;
	Mon, 10 Nov 2025 21:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVH4zacC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3388B304BD0
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 21:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762809639; cv=none; b=YWecn/NZUlQXgPIgsUKjmdqgVL9wza2gRoULSsLKYf+C6EFPXIl1sg6mC1K9tHtm/eHc6/Qls4xvgxyi9eocNbf7dN53JN8gVoWPxfSyCNWVPUnoQZ0mXHjjGaiipU1DNxPk4RvsigmTtVMa1MCRYfYMz2cCtXvd5RS6LC7aeg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762809639; c=relaxed/simple;
	bh=YTYfH3T5UuIj0tYqqN4wHAL3Zc3SHSjSaHVHogVJfk0=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=F8LLbMz48F9jX0zPOyrFNsSmvjdGYr6QiUGPmAhKQBer4qGAkeOJnVCrAwBcK5L0Ws9BhE7nZFTMOeIdsZr/uhcjnqAQDg9S1bC0i5Q3KA75FHSEWrX89rHHZts2LcMoSfw0ahn4lSUX2rpVvKJ8ddLV5Hr/4odnRAjgXXU8JOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVH4zacC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4710022571cso33873455e9.3
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 13:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762809626; x=1763414426; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEPTxM8l1+VEmikjeW2UsiDS4WIGaPTh9g/9vknL0Wg=;
        b=CVH4zacCtTgmF7sEy7dCg47GEAsDFia1ZGQ81lx4BkAQuTM+5NMv7SDhI82f6a2GdH
         5m4T5ZXwlKGZtL0L0SIE+Ri3vKIaj7odDtlL33/ZX1NWnt06/wlMIo7iVgpCHoUFK+9e
         Cf8gbqvnXEKXqImGNiKmBXgAKqCGgaifD4rB5edHeAuePNDyRmpQI2vhWWbsocKg3J+y
         Ws9hHUyZbRzA8wn4TGINc71TxKPrrIKUn1pQjLjDhrlB6djFPghhUZVIQ3h1v+/RuDiG
         FHwPyOasunViyrK+AVGLhHfWP17o4zCCnMXwiNaPpr4e3nxA/ZqQC1K+51syt7J6Hxku
         BUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762809626; x=1763414426;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TEPTxM8l1+VEmikjeW2UsiDS4WIGaPTh9g/9vknL0Wg=;
        b=kWc/p0ApKyMpxBwfNWhWEMvRr35GQNac1WR8eKy9oTorf+ICPUKD/EGUC7WZ7EnsUC
         BRwiEcnmE5wrpyJQ6jWnwbNXcoEf9Lj3E+dKWqIsXUJr6ptdTDS3bWd7IB7nWFjwl4Pd
         xtS1Ipv9QTrZGpWG+4QTuncPzqIzxeoeIrNQCcQW9VTkpCfShFAucBsxg3rtfeTQPQ5s
         wbs9g/4fzRNH+EFUpGODxeSRDqUQFc9K3prn95qDG7g5nZXXzycmVWcgW+Zh6prq2ugl
         KT8m2x6WyjhXoejWkmmmWZhgBQO9jV6JJiOz3bwvs/+80trGLZi1x5vHZWFIVZkC3wwR
         P69w==
X-Gm-Message-State: AOJu0YwxcmkwjT2YeSqtBr+LTm+ZKeR9L/Dq3pn3MJbPK0jCTTCkGZ2Y
	ZxRJP71XlW/OkTretTTcWWbNV4VGWYs0lycDjlKN1UG8ulIvwcEFixUw
X-Gm-Gg: ASbGncu7c/yt0DJGJXePs1xWpBRhhRaXSCp4C4fqbyjfwAe60VzTXUvU339bUzGH5jb
	hTE2cko5xdzz1ZnKwH+wtDewMUXEJzvkG/4yYxkpkeQQvgsl+/oVU80qsa8fEceo7C6Yfbp8kuv
	edK+HZnEjHn0HnGa5YEAb+PHuHGim6nYyxW+3fQxU6XUH9M2GrEd4352tUsUmQauSD72xY9xSp/
	ISey4pTloo2UdnqoSUcGsknilys7Os+iGFY7OeGsZGRYjnqM6PgCLYGDEhXHdSSSrHxS0FbQskS
	tGHqJVEOTQpW8qeGFSEfZ3YRrKEOTPWdM20CtS/KSe5TrAP4/gCz0D7GLsA6zTqKSDJiA7RcUwn
	AI903f4HETvJxd8eb/ePQlqlTPtDBlAO98Wzlli7Zlrm+gMxbxG/Q4zGaVJu/95tfvZJTiXlL3n
	fhuGotnVhIqVVbFdtDP0T+Xt204oBx7YkKxD8uK4Tx5V8xBYaIpMeFxY1vqo3O2b8quhU9+hlyI
	Go0Z5gBms5k7Hrm+3EKPFsYaBuOx+/SJYZb0RzetMSlAH5M4mJVXQ==
X-Google-Smtp-Source: AGHT+IFWJn6KTtFMJ+s+p8iJsL7MnF4diEGgavfAUIngqizf9Vg7eXL88JSe08+3Enmqit0ntyB8lA==
X-Received: by 2002:a7b:cb4d:0:b0:477:8094:2acf with SMTP id 5b1f17b1804b1-47780943053mr14571905e9.36.1762809625500;
        Mon, 10 Nov 2025 13:20:25 -0800 (PST)
Received: from ?IPV6:2003:ea:8f33:1e00:300e:33dd:b203:22f9? (p200300ea8f331e00300e33ddb20322f9.dip0.t-ipconnect.de. [2003:ea:8f33:1e00:300e:33dd:b203:22f9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47781644d87sm3420215e9.2.2025.11.10.13.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 13:20:25 -0800 (PST)
Message-ID: <45f644e8-2292-4787-a27a-f69084c93218@gmail.com>
Date: Mon, 10 Nov 2025 22:20:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [PATCH net-next] net: phy: fixed_phy: initialize the link status as
 up
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

All callers initialize the link status as up. This change is in line
with how of_phy_register_fixed_link() behaves.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/fixed_phy.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index 32a9b99af..f50607fb6 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -144,13 +144,11 @@ struct phy_device *fixed_phy_register(const struct fixed_phy_status *status,
 	}
 
 	/* propagate the fixed link values to struct phy_device */
-	phy->link = status->link;
-	if (status->link) {
-		phy->speed = status->speed;
-		phy->duplex = status->duplex;
-		phy->pause = status->pause;
-		phy->asym_pause = status->asym_pause;
-	}
+	phy->link = 1;
+	phy->speed = status->speed;
+	phy->duplex = status->duplex;
+	phy->pause = status->pause;
+	phy->asym_pause = status->asym_pause;
 
 	of_node_get(np);
 	phy->mdio.dev.of_node = np;
@@ -174,7 +172,6 @@ EXPORT_SYMBOL_GPL(fixed_phy_register);
 struct phy_device *fixed_phy_register_100fd(void)
 {
 	static const struct fixed_phy_status status = {
-		.link	= true,
 		.speed	= SPEED_100,
 		.duplex	= DUPLEX_FULL,
 	};
-- 
2.51.2


