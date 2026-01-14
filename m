Return-Path: <netdev+bounces-249898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7862FD20829
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 18:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EB11A30019F9
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 17:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686FA2E1730;
	Wed, 14 Jan 2026 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="an81nY6+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAC02857CF
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 17:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411282; cv=none; b=IhCyq0yhgZsOl+fOiTIERXcFkNjkY98tHIqcm1hfBC3fA8HKrtRR8/RJumGs8zw7BdVSGGmcGXxYvKO2qWkCnRlf5E0ULBS4BgECMgHLZlXlfpDAprcDs/8Ya7TviiJBUFKAnT4WyeGEuGdo4IRDldHQpnHk2kYL/AnR6A/nc20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411282; c=relaxed/simple;
	bh=h1bLSgxdpgtRqlq58JBrWlmqVe83xJlLsJqBd7U3h1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jd9OgGtU3coFLg8Q1YXHsF+xzzmQtOHtzbjlhAYZ/paQi3dU1wb4RAx3WHAQqJ0kh7LoXqN0Uxz+nGYJuM4qqAM/aPcC/XMKmtFALb5V6OyAbH/fwzSGGNNAvytdQM+Qc69JwFthrddD9v7G59dZWchq+rWR5/RGdFQslE2BwBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=an81nY6+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768411279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D/s0GXuNL9g9mdojAkGCXJ2uGGA6zHDkPRCRiaiyppY=;
	b=an81nY6+5UFZ18QLMayoj/STD540D/1FycY6sAiFpG8tt8stNlWSMG9/9DKwB5Rs3QC8aW
	o/UneW2b+HiKnpTRdQzJqouJY5Khd6nTbODKpS319rxmXSA0srWZmLAn28H7hHUzzmk7is
	ykfIE+jAZ9UoHjNXhJ19lgd+I9vI+s0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-UC85N3qjMZaZ5n7GFuc15Q-1; Wed,
 14 Jan 2026 12:21:14 -0500
X-MC-Unique: UC85N3qjMZaZ5n7GFuc15Q-1
X-Mimecast-MFC-AGG-ID: UC85N3qjMZaZ5n7GFuc15Q_1768411272
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BD9118005B2;
	Wed, 14 Jan 2026 17:21:12 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.130])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4699619560A7;
	Wed, 14 Jan 2026 17:21:08 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	sdf@fomichev.me,
	petrm@nvidia.com,
	razor@blackwall.org,
	idosch@nvidia.com
Subject: [PATCH v3 net-next 01/10] net: introduce mangleid_features
Date: Wed, 14 Jan 2026 18:20:34 +0100
Message-ID: <70afe1dc4404ef46154b684b12c59d4bc523477c.1768410519.git.pabeni@redhat.com>
In-Reply-To: <cover.1768410519.git.pabeni@redhat.com>
References: <cover.1768410519.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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


