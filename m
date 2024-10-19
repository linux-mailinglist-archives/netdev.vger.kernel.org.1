Return-Path: <netdev+bounces-137235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11FA9A50B5
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 22:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0F4E2841AA
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 20:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747F1190685;
	Sat, 19 Oct 2024 20:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqGBTlbZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAE51917CD;
	Sat, 19 Oct 2024 20:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729369016; cv=none; b=pLeX+gFwMoReWKq3xPV0FxfZoj7khilAMFtZt3eDVvERK6jSA6pKZ/SBjj0imcmwjb72DV7aWGcS/CDYCJYs14CrpVigwX608dkJt7WXo4Vy1rFMzVdydoEf/UXhJ3DHVkRT7GtRfg0obTA250rtczzt4FNk+R+MhaQ8BBjSCEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729369016; c=relaxed/simple;
	bh=WGyWuzIPw0J/dmy6own3hVDgAgVliWmQ/oQWiEc2R/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CJpfcKSQgDwYnVzry3rQ85dgDA0Mj4vV3ehW33SD0Xz9EO9aJSiHDCRT1SkbRpnuKVuF5Sbcy2IKfCeJEn88qv7FGZIQXbZkjLe1gtj+V5bNHIVDEq4ntjJh74Q/Eh1WNylRxsb6C/Exqk5MWDANk16jm8FrJQ2vDDA7zy57YPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqGBTlbZ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d58377339so3469524f8f.1;
        Sat, 19 Oct 2024 13:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729369013; x=1729973813; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gCFUfAS3DdB6fd3tKnHrbKzJIT9FSusJvapqVdNoyss=;
        b=CqGBTlbZStR/APXQANTdxHcCsJCRAp8yY94zjvCtrsKj2mQTIo7pwmiibC+fRpWj2Y
         oeCrKSzO0oTVV9+bjkCvVAlkemNa9mcJ6Xp+eHI1tuKnNm1JYUIMx3CpwJbm1OzwoAdq
         9Zxlu1/CfAG3XAJpfptCvpBzfd6fF5kaxF1IYJK7qxX9qlxkp7M2Qd/afc8qz1lD6AR9
         xZRhft2eITtmfnFweEdHxiOC1eO45KkHHwbmY7nl7gNwCtal+c+r9k2doV5UJTiPCTWY
         c8rZtF8KUVNXvFGNAzwvSyrMnQXRD1HTesJr5bxNN+b6MVJ5vat5FMiDjJm1R9d9vgEe
         wrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729369013; x=1729973813;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gCFUfAS3DdB6fd3tKnHrbKzJIT9FSusJvapqVdNoyss=;
        b=KiKvXMZUb8I8G1SxWPIxXbQaORmf8sm8jj3QdsGAxUSWc3+P1oWvsNnaIWkhs9MLCp
         Hs02lWp52uTTG87okDW41RcJZ1NNzuHyYm0pe8yEMr5JvMN8RP4Kf0RqT9ppPyzTQN5a
         yFPrumQvD95CVApGdF+MejfEb8R/S5ToQ5ua+K+ADS8K2cajof2+1AMp/fuv8T1t6zDc
         VerHOoXt86DE5f3/GbcHgHhhUAyx1fboEV/dcK8I6/FA6nUUYWHyxDPuO0wIaZEbQ89Z
         68BLMpI5yzfu6mVACUXv/SddOwHahISLufqQFgMx+J8zdj5O4SWI67cOY+f1cYkdI8lD
         H/ug==
X-Forwarded-Encrypted: i=1; AJvYcCXHC4R49Oxsqe+Z50w+pP2w1Y0Rz+LOQ8RoqKp1BuWrr9Gj0a1w6l1n1gDuK2o29ONx2fq51m/LO7n4g6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF3sAIr1f7Um496gd+YaLY0RBV1Tr1tWore9WG2BFd1S0uCJX3
	xQc+CtAHOVJSnva2uD8PAYG3iISVI1Al163yFFWMqKrNKwX+FdoI
X-Google-Smtp-Source: AGHT+IHlPmb8yCIvpKBKucnd7AvPyW0lCLtMxnj8KwmpqNXihHkQRUEv9kMi9WCwmrbrcHvaLPc+Dw==
X-Received: by 2002:a5d:4d01:0:b0:37c:cc4b:d1d6 with SMTP id ffacd0b85a97d-37eab2e3550mr5411985f8f.27.1729369012589;
        Sat, 19 Oct 2024 13:16:52 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-f8f1-d6d3-1513-aa34.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:f8f1:d6d3:1513:aa34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0ba7923sm248838f8f.114.2024.10.19.13.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 13:16:51 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 19 Oct 2024 22:16:49 +0200
Subject: [PATCH net-next] net: dsa: mv88e6xxx: fix unreleased fwnode_handle
 in setup_port()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241019-mv88e6xxx_chip-fwnode_handle_put-v1-1-fc92c4f16831@gmail.com>
X-B4-Tracking: v=1; b=H4sIALETFGcC/x2N0QqDIBhGXyX+6wkpTdxeZQwJ/aofmolaE6J3n
 +zywOGckzISI9OzOynh4MxbaCBvHbllDDME+8akejXIXj7E5zAGutZq3cJRTN+wedim+hU27kW
 Mzg3wUt+VNtQyMWHi+l+8KKCIgFrofV0/hqusG3wAAAA=
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729369011; l=1147;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=WGyWuzIPw0J/dmy6own3hVDgAgVliWmQ/oQWiEc2R/8=;
 b=VXShLh+GjX3fmLIg3jWVw83lQq8hHQzNHU8k3ZJBh4Fq24kLiDox/H9qobtth0Tzbj/87Jeqr
 r2poxqkm5JLCgMQ6d7Lee5zNG56jZ6canCBpUrkUKspiLBXdYacwih8
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

'ports_fwnode' is initialized via device_get_named_child_node(), which
requires a call to fwnode_handle_put() when the variable is no longer
required to avoid leaking memory.

Add the missing fwnode_handle_put() after 'ports_fwnode' has been used
and is no longer required.

Fixes: 94a2a84f5e9e ("net: dsa: mv88e6xxx: Support LED control")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index da19a3b05549..8c6797af8777 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3379,6 +3379,7 @@ static int mv88e6xxx_setup_port(struct mv88e6xxx_chip *chip, int port)
 				break;
 			}
 		}
+		fwnode_handle_put(ports_fwnode);
 	} else {
 		dev_dbg(chip->dev, "no ethernet ports node defined for the device\n");
 	}

---
base-commit: 160a810b2a8588187ec2b1536d0355c0aab8981c
change-id: 20241019-mv88e6xxx_chip-fwnode_handle_put-acc4ed165268

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


