Return-Path: <netdev+bounces-234652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 238CCC25330
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 14:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC6D64F9903
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 13:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3908834B1B3;
	Fri, 31 Oct 2025 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WKUuAA8u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF6E3446DD
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 13:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915908; cv=none; b=gLgflhqQUgAJLhdVY+/+k80mS4T8BrZqHI7ceBDzZRRfccWoDNxkJiAANdwOkiZUrCqsh6EW0sUnjVXhynqzxZOVnZMu3SifPbZizjRVHyAElrkkLU0I45TLPRdUF/vy3QWuzXOlkoEVAXOKVZ/suMutuswiywzjbKNDN+wm6gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915908; c=relaxed/simple;
	bh=ohLTL0SvpZNw1YyqDgj7e+a1xa9YzqNdtbvCbNOK1Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=h9WU1G9DfbuKixeJs6FIPlcuA9EjAvXG27ujzbJ2y/No6QBV+qkbQTuY1MiJ0i2XV4t8leII8xmzp/j21bzVcrfcT8xivBG2AeQMo2+DwTMkQI7xJ/uF6C0Htqhr3CYaoS5qHWNoqhVRQuG1cJX97HHzifNk0XtsU4nHZyh9Osk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WKUuAA8u; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-471191ac79dso24719035e9.3
        for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 06:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761915905; x=1762520705; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+w8jqf2lCxSEA+gKuomLF8ByPnOiEIRxtEHIBbMby5M=;
        b=WKUuAA8udu4w586zlyk6R83XVRBVK+QbQAx10NwNt6RXYxYb/rEHdS6kcQLMkhG1pv
         9ST5l8+qPAVXWBA9LM/L6FzfRAi59AwCAdYofww4RJwxavGQanzqPztneObNQdaDHaXV
         HpXv1x7zBi8oiF+74ID3GU1cySw0/PllMzxNhhy7QP1bvwX/qyrziX5gJaDdZrRQ8wdo
         4adrxPwtiCqtcwCAZuOQiKPr3wdDcdciJ1m3cqASQA18cSTGmHgPLr0ON7tC3MXQ7bzC
         ygiH3gQgRC6yVWDCbdAMGfB/YKmj90Gn76+AtJ7qUCBmlo2qDGFyJC+1f0s2ccN/q/Xs
         sj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761915905; x=1762520705;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+w8jqf2lCxSEA+gKuomLF8ByPnOiEIRxtEHIBbMby5M=;
        b=veNtL2d0Laosb6sP+ea3CGOegV0e0Ap4OUo5H1m5Kxu+RbHLd31m+LRV3AywW57il8
         p/glQK7+PJmBtVD7d8GdMuzKXeAROs4BwWHqSART9BDatHTWHAGvWNAUvnuE4XVOobih
         y7xj3DjX5TSNsyzaP5Et7YLAB6zGYvvetdjofJpZNqqvfpakvDdDaQwgE1kAnf20GuMB
         isvmIPy0JtURK5AwFJN+yg4Sd3gBzpNUytpO3dBFaX/ok0rXaFvNSOgFkQaWYL9GlbIK
         82oBkHx/7Z2/odVyBnC4MIlfL2LpEyip0Y6YR0x5IxD927sW67cLPfIGpj2OHpFv/8JU
         Zd9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXxIDb28pci5zjlnfLC3c6/LFe/Wx960aoIfoSHjSAoxkUZRQ+9hGrCdqrTJMax3/snDG/xHy0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8kDdH9D3uTp6fPAWjy3m0WUHkmvW75FPC9FBpeR5ow34X5oVG
	Vvar89CjUpe9nIV2IyamN5IxMCCQh83ykEe8lwKHc6lLw/YCUlfNOFD12E7ry5N7MQA=
X-Gm-Gg: ASbGncske57P9E9xYhlKCG7E9cakhJF29B5JGYtsrB5O/8G5B/trhan/87W952h/mZ6
	QKJR0bc3K8AvbIOgnaopveZQaDlkwjJNV3p+/+JqkmiqOeJCX7amB0E0OtVbrV/fbn4ZCrSHT1y
	6AL/sL1tCp4AH4bhLDAIGJ1MsDVIGt0koSdxGXdT5JRS5oRqqpL2EPSV1+1sJXqExkvkWCDM9o5
	bDZ2i1O2uUeJLIx1Xt1JCa7taqQr+o3nWYb0e8npiSYGwlt1RkAraMnlGjSKRRNH5tYbOHkClOq
	JfLPnsi0h1OWZBXxGY36txDr7Wcr2oQtjs3psqnevVOd+1tMxaOu6pHUTmMccVp3N5jGaA1s01q
	uiE/DDAh8ZiVMHNYvgJ64sTwTFU0ZZhHMtF4HN8ERr1wKMi2rpzFTGrq9+UVd/qj5j/VreBfGVB
	GxMGjPo/cnnUjF88+n
X-Google-Smtp-Source: AGHT+IEJtNSHRo+8kbxShLrSYoJ1sltDyk37yajDo7sugoAhpxuanGQrpoVYtZmOoClzTAqz2jv3ug==
X-Received: by 2002:a05:600c:a44:b0:477:df3:1453 with SMTP id 5b1f17b1804b1-477308cd816mr35529135e9.28.1761915904754;
        Fri, 31 Oct 2025 06:05:04 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429c1406a45sm3485008f8f.47.2025.10.31.06.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 06:05:04 -0700 (PDT)
Date: Fri, 31 Oct 2025 16:05:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tristram Ha <tristram.ha@microchip.com>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net] net: dsa: microchip: Fix a link check in
 ksz9477_pcs_read()
Message-ID: <aQSz_euUg0Ja8ZaH@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The BMSR_LSTATUS define is 0x4 but the "p->phydev.link" variable
is a 1 bit bitfield in a u32.  Since 4 doesn't fit in 0-1 range
it means that ".link" is always set to false.  Add a !! to fix
this.

Fixes: e8c35bfce4c1 ("net: dsa: microchip: Add SGMII port support to KSZ9477 switch")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
This is from a new static checker warning Harshit and I wrote.  Untested.

 drivers/net/dsa/microchip/ksz9477.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index d747ea1c41a7..cf67d6377719 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -244,7 +244,7 @@ static int ksz9477_pcs_read(struct mii_bus *bus, int phy, int mmd, int reg)
 				p->phydev.link = 0;
 			}
 		} else if (reg == MII_BMSR) {
-			p->phydev.link = (val & BMSR_LSTATUS);
+			p->phydev.link = !!(val & BMSR_LSTATUS);
 		}
 	}
 
-- 
2.51.0


