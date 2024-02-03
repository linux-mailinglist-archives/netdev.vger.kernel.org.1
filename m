Return-Path: <netdev+bounces-68805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C8084854F
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 12:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BAE21C224D9
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 11:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A701CAA3;
	Sat,  3 Feb 2024 11:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSvzf4m6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCAB1CAAC
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 11:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706959268; cv=none; b=joJvCLKQrWqpkSmgEswYz7v4YhQMl9BZN3/8SMDCiqFmgfKqoPKc6fuFqkNiFNioOrz1OhGwD/xpbEbKD8dQRgSPMDMDailvHUlit4/tAGT7O/52Zfhp3v7+QDLvMESJ6YBhCXJCoY8BTj11HrxTjhkr8S9j57Kg7W5a5Z2QxfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706959268; c=relaxed/simple;
	bh=kkdhy42RQoxGvS2aa4zV7RcKFbjKu2+O/+HVe6dsd+k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Du/P5kIT0rGGZ9WJIVje4iu9enrwou8ObsswU+djUZQSI87pVp6w+6vc/amrGknHyrHcFV45rQ6Y05r3W2169YmnH9kFJNL27gvJCi6Cu1UDl5CFo29N/KeHGvvgTmCZPll2rSAPs0M2B2Ql4sD95Qx2ADjij162LCSInuyegos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSvzf4m6; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5601eb97b29so565858a12.0
        for <netdev@vger.kernel.org>; Sat, 03 Feb 2024 03:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706959265; x=1707564065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kLVk9kI+Fh8dU+5aqkcIljCjYeBZbKjsFVpmVoRZeKU=;
        b=fSvzf4m6OKah1X2Npr30RTfPp35NKL7eFhc7lCFkmBW5cJ3WxhAXrz7/3vVDwH363/
         I1WtN5KY15zJ8wX1SmQYCjhr2vhIB0KfygMcEE/jxNslekL3hPzEeRMfehtlMyuYM8lJ
         ns6H7UlV8A5jWEW9ikF6cSw/pzu7U38Erw/plLl52EJKZ/XjATa8QJENc1LKty8doXEf
         qgYIkCsCl3HinpRfAvvckG8+qQJ3K1941rXFIGkXnTAWGtuxaQClDwB7rN7I10GbxLSa
         o4uYWKTY6MP/Z2H0N7Pqdtu2aFwex9+AeD3Sy1P1peTyf7PXSGWNhbqwj+cU4YqF/P2V
         IDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706959265; x=1707564065;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLVk9kI+Fh8dU+5aqkcIljCjYeBZbKjsFVpmVoRZeKU=;
        b=CPujhATSGfaaACFoDpVMeJyCyJ3wS6DENSKcXE5k/Rt2lURgDlnJGN+qaWycPiUjuL
         EhGWJy9ksTj+4NuUfAEFNtdXh+umKcFohKWGCTvPluu4gQO2ICvDSHs8CQC80w0WflQA
         zmOrQqONUDuH+YrXHmI2PlLT610P/0poaaS+ULWK8OyM16k/JvTPjo5H7eXUxmvIC/Lp
         P4Wt4P3AeaACpsNVHS28aR51+0vAhQ0bRdkQy0oIA9VJeINOnI0E2lgpFwJzZjyhxGIX
         u+Jc5mgFA1ciTJzDoFUYu7G2rs/RQycrshtfCcq18II5a7Z3VA2SF6EyjwD6X2y/8UBI
         2i5g==
X-Gm-Message-State: AOJu0YzbHb0xJ76I5IPkUkmeIjbvwZix8M0oWv/J20RLqatwyj7kJ0S+
	nGoSSGsD5AuA2Zajf2Feh3eyxW6UYs4CBEcdOOuFrGlW/mnnTzhj
X-Google-Smtp-Source: AGHT+IFNo9EnU1xhW69DsjTeUoFokWEWjy1WpJFKia7nzsdLVUNag3jJPfxjrlJMJF0a7I3UZa2ksg==
X-Received: by 2002:aa7:cf11:0:b0:55f:16d2:46a8 with SMTP id a17-20020aa7cf11000000b0055f16d246a8mr1290878edy.3.1706959264966;
        Sat, 03 Feb 2024 03:21:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWTMs54ER5wbZ571PigJ2/xkAAt3i59qdTsf2NPRPo0J/y9Avc3CkQ2qJizHbpmjTfazMq+Dv6hHGlzCjcrXqgHMzMyKN89nh0FdvhDydfEHQ5J2TukEQFrOrzd4K3+8VpTdeiPWVMiWU14YfOAPIW2nr3QjMsZRzlE7ysz3lVqdG0Pjs/X6RnekL3YT97ub2m9ACDxk2FfBMlw6AU+mzMB0OxKxclK
Received: from ?IPV6:2a01:c23:bde4:a000:48dd:a4bf:88d3:e6ac? (dynamic-2a01-0c23-bde4-a000-48dd-a4bf-88d3-e6ac.c23.pool.telefonica.de. [2a01:c23:bde4:a000:48dd:a4bf:88d3:e6ac])
        by smtp.googlemail.com with ESMTPSA id g18-20020a056402091200b0055ff4a88936sm1380915edz.41.2024.02.03.03.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 03:21:04 -0800 (PST)
Message-ID: <4a963539-80f9-4e85-9731-b41281eafc63@gmail.com>
Date: Sat, 3 Feb 2024 12:21:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 2/2] r8169: use new helper phy_advertise_eee_all
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <14ee6c37-3b4f-454e-9760-ca41848fffc2@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <14ee6c37-3b4f-454e-9760-ca41848fffc2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Use new helper phy_advertise_eee_all() to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index c70869539..b43db3c49 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5091,8 +5091,7 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 
 	tp->phydev->mac_managed_pm = true;
 	if (rtl_supports_eee(tp))
-		linkmode_copy(tp->phydev->advertising_eee,
-			      tp->phydev->supported_eee);
+		phy_advertise_eee_all(tp->phydev);
 	phy_support_asym_pause(tp->phydev);
 
 	/* PHY will be woken up in rtl_open() */
-- 
2.43.0



