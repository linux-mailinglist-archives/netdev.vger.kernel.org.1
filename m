Return-Path: <netdev+bounces-175657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E62A6707B
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 305723A5698
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 09:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2034B207DEE;
	Tue, 18 Mar 2025 09:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="GRvTAn8K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF14224CC
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 09:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291825; cv=none; b=G61g/MBR11qhn1gSsIp7R85j4QmuIYvtCkpCajAM4jQ7/Gln8VJpqe1UmEO9xlXlrEyJIG/qUTaMRfT1dWH/qg/bUDKW5hkuT/Tlxomc0i3Ooknb5xLv96Wscc1+H25oyW0rCfFsuKbWo77aX3tCdnVd0/Y5p9Kfi2WcRkjVJnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291825; c=relaxed/simple;
	bh=V0LTKhHSeqp8axFnG3MXcESZ5lvqeqj7WVpujBwX9cU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KOeyaDh1+b7rU1zE0sl7YM5+msyiLmO8G3hk0fjmB5lKcxWMYhST3Th/Af4EIawvXoDvCfMxvr6wXX40yW8L3nJkwmsgEXOanCCaIX2adMHScxTFdvind1apa40/HyTIon2rK28VnCkToxFAuAkkQBV1zPaTZqsajFFZOZ6sRsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=GRvTAn8K; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22438c356c8so92871385ad.1
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 02:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742291819; x=1742896619; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DYxrtds9WuAyx/VMy5k9Yihosia715CLjXw9v61XzK8=;
        b=GRvTAn8KeOc7q4OdTGKRW27WZniukgyCMeKESsBha5XUbEplLEoNGSYfdrNe24S29B
         VxRwdVOsnn5peiNoMLmNvEASvy/MqQ7HWIvDQgviKH0ErylQQWDPBLiFJeeKZ/uJWZUo
         iHiEcIv1sLLBy6TaCJAb9YaSvcjC432Oop3VTnWtbv2nQO2bd2xAXoP/eez+YswiV0hD
         gqiYPAYUpWaSHUfiqPoVKxgpyQkIRvm9YgI0V6E5lTgWF4uxE9Zb19Kx/1FRVQ9WXDTn
         hZEJNDofX80LJV9epQstPyhCbZZsDAAhceEskaXupZx+WJYyjD6xAt4UemabSvpRg27o
         TJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742291819; x=1742896619;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DYxrtds9WuAyx/VMy5k9Yihosia715CLjXw9v61XzK8=;
        b=BX5eqFG/Yxf9pmz4lHAsUVAkfhWabksFhqPKbZbF2eMc/MX3JTK/zKUugsjRIFMSTM
         Z8eoB7ZYCxPmq6VdZuMlTtdr+sFkdC5TS9OIC08tZsGiRD57JoYE9aUhi7MXr7irSI8K
         9038EmedI4Fhj0sXKCk0U2hLHrPzslYXz/D3HAHkxrq/HflpnF6TJut4SKtE5Wwpl3o1
         ViNi78/HctGqdL7IR18G5gHgNaU0BOeZ2atoFH4UabPWO8gujVfM8yGaWDu8mTrqzIk9
         d3FzBvWbyTICJzbLRbzD9rR1GWemCzlNLkc+gFR0p/otK76CjsmYyKnURu7qTzcU+laC
         eNpg==
X-Forwarded-Encrypted: i=1; AJvYcCVWsDsQk5p1DjtJVmGMo2q5ak+aIiURq6bFIkxXiwjvfQS017sm6JsaybnH/5Phui30QJovgaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZGIRiSEtxNjqPS/KCFqD9PbLMfBx8hXGtM2vPCaYJbdFKWhOo
	hqUyKTrmkTjVoDl6EvDKVg3b32709QnYUdQWuxOULxpbOKPGTReLc9AZnaZz9mI=
X-Gm-Gg: ASbGncsZl8poDJ+sl3HjUrS2NczdmAtuSluMDJe1VHdOrR8dWyjnKXubQPVRl8Yj7t9
	WG8WUJ1YxlNH3l6rWlRlzYURDvzyCCifzwmbKZ9oEXkoOQcb/BrjWAzPZ8oQ5v1f/VpjNSW5bjI
	HLrA8/lOBZfYpVLeDUxo2aAnqQGGoOtvwjbLXlDsP8IklSPj+a5dRlsROdnYo1e/v30VFs8dJXh
	NKcEqRVWPr2MwcSEzTPGiT6tPBs6ub7Yp8tJMGoibk0PotuWAWPprBjidxYdXl3w6ciJAKDHBah
	3M5+ZuLL+AewGdsJR3G7BZ0yYiFSpi41Cg05xpB+7y7GH2dd5hv0DXOafxY=
X-Google-Smtp-Source: AGHT+IHrk0Ye2VW3IkLXWNA3Y7JUi4Z0k3Yg5or8rzVPS9hPOf7HJ1+PfOM0m9d8tJMNA1KQW6fotA==
X-Received: by 2002:a05:6a21:9185:b0:1f5:70af:a32a with SMTP id adf61e73a8af0-1f5c1386049mr24959333637.32.1742291819121;
        Tue, 18 Mar 2025 02:56:59 -0700 (PDT)
Received: from localhost ([157.82.207.107])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af56e9ccb0csm8634097a12.2.2025.03.18.02.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 02:56:58 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH net-next 0/4] virtio_net: Fixes and improvements
Date: Tue, 18 Mar 2025 18:56:50 +0900
Message-Id: <20250318-virtio-v1-0-344caf336ddd@daynix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGJD2WcC/x3MQQqAIBBA0avErBvIQrOuEi0qp5qNhooI0t2Tl
 g8+v0AgzxRgbgp4ShzY2QrRNnDcm70I2VRD3/WyG4TGxD6yQyXlZNQk9Gh2qPHj6eT8jxawFNF
 SjrC+7wfuSPvWYgAAAA==
X-Change-ID: 20250318-virtio-6559d69187db
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Melnychenko <andrew@daynix.com>, Joe Damato <jdamato@fastly.com>, 
 Philo Lu <lulie@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6

Jason Wang recently proposed an improvement to struct
virtio_net_rss_config:
https://lore.kernel.org/r/CACGkMEud0Ki8p=z299Q7b4qEDONpYDzbVqhHxCNVk_vo-KdP9A@mail.gmail.com

This patch series implements it and also fixes a few minor bugs I found
when writing patches.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Akihiko Odaki (4):
      virtio_net: Split struct virtio_net_rss_config
      virtio_net: Fix endian with virtio_net_ctrl_rss
      virtio_net: Use new RSS config structs
      virtio_net: Allocate rss_hdr with devres

 drivers/net/virtio_net.c        | 119 +++++++++++++++-------------------------
 include/uapi/linux/virtio_net.h |  13 +++++
 2 files changed, 56 insertions(+), 76 deletions(-)
---
base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
change-id: 20250318-virtio-6559d69187db

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


