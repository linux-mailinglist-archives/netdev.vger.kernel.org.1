Return-Path: <netdev+bounces-50539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322C97F60B3
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 14:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62EA51C21139
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 13:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C515725776;
	Thu, 23 Nov 2023 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgoyYwCn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78A7D54
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 05:46:43 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b20a48522fso777018b3a.1
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 05:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700747203; x=1701352003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0eHcd9LyHw2hsBew4eC9u4lc8p/JkjTWelv2b6HLjM=;
        b=YgoyYwCn+xmZbbK0+LflWGtBI/o41WMskXLVbvBJtG+3FLvQiI+gCmxRNA+cLSL6D9
         b2PJdkIoMmpdEu80BDmtWa8w9Hq7UiMvl2rE4gwQDnFW/YDoWgJG8t36CI0IT1fPaBPh
         4wOGYBv6zJYlVkVe/nuSU3I95uxeWjjyyhoz++dDCLaVDcqWWSzboRwn6i/g4v9SUs4b
         M/i7B+JvHkTqAXTaRRzOyZWuJkTBEnAIpp/pZ3YUErFnIGeqCDRKn2SGkU1lZHoPz5+B
         gWXg6KV6UE6U04ZkCg4mb6qCOFae1HmsUavV5lhA/htRcHlV2ZJsglzXbLc41cuFNHF7
         UVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700747203; x=1701352003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0eHcd9LyHw2hsBew4eC9u4lc8p/JkjTWelv2b6HLjM=;
        b=xCHkoedaT9GJlmF7eJz+JRbQRbu6TsHYBUhcQ/a0CJ7jDyav2jFiEO5AQvDHiyq34e
         /idvZ6kcLKEkRzZnqi4Cy2X167r82b6WdID9tR2UEbHAPLjapyICLnI3GvnFOXtXLsu0
         ySOLIY2rWqYkbcEgvXxhx18goJcpK8SFS/S8+PeLOIFrYy+Tgn507d1yXT6N+f6xQ/G8
         gOPI03DlE6E9tixvBvXw5QS1MPhaBg613vyL+E5TflIvJYy3kBGXIyuaz7SVLkqXs8vU
         O1P5Gx3VGPyzxroMzImqGv8nVnfrb8V1qxBXjhzydrK1fPPc20L+92amRyLzQ+jme0Fv
         5nhA==
X-Gm-Message-State: AOJu0Yxtxypan9zYt2zUzKlRMB8jU4PUenEN5pEQk9xo0duF4JA7U4IX
	pQJRmZMDfyX3yYivbGpz2eNPUkQGkHBy+F5L
X-Google-Smtp-Source: AGHT+IGDnq2M+9N6/vG2Xcw9hzn+eREr5d1joozkqE6DnpsYzUhwlnVK8gdD/rWHQDwi3n95E0OjMg==
X-Received: by 2002:a17:90b:3e83:b0:27d:8b6f:a626 with SMTP id rj3-20020a17090b3e8300b0027d8b6fa626mr5459804pjb.13.1700747202873;
        Thu, 23 Nov 2023 05:46:42 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 29-20020a17090a195d00b0028328057c67sm1414210pjh.45.2023.11.23.05.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 05:46:42 -0800 (PST)
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
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 08/10] docs: bridge: add switchdev doc
Date: Thu, 23 Nov 2023 21:45:51 +0800
Message-ID: <20231123134553.3394290-9-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123134553.3394290-1-liuhangbin@gmail.com>
References: <20231123134553.3394290-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add switchdev part for bridge document.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bridge.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index 62cb6695cd22..f42c19e59268 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -220,6 +220,24 @@ which is disabled by default but can be enabled. And `Multicast Router Discovery
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


