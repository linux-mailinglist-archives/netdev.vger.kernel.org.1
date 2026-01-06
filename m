Return-Path: <netdev+bounces-247337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25331CF7A52
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 10:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93E5030DA5D9
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 09:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58A222F77E;
	Tue,  6 Jan 2026 09:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXqJucy+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432A52DC336
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 09:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767693221; cv=none; b=AzbSltB3YzkknfQ4UfIXSBN3TIpSb2h8z+nu550YSsGa/Ezf/NjdLLfCjnWmyGjkKFSDBW/W43IwM0ikPaxE57IqKTCfHrepVPdWelqAxaxki716yVMvrB9ffL0MqvuzidwpaOGkQdzH124xfIG1BGKDNzm5//oVh/OZzuarjLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767693221; c=relaxed/simple;
	bh=1CZu/EdpV8PmrZ/9MJ8Ck3qacqA+OvGnCwc1CmcaKSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1nRk51cUnQu1IDkqWNW4xYGCD5lx7FpaMsSYKTtNAAIUFLO7ENec88e1akWrS7MYOKlquH7EJhAJsDhSKzgmR5cZMQRHuiVbQ63Y7nmgbV9lFCmbrtyqMqQ0qIwPcYYoFWplR3KebFkvfU6E9rZTct+r8b/XJ2wj2LBbo3N5qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXqJucy+; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-78d64196795so962247b3.2
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 01:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767693219; x=1768298019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENEdETDWcTBseXwQg0tcyt9J65YucuzpqwchphRcKzQ=;
        b=KXqJucy+i2Z6LaW7R1t+E5t6FRSarKdq/ZyjySF1mT03ZgZU2fOoge6pUiazdq6BoJ
         u6lNfwP2RJHeX+rcR08BVo41mv7VachZkay6MZN0f2SMCr9lMxiwK50/JOZhe96SIa0B
         gt7cLjBooByo5d6kyXe9Bk/TeMBJpBOCL4NqQuiTnN1r0YOdZbWJsk4+1/8g6edXZXkY
         ww22hWQZqsrgqsyM6ENOiHbse9vSItCPF7EGOHgcq5kq3DH+z/fki3/UORCnMB4i/2yd
         UlBtn6UExsAoCFcU4+GRUUrCMY1AvjPq4rR+CSJNWzC8+CTBNCBhmCGUOXxnmn4ehn07
         Njbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767693219; x=1768298019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ENEdETDWcTBseXwQg0tcyt9J65YucuzpqwchphRcKzQ=;
        b=JPmrXtjqmpuAJJFUJhlKCwvhMcEQssicGaCD9aPz3prhSOVCLZ+LwVMoNY3dAmUITn
         buE7+9DgaG3NCpQs8WClyabFMUBnJ/5cAamJTAPRpdQOc1OmHFBG2JGr2XQmoZ3Rl0Ts
         vejS6OlBoh/DswKdL9OW+0CTOPt0EO/S6z1mxPn1YRftfLeGS5Hsc78UHSkWbChPGAsj
         QkiSt11ftvJsWEGqe9m0iIzx3Jcr6N68qjPX4h3au1iCZ2nxOyNblaEB2/3z2DbcftM6
         yVt/4sZ1Ktxp9Ww+sVPcO63BryCJu+Bsnx9CzLI+Dak1PSsHubUC7ay42LqOgxfDPvNY
         Z1Ow==
X-Gm-Message-State: AOJu0Yx+0DqoJOlZS4cCnExMFcq3KN/ngv720lDeApLDcKvi5WlVzU4R
	sEqs8cs5KFaiBD2G0tAF4ItMwlNMt8SRSSQuLFH4lvbzntvhbZkeiLDgVExEMLTR
X-Gm-Gg: AY/fxX7YHe3+/buzomslxdNl5tNQsaZ/SEX6L1VC35pwF/nL/oYkF4DR+0TPSW5UrtP
	RVNvTAIFmH8CayzP4E0icU660gaMHz/lO1yv/r895shztGyGxHMHKzHp13sVFQm08R0P4dHAkPa
	PA7Xe6SiKD/GEmXal8wAepYS9yTJhvruiXx4lKNIEifAuqI5ryYAdIFMocjhj1XD4BCeQrWq2Mg
	2xN/4sI2g3V6ilsG081oFsB04J+302BwN87DKpunAY4kZBfgG+eL+Q2GmnJKMuNGwVP+ojHbthE
	x60KEjZVzYrkdgkFvaWek2u+cRKW8Hr7odiCd7QDgChHyBfn5cHWfiLUXiIIuQrYHDAtK19OMhJ
	l7Y/Wz81bDw2b7KVe408JvBfmOd6lQ/BOrfGp7OvVi8xY4DxbPRQ4CTRV30gtHsiQzrtvjK3zS8
	YExCT9rM/c
X-Google-Smtp-Source: AGHT+IEOpuMrOK9n9eMCErO7mcehPGOWAjq1SBwfc0pnWpj7pnqp0zR9QTk9T+/IxSkDElpZidHYGw==
X-Received: by 2002:a05:690c:e3e2:b0:786:896d:884a with SMTP id 00721157ae682-790a8b867f2mr16700047b3.9.1767693219074;
        Tue, 06 Jan 2026 01:53:39 -0800 (PST)
Received: from localhost ([104.28.225.185])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6dc249sm5722947b3.51.2026.01.06.01.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 01:53:38 -0800 (PST)
From: Mariusz Klimek <maklimek97@gmail.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	Mariusz Klimek <maklimek97@gmail.com>
Subject: [PATCH net-next v2 2/3] ipv6: remove IP6SKB_FAKEJUMBO flag
Date: Tue,  6 Jan 2026 10:52:42 +0100
Message-ID: <20260106095243.15105-3-maklimek97@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260106095243.15105-1-maklimek97@gmail.com>
References: <20260106095243.15105-1-maklimek97@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch removes the IP6SKB_FAKEJUMBO flag that is used as a work-around
to bypass MTU validation of BIG TCP jumbograms due to a bug in
skb_gso_network_seglen. This work-around is no longer required now that the
bug is fixed.

Signed-off-by: Mariusz Klimek <maklimek97@gmail.com>
---
 include/linux/ipv6.h  | 1 -
 net/ipv6/ip6_output.c | 4 +---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 7294e4e89b79..9f076171106e 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -155,7 +155,6 @@ struct inet6_skb_parm {
 #define IP6SKB_L3SLAVE         64
 #define IP6SKB_JUMBOGRAM      128
 #define IP6SKB_SEG6	      256
-#define IP6SKB_FAKEJUMBO      512
 #define IP6SKB_MULTIPATH      1024
 #define IP6SKB_MCROUTE        2048
 };
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index f904739e99b9..9af9ec6bdb8c 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -179,8 +179,7 @@ ip6_finish_output_gso_slowpath_drop(struct net *net, struct sock *sk,
 static int ip6_finish_output_gso(struct net *net, struct sock *sk,
 				 struct sk_buff *skb, unsigned int mtu)
 {
-	if (!(IP6CB(skb)->flags & IP6SKB_FAKEJUMBO) &&
-	    !skb_gso_validate_network_len(skb, mtu))
+	if (!skb_gso_validate_network_len(skb, mtu))
 		return ip6_finish_output_gso_slowpath_drop(net, sk, skb, mtu);
 
 	return ip6_finish_output2(net, sk, skb);
@@ -323,7 +322,6 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 
 		proto = IPPROTO_HOPOPTS;
 		seg_len = 0;
-		IP6CB(skb)->flags |= IP6SKB_FAKEJUMBO;
 	}
 
 	skb_push(skb, sizeof(struct ipv6hdr));
-- 
2.47.3


