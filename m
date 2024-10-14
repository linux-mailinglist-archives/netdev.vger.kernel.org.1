Return-Path: <netdev+bounces-135103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A2299C41F
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 10:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52E0BB28988
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 08:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576CA156F39;
	Mon, 14 Oct 2024 08:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8TsLn/k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB12156C5F;
	Mon, 14 Oct 2024 08:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728895955; cv=none; b=kZRYKhnyeunKt5pFnGQLqt4p2nvy/TsuQsTyUYio15rscrptmtB2txy6IqsXDhWc4IVe7v76Ul0LebNbsegeyunS2bvSHvIRbwQ4ck5059lXVCouSUElVlVlG/6gommbj2hX023doWXhjfB7M6pvk2efEgc+XCroi3+zvmsglnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728895955; c=relaxed/simple;
	bh=HQ32Tdu74SJVgjzD2QAR/pXuhPtNi59PWTlnaGaArpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J+n0VBQbvaJ2j0LIcBX1Lcq7PRsMBA74WhWfLZzhYqexZ3aMo1pCslX63tqJLFA6x7WYg5Ym4NOH/I+PPPvGliJGUc/Pp1w1yBWyVg92+KRypGQSr4wT+1cOUducP7OcM7vJpiNHFN9DdAd78JXJt9XPcsAwg/Vf/ZXCnT06Kzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8TsLn/k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEF3C4CEC3;
	Mon, 14 Oct 2024 08:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728895954;
	bh=HQ32Tdu74SJVgjzD2QAR/pXuhPtNi59PWTlnaGaArpc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y8TsLn/kRsVNCySZ837YrD6FTalwxIrbxCQQ1teZq+PM4TBmjZi0st7mOxrC7YBMz
	 orOc3/F+JVlK6x3Ti3Hoqui/VRP+z75ezSy6Bkmp/Z7NnOF2gWzmXlLocqFTdJ5Sa2
	 CfJ3tphBiDPcXbukcShzKsYpBawCnxL9KgdCEGPVAIheik2l0LSbe6H1PHTvF5YyBj
	 qspeIryCMj26HTD9DE7X2x4DO7rq+S9+KoC4HcE7EwjyGG4AKfLGWEOF4y0V1/9SSl
	 xgYDBGMnBxxR731WdQggtmAsDGcBqguhzDAonxkuhidxVyAK8x/9jOE0AZiFo4Yopv
	 wAUgAUVWBdNDQ==
From: Simon Horman <horms@kernel.org>
Date: Mon, 14 Oct 2024 09:52:25 +0100
Subject: [PATCH net-next v2 1/2] net: dsa: microchip: copy string using
 strscpy
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-string-thing-v2-1-b9b29625060a@kernel.org>
References: <20241014-string-thing-v2-0-b9b29625060a@kernel.org>
In-Reply-To: <20241014-string-thing-v2-0-b9b29625060a@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Bill Wendling <morbo@google.com>, 
 Daniel Machon <daniel.machon@microchip.com>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Jiawen Wu <jiawenwu@trustnetic.com>, Justin Stitt <justinstitt@google.com>, 
 Mengyuan Lou <mengyuanlou@net-swift.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 netdev@vger.kernel.org, llvm@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0

Prior to this patch ksz_ptp_msg_irq_setup() uses snprintf() to copy
strings. It does so by passing strings as the format argument of
snprintf(). This appears to be safe, due to the absence of format
specifiers in the strings, which are declared within the same function.
But nonetheless GCC 14 warns about it:

.../ksz_ptp.c:1109:55: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
 1109 |         snprintf(ptpmsg_irq->name, sizeof(ptpmsg_irq->name), name[n]);
      |                                                              ^~~~~~~
.../ksz_ptp.c:1109:55: note: treat the string as an argument to avoid this
 1109 |         snprintf(ptpmsg_irq->name, sizeof(ptpmsg_irq->name), name[n]);
      |                                                              ^
      |                                                              "%s",

As what we are really dealing with here is a string copy, it seems make
sense to use a function designed for this purpose. In this case null
padding is not required, so strscpy is appropriate. And as the
destination is an array of fixed size, the 2-argument variant may be used.

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
Signed-off-by: Simon Horman <horms@kernel.org>
--
v2
- Add Reviewed-by from Daniel Machon
- Tweaked patch description, thanks to Daniel Machon
---
 drivers/net/dsa/microchip/ksz_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
index 050f17c43ef6..22fb9ef4645c 100644
--- a/drivers/net/dsa/microchip/ksz_ptp.c
+++ b/drivers/net/dsa/microchip/ksz_ptp.c
@@ -1106,7 +1106,7 @@ static int ksz_ptp_msg_irq_setup(struct ksz_port *port, u8 n)
 	ptpmsg_irq->port = port;
 	ptpmsg_irq->ts_reg = ops->get_port_addr(port->num, ts_reg[n]);
 
-	snprintf(ptpmsg_irq->name, sizeof(ptpmsg_irq->name), name[n]);
+	strscpy(ptpmsg_irq->name, name[n]);
 
 	ptpmsg_irq->num = irq_find_mapping(port->ptpirq.domain, n);
 	if (ptpmsg_irq->num < 0)

-- 
2.45.2


