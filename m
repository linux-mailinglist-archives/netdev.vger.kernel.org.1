Return-Path: <netdev+bounces-53600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D51803DF5
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 20:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E494AB209FC
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 19:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB4E315A8;
	Mon,  4 Dec 2023 19:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="AAGtKnHI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75325D7
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 11:01:00 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2ca02def690so17821001fa.3
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 11:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701716459; x=1702321259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUFbq/Bpf84kUYD5hi1tJcGjiTvsxTjhBSB3X6vJDoM=;
        b=AAGtKnHIFh72wPQbOIY29uXyHJKgf4BQhzDqtqRbdd5+LznKICxfH953R4lWksMKnc
         cWhIbGFjW9dmTGePThvhjeL5kbnsLWn/sOLXHa3TUuaU8IrzDqI7bz4DJ59mLub5zQFC
         YnTs1iMZEOCfVqMfE13kaPd4P1Rv29reYtJuFBZQDVvXhSN27oe5yl1QKiB3TH5zDO1d
         SXCuXMjaZV+vTYn99tq4PZZBNkYmp8q94eB+G5ZG6yao7XX3pu+cZz7tbZj+QvalKupu
         21/VVd4Z/LAMdQZvEUTBkdQQWXQjrjzA76SdNQJ4kmVke6Sf/+k82//IPUugveLku76Y
         968g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701716459; x=1702321259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUFbq/Bpf84kUYD5hi1tJcGjiTvsxTjhBSB3X6vJDoM=;
        b=qRu7TO8+bcll8qybaRsLr0cAUYe+wN8Xea28LSrVJoXATmHUSI+4SblYoIfjZRUX+g
         vvmyTHPPNwvP/mlouKaBG2dk6W3ubx1ODxr9rOmaJyzdLMo5OOiJlI80+OtUQ+41+yWF
         9EkAb7d6KEDVMXaR0Vw1IyU2jMh336Rg2LiNVYRxcr7ulchtqT2PA/o+XMOCOD/28qwr
         IQ24++Dtr/seHbgMX5nUJDqrE3s6Ar/RppnVlLsSf653DEfKVsIYnNPB4wriQQ4Kckm2
         6KevgFhPvGDKAKSQIEjTw4F8g9PMdjnihn5ta3FIY8tI0VcDGPBoXlt7tBkMSW1glErt
         SpRA==
X-Gm-Message-State: AOJu0Yy8D+90pIbgpUY1+BirNsmWyir2McQqupDw2us6H7ITVbSKjIU4
	OSK3+w+SvRcnR3JT+vADZaI5Pw==
X-Google-Smtp-Source: AGHT+IHYuOp6qqMq4tE1HhzSjBMzbnrKfodkZP1F+YHS+F6QHGdAXtt1lesJrgvunHJzsUHFUkmhAw==
X-Received: by 2002:a2e:b348:0:b0:2c9:f727:7e65 with SMTP id q8-20020a2eb348000000b002c9f7277e65mr1332068lja.38.1701716458691;
        Mon, 04 Dec 2023 11:00:58 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id dx9-20020a170906a84900b009fbc655335dsm5577614ejb.27.2023.12.04.11.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 11:00:57 -0800 (PST)
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
Subject: [PATCH v5 3/5] net/tcp: Limit TCP_AO_REPAIR to non-listen sockets
Date: Mon,  4 Dec 2023 19:00:42 +0000
Message-ID: <20231204190044.450107-4-dima@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231204190044.450107-1-dima@arista.com>
References: <20231204190044.450107-1-dima@arista.com>
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
Reviewed-by: Eric Dumazet <edumazet@google.com>
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


