Return-Path: <netdev+bounces-157281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DBFA09DC9
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 23:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3C5188D9FC
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 22:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B3E221DB0;
	Fri, 10 Jan 2025 22:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="cO/aUxqe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064A921A455
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 22:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736547980; cv=none; b=eygbx2CRBntMFrcEqkUTrJXDbP0uRrr4aok3A/53bLbbt+uBWxWZTp2e0bAFGEpxxkdQwoDGJv4se0rtnuTl/w9B97SPv4LeEQM4iPDXi1h4V4uAdq2bpqBom0hzRvd4Muha3PA6k+IBYEDLSzM8rb7b37asFWf6HKzooesJzjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736547980; c=relaxed/simple;
	bh=RY/Tuspo1DCFRvpCKqQYIvf8w9XDMBN0DkDSzZ4QpY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SfA6sqH0821eT7D1n82VHkdH0N3uPwEjNMBtRcxh7rMJoIQSqKtGUhb/CRgwANJ5Xgs5q6/u+kv5OalWLJgT0ts+Nn7h3gUKYzni6+5yWk+SV4g08dG0YSxFGYtI4Sleft6O0vJamtFKM/iVuHlwKfoMcUnV96elQYBuXmM5Kd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=cO/aUxqe; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-436a39e4891so18705675e9.1
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 14:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1736547976; x=1737152776; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V1Fm2KD7luUDhEb4Vs1/jF2TESvp7j4CV8OblpLPfSM=;
        b=cO/aUxqem2hIbGA61Qp5gxA8JowwaJPOb3YvUFpa9zezliu80VrcPZqXAWekieRFBi
         VlbojB/eGHETSo3OjDRfogX9ojlV++ajIV26bC43Ud5wAlFlNN+zxbNzNApWLot7unlu
         G85F82L//jz6N6WbomAq0JCajZ+1f+0CtTTPl/1GSvdqadxu58JfblLVbLOSECT6l0o9
         VXNmHuuhs9XR/9Zm0kXhkOjGqB7muv3/umOEhQ2NscnQXv6DQ47FcidO2K9Gqqu5JlP8
         sq1g+Agwc9QFTJy34E5ug6cNUeLZYU76A4nzrK7ZtBNZihlwJ84WZCKZ8GmVotp1KVoE
         XdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736547976; x=1737152776;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1Fm2KD7luUDhEb4Vs1/jF2TESvp7j4CV8OblpLPfSM=;
        b=XblmHNHsSdqsXN/dho9iDmJaGlgPtztZVpvmTmZF9sg12FcDtRPYlMqbEYS27/t8G4
         6kwOR3fxAx6l7gBVRY9tr4gZGmOiAsW3g7vkUDgCpapX+J1ch4papPVX8+WWoehHHf8P
         pZqSnIpncM1I/i7F5bt9UUnyUgC27zI7Gnfgi4opp+9lK/YG1KUox20BqLBCmhYIQ3OJ
         8L66YfhoTQQCYVhuDJ169cIKH87x1CYXR2kAnWoIqQZYgxoRW0qJuIXXhUJpKmf96U9j
         f232pt2zN4clj2WDuLcRfo7bYcvmHtQv07LSJa+YRKF2pBGiFlmRqv52E7zAgJPtVh/H
         njfA==
X-Gm-Message-State: AOJu0Ywng1PyKYy27ErHC6nLJZB9wtW91wc7Rsf9DYSO8QbQt4J+no4E
	b/PzPTaohZHTRsBQsJdsFkwGgW4Dc1+R6U9QbN0j+OENEtzJLR9AU2CcJUOihwU=
X-Gm-Gg: ASbGncsHRfQ5uVFMtWTRecAbcJPcei+9HrKIKl8aFFksQCtd8mxn7TwsdaDf0RyIH9b
	ZcTu8Ac+l3Us27FAOxDFrGPv1SxyzYFyaN/i4pS02FPUe7UJTjKcbwVnILqbDOdltAdclbk4O8V
	PqPlbbbUl93NiYqBtRWZaeEheOXs6qJhQg1suB5GJ8MhtsA5oRYIdsoIiLDQCJwT+ku//xsxJiu
	rOgCNaqH4XULy4SymM2mxis2KMlZaKTA8c1s7PHGbTJNHm+14vPXqio4pHsxSPJPZAX
X-Google-Smtp-Source: AGHT+IFqp7QlmWZvSRLx97iuKqFXUkxsINsV2JjbY95gJ0nehM7ErxL26OIazhGnOijHem6mFlcdgQ==
X-Received: by 2002:a05:6000:1448:b0:385:decf:52bc with SMTP id ffacd0b85a97d-38a872ea782mr10739639f8f.32.1736547976393;
        Fri, 10 Jan 2025 14:26:16 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:ef5f:9500:40ad:49a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d0fasm5704340f8f.19.2025.01.10.14.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 14:26:15 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 10 Jan 2025 23:26:20 +0100
Subject: [PATCH net-next v17 04/25] ovpn: keep carrier always on for MP
 interfaces
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-ovpn-v17-4-47b2377e5613@openvpn.net>
References: <20250110-b4-ovpn-v17-0-47b2377e5613@openvpn.net>
In-Reply-To: <20250110-b4-ovpn-v17-0-47b2377e5613@openvpn.net>
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
 h=from:subject:message-id; bh=RY/Tuspo1DCFRvpCKqQYIvf8w9XDMBN0DkDSzZ4QpY8=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBngZ6wyRwg9rOCLI29GHN/2SgW4Ab/ZZAc/ZAgG
 7i7BSaiv1mJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ4GesAAKCRALcOU6oDjV
 h0lUB/9mDi7MotucSnU4crV4fefJ5HyzdwXQ0dDeaz1/1qoYYi+91N/cTWrBB4iFe5Jf7TQkg/w
 l2n4doY/S1Ve7pU2TxCCttY5MI9t5YlH4cC+m7VHS7+yK60++BA7elEfVAUhbOGrN/IbVuUS1Z0
 9QMl/wP6PISb1YKAHbJGi0BQlHiJ/PpDDPC74yjyjnGct78rYOeBPQJUbKLQVXP/4dWSvP1tpKl
 mz/9T2j3GnrRhEh9oIkrm2QsWOJiJQraAizedXUKzj1CeYsDtiBWWFYQkAev7mp8EHqdWb/gNsS
 cSitYKT3yFrchB3tTgKxZ3pjZKyeRnwOZLM/t99e5JIrsPO7
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
index d3eebab7fa528cb648141021ab513c3ed687e698..97fcf284c06654a6581be592e45f77f0f78f566f 100644
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
2.45.2


