Return-Path: <netdev+bounces-95597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE58A8C2C71
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 00:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E69B1F22618
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 22:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1BF13CFAE;
	Fri, 10 May 2024 22:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uxWYvcWm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F272513CFA3
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 22:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715378937; cv=none; b=oOUK1umZSuLyFBYenr3/5RlZWldWm+pzh73uSE08VW7WYqLIAaIuDxbHpxbTeA1OMgHQ77s4i4X3mLoYlDa00AcbiJu5k73CCFZHpidlT18LXBSkUHWrs4HtGG/Fx9xPCQdN6GtAsZIdQ6GyJJBQB4mKhFczfOShRbFRGeedrko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715378937; c=relaxed/simple;
	bh=NAxGgZZsk/VCIqehiX35dghLM0pxpLNGnVZEiM0dv3I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nY5EsdOEAfAcIXyAEXnBdo6uZaDh6IecXcFe1sNKCLCF/6ekhBx/NpHwFqaAiB3xMP7Ng7Kd7+QVMG1yA1SAgD12SY35lm1XpK/nF0PRnA5giAdI8/6Fi/fB8fK4MIaiuRF0o7PoX7bxICGjXmOsxOcDhlha7wppEcvUad1Vubk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uxWYvcWm; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59b49162aeso612660966b.3
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 15:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715378934; x=1715983734; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o9cRryS+roxCSEoNZ+CfyuLiO+htAgihNDpfk7rVDuQ=;
        b=uxWYvcWm74nj3vS2ynIA+5YewLt2Ox3yUMOJPnIlcd8jRwoVGiCtyI79RYBhxn89pP
         0T/hdOUvZD7HUo7pGcmoZoD3aVFAq1dKtT6Ig0r92+koYhrW1QvH9FbOAEhqvOGcBESo
         1bnsoI5jTvsd3TVN7XhpkvHQzz5xSl/Muyj20HNVpq09p4QebGrCghv8I3mxR3pnYDix
         /jdPxJpK2ICtQPNgVvpRKVP2Znysi4QOJeOjkJHkgI8ehRjipzWW96WPUezwb6yAEZfH
         5BWdspYNiKxXYN5qSo/EK7Cf/44wqXcAAKf68dHgrKtMPB5TExM5kXCFef1S09Istlpb
         8bHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715378934; x=1715983734;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o9cRryS+roxCSEoNZ+CfyuLiO+htAgihNDpfk7rVDuQ=;
        b=dQgEWS2SLmaponWeHNVn5sqtaeQr/0aVq9OngVTK64PDDJl9rBXEY5aDzOD9R0fxhR
         Lkvs/5JU9uuvD4Ljj5/bLCuNDmh7aZOlWNUfoj/PQME6/cWzTFWAl47jUg7nGkZVDaBV
         1lcH/Z+MPgyL+ApjZD0Q6cyk8kF02GkYzdBiXdv3ZEuoR3Q6N+Wjl6C+dNcWWbhDbsZt
         7J/gbLs1ynwNK4QB4go3qFEGlSH8NpHfcCuOfFgOOk3JpxHj2kt1md5IioSStOFoJrM4
         OXWqDx32Byczs4k+TO8EnfczE3waAk0OIU+7WSMaSGyYD1ZwqNdutkJZ3shyv+RWjXCf
         D7tA==
X-Gm-Message-State: AOJu0Yxe38LLdiWcgWTcIx4cz0a4+zfHUbJOoVq14IFbDo7I80PuaOOe
	19BwOZysCsCXI52R9C66cg8OLQeGXKDTsDeUm0DciEiomLm+vRGxq09iquoX08I=
X-Google-Smtp-Source: AGHT+IF9mXn+w0ex/MK5MBe0KL2x0hpU7kMC3b5ZipHbYH0nlEZKZJSx7fiSD+9y0997fXLlQjn8kg==
X-Received: by 2002:a17:907:36f:b0:a59:ba18:2fb9 with SMTP id a640c23a62f3a-a5a2d534e9cmr230133166b.12.1715378934327;
        Fri, 10 May 2024 15:08:54 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781ce3fsm228219866b.4.2024.05.10.15.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 15:08:53 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH net-next v2 0/5] net: ethernet: cortina: TSO and pause
 param
Date: Sat, 11 May 2024 00:08:38 +0200
Message-Id: <20240511-gemini-ethernet-fix-tso-v2-0-2ed841574624@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOaaPmYC/3WNwQqDMBBEf0X23C1J0Ib21P8QDxpXXWiTsgnBI
 v57U+m1x+HNvNkgkjBFuFUbCGWOHHwJ5lSBW3o/E/JYMhhlatWoC870ZM9IaSHxlHDiFVMMSIO
 zurbWmWmAsn4JFXSYW/gWPa0JukIWjinI+7jM+uA/+/WvPWtUqJUblR2aetTu/mDfSzgHmaHb9
 /0DIjH1qMkAAAA=
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

To: Hans Ulli Kroll <ulli.kroll@googlemail.com>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

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

 drivers/net/ethernet/cortina/gemini.c | 88 +++++++++++++++++++++++++----------
 1 file changed, 63 insertions(+), 25 deletions(-)
---
base-commit: 8eed0f55df3577f279dfa680f3c7f600072abc45
change-id: 20240506-gemini-ethernet-fix-tso-ebc71477c2fb

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


