Return-Path: <netdev+bounces-237750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CE1C4FEC0
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 22:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FC323B63E7
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 21:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB6E352F95;
	Tue, 11 Nov 2025 21:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="N2S77Hpw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9DD326938
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 21:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897742; cv=none; b=ErRcuD9R0TzsJXu+nmKueiGaPtUVOEIQ943kw8a6awdIY6LzicERC4NYQe2dfV/EpISp/dnnP+93IItvtYYP5aqRGc2Boi5odMQ7sPC+3mOcoN9xBVrx5UZJBMLyC7SNqN5MjyoVypPJxE2jpfpe340FGh3uC0cfUn6e1C6seC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897742; c=relaxed/simple;
	bh=npWvAyntlsccAbSbes0TJ2SwcA+3RWx4tDLunupt/Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZwnkCMaIO+BwNE3Bzilqxye6A5CEDAspUap78SwFIGkPPU8I1R4UOp7VTY2tU5UCWP77N2i9OOeFYrgDkSXr8/NdYm2xh/7QhTbACpEOZakpWvJb1Uf0640aWg+dcS80VT8vS3uA+ekFx5eBmQ47MSVVKnoC4R2M4NPyYDaG4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=N2S77Hpw; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47778704516so988135e9.3
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 13:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1762897738; x=1763502538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcGpghFjR/KMpLr4sOd2BwB4bWNKBDSa1H+XD+Ch+ik=;
        b=N2S77Hpws9qnRMwFreg29RGgHMgPEP1Ry8KJ+Ikd9jWILpuN2ZjO94whqAqRH1gTgB
         gAT5LLHvonW6p7nH30j6bPkM1Geyz4ml76Ab0OZIs4Jlt2R3VyC2iXNJyKzbp8zqRWF4
         Z3fkWzf9BXjxCK9AQLSqp6yxPa+Wuvi/1mTB7UUcqLoGRxom/ToHgNKZqKBGGEcr9FrZ
         L2653Wn8hnVmmOpES8tqbADfZvhm/X4iH1t5Zdxr9x2ZdQafi6sD1qT8LFlm5EpOzxXK
         KP5IT7tA9wB79Nd4Fpwh0slWGz8WYCLO5+EIq9Y+tjAEoE39vxmJHSYFp7tFEv+Wxexu
         dNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762897738; x=1763502538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AcGpghFjR/KMpLr4sOd2BwB4bWNKBDSa1H+XD+Ch+ik=;
        b=iszswxCqKxjvPUrvzrPTul7xYWAmd7eNe+7NvuqatwsW3kBXrvMZZao/fW/W4k97zl
         BhNMp+54uVR/IHeXn6QReJLfk6mmYdbfYxOBpuha3LX56zlfAbdulYXoR36S5GBVLsU/
         ikZjV5xWgps7NLp4wUYO9HOFOIWn32RWFcJ8bHGD0AKead1IE8oQQhHTCcCySknz8XjG
         J3qwG3wAzJm0+DgpLU5kPbxqnOQbgZaNCtXwR5ERsSThfu8p9wBmMunVlbMVZv8PO9C1
         cnraKayi7S6Ntbwvtt3Gcqw1lenKOpEJeGXopp6EIjVBhBqxVLYWAHRy52htjXNMQyQw
         RBSA==
X-Gm-Message-State: AOJu0Yze/TZJmCJ4wmjzuIqjff6P22G6kC8Ndj4rMr7xJkarhCUaYiXI
	K0svWgksBnRL2F4oAH8aP2Up0OGsNpRYPVG8gfHiCCJDvqfk7DuzfcDf2vYZteI2dEMri7E3dz8
	1+cbQbTrkPQDzuDII0FcaX19LGjjhI+rkdJmmvzLrCNJmaOwSaWJ10zfhqSOh0Box7uY=
X-Gm-Gg: ASbGncsYBNTvFsCi6W7dmFgM6hHEw99BSaXertRVPTbHXt2/o93LReO9uwJfSRw2Ns+
	I8z44YFRYNllYRDE+DlwL5oPziS1p7iHtrklDgPiQMXBhZc0zkgbUnM6sjug/wNiUFdqXCc/gjP
	/OWyDaB4l4Ff+I5/+zii8VZfIjtoyfYmK54zpkmfEFDrQq4xt0j2ytiqH26JIpMR1y/LaALYg6e
	+VOrlack86Rn6iUrpPLgDfRaDS3myN7K0TkxIFZGr/iDzSn5PeH7+KXe/VB3M6o2V1MWGhVMcg2
	DNKyU3NYnrZxpYR9BlWHu5L0Du6WHKUVNLn+ZuHF0r0F+YCH7a+a5hm2ztg3R3mZKNJJ40G489r
	9hQM1png/1SzCnWI07X90EQnhSwrSTiTeFmObkZ7QUxfQDWnA8rmHuNbMkdBA54KbIfI9sHglVE
	ylA7YscaBsvqNtGQ==
X-Google-Smtp-Source: AGHT+IFMVs30K7915KuXX0x9lGXKAmZbhqpXJZJ4hs1Aym6gjE96541qJ3oQ6jErny6HrVg7QR1zjw==
X-Received: by 2002:a05:6000:2c05:b0:42b:41dc:1b5d with SMTP id ffacd0b85a97d-42b4bba63admr542315f8f.25.1762897738309;
        Tue, 11 Nov 2025 13:48:58 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:125b:1047:4c6f:63b0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b322d533dsm19478495f8f.0.2025.11.11.13.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 13:48:57 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ralf Lici <ralf@mandelbit.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 4/8] ovpn: Allow IPv6 link-local addresses through RPF check
Date: Tue, 11 Nov 2025 22:47:37 +0100
Message-ID: <20251111214744.12479-5-antonio@openvpn.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251111214744.12479-1-antonio@openvpn.net>
References: <20251111214744.12479-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

IPv6 link-local addresses are not globally routable and are therefore
absent in the unicast routing table. This causes legitimate packets with
link-local source addresses to fail standard RPF checks within ovpn.

Introduce an exception to explicitly allow such packets as link-local
addresses are essential for core IPv6 link-level operations like NDP,
which must function correctly within the virtual tunnel interface.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/peer.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 9ad50f1ac2c3..8fb6e43ecff7 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -882,6 +882,13 @@ bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 		rcu_read_unlock();
 		break;
 	case htons(ETH_P_IPV6):
+		/* Link-local addresses are not globally routable and thus
+		 * would always fail a standard RPF lookup. Allow them as
+		 * they are essential for IPv6 link operations (e.g. NDP)
+		 */
+		if (ipv6_addr_type(&ipv6_hdr(skb)->saddr) & IPV6_ADDR_LINKLOCAL)
+			return true;
+
 		addr6 = ovpn_nexthop_from_rt6(ovpn, ipv6_hdr(skb)->saddr);
 		rcu_read_lock();
 		match = (peer == ovpn_peer_get_by_vpn_addr6(ovpn, &addr6));
-- 
2.51.0


