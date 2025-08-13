Return-Path: <netdev+bounces-213498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1EAB255D8
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 23:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA15A1C218FE
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 21:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2232A30AABD;
	Wed, 13 Aug 2025 21:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jC3hxsZI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C942F39C2
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 21:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121397; cv=none; b=MEsXMbOFlgt/MRhRS3azm9bZUYjT/A3FOJKIBiDSeEYCNM+g/RWSQYK7evN9crtMdN4aYqj/AOFI/+qumeRVKdv2NojiWdbT4vnzTNda+pxcSlYShJWSKiKZZfqF2VV5WB/ijCoSeEcfN59yRMvbYIRGkw13LlDduqPeAUtdMzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121397; c=relaxed/simple;
	bh=Vvo/5JqhMXbiCqO6GcSyQizZiDGf/Z7J+mCwmBOYrEA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZdxLeYYjnI4v6x2iLXk64SOIxka287HqPLvHrO/rw8U0O+e5rPJCeAR1AQnyTiOG7ShR4lSSaB6xjlH+t3xKzJ+50R86j21m3dj0cKVf/QV33d4ODDF5hMy8OCTH6QN1z/yZ7qgtvSjTqCguriJ3ZkFrdRnajKQw5VhXgw152do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jC3hxsZI; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55ce526a25eso254904e87.3
        for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 14:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755121393; x=1755726193; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/dPxmQBvlzWHFqJ6KNvyKX/i0RNLjnVc5VfRu7Spc2Y=;
        b=jC3hxsZIopkcQoqX5Xqri2xWbrtucaF8zl0eiEZ5On53354HO7HDTus/fh2juqYUlN
         883p3Oz9W3fPxmX5XXhhkKHbCkB4OR6JQE0GAg6MMpcq/fNMT58P54LTF+qWiz10qIOi
         IPFC8sUVjZkQPqW/M1pZva0PkbJe3sHJ0oJBj7glIlkRb76ZCKPDh17RJ1Lidl01H9lo
         9q6qYw0g4XhcW3V7JzBMzflmiUtpvztQbIh7tU5LIgj6WeKyw9bv76xhUooqRKzruxgl
         c+v05tlJHinRiUusLVgjoyY6MvRqZD74GLQO8j9arphkaMHsQUXwvlJSaduP8kYmNL3A
         uTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755121393; x=1755726193;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dPxmQBvlzWHFqJ6KNvyKX/i0RNLjnVc5VfRu7Spc2Y=;
        b=jokGtn3FKLsfGEhT2eq8vXCqwB907yDJEP2QfJlVqMawQWtAvAEskfnjeYBWeoURCL
         rmkHlfCSXHznjlm+AJGde1lQuAwlhhO0aIDjWL/pj51LknWsGUggCjj7airHGEP2oH+Z
         RnyS2HkgXiD++k99AbcAt7Aac6TMLY6IbxAFdM4lFFyWoyokSftORDtpw3j7FNTo8W9B
         Ix3KoQ7fB8dQeK7ZEHGEOgxl+BIU2mQreLxLmC9L7FZzx5hwkGfOWIC6xR+/v/kxJ5MM
         5jgQNyA4tn7DirIbyS3HrjbL7eq1NNmnb0Og3Za1oMI+E8Pn6UhLZFsqz9eAal77z+rZ
         jDXg==
X-Gm-Message-State: AOJu0YxA0hKOky0SGc9tkIyGDWTplaHPkf8hkQGTk6Ku1218ahC5Amew
	Q/UeIXXQJtcUAVJfgcWPvNZttQcJP6UFqImAh+tYrqUh3CGmJTxOpyCCbo0LON+bQvU=
X-Gm-Gg: ASbGncvDJ6koO+5dq0Ijm8KGbiAhIHke1OjnjQjTu/YuauMUr4dw1ANQvKOxiFao5u1
	2Ql/glIvHQxa8u8WRMfEA+a0Wd8z38we2hUQ6Smm6Iwt02WQg68NoAxS2+xRZanlh4mOoyIQpSW
	CDAQPMyM0/h5jWGSXuIJQwicpUeXmwu5daM+CQziRhp/DgyDUc55GsBb/UQAoVVuQ3H+ly1xDnf
	Ab5n38B9NRfHoEXVKKGgHu4uCLtYFxu9jbfpSjTonA5+rsDSg6Zs5y1brMU2IdknoN2k2Snrzjb
	4iNwbRhhchqM3JXKR+6JSlsj/sUX6ulVT1JlAc43w73kklIp0sTe/zqNOnaRM/gO/VizWcvznoQ
	To+eWKuzZlHWoOggG0rkllcJv3xx8x5Sw9usL5g==
X-Google-Smtp-Source: AGHT+IF4oj2CbSdjQRL12jdzZLLvK0pz2NS2lTic486cDhYRjw10R+9jWPvuwYsO1/KaP+c4l/bI5A==
X-Received: by 2002:a05:6512:3a8c:b0:55b:910e:dc1d with SMTP id 2adb3069b0e04-55ce4fede36mr278786e87.16.1755121393076;
        Wed, 13 Aug 2025 14:43:13 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b95a105d4sm4732918e87.160.2025.08.13.14.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 14:43:12 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 13 Aug 2025 23:43:04 +0200
Subject: [PATCH net-next 2/4] net: dsa: ks8995: Add proper RESET delay
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-ks8995-to-dsa-v1-2-75c359ede3a5@linaro.org>
References: <20250813-ks8995-to-dsa-v1-0-75c359ede3a5@linaro.org>
In-Reply-To: <20250813-ks8995-to-dsa-v1-0-75c359ede3a5@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.2

According to the datasheet we need to wait 100us before accessing
any registers in the KS8995 after a reset de-assertion.

Add this delay, if and only if we obtained a GPIO descriptor,
otherwise it is just a pointless delay.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/dsa/ks8995.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/ks8995.c b/drivers/net/dsa/ks8995.c
index d135b061d810b7ba0c0731d43d176f3ba46b3f52..bdee8c62315f336e380313558c66127ff0b701d3 100644
--- a/drivers/net/dsa/ks8995.c
+++ b/drivers/net/dsa/ks8995.c
@@ -438,9 +438,15 @@ static int ks8995_probe(struct spi_device *spi)
 	if (err)
 		return err;
 
-	/* de-assert switch reset */
-	/* FIXME: this likely requires a delay */
-	gpiod_set_value_cansleep(ks->reset_gpio, 0);
+	if (ks->reset_gpio) {
+		/*
+		 * If a reset line was obtained, wait for 100us after
+		 * de-asserting RESET before accessing any registers, see
+		 * the KS8995MA datasheet, page 44.
+		 */
+		gpiod_set_value_cansleep(ks->reset_gpio, 0);
+		udelay(100);
+	}
 
 	spi_set_drvdata(spi, ks);
 

-- 
2.50.1


