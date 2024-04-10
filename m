Return-Path: <netdev+bounces-86359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D789B89E79E
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 03:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED451282B22
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 01:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E420623;
	Wed, 10 Apr 2024 01:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b="oU/EncLI"
X-Original-To: netdev@vger.kernel.org
Received: from perseus.uberspace.de (perseus.uberspace.de [95.143.172.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2225256
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 01:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712711376; cv=none; b=V4UeyiqGSyQi8WIqUnlVRMg3PosJYO726hPS2RHMPqMMm6l/O3NZrF4hkzqB/CFTXxel2Akvg4vVP78gVLyz71ZDCVjf2L/t86w9IcYlOezu0vqPQeZcEQXPQCDyM4xTOVhfMCImIs+vCmTUEEa0dCc49Hsypb8CoEmXdsr+AoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712711376; c=relaxed/simple;
	bh=JMDtbVQvNoVZnEUI8oFlwfBSFIoh1iyLMNNNLojxVgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mm6nQP93KvI0oogGqZ6C6E55Q1wAqqkIvyjG2YZlpFUStO87y71BJqbSgWYgLDmWRzBSwOoGSWbID/gScC4gBIS1mpiFN7FYYmStIy7CQLB1Pkp/4qQUr4K3URjdDrvpS7OGobcmKiEgPG4exuVOTQyNF48/capZON1Mlfo2xug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=david-bauer.net; spf=pass smtp.mailfrom=david-bauer.net; dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b=oU/EncLI; arc=none smtp.client-ip=95.143.172.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=david-bauer.net
Received: (qmail 26566 invoked by uid 988); 10 Apr 2024 01:09:24 -0000
Authentication-Results: perseus.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by perseus.uberspace.de (Haraka/3.0.1) with ESMTPSA; Wed, 10 Apr 2024 03:09:23 +0200
From: David Bauer <mail@david-bauer.net>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	amcohen@nvidia.com
Cc: netdev@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net] vxlan: drop packets from invalid src-address
Date: Wed, 10 Apr 2024 03:09:17 +0200
Message-ID: <20240410010917.90115-1-mail@david-bauer.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -
X-Rspamd-Report: MID_CONTAINS_FROM(1) BAYES_HAM(-3) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -1.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=david-bauer.net; s=uberspace;
	h=from:to:cc:subject:date;
	bh=JMDtbVQvNoVZnEUI8oFlwfBSFIoh1iyLMNNNLojxVgU=;
	b=oU/EncLIUiJbYF4Q1BSounOWryUQbO1elSzPMkKCdLP6jHkxsn9FLmdKn/mtvfuvVGsyAOzmJQ
	2g183ZRzZwcObSPgHP6uE8ayOs+cjoLrUBagNhUqCAebfQ4T03co1qzT2Bzq8jZxyzLa+j/7+fRV
	bL/yWSM2mleV3jWDNbkVbrALSO7/4fvEauilpxX4iU12gdzbUqZ7aqPc9NkUvYt2Re9/xJZTmv+g
	je26GTze93/WjpcQMF0LugZcRsu0vqc3/wRUTpd9qV5j/18V+Gidk8HdH/FjypcWn9sYx5e0XcLj
	FhaTAzuRTmISBbO7ajynlvaGSXBN14VSqu1D5RO6FYIwgRTEgNf+8U9dgw5uzuNtTaxf1WxToL2z
	1HDvSI6byhep1tqVUuoKTVrDoy9ZtCBH9dbQogmrepcTNKO/x61RiFVIQCpdUWLvO9iaYE2IZLr3
	IQGBhosfcr+JFqvlDU2THGF0A0ln6NuLngzN+9uPK6KGoTP6rqtP6ABIPmNR+mPnjAFPqaV80sw5
	4MzTzbLhmYLo+RPBvknUHyz4Ti/tp55WQ1MpRTgXbzLgw3HHYw+QyQU/RqIK4XZerzKxldqdkZIY
	OLQ6uwcGorF7ELV3ttCIl8W6NXpO/6gWsVDuIAaAG9ikV27j4l9FlvXl3/SO5T/FX8m0ljTkR8Iv
	Y=

The VXLAN driver currently does not check if the inner layer2
source-address is valid.

In case source-address snooping/learning is enabled, a entry in the FDB
for the invalid address is created with the layer3 address of the tunnel
endpoint.

If the frame happens to have a non-unicast address set, all this
non-unicast traffic is subsequently not flooded to the tunnel network
but sent to the learnt host in the FDB. To make matters worse, this FDB
entry does not expire.

Apply the same filtering for packets as it is done for bridges. This not
only drops these invalid packets but avoids them from being learnt into
the FDB.

Fixes: d342894c5d2f ("vxlan: virtual extensible lan")

Suggested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: David Bauer <mail@david-bauer.net>
---
 drivers/net/vxlan/vxlan_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 3495591a5c29..ba319fc21957 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1615,6 +1615,10 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
 	if (ether_addr_equal(eth_hdr(skb)->h_source, vxlan->dev->dev_addr))
 		return false;
 
+	/* Ignore packets from invalid src-address */
+	if (!is_valid_ether_addr(eth_hdr(skb)->h_source))
+		return false;
+
 	/* Get address from the outer IP header */
 	if (vxlan_get_sk_family(vs) == AF_INET) {
 		saddr.sin.sin_addr.s_addr = ip_hdr(skb)->saddr;
-- 
2.43.0


