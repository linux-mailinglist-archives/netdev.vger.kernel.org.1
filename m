Return-Path: <netdev+bounces-189285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63454AB1761
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 16:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E56BA07D85
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359CF22068E;
	Fri,  9 May 2025 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Y9pmxGym"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039D721CC59
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 14:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746800872; cv=none; b=mcnDpV68dy1ZrislzcyICVps8rh/0HQVixDfMRKp1tr/gkrzdYUGkQy1Z8SfeHpfxVgG41SFPy062jNxOw7Z3L+uT7Idg3ABjWfDiA6Iy12x35P+5RBNrlfDW+zGhxeIOH9iXAEyRhp8qg+BcrGLPYfBaFHXy/nbVN+gya1bX30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746800872; c=relaxed/simple;
	bh=o1lchbA4VnQzTNdsPExW4BeHfb285L/1hEshtHs6a3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNfrzVxuK68ykxmA8GH9t5IMKQxkJFQ5pFy5Ez4i03qMJ/9Ixj53Duhwd1407TfFcDeqxfmNCLo6AfcU/f5ogBka2JbLhM1qyjDuIETH4PUlSdlslp6k8VLo2y+ll4mVuO8de4cHwNsJiEo6UDk+LdIpswT7o70IEnLxoHYfjB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Y9pmxGym; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a0b291093fso2058169f8f.0
        for <netdev@vger.kernel.org>; Fri, 09 May 2025 07:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1746800868; x=1747405668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZwIFwdDmDxbrQm8Z/MNI/EjdTMbCDclXqgI8IXZQlc=;
        b=Y9pmxGymKx8XVnQlFOAX2tH887S+GY5oJCBaL8JLH8fm8O4jhJ0VFE2I+AM/Fw2g4m
         sFQ7sohy25+zZCsYW8FOMYUzW+8gS+Nmx7L6AaZiDLe2PyxgB+Fgm1Gd/KmI511oXwNI
         9lHEk6oDcC82NRrSwlXWDOGZ8q24ZOR4hm4JT7dq60R5M7OPa+6anmuIgopu9yORdAc6
         /JHIzzFR0cNO5CLkPbMu9OWZxJgCbi01Kh3FE06gWXbt2D58fvlSy/mprtcY+mZi3fPE
         ixszqUB7j7uc9MW92VjaluEG4yRDiDu2yquEkiSQ0Zat0HudhPh7IycICPtGew7q4Hi7
         LcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746800868; x=1747405668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZwIFwdDmDxbrQm8Z/MNI/EjdTMbCDclXqgI8IXZQlc=;
        b=I/QJ+9Bs+vFe+jUFxa/Gys02s+Hy4Fpo/kCbFRFlBRhlCHCIDAMQ5PddI4iHSzqsef
         vXoy/QsBKjpKexT6iMUWDMh8dhklSaMthZpdLEieI8EKN9Mm7fyirq3QyZwxnbq+9t55
         NKA8Q4+E5q3Pc9QqUTBi6Ujema0lyCqNnq7hBOX7rwEuFckrlQ71LB7O2r2cW/E/REmd
         yxrapBDLt0h2P9DEPhz4tAvSqBVTGomWAn1QZEiIUZL/6N5e95O2KNXu7eSt8jDtbm01
         d3VhVxT4TKwOI+sSDgpS7ofcn8q9GcdiQ1sGLgPyELc7k0DguPXUWdRzHIaJ8fh5P8VH
         6uRQ==
X-Gm-Message-State: AOJu0YyQHQ73CkJ43+CMhm/AkGpxIBCYK8PHACX7+58ZF4mCuLSuPVVt
	o/HlVU4qFpnSEfefmiC5vuX4Cj/fKFBR9AL15OjuVb4DP5a8aRN4RcUadi181Qn0/7gXLusjj3o
	FjO+MpK1rJ006RPM/MrvredBOc5JY8YRNdWlzzB+P7yIgl8eFVweve0wJrr/a
X-Gm-Gg: ASbGncsxCPVdfypitrTnBNt6O6SAkyv0YPaMedeBFpZrT2vsSMwS01PwTdG+GvwE3xb
	1XzbtJ5skm+20R4D+vjK6Fs0vWCx3jsfYe8LC5n3aO63grPe6uz2tiuRH1l9JAMW0gfzYATQwQJ
	aNXPM8l+YsylBhkmo18d9ygFCDO7UvbHP7NhqV8geUSgqjHmG9oQ4Ofe1GzNoeKuAK5OpEqgKPm
	axjRrFBQodazi2eRpoeheO3px63pHjMAUsbbtCdadaBW1mGyedtRbWF8F4JePsN2DVMJapI03IT
	B93BrDax2aejR3PZp67S7OLAlhtXHgx9EUCVbNdKwVMMdp+77gyLwaZI1JeL8bU=
X-Google-Smtp-Source: AGHT+IG+mA3/s92Zlx33L0tWhd9UQc8loJ1nEMLqzZ325WUHkDvWFeta2cXf1BT847HD5+P42DOjtA==
X-Received: by 2002:a05:6000:4287:b0:3a0:b4a0:371b with SMTP id ffacd0b85a97d-3a0b99077b8mr6540667f8f.11.1746800868010;
        Fri, 09 May 2025 07:27:48 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:4ed9:2b6:f314:5109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d687bdd6sm30905025e9.38.2025.05.09.07.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 07:27:47 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 09/10] ovpn: improve 'no route to host' debug message
Date: Fri,  9 May 2025 16:26:19 +0200
Message-ID: <20250509142630.6947-10-antonio@openvpn.net>
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

When debugging a 'no route to host' error it can be beneficial
to know the address of the unreachable destination.
Print it along the debugging text.

While at it, add a missing parenthesis in another debugging
message.

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


