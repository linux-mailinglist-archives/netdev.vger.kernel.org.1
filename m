Return-Path: <netdev+bounces-190686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3385BAB8499
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153E51BC1C3C
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122A62989B2;
	Thu, 15 May 2025 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="B7aBKBHM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29E32989A0
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747307670; cv=none; b=PUOIRqpMwNjowzc0xhkQZozpT+Rt/J5IhHSrmMiK+MTLnyUaEXuAd7QE/26KdTJFV79/68XjGfOcdYB0ocGBGbJu/rju9OE3UKhMf8KXlbvRvV4O6NwaDlvVDRbFe5m7YJL/85H8RIj2WvdK7CP4qUfHzkvBroyHDupOyb2Z/Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747307670; c=relaxed/simple;
	bh=Gf//BG43K3Tf3FQERlG2nSN9E0Vs+ZPF6zjo+sVJaYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X06EtsYpcPz2dUgP8ww44UAqVQ+KcMFmoJuNFiyZV+idSFC014Y7jOoxhL+W1G3IboXNyh4JIN8c8TzBvCl29IV2OtxUIwDCNLodie9E4JxMMrd/eaRzF0BninFiyQM3uW1pFKOZlUESukXdAFpekTkpxfPwaxavSuKWjFrza64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=B7aBKBHM; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d0618746bso6195415e9.2
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 04:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1747307665; x=1747912465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFC+CYuc+lma1Z/Jr+A/hgZIN35QOyNF1dwagEiqkCs=;
        b=B7aBKBHMa/pMv7v/alrSdIZkdj4IZSjfBf0LEBWhy94BZiZXO42wKcbgHWAQe024Kx
         KCnoqqVDEwjKw2Iv8f//uGSy28HnRGWmbawp+lmXum+W0oeqN7jOcu+eMX3lS8MewhhV
         YV5uK2H+d4YoK7Mt/vBYZqIVcrVOZ4bxAy1GEgaFe7w1EwAiDSy69vVj8pXLkS5zMUat
         6+Aa4kZYOP3sY20iza+8EHsMiHfrVJ80xlH51Xp5raHcaeTw9MUotrdpWFMVAAWMvXIP
         JS26TyR1Mo04lLr0Tw/FApLjjVeKRxwrifZdE16ophfzl2oQf7vzPGeSE3Y3IZbThZbO
         Mr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747307665; x=1747912465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFC+CYuc+lma1Z/Jr+A/hgZIN35QOyNF1dwagEiqkCs=;
        b=g+CgcqoGJ+Nrb9TSVYRaxwHypzYfcdEw6BXznj/rL6RtyVctSVG4SceM0bs9wWn8lF
         zfOVTuVOtoq0CpgpBIdh8Fa8BjIfZ01XTpiIcYYvyYlTIMWpSIxMHG0oPlFADtUtd9SE
         3jKfJ/WBCFqKzgrDPhABY3Rc/lD3tQuBEwM/DIgjXJbU66B/wOgs9k91348YxYbsoxFD
         9BvpwoKOSomCCz1B+xmHiEE9Ef/9IyR5xvH+0J9tQT2BR8bngQwifT26IDnREAg6SMCU
         Z6Z6L54f+0/vaAavB3IH2gqQnJUiWoZkVqOk3dzzn8b1zr7tumgNznOqzS1cE+stpWuZ
         qRgg==
X-Gm-Message-State: AOJu0YwmSw5xe1Y/SJZE6VkFTylsgUWU25IU/vVy0dunPXAfxLBD/q18
	XWq/wR13Dx1bOBThcdYjyjy3whtFTLbyqq4Ufk81c5MrHEOCYtGSWxhjYBx+/ly4Ig/6Kfv9dK1
	VgvMFZgqrUB7Z2eCvtAyIhS/vMGWP6ZvYh0QPjvVRwfjez6NQsnfBe7lfdzmw
X-Gm-Gg: ASbGncuSvBY44X7vWoxvoX47Ck+BhworrH+7r9VKLt9hv4ek7D0S+hJDqVJ37cGUfjs
	0D2JKH+V3mbBxE0jnaPsnu7Pq5JwZ+0yCE5Me1hNZ1LEzzCLtxL+C2g5fSer0KTQiGoxUqamEBU
	YVcc59yZjdve9G1plkW8o0ZGEtWgfRvD0gtg0sGNRNNO3D+F3FJhipjUYSiSmi1AFWmEvyZc/Lj
	AnhCrVffq1exVuMUGid0Vy8uKOL3zDILafoJzKUUoX22oseeM3SK6I0JG5RRYLxNYKAvDe4B10H
	UyGUX3NBnOXGvFr+pN0eSNwGbW794iRBajB1HELtd/FPt0zr4tr0DhtTQw1lCkRRqFh8+2KxxIb
	RSD0hAKtoyw==
X-Google-Smtp-Source: AGHT+IGgL+KI4zJK/8Wc5flYaQK/GtE5mS6Bi+RdHhXbbgUIHpfsmCmk4yqORRqZTUQppRroZNBV9Q==
X-Received: by 2002:a05:600c:a344:b0:43c:eeee:b70a with SMTP id 5b1f17b1804b1-442f970b191mr16780935e9.22.1747307665411;
        Thu, 15 May 2025 04:14:25 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:d81f:3514:37e7:327a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f8fc4557sm24321435e9.6.2025.05.15.04.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 04:14:24 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sd@queasysnail.net,
	Gert Doering <gert@greenie.muc.de>
Subject: [PATCH net-next 03/10] ovpn: set skb->ignore_df = 1 before sending IPv6 packets out
Date: Thu, 15 May 2025 13:13:48 +0200
Message-ID: <20250515111355.15327-4-antonio@openvpn.net>
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

IPv6 user packets (sent over the tunnel) may be larger than
the outgoing interface MTU after encapsulation.
When this happens ovpn should allow the kernel to fragment
them because they are "locally generated".

To achieve the above, we must set skb->ignore_df = 1
so that ip6_fragment() can be made aware of this decision.

Failing to do so will result in ip6_fragment() dropping
the packet thinking it was "routed".

No change is required in the IPv4 path, because when
calling udp_tunnel_xmit_skb() we already pass the
'df' argument set to 0, therefore the resulting datagram
is allowed to be fragmented if need be.

Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
Reported-by: Gert Doering <gert@greenie.muc.de>
Closes: https://github.com/OpenVPN/ovpn-net-next/issues/3
Tested-by: Gert Doering <gert@greenie.muc.de>
Acked-by: Gert Doering <gert@greenie.muc.de> # as primary user
Link: https://mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31577.html
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/udp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index c9e189056f33..aef8c0406ec9 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -262,6 +262,16 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
 	dst_cache_set_ip6(cache, dst, &fl.saddr);
 
 transmit:
+	/* user IPv6 packets may be larger than the transport interface
+	 * MTU (after encapsulation), however, since they are locally
+	 * generated we should ensure they get fragmented.
+	 * Setting the ignore_df flag to 1 will instruct ip6_fragment() to
+	 * fragment packets if needed.
+	 *
+	 * NOTE: this is not needed for IPv4 because we pass df=0 to
+	 * udp_tunnel_xmit_skb()
+	 */
+	skb->ignore_df = 1;
 	udp_tunnel6_xmit_skb(dst, sk, skb, skb->dev, &fl.saddr, &fl.daddr, 0,
 			     ip6_dst_hoplimit(dst), 0, fl.fl6_sport,
 			     fl.fl6_dport, udp_get_no_check6_tx(sk));
-- 
2.49.0


