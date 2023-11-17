Return-Path: <netdev+bounces-48598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EADBD7EEEBF
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 279231C208A3
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 09:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F75F14F7A;
	Fri, 17 Nov 2023 09:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDslITqG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9547A173F
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:32:29 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-282fcf7eef9so1345624a91.1
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700213548; x=1700818348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPubW4rO6QiOWzCHMSlO5V8NYMxcwcZYtNdCDw8LOi4=;
        b=fDslITqGH9WRY2RdrlFhuIj5TOmTeqqV+TTnaxVVNzX8eugP8+0s9Czs9jT9YpqIjj
         hkfJLGKIS2JE2Qhlu1FEfGx/Ik8XYD5pqOcjL2DQJ3EUyvOjQpB8m47PVCZR14/Ib8Qs
         pXZyq3BILquR6XGKN2BuPG0fmjIhBPUTGDCwLkklATM0+YofDIGuWYwse55aFJM+41UU
         tA1i1ddrWWfaBWMW7eWzP6du/fQoFMGv/YP8Rxn9IBs23f/DXMSKPO46jqqO17HWKKbG
         35dTvQzUwF27RJfx/9cBMbqxIYhWeUZTfFsGZoCvZ+9ikyc1yi5B4fFozT1GZ3OCYt6L
         HKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700213548; x=1700818348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPubW4rO6QiOWzCHMSlO5V8NYMxcwcZYtNdCDw8LOi4=;
        b=WlMYh7Au+d4WCrHa4dniZd6YpBT9Lo1xAZ+dFlioaHbhlLeDvthci0AIxpQrQlq2qh
         Fzub5du06IAxQRxUucAl07n0jXA/2HSkEDTDxsN1v+UEvZqxVhlwBOem4VLbMEJdfHws
         s7iXs9CkPVOtVXc/IMu1g592au2giI7Q4xe0QYeWn3+tdTrrmtsDMJX8Ga+8IqaATCAU
         KFiDLCaNXbv1TISWprwN+rffELFS5VR+1JIZ6TEOmRxh1znFXcH4c7/1V5GhkHxHFbfr
         fzgu/fRnDKDgEphfC8Isc4WYK/kQWfmI9hkJ2Hf8ptbXQDzaLqyZhBvjeKcNeGil8i+6
         6Zzw==
X-Gm-Message-State: AOJu0YxVaAgljzhCpBwxLN9edDBgeldAmjkTkIZb3SmOug03xRziW0tX
	ETj0YGkSaE1vfdExKY17qyg/1K1shQYB0eUK
X-Google-Smtp-Source: AGHT+IGvngpo7ko6jR/+ADAd5d53p6gemjifzbFHiLRmyqG9GWbY01/5gKIzLnFQRohDXsz3cbKhGA==
X-Received: by 2002:a17:90a:188:b0:27d:c36:e12c with SMTP id 8-20020a17090a018800b0027d0c36e12cmr17877636pjc.9.1700213548412;
        Fri, 17 Nov 2023 01:32:28 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p9-20020a17090adf8900b0027ceac90684sm964060pjv.18.2023.11.17.01.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 01:32:28 -0800 (PST)
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
Subject: [PATCH net-next 08/10] docs: bridge: add switchdev doc
Date: Fri, 17 Nov 2023 17:31:43 +0800
Message-ID: <20231117093145.1563511-9-liuhangbin@gmail.com>
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

Add switchdev part for bridge document.

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


