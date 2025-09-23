Return-Path: <netdev+bounces-225618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 772DCB9614A
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 15:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81718485CA4
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173011FAC4B;
	Tue, 23 Sep 2025 13:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGWWmyv6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB0A223DDA
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 13:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758635311; cv=none; b=Kl73lqKd5EyMCMUdukZcWsBkTBHF8R9BhlI0ExctAXAYnSQscDyybLCSgtYRKVzbk0HT7F3aQSjKCH2F7B3Qe9f80hgq/f0xxpjBbX1gmZjWRrUPNtlwFP5+GfBxviOwdO9/cxMuag8qDi9IGjBED6NOBrNT00aehcjY+E8uzOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758635311; c=relaxed/simple;
	bh=q2MIJtVoCefK5sq3c6srNc+kN/liRllV4B4L1lKhfUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6aJoiVJq7DNA1eLyrFw8h2x/00lKtSZBPZSsFjg94yyaUE5kXPhrLJqDYo/iBvU747glhu0m6UEFEjFc4q6uLVqregu7+Mcy5igtHfe3dTxO2shVs4uMQxpgV1OK10KaHi5bs3RSVwmHZig5G96ESxqJ3PB3ygC6aQqtKOtct0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGWWmyv6; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so2770620f8f.0
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 06:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758635308; x=1759240108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=df2zEXaCR8g43M31lC8RGXgZ3e+fLBn1a/9LckMnU8s=;
        b=ZGWWmyv6bxHc+PlCtxkPogFqlCapyAuvaGdOT45Af0NPbwi1iRQWoP5iDBPDaoscy5
         ypkDko/ag0nuL9Ns/8V2poGRSbIumX5oAW7c5mcu0TFZO2590MbHkbdlOzr8UgocbgQb
         2HgvSmBhLf3hEc15HSbp8aqBoNfgQ/KuwLEm61ikw8+BwsM1hfQ9fv5amq2ljB6zS6ZX
         x9G6Jgi6tL1xV2Z82fsSmQnQjVLRwe0Na22YafzvLSSyGQOAuU5b8cc2abzeUQYQf7LQ
         bXQZ/y3gsRN2FlGplCtyxam4/xRj8ADxEKjLNAteQcUopZ2nAegOBbWhcfCnA0AgXHmD
         2r1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758635308; x=1759240108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=df2zEXaCR8g43M31lC8RGXgZ3e+fLBn1a/9LckMnU8s=;
        b=CnfScK74WCPwOug3HEH3teEWsFaRM/vm80N4inA6g5SBb9vVD7Si4jm0TyVDkUMfvK
         kk994QjEGSlFSS9L+i7s/zGnxXLZfdARPs6WcF6lNNQOLPz0YMfD0sWJmXfWcFh38zP5
         dtmfrpfaRMBTs1Sd7DOg1Bllabm0BLF2mzpSyGmycWNtXPGf/IVRACVG7+fvTJ0WpfSq
         A+4BrgPIszycrErIAQoC4/uqFLrv+8r0leIdBZ+NAjXhDGI24kiJSohyu/2ZWmwualnl
         HGvJ9iZz/w7T8oyEa8natZpSMeCy3FQTc9d588Ej4DdDFQUH0MLnePZg51cagtmW+66t
         TZWw==
X-Gm-Message-State: AOJu0YygiYeF1riFAq+LOm0jVZ5y6J2DXFAyjum+UOHrrAogC3VGQoUQ
	k2xVbb8YQPiHLtVuZugEyidb3PIjTou/rtpzujAiWd9jbbMPsxtorSZ5
X-Gm-Gg: ASbGncsEIPBD60+plrgHyiwmxVbpmkp2BUVCTaO3iGdd1MzFFDm+fN0M+6pDbynW8Du
	M3Rdk2MONai4pT4NcNBrKgWUDF2JttacJH/dNFG1tD9z4MWzx5PDosZXqUy3S82qEPJsayTKZ4/
	UssKq7x7lIzsCmqCWjnbhamZfT4gJ7nPo7kvfOWxc1WnTJvuu8Rtr3CAg3gwARnTE8Iw35Ceyi6
	+HCvB+UGi45i0kMlOw9qRHG//HuELDzXrSEeDUnhEZwkRoAvNOoGAmfuxuzkW4RQgPK8Dp6w4JK
	vIo6vW/wIVX5ED/i6udvacxOjlAFvsKprAcrItKkA+AvubAXQowUUqDEjC+G+GDyqEtHjoVPoMC
	A5HgTBnra9W9o2kcjpFqR7TxSmHtjDv8nON+VlZYdNdNLEgzNUpi7W4ufyBS1LAle2JNzEQ==
X-Google-Smtp-Source: AGHT+IEkrZMqaEvRdjYUuZIVzuwOBz4RpSTzGClFiTSmz1Md95cW/OtrZxm8uudtJmMAQf0KabAgmg==
X-Received: by 2002:a05:6000:40c8:b0:3ec:df2b:14ff with SMTP id ffacd0b85a97d-405caa5034fmr2179614f8f.40.1758635307509;
        Tue, 23 Sep 2025 06:48:27 -0700 (PDT)
Received: from localhost (tor.caspervk.net. [31.133.0.235])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46d7a566a27sm77364525e9.20.2025.09.23.06.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 06:48:27 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	tcpdump-workers@lists.tcpdump.org,
	Guy Harris <gharris@sonic.net>,
	Michael Richardson <mcr@sandelman.ca>,
	Denis Ovsienko <denis@ovsienko.info>,
	Xin Long <lucien.xin@gmail.com>,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH net-next 15/17] udp: Set length in UDP header to 0 for big GSO packets
Date: Tue, 23 Sep 2025 16:47:40 +0300
Message-ID: <20250923134742.1399800-16-maxtram95@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250923134742.1399800-1-maxtram95@gmail.com>
References: <20250923134742.1399800-1-maxtram95@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maxim Mikityanskiy <maxim@isovalent.com>

From: Maxim Mikityanskiy <maxim@isovalent.com>

skb->len may be bigger than 65535 in UDP-based tunnels that have BIG TCP
enabled. If GSO aggregates packets that large, set the length in the UDP
header to 0, so that tcpdump can print such packets properly (treating
them as RFC 2675 jumbograms). Later in the pipeline, __udp_gso_segment
will set uh->len to the size of individual packets.

Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
---
 net/ipv4/udp_tunnel_core.c | 2 +-
 net/ipv6/ip6_udp_tunnel.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
index 54386e06a813..98faddb7b4bf 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -184,7 +184,7 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb
 
 	uh->dest = dst_port;
 	uh->source = src_port;
-	uh->len = htons(skb->len);
+	uh->len = skb->len <= GRO_LEGACY_MAX_SIZE ? htons(skb->len) : 0;
 
 	memset(&(IPCB(skb)->opt), 0, sizeof(IPCB(skb)->opt));
 
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index 0ff547a4bff7..0fb85f490f8c 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -93,7 +93,7 @@ void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 	uh->dest = dst_port;
 	uh->source = src_port;
 
-	uh->len = htons(skb->len);
+	uh->len = skb->len <= GRO_LEGACY_MAX_SIZE ? htons(skb->len) : 0;
 
 	skb_dst_set(skb, dst);
 
-- 
2.50.1


