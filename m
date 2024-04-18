Return-Path: <netdev+bounces-89224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C56658A9B66
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D6D282460
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 13:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1848216078D;
	Thu, 18 Apr 2024 13:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b="Zh/uw4Ji"
X-Original-To: netdev@vger.kernel.org
Received: from perseus.uberspace.de (perseus.uberspace.de [95.143.172.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662C31635B6
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 13:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713447368; cv=none; b=brzLLbPRXmbuRHqudcvrn8CPCx7tdcl+uv9s8oOFT17yxtSVJ6Hj88pMghENSk3RsRLfoiWGd1XXmslwVj0jhdpEGABfvBlHVBGmosyVX6sn2op/yqyh6sggVaAut3GI6OZplXl8WLpHa+IqgUgieEKici7xyqd2Ufj3OU+COew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713447368; c=relaxed/simple;
	bh=VUHSmMnwVCw3JA0JBbpeblezsi5qwZhOXSDD04pEc3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y13626HrNRp/3+rsHDDk0wr0vh0KD8IrxaExChkwf+1JVLKvmpLVeBGPY8uOuzaSgZ3MOT2CcitoFmFYWdksk96ErV9l80Xnc/rPSWLXNHUo7pZQW/MrnOnRj+Rcfq3HG/Ld0P5egRdlq01dNSWupTymA3CxKXv3p3koWUoOFac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net; spf=pass smtp.mailfrom=david-bauer.net; dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b=Zh/uw4Ji; arc=none smtp.client-ip=95.143.172.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=david-bauer.net
Received: (qmail 14947 invoked by uid 988); 18 Apr 2024 13:29:17 -0000
Authentication-Results: perseus.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by perseus.uberspace.de (Haraka/3.0.1) with ESMTPSA; Thu, 18 Apr 2024 15:29:17 +0200
From: David Bauer <mail@david-bauer.net>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	amcohen@nvidia.com
Cc: netdev@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net v2] vxlan: drop packets from invalid src-address
Date: Thu, 18 Apr 2024 15:29:08 +0200
Message-ID: <20240418132908.38032-1-mail@david-bauer.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -
X-Rspamd-Report: MID_CONTAINS_FROM(1) BAYES_HAM(-2.999999) MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -1.599999
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=david-bauer.net; s=uberspace;
	h=from:to:cc:subject:date;
	bh=VUHSmMnwVCw3JA0JBbpeblezsi5qwZhOXSDD04pEc3o=;
	b=Zh/uw4JijyRx2uILJI5YOGD41A1uT+RFt5K/G6GVl3cZ0yNfpu1Gg3bLeTNljAB/lu97zcfLRH
	evtDRAbKVTV15Lcn9rZuwhVi1YrPk3a77txfAwPKoQrkgJn2JCJ1rmnwYdZv1uMb81S8LW1yTC5V
	uf93pbkzdpZ5JxSIpEdKGKXOxHteAXb+jrMh98UgHk2s7xwnQWHeKA6Vq9FJFoCML3kY0Q/Y5mSJ
	X20SOD80X2Oi0TfQG5V1lbokvn6wLjplQKEI3EsVvwgFYYmCRnNp/mwgpT2XAXg1yV3R13N96klA
	n3HT41S7Ge+yBXQUtxgDZwrT1JszbDwszTy9OVC4a5xIlrtFztHgwf1yhlz+g5TYW1DI4hOwlscZ
	2+MkgGUGkq0S9kyi7VZW1F3altacwfEBhCOO9CZjt6u+hZKbtKaOt9GVzVTtMQAk8dw7EzeaO1fd
	PwkIr7QgsEKy/wkNizHICdQa1pA51KmGYxgaCgrHTeZzi6Z93OEGJeOOC8JXeKlfy9Zk6R5NIxLF
	ADKUCj6d+eRUPDlRy+bB+OSfnMfOG0QjxzS4fTvDiN98ra+5W2F1I5uOY7HMTAU8HrdZ+Jq6qvb9
	vttDBkUR26xD0pH6GiStNekFntIQ1ig+kQoN/08Y1VWLy/b77DNR+MC2yf2i2dljJ071C/mndEpJ
	8=

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


