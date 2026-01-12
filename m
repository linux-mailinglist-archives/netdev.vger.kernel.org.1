Return-Path: <netdev+bounces-249167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 661B4D1551F
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A13A30161F1
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 20:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09781326D65;
	Mon, 12 Jan 2026 20:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f73qCkgy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F35232B9A8
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 20:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768251060; cv=none; b=tNCCLe0dCcfilif2FJUk1v4LRmtrBPhd9kx/bC54BESN7zaZVLlumAe0gaYhzpdlVJrsO2DZghWcBNHfT1g3Kx8ry9faUca2x9tGwpT2ezIcKN+FQGr6GHqTQlhbpyTsxqLxEn96C7cBj4p9dmhQdmS8LiJGfM4rSwUTP+dZx7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768251060; c=relaxed/simple;
	bh=h1bLSgxdpgtRqlq58JBrWlmqVe83xJlLsJqBd7U3h1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdwPm2HLbhklg64uHfbJw+V3p3KmGndTBFiLvx1/pOJZMF36uKFtUn157+ujctIoigLWhQQq7UpBvsWcGEsEc4aGK2nCSxhDwvfWWvd4DwJFpYEziRF9332hyxsnm49vgIl8f/UemSY4P9sSbaotLqMPYqAEPUWB0Q8Ue/+PEWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f73qCkgy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768251056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D/s0GXuNL9g9mdojAkGCXJ2uGGA6zHDkPRCRiaiyppY=;
	b=f73qCkgy7qV/lfj86hY09i/nX+WS/z+sMpHs8c+Z3xICSy0o9LwSVpV9loa/W6XbaguyHJ
	JkB8EHLVbztRJDCw3/BbORCi+7M36eBa+xV/OdlPfYHntIMDE+SH4pKAEy/CS0KTJkWbSA
	RlifqL/n5iTzlwLDNtg43+lj8b1fuMU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-c_aMErYqOtGT_EE8lI6jZw-1; Mon,
 12 Jan 2026 15:50:52 -0500
X-MC-Unique: c_aMErYqOtGT_EE8lI6jZw-1
X-Mimecast-MFC-AGG-ID: c_aMErYqOtGT_EE8lI6jZw_1768251051
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2EE2E1956089;
	Mon, 12 Jan 2026 20:50:51 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.212])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5609818001D5;
	Mon, 12 Jan 2026 20:50:48 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH v2 net-next 01/10] net: introduce mangleid_features
Date: Mon, 12 Jan 2026 21:50:17 +0100
Message-ID: <b897195a1f2cfb788ea6982b5c6badeba75d9116.1768250796.git.pabeni@redhat.com>
In-Reply-To: <cover.1768250796.git.pabeni@redhat.com>
References: <cover.1768250796.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Some/most devices implementing gso_partial need to disable the GSO partial
features when the IP ID can't be mangled; to that extend each of them
implements something alike the following:

	if (skb->encapsulation && !(features & NETIF_F_TSO_MANGLEID))
		features &= ~NETIF_F_TSO;

in the ndo_features_check() op, which leads to a bit of duplicate code.

Later patch in the series will implement GSO partial support for virtual
device, and the current status quo will require more duplicate code and
a new indirect call in the TX path for such devices.

Introduce the mangleid_features mask, allowing the core to disable NIC
features based on/requiring MANGLEID, without any further intervention
from the driver.

The same functionality could be alternatively implemented adding a single
boolean flag to the struct net_device, but would require an additional
checks in ndo_features_check().

Also note that the above mentioned action is incorrect if the NIC
additionally implements NETIF_F_GSO_UDP_L4, mangleid_features
transparently handle even such a case.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/linux/netdevice.h | 5 ++++-
 net/core/dev.c            | 4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d99b0fbc1942..23a698b70de1 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1830,7 +1830,9 @@ enum netdev_reg_state {
  *				and drivers will need to set them appropriately.
  *
  *	@mpls_features:	Mask of features inheritable by MPLS
- *	@gso_partial_features: value(s) from NETIF_F_GSO\*
+ *	@gso_partial_features: value(s) from NETIF_F_GSO
+ *	@mangleid_features:	Mask of features requiring MANGLEID, will be
+ *				disabled together with the latter.
  *
  *	@ifindex:	interface index
  *	@group:		The group the device belongs to
@@ -2219,6 +2221,7 @@ struct net_device {
 	netdev_features_t	vlan_features;
 	netdev_features_t	hw_enc_features;
 	netdev_features_t	mpls_features;
+	netdev_features_t	mangleid_features;
 
 	unsigned int		min_mtu;
 	unsigned int		max_mtu;
diff --git a/net/core/dev.c b/net/core/dev.c
index c711da335510..6154f306ed76 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3788,8 +3788,10 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 		struct iphdr *iph = skb->encapsulation ?
 				    inner_ip_hdr(skb) : ip_hdr(skb);
 
-		if (!(iph->frag_off & htons(IP_DF)))
+		if (!(iph->frag_off & htons(IP_DF))) {
 			features &= ~NETIF_F_TSO_MANGLEID;
+			features &= ~dev->mangleid_features;
+		}
 	}
 
 	/* NETIF_F_IPV6_CSUM does not support IPv6 extension headers,
-- 
2.52.0


