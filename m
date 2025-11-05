Return-Path: <netdev+bounces-235932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A36D4C374A2
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 19:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A7491894C62
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 18:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9181E27E06C;
	Wed,  5 Nov 2025 18:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XTUAiIu2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A526279DCD
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 18:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367179; cv=none; b=CGxMt1YbT0RLKsup9HWYlJzX2Fp7f2jyGIZRo0jGn1czgNaeIBRMam/UxR3j9KYOfzoAM6xxjrWeACRgkIqa5B2LSNcZohFkJUcO/oxNvp0zD8gS+FQfKTe/kYHJo0JTa8IDgC7XqtVc+L23/9G40yvB46py+x/ynaW4ba9rhP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367179; c=relaxed/simple;
	bh=dC3wZU1d3Q/XuLeo0NqN7Nn6l96ix4J3LsC/gtz7RXU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HhXS/X+HoDzfIvVx3STXgmC/4unAOJNB/CrW23cGIa2YTLjsN9J4IkdE3YoLQQxxEaNZSnAwuIS2Ywto6SRQr7J5x9uxy8ZZkAIQ1HAVrt1av0n3AppqmboUrMiei94+SbqDypIUE6VKYHorI49MHksNrW6OZjDetIY2y4xfhnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XTUAiIu2; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2958c80fcabso3172775ad.0
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 10:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762367177; x=1762971977; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KSss6HbGQCY5z8mN796rywNkBrMYQLKch5XXdSsn0us=;
        b=XTUAiIu2oYf1CgZV8O3V4WcvY5QomgL82n0PWSnHVA1IaHIP6ZoCCl+Gn0bHktPtIN
         JFGyt89YcGZvnU1GJT8BjNrUfb5idSF+nRV32qaoRfNPiH+qTXeKsVJ82SdcsDWiq62Z
         LLEE4SuOaR/qTWWQWIaqh6olEAY53UFL5c12pRyr5/HX0l0xvP/J+NhWF21gFOs/nuNt
         AbbG9nM5FNJAtR551pcn7AXV834m3zpkNIHbDE2bhRJDDh2I0+QJFuw3qr5BBOZP1XjK
         ISrhmzFgYDrSEDvVdZf5iAOlNrgfYi5cghMTw1RS75l9+uyc6x43poTPydXWXTt6ufhv
         RveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762367177; x=1762971977;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KSss6HbGQCY5z8mN796rywNkBrMYQLKch5XXdSsn0us=;
        b=r1mgtxFa8062FxMr7AqtuclMFkX6nzTAltotko2KdKbkcNUk4T8Jjm5wojQ191s6LB
         1Bt/CTQmaFAi7siD0tsdiRdtztvJL9qfbRb9cMDykUfcDVEuhH4TBMY6W2Pvsk4tSfgr
         3UtAeJcxRnS9GI9pvSxghU/Zzyya8mTNYN9/puJSiiliQOMJNkGjVEcKP03kgrwVCsW/
         KsV7V13Zz57eT9RRKKCXL1u8FldYFwQZY7Igyhv0WWe6Bgvf9xBEoXVZKvA53hKyjPGV
         97Y0pcGT5Bba7ah5gN3Arki90mngYMpXlFugx7kYZB2eGpVVDRPkcLoZ1EXZAd8Co/EQ
         K15Q==
X-Gm-Message-State: AOJu0YxIUVhc7IAepcVM3jjkVbUg4GGSkrsw10XguHDli7JwxrsGBXIN
	FXkRS7yxrtDds035ZOZrl0hLmoWbmEIhqUShFJRr0EntWPsleHsVCJB7+/4JcCI7YGT/D/mQpW/
	EG05lwg9eT14TsqKXHeLTJkCWOvcoqcGgluW1Dr1lK3p8zZfdZ9aM01Fa083vlphf1LsSn/LvB7
	2sZT7mhNh11OdtGEPa+YcYLL7caXcFC4BITG841pRGMaTUgjY=
X-Google-Smtp-Source: AGHT+IGVoXl2Yf/ZmXbfSZT9DXVZPIfvmxJuyTN8+U8b4/6iSY/LsQ8oiGdYPs2AX8p70jtncbegcjmEFBPnHg==
X-Received: from plbba9.prod.google.com ([2002:a17:902:7209:b0:295:49fb:2392])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:fc8e:b0:295:8c51:64ff with SMTP id d9443c01a7336-2962ad95d73mr59836465ad.29.1762367176830;
 Wed, 05 Nov 2025 10:26:16 -0800 (PST)
Date: Wed,  5 Nov 2025 10:25:59 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251105182603.1223474-1-joshwash@google.com>
Subject: [PATCH net-next v2 0/4] gve: Improve RX buffer length management
From: joshwash@google.com
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Ziwei Xiao <ziweixiao@google.com>, 
	John Fraker <jfraker@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Ankit Garg <nktgrg@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ankit Garg <nktgrg@google.com>

This patch series improves the management of the RX buffer length for
the DQO queue format in the gve driver. The goal is to make RX buffer
length config more explicit, easy to change, and performant by default.

We accomplish that in four patches:

1.  Currently, the buffer length is implicitly coupled with the header
    split setting, which is an unintuitive and restrictive design. The
    first patch decouples the RX buffer length from the header split
    configuration.

2.  The second patch is a preparatory step for third. It converts the
    XDP config verification method to use extack for better error
    reporting.

3.  The third patch exposes the `rx_buf_len` parameter to userspace via
    ethtool, allowing user to directly view or modify the RX buffer
    length if supported by the device.

4.  The final patch improves the out-of-the-box RX single stream
    throughput by >10%  by changing the driver's default behavior to
    select the maximum supported RX buffer length advertised by the
    device during initialization.

Changes in v2:
* Plumbed extack during xdp verification in patch 2 (Jakub Kicinski)
* Refactored RX buffer length validation to clarify that it handles
  scenario when device doesn't advertise 4K support (Jakub Kicinski)

Ankit Garg (4):
  gve: Decouple header split from RX buffer length
  gve: Use extack to log xdp config verification errors
  gve: Allow ethtool to configure rx_buf_len
  gve: Default to max_rx_buffer_size for DQO if device supported

 drivers/net/ethernet/google/gve/gve.h         | 12 +++++--
 drivers/net/ethernet/google/gve/gve_adminq.c  |  4 +++
 drivers/net/ethernet/google/gve/gve_ethtool.c | 13 +++++--
 drivers/net/ethernet/google/gve/gve_main.c    | 73 +++++++++++++++++++++++++++++-----------
 4 files changed, 78 insertions(+), 24 deletions(-)

--
2.51.2.997.g839fc31de9-goog


