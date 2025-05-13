Return-Path: <netdev+bounces-190114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2752AB5354
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 12:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398BE3B0BF8
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 10:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3367923C8B3;
	Tue, 13 May 2025 10:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGMN5AVd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC2E1DACA1
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 10:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747133978; cv=none; b=H2fF7S8fi+j+5fM69iZsDrw5f5u3dxS1EGswqD+YDqhKVwi38K0TT6Ib7gLBlEYoq6DIf6sbALsJHbuc141BEwpaCy9cqcs7Xd6i6FCDXo4TcWYrHNHp0bL4fsl/OfeVgaLrhwTsxYqHx5gFPOcJQvEX3z9pjgTWNsGWsZJGA9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747133978; c=relaxed/simple;
	bh=pg7gMRFow6dTCINZjyNY/eo4/X48/ZiLtNLXkwRG81c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S3qkroJleoIMmUEsmcojCnodxueCZuNMH0c5SaEVWSwGiS3Z2conesJ7KqW7YHcCsSbaEYetjX7eqS0IxgpcdbdSRkVNeHzxJXcgt62XgdpOjE7GAfE0T6e8vfGEZXgwuQpXugx4o1vsbFmabhISsqPXgQMxnrfU51BRSUMeJMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGMN5AVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4F4C4CEE4;
	Tue, 13 May 2025 10:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747133977;
	bh=pg7gMRFow6dTCINZjyNY/eo4/X48/ZiLtNLXkwRG81c=;
	h=From:To:Cc:Subject:Date:From;
	b=gGMN5AVd0IlxAQ2RMqPsv3iXndWPS8mQjLh5AX80hq9ztkdWUYIZw5IvdpxlUmJNe
	 qWxZ45ui2gEpYwWPiQgx6tXPjiX/4ZNvthQ79OlSKpt6s75h0DZ44AijGQ5q7b3p9J
	 qYIbRf5kFmNkg0bLvIxT14EUPDZYEJ2iRr7fNsGiVBrp0an4drZb/f1aP6l0APdN2O
	 uuGneRpML90eQsBof1Rq53VxiIKvdiTjpQ7nQKOWIDsFqsxRmRP4uCDu3LVSfJ6Fe9
	 +luq6hWeks28enUo9GuskylRQKGL7io2Hr7tbQvvZ9X+0T7ENEEKRo0d+dXCWHg1bl
	 FavE9goOKP/sQ==
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH ipsec-next] xfrm: prevent configuration of interface index when offload is used
Date: Tue, 13 May 2025 13:59:19 +0300
Message-ID: <ba693167024546895f704663d699132cbeb68c27.1747133865.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Both packet and crypto offloads perform decryption while packet is
arriving to the HW from the wire. It means that there is no possible
way to perform lookup on XFRM if_id as it can't be set to be "before' HW.

So instead of silently ignore this configuration, let's warn users about
misconfiguration.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 net/xfrm/xfrm_device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index d62f76161d83..01dc31111570 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -256,6 +256,11 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 		return -EINVAL;
 	}
 
+	if (xuo->flags & XFRM_OFFLOAD_INBOUND && x->if_id) {
+		NL_SET_ERR_MSG(extack, "XFRM if_id is not supported in RX path");
+		return -EINVAL;
+	}
+
 	is_packet_offload = xuo->flags & XFRM_OFFLOAD_PACKET;
 
 	/* We don't yet support TFC padding. */
-- 
2.49.0


