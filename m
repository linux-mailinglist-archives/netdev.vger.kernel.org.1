Return-Path: <netdev+bounces-52838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BAE80055C
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 09:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0DEC1C20D39
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 08:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553D118B02;
	Fri,  1 Dec 2023 08:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFsB4aUP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881BE170F
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 00:20:35 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cfbce92362so2101135ad.1
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 00:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701418834; x=1702023634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6bH32cy/PxeSr+LrXLCFJ5FrLQN/VMuHkVGPfyxWmY=;
        b=SFsB4aUPsy4bBtdyWVCk6+nMFmB5NAjxMh+ZpvHA0NNCbqUG0R1u+Rhf3Gz+0z68Mx
         ajzoscLp7fgM+WlS455kuVRZ/aLqGivOQS9ZTht1CdGw6Q9YfWetjUpVMw8vfPp+D429
         wAQTQM48+LwG7/wwCXalIj3xRMBBn+xWFV1oQcizKmkiUllhGITGPLpF9qSQKZHeZdMB
         ukGHEoZgd46UJHgQ7W7MsqXa/Kx1wCpD5VYMv80C24P3peMWvuI+1aPOoKjVWyVJq1qv
         WJF9lhWBjWWd3zksDr2CaBzgmXFcet9k+DuUIybsSassgHGzxqWfKOo5a8hWAUr6YMyO
         81tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701418834; x=1702023634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6bH32cy/PxeSr+LrXLCFJ5FrLQN/VMuHkVGPfyxWmY=;
        b=tUY94onRqw00/NsmCN8lDgVs0EUK/QrAQj3KnteY82FqjRZdjckYr5VHE7gFrmSKk9
         +bIVKAQQvRLb0Cg3cXlecb61gu2LuAUupjHV2whBmb4dcrHOp2QVSSQ8cmTCPauI8Fpu
         OOj++gPFq9/Ng1Z3gbpNNC+JK4D2EpBviutI+cDEXJDqMKvZRfytdlO5AOqt9xQjbqH3
         TzrJyunBZuZyBhZNPV9FkibFQ1dt2xzm1UYY1YW+uxaMwQQaz1x3VIf9e8WZ0i71pwQN
         vFmA/uejSueEynKQejGM1agX7ICosFNEmsK0+/a4TXLa2r0C/8uNsZcnkd5y42nPuDyE
         6gzw==
X-Gm-Message-State: AOJu0Ywv7HO8rzCSATYsDP9oBPWT1idCRmcxd43z995zHLw9IKU2LX+k
	crieMkcX8A6wteXYeMF4fejtEjTcLc685g==
X-Google-Smtp-Source: AGHT+IHeAx6t/LJjtZf0OBzaW1jy7pFZKocvcEFMGx+KQUSpts2z3NQm/8/lXIt0kuC3G8mP7UCniw==
X-Received: by 2002:a17:902:8695:b0:1cf:dce0:4d60 with SMTP id g21-20020a170902869500b001cfdce04d60mr15086048plo.6.1701418834571;
        Fri, 01 Dec 2023 00:20:34 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bf3-20020a170902b90300b001cfc68aca48sm2715787plb.135.2023.12.01.00.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 00:20:34 -0800 (PST)
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
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCHv4 net-next 06/10] docs: bridge: add VLAN doc
Date: Fri,  1 Dec 2023 16:19:46 +0800
Message-ID: <20231201081951.1623069-7-liuhangbin@gmail.com>
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

Add VLAN part for bridge document.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bridge.rst | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index c14410008ddf..97936b9564fd 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -148,6 +148,35 @@ called by the kernel when STP is enabled/disabled on a bridge
 stp_state <0|1>``).  The kernel enables user_stp mode if that command returns
 0, or enables kernel_stp mode if that command returns any other value.
 
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


