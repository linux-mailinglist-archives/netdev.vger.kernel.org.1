Return-Path: <netdev+bounces-51595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1047FB4CA
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 09:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615831C210DC
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 08:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC042E3E3;
	Tue, 28 Nov 2023 08:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItPpayfV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5C9E7
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:50:36 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5cfa3a1fb58so23440207b3.2
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 00:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701161434; x=1701766234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zRW1MdnZiX3AOov0+Nwg25Dvqe5Quqvhljjzc3Zk5Y=;
        b=ItPpayfVAVUCAP4IjCvv+g1Z5E7ymVvZ6wsqPE808AQJ2ei0sGcmzVI1GIK/RUTz3+
         bWy4231LBQPx8pBs1jne/7CQXhpjhLbltV7Y191pZWsm3KfAH7KozAM/m/w49ReHnywW
         bNAoVR55B94vmhKMVhrTRB7s/0nc/wj2OCUe2mzaer3n9MZkwRh9y8gwSrhS0lB1UV8e
         L9jgf/rHxU9di50IWMP3kvTaA8OgLz2VHL+rmM/IJimJDb2N6JQ5hhMpMJ8Weqzz2fJT
         tWfHS5s8N4pUpjfNiThyLuOKQnbatRTKwNOoebzTQiKaiO9MDm+36nJY1YD3MEGL0WWi
         cVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701161434; x=1701766234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3zRW1MdnZiX3AOov0+Nwg25Dvqe5Quqvhljjzc3Zk5Y=;
        b=V6Au5pS8p5WpzBEvXnxeY8/jK77xmbIr8vwhfIGt4aV4GZWmS/OXwxjeq2XUqCLVFl
         6/kKBKoDXZgNNc1Fe0uWUUFVFjllCXuT4Oz/4hc+Uuq5I+vvaQVJ2J6i3YeyeC7h9bXW
         +NsxFe33Cy2yIp/n2sNFZj2CLiUnvpEUVF7/BHC9tXyLz9lTF4OyAqvQWgWQjaNWKNuL
         vmgQxHaCXIvZ0EV4TQ30zvHeRj7+1GzlSfxH1YjV1qoX8X1hFjXM8Ji7LdDZkQeRytT6
         jDDVkcF+z9XGvusVDw6AQJwbMo3jwKhFYrd3Z2RqLraB3C/bUBA5Ajau8vYPZIU9e2yS
         NZcg==
X-Gm-Message-State: AOJu0YxzTbZMjQeLWBA8ZIkRvuXOE8OfIprQqK+fi6ZwnDOnbK8KNJ+w
	JCurHoJfz8rgkhZ1Lz+UBsPG3O3c+02wQCQf
X-Google-Smtp-Source: AGHT+IEkTv5jlg2KGTbTRU6g9oaFTnavPXoLJaru4xJOV1Qo1j9SoK/ABHx+4TXIy+IUT/vk7UtsSQ==
X-Received: by 2002:a0d:e8c8:0:b0:5ca:10d0:c3a2 with SMTP id r191-20020a0de8c8000000b005ca10d0c3a2mr17996111ywe.19.1701161434339;
        Tue, 28 Nov 2023 00:50:34 -0800 (PST)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78159000000b006cbae51f335sm8766513pfn.144.2023.11.28.00.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:50:33 -0800 (PST)
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
Subject: [PATCHv3 net-next 06/10] docs: bridge: add VLAN doc
Date: Tue, 28 Nov 2023 16:49:39 +0800
Message-ID: <20231128084943.637091-7-liuhangbin@gmail.com>
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

Add VLAN part for bridge document.

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/networking/bridge.rst | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
index 9d07da681bc5..764d44c93c65 100644
--- a/Documentation/networking/bridge.rst
+++ b/Documentation/networking/bridge.rst
@@ -132,6 +132,35 @@ called by the kernel when STP is enabled/disabled on a bridge
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


