Return-Path: <netdev+bounces-190687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E90AB8498
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC2D9E6493
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82562989BD;
	Thu, 15 May 2025 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="GHJ7u5vb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CBF1D2F42
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 11:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747307670; cv=none; b=qKWwGqAWBChnsLRKB/c7Qvc2TVxeMPVH6SFro0lFcv4JMYBNr4GNdNOcs6etm19nv6i5TU7GzOQMAP7RGyaSFzRYr24vFsyotqHbF2vt5Rez4ZL7raZR3MQH61xhSHMWyESG+8B5yvxd3KhLNNsx3D8sSDswMNi2bnqN6cl6aiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747307670; c=relaxed/simple;
	bh=uJ659rSXpoXs4yxHQYIcoQRdDlt1Tzdxd1MYDDyvNdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ji+sG6MhXmC83Hlo/oTywEEuOHnfSSFtTVj70TN9fO+eJapGfjMptAKp8NW8hZVcAvguOxewqw6A+5HUfuw0z9XJsjy7ARDIOKfRJo912KRTAFrJB1rrUi5vXEulVZtoOpY8Ukkkw8jFwKnMH6wKFXFl93ZRsjQyBDE/mNxAV9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=GHJ7u5vb; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so6288315e9.1
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 04:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1747307666; x=1747912466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayiIIPtTmNtkvPKXWmL635X+uQFAuNDHLUnTEUP+O60=;
        b=GHJ7u5vb7RaiPb6iYVkWs8eROlyg5fok9Lsfa+R+g6IfRZ0i9ZPOYu8Z7IjUj17sXF
         MPBhLgASDsSUofY3+YxL9LEiCTe0zfpgUgQRA0EucllGjKLELIdSvaDwXFhT5AIRPRWi
         kQUVGp3vDP+L/TEhuMmp2rWjRcxALEr/w/stlR0qkLTS9Cn6lYvxihYn0QneSJEpqv7y
         LoGRU8maKCqEJh/rlM+yxmn/8gDf5QCW7JBY2mP+F3hDxXcql9jf33ffJqviGuyMwkZP
         nod6Db1GOC+VRz2GYpwNjYWknLqseYXMIfBmtoCYIomRGu+mi/AU6kFy6q9RcVlJDzTS
         7rnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747307666; x=1747912466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayiIIPtTmNtkvPKXWmL635X+uQFAuNDHLUnTEUP+O60=;
        b=AL28HdxKpsbw0ZbLSGhLaPnL0wW/FIiJXdkMqLjxbth23Aei7L7z74aepHfuyJXB23
         Zsg/lvCqf6JH5ej5JNS9kXxwB7M0gnV6BAeLCRMBIOgOQ2X1qFzHXzpoQq5JwQz2uNCG
         GkSnSSeipmO/I5DYA2Ivw2+OfMrLD00fp1Ujwi2+1BvkTVsuHmmZHzTwtAQgle7077Nd
         RH597hWpJdHCZl2YuofnJFUae8dtdXj81PPPq5KM5K2vH6BA/Pw/UUhN6iX5F4gmqJPc
         pcYLY37sOR6TpmtbQnRaDOMJz0RWEaMEg5Vr/rgGvS9oX/c5UME9CVO8bmqCcGKLP1hz
         7VWA==
X-Gm-Message-State: AOJu0YwUT2BgEKieikTnmvWxrzk4TYQfU5m1dhUVZgUFnX+ff8eQ5LtS
	fP6ZaZMM30CcBlhqBmJSpqmkmpOecS9HOqp2AIerJg2dOCwGRqz9fEUG6O+a1m96RBBBSJo/pRA
	IJAThqPY70uE2yjuTmny+7WxaPYH5Y/HxBhdCzm5/Vu9ix/LJNZrG7DnJfnav
X-Gm-Gg: ASbGnctIG65ZLjAk9gRGrlMpeUdQvs5Hlg6HDuxHaKmzkH7F6SPSa8iBXLSvpbCUlE7
	6iQCcxLcaj4ccrd0AICaSqGUgTs4+FKkjft74MzPP/ub903CVieGQo0CvpRSM24Xg20svg0EviT
	tozs2EveSv2NjCJn17vyuplkGzZ5hjN32prlJbBCbmwRiB750iiM3q19BKhbvqwu8EVq8TkSXu7
	H+1cpckxeeLB+x1r7UgUi5uJ9xn+mxReO+vrxFIti0W1TJI2BujOk7FgxyXAp6VPrj44SQ3akRx
	vsN3ZDC4DVHEamRtxKFLjmPOsS/XkhRCi495Qo6eZ0zyJGXPttNn/DoAryvjECkty1vQMVnnHH0
	=
X-Google-Smtp-Source: AGHT+IH/aU0vP+YoB94wZA+Nm/WufDIRAtoECjfs9nfWKT+d/L8gMVPkiptGZmDI658NxzOonbjzBw==
X-Received: by 2002:a05:600c:818a:b0:43e:afca:808f with SMTP id 5b1f17b1804b1-442f21778cdmr72865675e9.31.1747307666551;
        Thu, 15 May 2025 04:14:26 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:d81f:3514:37e7:327a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f8fc4557sm24321435e9.6.2025.05.15.04.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 04:14:26 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sd@queasysnail.net,
	Gert Doering <gert@greenie.muc.de>
Subject: [PATCH net-next 04/10] ovpn: don't drop skb's dst when xmitting packet
Date: Thu, 15 May 2025 13:13:49 +0200
Message-ID: <20250515111355.15327-5-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515111355.15327-1-antonio@openvpn.net>
References: <20250515111355.15327-1-antonio@openvpn.net>
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
Closes: https://github.com/OpenVPN/ovpn-net-next/issues/2
Tested-by: Gert Doering <gert@greenie.muc.de>
Acked-by: Gert Doering <gert@greenie.muc.de> # as a primary user
Link: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31583.html
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
index 0acb0934c1be..1bb1afe766a4 100644
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
+	netif_keep_dst(dev);
 
 	dev->lltx = true;
 	dev->features |= feat;
-- 
2.49.0


