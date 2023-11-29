Return-Path: <netdev+bounces-52199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F406D7FDDBF
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 17:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13881C20B94
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 16:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B793C6AB;
	Wed, 29 Nov 2023 16:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="j8pc+UZD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980FAC9
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 08:57:34 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40a4848c6e1so50512155e9.1
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 08:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701277053; x=1701881853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dH55LyAvyZzawnq9+CybIblcEgwIvM5k9Dss3KgMZik=;
        b=j8pc+UZDa62f/c+qFGBN5Mz3r305vAeUpt+nQs/rEajQI0OBe0Lj3D97baonnDOx+Z
         NS4Gc8kKoqJJN9MH39t9F9v3n0hPHyeVmWAYKytsaReDiBvBzyvKYXMWXjAgpqVABa4u
         QOYIxo6bdySjZJS/ZTzo/1G2QcyD3fsu29NKbgpUJiNgRogtzD4SNqeeGQfa/4MuiShV
         2rEGFviYteUyBPOgtsNoVxNQppAtgRSKDefibt7Cl9hv634x1GoopC7B+veQ+oqgmVFs
         XnAQc+8C2Z9TLeJfk+PaqGI0T4zW2Z04ZLOcjWVS65tJdK4r8LO6CT/rcs+y93x0jFF6
         y6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701277053; x=1701881853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dH55LyAvyZzawnq9+CybIblcEgwIvM5k9Dss3KgMZik=;
        b=cNZDOZnqBNJ3MHZPXoKN16U5YS0x1ZC0/Y0ITrYkNDGiqfVwic1is86RjZ4XLLtw3F
         ZQeaN3A7nugGBw7eKgtkpYEEypEkpZmA6VDA2CqbLvtAQy+XZptqrUyBKuIJQageSTBq
         BlI7QGVif8F4BH+ovICEHD1yw5opMRncAPU3/dUBGEfA6eq/m7rkLi/kZMLG3afZwdv+
         GYL+1sGD9giVG8vobmzBmtHrTCAxtZuUH7fXiDV2ThWaLMT5vJCVFUI9HEKRp7Ge2sag
         oFShVsdr7Q7qMkvEPeTRhiJ+1m+9tHx9UzCcYkLfJp29Ull7ISdkmr96lLywsjYDNkQY
         e57w==
X-Gm-Message-State: AOJu0YyOcBQBy2/EL8P2Wec5zFlhMi253f4d46G5hGLQb6a2hK+WocJg
	VsPSQYuODitULd0q4AV2vKj9kA==
X-Google-Smtp-Source: AGHT+IE0qW6+CGImPLkSMdoP6jUwi6RitG/CiFlOiEI5qiKsdgyQfjlYJD5XpTFWDPXVSoi7ktogYQ==
X-Received: by 2002:a05:600c:548f:b0:40b:4a7f:c9ca with SMTP id iv15-20020a05600c548f00b0040b4a7fc9camr4714881wmb.34.1701277053177;
        Wed, 29 Nov 2023 08:57:33 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s20-20020a05600c45d400b003fe1fe56202sm2876823wmo.33.2023.11.29.08.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 08:57:32 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org,
	Dmitry Safonov <dima@arista.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Francesco Ruggeri <fruggeri05@gmail.com>,
	Salam Noureddine <noureddine@arista.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v4 3/7] net/tcp: Limit TCP_AO_REPAIR to non-listen sockets
Date: Wed, 29 Nov 2023 16:57:17 +0000
Message-ID: <20231129165721.337302-4-dima@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231129165721.337302-1-dima@arista.com>
References: <20231129165721.337302-1-dima@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Listen socket is not an established TCP connection, so
setsockopt(TCP_AO_REPAIR) doesn't have any impact.

Restrict this uAPI for listen sockets.

Fixes: faadfaba5e01 ("net/tcp: Add TCP_AO_REPAIR")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 net/ipv4/tcp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 53bcc17c91e4..b1fe4eb01829 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3594,6 +3594,10 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case TCP_AO_REPAIR:
+		if (!tcp_can_repair_sock(sk)) {
+			err = -EPERM;
+			break;
+		}
 		err = tcp_ao_set_repair(sk, optval, optlen);
 		break;
 #ifdef CONFIG_TCP_AO
@@ -4293,6 +4297,8 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 	}
 #endif
 	case TCP_AO_REPAIR:
+		if (!tcp_can_repair_sock(sk))
+			return -EPERM;
 		return tcp_ao_get_repair(sk, optval, optlen);
 	case TCP_AO_GET_KEYS:
 	case TCP_AO_INFO: {
-- 
2.43.0


