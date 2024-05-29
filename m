Return-Path: <netdev+bounces-99044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CA08D3887
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B06C1C21C98
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 14:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59E61CA84;
	Wed, 29 May 2024 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qJKWZ5fu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CC81BC2F
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991206; cv=none; b=kNPEPHKr17hT9kCnG/jHwLDESyHpvf4nF9rCS9R3AI5JOSp3vEsmZ0RjKJuZ/BknzKi9bMgJSrSOS6rodetbl1FELmFXYzOc1mczFSOqonmWGiYe1Bl4slJmCqwv6GA4PmpWbrti+KSZkVoGThJZgOoMcKKn2HHnNERLiAeagTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991206; c=relaxed/simple;
	bh=MWNiFGs1m7I1y28O9A1IDbK2USBeIP8B9iXJG9inALA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LihvJoOz2b3aRHCjxmOxn+xdrj3Ym4wS+ExmRbjmXrYHtKULMJOr/4AKHv93B//ye4Ih9tugUqywILJPT6ZouXsx/hC3Y/V2nUxv1O4TRbAc9ezteN4A2zENRzNqTzXxMrp+cXst8EFyPVTlJM1/SmlSJcyDRePU7rV8MXGL1yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qJKWZ5fu; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e9684e0288so26778221fa.1
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 07:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716991201; x=1717596001; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m6AhhxeN0zUWZa4Hpv5HMmSkY2iEp9eLo0kIiqb79TE=;
        b=qJKWZ5fuPe6HGhaNlDh/i6x3goYX6stkXVz7Cc+31O8i7ngx0sBoylEpebtFCs3GLw
         /WStzEm725l5K0shfoPN7OA7QYglZSEvm4P/LZu/zjNZ1eTLd2qdTO3BXieY/T7MTA75
         6vI6ekOSSZdU5Sgg3DQlz1kp5IXdYbYMr1Ln2X9N8lC4Iy2EaXF4PzWRYcoPeTB0UAtp
         9/WN43edRatHIU9grStbIImpjfdgXMpcNlY4Dr3v8UxEXBlDnm3TZa0qMysd1zWnTD4r
         A78/GX2Nu7CSc+HaE7VYXRhPNOU3dfqODTE7gK3ZBhe7SVmRCtZvrr/8mrmk/NLDZXwm
         UH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716991201; x=1717596001;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m6AhhxeN0zUWZa4Hpv5HMmSkY2iEp9eLo0kIiqb79TE=;
        b=Edgt7AoPNBBOW1OjF2odVT7J3D9z4MqFFMGG4I52GTmSG+3JTYKP6U8bakGTk8gXuR
         tIe0BByvjUX1WquWY70m6BRg60ctxjcFMMPAlQOxB6f18EBr0WxUgJyPEQ5jkXEBSivB
         k8AvTC9HsGBcP7kmEXD5lqTcbcSfAMAjXsLXl/NHg7Vt8u2d7HIUSXjkOxGie/q8lYNE
         m5BV1VeHoUNDUfGtsysq6T0u3zCuXjtblqGbs8VeN75lOBSLfJqXGv4nlNwXASiKTkAH
         NM9l4Ih1MTKrd5e07VW/KMFZ6fyIlVr53b+JqUoOqNj7tJgnJ3VfRTYZT2METPDsYJQQ
         ekPQ==
X-Gm-Message-State: AOJu0YyP5ogd5A6w4394n3+mUDQr/81xcnZOvT8wS2fGytF0Q1/3tFXc
	ScvWZO7P/rKQydLxs/P2UIAYIk0FBo/UYDTh9lOckNdUBm0Q21eRdwVDBse9Jfk=
X-Google-Smtp-Source: AGHT+IFILPg+5rYtiWB6yRC38SsYtCK2JbtGgiO3s/TjRghiYanr2L/Oky7Ek4L1Q9LaN9Yg0Dz63Q==
X-Received: by 2002:a2e:be1e:0:b0:2e1:a8ca:6166 with SMTP id 38308e7fff4ca-2e95b278b43mr178855761fa.43.1716991201296;
        Wed, 29 May 2024 07:00:01 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcc47bfsm25472551fa.20.2024.05.29.07.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 07:00:00 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH net-next v4 0/3] net: ethernet: cortina: Use phylib for RX
 and TX pause
Date: Wed, 29 May 2024 15:59:59 +0200
Message-Id: <20240529-gemini-phylib-fixes-v4-0-16487ca4c2fe@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN80V2YC/x3LQQqDQAxG4atI1g2EMLbgVUoXnfGvBmoqM1IU8
 e4OLj8eb6eCbCjUNTtl/K3YzyvCraE0vn0AW19NKhqk1QcPmMyN53H7WuSPrSicNEm4S4RKpHr
 OGVeo45McCzvWhV7HcQIbsRldbwAAAA==
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.13.0

This patch series switches the Cortina Gemini ethernet
driver to use phylib to set up RX and TX pause for the
PHY.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v4:
- Drop the register setting in .set_pauseparam(), just call
  phylib and let .adjust_link() handle this.
- Link to v3: https://lore.kernel.org/r/20240513-gemini-ethernet-fix-tso-v3-0-b442540cc140@linaro.org

Changes in v3:
- Do the pause setting unconditionally in the full duplex
  case in adjust_link just like the code used to be,
  phydev->autoneg should not influence this.
- Bail out of .set_pauseparam() if pparam->autoneg is not
  true.
- Link to v2: https://lore.kernel.org/r/20240511-gemini-ethernet-fix-tso-v2-0-2ed841574624@linaro.org

Changes in v2:
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
Linus Walleij (3):
      net: ethernet: cortina: Rename adjust link callback
      net: ethernet: cortina: Use negotiated TX/RX pause
      net: ethernet: cortina: Implement .set_pauseparam()

 drivers/net/ethernet/cortina/gemini.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240527-gemini-phylib-fixes-c2c0460be20b

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


