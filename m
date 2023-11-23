Return-Path: <netdev+bounces-50541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC947F60B6
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 14:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3171E1C2117D
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 13:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4B825776;
	Thu, 23 Nov 2023 13:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJUnobMR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B69F9
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 05:46:53 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-285685530f3so407536a91.0
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 05:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700747212; x=1701352012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfCpLUY8uRc7ejP0BoGnUPM/LMXmRidgX+2dbabaW1M=;
        b=hJUnobMRu7GH4SlWNZkc3o749oIYLF1uQGowgzeEgol/NHupoZTOokn5jq61EU5tm/
         03hujjzo9R0ZbrdBbzN6SiEmSRa6t9E5x4TlVy/RdsWWpSIKxzT+rLnXEjCMGwZB59Ln
         JoA2mU1o8z7Czc1av4TMKmbSD4z0WCK8UCdGdAbFRnCJoDOdLVgRFdUTze0RQp4PgFQM
         cyBu3P9dqvlfZ9/cNfFOzMXH+MFeYRZ1t7xMeyRvq9vmYLa0RhAe0RMHG2IoUj9eBMrS
         lhREqOKuBIVZfvRAyX0c7zwjj3JsRH16garffEt1Mhg1Ti0+cUgi+vCyxD/c6Gtv8AvY
         BHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700747212; x=1701352012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfCpLUY8uRc7ejP0BoGnUPM/LMXmRidgX+2dbabaW1M=;
        b=ru3vsNnN0/15611oXBQA/RzHORPWKxdZDVGBic0JNWsivcC8JVrbm0QSB+NjisMQHW
         bJ8ofnxtwqzGZ1OLsfVDlRojUPyBgCsEaxtgR8FVlV7qTaLyOokdw/3M2sOxa0tt5QoG
         EePLD7sOQf0pAxgj8O4auz56DmO4vL3Pt9ECx6gIFfqxOcg/FxHmUfOCcgc5KGekuuAh
         /VHSzPPEK2DBmy+dpTwZRMgslpgYY06gmtZPHibPPvv47/4kSp5WkyxDbPhwF8smxRtI
         QBDHSYHYqmkcfwWSbX3XvETeoncm9uSj1WC7UtPrT8Fq+0Us76D8j3hPrfobKmuPWod2
         8SMA==
X-Gm-Message-State: AOJu0YzmabxTf1ug9KeY/CrdtqcOgEgRjyr8H5RNM64bGpF5qfmil3Dy
	kxZAbZeXYmKZqytTQ9Xwb9ckPJEcyv2xf0RU
X-Google-Smtp-Source: AGHT+IG95qwWIecwU9lNiOCIXPjFCTg+Z3ZAbo04iCyAWOXqgw4gqzQw32m6M8/bI8BzRc/Z+f+zMQ==
X-Received: by 2002:a17:90b:1b50:b0:26b:4a9e:3c7e with SMTP id nv16-20020a17090b1b5000b0026b4a9e3c7emr5584461pjb.4.1700747212187;
        Thu, 23 Nov 2023 05:46:52 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 29-20020a17090a195d00b0028328057c67sm1414210pjh.45.2023.11.23.05.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 05:46:51 -0800 (PST)
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
Subject: [PATCHv2 net-next 10/10] docs: bridge: add other features
Date: Thu, 23 Nov 2023 21:45:53 +0800
Message-ID: <20231123134553.3394290-11-liuhangbin@gmail.com>
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


