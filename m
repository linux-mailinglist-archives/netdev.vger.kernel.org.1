Return-Path: <netdev+bounces-251979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDfnIOoIcWmPcQAAu9opvQ
	(envelope-from <netdev+bounces-251979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:12:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE93C5A58C
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 18:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C591D86F54D
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1BA2F5328;
	Wed, 21 Jan 2026 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3Fp3z/+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99F53D1CBC
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769011950; cv=none; b=N+6stbfCMoMEms9zTZ6w6gXqbemom2aW4Drs/vZuJTPvoZOxvMvnk4byFxe/gVWvUmUN+djnSG1KyEoYJXLQOjhshx6oSvKLr6IEOfFAYS68a2Ov74eB7dVz4NyJxleBa/sLIkynMopTH0Yv4N/Y6TSqk1xNNbS9bRptHTmK9oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769011950; c=relaxed/simple;
	bh=8L0Nhgdic4vSfNMASbbdCmsnup8zZ0pIwhxNP5MUMqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BeSG3/PpLgaGnJsNlVU6QGHnBvrutszxkoycnILU7vvD0Qae+wph2Ha5D/MqPEd78IkEVeN9sSXQhveg9wIBuFfmpEr/SxufrzF4HPPrTpE4e2xu8GDeDIuLF/Rnvl5QAsaRoXTaaoVWqmXAcfSu7QWNMB/cjaMDnYUKlQGrFdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c3Fp3z/+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769011947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n/h+9bHgknFruRjBndNiJ1hA5LvUpS3H4KW9mFAgIWw=;
	b=c3Fp3z/+gjLE6eIUmJI/SbXwJOLJfjBbLScnZ4/T2/8anH08T9oUSeIHlgtU6fQHMVoIof
	ilzTUd6fpTRndaZRpBRuY6abLemrLr5dC8BVUwI8VWsBjtY8uFBySza+Hr6U2teyApm9Au
	Uw0Lh5s1+3LjAh7EJSXmfXF+vKzKvDc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-UkwcIWHJN1iCQdoZbCOLWA-1; Wed,
 21 Jan 2026 11:12:26 -0500
X-MC-Unique: UkwcIWHJN1iCQdoZbCOLWA-1
X-Mimecast-MFC-AGG-ID: UkwcIWHJN1iCQdoZbCOLWA_1769011944
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5058E18D625A;
	Wed, 21 Jan 2026 16:12:15 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.3])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 258BA1801A45;
	Wed, 21 Jan 2026 16:12:10 +0000 (UTC)
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
Subject: [PATCH v5 net-next 01/10] net: introduce mangleid_features
Date: Wed, 21 Jan 2026 17:11:27 +0100
Message-ID: <5a7cdaeea40b0a29b88e525b6c942d73ed3b8ce7.1769011015.git.pabeni@redhat.com>
In-Reply-To: <cover.1769011015.git.pabeni@redhat.com>
References: <cover.1769011015.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251979-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,gmail.com,lunn.ch,fomichev.me,nvidia.com,blackwall.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	DKIM_TRACE(0.00)[redhat.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: DE93C5A58C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some/most devices implementing gso_partial need to disable the GSO partial
features when the IP ID can't be mangled; to that extend each of them
implements something alike the following[1]:

	if (skb->encapsulation && !(features & NETIF_F_TSO_MANGLEID))
		features &= ~NETIF_F_TSO;

in the ndo_features_check() op, which leads to a bit of duplicate code.

Later patch in the series will implement GSO partial support for virtual
devices, and the current status quo will require more duplicate code and
a new indirect call in the TX path for them.

Introduce the mangleid_features mask, allowing the core to disable NIC
features based on/requiring MANGLEID, without any further intervention
from the driver.

The same functionality could be alternatively implemented adding a single
boolean flag to the struct net_device, but would require an additional
checks in ndo_features_check().

Also note that [1] is incorrect if the NIC additionally implements
NETIF_F_GSO_UDP_L4, mangleid_features transparently handle even such a
case.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v4 -> v5:
 - set mangleid_features unconditionally (Eric)

v3 -> v4:
 - ensure mangleid_features includes TSO_MANGLEID for better code
   in gso_features_check() - Eric
 - some changelog clarifications.
---
 include/linux/netdevice.h | 3 +++
 net/core/dev.c            | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d99b0fbc1942..179b50f98cee 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1831,6 +1831,8 @@ enum netdev_reg_state {
  *
  *	@mpls_features:	Mask of features inheritable by MPLS
  *	@gso_partial_features: value(s) from NETIF_F_GSO\*
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
index 048ab4409a2c..b332188a6a2f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3802,7 +3802,7 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 				    inner_ip_hdr(skb) : ip_hdr(skb);
 
 		if (!(iph->frag_off & htons(IP_DF)))
-			features &= ~NETIF_F_TSO_MANGLEID;
+			features &= ~dev->mangleid_features;
 	}
 
 	/* NETIF_F_IPV6_CSUM does not support IPv6 extension headers,
@@ -11402,6 +11402,9 @@ int register_netdevice(struct net_device *dev)
 	if (dev->hw_enc_features & NETIF_F_TSO)
 		dev->hw_enc_features |= NETIF_F_TSO_MANGLEID;
 
+	/* TSO_MANGLEID belongs mangleid_features by definition */
+	dev->mangleid_features |= NETIF_F_TSO_MANGLEID;
+
 	/* Make NETIF_F_HIGHDMA inheritable to VLAN devices.
 	 */
 	dev->vlan_features |= NETIF_F_HIGHDMA;
-- 
2.52.0


