Return-Path: <netdev+bounces-198683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F70ADD082
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7454044CF
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD9E20C02E;
	Tue, 17 Jun 2025 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiLAOmva"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576652EBDCE
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171382; cv=none; b=ngua1pIDFjRGGpfdWq66stEE5Zu1MqjX9x6ys5fz9i2pC0j5SVJ5MsTzOjntJBJn8haFWYEFtIltqiCv+22zn9tq2Uopn6nuj5qO2C1BDTOOv/o75BJjxOOLaNS4ffasM7/85tk/LfVjII+D3Am9A6lKdUiXJnnjqsllQ/s6ufY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171382; c=relaxed/simple;
	bh=uUbkltQ2+iyHvWQkFZ0cdjHESKYWwh2LzzGmrknsW3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qrBXW3QAWuq4NZWu/6HR1ce+/qOUMob9IQN1V6popPSWr4iLPka/SpnuLi8Ux+AYQVPlGeJia337qHtSo+YBABOiAc0tIz7ddWZj0LfEA0qg4dFJ1MeagCCU/mj/UOa1eFbnSv5DjVvXqFnVu8OxRwSCyF1XzgwO1kdDaMr/5rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiLAOmva; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60867565fb5so10361011a12.3
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 07:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750171379; x=1750776179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFxiasKZZDwBIbQexCzTilPAkMuibognV4IasZCnsfA=;
        b=kiLAOmvabv6YFdmGlW0wjKZU2l3GxgQDsaw1sw+08m2qEdYkgyll9iTomcOTQNJG/7
         WHg+p9l6vV9odWSZ0L+2rOtYSJsC4XcqgSaJv3gYUO6ENzAf7uNrDHQJ4hCTg5rXPSrv
         7qTvFid0E89Eby2bwL6FoxkVObmIbKth6LJDrAI7YYACeHsqz59SGJc+TUBbRElquN1v
         /3SZoopPqzZIiUYY1u+OlWzoEU89lb9KWPm5e56RY0redhuwZvbLWu1+s4W8pifofZ0k
         mRYuT8aKQlb2EVDbjmdFlHb1281Hb6Hfar3gETYzxoeg2tjfIASArdw6KXdMVaI70G/2
         eJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750171379; x=1750776179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFxiasKZZDwBIbQexCzTilPAkMuibognV4IasZCnsfA=;
        b=E7ZJeD32d7CaeNww6XvIOugcclHIjpXn63oNSvZeIDt0tQlvuiAGFKtbt0Vn20Zj1G
         WB4E+TVNgFL9l5PFNolAUeoe/1/J5HUSXqahuoAQFamar7Vfei3XBljbnLtrlr8eAPAZ
         XzYmAIHqYjTtjOr8Ergxcyu+1lY7g8JtcmU4upJGIPQInjGXVcgDCudtG5t6bUxZzmlJ
         D+M5UCpTK1QLqPEGC6lwBoG88iow3EZ9lLnzY7lzhF0mvKzC2IvNkpZfRzo6mCS0q++I
         YE1fNUx1TCNzPlTU8fly5YaG+xlVtQYHK9LoUakKFYyHrvPFfCIcVcmXeJEZpUh3JAjk
         uznA==
X-Gm-Message-State: AOJu0Yyxc6ER68UodWJk6qU3DPAKkqcKEaIOuuF2IVatsnr9VknApCpm
	R/iqc7u8YJ8OmvZQeb25IBziec0WWYvcjFeGrnVkOW+csn8TgYkPV7eZ
X-Gm-Gg: ASbGncufrHTUPKXM7TKR0LC01914rwj/6Y1XUQx4q/CsAc2jBRld3OIAaQHM5qAuv6Z
	zJUAfBTmaQEpRG2ZdOBXyW5FKR4+/8jgTX6lLqmNmS2Uk9LD5xfgROLGIrgLm/1VsNSgD4r6d36
	W740ckHY+7alFmxb0Xu4NNRJx7jfqJnVyR8Z6AyrgMYW85nbmC7c20wN+XkBu1yhkp6n/gmCA5r
	/dtMHl/5D+37D7DalLtI0krQQ1CCpbX3pTBqt+nfflh3NPvQxhPjyVYj4Rfa/U2bjSTJqCv/iAB
	fSOFQ92zL0O0A5H8sbLx+Fe3Z5qer1/05J6Z/8MqpeMVr/3jedM4JXc6Ny8DkE0aAqg0Wlb8SYX
	yV3oWhDtQSW4c
X-Google-Smtp-Source: AGHT+IFSUxZ0ZV+sx36vHs8ocsa8+tXqdhzXL9Qf1VRyOu3rJOuZsCl+7F+OVHaL5dKk1eb0CublNQ==
X-Received: by 2002:a17:907:fd18:b0:add:fa4e:8a7e with SMTP id a640c23a62f3a-adfad4104cemr1190107666b.32.1750171378452;
        Tue, 17 Jun 2025 07:42:58 -0700 (PDT)
Received: from localhost (tor-exit-56.for-privacy.net. [185.220.101.56])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-adec820da06sm879990666b.70.2025.06.17.07.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:42:58 -0700 (PDT)
From: Maxim Mikityanskiy <maxtram95@gmail.com>
X-Google-Original-From: Maxim Mikityanskiy <maxim@isovalent.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org,
	Maxim Mikityanskiy <maxim@isovalent.com>
Subject: [PATCH RFC net-next 15/17] udp: Set length in UDP header to 0 for big GSO packets
Date: Tue, 17 Jun 2025 16:40:14 +0200
Message-ID: <20250617144017.82931-16-maxim@isovalent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617144017.82931-1-maxim@isovalent.com>
References: <20250617144017.82931-1-maxim@isovalent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 2326548997d3..5c76a4aaab7d 100644
--- a/net/ipv4/udp_tunnel_core.c
+++ b/net/ipv4/udp_tunnel_core.c
@@ -179,7 +179,7 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb
 
 	uh->dest = dst_port;
 	uh->source = src_port;
-	uh->len = htons(skb->len);
+	uh->len = skb->len <= GRO_LEGACY_MAX_SIZE ? htons(skb->len) : 0;
 
 	memset(&(IPCB(skb)->opt), 0, sizeof(IPCB(skb)->opt));
 
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index c99053189ea8..e318c89663cb 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -92,7 +92,7 @@ int udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 	uh->dest = dst_port;
 	uh->source = src_port;
 
-	uh->len = htons(skb->len);
+	uh->len = skb->len <= GRO_LEGACY_MAX_SIZE ? htons(skb->len) : 0;
 
 	skb_dst_set(skb, dst);
 
-- 
2.49.0


