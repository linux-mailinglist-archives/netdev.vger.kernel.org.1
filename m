Return-Path: <netdev+bounces-52612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4127FF78F
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 17:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A911B211BD
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 16:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC9055C02;
	Thu, 30 Nov 2023 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CbeCjIfl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C421B3
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 08:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701363508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=47yY7iPs1dv0KQfmDWaKIoVimfKTuHUX6+HGkNeEXfE=;
	b=CbeCjIflaQ/Om7uHrmpR6snKHTAtn8cOPld4MtRvBxLVme1xZRnyMloai7xFBJzHbmxV7L
	CM4meMzahhqdfoJwnsvfP4BLKJjhni7TOjbhVu4NW63knk2VjLmzmBKx+QhI6XHsdjBALJ
	v29zONixrKHyZ4q5PD0/IeX+iEtXG5k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-eOaNy0UqPRuj58coU7AoJA-1; Thu,
 30 Nov 2023 11:58:24 -0500
X-MC-Unique: eOaNy0UqPRuj58coU7AoJA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A99938149BD;
	Thu, 30 Nov 2023 16:58:24 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.45.226.172])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7C87E1121307;
	Thu, 30 Nov 2023 16:58:22 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net] ice: fix theoretical out-of-bounds access in ethtool link modes
Date: Thu, 30 Nov 2023 17:58:06 +0100
Message-ID: <20231130165806.135668-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

To map phy types reported by the hardware to ethtool link mode bits,
ice uses two lookup tables (phy_type_low_lkup, phy_type_high_lkup).
The "low" table has 64 elements to cover every possible bit the hardware
may report, but the "high" table has only 13. If the hardware reports a
higher bit in phy_types_high, the driver would access memory beyond the
lookup table's end.

Instead of iterating through all 64 bits of phy_types_{low,high}, use
the sizes of the respective lookup tables.

Fixes: 9136e1f1e5c3 ("ice: refactor PHY type to ethtool link mode")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index a34083567e6f..bde9bc74f928 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -1850,14 +1850,14 @@ ice_phy_type_to_ethtool(struct net_device *netdev,
 	linkmode_zero(ks->link_modes.supported);
 	linkmode_zero(ks->link_modes.advertising);
 
-	for (i = 0; i < BITS_PER_TYPE(u64); i++) {
+	for (i = 0; i < ARRAY_SIZE(phy_type_low_lkup); i++) {
 		if (phy_types_low & BIT_ULL(i))
 			ice_linkmode_set_bit(&phy_type_low_lkup[i], ks,
 					     req_speeds, advert_phy_type_lo,
 					     i);
 	}
 
-	for (i = 0; i < BITS_PER_TYPE(u64); i++) {
+	for (i = 0; i < ARRAY_SIZE(phy_type_high_lkup); i++) {
 		if (phy_types_high & BIT_ULL(i))
 			ice_linkmode_set_bit(&phy_type_high_lkup[i], ks,
 					     req_speeds, advert_phy_type_hi,
-- 
2.41.0


