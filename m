Return-Path: <netdev+bounces-48600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A617EEEC2
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B87D9B20AB0
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 09:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670F314018;
	Fri, 17 Nov 2023 09:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCHKsat4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C4B1998
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:32:38 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cc7077d34aso14556385ad.2
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700213557; x=1700818357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfCpLUY8uRc7ejP0BoGnUPM/LMXmRidgX+2dbabaW1M=;
        b=TCHKsat4FSWhJ1zxhh3XVCItY0AR2kuza+u1mgJaKA2erDATflNe41S8z8kPZN0EF8
         M9ds8BKcFe6lqNLYHT7nkcH8Fl+b6XRjmAMG3fNaDVtk6uS83sG3/TyvJTddFXiTHs6u
         I4nPwrc2jthcO3FSJSoLPKZMQQfNHpYHC0PTunIcOwkQdLmyRZxOmJ4+vctKp3rn+8N9
         0mz02d126ca5cZ9viIOLVzuZdyyajhnWmBZI2WCUUc8UYePG7XZgh3hDMVJF+FQOqByb
         1xgbWK/56zbguAubXJrYU0ajnqX2z2KNxDPIkMHTP5IxAchVlCL62r2y53YZQVRD1FtG
         IgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700213557; x=1700818357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfCpLUY8uRc7ejP0BoGnUPM/LMXmRidgX+2dbabaW1M=;
        b=DT+uVWGGyMR8MFHJ7FnpZ2BntBSXNel6W7FITT5HCzsinKP8KNxVj1ZaZRxJvtflqT
         Yb/ZJW3sQVH5flxqsTY/7A0MwhVQeBpc/tSa9HCBmdAHYe7FDgLE44+iVtZu4/1tBs99
         4aGE+fkF1Ou43Ps8YEz4tXs/wJJtPqL+nYgv2emZ0rCRR9ICvNsWuRVHQpQlRH1UkyRh
         1Uo4Oh+mIRXfBp5jXnP9oYfGNloRtSAyBZkSq54ijOPDKtuJ8r7457jeh3jYD7t3+FLN
         l+3B/1BZ3byB8sguRi3QEk8mb2BG09Co8uQm9MySE0kQUrQbY+yrSuH05LgclOeYIydU
         eRPQ==
X-Gm-Message-State: AOJu0YzD2sv1Nwibq3zELmbmGl614xU1Irdw1lYuq4VgHJCSdeX9igax
	pFVsseU0vKel/HIUW1s8D+qNA16Yxqc5nURN
X-Google-Smtp-Source: AGHT+IFAuRjnLfpIrry60EGXua6rmPXC93wHbXBhIPhJQ17u8Mjtzp341RjkgVKOvckwKo9JyHQb7g==
X-Received: by 2002:a17:90b:4ac9:b0:27d:b488:92ee with SMTP id mh9-20020a17090b4ac900b0027db48892eemr16475389pjb.2.1700213557127;
        Fri, 17 Nov 2023 01:32:37 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p9-20020a17090adf8900b0027ceac90684sm964060pjv.18.2023.11.17.01.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 01:32:36 -0800 (PST)
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
Subject: [PATCH net-next 10/10] docs: bridge: add other features
Date: Fri, 17 Nov 2023 17:31:45 +0800
Message-ID: <20231117093145.1563511-11-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231117093145.1563511-1-liuhangbin@gmail.com>
References: <20231117093145.1563511-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add some features that are not appropriate for the existing section to
the "Others" part of the bridge document.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bridge.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index 772bbe28aefe..54118d9da2a4 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -274,6 +274,20 @@ So, br_netfilter is only needed if users, for some reason, need to use
 ip(6)tables to filter packets forwarded by the bridge, or NAT bridged
 traffic. For pure link layer filtering, this module isn't needed.
 
+Other Features
+==============
+
+The Linux bridge also supports `IEEE 802.11 Proxy ARP
+<https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=958501163ddd6ea22a98f94fa0e7ce6d4734e5c4>`_,
+`Media Redundancy Protocol (MRP)
+<https://lore.kernel.org/netdev/20200426132208.3232-1-horatiu.vultur@microchip.com/>`_,
+`Media Redundancy Protocol (MRP) LC mode
+<https://lore.kernel.org/r/20201124082525.273820-1-horatiu.vultur@microchip.com>`_,
+`IEEE 802.1X port authentication
+<https://lore.kernel.org/netdev/20220218155148.2329797-1-schultz.hans+netdev@gmail.com/>`_,
+and `MAC Authentication Bypass (MAB)
+<https://lore.kernel.org/netdev/20221101193922.2125323-2-idosch@nvidia.com/>`_.
+
 FAQ
 ===
 
-- 
2.41.0


