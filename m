Return-Path: <netdev+bounces-151760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AF99F0C7D
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60EF6188DDA5
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278A71DFE32;
	Fri, 13 Dec 2024 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="owdGY8W0"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3DA1DFD9E
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734093435; cv=none; b=jSoj4e+x6p7AeiC8Jaj4QCX4DbIcCj9vxxGbCv6JHxft1PlOTUibjZzvuu31Z6R5rXqsR01dR7V6wr4rMCk37lPZcZZHpv24s3OOv3BjdtyboTgMCluoi54XU3oAkHYAsag0BexaSgtM0wVjjz2RD0RoLSLFcVmXNTMZ4suv1bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734093435; c=relaxed/simple;
	bh=I1DK0OOIK/Zo2j10qkQqyQD8gHL4nA4ghe2sKtY3dEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BkbdMIF02yqLGpm3LccJJePaiKPKTZfmGJzkqrLRmwOoraPGgActn7VM689gy6P7+BehQz5JqVMU7N8ba04BuCosNKgPotzEvqdWmc6caVGsSvd5zLq+sJhAbCD6TNZnheDRIhRhvQYboSUuDEbhuQUYVCYxSK1GwtsOkmLie1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=owdGY8W0; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=mbtB2rV3v8Ts6kJKTQW54E3N40+WwRWDY1cdjKYAuC0=; b=owdGY8W00/xlFIcvOUYd06nsNq
	1tBdNySALlgRJBDMImUv+SYweFfHGhSYV45Fk2p9ZRkcD20TVtCKdYXo1C2FCi025iibz4+CVKsng
	YJQx1T3dthypi6cs75oQs3dKGLDcr/2Z/jR/2H77z3XLTNI9ZXF7QQDrnyE0JfGZnX3e3svaYk/PW
	gvEnBSDADcl8ajKF5v/DNMCpA5k/uIYK6y1gliCJBMoadbgaKFaoutFS99BBKd9CnTVK+Jkhjz5kr
	mqgXPDoeMYooj+QBOgPg0+RqB7osm7XrlFPNnpXEd3w3XCgYDD2NFspNdN1cuOnCiwdcrVbNZ16X1
	rsc1HbbA==;
Received: from 226.206.1.85.dynamic.cust.swisscom.net ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1tM4ug-000P1A-BW; Fri, 13 Dec 2024 13:36:58 +0100
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: liuhangbin@gmail.com,
	razor@blackwall.org,
	mkubecek@suse.cz,
	jiri@nvidia.com,
	pabeni@redhat.com
Subject: [PATCH net] team: Fix feature exposure when no ports are present
Date: Fri, 13 Dec 2024 13:36:57 +0100
Message-ID: <20241213123657.401868-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27485/Thu Dec 12 10:47:34 2024)

Small follow-up to align this to an equivalent behavior as the bond driver.
The change in 3625920b62c3 ("teaming: fix vlan_features computing") removed
the netdevice vlan_features when there is no team port attached, yet it
leaves the full set of enc_features intact.

Instead, leave the default features as pre 3625920b62c3, and recompute once
we do have ports attached. Also, similarly as in bonding case, call the
netdev_base_features() helper on the enc_features.

Fixes: 3625920b62c3 ("teaming: fix vlan_features computing")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 drivers/net/team/team_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index 69ea2c3c76bf..c7690adec8db 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -998,9 +998,13 @@ static void __team_compute_features(struct team *team)
 	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE |
 					IFF_XMIT_DST_RELEASE_PERM;
 
+	rcu_read_lock();
+	if (list_empty(&team->port_list))
+		goto done;
+
 	vlan_features = netdev_base_features(vlan_features);
+	enc_features = netdev_base_features(enc_features);
 
-	rcu_read_lock();
 	list_for_each_entry_rcu(port, &team->port_list, list) {
 		vlan_features = netdev_increment_features(vlan_features,
 					port->dev->vlan_features,
@@ -1010,11 +1014,11 @@ static void __team_compute_features(struct team *team)
 						  port->dev->hw_enc_features,
 						  TEAM_ENC_FEATURES);
 
-
 		dst_release_flag &= port->dev->priv_flags;
 		if (port->dev->hard_header_len > max_hard_header_len)
 			max_hard_header_len = port->dev->hard_header_len;
 	}
+done:
 	rcu_read_unlock();
 
 	team->dev->vlan_features = vlan_features;
-- 
2.43.0


