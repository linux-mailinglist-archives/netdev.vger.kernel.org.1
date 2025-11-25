Return-Path: <netdev+bounces-241559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25876C85E2D
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 17:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D29583B294E
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 16:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7256622F77B;
	Tue, 25 Nov 2025 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VlrRahej"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF87B226D00
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087099; cv=none; b=VB8sBId/bcNmClHX/tzryOQZXiqFW59+z3KqwIOOcEwMRsAhSbs5PByV8Jud3miO+Oz0054Zb0yHGAu9jiM4T/gCqcZylG3bH2oZlH6L34/B9uFPQ3H4tICQrKFnXXneSlUiMIjQZ4bLon9R6Zob5OlXl04kYpESuWCX6U46hAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087099; c=relaxed/simple;
	bh=3DgT2/YG4w/VQ1AKRc9qysEAmWbRLXr3/xneY/YsZiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eAR8pQyej7EmS/GtwXOQ3TOegS2XkmNfDNR4z6feTR20ZOFwjRDB+BLez3t3ES/9jU1cOksW9J8EElfebRLiVo+obGw7wQbeukfBqGzy56Ue08nCrfHyyK3cpf9J4FfztaKp1IERwJd+iiI7blj5DqCy2WdREwqC3k8zYF/IEi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VlrRahej; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764087097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hPFWHC9cp3vUs4nylOIOc02i/zvHGqapnFsaE1DHwHc=;
	b=VlrRahejlJ5zVgxy8yJm2OuUHGF1Cir6vv6hTF0gK544b24J8Of2KV6grntBSMRiXQ0vVe
	4kfkGT2WWCcPbrgkjXPm2S1411Kb3pR0f7vP4tP2xGMjmnQOST+Fif2f+bvPWjszztFnyR
	r+g2biapC6XlIu+/wnSNupkwlzvI3M0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-TzDGiZHvN4SIMw69ffo2JA-1; Tue,
 25 Nov 2025 11:11:33 -0500
X-MC-Unique: TzDGiZHvN4SIMw69ffo2JA-1
X-Mimecast-MFC-AGG-ID: TzDGiZHvN4SIMw69ffo2JA_1764087091
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A51B2195609F;
	Tue, 25 Nov 2025 16:11:31 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.183])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 801EE1800451;
	Tue, 25 Nov 2025 16:11:28 +0000 (UTC)
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
Subject: [PATCH net-next 01/10] net: introduce mangleid_features
Date: Tue, 25 Nov 2025 17:11:06 +0100
Message-ID: <10db2e40fc6193c43793669f450b40166a48c5d1.1764056123.git.pabeni@redhat.com>
In-Reply-To: <cover.1764056123.git.pabeni@redhat.com>
References: <cover.1764056123.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
index e808071dbb7d..92ff602d8f30 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1817,7 +1817,9 @@ enum netdev_reg_state {
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
@@ -2206,6 +2208,7 @@ struct net_device {
 	netdev_features_t	vlan_features;
 	netdev_features_t	hw_enc_features;
 	netdev_features_t	mpls_features;
+	netdev_features_t	mangleid_features;
 
 	unsigned int		min_mtu;
 	unsigned int		max_mtu;
diff --git a/net/core/dev.c b/net/core/dev.c
index 69515edd17bc..9d3bbc0529d5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3789,8 +3789,10 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
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


