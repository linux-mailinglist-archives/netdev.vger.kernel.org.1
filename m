Return-Path: <netdev+bounces-207454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDC3B07526
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 13:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 325A37B120A
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 11:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287C72F4A14;
	Wed, 16 Jul 2025 11:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="YfeRpAjo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D682376F7
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 11:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752666907; cv=none; b=SENpM8kzRCtpsFBEkEfEo0V25O3mm12IgASw40R8f3/Pvcg6ONFgp7KBAKejMZGb9Dehl2jaqNOAzdD8nL9F7IjZPSRDo2QydIKMaaXJ9Zjb/NbEcCWqPMzEpr9DiAFOSipdSNjXVjbKbBVYeB1OCMqeL/SU+MDE2BZTwe19RWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752666907; c=relaxed/simple;
	bh=PHfqff40ak0nzjYDD0920xW5g6v53AeyEK5zqYbSZWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6qbe6dXsqBylrpCuhGdnefZD97phdkXutfaI+c9Z14eYIMH2J6bhbib9EfGqS5TR0dxv+VFOIZvUPONt4p8dZ2/HhJ8W+H+ty6VQzq/mMad3/5idr+46F4WAuooJNjwjMQ2RjB26ingb4+rukYdBFZo7pjL/N4VUppzJu+WYgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=YfeRpAjo; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae3c5f666bfso1143645066b.3
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 04:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1752666903; x=1753271703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEUkUqdHmtpvfRO+CHi6jqs94674FUmFpzG0/8wdHBY=;
        b=YfeRpAjo4NZyuI0IT4r5PMHtJ4T+pD1jD6RE59ZwfmDRPwdfLm4/HzVg63zlbTEk47
         4NWrTmDWz9VyzOlXgxa7pNjO5pUXdomSMNBEEzOQhauRgzrseJRKPJsTUK7nyN44yYdU
         BJ3joo5T0opOzXMp/SY3X3EnjrLLu1pDCgX8i03aBl9xVvGS0dnZZ79CmlbkgurxroVY
         XYRpc3wePZ5EZEY4EZzw0YEJeqBFKcSnTg1hrAZbCmHIsMm6pVjkzBcmFbMuvDB6J+ZA
         wMVORmW1pxOKfMGb1P+vFsM9SN+tDltjBAJPIeqMH7X0shzndZMf4AA/Z0inC6sFKI76
         nNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752666903; x=1753271703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TEUkUqdHmtpvfRO+CHi6jqs94674FUmFpzG0/8wdHBY=;
        b=ZJ8YdWCA25y8mTfklZ4xxuI/Tu0J+SROfg/MFisMRcIdJvXr4I9ALOyTxxdcaVS2aq
         XOsrVOMwzPVU9Q+1GQO6y3vkfAGqmve1b3TMreq/KJBm4Yk+w1RCRnZ8F3O4BPkpLrW3
         N7c2h45c4fglpBeEiG6vzJP8IxW3jrcnf0tHQv/574sWQBr6cHBRn2KjCezvE6k1ebMB
         QrGg4slgRcFZGjMsl2tSZutuTdI9lZv/4eZ+LVVRYU3MR6QV9t7DJq4z1/Hckr6LLvGX
         52kfVR9aUd3++fu/tf4vB7dZ2vtvKBRHy2PRMfH1ddrmf04cdEjGdsb8Mm+gBlDAQ104
         J1pg==
X-Gm-Message-State: AOJu0Yw1LJhhyFY0GYwJMGQdXkGkgT4sgQ+f+gCWbJdZ4RQ7ozQl7Ks7
	f91NjXZVKO+zcwT1/hzQ17NB3kOvIZbO/87m8bafpRqTJ5wpjnHulwLzxJ/SJhIqdNgR6i312V+
	BtDwkejpZ9YEV9jPjQJikrfDJgGCE0KNfTdaql4Sh1PwlMDIIOsPFd2S+z5X3c1SR
X-Gm-Gg: ASbGncscrDgOrSO0nhvoFx7Hx/vUf8TegkivcqZVy9rgNsU1gEW4zApx+3h2uG4JYbx
	LIRmKVKnZRCjjDF5kOZ0VB+NQctmbs33dfHwh97vzoU+l5u9hQFkduKiWs1DzRkCoYVX6RcYJXS
	wX42mDHM37sDZR5iETK5uxvDjgfeSos/S6UtitazdbeOwKxDcUkXwrv4wrByhcVOYSB712eniWm
	LjWMLaHML78flD9MwqE+X0jTnCd0xSwf42F9W6aZb4dJx3G++xOlRQjF2fCVdyN0ZmEsYOrf/Op
	Y0zaGN9m8GT5OPJGZHaKqCjMGh4nycbvv9/e6srrkOWNeLjb4Lfq7/9vF5yCwMXLRpHAeYZ2/1c
	hztUL52RTsMa0COXd7FZMBdXRYg31A4p5Q3xZf1JGr6Ec5Q==
X-Google-Smtp-Source: AGHT+IEFH9T6EfRdlOQfHMc6t3tcujw/RzjKR5kCk0FzCBggX4yjtuoQOOFQChNcJAfNr4hpWHOI5Q==
X-Received: by 2002:a17:906:8304:b0:ae0:16c5:d429 with SMTP id a640c23a62f3a-ae9c9b9d21fmr232892666b.58.1752666902836;
        Wed, 16 Jul 2025 04:55:02 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:96ff:526e:2192:5194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8264636sm1169169666b.86.2025.07.16.04.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 04:55:02 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 1/3] ovpn: propagate socket mark to skb in UDP
Date: Wed, 16 Jul 2025 13:54:41 +0200
Message-ID: <20250716115443.16763-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250716115443.16763-1-antonio@openvpn.net>
References: <20250716115443.16763-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ralf Lici <ralf@mandelbit.com>

OpenVPN allows users to configure a FW mark on sockets used to
communicate with other peers. The mark is set by means of the
`SO_MARK` Linux socket option.

However, in the ovpn UDP code path, the socket's `sk_mark` value is
currently ignored and it is not propagated to outgoing `skbs`.

This commit ensures proper inheritance of the field by setting
`skb->mark` to `sk->sk_mark` before handing the `skb` to the network
stack for transmission.

Fixes: 08857b5ec5d9 ("ovpn: implement basic TX path (UDP)")
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Link: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31877.html
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/udp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
index bff00946eae2..60435a21f29c 100644
--- a/drivers/net/ovpn/udp.c
+++ b/drivers/net/ovpn/udp.c
@@ -344,6 +344,7 @@ void ovpn_udp_send_skb(struct ovpn_peer *peer, struct sock *sk,
 	int ret;
 
 	skb->dev = peer->ovpn->dev;
+	skb->mark = READ_ONCE(sk->sk_mark);
 	/* no checksum performed at this layer */
 	skb->ip_summed = CHECKSUM_NONE;
 
-- 
2.49.1


