Return-Path: <netdev+bounces-266092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLmrCVsUsGl1fQIAu9opvQ
	(envelope-from <netdev+bounces-266092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 13:53:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC5B24F1DF
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 13:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7534634C5EC2
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 12:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993853F54BF;
	Tue, 10 Mar 2026 11:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZHSYEVV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F113C3427
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 11:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143781; cv=none; b=hdxhVGRcscPkOz7LEWhCidseZIZa1UXsO7CYwMdiOc8Bx627zomB/xhv+9a2RdsiOCfHa368JBElZgbuxXWRoiydI4Xqg0yoQ7awfCyIM7kTqjZi0CG4pcQJk6UpzotN1MyK/FrGT3/rJb1TpfmJdRa9uop8x8L5gU9S6FWWlC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143781; c=relaxed/simple;
	bh=EB8zPrZzX5eiVEuYcpw86IjU4EzIIg4/IQv9+3/U6KE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JiHnBDx4bUjcExO3xLVViSxJ/73KvjFFn0o4DC4JckwgFE7onvCyGjXcqecdI4sZ59KeM88OP5PHu8EZuheZK2pwltKNff+k5WcHhdfO+OG0fklvXLZv5NCdi/0h0SEa1Tl/EWfyfWxejkMGxQ8R58WzHV5ggOlWMOW7L9Enf8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gZHSYEVV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773143777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2Tl0rqhKy3+HoN9UE1g3Gni0kMosYIJ5CSDPC/4uRtk=;
	b=gZHSYEVV2KnktL+7iWKHmlybqYk5GjHYqNSxTAOd4k7N2xNSOS7wQih+vU/0b2T/oslQIn
	sT9d4sRSE0AxmLJSBppdyLoXSEMKZoPyZEJ/oxoio1rT/TW9RWoeJGMykjG5ogKS2RTxFl
	Vx0aVXKrDGx248f+ngPVtSQg4OC+Brc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-gzfeU9fbMz2c57R595sXwg-1; Tue,
 10 Mar 2026 07:56:13 -0400
X-MC-Unique: gzfeU9fbMz2c57R595sXwg-1
X-Mimecast-MFC-AGG-ID: gzfeU9fbMz2c57R595sXwg_1773143771
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D64619560B7;
	Tue, 10 Mar 2026 11:56:10 +0000 (UTC)
Received: from jramaseu-thinkpadt14gen5.tpbc.csb (unknown [10.43.3.226])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B055A1800576;
	Tue, 10 Mar 2026 11:56:08 +0000 (UTC)
From: Jakub Ramaseuski <jramaseu@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	przemyslaw.korba@intel.com,
	Jakub Ramaseuski <jramaseu@redhat.com>
Subject: [Intel-wired-lan] [PATCH iwl-net] ice: enable NETIF_F_HW_CSUM for GSO packets
Date: Tue, 10 Mar 2026 12:55:56 +0100
Message-ID: <20260310115556.1004263-1-jramaseu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 8EC5B24F1DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266092-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jramaseu@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

IPv4 over IPv6 GRE currently fails on E810 with skb_warn_bad_offload,
while IPv6 over IPv6 GRE falls back to software segmentation.
This happens because the kernel's GSO engine requires the generic HW_CSUM
flag to trust the hardware with complex encapsulation offloads.

Add NETIF_F_HW_CSUM to the device's csumo_features to satisfy the network
stack and unlock full hardware segmentation for GRE tunnels.
To prevent checksum corruption on standard traffic, evaluate the packet
in ice_features_check() and dynamically clear the NETIF_F_HW_CSUM bit
if it is not a GSO frame. This forces the driver to fall back to safe,
protocol-specific checksum features for non-GSO packets
while preserving the generic offload for tunnels.

Signed-off-by: Jakub Ramaseuski <jramaseu@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e7308e381e2f..9b4ad03e1a32 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3565,6 +3565,7 @@ void ice_set_netdev_features(struct net_device *netdev)
 
 	csumo_features = NETIF_F_RXCSUM	  |
 			 NETIF_F_IP_CSUM  |
+			 NETIF_F_HW_CSUM  |
 			 NETIF_F_SCTP_CRC |
 			 NETIF_F_IPV6_CSUM;
 
@@ -9789,6 +9790,14 @@ ice_features_check(struct sk_buff *skb,
 	if (skb->ip_summed != CHECKSUM_PARTIAL)
 		return features;
 
+	/* Hardware requires strictly-typed Tx descriptors for non-GSO frames.
+	 * Leaving generic NETIF_F_HW_CSUM enabled corrupts checksums,
+	 * causing TCP drops. We strip it here to force safe,
+	 * protocol-specific IPv4/IPv6 offloads instead.
+	 */
+	if (!gso)
+		features &= ~NETIF_F_HW_CSUM;
+
 	/* We cannot support GSO if the MSS is going to be less than
 	 * 64 bytes. If it is then we need to drop support for GSO.
 	 */
-- 
2.52.0


