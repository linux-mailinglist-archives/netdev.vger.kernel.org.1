Return-Path: <netdev+bounces-50675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A0E7F69CB
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 01:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51BEF2816DD
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 00:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FF8375;
	Fri, 24 Nov 2023 00:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="KyTb8XJF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FAE10DD
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 16:27:34 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32fdc5be26dso789293f8f.2
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 16:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700785653; x=1701390453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dH55LyAvyZzawnq9+CybIblcEgwIvM5k9Dss3KgMZik=;
        b=KyTb8XJFTur8dPrC3de1g8Vk/S8ze/Uv/lZ9Ot5vHOscxuoGloR0ffhdznpFeJteLy
         xMQ56X+X3N8xIhQxt/JaW4WVq73I22bhI0CUC/3ZfPKZ+6VxQO8qVS4K/SXTLKM8eHsQ
         jrpBsB/0nsoJujnM2XDhnZ3euMZ0RfT2n/nuxm0r7gH2aXNJuBy7bKJ55JJFyP8dvG4p
         d6A0U7KtoOCTjSLJ/nHbILwtCBXzaBTmAC9CyeBN8yWhJ6A4L0CR1u/npMkvGyH+gaYj
         b98Vfx+3vZ2kP+1VaxlciXo1sDZC71eZbIIdNTq/i0Bi4E6wI1qsNjwOze7EWSerJWkD
         SEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700785653; x=1701390453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dH55LyAvyZzawnq9+CybIblcEgwIvM5k9Dss3KgMZik=;
        b=hJ/jwQB6IZ752cIfk6nrbDXy48bFNW97nYCYsHhkqixSLspqpOs6NZ7r3r+32yUwKE
         P8jNGgg2umFZ4/XSbTNEascVVetR0Y2SN8DH2iSybuXiwOwS3FLbp9p5Bo1COz6N7BiD
         RXw1k9mWJUnb5scW5aw9cjwGZee/OXvgZgqDg4qLTV0PavjrroRbvEq6PlBaBByecfy3
         1enxxbcnOuAuY5xM90n5lopxf1RFAN966GnPSX84Ry7qjl3Y8bed/mSPlFlD0ak9Rpfv
         6X5tB/IgREsTJiiynL+th2rMkLlYDoWMa2wLLb8Hsgws5B5Gh2vpQxwlBP/YgeEw+hwN
         CXVQ==
X-Gm-Message-State: AOJu0Yz/6EfCFkGi3ovdXQxUeX18UMx560HVTtZvbi3GavqWBC3uCIbP
	yxFfGFHWgp/l9qnpujbOlSwHbQ==
X-Google-Smtp-Source: AGHT+IFT357fLdv+9VPLUo9JyrvYwmlakZqhgzZ1DUTRUDGIr00buQXKS16JWd7Hv3B31+VpUgT0Qg==
X-Received: by 2002:adf:e6c9:0:b0:32f:e1a2:526a with SMTP id y9-20020adfe6c9000000b0032fe1a2526amr649526wrm.67.1700785653098;
        Thu, 23 Nov 2023 16:27:33 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c310900b004094e565e71sm3453230wmo.23.2023.11.23.16.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 16:27:32 -0800 (PST)
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
Subject: [PATCH v2 3/7] net/tcp: Limit TCP_AO_REPAIR to non-listen sockets
Date: Fri, 24 Nov 2023 00:27:16 +0000
Message-ID: <20231124002720.102537-4-dima@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124002720.102537-1-dima@arista.com>
References: <20231124002720.102537-1-dima@arista.com>
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


