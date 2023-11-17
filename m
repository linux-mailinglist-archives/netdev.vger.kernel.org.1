Return-Path: <netdev+bounces-48596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF887EEEBA
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711CF1F26E8E
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 09:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207F313FEA;
	Fri, 17 Nov 2023 09:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFHqnAZf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ACFD67
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:32:21 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6c33ab26dddso1682636b3a.0
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 01:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700213540; x=1700818340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8oUo9C5xcva8KJDqQvql+tezZAPIpLAGnaZWqMceG4=;
        b=VFHqnAZfMHaoiaJWydlM9SYGgiuP/VDMU/bI8gHU5tSJZjhm9rBYmkdJNyeN/Hptug
         Cr8g4dCLfQz3KKYGNAqw34bRQ2FVj1wGv8mwUeAUXtdRlVCj6YJSDy3c7NxHxDnJhS7v
         FDHGBiMjFpOOqf+j3r5A1eRqaBCr6Oiura0NeoEhfuTBNhSiNVfT7jEe7589QL5lk/Ln
         wRucZ+7kwvjK2enPQWTfLTgP3mBCcP6uBZpTFykE2vC5hPW3shmmgrD1p2Pxxb8LUpec
         /X3DZwrFRZ0JusvWISxEKuPQ5rjq7OLpoMC7h7qNaUncx+s4K40dvPNo+H8wtj5BUuE/
         dDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700213540; x=1700818340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8oUo9C5xcva8KJDqQvql+tezZAPIpLAGnaZWqMceG4=;
        b=d9cY/EoCG7++2xaU1cmp0M34+iShb3LqOpbrOEjQQKewVoz36qolYZ2a5YfoRYjoU4
         sLAD6PoUxFgMgib0Ct5I1wS71GrKLiyQBunEmSa/bLE2YrgTYK5z/ma2lMG7AADxo1cY
         qxsnhzzcySJK+I2j0qSGCR6N0g8hLwiHTx9tFtl9Sj08rHCEb/7X0B3gj/yc3vkYWgjL
         kGq7KcHR97IO5832YwJhoCdpz5Lj/De12ecg7RIPd/pFYrVm1vbltIJhcKWpGHFvJTrF
         gvDl53yMfBpKUphEwj5duqvPufBvt4JJbDw+Ng/acgjBs5UZO2hRuppNtXKYNCkufj4l
         i/CA==
X-Gm-Message-State: AOJu0YzDWbkDRIJk3A1MgrmZl8+lI/h+jw9Ae8PAaHiBD3bLzBlBn8uf
	9rEK9I8oEpAYGQqNq2t45sAVA0d2R+z3SXv0
X-Google-Smtp-Source: AGHT+IGbbkmT9+0EjIe5VKBsC8+VLfoAvTC2sCf14cXcIU8qEHIoQklg5peijSgp8mSEeAtKDO1ZPQ==
X-Received: by 2002:a05:6a20:12c6:b0:154:b4cb:2e8c with SMTP id v6-20020a056a2012c600b00154b4cb2e8cmr19838551pzg.24.1700213540079;
        Fri, 17 Nov 2023 01:32:20 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p9-20020a17090adf8900b0027ceac90684sm964060pjv.18.2023.11.17.01.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 01:32:19 -0800 (PST)
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
Subject: [PATCH net-next 06/10] docs: bridge: add VLAN doc
Date: Fri, 17 Nov 2023 17:31:41 +0800
Message-ID: <20231117093145.1563511-7-liuhangbin@gmail.com>
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

Add VLAN part for bridge document.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bridge.rst | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index 1fd339e48129..f70f42ab7396 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -136,6 +136,35 @@ Proper configuration of STP parameters, such as the bridge priority, can
 influence which bridge becomes the Root Bridge. Careful configuration can
 optimize network performance and path selection.
 
+VLAN
+====
+
+A LAN (Local Area Network) is a network that covers a small geographic area,
+typically within a single building or a campus. LANs are used to connect
+computers, servers, printers, and other networked devices within a localized
+area. LANs can be wired (using Ethernet cables) or wireless (using Wi-Fi).
+
+A VLAN (Virtual Local Area Network) is a logical segmentation of a physical
+network into multiple isolated broadcast domains. VLANs are used to divide
+a single physical LAN into multiple virtual LANs, allowing different groups of
+devices to communicate as if they were on separate physical networks.
+
+Typically there are two VLAN implementations, IEEE 802.1Q and IEEE 802.1ad
+(also known as QinQ). IEEE 802.1Q is a standard for VLAN tagging in Ethernet
+networks. It allows network administrators to create logical VLANs on a
+physical network and tag Ethernet frames with VLAN information, which is
+called *VLAN-tagged frames*. IEEE 802.1ad, commonly known as QinQ or Double
+VLAN, is an extension of the IEEE 802.1Q standard. QinQ allows for the
+stacking of multiple VLAN tags within a single Ethernet frame. The Linux
+bridge supports both the IEEE 802.1Q and `802.1AD
+<https://lore.kernel.org/netdev/1402401565-15423-1-git-send-email-makita.toshiaki@lab.ntt.co.jp/>`_
+protocol for VLAN tagging.
+
+`VLAN filtering <https://lore.kernel.org/netdev/1360792820-14116-1-git-send-email-vyasevic@redhat.com/>`_
+on a bridge is disabled by default. After enabling VLAN filtering on a bridge,
+it will start forwarding frames to appropriate destinations based on their
+destination MAC address and VLAN tag (both must match).
+
 FAQ
 ===
 
-- 
2.41.0


