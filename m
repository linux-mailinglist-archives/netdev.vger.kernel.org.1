Return-Path: <netdev+bounces-135259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E13699D392
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A65A2845CE
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579921BE854;
	Mon, 14 Oct 2024 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="c9tESvC1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B0F1B4F2E
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920311; cv=none; b=HEMmda6vmZKpjK3XUta9RfjGcu3B2EImSJ2PVmmV4WtEKX23K2MC4ZMMv8k5jZHCUvKf6xwoKdoNxyf5CWxX6AUG5yZmaoG4tYIJEPCHgOV6yA6ABAcqA6HSzDK8zHRP0mdZ6lv+gMlWKYPlV39Vv8F6LJKuPSs8RwoP+qFzGU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920311; c=relaxed/simple;
	bh=GvHicGdC5gF55ThXSZt1O/NLZ5Cy+z1ts4hoVbPvBIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o7bWrchavbiDR8ZAkW6E21HQOsVfej5ipEdq/S/yhTRXG2RZ0HTY2iocjScj9TQIq+wtgU+y1nmS4fqFp/4fbsY7hZAK+E+BU0HGE3Fxdm5/7ofY3z51MLd2XQLbV6AuS/HSUJkS58gmLe9oG/h74vC91nORi+geCN2L6qSYyXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=c9tESvC1; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4311420b63fso33470315e9.2
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 08:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1728920307; x=1729525107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRe2C+foWbcov6G7P3m7UzBNc36wNTYgM3II8ClmqRs=;
        b=c9tESvC14rgTwhPvzYHqFoBqPQ1vxoiSX9RhESYC7q2TQJ1kln8f9U0YbQTpSsJVhI
         zPNsB/6rBD7N8OO9qL72i1c/7UWYUZHTY6XU+IY8qdRE9MSZY30TVt/kJalkzIH/PQRs
         zXZ0zjyT7+394U6mIBXd/gk20oBgk7lcL0P61DL9aOYqPXotBypDGiRp7/gJTBTRQwyB
         6QLU6HGBB98cyYowz8Tpl+ajRXZELGmFoCReTE02JwUcM5GqhHG6M8lJaI2SsV+TkbKa
         lWLM41dklrpcVMOwugPg7MuztTS2zJ/VHzeqHh1yP4CQmasICfMt+YnLRPKMA6Ob3PDF
         D8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728920307; x=1729525107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRe2C+foWbcov6G7P3m7UzBNc36wNTYgM3II8ClmqRs=;
        b=FTAL4ZlYQagu3nQLeBb0dzXRgyw2BbOBVSkEjKW/43650QsZcYdmyXTfkcgaFKbdaC
         7On/N+L9JMs7P97JQnWrBKDC7HF1UjhekAkz8D83Diw/xQR2HR8J4JTrJjrMKIoYX3gI
         gZuD/0YkzxVQcXFA5qY0ATQMdr4k6DytzhtFAxJxRq1EsJbrRnjvzDLgkdUdL1PHb5nx
         7mhteqK7nqRPnX33IDRQLNcuLuEMNf9cUbCgEVsV3w9cHpIEdr0fLY8vkuYP6RBOeCWS
         CfA4UbLaj6Tmq1dVw4G1nbMWVvjSbjA7rrrNGPiwsDXUzHBs2flmyzHM0DZtu4MqsQO7
         lKtw==
X-Forwarded-Encrypted: i=1; AJvYcCXJYhNlXFqOEosvyel149QFY2T0B/w5llCKjA2Xa/wm9WiqNHbaKUJC0uHERnzGQN2WhdCwZrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB7EDOduJEv/Qvol7KpE8Ch/CDKYxj14NicQwXxa6tRZGX4z5b
	vA8B0ftSYExI8nP2FHAm0Hk1oYuoJ+z7Ib87JY3d8Iaxrd4hnhhVwOE10ncJkLI=
X-Google-Smtp-Source: AGHT+IE4BazPIerb4dni+agrzlUjCsWIGS3LpWQM7q1t/kfeDsxhJlB9u9/bMMZmGbUUqKUZP+ZMNQ==
X-Received: by 2002:a05:600c:1c09:b0:429:e6bb:a436 with SMTP id 5b1f17b1804b1-431255dc867mr78702245e9.9.1728920307425;
        Mon, 14 Oct 2024 08:38:27 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:50cb:432::6b:93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8940sm11725913f8f.6.2024.10.14.08.38.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Oct 2024 08:38:26 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-wpan@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	kuniyu@amazon.com,
	alibuda@linux.alibaba.com,
	Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH net-next v3 3/9] Bluetooth: RFCOMM: avoid leaving dangling sk pointer in rfcomm_sock_alloc()
Date: Mon, 14 Oct 2024 16:38:02 +0100
Message-Id: <20241014153808.51894-4-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241014153808.51894-1-ignat@cloudflare.com>
References: <20241014153808.51894-1-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bt_sock_alloc() attaches allocated sk object to the provided sock object.
If rfcomm_dlc_alloc() fails, we release the sk object, but leave the
dangling pointer in the sock object, which may cause use-after-free.

Fix this by swapping calls to bt_sock_alloc() and rfcomm_dlc_alloc().

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 net/bluetooth/rfcomm/sock.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index f48250e3f2e1..355e1a1698f5 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -274,13 +274,13 @@ static struct sock *rfcomm_sock_alloc(struct net *net, struct socket *sock,
 	struct rfcomm_dlc *d;
 	struct sock *sk;
 
-	sk = bt_sock_alloc(net, sock, &rfcomm_proto, proto, prio, kern);
-	if (!sk)
+	d = rfcomm_dlc_alloc(prio);
+	if (!d)
 		return NULL;
 
-	d = rfcomm_dlc_alloc(prio);
-	if (!d) {
-		sk_free(sk);
+	sk = bt_sock_alloc(net, sock, &rfcomm_proto, proto, prio, kern);
+	if (!sk) {
+		rfcomm_dlc_free(d);
 		return NULL;
 	}
 
-- 
2.39.5


