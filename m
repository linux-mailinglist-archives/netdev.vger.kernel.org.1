Return-Path: <netdev+bounces-166962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3811A38273
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 12:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4427218953EC
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 11:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93815218EA8;
	Mon, 17 Feb 2025 11:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="pBFGpNEm"
X-Original-To: netdev@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D90217733;
	Mon, 17 Feb 2025 11:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739793301; cv=none; b=Ilgkcq29u9uD1f4Kecknc2P5C3nYevoPaWeYIIyMugRVmySbn+qGBNlrJ74OE9FYNg1BOe9zftR41wXroUNpRnk/E3+ncDLDlZRG9WsUWj0GDs0Yb6vc3hD0KiSoRPhpJ6JsVDpczzrSozkY2zSzZV0rV+tq5whTOTbF6oKxNUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739793301; c=relaxed/simple;
	bh=h+O+ibFzxC5CAgefPBkwm/5PJBNefvtc+BzFWMlwpiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t5z87ck+gj2nSC1y8xI550hWDW7TGQqVr2/VkyZYrNNn1yPs8fbdryjORrlof/EacULgM8dc11NQFNiKv9oMNMEQVSjf5rAE2H0f1cqjf3x+hrnQePHH6KYCTz7I84kQKLy3Fs51z+wSULtQqHVEthPahRWsGmAOd86qKwbH098=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=pBFGpNEm; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=UDUhVrBdPRQjgsQkHQ57OQBrnvRcX2sjoY8WgVvH3ls=; b=pBFGpNEmjEzf8R9AXNOh0/fRv9
	Uamz+e6kKXAN9UJE5xRcwreb4iX8dd4EDhXxZEcjj5pVozANasfCEuxKkfFiN6ukVeKGSmVn+L/3a
	3dyGrY5WA4W2siFk5YBIbhU8Gkskjc/3KoZ7y7jGSJi65qXwFDKQV5naP3Fc7VWpEraU=;
Received: from p5b206ef1.dip0.t-ipconnect.de ([91.32.110.241] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tjzGa-006FEq-0d;
	Mon, 17 Feb 2025 12:26:24 +0100
From: Felix Fietkau <nbd@nbd.name>
To: netdev@vger.kernel.org,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: bridge: locally receive all multicast packets if IFF_ALLMULTI is set
Date: Mon, 17 Feb 2025 12:26:20 +0100
Message-ID: <20250217112621.66916-1-nbd@nbd.name>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If multicast snooping is enabled, multicast packets may not always end up on
the local bridge interface, if the host is not a member of the multicast
group. Similar to how IFF_PROMISC allows all packets to be received locally,
let IFF_ALLMULTI allow all multicast packets to be received.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/bridge/br_input.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 232133a0fd21..7fa2da6985b5 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -155,6 +155,8 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 			pkt_type = BR_PKT_MULTICAST;
 			if (br_multicast_rcv(&brmctx, &pmctx, vlan, skb, vid))
 				goto drop;
+			if (br->dev->flags & IFF_ALLMULTI)
+				local_rcv = true;
 		}
 	}
 
-- 
2.47.1


