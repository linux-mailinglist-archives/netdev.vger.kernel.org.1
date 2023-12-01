Return-Path: <netdev+bounces-52840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B9480055E
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 09:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2F3928151B
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 08:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A50018632;
	Fri,  1 Dec 2023 08:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsbpmFXR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD851713
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 00:20:50 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cfc2d03b3aso2378175ad.1
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 00:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701418850; x=1702023650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEHb+FWTW43zmcGFeHI3h2qauVCm6T4VUYC5A70U2Ng=;
        b=NsbpmFXRzNNr7pu07LdqkDnqWYF11xoGyzYE8NKwJB15l2ctNwIFV4ULFNY5LRrO5e
         ia6Nct5wkheMKcM9zdm6vmYIIm7R7N+1eSuUfl/jP1q9RAZMNfxPoS9zSNbmRs5A16Z1
         hcsN4zmlqlfnZF87DPqlJ1dSuaeoBty40wbF9phBWcf9CAuvfAFFH62T/OD+T1DV6FL8
         +O78TEzhc21/Mr27go5OZbhgeGzMC8tLJn5OnNGpFeisfeq+KhiCM5/i2qlGy0qgkMsD
         RGJa/GyTk933huuSfy2qEzWRUEIMSpaeYqtTbyjcEv9v4bItUW1SncRY0hVRAcHb9AJn
         LbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701418850; x=1702023650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XEHb+FWTW43zmcGFeHI3h2qauVCm6T4VUYC5A70U2Ng=;
        b=wLzzhoPHAkCy8lDfoOC0dbsQIcv5hVDBgBIPiKgw3t9i0GjZFrW76u3SsZFmc7bTwR
         Y/aRJwZI/CglJIVVIu9HYipNI6OYVnuWfCWIHMKwmVfucoO3bYK6xblHfu+Rx9OBkUHO
         nFpTo0AUhp9vX20iJWsjf5fJByuYxk8uXU5tc8yG4j06ymtqyrMK9uEiBHZJ8tGM0zuq
         5mZNS6zB0bZREMsjCdXliFV1I2WzOYB1RUIXB4aKcRYTPHZpxPEaROtoE8YyH3Uqr+Qn
         4EmEoV9RaJKuqAckJeGiCGuw38kv4dh4h0yy2/yEVA/zWBOYHS8ubtt6UGYsBn5+mM83
         HAUg==
X-Gm-Message-State: AOJu0Yw3m1jaaf6Cqu3u3NqQY37MmyhNoMH1++rEeBss62KFfuBMKdNg
	t5aAXoLhEQCzL3wVqy4X76Y/b3IzCJ8mZQ==
X-Google-Smtp-Source: AGHT+IGIiEP+5DUfx6hZ1etaDumw5fu0qKdQ8bGvR5rRrY9SfKC7T53stD7fblcD7ahULe0hR952Ww==
X-Received: by 2002:a17:902:eb84:b0:1d0:5811:acb9 with SMTP id q4-20020a170902eb8400b001d05811acb9mr592032plg.5.1701418849815;
        Fri, 01 Dec 2023 00:20:49 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bf3-20020a170902b90300b001cfc68aca48sm2715787plb.135.2023.12.01.00.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 00:20:49 -0800 (PST)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Florian Westphal <fw@strlen.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Marc Muehlfeld <mmuehlfe@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCHv4 net-next 08/10] docs: bridge: add switchdev doc
Date: Fri,  1 Dec 2023 16:19:48 +0800
Message-ID: <20231201081951.1623069-9-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231201081951.1623069-1-liuhangbin@gmail.com>
References: <20231201081951.1623069-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add switchdev part for bridge document.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bridge.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index 863ad2c8d146..e96af89cd061 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -233,6 +233,24 @@ which is disabled by default but can be enabled. And `Multicast Router Discovery
 <https://lore.kernel.org/netdev/20190121062628.2710-1-linus.luessing@c0d3.blue/>`_,
 which help identify the location of multicast routers.
 
+Switchdev
+=========
+
+Linux Bridge Switchdev is a feature in the Linux kernel that extends the
+capabilities of the traditional Linux bridge to work more efficiently with
+hardware switches that support switchdev. With Linux Bridge Switchdev, certain
+networking functions like forwarding, filtering, and learning of Ethernet
+frames can be offloaded to a hardware switch. This offloading reduces the
+burden on the Linux kernel and CPU, leading to improved network performance
+and lower latency.
+
+To use Linux Bridge Switchdev, you need hardware switches that support the
+switchdev interface. This means that the switch hardware needs to have the
+necessary drivers and functionality to work in conjunction with the Linux
+kernel.
+
+Please see the :ref:`switchdev` document for more details.
+
 FAQ
 ===
 
-- 
2.41.0


