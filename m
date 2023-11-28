Return-Path: <netdev+bounces-51597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 718467FB4D1
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 09:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6D0BB2132E
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 08:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BF21DA2C;
	Tue, 28 Nov 2023 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V65OTZ6m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F838E7
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:50:44 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b20577ef7bso4505230b3a.3
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701161443; x=1701766243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u15oyv4jQ5hr1Ec1G7FfFNQfq84tvttpwKNWquVokdU=;
        b=V65OTZ6mZ9Q7xsEI4qoijexWD8zwd23Rl8fngTw1toqjBW+xDYHbq20AaqLzY+8PmF
         E9OpeU2/fvnjlx+yGtyWLECyAEDKrnCjawoD4HLVccYQMvOQJ1QGgttuznA5aBzoUghH
         sJEq19B1H7g24DT1Adiv0+GIXvwNU0eKaO5WbLp20dit3TNY9x5SFcGDlX6wsmQTU1Rq
         hdPJ/ed1J5CCn6uOI+dZZOQDG/vjOWyOzGVF7Ms/NxcYkpa5/GEbhJt/9Lk6nF+hlPgN
         dQb30PQ5W7AzrA78sCV/K65IB1sy3sGvbd4GL9ZCGSRh8ZNoYq7+E233jANfimQAe/d8
         fNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701161443; x=1701766243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u15oyv4jQ5hr1Ec1G7FfFNQfq84tvttpwKNWquVokdU=;
        b=UiFL9QCj57UsJ5G2CNaaojTrUDuftnJmPnA40zVFsvVS0/mrMcwMBx2sD6EXydIVEU
         efBqsbilqsBbd/k7J/PtfBUI6kbq2h++CQOEQHFaQHpEv6MNQRpudRNjhuc+SAboNmq6
         neWMND+Z+stuXQIrGIJzNozkP/0mw8jGqrxaaUia7qgCatE7Nowz54TTCrptyivnPGK5
         I5W35trwi9VKoxGoaZeOakfiTynXloY4vrwh+6YyevxAR9ftNaK3cKEi8EjfSfZm7Fj7
         3MwRR125vmOZZuYcCq5K9lRQMkqhknO1eyHgvBmLok8KZYxyWQLJ9T2eWvEHkzKjCcDZ
         QnmQ==
X-Gm-Message-State: AOJu0YwVeCcUQ3Ta11WO7J8nH+KGVL0aDMgEhGZtpj4u8hrIW7QBJygD
	a4To5zjBb5LViPeUy2sbgBRJ1JRH8drasjKq
X-Google-Smtp-Source: AGHT+IGp3jchBNq6XdVu3VqVhw6NEUEBTIwKHvzWYtsrvgL3MxmAA6V0vtFAcgB2+NqOR0GqmidEpQ==
X-Received: by 2002:a05:6a00:2787:b0:6bd:f760:6ab1 with SMTP id bd7-20020a056a00278700b006bdf7606ab1mr16465855pfb.14.1701161443460;
        Tue, 28 Nov 2023 00:50:43 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78159000000b006cbae51f335sm8766513pfn.144.2023.11.28.00.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:50:43 -0800 (PST)
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
Subject: [PATCHv3 net-next 08/10] docs: bridge: add switchdev doc
Date: Tue, 28 Nov 2023 16:49:41 +0800
Message-ID: <20231128084943.637091-9-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231128084943.637091-1-liuhangbin@gmail.com>
References: <20231128084943.637091-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add switchdev part for bridge document.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bridge.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index 956583d2a184..3b82cf52bfec 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -216,6 +216,24 @@ which is disabled by default but can be enabled. And `Multicast Router Discovery
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


