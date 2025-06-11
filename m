Return-Path: <netdev+bounces-196701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4ACAD5FED
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 22:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D08171A50
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 20:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83B72BDC15;
	Wed, 11 Jun 2025 20:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/xEH+fS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D31E2253BA
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 20:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749672781; cv=none; b=gncNb3zrsm9M4G8sp5LHGkCLOIUCI8MYSVyMhW7AOU6gWchjN1ji37IpUBSVI6dNEWbiwHP9mq8cw57lKK1m4sREfUYNhcx45dgVbkEK/I3FHcZWrxGbcYLkMCY2rm5/OHo9mMs5FdBV5jFtjpny9xKX20c0DTXRRSM+9dwARnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749672781; c=relaxed/simple;
	bh=rVWiU5SUNwCGASGLXBn0433W3vwY3sV7U8ZG/wGRRkc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hP+lvoQ+9VyBcfQog/lzmTU7vzuvKqNShQ23jx4JwsgdqqUyfrfxcjcZsfPAEeaMvV9GdPKNwG0LG8tlrE2w8004K0FFl6mXT8bVY/nntin9W9imHjHwxaQLGYgVQouxox531FUzTOU3/VF6spKee4F5C6YH/g7Sd/Bsth+to48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/xEH+fS; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a365a6804eso165252f8f.3
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 13:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749672778; x=1750277578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hRy6jnBx6TXWt0oxmoX4k4HeerQmqfDd4zZx0mQ+r5E=;
        b=Q/xEH+fSp3odolqxFK3T5a9EqClLKquij35/bY0TJAAcc2POLCcr+V+mDgOnmcDeD8
         gIj5Gs0INSmQT7I8N7XnlHSviZoAGCpuyedlKAmzxQRHz2CuR8/EbTe9PowC5++2N/Ax
         P5K3HVPKlS76quQTkP3XPu1J6x78q4lXefE+PN4oL9WtFTTgGrPlg5exLsZCXBv1iR47
         wWxb+ZMItc6NWdRnZ/se5naO29jYngJ5ycHRFYyox+t44JXR6bjPrqP7sMgCTJuNQ7q0
         Ae4KcAElR3UzTw/qv8l7JQVOMLdSmjjKMXoYz9wiU7vQPXPe6nbTTpVnIKCjoidCewlH
         eQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749672778; x=1750277578;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hRy6jnBx6TXWt0oxmoX4k4HeerQmqfDd4zZx0mQ+r5E=;
        b=rjakyvJSdGHpggD5efGJiYhD7EfSe6BbMYuoXrzvNTQlKhyCfhW6VVUyib7w/YCRhc
         LTr6B/GXa8Dut0yV2WP66uzLidvkMKp7OJqTMA/npLdzzpu9eQYs8pcY+FaHdrSeELmR
         iDWUsDDqCPQTa3t+EU+9rIBaoeoD2yqC6WgSy4ouk5brtkr+TRf/09y4Bl0PKfsGMs5K
         SxEZgmJHMOWp9F+dtpMQIo87GYpK2wkmdXHjpHzL85aBKRznbwihatOemuR/3tTS/voo
         U0U/kCk0NUtWSU7vz/zIYNv+pB8UQRghZydMjrE81aTgP1D/ctnUp2y+S/pGNxvGSp8C
         HVVQ==
X-Gm-Message-State: AOJu0YxbcDM9Y2PZMOnGV4FVlvHW2qLB54VXpZ4LSKqoZif6vptjRn2T
	t3m1XwL0lOcbFSmXmdVaI20mxxlQjMpR6ed67Dv658fR+okSUhoYlGS4
X-Gm-Gg: ASbGncu0RqdIa9ilxwQGkOcowm6Hb0zJa7ErSTHklummuwP40eUia7oexvbPQ6YeSZQ
	DSg5qpgJUrdG6EP2tJC1OI0xeYVLFyifDmy7KWaI8/XU0Z/znWDhkVvDeogu748Ey4dR6f/cMUm
	zTvRmHeiz3fs4mXkSou1h/Ulcuoz+zY7uux8ZsFkOgvjWnFhcXzlYaY7yrFl/0aE5EzqCUMkTsy
	Oq/w/mymZzIWGs2l3bSSn/241SaqCRoi/DyyKrXhemM1xdQN/u4nd3rxy7L8w/25pn1Z9pYLD7R
	ey+QRkoVxz9MIIwxsxAzlBLi2NDR1IN50u7FlaIM/cvXvPxGIDwQF9e0IcQf6tyajeyHOqkvgVQ
	PJarBOoYCvSguoRTbae0aZ7CTXLevQ+jVwDGnw92NAkdsW4PCJTkSoM6EXskQPqSmkPENwWbN2v
	MaMP+dKQaQjPKRVeS+NRnrhQACig==
X-Google-Smtp-Source: AGHT+IHDCkdMZ9rOeSHpEdIYL3WSZSlNeioumEVjXS3mwn5j+ibNfJDxFv2YYAtKmuo9+96sW3zuRQ==
X-Received: by 2002:a05:6000:25c5:b0:3a1:f5c4:b81b with SMTP id ffacd0b85a97d-3a558695e45mr3837441f8f.23.1749672778259;
        Wed, 11 Jun 2025 13:12:58 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f1d:5400:69f2:2062:82e9:fc02? (p200300ea8f1d540069f2206282e9fc02.dip0.t-ipconnect.de. [2003:ea:8f1d:5400:69f2:2062:82e9:fc02])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a56198cc12sm14238f8f.25.2025.06.11.13.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 13:12:57 -0700 (PDT)
Message-ID: <af371f2a-42f3-4d94-80b9-3420380a3f6f@gmail.com>
Date: Wed, 11 Jun 2025 22:13:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 4/4] net: phy: directly copy struct mdio_board_info
 in mdiobus_register_board_info
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <6ae7bda0-c093-468a-8ac0-50a2afa73c45@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <6ae7bda0-c093-468a-8ac0-50a2afa73c45@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Using a direct assignment instead of memcpy reduces the text segment
size from 0x273 bytes to 0x19b bytes in my case.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/mdio-boardinfo.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/mdio-boardinfo.c b/drivers/net/phy/mdio-boardinfo.c
index b1e7a5920..d3184e8f1 100644
--- a/drivers/net/phy/mdio-boardinfo.c
+++ b/drivers/net/phy/mdio-boardinfo.c
@@ -62,14 +62,13 @@ int mdiobus_register_board_info(const struct mdio_board_info *info,
 				unsigned int n)
 {
 	struct mdio_board_entry *be;
-	unsigned int i;
 
 	be = kcalloc(n, sizeof(*be), GFP_KERNEL);
 	if (!be)
 		return -ENOMEM;
 
-	for (i = 0; i < n; i++, be++, info++) {
-		memcpy(&be->board_info, info, sizeof(*info));
+	for (int i = 0; i < n; i++, be++) {
+		be->board_info = info[i];
 		mutex_lock(&mdio_board_lock);
 		list_add_tail(&be->list, &mdio_board_list);
 		mutex_unlock(&mdio_board_lock);
-- 
2.49.0



