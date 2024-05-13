Return-Path: <netdev+bounces-96053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E808C4212
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 15:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54DF41C20F65
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 13:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D5A1534FE;
	Mon, 13 May 2024 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sRhkFym2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2810A1534EC
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607533; cv=none; b=hsTRoZnd8mj97lRK3D28qjOPUBnUfftqRjPofWA6yianPthBJxUuilVTWZlIsOtLRC/t1AR5VMBY/B15F95ejxF2JuVJlyjDUNLxtmKJgg4N8kGrvWq8WQ4DnYT9+oEr6QzCgzfQkEwq33b+SiYFtJtE6kD3FPe/Ta0itkxQnQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607533; c=relaxed/simple;
	bh=AEKf2hm9eO0+nDhH/ent8tNelXk3FBd5l342y4lOn/s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GIErK0K83zlqYCrS9tw4mrI+qjUzYd59ONFG1vnfGLiPws5khd6TYGrVYxBKDyWjBjbdJPP/luJHbDaX8jnPQF4dAnVttF2o/kZhln74PE4vbAOt5KROTbwZRMced4UgIlaZdfCOPWEq0on0RZnjJf0vlvHSK1RMktRKYnrD/So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sRhkFym2; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51f4d2676d1so4716897e87.3
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 06:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715607530; x=1716212330; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j+d6WkcJl1hJ21/tMXT/q5+gbY45Eg2KAsk/MVIxHRQ=;
        b=sRhkFym2vIIvjlS3Ci3V1HDFBZxcob1HMSAPIgiwetGGxXS76nxGqlAHzqbQpuViHk
         jVjApXh5VncjUvBUnQ7bgGC7DvKqHUetn0qykVEJ14AsGvaDbb6G7Ni9jnrLbyTa9kZ8
         UWjTVSwmTW5n7oxFSr9dgMt0GeRrEVNvmvopOMATrD90cbMXJ5R8HahOQgH+Ugnu7/Iv
         8DMrfP5XDHLfXWWbhOx5aBvNd6YMjo8O6INKZeQ9KIbT85m+tPxTkRXhHrVcs+c/4Jxg
         vPinrpvbpW27zfW1MavQsl/ZSK9S8DrvAgmtYFp4CuD//bbdY7to9WbS+XG+KTo8o9p7
         ptwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715607530; x=1716212330;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+d6WkcJl1hJ21/tMXT/q5+gbY45Eg2KAsk/MVIxHRQ=;
        b=MHffBvrxmTW6pjc0JsAiTIyYsNWgdWqa5crRTGnqhaQvHiDkBvoJEo6TOklf5Qp/ey
         3G0CWBi1eEWepJYt3MZRg2kATPHOOXDPPMqtTMQ9gLLQ3xpzxpBJDe1FwxDmKA4FvSaB
         0P50mnD/Tsp/8X14d2+UHfiZRK+UAC68u3E++6T1SeiVVlZiPGLbTqUgIkkyyk7q2GV6
         NLpDiCn/iyRQ0lYHBfdgJIr5l0/nkHE12vS5v5yvut3b3IBjTOo3q4Y7FNLo9F7ZasI+
         Y4oc9r2atp2V8rMDodYfUo5f6uwdkHv+7J6R0eXCGobBUGuW2xwz07C+ZkGt0saXVKhI
         0HhA==
X-Gm-Message-State: AOJu0YwrIFxFgiOAIJ40OwvCGIR8YTLsNwJfcRFmg83nTW+aP4w0p/wn
	MP3u+blcLrZV5ruR7poBkSrJKrFBr96LD7dcBF+996bkJAZ/YYOXWoIAdCI5LbI=
X-Google-Smtp-Source: AGHT+IGkAxsr7XwaySA1rSBDPToZ/by8C+d0CoMgToGSnLllJBtsmMXcPa1rPLckNbXLcnbF9PYOLg==
X-Received: by 2002:ac2:54b9:0:b0:51f:d72:cd2d with SMTP id 2adb3069b0e04-5220fc7aeb4mr6032918e87.22.1715607530221;
        Mon, 13 May 2024 06:38:50 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d899asm1757367e87.231.2024.05.13.06.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 06:38:49 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH net-next v3 0/5] net: ethernet: cortina: TSO and pause
 param
Date: Mon, 13 May 2024 15:38:47 +0200
Message-Id: <20240513-gemini-ethernet-fix-tso-v3-0-b442540cc140@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOcXQmYC/3XNQQ7CIBAF0Ks0rMUwSIu68h7GRUun7SQKBgipa
 Xp3kbjQRZc/f/6bhQX0hIGdq4V5TBTI2RwOu4qZqbUjcupzZlJIJWrR8BEfZIljnNBbjHygmcf
 gOHZGg9LayKFjef30mKsiX9nn0OIc2S03E4Xo/Ku8TFD6r37a1BNwwUGYXuiuVj2Yy51s693e+
 bGgSf5AANuQzJDE/qig1qqR6g9a1/UNXNN/CxIBAAA=
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.13.0

This restores the TSO support as we put it on the back
burner a while back. This version has been thoroughly
tested with iperf3 to make sure it really works.

Also included is a patch that implements setting the
RX or TX pause parameters.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v3:
- Do the pause setting unconditionally in the full duplex
  case in adjust_link just like the code used to be,
  phydev->autoneg should not influence this.
- Bail out of .set_pauseparam() if pparam->autoneg is not
  true.
- Link to v2: https://lore.kernel.org/r/20240511-gemini-ethernet-fix-tso-v2-0-2ed841574624@linaro.org

Changes in v2:
- Fix up the issue in the previous version where I packed the
  TSO segments into too small packets: the TSO hardware
  expects the "MTU" to be set to the length of the resulting
  ethernet frame for each segment.
- Add a patch to make use of the TSO also when we do not have
  any explicit segmenting, which is what the vendor driver
  was always doing. This works fine with even frames with custom
  DSA tags.
- Add a new patch to rename the gmac_adjust_link callback to
  a recognized name.
- Add a new patch to make the driver use the autonegitiated
  RX and TX pause settings from phylib.
- Rewrite the set_pauseparam() patch to use the existing
  gmac_set_flow_control() function.
- Add a call to phy_set_asym_pause() in the set_pauseparam
  callback, so the phylib is informed of the new TX/RX setting.
- Link to v1: https://lore.kernel.org/r/20240509-gemini-ethernet-fix-tso-v1-0-10cd07b54d1c@linaro.org

---
Linus Walleij (5):
      net: ethernet: cortina: Restore TSO support
      net: ethernet: cortina: Use TSO also on common TCP
      net: ethernet: cortina: Rename adjust link callback
      net: ethernet: cortina: Use negotiated TX/RX pause
      net: ethernet: cortina: Implement .set_pauseparam()

 drivers/net/ethernet/cortina/gemini.c | 86 ++++++++++++++++++++++++++---------
 1 file changed, 64 insertions(+), 22 deletions(-)
---
base-commit: 8eed0f55df3577f279dfa680f3c7f600072abc45
change-id: 20240506-gemini-ethernet-fix-tso-ebc71477c2fb

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


