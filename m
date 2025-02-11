Return-Path: <netdev+bounces-164977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79576A2FF4F
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 01:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4859A164FD8
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 00:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D431D5CD9;
	Tue, 11 Feb 2025 00:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="czHZe98X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CDA1D47A6
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 00:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234463; cv=none; b=udtGmetV5YKJwsDVbajm9zqgVLf3Hj1Wmxh6mu3+lqEeFKCgp3eF2JN0cPuTDnIC3tr3+L0pjkY+hbS5SnaNTcMhbRgdIDTTllZHbIJe/HxPGr3rd+qONusG3ShSixKRWy4h4u6oZeROlZYOBFqMNbqyLPLnIPA3V/dReJTccjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234463; c=relaxed/simple;
	bh=eJ3PNxxAZekah9naKbbW6jo7KQBN+FSwk2ZBYWG0nks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=spOdJB2jUpAm4BL6jxbcX5o4H8eq7+lPK/utsVcpPFaH+dfAz2CXDQGC9ya5fRFU7P8IQ9m0Xjdv34TWlgDyuiByF7Y1qb+U+qDya+tBRddyQuhQE0c4WFWM7eu8r1hspF4F60oJZmBk/ryfvP6V51mroOEPKYub26nW7zL/AhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=czHZe98X; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43944181e68so17209675e9.0
        for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 16:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1739234459; x=1739839259; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qk5TLUGwG4S7neZ5Y4DGrjf9AZmKaXK3mVQ9uModc5A=;
        b=czHZe98XzgfGZp9xrXYLOX5+8WB1C2zI7Dwwdnk/Ttzc4HrV2Wn7ech/wUk4ig/Jd1
         lZW4/w7gPzzg3LelvyMjpnqi7hcJrkIM1qpN/GUCK5U1GBDAERxR65Mq9JiLCk2MisEZ
         5AiuCy7SSttxhweZqvIhPC1lWt95xYrtS8Gc4nEVfX2G1+FJGiVpQUm7lBNB8uP2F1lE
         Ipv/KPRClkXTlCbc/ZRxcj2B89008ZD2dtoMbqjcjfTkKggovAMKwWM+0Qg2L6HGp7+G
         PL2V5UCHVwLm8f8o3KYqsanQq2pQeifF7+7u5R9Y8tqHNr3opeCpqz4Y4jAOLL7O4GCK
         6pHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739234459; x=1739839259;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qk5TLUGwG4S7neZ5Y4DGrjf9AZmKaXK3mVQ9uModc5A=;
        b=AgguDPYyqJad8YhYpq+4Not10J/YHNJcpoj2lRIn+R2fLi+GqaCOR/jj3vgtaSeWN3
         Njvtpr/TM2VNz23WFpfkOgwLjc0xrgQDZnOKtfh4pFQKjmm7PDDnJ2yd3PbL+/sO59wz
         03zTrQEXegXqsq1jHa1k/TltwTY5a+6NWZ1KC98KRSDyJm7+NOkuMX7IOBh1vOmp5/S3
         q9UjhNFuPgNR74KEarvOugtxN8FrfptrHms/eGMTkuRYmE/caLYVZEEHDOAGUag8aTQJ
         xl0ImhHUlMZHWfjLdtncR07scBTazK6ytO8UWS8murKQ/VEEUQWOQHDKBgN15Ha2Gboy
         7uiQ==
X-Gm-Message-State: AOJu0Yx6yvKoYKlBYHXmJrCG94XkJJKpTBIMFqwZriEYkUxJnOQhhBnb
	oaC7vraR17NtErOHlwW8fRqhar03C2mK32PXMAx/NQ0o4nhvqM4to5s2dqPmGLw=
X-Gm-Gg: ASbGncu8MrQeKlVlTTXqweTZTUrqrnCsCz3uc5vplFZiO1+fgtnjWC58y5X5FnPI6dI
	JX9IO8bRq8w3l04YY5rFsmUTaFZR1TLZuy7j9m7YYVhAb3DdJq9LJpz7nVPHNmMW0eqrgj/UMFU
	oWlGpduwkUFqzGGlVi85MEiYXXQg4CGHcSoKjCLQ3wFjAqXV5o1XqJrP9s5LDYIjfKKTOyqLYg0
	iagtKOWhvPdsgPFlMTuZqSEaMmN/S7joW9kWsBsuRZjJMb/6itKrzvBte29/SgbicTdF1wPS6Rr
	oMa7DUvZ+CJ8Uty3ZrIOB9/qNOU=
X-Google-Smtp-Source: AGHT+IFHTVTdhnuWvsyarx1fk8vQKzVR+MOeqKMzewrWzFS/51onsH3Hi3ms5ltzeoDOgdEKLsoAzg==
X-Received: by 2002:a5d:6d83:0:b0:38d:e1ab:d785 with SMTP id ffacd0b85a97d-38de1abda3fmr3946799f8f.14.1739234458707;
        Mon, 10 Feb 2025 16:40:58 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:1255:949f:f81c:4f95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394dc1bed2sm3388435e9.0.2025.02.10.16.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 16:40:58 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 11 Feb 2025 01:39:57 +0100
Subject: [PATCH net-next v19 04/26] ovpn: keep carrier always on for MP
 interfaces
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-b4-ovpn-v19-4-86d5daf2a47a@openvpn.net>
References: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>
In-Reply-To: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1056; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=eJ3PNxxAZekah9naKbbW6jo7KQBN+FSwk2ZBYWG0nks=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnqpyMbarSd0v9dnPumrFpHvLneCBvSTs1uT2kB
 DGs/lLRmuyJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ6qcjAAKCRALcOU6oDjV
 h8suB/4zYo0OMt1oCwNOO/TVGCvLlJXAH9XlYWTV+H7t+iYAIBavrbN8Yj6XF2L4KvVtNrYdi3Y
 ky6Jsy4u2Zdk+gBSSYM4slnuhBSfK1nLiuhv1nZnZV+78X5vvUNdiRHoUr+nui1iUZtNdBDPmG2
 wcYAz83oHiy8+uBD4EwydXSahppBvX96615RqRt/V/UEKI0YShrbJtM1LjDrzIH1IC3pnypgE2R
 XM5KQ+/FjWxOqjGLvCR5OiTI++0k5obU0yBJ2I9AG/V1BUMRVLPY3j1+5Pau+ABpdDtwcNBnzGy
 KIqDvk7C+bga7PPtZDcgWqi7l6KVBuFpcHJU+q4gKT0JhRgn
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

An ovpn interface configured in MP mode will keep carrier always
on and let the user decide when to bring it administratively up and
down.

This way a MP node (i.e. a server) will keep its interface always
up and running, even when no peer is connected.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 14dad1732f31445d53cb2dbd5c592e8c3f11ef94..64f845ec13499a72a8586fe6af035aabd6884505 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -23,6 +23,15 @@
 
 static int ovpn_net_open(struct net_device *dev)
 {
+	struct ovpn_priv *ovpn = netdev_priv(dev);
+
+	/* carrier for P2P interfaces is switched on and off when
+	 * the peer is added or deleted.
+	 *
+	 * in case of P2MP interfaces we just keep the carrier always on
+	 */
+	if (ovpn->mode == OVPN_MODE_MP)
+		netif_carrier_on(dev);
 	netif_tx_start_all_queues(dev);
 	return 0;
 }

-- 
2.45.3


