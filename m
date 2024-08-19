Return-Path: <netdev+bounces-119768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF3B956E32
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 17:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EC921C21D5B
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 15:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5468117556B;
	Mon, 19 Aug 2024 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="rFkyHwUr"
X-Original-To: netdev@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919601741D9;
	Mon, 19 Aug 2024 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724080017; cv=none; b=Tq2aSZlSEjNvhIgXbZURrqHy69JJdJUYP+ML1UyNdvEdYSTaX2ElVJDuZ8a7dkl5W6OCXMZrRWtcGOtAnqM+HXZQ+rguNWgAcOOsRO/qTb7BoPAPa5g044AY17CReJEKO2kp8BxjNAk9z0hdGcDrKI0B6LrQaJVlXb07sft22sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724080017; c=relaxed/simple;
	bh=vns+adXAJLw8T/OM3pAthnwRhUMiPNaH/Eq3YdBkm+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xhi1v9+a8/wgNKNBMsDxDtPi11mDa2Wd5Z8avemcO9DitQnJPVWRaKxocoHkXyU5vpx4yvPq5dwjy2QWGbVRBgJNOOSnJN11tPIA0pldc8FxY/ToQQZFjynnbtTbyB8IYv4coPl2Su0cOY3IS6Jv+3KtAYe1CQIiLmFtaS6Wmt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=rFkyHwUr; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+nhzfS7nwlcduWA3b9lUiJN3hfhtWWmUh6PUuFzlJqw=; b=rFkyHwUrcD6xAjGPxd8Nzg9GlX
	pmrtQ43Q66j2SONDJOffD7xHxDvMEVZImyiTzD/yQv8hisyBj3+I+jq0M0tmNLoReIbtJ0eHHg8GI
	SDjIJjGxVtS4CQu029pvq7HyH3gv7VX4cau5pHnAeMVadHTjMOrpJxS4folDnUN185NM=;
Received: from p5b2060c8.dip0.t-ipconnect.de ([91.32.96.200] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sg3xq-001WcL-33;
	Mon, 19 Aug 2024 17:06:35 +0200
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net] udp: fix receiving fraglist GSO packets
Date: Mon, 19 Aug 2024 17:06:21 +0200
Message-ID: <20240819150621.59833-1-nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When assembling fraglist GSO packets, udp4_gro_complete does not set
skb->csum_start, which makes the extra validation in __udp_gso_segment fail.

Fixes: 89add40066f9 ("net: drop bad gso csum_start and offset in virtio_net_hdr")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/ipv4/udp_offload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index b254a5dadfcf..d842303587af 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -279,7 +279,8 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 		return ERR_PTR(-EINVAL);
 
 	if (unlikely(skb_checksum_start(gso_skb) !=
-		     skb_transport_header(gso_skb)))
+		     skb_transport_header(gso_skb) &&
+		     !(skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST)))
 		return ERR_PTR(-EINVAL);
 
 	/* We don't know if egress device can segment and checksum the packet
-- 
2.46.0


