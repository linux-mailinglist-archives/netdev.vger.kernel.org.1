Return-Path: <netdev+bounces-175112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A77A63591
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 13:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A7B816F98E
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 12:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ED319AD86;
	Sun, 16 Mar 2025 12:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="e/sZv+ZJ";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="KG0QREhx"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7192AD02;
	Sun, 16 Mar 2025 12:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742127470; cv=pass; b=hZnyG3ppONsQvHmsqcpvFAz05deywRX7REhkoOt+rGwatiz63d+sRBtDH3UEO+6ri4F/t5DWcGuG3m22rdMpAMKjgsL/aE3WuaPvv1pe5/zCWXBKioOIYI2fVSUL/smekulPWKHN1GRr8Psz7m4BgaZI+lVr3BVodRtS9IyA0zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742127470; c=relaxed/simple;
	bh=L7+xky7iBDJHO+ZZyfUqZJ3J5cEYq4fNqY8pyONnYA4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pSfn8gNTybm6xb89wFY6uCIlgQL3klHzVwYgmBJ7IaI/KDJxPJvNn/CBHbGKmyJwuPRY71a3aWJKY1kL6FxbhsNxWvE8uUNoFXRo+sv/Ds3R7UNGeKwX2DwHRy/EEfs3Ei1vkMOBL5xOe/1B9mCW9u8TFdaxWmcbAgG4JlFtUJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=a98shuttle.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=e/sZv+ZJ; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=KG0QREhx; arc=pass smtp.client-ip=81.169.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a98shuttle.de
ARC-Seal: i=1; a=rsa-sha256; t=1742127277; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=r8dn29j2ps8PTqLSk0GOECvitYf5PyUkuokQEKsJlK0sZvqdawbaxfF0iVqOwWBS7L
    By5QRklwnDCdIX7tUeqpiZookGspnZTl4azjzJVtvhrNhzrfqsuPYnPU2IQI1eHVHuPq
    opjTz8lhJKrODYXvjPBEK/+TuK+TrwJjihTn2Zt9ypgj9er+hcJFkRyP/pZzruwZZddr
    3KSCojp5ajq4Fm/OjjVKWRBjiy6ijJtpFgXNtw17jIr1swQGSTbtZ40k80gDfbUTYaJK
    UBfcMaG5AL+fgkhZudVkapJ3Oga5A7QjCw7y019jXoDvjqF2c624n+A3wD4X7Cgc1QBu
    JtpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1742127277;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Q3PPnZYsYDVMqrvC+ImUKBBxiBgnLPhrJkzzrUE7oeU=;
    b=iRRl79TJaFQio0eX5AbJ4xhVewC7qjJkc4y0/u/WVMXWUmzFB4jDtK0mADNCAnXrSY
    c7PwKqnPWcWI036fI72QXAYUg2QsbfTYAj8IvUEXnYOSNkqhxdwmvsTYaMQPE8FZLn9q
    m9yCxRAb7APIF96XXhUHPOHWEy5MUpugXvOLcniBkZJR+thvVVgAZnpF5ubV6BIzOhox
    zgGxM6ASqvGdqkL3/heHynvBAegviJd7Fp3cJCy2pV1NCubJ39ym3x7juYBm8I7mTYiM
    voL0oG8ViyE9dFieX/9UttB2BJjcsXd0WlrLrWltgH6jC0+7rNNrbO2NV0C0XPHDpuWi
    DWRg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742127277;
    s=strato-dkim-0002; d=fossekall.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Q3PPnZYsYDVMqrvC+ImUKBBxiBgnLPhrJkzzrUE7oeU=;
    b=e/sZv+ZJTZYNN3VxE6FuhJUjQ2rqG8ST7pRtBIDpolKdXMYflVmJ0NOePFQTJ8fD9V
    3zTY6ipPp40+whcggdYuc2l8L2ErkbdOMVxknqChVQYJxld+bfkLSQayNhw3I7BBpZFb
    byjB917AEcRR5kioB5B1MuZbdeuZnSbmM3ECoNFlJenPSbNBwZ8LI6ayeoaXREQFi5pT
    IkRGHjKGmz1JOgm737w01L4yyviF/leh1kAWv2uTrhGO9X7z6oNIFpos5VSWVUnnNRFQ
    Kj8wKBYywgP6cX35Nc0VK+k4FPxQdRK6U56U9VrfJzEbSMDkf0QyEQ3XM5FPT5EfaZaK
    34yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742127277;
    s=strato-dkim-0003; d=fossekall.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Q3PPnZYsYDVMqrvC+ImUKBBxiBgnLPhrJkzzrUE7oeU=;
    b=KG0QREhxknY/KOLMtsHf6XxNrwkqhggo0nl5YRk305yCd3pzAxlY3PRLW5BddxOIy5
    uNPL/BL5MLomxduGhWDA==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b3512GCEb8gr
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 16 Mar 2025 13:14:37 +0100 (CET)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with smtp (Exim 4.96)
	(envelope-from <michael@a98shuttle.de>)
	id 1ttmt2-00061f-0X;
	Sun, 16 Mar 2025 13:14:36 +0100
Received: (nullmailer pid 82540 invoked by uid 502);
	Sun, 16 Mar 2025 12:14:36 -0000
From: Michael Klein <michael@fossekall.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michael Klein <michael@fossekall.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net-next,v3,0/2] net: phy: realtek: Add support for PHY LEDs on
Date: Sun, 16 Mar 2025 13:14:21 +0100
Message-Id: <20250316121424.82511-1-michael@fossekall.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Changes in V3:
- move definition of rtl8211e_read_ext_page() to patch 2
- Wrap overlong lines
Changes in V2:
- Designate to net-next
- Add ExtPage access cleanup patch as suggested by Andrew Lunn

Michael Klein (2):
  net: phy: realtek: Clean up RTL8211E ExtPage access
  net: phy: realtek: Add support for PHY LEDs on RTL8211E

 drivers/net/phy/realtek/realtek_main.c | 174 +++++++++++++++++++++----
 1 file changed, 146 insertions(+), 28 deletions(-)

-- 
2.39.5


