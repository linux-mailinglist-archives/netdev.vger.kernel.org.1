Return-Path: <netdev+bounces-190692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A74F6AB849D
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46E594A73FC
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4CD298C3F;
	Thu, 15 May 2025 11:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="MMW9yzcj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552B4298271
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 11:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747307677; cv=none; b=KyF9WiDwLv8gMjRiLxNLHTPCe64fDCQhKpSuXky7Ioy9BV6r1HMTRO1ab9za12KwcbkKXgZVRP2seIHaFmwmuJWMK4IpftPjvpS4akdUBG9DVXpk+7EOB+HnQ9wOaq7eMgQqJvGOCqybdcUofbsVtzsZrHQHUGcmEPBilpEDvIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747307677; c=relaxed/simple;
	bh=CRS2xeSJ4IY9pv1QapUoWbU0vJvrXzg3xAg4W+3LX2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6wZ0htczvxuFxrgMq5GimQSfJ9wbosBHJ1RWzpINu4OUBYHeh/DQrougVcbHPlECL+huPvcDVxvgSGNauXbUK50MHWxHt8iQ/kvA/ZPqj4PCS34hLYQW1X99+YPyFhicSTHMhsAZdarN2saTkLiRxKEQl3Hx/IPUE06DMMtHY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=MMW9yzcj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-442ec3ce724so6515005e9.0
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 04:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1747307673; x=1747912473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctwA2k19d6mcq5r26aj34KLlbbgK3X3zKI6CKBc5QdI=;
        b=MMW9yzcjpTGqclx1SBdDIxCzv1PWevmnpxjLnA6NCpoLXIQ7Q/eC03W/m07bqV9awf
         JnTHGG5tz5Cc5To7YDKgnnKNKpyazXdiqqi77z4s0vbBW/1BO668SPaSqCTJrgBCE1mu
         DI2y5i1nojcSzLOCJP0eMSEG/QIUebdDUskOVvMC5dLHyAsk5scgjg2x2coWypX+Jymx
         fR8gtzaWzdRkUSjD8xgv+LpmTkpC67VypaQAeoxXT7roLllGgGXGkPOe7T++OVs0NVqc
         FCXDfzUBGBcYTkNsY4UhZn1d25Eo3kJyBPmFpwE2sXDXABow6rm19vTXMnP2fH3fuRGK
         IEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747307673; x=1747912473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctwA2k19d6mcq5r26aj34KLlbbgK3X3zKI6CKBc5QdI=;
        b=iVvrEejYxuZVB//RmoaC+9nxsWVQ9VdB3ogwcz4y00puOkoBTt/1l8rEUctZmTndRd
         dlVhFlsiX7ulC9Q8dN7TxkZLdmISxgbMG+iXhcBKmtptmD3xvMJtBi0Zd6kG+myU0Hdg
         l3jfHwb7QoKFGsb1kmt38JEzksnXDGkSADtbtTtGLfxGRGJb+gzfC4hzlXcF2ucyUt03
         ii4ROeRZGfuESVnJwzJZ6pgtoO/V1Htf/5HxRHRWZ3GcxAGv+gkx8D7KNK0ABDSmG8ZR
         gl9BCvdhhrCkOtQ/Gvws4oD8kyLxiuiaegSJUr1bQP4gTigsyOWlrbE+GRN9+QgxLwlg
         iDAw==
X-Gm-Message-State: AOJu0YzUnARTV1Q13v5/jpJT945uC0cyJro52xzoIs6UfHUYCjzWdxxt
	QNYt+i1pbHncGop4OkI0/Vd5Hrx4U5vp1Q2OeP4HiL3Dr17+m/erW/U/uIUrNaTu2XPOUl8aXTz
	8AVmrcAq6WBXWuXt4p00MuQQLOO+0JiqWsui9iCR+LHZtPp5dda/sjWQS/QLe
X-Gm-Gg: ASbGncsNe8TMZj3C+ww+J900QTX12ZHz9UEQ0PqsD5cMbkA4wsvTB+LQ911Aon3TqkQ
	pRIL+Ok74dVJZVRA32VExc8ImXpX3yDVXFQtOGfkMUJXHDZHnUkjJFvGk4c1/VlQiR2XSVYHg8o
	ntuD9M5+hNZr90YnrTrbZ692Hv0/Wrd1XY5v2aCIjdzxDyxUb6sXU+YXyqTvxrzWP9sIT+/XdES
	dlRByoNUhQxhE1968iD8qRkoA1NngbyG47SIY4WqSsk4QON7QIkU9aZrEF06NLsjtV8cuFVQn5L
	hkrHAaomMS2W5VffhDSqTwt/cRx1PQO/AxhJNFZAd5MYmv+iEpPRGspU3xLxaRCrmh5uyhcNgUc
	=
X-Google-Smtp-Source: AGHT+IFhvwZSn5Oo8+2yjjbX012+THeI+iueyhpWwylrwSvDWjMq61Jk3Mm9gvUMtNN7bQbqiwDCtA==
X-Received: by 2002:a05:600c:1e89:b0:43c:fa24:8721 with SMTP id 5b1f17b1804b1-442f210fa5emr76680975e9.17.1747307673309;
        Thu, 15 May 2025 04:14:33 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:d81f:3514:37e7:327a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f8fc4557sm24321435e9.6.2025.05.15.04.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 04:14:32 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sd@queasysnail.net
Subject: [PATCH net-next 09/10] ovpn: improve 'no route to host' debug message
Date: Thu, 15 May 2025 13:13:54 +0200
Message-ID: <20250515111355.15327-10-antonio@openvpn.net>
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

When debugging a 'no route to host' error it can be beneficial
to know the address of the unreachable destination.
Print it along the debugging text.

While at it, add a missing parenthesis in a different debugging
message inside ovpn_peer_endpoints_update().

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/io.c   | 14 ++++++++++++--
 drivers/net/ovpn/peer.c |  2 +-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
index 43f428ac112e..10d8afecec55 100644
--- a/drivers/net/ovpn/io.c
+++ b/drivers/net/ovpn/io.c
@@ -394,8 +394,18 @@ netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	/* retrieve peer serving the destination IP of this packet */
 	peer = ovpn_peer_get_by_dst(ovpn, skb);
 	if (unlikely(!peer)) {
-		net_dbg_ratelimited("%s: no peer to send data to\n",
-				    netdev_name(ovpn->dev));
+		switch (skb->protocol) {
+		case htons(ETH_P_IP):
+			net_dbg_ratelimited("%s: no peer to send data to dst=%pI4\n",
+					    netdev_name(ovpn->dev),
+					    &ip_hdr(skb)->daddr);
+			break;
+		case htons(ETH_P_IPV6):
+			net_dbg_ratelimited("%s: no peer to send data to dst=%pI6c\n",
+					    netdev_name(ovpn->dev),
+					    &ipv6_hdr(skb)->daddr);
+			break;
+		}
 		goto drop;
 	}
 	/* dst was needed for peer selection - it can now be dropped */
diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 24eb9d81429e..a1fd27b9c038 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -258,7 +258,7 @@ void ovpn_peer_endpoints_update(struct ovpn_peer *peer, struct sk_buff *skb)
 		 */
 		if (unlikely(!ipv6_addr_equal(&bind->local.ipv6,
 					      &ipv6_hdr(skb)->daddr))) {
-			net_dbg_ratelimited("%s: learning local IPv6 for peer %d (%pI6c -> %pI6c\n",
+			net_dbg_ratelimited("%s: learning local IPv6 for peer %d (%pI6c -> %pI6c)\n",
 					    netdev_name(peer->ovpn->dev),
 					    peer->id, &bind->local.ipv6,
 					    &ipv6_hdr(skb)->daddr);
-- 
2.49.0


