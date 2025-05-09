Return-Path: <netdev+bounces-189280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEC5AB175B
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 16:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3720526478
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800FD218599;
	Fri,  9 May 2025 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Fqr5i8xA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3945B21322B
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746800865; cv=none; b=sTDaB3YzIDcc0UrSz37RnXooZGg9Lh7DPu3uRA1MZDN58AKk3Ow+yhmALxZ+kiPSktuuaoU7Y68XaBkiANgqXayjfM4gU8feeWOXgBok77o8Be8wlskcRdznsDOUMVqu2Yo9nCJKsNDl5sBeiHAITkADHXKsYjugZt4zr+6lDpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746800865; c=relaxed/simple;
	bh=QpA2EfcWlWmS/JKCPzTIOdJ+X7oPjQ0/C56gCM7JKXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NiqO5C8TnhfPr7AywrpmLjwx0kDaD2bubAWxD0u/5dEIVMVZNVmsfbyK5k4/6jei1owYGdY9CQ08YRnUFGJIU4W0qxC3o5w4sj14EcRvpgaHAFs+Kdh5oaKOmGnZUCuhYVAnz/uHefL8aaj4HxJI20/w6uzGGihDbZPPGbcz7pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Fqr5i8xA; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43ede096d73so15231365e9.2
        for <netdev@vger.kernel.org>; Fri, 09 May 2025 07:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1746800861; x=1747405661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvcGTEI4ivw1c1pQFx5cXg4jKdbfPtQRMJdbMnYT5yI=;
        b=Fqr5i8xAXSCBhaMVK3twb6t7STL4WQocGq4rxh2uAbEN8otb/neXOWUy3etrxAUYOR
         JG766pG+XFdSTXbezPXrk/Pesj7vVq4guBegWMUFLokrbBJi67j4o1eVUHzkKvnG+97i
         PdwMVgc7DTm2FEIN1lTH68ZKCYR7+tKZZpyw7pveymPNFMw1gBVaJ/LppRjS87jmCA32
         KGjZ2dVPiLqqc208K9Mm0RMM83i0d1DEBCLs8o8Dt9KBXkmt1Bnx4O3FYysZZmWR99f/
         rRmpzwFWCXntGZ4kr4yIoYBYDMMZ6L41NK93zuwW4p2a3AIXELE6gJfNfAncv6X+M6hL
         DYtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746800861; x=1747405661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvcGTEI4ivw1c1pQFx5cXg4jKdbfPtQRMJdbMnYT5yI=;
        b=IKzdeqQmoNnzYNfOG1cBzNc+nuVD3/qPISAFmMJin7HXbzy8Jr1FSNe1VFOzx8V0Xt
         8TOZvmTQhD81bsXnEm+FmNL0IVw2kHgrFyg4JuLTRD95OaUgS7ikA7uIzHkGl44N09l5
         vm3B6etlPmjqNMmkZRWZk4L1M0QqGkWfDZsUsEiRb0exTSSRKAvqqepKH5vRpvpciydQ
         T53pDXJ9TWy8a/iucJeop+u9H6KJ0+sR5icCbIKsIAeuveyuFMI7ymzIAtGVkzEu6jVv
         Qdueu/q8HoiHBOEUFFo5dANePx+/5LYN5Zc+Fv3i3o4Xit+hGCjtyvuGfODupHBdxHzj
         BXGA==
X-Gm-Message-State: AOJu0YyjlhmUpKFgVz9VCEYgcpObPjxD+C/TYWeC2MoWtyJLbg9qEOBh
	2mXptJIaLk/bxcFQ/0se41UFVguuI/o8ZcMNgcDR2vxOsEaxV79sGc4X3rIAPsn/GROSY/PHtnP
	ZZ0abUSsN46VUA5LR98u4rWbpR6Es/RgAF7PA1+xFRXuxf0MOuQF22FUVZIcN
X-Gm-Gg: ASbGncvG7PMhNH9U18QcaJl4sgP16vlFR5t1vVQ9wdeSUdQ+TuE5PclcP4CaFtA4ZQd
	/BZgmogZHcfhk6dCpl4dTkX1rXL3s+v1eot2Fh4GIXt7hsZPuDT/1p7pHDGJzz2WavXXoZJH6aV
	jXxGTg4Z3s9M6YRtY4ulM//VwecMNXZJ6uwMWFJ/nvMTdHUNMdSnRT2FzqOUHz7kF5jlet0q/OD
	kV7W6MF+gL2JXU2IaGNLO7ZZDdYqS6S44k3I0uo0GZLn6uYIU6IU25cZcncpuoBLMbzs89OXOaA
	KsWfEcrdxhS/WIvOQMu+xFNvfFULJCUwYl/Spkm3K8Y0eMS67FYYp/ZG9Mje7aM=
X-Google-Smtp-Source: AGHT+IH+Zcf4CZ9VafE8ABIo+BsIv53pZZ/zIFXfmIVa7iuri6pHsHQJjZEWMaFOdVHTU3CkMJRsWQ==
X-Received: by 2002:a05:600c:c18:b0:43d:82c:2b11 with SMTP id 5b1f17b1804b1-442d6dc7ce7mr28936585e9.23.1746800861211;
        Fri, 09 May 2025 07:27:41 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:4ed9:2b6:f314:5109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d687bdd6sm30905025e9.38.2025.05.09.07.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 07:27:40 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Antonio Quartulli <antonio@openvpn.net>,
	Gert Doering <gert@greenie.muc.de>
Subject: [PATCH net-next 04/10] ovpn: don't drop skb's dst when xmitting packet
Date: Fri,  9 May 2025 16:26:14 +0200
Message-ID: <20250509142630.6947-5-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509142630.6947-1-antonio@openvpn.net>
References: <20250509142630.6947-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When routing a packet to a LAN behind a peer, ovpn needs to
inspect the route entry that brought the packet there in the
first place.

If this packet is truly routable, the route entry provides the
GW to be used when looking up the VPN peer to send the packet to.

However, the route entry is currently dropped before entering
the ovpn xmit function, because the IFF_XMIT_DST_RELEASE priv_flag
is enabled by default.

Clear the IFF_XMIT_DST_RELEASE flag during interface setup to allow
the route entry (skb's dst) to survive and thus be inspected
by the ovpn routing logic.

Fixes: a3aaef8cd173 ("ovpn: implement peer lookup logic")
Reported-by: Gert Doering <gert@greenie.muc.de>
Tested-by: Gert Doering <gert@greenie.muc.de>
Acked-by: Gert Doering <gert@greenie.muc.de> # as a primary user
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c   | 2 ++
 drivers/net/ovpn/main.c | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index dd8a8055d967..7e4b89484c9d 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -398,6 +398,8 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 				    netdev_name(ovpn->dev));
 		goto drop;
 	}
+	/* dst was needed for peer selection - it can now be dropped */
+	skb_dst_drop(skb);
 
 	ovpn_peer_stats_increment_tx(&peer->vpn_stats, skb->len);
 	ovpn_send(ovpn, skb_list.next, peer);
diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 0acb0934c1be..dcc094bf3ade 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -157,6 +157,11 @@ static void ovpn_setup(struct net_device *dev)
 	dev->type = ARPHRD_NONE;
 	dev->flags = IFF_POINTOPOINT | IFF_NOARP;
 	dev->priv_flags |= IFF_NO_QUEUE;
+	/* when routing packets to a LAN behind a client, we rely on the
+	 * route entry that originally brought the packet into ovpn, so
+	 * don't release it
+	 */
+	dev->priv_flags &= ~IFF_XMIT_DST_RELEASE;
 
 	dev->lltx = true;
 	dev->features |= feat;
-- 
2.49.0


