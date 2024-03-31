Return-Path: <netdev+bounces-83690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAF78935FB
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 23:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC9D1F21958
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 21:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3451482FC;
	Sun, 31 Mar 2024 21:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b="DKmaZuum"
X-Original-To: netdev@vger.kernel.org
Received: from perseus.uberspace.de (perseus.uberspace.de [95.143.172.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEC31482F0
	for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 21:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.172.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711920100; cv=none; b=kZYpxojylzpuHWLUUN8cxH5uRuZePMFjuwyqzY6rYA4gU/CChxf8qsO6OulvT5H3nSnT7gH1A/V+a8iDEr0gjU6o0OIO9RtCW5E7DUqCS7Afw14v6044FHOOlM1f1HLRABGB/xyj7tpRV/ukmuVQy+8ER7LkEf30IXjMAUgtD78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711920100; c=relaxed/simple;
	bh=8ftzkWW4g3vVjxT6EKOmoTjoOABa8xTCnvINZX8xh0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G8z05/5R3BCBPsYmuu0akJl5lmOWA8kYe+KCd2+1YH6umJdYMBjtrZuEnPtqom1M23yo9PGIntjoTasbqLV6oU2qjyceJtNQsd3DI7JfVX58RYbMiGdu8FD5HhZxkaNvXnxogkvz5L9UBiCP1bg3NxWW0vwI6RVIFdl20uQT2Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=david-bauer.net; spf=pass smtp.mailfrom=david-bauer.net; dkim=pass (4096-bit key) header.d=david-bauer.net header.i=@david-bauer.net header.b=DKmaZuum; arc=none smtp.client-ip=95.143.172.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=david-bauer.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=david-bauer.net
Received: (qmail 22006 invoked by uid 988); 31 Mar 2024 21:14:53 -0000
Authentication-Results: perseus.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
	by perseus.uberspace.de (Haraka/3.0.1) with ESMTPSA; Sun, 31 Mar 2024 23:14:52 +0200
From: David Bauer <mail@david-bauer.net>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	amcohen@nvidia.com
Cc: netdev@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next] vxlan: drop packets from invalid src-address
Date: Sun, 31 Mar 2024 23:14:34 +0200
Message-ID: <20240331211434.61100-1-mail@david-bauer.net>
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
	bh=8ftzkWW4g3vVjxT6EKOmoTjoOABa8xTCnvINZX8xh0M=;
	b=DKmaZuums6MuX2hFfellz6s6pKMU3nzyYeQDrZMs+bSFfg0SNYXQyv/NNSypV6fGXsAMXb1qVw
	R4QeZyj20sSJjENO0z2IIlayjh8AhgbI5EgTFXUbX5Ev3oG36DaHc2QZo2faoOwn1lgFLq+qxLVu
	r+EdEzkhohV2zTlsDJho4B1Hbma8CgerujJis4G5FJrhnx2c5cjMu9oR0jrCwhd27uMNXbaBMISM
	SqQuKrpbtCpkL8uy6lgLGfDP4PtFnTDtSiaw1Z3jA9ueyKeC2eBM8piSwwF4HohHZajxkg4v9KPB
	BQY1h7zEZXXDsD8+xuyXSCa/bFrMyt+li3u0aylnpkjNbJzJDrlb7Uz1x7yhpS7TV81U1jVgKQJw
	1rgA1f3p+wuqzFUjyclojvavmiXmPDeDu98Anz+HB4v5Ri8ifyVuPa/v/2CAxyEbVskOekHRVfLL
	9jNLuJlYyA971ZQCRH4+4SaRppfJeboZrO/GTsYWHkagxFFbPTIKUEbMEGBaF9qjr9OQbq4N/z4R
	ZvqJfm+WZ5uhPnkLpl/bysjN7Utsq6Xb93zs0XXVX62TPsmDR+PfL3k5IRU+dXdULGWkqWbLdx5N
	DrSy4ta9bYaIrxnpzD8oMkN14gSpKE6uhCQvpApfSQ08udymNqLswWU2IeWIJ1eDYgpGRjOf3VeH
	4=

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


