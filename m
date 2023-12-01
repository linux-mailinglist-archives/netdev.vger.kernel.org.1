Return-Path: <netdev+bounces-52842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCDB800568
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 09:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2040CB20D0B
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 08:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2673A1A28F;
	Fri,  1 Dec 2023 08:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/dm9L9P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B28B1711
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 00:21:03 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1d05199f34dso2423125ad.3
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 00:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701418862; x=1702023662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTCl2ATdDx5oxAQBzyos4KiLjjgp0AYowxAbMfInlAY=;
        b=m/dm9L9PNnL8kohVw50nu0s/o+DPd+8akd4VgKKKzFUZAtwx2DDedNvqmGxLqjIcln
         cZWQNz17UimNA2iUdpnwpCrljZwRxxOy7Z+/w5XuXn9JoCk1HHE7V7a7836I6uvdZC9v
         iu7R1V2gAUrvGahamDUJSx3UIRfSIAsvO5tK3wJYIefT2KHi6tya9bcN4ZS5GzBG2B0V
         ZfJjxUqt2Kx/aQTQdS7zK+BLmrQ9mbvDzNoDXklrJCzwOxEbKRVhKuBe33Owzj0ePbtt
         3iez8lDhGHE6kGY5zHjtDJxRdY1RT5H6yWiNOruQLqCB67DE4KgDsd+JyMWP4LYxPNg6
         oyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701418862; x=1702023662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTCl2ATdDx5oxAQBzyos4KiLjjgp0AYowxAbMfInlAY=;
        b=LeYL0LaCmMzo1t3R4GDX1/8WBw3PbrKECyhm73LgW41tvXWsMwNTZlV/8lmHqq4E2f
         GrI67y2XT7HNFXaWOgQ87Ngz3AsDB/ktSP6mgaO0SuuSzxsoXjtQ3DVrgAStDAIX74i+
         Z8n9PWczRCC00Bo871Lcwp2OtOK5SrcF0QtKbUb8aAKbyRLd2zWn3LZ3b94GcSy54l1/
         Sa/Yk60dJeoE7DnCLPo1s3W/llJrdPJC1U134cSfDjQSHjCihKJviDoOjRIMx9DSUhrR
         XwDAQ3KlBS1l0knhSM15KqbbeLQXWbRF+ijfYj/4UMFIP/VGHpeZuo1yJXHzCjSjqMPs
         WFZQ==
X-Gm-Message-State: AOJu0YxgQBRh14g76hmiqx7XNSZ01kmJoK4/FaYt5y48xk8qPu28dqDM
	YmfKVLgnqsRsQQW3dsVT/jEyUlnLDr9ZTA==
X-Google-Smtp-Source: AGHT+IEZcmg3rSwEKbY1B/i8/3H8EMdkfEXE6SQVyKmMthKan5sudkkQsHogpgXiQGEzDdv3xo/YGg==
X-Received: by 2002:a17:903:607:b0:1cf:8a91:a84e with SMTP id kg7-20020a170903060700b001cf8a91a84emr19984194plb.50.1701418862068;
        Fri, 01 Dec 2023 00:21:02 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bf3-20020a170902b90300b001cfc68aca48sm2715787plb.135.2023.12.01.00.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 00:21:01 -0800 (PST)
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
Subject: [PATCHv4 net-next 10/10] docs: bridge: add other features
Date: Fri,  1 Dec 2023 16:19:50 +0800
Message-ID: <20231201081951.1623069-11-liuhangbin@gmail.com>
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

Add some features that are not appropriate for the existing section to
the "Others" part of the bridge document.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bridge.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index 39ff8d126a04..ba14e7b07869 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -287,6 +287,20 @@ So, br_netfilter is only needed if users, for some reason, need to use
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


